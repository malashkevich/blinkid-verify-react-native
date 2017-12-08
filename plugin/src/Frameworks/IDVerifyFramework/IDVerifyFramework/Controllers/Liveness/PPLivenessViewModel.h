//
//  PPLivenessViewModel.h
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdVerifyResult.h"

#import <MicroBlink/MicroBlink.h>

#import <Foundation/Foundation.h>

@interface PPLivenessViewModel : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCoordinator:(PPCameraCoordinator *)coordinator verifyResult:(PPIdVerifyResult *)verifyResult;

- (void)configureCoordinator;

- (void)addImageMetadata:(PPImageMetadata *)imageMetadata;

- (void)addRecognizerResult:(PPRecognizerResult *)recognizerResult;

- (BOOL)shouldLivenessInstructions;

- (void)setInstructionsPresented;

@end
