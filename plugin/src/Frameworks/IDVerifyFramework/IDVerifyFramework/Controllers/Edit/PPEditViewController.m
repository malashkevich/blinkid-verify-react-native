//
//  PPEditViewController.m
//  IDVerifyFramework
//
//  Created by Jura on 10/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPEditViewController.h"

#import "PPIdVerifySettings.h"
#import "PPLocalization.h"
#import "PPAutoBalancedLabel.h"
#import "PPKeyboardViewController.h"
#import "PPKeyboardViewModel.h"
#import "PPKeyboardConfusions.h"
#import "PPConfigurationStorage.h"

static CGFloat bottomMarginItemToButton = 26.f;

@interface PPEditViewController () <PPEditableFieldResultItemViewDelegate, PPInsertableFieldResultItemViewDelegate, PPKeyboardViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet PPAutoBalancedLabel *checkDataLabel;

@property (weak, nonatomic) IBOutlet UIButton *scanAgainButton;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (nonatomic, strong) PPEditableFieldResultItemView *activeEditableItemView;

@property (nonatomic, strong) PPInsertableFieldResultItemView *activeInsertableItemView;

@property (nonatomic) NSArray<PPIdResultItemView *> *resultSubviews;

@end

@implementation PPEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scanAgainButton.layer.cornerRadius = 6.0f;
    self.confirmButton.layer.cornerRadius = 6.0f;

    self.checkDataLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightRegular pointSizeDiff:-2.f];

    self.scanAgainButton.titleLabel.font =
        [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:1.f];
    self.confirmButton.titleLabel.font =
        [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:1.f];

    self.checkDataLabel.text = PP_LOCALIZED_RESULT(@"edit.subtitle", @"Marked letters are available for editing with the keyboard. A selected letter to be changed is marked in red. Use arrows to select other letters.");

    [self.confirmButton setTitle:PP_LOCALIZED_RESULT(@"edit.button.confirm", @"Confirm changes") forState:UIControlStateNormal];
    self.confirmButton.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationPrimaryColor;

    [self.scanAgainButton setTitle:PP_LOCALIZED_RESULT(@"edit.button.repeatScanning", @"Scan again") forState:UIControlStateNormal];
    self.scanAgainButton.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self clearAllItems];
    [self populateItems];

    [self.scrollView setContentOffset:CGPointMake(0, -self.scrollView.contentInset.top) animated:NO];

    [self.delegate editViewControllerStarted:self];

    [self registerForKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self deregisterKeyboardNotifications];
}

#pragma mark - configure views

- (void)clearAllItems {
    for (int i = 0; i < [self.resultSubviews count]; i++) {
        UIView *view = [self.resultSubviews objectAtIndex:i];
        [view removeFromSuperview];
        for (NSLayoutConstraint *c in view.constraints) {
            c.active = NO;
        }
    }
    self.resultSubviews = nil;
}

- (void)setFieldViewDelegate:(PPIdResultItemView *)fieldView {
    if ([fieldView isKindOfClass:[PPEditableFieldResultItemView class]]) {
        PPEditableFieldResultItemView *editableView = (PPEditableFieldResultItemView *)fieldView;
        editableView.delegate = self;
    }
    if ([fieldView isKindOfClass:[PPInsertableFieldResultItemView class]]) {
        PPInsertableFieldResultItemView *insertableView = (PPInsertableFieldResultItemView *)fieldView;
        insertableView.delegate = self;
    }
}

- (void)populateItems {

    self.resultSubviews = [self.viewModel.viewPopulator populateViewsForViewResult:self.viewModel.verifyResult.viewResult editingEnabled:YES];

    for (int i = 0; i < [self.resultSubviews count]; i++) {
        PPIdResultItemView *view = [self.resultSubviews objectAtIndex:i];
        [self setFieldViewDelegate:view];
        if (i > 0) {
            UIView *previousView = [self.resultSubviews objectAtIndex:i - 1];
            [self.contentView insertSubview:view belowSubview:previousView];
        } else {
            [self.contentView addSubview:view];
        }
        [self configureView:view atIndex:i];
    }

    [self configureTopView:[self.resultSubviews firstObject]];

    for (int i = 1; i < [self.resultSubviews count] - 1; i++) {
        UIView *view = [self.resultSubviews objectAtIndex:i];
        UIView *topView = [self.resultSubviews objectAtIndex:i - 1];
        UIView *bottomView = [self.resultSubviews objectAtIndex:i + 1];
        [self configureView:view betweenView:topView andView:bottomView];
    }

    if ([self.resultSubviews count] % 2) {
        self.scrollView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.evenTableCellColor;
        self.contentView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.evenTableCellColor;
    } else {
        self.scrollView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.oddTableCellColor;
        self.contentView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.oddTableCellColor;
    }

    [self configureBottomView:[self.resultSubviews lastObject]];
}

- (void)configureView:(UIView *)view atIndex:(NSUInteger)index {

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.contentView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0f
                                                                       constant:0.0];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.contentView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0f
                                                                          constant:0.0f];

    if ([view isKindOfClass:[PPTitleResultItemView class]]) {
        view.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;
    } else if (index % 2) {
        view.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.evenTableCellColor;
    } else {
        view.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.oddTableCellColor;
    }

    [self.contentView addConstraints:@[ leftConstraint, centerXConstraint ]];
}

- (void)configureTopView:(UIView *)view {

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.checkDataLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0f
                                                                      constant:0];

    [self.contentView addConstraint:topConstraint];
}

- (void)configureBottomView:(UIView *)view {

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.scanAgainButton
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0f
                                                                         constant:-bottomMarginItemToButton];

    [self.contentView addConstraint:bottomConstraint];
}

- (void)configureView:(UIView *)view
          betweenView:(UIView *)topView
              andView:(UIView *)bottomView {

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:topView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0f
                                                                      constant:0.0];

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:bottomView
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0f
                                                                         constant:0.0f];

    [self.contentView addConstraints:@[ topConstraint, bottomConstraint ]];
}

#pragma mark - Keyboard

- (void)openKeyboardViewControllerForValue:(NSString *)value {
    PPKeyboardViewController *keyboardViewController = [PPKeyboardViewController viewControllerFromStoryboardInBundle:[PPIdVerifySettings sharedSettings].resourcesBundle];
    keyboardViewController.delegate = self;

    PPKeyboardViewModel *keyboardModel = [[PPKeyboardViewModel alloc]
        initWithValue:value
           confusions:[[PPConfigurationStorage sharedStorage] configurationForType:self.viewModel.verifyResult.viewResult.configurationType]
                          .transliterationMappings];
    keyboardViewController.viewModel = keyboardModel;

    [self showViewController:keyboardViewController animated:YES completion:nil];
}

#pragma mark - Show Dismiss Keyboard

- (void)showViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^__nullable)())completion {

    [self addChildViewController:viewController];
    viewController.view.frame = self.view.bounds;
    viewController.view.alpha = 0.0f;
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];

    void (^block)(void) = ^void(void) {
        viewController.view.alpha = 1.0f;
    };

    if (animated) {
        [UIView animateWithDuration:0.4f
                         animations:^{
                             block();
                         }
                         completion:^(BOOL finished) {
                             if (completion) {
                                 completion();
                             }
                         }];
    } else {
        block();
        if (completion) {
            completion();
        }
    }
}

- (void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^__nullable)())completion {

    void (^block)(void) = ^void(void) {
        viewController.view.alpha = 0.0f;
    };

    void (^remove)(void) = ^void(void) {
        [viewController willMoveToParentViewController:nil];
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    };

    if (animated) {
        [UIView animateWithDuration:0.4f
                         animations:^{
                             block();
                         }
                         completion:^(BOOL finished) {
                             remove();
                             if (completion) {
                                 completion();
                             }
                         }];
    } else {
        block();
        remove();
        if (completion) {
            completion();
        }
    }
}

#pragma mark - PPEditableFieldResultItemViewDelegate

- (void)editableFieldResultItemViewEditTapped:(PPEditableFieldResultItemView *)view {
    self.activeEditableItemView = view;
    [self openKeyboardViewControllerForValue:view.valueView.text];
}

#pragma mark - PPKeyboardViewControllerDelegate

- (void)keyboardViewController:(PPKeyboardViewController *)controller didFinishEditingWithResult:(NSString *)result {

    [self.delegate editViewController:self
                          editedField:self.activeEditableItemView.originalKey
                             oldValue:self.activeEditableItemView.valueView.text
                             newValue:result];

    [self.viewModel.verifyResult editedKey:self.activeEditableItemView.originalKey newValue:result];
    self.activeEditableItemView.valueView.text = result;
    [self.activeEditableItemView setEdited:YES];
    self.activeEditableItemView = nil;
    [self dismissViewController:controller animated:YES completion:nil];
}

#pragma mark - UI handlers

- (IBAction)scanAgainTapped:(id)sender {
    [self clearValidations];
    [self.delegate editViewControllerRequiresRepeatedScan:self];
}

- (IBAction)confirmTapped:(id)sender {
    if ([self areAllFieldsValid]) {
        [self.delegate editViewControllerFinished:self];
    } else {
        [self showErrorLabelIfNecessary];
    }
}

#pragma mark - Validations

- (BOOL)areAllFieldsValid {
    for (PPIdResultItemView *view in self.resultSubviews) {
        if ([view isKindOfClass:[PPInsertableFieldResultItemView class]]) {
            PPInsertableFieldResultItemView *insertableView = (PPInsertableFieldResultItemView *)view;
            if (insertableView.validationBlock) {
                if (!insertableView.validationBlock(insertableView.valueView.text)) {
                    return NO;
                }
            }
        }
    }
    return YES;
}

- (BOOL)clearValidations {
    for (PPIdResultItemView *view in self.resultSubviews) {
        if ([view isKindOfClass:[PPInsertableFieldResultItemView class]]) {
            PPInsertableFieldResultItemView *insertableView = (PPInsertableFieldResultItemView *)view;
            insertableView.validationBlock = nil;
        }
    }
    return YES;
}

- (BOOL)showErrorLabelIfNecessary {
    for (PPIdResultItemView *view in self.resultSubviews) {
        if ([view isKindOfClass:[PPInsertableFieldResultItemView class]]) {
            PPInsertableFieldResultItemView *insertableView = (PPInsertableFieldResultItemView *)view;
            [insertableView showErrorLabelIfNecessary];
        }
    }
    return YES;
}

#pragma mark - PPInsertableFieldResultItemViewDelegate

- (void)insertableFieldDidBeginEditing:(PPInsertableFieldResultItemView *)view {
    self.activeInsertableItemView = view;
}

- (void)insertableFieldDidEndEditing:(PPInsertableFieldResultItemView *)view {
    [self.viewModel.verifyResult insertedKey:view.originalKey value:view.valueView.text];
    self.activeInsertableItemView = nil;
}

#pragma mark - Keyboard for insertion

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)deregisterKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillBeShown:(NSNotification *)aNotification {
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;

    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeInsertableItemView.frame.origin)) {
        CGRect frame = self.activeInsertableItemView.frame;
        frame.size.height += 16.f;
        [self.scrollView scrollRectToVisible:frame animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - Instantiation

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPIdVerify" bundle:bundle];
    PPEditViewController *controller = [storyboard instantiateViewControllerWithIdentifier:[self identifier]];
    return controller;
}

@end
