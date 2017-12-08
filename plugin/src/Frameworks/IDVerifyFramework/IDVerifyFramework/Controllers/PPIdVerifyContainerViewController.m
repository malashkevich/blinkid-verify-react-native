//
//  PPIdVerifyContainerViewController.m
//  IDVerifyFramework
//
//  Created by Jura on 09/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdVerifyContainerViewController.h"

#import "PPIdVerifyViewModel.h"
#import "PPLocalization.h"
#import "UIImage+Utils.h"

@interface PPIdVerifyContainerViewController ()

@property (nonatomic) UIViewController<PPScanningViewController> *scanningViewController;

@property (nonatomic) PPIdVerifyViewController *verifyViewController;

@property (nonatomic) UIBarButtonItem *torchBarButton;

@property (nonatomic) BOOL torchOn;

@property (nonatomic) BOOL backGestureEnabled;

@property (nonatomic, readonly) PPIdVerifyPreset verifyPreset;

@end

@implementation PPIdVerifyContainerViewController

- (instancetype)initWithIdVerifyPreset:(PPIdVerifyPreset)verifyPreset {
    self = [super init];
    if (self) {
        _verifyPreset = verifyPreset;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.containerView];

    [self.delegate idVerifyContainerViewControllerDidLoadView:self];

    [self addChildViewController:self.scanningViewController];
    self.scanningViewController.view.clipsToBounds = YES;
    self.scanningViewController.view.frame = self.containerView.bounds;
    [self.containerView insertSubview:self.scanningViewController.view atIndex:0];
    [self.scanningViewController didMoveToParentViewController:self];

    [self setupNavigationBar];

    self.backGestureEnabled = self.navigationController.interactivePopGestureRecognizer.enabled;

    _torchOn = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self displayTorchButton:YES animated:NO];

    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    self.navigationController.interactivePopGestureRecognizer.enabled = self.backGestureEnabled;
}

+ (instancetype)verifyContainerViewControllerForCountryPreset:(PPIdVerifyPreset)verifyPreset {
    return [[self alloc] initWithIdVerifyPreset:verifyPreset];
}

#pragma mark - navigation bar

- (void)setupNavigationBar {

    self.torchBarButton = [[UIBarButtonItem alloc]
        initWithImage:[[UIImage pp_imageInResourcesBundleNamed:@"icSun1Novi"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                style:UIBarButtonItemStylePlain
               target:self
               action:@selector(didTapTorch:)];

    self.navigationItem.rightBarButtonItem = self.torchBarButton;

    self.navigationItem.title = PP_LOCALIZED_CAMERA(@"scanning.navigationBar.title", @"ID Scanning");

    [self displayTorchButton:[self isTorchAvailable] animated:NO];
}

- (BOOL)isTorchAvailable {
    return [self.verifyViewController.containerViewController overlayViewControllerShouldDisplayTorch:self.verifyViewController];
}

- (void)displayTorchButton:(BOOL)visible animated:(BOOL)animated {

    void (^block)(void) = ^void() {
        if (visible) {
            self.torchBarButton.enabled = YES;
            self.navigationItem.rightBarButtonItem = self.torchBarButton;

        } else {
            self.torchBarButton.enabled = NO;
            self.navigationItem.rightBarButtonItem = nil;
        }
    };

    if (animated) {
        [UIView animateWithDuration:0.4
                         animations:^{
                             block();
                         }];
    } else {
        block();
    }
}

- (void)didTapTorch:(id)sender {
    [self toggleTorch];
}

- (void)toggleTorch {
    BOOL success =
        [self.verifyViewController.containerViewController overlayViewController:self.verifyViewController willSetTorch:!self.torchOn];
    if (success) {
        self.torchOn = !self.torchOn;
    }
}

- (void)turnOffTorch {
    if (self.torchOn) {
        [self toggleTorch];
    }
}

#pragma mark - verification method

- (void)idVerifyResult:(PPIdVerifyResult *)result verifiedWithResponse:(PPIdVerifyResponse *)response error:(NSError *)error {
    [self.verifyViewController idVerifyResult:result verifiedWithResponse:response error:error];
}

#pragma mark - View Controller

- (PPIdVerifyViewController *)verifyViewController {
    if (_verifyViewController == nil) {
        _verifyViewController =
            [PPIdVerifyViewController viewControllerFromStoryboardInBundle:[PPIdVerifySettings sharedSettings].resourcesBundle
                                                        withIdVerifyPreset:self.verifyPreset];
        _verifyViewController.delegate = self;
        _verifyViewController.showCloseButton = NO;
    }
    return _verifyViewController;
}

- (UIViewController<PPScanningViewController> *)scanningViewController {
    if (_scanningViewController == nil) {
        _scanningViewController = [PPViewControllerFactory cameraViewControllerWithDelegate:nil
                                                                      overlayViewController:self.verifyViewController
                                                                                coordinator:self.verifyViewController.viewModel.coordinator
                                                                                      error:nil];
    }
    return _scanningViewController;
}

#pragma mark - PPIdVerifyViewControllerDelegate

- (void)idVerifyViewControllerDidStartScanning:(PPIdVerifyViewController *)idVerifyViewController {
    self.navigationItem.title = PP_LOCALIZED_CAMERA(@"scanning.navigationBar.title", @"ID Scanning");
    [self.delegate idVerifyContainerViewControllerDidStartScanning:self];
}

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishScanningFrontSideWithResult:(PPIdVerifyResult *)result {
    [self.delegate idVerifyContainerViewController:self didFinishScanningFrontSideWithResult:result];
}

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishScanningWithResult:(PPIdVerifyResult *)result {
    [self displayTorchButton:NO animated:YES];
    [self.delegate idVerifyContainerViewController:self didFinishScanningWithResult:result];
}

- (void)idVerifyViewControllerDidStartEditing:(PPIdVerifyViewController *)idVerifyViewController {
    [self turnOffTorch];
    self.navigationItem.title = PP_LOCALIZED_CAMERA(@"editing.navigationBar.title", @"Confirm data");
}

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController editedField:(NSString *)fieldKey oldValue:(NSString *)oldValue newValue:(NSString *)newValue {
    [self.delegate idVerifyContainerViewController:self editedField:fieldKey oldValue:oldValue newValue:newValue];
}

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishEditingWithResult:(PPIdVerifyResult *)result {
    [self.delegate idVerifyContainerViewController:self didFinishEditingWithResult:result];
}

- (void)idVerifyViewControllerDidStartLivenessDetection:(PPIdVerifyViewController *)idVerifyViewController {
    self.navigationItem.title = PP_LOCALIZED_CAMERA(@"liveness.navigationBar.title", @"Selfie");
}

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController
    didFinishLivenessDetectionWithResult:(PPIdVerifyResult *)result {
    [self.delegate idVerifyContainerViewController:self didFinishLivenessWithResult:result];
}

- (void)idVerifyViewControllerDidStartResultView:(PPIdVerifyViewController *)idVerifyViewController {
    self.navigationItem.title = PP_LOCALIZED_CAMERA(@"results.navigationBar.title", @"Confirm data");
}

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController doVerifyForResult:(PPIdVerifyResult *)result {
    [self.delegate idVerifyContainerViewController:self doVerifyForResult:result];
}

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishWithoutVerification:(PPIdVerifyResult *)result {
    [self.delegate idVerifyContainerViewController:self didFinishWithoutVerification:result];
}

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishWithSuccessfulVerification:(PPIdVerifyResult *)result {
    [self.delegate idVerifyContainerViewController:self didFinishWithSuccessfulVerification:result];
}

#pragma mark - orientation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

@end
