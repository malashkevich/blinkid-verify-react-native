//
//  PPSingaporeIdScanConfigurator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSingaporeIdScanConfigurator.h"

#import "PPSingaporeIdVerifyResult.h"
#import "PPSingaporeIdVerifyResult+Updates.h"

@implementation PPSingaporeIdScanConfigurator

- (void)configureNextStepForVerifyResult:(PPIdVerifyResult *)verifyResult {
    
    if (![verifyResult isKindOfClass:[PPSingaporeIdVerifyResult class]]) {
        return;
    }
    
    PPSingaporeIdVerifyResult *singaporeVerifyResult = (PPSingaporeIdVerifyResult *)verifyResult;
    
    switch (self.scanningState) {
        case PPScanningStateUndefined:
            [self configureScan];
            break;
        case PPScanningStateIdFrontSide:
        case PPScanningStateIdBackSide:
            if ([singaporeVerifyResult hasAllDataInResult]) {
                if ([singaporeVerifyResult hasMatchingData]) {
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
    
    PPSingaporeIDCombinedRecognizerSettings *combinedSettings = [[PPSingaporeIDCombinedRecognizerSettings alloc] init];
    
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
