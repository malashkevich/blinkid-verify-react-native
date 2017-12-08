//
//  PPIdScanConfigurator.m
//  LivenessTest
//
//  Created by Jura on 02/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdScanConfigurator.h"

@implementation PPIdScanConfigurator

- (instancetype)initWithCoordinator:(PPCameraCoordinator *)coordinator {
    self = [super init];
    if (self) {
        _coordinator = coordinator;
        _scanningState = PPScanningStateUndefined;
    }
    return self;
}

- (void)configureNextStepForVerifyResult:(PPIdVerifyResult *)verifyResult {
}

- (void)resetState {
    _scanningState = PPScanningStateUndefined;
}

@end
