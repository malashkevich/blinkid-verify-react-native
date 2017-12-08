//
//  PPIdResultViewModel.m
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdResultViewModel.h"

#import "PPIdVerifyClient.h"

#import "NSDictionary+Utils.h"

@interface PPIdResultViewModel ()

@property (nonatomic) PPIdVerifyClient *idVerifyClient;

@end

@implementation PPIdResultViewModel

- (instancetype)initWithVerifyResult:(PPIdVerifyResult *)verifyResult viewPopulator:(PPIdResultViewPopulator *)viewPopulator {
    self = [super init];
    if (self) {
        _verifyResult = verifyResult;
        _viewPopulator = viewPopulator;
        _idVerifyClient = [[PPIdVerifyClient alloc] initWithUrl:[NSURL URLWithString:@"https://blinkid-verify-test.microblink.com"]];
    }
    return self;
}

- (BOOL)livenessFailed {
    return !self.verifyResult.alive || (self.verifyResult.viewResult.selfieImage == nil) || (self.verifyResult.viewResult.faceImage == nil);
}

@end
