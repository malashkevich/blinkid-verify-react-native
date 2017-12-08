//
//  PPLivenessViewController.m
//  LivenessTest
//
//  Created by Jura on 01/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPLivenessViewController.h"

#import "PPInstructionsViewController.h"
#import "PPTransparentHoleView.h"
#import "PPRoundView.h"
#import "PPLivenessStatusView.h"
#import "PPIdVerifySettings.h"
#import "PPLocalization.h"

@interface PPLivenessViewController () <PPInstructionsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet PPTransparentHoleView *transparentHoleView;

@property (weak, nonatomic) IBOutlet PPRoundView *roundHoleView;

@property (weak, nonatomic) IBOutlet PPLivenessStatusView *livenessStatusView;

@property (weak, nonatomic) IBOutlet UIButton *instructionsButton;

@property (nonatomic) BOOL isScanningDone;

@end

@implementation PPLivenessViewController

#pragma mark - View Controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureTransparentHoleView];
    [self configureLivenessStatusView];

    if ([self.viewModel shouldLivenessInstructions]) {
        [self showInstructionsAnimated:NO];
    }

    [self configureInstructionsButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.viewModel configureCoordinator];

    self.livenessStatusView.running = YES;

    [self.livenessStatusView updateForStatus:PPLivenessStatusFaceNotInFrame];

    self.isScanningDone = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    self.livenessStatusView.running = NO;
}

#pragma mark - Configure subviews

- (void)configureTransparentHoleView {
    self.transparentHoleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.45];
    self.transparentHoleView.holeView = self.roundHoleView;
}

- (void)configureLivenessStatusView {
    self.livenessStatusView.normalColor = [[PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor colorWithAlphaComponent:0.67f];
    self.livenessStatusView.errorColor = [[PPIdVerifySettings sharedSettings].uiSettings.colorScheme.livenessErrorColor colorWithAlphaComponent:0.67f];
}

- (void)configureInstructionsButton {
    
    self.instructionsButton.layer.cornerRadius = 10.0f;
    
    [self.instructionsButton setTitle:PP_LOCALIZED_CAMERA(@"liveness.instructions.title", @"Tap for detailed instructions") forState:UIControlStateNormal];

    self.instructionsButton.titleLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightBold relativeScale:1.0f pointSizeDiff:-1.0f];
    self.instructionsButton.titleLabel.textColor = [UIColor whiteColor];
    self.instructionsButton.backgroundColor = [[PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor colorWithAlphaComponent:0.9f];
}

#pragma mark - Instructions

- (void)showInstructionsAnimated:(BOOL)animated {

    [self.delegate livenessViewControllerNeedsPauseScanning:self];

    PPInstructionsViewController *instructionsViewController = [PPInstructionsViewController viewControllerFromStoryboardInBundle:[PPIdVerifySettings sharedSettings].resourcesBundle];
    instructionsViewController.delegate = self;
    [instructionsViewController setSelfiePreset];
    [instructionsViewController attachToParentViewController:self animated:animated];
}

- (void)hideInstructions:(PPInstructionsViewController *)instructionsViewController animated:(BOOL)animated {
    [instructionsViewController detachFromParentViewController:self animated:animated];

    [self.delegate livenessViewControllerNeedsResumeScanning:self];

    [self.viewModel setInstructionsPresented];
}

#pragma mark - Liveness events

- (void)cameraViewController:(UIViewController<PPScanningViewController> *)cameraViewController didOutputMetadata:(PPMetadata *)metadata {

    if (self.isScanningDone) {
        return;
    }
    
    if ([metadata isKindOfClass:[PPImageMetadata class]]) {
        [self.viewModel addImageMetadata:(PPImageMetadata *)metadata];
    }
}

- (void)cameraViewController:(UIViewController<PPScanningViewController> *)cameraViewController
            didOutputResults:(NSArray<PPRecognizerResult *> *)results {

    if (self.isScanningDone) {
        return;
    }

    for (PPRecognizerResult *result in results) {
        if ([result isKindOfClass:[PPLivenessRecognizerResult class]]) {
            [self.viewModel addRecognizerResult:result];
            [self.delegate livenessViewControllerDidFinish:self];

            self.isScanningDone = YES;
        }
    }
}

- (void)cameraViewController:(UIViewController<PPScanningViewController> *)cameraViewController
    didRequestLivenessAction:(PPLivenessAction)action {

    switch (action) {
        case PPLivenessActionBlink:
            [self.livenessStatusView updateForStatus:PPLivenessStatusBlink];
            break;
        case PPLivenessActionSmile:
            [self.livenessStatusView updateForStatus:PPLivenessStatusSmile];
            break;
    }
}

- (void)cameraViewController:(UIViewController<PPScanningViewController> *)cameraViewController
    didFindLivenessActionError:(PPLivenessError)error {
    switch (error) {
        case PPLivenessErrorFaceNotInRoi:
        case PPLivenessErrorNoFace:
            [self.livenessStatusView updateForStatus:PPLivenessStatusFaceNotInFrame];
            break;
        case PPLivenessErrorFaceAngleYawLarge:
        case PPLivenessErrorFaceAngleYawSmall:
        case PPLivenessErrorFaceAnglePitchLarge:
        case PPLivenessErrorFaceAnglePitchSmall:
        case PPLivenessErrorFaceAngleRollLarge:
        case PPLivenessErrorFaceAngleRollSmall:
            [self.livenessStatusView updateForStatus:PPLivenessStatusAngle];
            break;
        case PPLivenessErrorFaceTooClose:
            [self.livenessStatusView updateForStatus:PPLivenessStatusTooClose];
            break;
        case PPLivenessErrorFaceTooFar:
            [self.livenessStatusView updateForStatus:PPLivenessStatusTooFar];
            break;
        case PPLivenessErrorSuccess:
            break;
    }
}

#pragma mark - Instantiation

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPIdVerify" bundle:bundle];
    PPLivenessViewController *controller = [storyboard instantiateViewControllerWithIdentifier:[self identifier]];
    return controller;
}

#pragma mark - PPInstructionsViewControllerDelegate

- (void)instructionsViewControllerFinished:(PPInstructionsViewController *)instructionsViewController {
    [self hideInstructions:instructionsViewController animated:YES];
}

- (IBAction)instructionsTapped:(id)sender {
    [self showInstructionsAnimated:YES];
}

@end
