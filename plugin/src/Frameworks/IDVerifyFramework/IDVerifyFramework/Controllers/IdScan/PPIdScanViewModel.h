//
//  PPIdScanViewModel.h
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdScanConfigurator.h"
#import "PPScanningState.h"
#import "PPIdVerifyResult.h"

#import <Foundation/Foundation.h>

@protocol PPIdScanViewModelDelegate;


@interface PPIdScanViewModel : NSObject

@property (nonatomic, weak) id<PPIdScanViewModelDelegate> delegate;

- (instancetype)initWithScanConfigurator:(PPIdScanConfigurator *)scanConfigurator verifyResult:(PPIdVerifyResult *)verifyResult;

- (void)resetScanResult;

- (void)addImageMetadata:(PPImageMetadata *)imageMetadata;

- (void)addRecognizerResult:(PPRecognizerResult *)recognizerResult;

- (BOOL)shouldShowInstructions;

@end


@protocol PPIdScanViewModelDelegate

- (void)idScanViewModel:(PPIdScanViewModel *)viewModel didChangeStateTo:(PPScanningState)newState from:(PPScanningState)oldState;

@end
