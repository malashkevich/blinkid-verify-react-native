//
//  PPMrtdScanConfigurator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 06/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPMrtdScanConfigurator.h"

#import "PPMrtdVerifyResult.h"
#import "PPMrtdVerifyResult+Updates.h"

@implementation PPMrtdScanConfigurator

- (void)configureNextStepForVerifyResult:(PPIdVerifyResult *)verifyResult {
    
    if (![verifyResult isKindOfClass:[PPMrtdVerifyResult class]]) {
        return;
    }
    
    PPMrtdVerifyResult *mrtdVerifyResult = (PPMrtdVerifyResult *)verifyResult;
    
    switch (self.scanningState) {
        case PPScanningStateUndefined:
            [self configureScan];
            break;
        case PPScanningStateIdFrontSide:
        case PPScanningStateIdBackSide:
            if ([mrtdVerifyResult hasAllDataInResult]) {
                if ([mrtdVerifyResult hasMatchingData]) {
                    [self finishScanning];
                } else {
                    [self reportNonMatchingData];
                }
            }
            break;
        case PPScanningStateNonMatchingData:
            break;
        case PPScanningStateDone:
            NSAssert(NO, @"Invalid scanning state %@", @(self.scanningState));
            break;
    }
}

- (void)configureScan {
    
    for (PPRecognizerSettings *settings in self.coordinator.currentSettings.scanSettings.recognizerSettingsList) {
        [self.coordinator.currentSettings.scanSettings removeRecognizerSettings:settings];
    }
    
    PPMrtdCombinedRecognizerSettings *combinedSettings = [[PPMrtdCombinedRecognizerSettings alloc] init];
    
    combinedSettings.returnFacePhoto = YES;
    combinedSettings.encodeFullDocumentPhoto = YES;
    combinedSettings.encodeFacePhoto = YES;
    combinedSettings.shouldSignData = YES;
    
    [self.coordinator.currentSettings.scanSettings addRecognizerSettings:combinedSettings];
    
    self.coordinator.currentSettings.cameraSettings.cameraType = PPCameraTypeBack;
    self.coordinator.currentSettings.cameraSettings.cameraMirroredVertically = NO;
    self.coordinator.currentSettings.cameraSettings.cameraMirroredHorizontally = NO;
    
    [self.coordinator applySettings];
    
    _scanningState = PPScanningStateIdFrontSide;
    
    [self.delegate idScanConfigurator:self didChangeStateTo:self.scanningState from:PPScanningStateUndefined];
}

- (void)finishScanning {
    _scanningState = PPScanningStateDone;
    
    [self.delegate idScanConfigurator:self didChangeStateTo:self.scanningState from:PPScanningStateIdBackSide];
}

- (void)reportNonMatchingData {
    _scanningState = PPScanningStateNonMatchingData;
    
    [self.delegate idScanConfigurator:self didChangeStateTo:self.scanningState from:PPScanningStateIdBackSide];
}


@end
