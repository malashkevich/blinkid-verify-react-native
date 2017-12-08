//
//  PPCroatiaIdScanConfigurator.m
//  LivenessTest
//
//  Created by Jura on 02/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPCroatiaIdScanConfigurator.h"

#import "PPCroatiaIdVerifyResult.h"
#import "PPCroatiaIdVerifyResult+Updates.h"

@implementation PPCroatiaIdScanConfigurator

- (void)configureNextStepForVerifyResult:(PPIdVerifyResult *)verifyResult {

    if (![verifyResult isKindOfClass:[PPCroatiaIdVerifyResult class]]) {
        return;
    }

    PPCroatiaIdVerifyResult *croatiaVerifyResult = (PPCroatiaIdVerifyResult *)verifyResult;

    switch (self.scanningState) {
        case PPScanningStateUndefined:
            [self configureScan];
            break;
        case PPScanningStateIdFrontSide:
        case PPScanningStateIdBackSide:
            if ([croatiaVerifyResult hasAllDataInResult]) {
                if ([croatiaVerifyResult hasMatchingData]) {
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

    PPCroIDCombinedRecognizerSettings *combinedSettings = [[PPCroIDCombinedRecognizerSettings alloc] init];

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
