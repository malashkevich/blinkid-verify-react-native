//
//  PPIdResultViewModel.h
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdVerifyResult.h"
#import "PPIdResultViewPopulator.h"
#import "PPIdVerifyResponse.h"

#import <MicroBlink/MicroBlink.h>

#import <Foundation/Foundation.h>

@protocol PPIdResultViewModelDelegate;

@interface PPIdResultViewModel : NSObject

@property (nonatomic, readonly) PPIdVerifyResult *verifyResult;

@property (nonatomic, readonly) PPIdVerifyResponse *verifyResponse;

@property (nonatomic, readonly) NSError *verifyResponseError;

@property (nonatomic, readonly) PPIdResultViewPopulator *viewPopulator;

@property (nonatomic, weak) id<PPIdResultViewModelDelegate> delegate;

@property (nonatomic, readonly) BOOL livenessFailed;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithVerifyResult:(PPIdVerifyResult *)verifyResult viewPopulator:(PPIdResultViewPopulator *)viewPopulator;

@end

@protocol PPIdResultViewModelDelegate

@end
