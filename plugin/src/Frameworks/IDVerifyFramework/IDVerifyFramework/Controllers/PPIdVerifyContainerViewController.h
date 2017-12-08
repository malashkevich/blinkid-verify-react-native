//
//  PPIdVerifyContainerViewController.h
//  IDVerifyFramework
//
//  Created by Jura on 09/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <MicroBlink/MicroBlink.h>

#import "PPIdVerifyViewController.h"
#import "PPIdVerifyPreset.h"

#import <UIKit/UIKit.h>

@protocol PPIdVerifyContainerViewControllerDelegate;


@interface PPIdVerifyContainerViewController : UIViewController <PPIdVerifyViewControllerDelegate>

@property (nonatomic, weak) id<PPIdVerifyContainerViewControllerDelegate> delegate;

@property (nonatomic) UIView *containerView;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithIdVerifyPreset:(PPIdVerifyPreset)verifyPreset;

- (void)idVerifyResult:(PPIdVerifyResult *)result verifiedWithResponse:(PPIdVerifyResponse *)response error:(NSError *)error;

+ (instancetype)verifyContainerViewControllerForCountryPreset:(PPIdVerifyPreset)verifyPreset;

@end


@protocol PPIdVerifyContainerViewControllerDelegate

- (void)idVerifyContainerViewControllerDidLoadView:(PPIdVerifyContainerViewController *)viewController;

#pragma mark - PPIdVerifyViewControllerDelegate

- (void)idVerifyContainerViewControllerDidStartScanning:(PPIdVerifyContainerViewController *)viewController;

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController
    didFinishScanningFrontSideWithResult:(PPIdVerifyResult *)result;

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController
            didFinishScanningWithResult:(PPIdVerifyResult *)result;

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController
                            editedField:(NSString *)fieldKey
                               oldValue:(NSString *)oldValue
                               newValue:(NSString *)newValue;

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController
             didFinishEditingWithResult:(PPIdVerifyResult *)result;

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController
            didFinishLivenessWithResult:(PPIdVerifyResult *)result;

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController doVerifyForResult:(PPIdVerifyResult *)result;

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController
           didFinishWithoutVerification:(PPIdVerifyResult *)result;

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController
    didFinishWithSuccessfulVerification:(PPIdVerifyResult *)result;

@end
