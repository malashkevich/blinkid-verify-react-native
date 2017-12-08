//
//  PPIdVerifyViewModel.m
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdVerifyViewModel.h"

#import "PPCroatiaIdScanConfigurator.h"
#import "PPCroatiaIdVerifyResult.h"
#import "PPCroatiaIdResultViewPopulator.h"

#import "PPGermanyIdScanConfigurator.h"
#import "PPGermanyIdVerifyResult.h"
#import "PPGermanyIdResultViewPopulator.h"

#import "PPAustriaIdScanConfigurator.h"
#import "PPAustriaIdVerifyResult.h"
#import "PPAustriaIdResultViewPopulator.h"

#import "PPCzechIdScanConfigurator.h"
#import "PPCzechIdVerifyResult.h"
#import "PPCzechIdResultViewPopulator.h"

#import "PPSerbiaIdScanConfigurator.h"
#import "PPSerbiaIdVerifyResult.h"
#import "PPSerbiaIdResultViewPopulator.h"

#import "PPSingaporeIdScanConfigurator.h"
#import "PPSingaporeIdVerifyResult.h"
#import "PPSingaporeIdResultViewPopulator.h"

#import "PPSlovakiaIdScanConfigurator.h"
#import "PPSlovakiaIdVerifyResult.h"
#import "PPSlovakiaIdResultViewPopulator.h"

#import "PPSloveniaIdScanConfigurator.h"
#import "PPSloveniaIdVerifyResult.h"
#import "PPSloveniaIdResultViewPopulator.h"

#import "PPUsdlScanConfigurator.h"
#import "PPUsdlVerifyResult.h"
#import "PPUsdlResultViewPopulator.h"

#import "PPMrtdScanConfigurator.h"
#import "PPMrtdVerifyResult.h"
#import "PPMrtdResultViewPopulator.h"

#import "PPIdVerifySettings.h"

#import "NSDictionary+Utils.h"

#import "PPCroIDCombinedRecognizerResult+Test.h"
#import "PPLivenessRecognizerResult+Test.h"
#import "PPIdVerifyResult+Updates.h"

@interface PPCoordinatorSingleton : NSObject

@property (nonatomic) PPCameraCoordinator *coordinator;

+ (instancetype)sharedCoordinatorSingleton;

@end

@implementation PPCoordinatorSingleton

- (instancetype)init {
    self = [super init];

    if (self) {
        PPSettings *settings = [[PPSettings alloc] init];
        settings.licenseSettings.licenseKey = [PPIdVerifySettings sharedSettings].licenseKey;
        settings.licenseSettings.licensee = [PPIdVerifySettings sharedSettings].licensee;
        settings.metadataSettings.dewarpedImage = YES;
        _coordinator = [[PPCameraCoordinator alloc] initWithSettings:settings];
    }

    return self;
}

- (void)resetSettings {
    PPSettings *settings = [[PPSettings alloc] init];
    settings.licenseSettings.licenseKey = [PPIdVerifySettings sharedSettings].licenseKey;
    settings.metadataSettings.dewarpedImage = YES;
    settings.scanSettings.partialRecognitionTimeout = 0.0f;
    _coordinator.currentSettings = settings;
    [_coordinator applySettings];
}

+ (instancetype)sharedCoordinatorSingleton {
    static PPCoordinatorSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end

@interface PPIdVerifyViewModel ()

@property (nonatomic, readonly) PPIdVerifyPreset preset;

@end

@implementation PPIdVerifyViewModel

- (instancetype)initWithIdVerifyPreset:(PPIdVerifyPreset)verifyPreset {
    self = [super init];

    if (self) {
        [[PPCoordinatorSingleton sharedCoordinatorSingleton] resetSettings];

        _coordinator = [PPCoordinatorSingleton sharedCoordinatorSingleton].coordinator;
        _preset = verifyPreset;
        _verifyResult = [PPIdVerifyViewModel resultForPreset:_preset];
    }

    return self;
}

- (void)reset {
    [_verifyResult clear];
}

- (PPIdScanViewModel *)createIdScanViewModel {
    PPIdScanViewModel *idScanViewModel = [[PPIdScanViewModel alloc]
        initWithScanConfigurator:[PPIdVerifyViewModel configuratorForPreset:self.preset coordinator:self.coordinator]
                    verifyResult:self.verifyResult];

    return idScanViewModel;
}


- (PPLivenessViewModel *)createLivenessViewModel {
    PPLivenessViewModel *livenessViewModel =
        [[PPLivenessViewModel alloc] initWithCoordinator:self.coordinator verifyResult:self.verifyResult];
    return livenessViewModel;
}

- (PPIdResultViewModel *)createIdResultViewModel {
    PPIdResultViewModel *idResultViewModel =
        [[PPIdResultViewModel alloc] initWithVerifyResult:self.verifyResult
                                            viewPopulator:[PPIdVerifyViewModel populatorForPreset:self.preset]];
    return idResultViewModel;
}

- (PPEditViewModel *)createEditViewModel {
    PPEditViewModel *editViewModel =
        [[PPEditViewModel alloc] initWithVerifyResult:self.verifyResult viewPopulator:[PPIdVerifyViewModel populatorForPreset:self.preset]];
    return editViewModel;
}

#pragma mark - factory methods

+ (PPIdVerifyResult *)resultForPreset:(PPIdVerifyPreset)preset {
    switch (preset) {
        case PPIdVerifyPresetAustria:
            return [[PPAustriaIdVerifyResult alloc] init];
        case PPIdVerifyPresetCroatia:
            return [[PPCroatiaIdVerifyResult alloc] init];
        case PPIdVerifyPresetCzech:
            return [[PPCzechIdVerifyResult alloc] init];
        case PPIdVerifyPresetGermany:
            return [[PPGermanyIdVerifyResult alloc] init];
        case PPIdVerifyPresetSerbia:
            return [[PPSerbiaIdVerifyResult alloc] init];
        case PPIdVerifyPresetSingapore:
            return [[PPSingaporeIdVerifyResult alloc] init];
        case PPIdVerifyPresetSlovakia:
            return [[PPSlovakiaIdVerifyResult alloc] init];
        case PPIdVerifyPresetSlovenia:
            return [[PPSloveniaIdVerifyResult alloc] init];
        case PPIdVerifyPresetUsdl:
            return [[PPUsdlVerifyResult alloc] init];
        case PPIdVerifyPresetMrtd:
            return [[PPMrtdVerifyResult alloc] init];
    }
}

+ (PPIdScanConfigurator *)configuratorForPreset:(PPIdVerifyPreset)preset coordinator:(PPCameraCoordinator *)coordinator {
    switch (preset) {
        case PPIdVerifyPresetAustria:
            return [[PPAustriaIdScanConfigurator alloc] initWithCoordinator:coordinator];
        case PPIdVerifyPresetCroatia:
            return [[PPCroatiaIdScanConfigurator alloc] initWithCoordinator:coordinator];
        case PPIdVerifyPresetCzech:
            return [[PPCzechIdScanConfigurator alloc] initWithCoordinator:coordinator];
        case PPIdVerifyPresetGermany:
            return [[PPGermanyIdScanConfigurator alloc] initWithCoordinator:coordinator];
        case PPIdVerifyPresetSerbia:
            return [[PPSerbiaIdScanConfigurator alloc] initWithCoordinator:coordinator];
        case PPIdVerifyPresetSingapore:
            return [[PPSingaporeIdScanConfigurator alloc] initWithCoordinator:coordinator];
        case PPIdVerifyPresetSlovakia:
            return [[PPSlovakiaIdScanConfigurator alloc] initWithCoordinator:coordinator];
        case PPIdVerifyPresetSlovenia:
            return [[PPSloveniaIdScanConfigurator alloc] initWithCoordinator:coordinator];
        case PPIdVerifyPresetUsdl:
            return [[PPUsdlScanConfigurator alloc] initWithCoordinator:coordinator];
        case PPIdVerifyPresetMrtd:
            return [[PPMrtdScanConfigurator alloc] initWithCoordinator:coordinator];
    }
    return nil;
}

+ (PPIdResultViewPopulator *)populatorForPreset:(PPIdVerifyPreset)preset {
    switch (preset) {
        case PPIdVerifyPresetAustria:
            return [[PPAustriaIdResultViewPopulator alloc] init];
        case PPIdVerifyPresetCroatia:
            return [[PPCroatiaIdResultViewPopulator alloc] init];
        case PPIdVerifyPresetCzech:
            return [[PPCzechIdResultViewPopulator alloc] init];
        case PPIdVerifyPresetGermany:
            return [[PPGermanyIdResultViewPopulator alloc] init];
        case PPIdVerifyPresetSerbia:
            return [[PPSerbiaIdResultViewPopulator alloc] init];
        case PPIdVerifyPresetSingapore:
            return [[PPSingaporeIdResultViewPopulator alloc] init];
        case PPIdVerifyPresetSlovakia:
            return [[PPSlovakiaIdResultViewPopulator alloc] init];
        case PPIdVerifyPresetSlovenia:
            return [[PPSloveniaIdResultViewPopulator alloc] init];
        case PPIdVerifyPresetUsdl:
            return [[PPUsdlResultViewPopulator alloc] init];
        case PPIdVerifyPresetMrtd:
            return [[PPMrtdResultViewPopulator alloc] init];
    }
    return nil;
}

- (void)setDummyResult {
    [_verifyResult clear];

    [_verifyResult addRecognizerResult:[PPCroIDCombinedRecognizerResult emirResult]];
    [_verifyResult addRecognizerResult:[PPLivenessRecognizerResult realSignatureResult]];
}

#pragma mark - Instructions

- (BOOL)shouldShowScanInstructions {
    return YES;
}

- (BOOL)shouldShowSelfieInstructions {
    return YES;
}

@end
