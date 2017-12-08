//
//  PPIdVerifyViewController.m
//  LivenessTest
//
//  Created by Jura on 01/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdVerifyViewController.h"

#import "PPIdVerifySettings.h"
#import "PPLivenessViewController.h"
#import "PPIdScanViewController.h"
#import "PPEditViewController.h"
#import "PPIdResultViewController.h"
#import "PPCroatiaIdResultViewPopulator.h"
#import "PPGermanyIdResultViewPopulator.h"
#import "PPIdVerifyViewModel.h"

typedef NS_ENUM(NSUInteger, PPIdVerifyState) {
    PPIdVerifyStateStarting,
    PPIdVerifyStateScanning,
    PPIdVerifyStateEditing,
    PPIdVerifyStateSelfie,
    PPIdVerifyStateResult,
    PPIdVerifyStateDone
};

@interface PPIdVerifyViewController () <PPIdScanViewControllerDelegate, PPEditViewControllerDelegate, PPLivenessViewControllerDelegate,
                                        PPIdResultViewControllerDelegate>

@property (nonatomic) PPLivenessViewController *livenessViewController;

@property (nonatomic) PPIdResultViewController *resultViewController;

@property (nonatomic) PPIdScanViewController *idScanViewController;

@property (nonatomic) PPEditViewController *editViewController;

@property (nonatomic) PPIdVerifyViewModel *viewModel;

@property (nonatomic) PPIdVerifyState state;

@property (nonatomic) BOOL pausedCamera;

@property (nonatomic) BOOL pausedScanning;

@end

@implementation PPIdVerifyViewController

#pragma mark - View Controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.state = PPIdVerifyStateStarting;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.viewModel reset];
    [self startScanning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // camera or scanning can be paused because of the last state when verify view controller was presented
    // and since on view did appear we always start with ID scanning
    // we always start fresh

    if ([self.containerViewController isCameraPaused]) {
        [self resumeCamera];
    } else {
        self.pausedCamera = NO;
    }

    if ([self.containerViewController isScanningPaused]) {
        [self resumeScanning];
    } else {
        self.pausedScanning = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self clearViewControllers];
}

#pragma mark - UI setup

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - Button handlers

- (void)startScanning {

//    [self.viewModel setDummyResult];
//    [self startResultAnimated:NO withCompletion:nil];

    [self startIdScanAnimated:NO withCompletion:nil];

//    [self startLivenessAnimated:NO withCompletion:nil];
}

#pragma mark - Child View Controllers

- (PPIdScanViewController *)idScanViewController {
    if (_idScanViewController == nil) {
        _idScanViewController =
            [PPIdScanViewController viewControllerFromStoryboardInBundle:[PPIdVerifySettings sharedSettings].resourcesBundle];
        _idScanViewController.viewModel = [self.viewModel createIdScanViewModel];
        _idScanViewController.delegate = self;
    }
    return _idScanViewController;
}

- (PPLivenessViewController *)livenessViewController {
    if (_livenessViewController == nil) {
        _livenessViewController =
            [PPLivenessViewController viewControllerFromStoryboardInBundle:[PPIdVerifySettings sharedSettings].resourcesBundle];
        _livenessViewController.viewModel = [self.viewModel createLivenessViewModel];
        _livenessViewController.delegate = self;
    }
    return _livenessViewController;
}

- (PPIdResultViewController *)resultViewController {
    if (_resultViewController == nil) {
        _resultViewController =
            [PPIdResultViewController viewControllerFromStoryboardInBundle:[PPIdVerifySettings sharedSettings].resourcesBundle];
        _resultViewController.viewModel = [self.viewModel createIdResultViewModel];
        _resultViewController.delegate = self;
    }
    return _resultViewController;
}

- (PPEditViewController *)editViewController {
    if (_editViewController == nil) {
        _editViewController =
            [PPEditViewController viewControllerFromStoryboardInBundle:[PPIdVerifySettings sharedSettings].resourcesBundle];
        _editViewController.viewModel = [self.viewModel createEditViewModel];
        _editViewController.delegate = self;
    }
    return _editViewController;
}

#pragma mark - Animations

- (void)showViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^__nullable)())completion {

    [self addChildViewController:viewController];
    viewController.view.frame = self.view.bounds;
    viewController.view.alpha = 0.0f;
    [self.view insertSubview:viewController.view atIndex:0];
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

- (void)clearViewControllers {

    if (_idScanViewController ) {
        [self dismissViewController:_idScanViewController animated:NO completion:nil];
        _idScanViewController = nil;
    }

    if (_editViewController) {
        [self dismissViewController:_editViewController animated:NO completion:nil];
        _editViewController = nil;
    }

    if (_livenessViewController) {
        [self dismissViewController:_livenessViewController animated:NO completion:nil];
        _livenessViewController = nil;
    }

    if (_resultViewController) {
        [self dismissViewController:_resultViewController animated:NO completion:nil];
        _resultViewController = nil;
    }
}

#pragma mark - ID Scan Configuration

- (void)startIdScanAnimated:(BOOL)animated withCompletion:(void (^__nullable)())completion {
    [self showViewController:self.idScanViewController animated:animated completion:completion];
    [self.delegate idVerifyViewControllerDidStartScanning:self];
    self.state = PPIdVerifyStateScanning;
}

- (void)endIdScanWithAnimated:(BOOL)animated withCompletion:(void (^__nullable)())completion {
    [self dismissViewController:self.idScanViewController animated:animated completion:completion];
}

#pragma mark - Editing Configuration

- (void)startEditingAnimated:(BOOL)animated withCompletion:(void (^__nullable)())completion {
    [self showViewController:self.editViewController animated:animated completion:completion];
    [self.delegate idVerifyViewControllerDidStartEditing:self];
    self.state = PPIdVerifyStateEditing;
}

- (void)endEditingAnimated:(BOOL)animated withCompletion:(void (^__nullable)())completion {
    [self dismissViewController:self.editViewController animated:animated completion:completion];
}

#pragma mark - Liveness Configuration

- (void)startLivenessAnimated:(BOOL)animated withCompletion:(void (^__nullable)())completion {
    [self showViewController:self.livenessViewController animated:animated completion:completion];
    [self.delegate idVerifyViewControllerDidStartLivenessDetection:self];
    self.state = PPIdVerifyStateSelfie;
}

- (void)endLivenessAnimated:(BOOL)animated withCompletion:(void (^__nullable)())completion {
    [self dismissViewController:self.livenessViewController animated:animated completion:completion];
}

#pragma mark - Result Configuration

- (void)startResultAnimated:(BOOL)animated withCompletion:(void (^__nullable)())completion {
    [self showViewController:self.resultViewController animated:animated completion:completion];
    [self.delegate idVerifyViewControllerDidStartResultView:self];
    self.state = PPIdVerifyStateResult;
}

- (void)endResultAnimated:(BOOL)animated withCompletion:(void (^__nullable)())completion {
    [self dismissViewController:self.resultViewController animated:animated completion:completion];
}

#pragma mark - PPIdScanViewControllerDelegate

- (void)idScanViewControllerFinishedScanningFrontSide:(PPIdScanViewController *)idScanViewController {
    [self.delegate idVerifyViewController:self didFinishScanningFrontSideWithResult:self.viewModel.verifyResult];
}

- (void)idScanViewControllerFinished:(PPIdScanViewController *)idScanViewController {

    [self.delegate idVerifyViewController:self didFinishScanningWithResult:self.viewModel.verifyResult];

    [self endIdScanWithAnimated:YES
                 withCompletion:^{
                     [self startEditingAnimated:YES withCompletion:^{
                         [self pauseScanning];
                         [self pauseCamera];
                     }];
                 }];
}

- (void)idScanViewControllerNeedsPauseScanning:(PPIdScanViewController *)idScanViewController {
    [self.containerViewController pauseScanning];
}

- (void)idScanViewControllerNeedsResumeScanning:(PPIdScanViewController *)idScanViewController {
    [self.containerViewController resumeScanningAndResetState:YES];
}

- (void)idScanViewControllerNeedsPauseCamera:(PPIdScanViewController *)idScanViewController {
    [self.containerViewController pauseCamera];
}

- (void)idScanViewControllerNeedsResumeCamera:(PPIdScanViewController *)idScanViewController {
    [self.containerViewController resumeCamera];
}

#pragma mark - PPEditViewControllerDelegate

- (void)editViewControllerStarted:(PPEditViewController *)editViewController {

}

- (void)editViewController:(PPEditViewController *)editViewController editedField:(NSString *)fieldKey oldValue:(NSString *)oldValue newValue:(NSString *)newValue {
    [self.delegate idVerifyViewController:self editedField:fieldKey oldValue:oldValue newValue:newValue];
}

- (void)editViewControllerFinished:(PPEditViewController *)editViewController {

    [self.delegate idVerifyViewController:self didFinishEditingWithResult:self.viewModel.verifyResult];

    [self resumeCamera];
    [self resumeScanning];

    [self endEditingAnimated:YES
              withCompletion:^{
                  [self startLivenessAnimated:YES withCompletion:nil];
              }];
}

- (void)editViewControllerRequiresRepeatedScan:(PPEditViewController *)editViewController {

    [self resumeCamera];
    [self resumeScanning];

    [self endEditingAnimated:YES
              withCompletion:^{
                  [self startIdScanAnimated:YES withCompletion:nil];
              }];
}

#pragma mark - PPLivenessViewControllerDelegate

- (void)livenessViewControllerDidFinish:(PPLivenessViewController *)viewController {

    [self.delegate idVerifyViewController:self didFinishLivenessDetectionWithResult:self.viewModel.verifyResult];

    [self endLivenessAnimated:YES
               withCompletion:^{
                   [self startResultAnimated:YES withCompletion:^{
                       [self pauseScanning];
                       [self pauseCamera];
                   }];
               }];
}

- (void)livenessViewControllerNeedsPauseScanning:(PPLivenessViewController *)viewController {
    [self.containerViewController pauseScanning];
}

- (void)livenessViewControllerNeedsResumeScanning:(PPLivenessViewController *)viewController {
    [self.containerViewController resumeScanningAndResetState:YES];
}

- (void)pauseScanning {
    if (!self.pausedScanning) {
        [self.containerViewController pauseScanning];
        self.pausedScanning = YES;
    }
}

- (void)resumeScanning {
    if (self.pausedScanning) {
        [self.containerViewController resumeScanningAndResetState:YES];
        self.pausedScanning = NO;
    }
}

- (void)pauseCamera {
    if (!self.pausedCamera) {
        [self.containerViewController pauseCamera];
        self.pausedCamera = YES;
    }
}

- (void)resumeCamera {
    if (self.pausedCamera) {
        [self.containerViewController resumeCamera];
        self.pausedCamera = NO;
    }
}

#pragma mark - PPIdResultViewControllerDelegate

- (void)idResultViewControllerRequiresRepeatedScan:(PPIdResultViewController *)resultViewController {

    [self resumeCamera];
    [self resumeScanning];

    [self endResultAnimated:YES withCompletion:^{
        [self startLivenessAnimated:YES withCompletion:nil];
    }];
}

- (void)idResultViewController:(PPIdResultViewController *)resultViewController doVerifyForResult:(PPIdVerifyResult *)result {
    [self.delegate idVerifyViewController:self doVerifyForResult:result];
}

- (void)idResultViewController:(PPIdResultViewController *)resultViewController didFinishWithoutVerification:(PPIdVerifyResult *)result {
    [self.delegate idVerifyViewController:self didFinishWithoutVerification:result];
}

- (void)idResultViewController:(PPIdResultViewController *)resultViewController didFinishWithSuccessfulVerification:(PPIdVerifyResult *)result {
    [self.delegate idVerifyViewController:self didFinishWithSuccessfulVerification:result];
}

#pragma mark - verification method

- (void)idVerifyResult:(PPIdVerifyResult *)result verifiedWithResponse:(PPIdVerifyResponse *)response error:(NSError *)error {
    NSAssert(self.state == PPIdVerifyStateResult, @"In order to process verify result, we need to have result screen on!");
    [self.resultViewController idVerifyResult:result verifiedWithResponse:response error:error];
}

#pragma mark - Instantiation

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle withIdVerifyPreset:(PPIdVerifyPreset)verifyPreset {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPIdVerify" bundle:bundle];
    PPIdVerifyViewController *controller = [storyboard instantiateViewControllerWithIdentifier:[self identifier]];
    
    PPIdVerifyViewModel *viewModel = [[PPIdVerifyViewModel alloc] initWithIdVerifyPreset:verifyPreset];
    controller.viewModel = viewModel;

    return controller;
}

@end
