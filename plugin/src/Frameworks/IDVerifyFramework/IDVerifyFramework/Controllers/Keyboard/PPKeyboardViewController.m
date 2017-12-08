//
//  PPKeyboardViewController.m
//  IDVerifyFramework
//
//  Created by Jura on 30/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPKeyboardViewController.h"

#import "PPIdVerifySettings.h"
#import "PPLocalization.h"
#import "PPKeyboardView.h"
#import "PPStringConfusion.h"

@interface PPKeyboardViewController () <PPKeyboardViewDelegate>

@property (nonatomic, strong) PPKeyboardView *keyboardView;

@property (weak, nonatomic) IBOutlet UIView *textDataView;

@property (weak, nonatomic) IBOutlet UIView *keyboardPartView;

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (weak, nonatomic) IBOutlet UILabel *helpLabel;

@property (weak, nonatomic) IBOutlet UIView *keysContainerView;

@property (weak, nonatomic) IBOutlet UIButton *previousKeyButton;

@property (weak, nonatomic) IBOutlet UIButton *nextKeyButton;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation PPKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.helpLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightRegular pointSizeDiff:-2.f];
    self.helpLabel.text = PP_LOCALIZED_RESULT(
        @"keyboard.label.help", @"Ukoliko označeno slovo nije ispravno, zamijenite ga ponuđenim. Strelicama se prebacujete između slova.");

    self.confirmButton.layer.cornerRadius = 6.0f;
    self.confirmButton.titleLabel.font =
        [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:2.f];
    self.confirmButton.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationPrimaryColor;

    self.valueLabel.font =
        [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightRegular relativeScale:2.0f pointSizeDiff:0.0f];

    [self.confirmButton setTitle:PP_LOCALIZED_RESULT(@"keyboard.button.confirm", @"CONFIRM CHANGES") forState:UIControlStateNormal];

    self.keyboardPartView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;

    self.textDataView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.keyboardBackgroundColor;

    [self configureKeys];
    [self updateText];
}

- (void)updateText {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.viewModel.result];

    for (PPStringConfusion *confusion in self.viewModel.stringConfusions) {
        if (confusion == self.viewModel.currentConfusion) {
            [string addAttribute:NSForegroundColorAttributeName
                           value:[PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationPrimaryColor
                           range:confusion.range];
        } else {
            [string addAttribute:NSForegroundColorAttributeName
                           value:[PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor
                           range:confusion.range];
        }
    }

    self.valueLabel.attributedText = string;
}

#pragma mark - Keys

- (void)configureKeys {
    self.keyboardView = [[PPKeyboardView alloc] initWithFrame:self.keysContainerView.bounds confusion:[self.viewModel currentConfusion]];
    self.keyboardView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.keyboardView.delegate = self;
    [self.keysContainerView addSubview:self.keyboardView];

    if ([self.viewModel isFirstCofusion]) {
        [self toggleButton:self.previousKeyButton isOn:NO];
    } else {
        [self toggleButton:self.previousKeyButton isOn:YES];
    }

    if ([self.viewModel isLastConfusion]) {
        [self toggleButton:self.nextKeyButton isOn:NO];
    } else {
        [self toggleButton:self.nextKeyButton isOn:YES];
    }
}

- (void)toggleButton:(UIButton *)button isOn:(BOOL)isOn {
    button.enabled = isOn;
    button.hidden = !isOn;
}

#pragma mark - Button handlers

- (IBAction)previousPressed:(id)sender {
    [self.keyboardView removeFromSuperview];
    [self.viewModel moveToPreviousConfusion];
    [self configureKeys];
    [self updateText];
}

- (IBAction)confirmPressed:(id)sender {
    [self.delegate keyboardViewController:self didFinishEditingWithResult:self.viewModel.result];
}

- (IBAction)nextPressed:(id)sender {
    [self.keyboardView removeFromSuperview];
    [self.viewModel moveToNextConfusion];
    [self configureKeys];
    [self updateText];
}

- (IBAction)didTapValueLabel:(id)sender {
    CGPoint tapLocation = [sender locationInView:self.valueLabel];

    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.valueLabel.attributedText];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];

    NSAssert(self.valueLabel.font != nil, @"Value label font in PPKeyboardViewController must not be nil");

    [attributedText addAttributes:@{ NSFontAttributeName : self.valueLabel.font, NSParagraphStyleAttributeName : paragraphStyle } range:NSMakeRange(0, self.valueLabel.text.length)];

    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];

    // init text storage
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedText];
    [textStorage addLayoutManager:layoutManager];

    // init text container
    NSTextContainer *textContainer =
        [[NSTextContainer alloc] initWithSize:CGSizeMake(self.valueLabel.frame.size.width, self.valueLabel.frame.size.height + 100.f)];
    textContainer.lineFragmentPadding = 0;
    textContainer.maximumNumberOfLines = self.valueLabel.numberOfLines;
    textContainer.lineBreakMode = self.valueLabel.lineBreakMode;

    [layoutManager addTextContainer:textContainer];

    NSUInteger index = [self confusionIndexForTapAtPoint:tapLocation inLayoutManager:layoutManager textContainer:textContainer];

    if (index != self.viewModel.currentConfusionIndex) {
        [self.keyboardView removeFromSuperview];
        [self.viewModel moveToConfusionAtIndex:index];
        [self configureKeys];
        [self updateText];
    }
}

- (NSUInteger)confusionIndexForTapAtPoint:(CGPoint)point
                          inLayoutManager:(NSLayoutManager *)layoutManager
                            textContainer:(NSTextContainer *)textContainer {
    NSUInteger best = 0;
    CGFloat bestDistance = INFINITY;

    for (NSUInteger i = 0; i < self.viewModel.stringConfusions.count; i++) {
        PPStringConfusion *confusion = [self.viewModel.stringConfusions objectAtIndex:i];
        CGRect confusionRect = [self rectForConfusion:confusion inLayoutManager:layoutManager textContainer:textContainer];
        CGFloat distance = CGPointDistance(point, CGPointMake(CGRectGetMidX(confusionRect), CGRectGetMidY(confusionRect)));
        if (distance < bestDistance) {
            bestDistance = distance;
            best = i;
        }

    }
    return best;
}

- (CGRect)rectForConfusion:(PPStringConfusion *)confusion
           inLayoutManager:(NSLayoutManager *)layoutManager
             textContainer:(NSTextContainer *)textContainer {
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:confusion.range actualGlyphRange:&glyphRange];
    return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}

CGFloat CGPointDistance(CGPoint p1, CGPoint p2) {
    CGFloat dx = p1.x - p2.x;
    CGFloat dy = p1.y - p2.y;
    CGFloat dist = sqrt(pow(dx, 2) + pow(dy, 2));
    return dist;
}

#pragma mark - PPKeyboardViewDelegate

- (void)keyboardView:(PPKeyboardView *)keyboardView didTapStringConfusion:(NSString *)confusion {
    self.viewModel.currentConfusion.currentValue = confusion;
    self.viewModel.result =
        [self.viewModel.result stringByReplacingCharactersInRange:self.viewModel.currentConfusion.range withString:confusion];
    [self updateText];
}

#pragma mark - Instantiation

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPIdVerify" bundle:bundle];
    PPKeyboardViewController *controller = [storyboard instantiateViewControllerWithIdentifier:[self identifier]];
    return controller;
}

@end
