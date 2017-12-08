//
//  PPIdVerifyViewController.h
//  LivenessTest
//
//  Created by Jura on 01/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdVerifyResult.h"
#import "PPIdVerifyResponse.h"

#import "PPIdVerifyPreset.h"

#import <MicroBlink/MicroBlink.h>

#import <UIKit/UIKit.h>

@class PPIdVerifyViewModel;
@protocol PPIdVerifyViewControllerDelegate;

@interface PPIdVerifyViewController : PPBaseOverlayViewController

@property (nonatomic, readonly) PPIdVerifyViewModel *viewModel;

@property (nonatomic, weak) id<PPIdVerifyViewControllerDelegate> delegate;

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle withIdVerifyPreset:(PPIdVerifyPreset)verifyPreset;

- (void)idVerifyResult:(PPIdVerifyResult *)result verifiedWithResponse:(PPIdVerifyResponse *)response error:(NSError *)error;

@end

@protocol PPIdVerifyViewControllerDelegate <NSObject>

- (void)idVerifyViewControllerDidStartScanning:(PPIdVerifyViewController *)idVerifyViewController;

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishScanningFrontSideWithResult:(PPIdVerifyResult *)result;

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishScanningWithResult:(PPIdVerifyResult *)result;

- (void)idVerifyViewControllerDidStartEditing:(PPIdVerifyViewController *)idVerifyViewController;

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController editedField:(NSString *)fieldKey oldValue:(NSString *)oldValue newValue:(NSString *)newValue;

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishEditingWithResult:(PPIdVerifyResult *)result;

- (void)idVerifyViewControllerDidStartLivenessDetection:(PPIdVerifyViewController *)idVerifyViewController;

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishLivenessDetectionWithResult:(PPIdVerifyResult *)result;

- (void)idVerifyViewControllerDidStartResultView:(PPIdVerifyViewController *)idVerifyViewController;

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController doVerifyForResult:(PPIdVerifyResult *)result;

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishWithoutVerification:(PPIdVerifyResult *)result;

- (void)idVerifyViewController:(PPIdVerifyViewController *)idVerifyViewController didFinishWithSuccessfulVerification:(PPIdVerifyResult *)result;

@end
