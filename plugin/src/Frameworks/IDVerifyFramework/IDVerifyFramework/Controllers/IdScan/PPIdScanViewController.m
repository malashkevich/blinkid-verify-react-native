//
//  PPIdScanViewController.m
//  LivenessTest
//
//  Created by Jura on 01/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdScanViewController.h"

#import "PPIdVerifySettings.h"
#import "PPIdRecognizerResults.h"
#import "PPViewfinderView.h"
#import "PPIdScanViewStateUpdater.h"
#import "PPNonMatchingDataView.h"
#import "PPGlareStatusView.h"
#import "PPInstructionsViewController.h"

@interface PPIdScanViewController () <PPIdScanViewModelDelegate, PPNonMatchingDataViewDelegate, PPInstructionsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet PPViewfinderView *viewfinderView;

@property (weak, nonatomic) IBOutlet UIView *instructionsView;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

@property (nonatomic, strong) PPNonMatchingDataView *nonMatchingDataView;

@property (nonatomic, strong) PPGlareStatusView *glareStatusView;

@property (nonatomic, strong) PPIdScanViewStateUpdater *viewUpdater;

@property (nonatomic, assign) BOOL isScanningDone;

@end

@implementation PPIdScanViewController

#pragma mark - View Controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupModernOcrOverlaySubview];
    [self setupTapToFocusOverlaySubview];
    [self setupGlareSubview];

    self.viewModel.delegate = self;

    self.viewUpdater = [[PPIdScanViewStateUpdater alloc] initWithViewfinder:self.viewfinderView
                                                                statusLabel:self.statusLabel
                                                            statusImageView:self.statusImageView];

    self.statusLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightRegular pointSizeDiff:-1.f];

    self.instructionsView.backgroundColor = [[PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor colorWithAlphaComponent:0.9f];

    [self.viewUpdater updateForState:PPScanningStateUndefined];

    if ([self.viewModel shouldShowInstructions]) {
        [self showInstructionsAnimated:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (![self.viewModel shouldShowInstructions]) {
        [self resetScanning];
    }
}

#pragma mark - Subview setup

- (void)setupModernOcrOverlaySubview {

    PPModernOcrResultOverlaySubview *ocrSubview = [[PPModernOcrResultOverlaySubview alloc] init];
    ocrSubview.translatesAutoresizingMaskIntoConstraints = NO;
    ocrSubview.tintColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;

    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:ocrSubview
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:0.f];

    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:ocrSubview
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0f
                                                                constant:0.f];

    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:ocrSubview
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1.0f
                                                              constant:0.f];

    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:ocrSubview
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1.0f
                                                               constant:0.f];

    ocrSubview.charFadeInDuration = 0.14f;
    ocrSubview.shouldIgnoreFastResults = YES;


    [self registerOverlaySubview:ocrSubview];
    [self.view addSubview:ocrSubview];

    [self.view addConstraint:centerX];
    [self.view addConstraint:centerY];
    [self.view addConstraint:width];
    [self.view addConstraint:height];
}

- (void)setupTapToFocusOverlaySubview {
    PPTapToFocusOverlaySubview *tapSubview = [[PPTapToFocusOverlaySubview alloc] initWithFrame:self.view.bounds];

    [self registerOverlaySubview:tapSubview];
    [self.view insertSubview:tapSubview atIndex:0];
}

- (void)setupNonMatchingDataView {
    self.nonMatchingDataView = [PPNonMatchingDataView allocFromNibInBundle:[PPIdVerifySettings sharedSettings].resourcesBundle];

    self.nonMatchingDataView.translatesAutoresizingMaskIntoConstraints = NO;
    self.nonMatchingDataView.alpha = 0.0f;
    self.nonMatchingDataView.delegate = self;

    [self.view addSubview:self.nonMatchingDataView];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.nonMatchingDataView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.viewfinderView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0.0f];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.nonMatchingDataView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.viewfinderView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:0.0f];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.nonMatchingDataView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.viewfinderView
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1.0
                                                                        constant:0.f];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.nonMatchingDataView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.viewfinderView
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0f
                                                                         constant:0.0f];

    [self.view addConstraints:@[ centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]];
}

- (void)setupGlareSubview {

    self.glareStatusView = [[PPGlareStatusView alloc] initWithFrame:CGRectZero];
    self.glareStatusView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.glareStatusView];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.glareStatusView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.viewfinderView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0.0f];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.glareStatusView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.viewfinderView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:0.0f];

    NSLayoutConstraint *widthCostraint = [NSLayoutConstraint constraintWithItem:self.glareStatusView
                                                                      attribute:NSLayoutAttributeWidth
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.viewfinderView
                                                                      attribute:NSLayoutAttributeWidth
                                                                     multiplier:1.0
                                                                       constant:-20.0f];

    [self.view addConstraints:@[ centerXConstraint, centerYConstraint, widthCostraint]];
}

#pragma mark - Instructions

- (void)showInstructionsAnimated:(BOOL)animated {

    [self.delegate idScanViewControllerNeedsPauseScanning:self];
    [self.delegate idScanViewControllerNeedsPauseCamera:self];

    PPInstructionsViewController *instructionsViewController = [PPInstructionsViewController viewControllerFromStoryboardInBundle:[PPIdVerifySettings sharedSettings].resourcesBundle];
    instructionsViewController.delegate = self;
    [instructionsViewController setScanPreset];
    [instructionsViewController attachToParentViewController:self animated:animated];
}

- (void)hideInstructions:(PPInstructionsViewController *)instructionsViewController animated:(BOOL)animated {
    [instructionsViewController detachFromParentViewController:self animated:animated];

    [self.delegate idScanViewControllerNeedsResumeCamera:self];
    [self.delegate idScanViewControllerNeedsResumeScanning:self];
}

#pragma mark - scanning

- (void)resetScanning {
    [self.viewModel resetScanResult];
    self.isScanningDone = NO;
}

- (void)cameraViewController:(UIViewController<PPScanningViewController> *)cameraViewController
    didFinishRecognitionFirstSide:(PPRecognizerResult *)result {

    if ([PPIdVerifySettings sharedSettings].enableBeep) {
        [cameraViewController playScanSuccesSound];
    }

    [self.delegate idScanViewControllerFinishedScanningFrontSide:self];
    [self.viewUpdater updateForState:PPScanningStateIdBackSide];
}

- (void)cameraViewController:(UIViewController<PPScanningViewController> *)cameraViewController didOutputMetadata:(PPMetadata *)metadata {

    if (self.isScanningDone) {
        return;
    }

    if ([metadata isKindOfClass:[PPImageMetadata class]]) {
        [self.viewModel addImageMetadata:(PPImageMetadata *)metadata];
    }

    if ([metadata isKindOfClass:[PPRecognitionStatusMetadata class]]) {
        PPRecognitionStatusMetadata *statusMetadata = (PPRecognitionStatusMetadata *)metadata;
        [self.glareStatusView setStatus:statusMetadata.status];
    }
}

- (void)cameraViewController:(UIViewController<PPScanningViewController> *)cameraViewController
            didOutputResults:(NSArray<PPRecognizerResult *> *)results {

    if (self.isScanningDone) {
        return;
    }

    if ([PPIdVerifySettings sharedSettings].enableBeep) {
        [cameraViewController playScanSuccesSound];
    }

    for (PPRecognizerResult *result in results) {
        [self.viewModel addRecognizerResult:result];
    }
}

#pragma mark - Handle non matching data

- (void)showNonMatchingDataMessage {
    [self setupNonMatchingDataView];

    [UIView animateWithDuration:0.4f
                     animations:^{
                         self.nonMatchingDataView.alpha = 1.0f;
                     }
                     completion:nil];
}

- (void)hideNonMatchingDataMessageWithCompletion:(void (^ __nullable)())completion  {
    [UIView animateWithDuration:0.4f
                     animations:^{
                         self.nonMatchingDataView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         self.nonMatchingDataView = nil;

                         if (completion) {
                             completion();

                              [self.delegate idScanViewControllerNeedsResumeScanning:self];
                         }
                     }];
}

#pragma mark - Configuration

- (void)idScanViewModel:(PPIdScanViewModel *)viewModel didChangeStateTo:(PPScanningState)newState from:(PPScanningState)oldState {

    if (newState == PPScanningStateDone) {
        self.isScanningDone = YES;
        [self.delegate idScanViewControllerFinished:self];
    } else if (newState == PPScanningStateNonMatchingData) {
        [self.delegate idScanViewControllerNeedsPauseScanning:self];
        [self showNonMatchingDataMessage];
    } else {
        [self.viewUpdater updateForState:newState];
    }
}

#pragma mark - PPNonMatchingDataViewDelegate

- (void)nonMatchingDataViewScanAgainTapped:(PPNonMatchingDataView *)view {
    [self hideNonMatchingDataMessageWithCompletion:^{
        [self resetScanning];
    }];
}

#pragma mark - Instructions tapped

- (IBAction)instructionsTapped:(id)sender {
    [self showInstructionsAnimated:YES];
}

#pragma mark - PPInstructionsViewControllerDelegate

- (void)instructionsViewControllerFinished:(PPInstructionsViewController *)instructionsViewController {
    [self hideInstructions:instructionsViewController animated:YES];

    if ([self.viewModel shouldShowInstructions]) {
        [self resetScanning];
    }
}

#pragma mark - Instantiation

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPIdVerify" bundle:bundle];
    PPIdScanViewController *controller = [storyboard instantiateViewControllerWithIdentifier:[self identifier]];
    return controller;
}

@end
