//
//  PPIdScanViewModel.m
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdScanViewModel.h"

#import "PPIdVerifyResult+Updates.h"
#import "PPIdVerifySettings.h"

@interface PPIdScanViewModel () <PPIdScanConfiguratorDelegate>

@property (nonatomic) PPIdScanConfigurator *scanConfigurator;

@property (nonatomic) PPIdVerifyResult *verifyResult;

@end

@implementation PPIdScanViewModel

- (instancetype)initWithScanConfigurator:(PPIdScanConfigurator *)scanConfigurator verifyResult:(PPIdVerifyResult *)verifyResult {
    self = [super init];
    if (self) {
        _scanConfigurator = scanConfigurator;
        _scanConfigurator.delegate = self;
        _verifyResult = verifyResult;
    }
    return self;
}

- (void)resetScanResult {
    [self.verifyResult clear];
    [self.scanConfigurator resetState];
    [self.scanConfigurator configureNextStepForVerifyResult:self.verifyResult];
}

- (void)addImageMetadata:(PPImageMetadata *)imageMetadata {
    [self.verifyResult addImageMetadata:imageMetadata];

    [self.scanConfigurator configureNextStepForVerifyResult:self.verifyResult];
}

- (void)addRecognizerResult:(PPRecognizerResult *)recognizerResult {
    [self.verifyResult addRecognizerResult:recognizerResult];

    [self.scanConfigurator configureNextStepForVerifyResult:self.verifyResult];
}

- (BOOL)shouldShowInstructions {
    return ![[PPIdVerifySettings sharedSettings].uiSettings areInstructionPresented];
}

#pragma mark - PPIdScanConfiguratorDelegate

- (void)idScanConfigurator:(PPIdScanConfigurator *)configurator didChangeStateTo:(PPScanningState)newState from:(PPScanningState)oldState {
    [self.delegate idScanViewModel:self didChangeStateTo:newState from:oldState];
}

@end
