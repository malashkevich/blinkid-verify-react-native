//
//  PPIdVerify.m
//  IDVerifyFramework
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdVerify.h"

#import "PPIdVerifySettings.h"

@interface PPIdVerify () <PPIdVerifyContainerViewControllerDelegate>
@end

@implementation PPIdVerify

- (void)setVerifyContainerViewController:(PPIdVerifyContainerViewController *)verifyContainerViewController {
    _verifyContainerViewController = verifyContainerViewController;
    _verifyContainerViewController.delegate = self;
}

- (void)idVerifyResult:(PPIdVerifyResult *)result verifiedWithResponse:(PPIdVerifyResponse *)response error:(nullable NSError *)error {
    NSAssert(_verifyContainerViewController != nil, @"verifyContainerViewController should never be nil");
    [self.verifyContainerViewController idVerifyResult:result verifiedWithResponse:response error:error];
}

#pragma mark - PPIdVerifyContainerViewControllerDelegate

- (void)idVerifyContainerViewControllerDidLoadView:(PPIdVerifyContainerViewController *)viewController {
    [self.delegate idVerify:self didLoadContainerViewController:viewController];
}

- (void)idVerifyContainerViewControllerDidStartScanning:(PPIdVerifyContainerViewController *)viewController {
    [self.delegate idVerifyDidStartScanning:self];
}

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController didFinishScanningFrontSideWithResult:(PPIdVerifyResult *)result {
    [self.delegate idVerify:self didFinishScanningFrontSideWithResult:result];
}

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController didFinishScanningWithResult:(PPIdVerifyResult *)result {
    [self.delegate idVerify:self didFinishScanningWithResult:result];
}

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController editedField:(NSString *)fieldKey oldValue:(NSString *)oldValue newValue:(NSString *)newValue {
    [self.delegate idVerify:self editedField:fieldKey oldValue:oldValue newValue:newValue];
}

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController  didFinishEditingWithResult:(PPIdVerifyResult *)result {
    [self.delegate idVerify:self didFinishEditingWithResult:result];
}

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController didFinishLivenessWithResult:(PPIdVerifyResult *)result {
    [self.delegate idVerify:self didFinishLivenessWithResult:result];
}

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController doVerifyForResult:(PPIdVerifyResult *)result {
    [self.delegate idVerify:self doVerifyForResult:result];
}

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController
           didFinishWithoutVerification:(PPIdVerifyResult *)result {
    [self.delegate idVerify:self didFinishWithoutVerification:result];
}

- (void)idVerifyContainerViewController:(PPIdVerifyContainerViewController *)viewController
    didFinishWithSuccessfulVerification:(PPIdVerifyResult *)result {
    
    [self.delegate idVerify:self didFinishWithSuccessfulVerification:result];
}

@end
