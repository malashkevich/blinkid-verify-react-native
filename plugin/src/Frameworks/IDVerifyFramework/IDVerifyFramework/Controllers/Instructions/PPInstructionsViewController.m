//
//  PPInstructionsViewController.m
//  IDVerifyFramework
//
//  Created by Jura on 17/05/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPInstructionsViewController.h"

#import "PPLocalization.h"

@interface PPInstructionsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *helpImageView;

@property (weak, nonatomic) IBOutlet UILabel *upperDetailsLabel;

@property (weak, nonatomic) IBOutlet UILabel *lowerDetailsLabel;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (nonatomic, strong) NSString *instructionsTitle;

@property (nonatomic, strong) UIImage *helpImage;

@property (nonatomic, strong) NSString *upperDetails;

@property (nonatomic, strong) NSString *lowerDetails;

@property (nonatomic, strong) NSString *closeButtonTitle;

@end

@implementation PPInstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.instructionsTitle;
    self.upperDetailsLabel.text = self.upperDetails;
    self.lowerDetailsLabel.text = self.lowerDetails;
    [self.closeButton setTitle:self.closeButtonTitle forState:UIControlStateNormal];
    self.helpImageView.image = self.helpImage;

    self.titleLabel.font =
        [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:7.f];

    self.upperDetailsLabel.font =
        [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightRegular pointSizeDiff:1.f];

    self.lowerDetailsLabel.font =
        [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightRegular pointSizeDiff:1.f];

    self.closeButton.titleLabel.font =
        [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:2.f];
}

- (IBAction)closeTapped:(id)sender {
    [self.delegate instructionsViewControllerFinished:self];
}

#pragma mark - Setters

- (void)setInstructionsTitle:(NSString *)instructionsTitle {
    _instructionsTitle = instructionsTitle;
    if (self.titleLabel) {
        self.titleLabel.text = instructionsTitle;
    }
}

- (void)setHelpImage:(UIImage *)helpImage {
    _helpImage = helpImage;
    if (self.helpImageView) {
        self.helpImageView.image = helpImage;
    }
}

- (void)setUpperDetails:(NSString *)upperDetails {
    _upperDetails = upperDetails;
    if (self.upperDetailsLabel) {
        self.upperDetailsLabel.text = upperDetails;
    }
}

- (void)setLowerDetails:(NSString *)lowerDetails {
    _lowerDetails = lowerDetails;
    if (self.lowerDetailsLabel) {
        self.lowerDetailsLabel.text = lowerDetails;
    }
}

- (void)setCloseButtonTitle:(NSString *)closeButtonTitle {
    _closeButtonTitle = closeButtonTitle;
    if (self.closeButton) {
        [self.closeButton setTitle:closeButtonTitle forState:UIControlStateNormal];
    }
}

#pragma mark - Instantiation

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPIdVerify" bundle:bundle];
    PPInstructionsViewController *controller = [storyboard instantiateViewControllerWithIdentifier:[self identifier]];
    return controller;
}

#pragma mark - Scan Instructions

- (void)setScanPreset {

    self.instructionsTitle = PP_LOCALIZED_CAMERA(@"instructions.scan.title", @"SCANNING INSTRUCTIONS");

    self.upperDetails = PP_LOCALIZED_CAMERA(@"instructions.scan.upper", @"First, put the front side then the back of your ID card in the frame. Wait until automatic reading is complete.");

    self.lowerDetails = PP_LOCALIZED_CAMERA(@"instructions.scan.lower", @"To ensure a successful reading, make sure that the ID card is not placed aslant and that there is no reflection.");

    self.closeButtonTitle = PP_LOCALIZED_CAMERA(@"instructions.close", @"CLOSE");

    self.helpImage = [PPIdVerifySettings sharedSettings].uiSettings.scanHelpImage;
}

- (void)setSelfiePreset {

    self.instructionsTitle = PP_LOCALIZED_CAMERA(@"instructions.selfie.title", @"INSTRUCTIONS FOR SELFIE");

    self.upperDetails = PP_LOCALIZED_CAMERA(@"instructions.selfie.upper", @"Hold your phone directly in front of your face and follow the instructions on the display.");

    self.lowerDetails = PP_LOCALIZED_CAMERA(@"instructions.selfie.lower", @"There must be enough light in the room, and the source of light may not be directly behind you.");

    self.closeButtonTitle = PP_LOCALIZED_CAMERA(@"instructions.close", @"CLOSE");

    self.helpImage = [PPIdVerifySettings sharedSettings].uiSettings.selfieHelpImage;
}

#pragma mark - attaching to parent

- (void)attachToParentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [viewController addChildViewController:self];
    self.view.frame = viewController.view.bounds;
    [viewController.view addSubview:self.view];
    self.view.alpha = 0.0f;
    [self didMoveToParentViewController:self];

    void (^block)(void) = ^void(void) {
        self.view.alpha = 1.0f;
    };

    if (animated) {
        [UIView animateWithDuration:0.4f
                         animations:^{
                             block();
                         }
                         completion:nil];
    } else {
        block();
    }
}

- (void)detachFromParentViewController:(UIViewController *)viewController animated:(BOOL)animated {

    void (^block)(void) = ^void(void) {
        self.view.alpha = 0.0f;
    };

    void (^remove)(void) = ^void(void) {
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    };

    if (animated) {
        [UIView animateWithDuration:0.4f
                         animations:^{
                             block();
                         }
                         completion:^(BOOL finished) {
                             remove();
                         }];
    } else {
        block();
        remove();
    }
}

@end
