//
//  PPIdResultViewController.m
//  LivenessTest
//
//  Created by Jura on 01/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdResultViewController.h"

#import "PPIdVerifySettings.h"
#import "PPMatchResultView.h"
#import "PPLocalization.h"
#import "PPAutoBalancedLabel.h"

static CGFloat bottomMarginItemToButton = 26.f;
static CGFloat buttonMargin = 20.f;
static CGFloat buttonHeight = 44.f;

@interface PPIdResultViewController () <PPIdResultViewModelDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet PPMatchResultView *matchResultView;
@property (weak, nonatomic) IBOutlet UIView *redSeparatorView;
@property (weak, nonatomic) IBOutlet PPAutoBalancedLabel *statusLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *faceImageAspectRatioConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redSeparatorViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIButton *scanAgainButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic) NSArray<PPIdResultItemView *> *resultSubviews;

@end

@implementation PPIdResultViewController

#pragma mark - View Controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewModel.delegate = self;

    self.statusLabel.font =
        [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightRegular pointSizeDiff:-1.f];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self reloadViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!self.viewModel.livenessFailed) {
        [self.matchResultView setStatus:PPMatchResultStatusWorking withConfidence:0.0f];
        [self.delegate idResultViewController:self doVerifyForResult:self.viewModel.verifyResult];
    }
}

#pragma mark - Header/Footer definition 

- (void)reloadViews {

    [self updateHeaderAndFooter];

    [self clearAllItems];
    [self populateItems];

    [self.scrollView setContentOffset:CGPointMake(0, -self.scrollView.contentInset.top) animated:NO];
}

- (void)updateHeaderAndFooter {
    if (self.viewModel.livenessFailed) {
        [self setFailedSelfie];
        [self configureFooterViewFaceMatchFail];
    } else {
        [self setImages];
        [self configureFooterViewWorking];
    }
}

- (void)setImages {

    [self.view removeConstraint:self.faceImageAspectRatioConstraint];

    self.matchResultView.hidden = NO;
    [self.matchResultView setStatus:PPMatchResultStatusFail withConfidence:0.0f];

    self.leftImageView.image = self.viewModel.verifyResult.viewResult.faceImage;
    self.rightImageView.image = self.viewModel.verifyResult.viewResult.selfieImage;

    self.faceImageAspectRatioConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.leftImageView
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1.1f
                                                                        constant:0.f];

    self.statusLabel.text = nil;
    self.redSeparatorViewHeightConstraint.constant = 2.0f;
    self.redSeparatorView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;
    [self.view layoutIfNeeded];
}

- (void)setFailedSelfie {
    [self.view removeConstraint:self.faceImageAspectRatioConstraint];

    self.leftImageView.image = nil;
    self.rightImageView.image = nil;

    self.matchResultView.hidden = YES;

    self.faceImageAspectRatioConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.leftImageView
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:0.0f
                                                                        constant:0.f];

    self.statusLabel.text = PP_LOCALIZED_RESULT(@"result.status.selfiefailed", @"SELFIE CAPTURE FAILED. REPEAT AND FOLLOW THE INSTRUCTION ON THE SCREEN.");

    self.redSeparatorViewHeightConstraint.constant = 48.f;
    self.redSeparatorView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationPrimaryColor;
    [self.view addConstraint:self.faceImageAspectRatioConstraint];
    
    [self.view layoutIfNeeded];
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

- (void)populateItems {

    self.resultSubviews = [self.viewModel.viewPopulator populateViewsForViewResult:self.viewModel.verifyResult.viewResult];

    for (int i = 0; i < [self.resultSubviews count]; i++) {
        UIView *view = [self.resultSubviews objectAtIndex:i];
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

    if (index % 2) {
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
                                                                        toItem:self.redSeparatorView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0f
                                                                      constant:0];

    [self.contentView addConstraint:topConstraint];
}

- (void)configureBottomView:(UIView *)view {

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.footerView
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0f
                                                                         constant:0.0f];

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

#pragma mark - footer definition

- (void)configureFooterViewWorking {

    [self.confirmButton removeFromSuperview];
    self.confirmButton = nil;

    [self.scanAgainButton removeFromSuperview];
    self.scanAgainButton = nil;

    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.footerView addSubview:self.activityIndicatorView];
    self.activityIndicatorView.color = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;
    [self.activityIndicatorView startAnimating];

    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.activityIndicatorView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.footerView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0f
                                                                      constant:bottomMarginItemToButton];

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.activityIndicatorView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.footerView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0f
                                                                         constant:-bottomMarginItemToButton];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.activityIndicatorView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.footerView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0f
                                                                          constant:0.0f];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.activityIndicatorView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.footerView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0f
                                                                          constant:0.0f];

    [self.footerView addConstraints:@[topConstraint, bottomConstraint, centerXConstraint, centerYConstraint]];
}

- (void)configureFooterViewFaceMatchFail {

    [self.activityIndicatorView removeFromSuperview];
    self.activityIndicatorView = nil;

    self.confirmButton = [[UIButton alloc] init];
    self.scanAgainButton = [[UIButton alloc] init];

    self.scanAgainButton.layer.cornerRadius = 6.0f;
    [self.scanAgainButton setTitle:PP_LOCALIZED_RESULT(@"result.button.repeatSelfie", @"Repeat selfie") forState:UIControlStateNormal];
    [self.scanAgainButton addTarget:self action:@selector(buttonScanAgainTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.scanAgainButton.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;
    self.scanAgainButton.titleLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:1.f];
    self.scanAgainButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.footerView addSubview:self.scanAgainButton];

    // Show only scan again button

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.scanAgainButton
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.footerView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0f
                                                                      constant:buttonMargin];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.scanAgainButton
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.footerView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0f
                                                                       constant:buttonMargin];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.scanAgainButton
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.footerView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0f
                                                                          constant:0.0f];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.scanAgainButton
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0f
                                                                         constant:buttonHeight];

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.scanAgainButton
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.footerView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0f
                                                                         constant:-buttonMargin];

    [self.footerView addConstraints:@[topConstraint, heightConstraint, bottomConstraint]];
    [self.footerView addConstraints:@[leftConstraint, centerXConstraint]];
}

- (void)configureFooterViewFaceMatchSuccess {

    [self.activityIndicatorView removeFromSuperview];
    self.activityIndicatorView = nil;

    [self.scanAgainButton removeFromSuperview];
    self.scanAgainButton = nil;

    self.confirmButton = [[UIButton alloc] init];

    self.confirmButton.layer.cornerRadius = 6.0f;
    [self.confirmButton setTitle:PP_LOCALIZED_RESULT(@"result.button.continue", @"Continue") forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(buttonConfirmTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationPrimaryColor;
    self.confirmButton.titleLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:1.f];
    self.confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.footerView addSubview:self.confirmButton];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.confirmButton
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.footerView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0f
                                                                      constant:buttonMargin];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.confirmButton
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.footerView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0f
                                                                       constant:buttonMargin];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.confirmButton
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.footerView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0f
                                                                          constant:0.0f];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.confirmButton
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1.0f
                                                                                constant:buttonHeight];

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.confirmButton
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.footerView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0f
                                                                         constant:-buttonMargin];

    [self.footerView addConstraints:@[topConstraint, heightConstraint, bottomConstraint]];
    [self.footerView addConstraints:@[leftConstraint, centerXConstraint]];
}

#pragma mark - Button handlers

- (void)buttonScanAgainTapped:(id)sender {
    [self.delegate idResultViewControllerRequiresRepeatedScan:self];
}

- (void)buttonConfirmWithoutVerificationTapped:(id)sender {
    [self.delegate idResultViewController:self
          didFinishWithoutVerification:self.viewModel.verifyResult];
}

- (void)buttonConfirmTapped:(id)sender {
    [self.delegate idResultViewController:self
        didFinishWithSuccessfulVerification:self.viewModel.verifyResult];
}

#pragma mark - verification handling

- (void)idVerifyResult:(PPIdVerifyResult *)result verifiedWithResponse:(PPIdVerifyResponse *)response error:(NSError *)error {
    if (response.isPersonVerified) {

        [self.matchResultView setStatus:PPMatchResultStatusMatch withConfidence:1.0f];
        [self configureFooterViewFaceMatchSuccess];
        [self showOk];

        [UIView animateWithDuration:0.3
                         animations:^{
                             [self.view layoutIfNeeded];
                             self.redSeparatorView.backgroundColor =
                                [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;
                         }];
    } else {

        [self.matchResultView setStatus:PPMatchResultStatusFail withConfidence:0.0f];
        [self configureFooterViewFaceMatchFail];
        if (error != nil) {
            [self showInternetConnectionFail];
        } else {
            [self showFaceMatchFail];
        }

        [UIView animateWithDuration:0.3
                         animations:^{
                             [self.view layoutIfNeeded];
                             self.redSeparatorView.backgroundColor =
                                [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.livenessErrorColor;
                         }];
    }
}

- (void)showOk {
    self.statusLabel.text = nil;
    self.redSeparatorViewHeightConstraint.constant = 2.f;
}

- (void)showFaceMatchFail {
    self.statusLabel.text =
        PP_LOCALIZED_RESULT(@"result.status.matchfailed", @"FACE MATCHING FAILED. REPEAT THE SELFIE OR SCHEDULE A MEETING.");
    self.redSeparatorViewHeightConstraint.constant = 48.f;
}

- (void)showInternetConnectionFail {
    self.statusLabel.text = PP_LOCALIZED_RESULT(@"result.status.noconnection", @"CHECK YOUR INTERNET CONNECTION.");
    self.redSeparatorViewHeightConstraint.constant = 48.f;
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.view layoutIfNeeded];
                         self.redSeparatorView.backgroundColor =
                            [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationPrimaryColor;
                     }];
}

#pragma mark - Instantiation

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPIdVerify" bundle:bundle];
    PPIdResultViewController *controller = [storyboard instantiateViewControllerWithIdentifier:[self identifier]];
    return controller;
}

@end
