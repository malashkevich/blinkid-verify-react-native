//
//  PPGermanyIdScanConfigurator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 29/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPGermanyIdScanConfigurator.h"

#import "PPGermanyIdVerifyResult.h"
#import "PPGermanyIdVerifyResult+Updates.h"

@implementation PPGermanyIdScanConfigurator

- (void)configureNextStepForVerifyResult:(PPIdVerifyResult *)verifyResult {

    if (![verifyResult isKindOfClass:[PPGermanyIdVerifyResult class]]) {
        return;
    }

    PPGermanyIdVerifyResult *germanyVerifyResult = (PPGermanyIdVerifyResult *)verifyResult;

    switch (self.scanningState) {
        case PPScanningStateUndefined:
            [self configureScan];
            break;
        case PPScanningStateIdFrontSide:
        case PPScanningStateIdBackSide:
            if ([germanyVerifyResult hasAllDataInResult]) {
                if ([germanyVerifyResult hasMatchingData]) {
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

    PPGermanIDCombinedRecognizerSettings *combinedSettings = [[PPGermanIDCombinedRecognizerSettings alloc] init];

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
