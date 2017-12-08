//
//  PPIdVerify.h
//  IDVerifyFramework
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdVerifyViewController.h"
#import "PPIdVerifyResult.h"
#import "PPIdVerifyContainerViewController.h"
#import "PPIdVerifyPreset.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PPIdVerifyDelegate;

@interface PPIdVerify : NSObject

@property (nonatomic, weak) id<PPIdVerifyDelegate> delegate;

@property (nonatomic) PPIdVerifyContainerViewController *verifyContainerViewController;

@property (nonatomic, readonly) PPIdVerifyPreset verifyPreset;

- (void)setVerifyContainerViewController:(PPIdVerifyContainerViewController *)verifyContainerViewController;

- (void)idVerifyResult:(PPIdVerifyResult *)result verifiedWithResponse:(PPIdVerifyResponse *)response error:(nullable NSError *)error;

@end


@protocol PPIdVerifyDelegate <NSObject>

- (void)idVerify:(PPIdVerify *)idVerify didLoadContainerViewController:(PPIdVerifyContainerViewController *)containerViewController;

- (void)idVerifyDidStartScanning:(PPIdVerify *)idVerify;

- (void)idVerify:(PPIdVerify *)idVerify didFinishScanningFrontSideWithResult:(PPIdVerifyResult *)result;

- (void)idVerify:(PPIdVerify *)idVerify editedField:(NSString *)fieldKey oldValue:(NSString *)oldValue newValue:(NSString *)newValue;

- (void)idVerify:(PPIdVerify *)idVerify didFinishScanningWithResult:(PPIdVerifyResult *)result;

- (void)idVerify:(PPIdVerify *)idVerify didFinishEditingWithResult:(PPIdVerifyResult *)result;

- (void)idVerify:(PPIdVerify *)idVerify didFinishLivenessWithResult:(PPIdVerifyResult *)result;

- (void)idVerify:(PPIdVerify *)idVerify doVerifyForResult:(PPIdVerifyResult *)result;

- (void)idVerify:(PPIdVerify *)idVerify didFinishWithoutVerification:(PPIdVerifyResult *)result;

- (void)idVerify:(PPIdVerify *)idVerify didFinishWithSuccessfulVerification:(PPIdVerifyResult *)result;

@end

NS_ASSUME_NONNULL_END
