//
//  PPLivenessViewModel.m
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPLivenessViewModel.h"

#import "PPIdVerifySettings.h"
#import "PPIdVerifyResult+Updates.h"

@interface PPLivenessViewModel ()

@property (nonatomic) PPCameraCoordinator *coordinator;

@property (nonatomic) PPIdVerifyResult *verifyResult;

@end

@implementation PPLivenessViewModel

- (instancetype)initWithCoordinator:(PPCameraCoordinator *)coordinator verifyResult:(PPIdVerifyResult *)verifyResult {
    self = [super init];
    if (self) {
        _coordinator = coordinator;
        _verifyResult = verifyResult;
    }
    return self;
}

- (void)configureCoordinator {

    for (PPRecognizerSettings *settings in self.coordinator.currentSettings.scanSettings.recognizerSettingsList) {
        [self.coordinator.currentSettings.scanSettings removeRecognizerSettings:settings];
    }

    PPLivenessRecognizerSettings *livenessSettings = [[PPLivenessRecognizerSettings alloc] initWithLicenseKey:[PPIdVerifySettings sharedSettings].livenessLicenseKey];

    // we're assuming resources bundle is in the root of the main bundle
    NSString *bundlePath = [[PPIdVerifySettings sharedSettings].resourcesBundle resourcePath];
    NSString *resourcesPath = [NSString stringWithFormat:@"%@/%@", [bundlePath lastPathComponent], @"Facial Features Tracker - High.cfg"];
    [livenessSettings setResourcePath:resourcesPath];

    livenessSettings.numMsBeforeTimeout = 30000;
    livenessSettings.returnFacePhoto = YES;
    livenessSettings.encodeFacePhoto = YES;

    [self.coordinator.currentSettings.scanSettings addRecognizerSettings:livenessSettings];

    self.coordinator.currentSettings.cameraSettings.cameraType = PPCameraTypeFront;
    self.coordinator.currentSettings.cameraSettings.cameraMirroredHorizontally = YES;

    self.coordinator.currentSettings.metadataSettings = [[PPMetadataSettings alloc] init];
    self.coordinator.currentSettings.metadataSettings.dewarpedImage = YES;

    [self.coordinator applySettings];
}

- (void)addImageMetadata:(PPImageMetadata *)imageMetadata {
    [self.verifyResult addImageMetadata:imageMetadata];
}

- (void)addRecognizerResult:(PPRecognizerResult *)recognizerResult {
    [self.verifyResult addRecognizerResult:recognizerResult];
}

- (BOOL)shouldLivenessInstructions {
    return ![[PPIdVerifySettings sharedSettings].uiSettings areInstructionPresented];
}

- (void)setInstructionsPresented {
    [[PPIdVerifySettings sharedSettings].uiSettings setInstructionsPresented:YES];
}

@end
