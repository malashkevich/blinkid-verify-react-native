//
//  PPIdScanConfigurator.h
//  LivenessTest
//
//  Created by Jura on 02/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MicroBlink/MicroBlink.h>

#import "PPIdVerifyResult.h"
#import "PPScanningState.h"

@protocol PPIdScanConfiguratorDelegate;

@interface PPIdScanConfigurator : NSObject {

@protected
    PPScanningState _scanningState;
}

@property (nonatomic, readonly) PPCameraCoordinator *coordinator;

@property (nonatomic, readonly) PPScanningState scanningState;

@property (nonatomic, weak) id<PPIdScanConfiguratorDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCoordinator:(PPCameraCoordinator *)coordinator NS_DESIGNATED_INITIALIZER;

- (void)configureNextStepForVerifyResult:(PPIdVerifyResult *)verifyResult;

- (void)resetState;

@end


@protocol PPIdScanConfiguratorDelegate <NSObject>

- (void)idScanConfigurator:(PPIdScanConfigurator *)configurator didChangeStateTo:(PPScanningState)newState from:(PPScanningState)oldState;

@end
