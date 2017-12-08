//
//  PPIdVerifyViewModel.h
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdScanViewModel.h"
#import "PPLivenessViewModel.h"
#import "PPIdResultViewModel.h"
#import "PPEditViewModel.h"
#import "PPIdVerifyResult.h"
#import "PPIdVerifyPreset.h"

#import <MicroBlink/MicroBlink.h>

#import <Foundation/Foundation.h>

@interface PPIdVerifyViewModel : NSObject

@property (nonatomic, readonly) PPCameraCoordinator *coordinator;

@property (nonatomic, readonly) PPIdVerifyResult *verifyResult;

- (void)reset;

- (void)setDummyResult;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithIdVerifyPreset:(PPIdVerifyPreset)verifyPreset NS_DESIGNATED_INITIALIZER;

#pragma mark - child view models

- (PPIdScanViewModel *)createIdScanViewModel;

- (PPLivenessViewModel *)createLivenessViewModel;

- (PPIdResultViewModel *)createIdResultViewModel;

- (PPEditViewModel *)createEditViewModel;

@end
