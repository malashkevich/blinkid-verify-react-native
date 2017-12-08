//
//  PPEditViewModel.m
//  IDVerifyFramework
//
//  Created by Jura on 10/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPEditViewModel.h"

@interface PPEditViewModel ()

@end

@implementation PPEditViewModel

- (instancetype)initWithVerifyResult:(PPIdVerifyResult *)verifyResult viewPopulator:(PPIdResultViewPopulator *)viewPopulator {
    self = [super init];
    if (self) {
        _verifyResult = verifyResult;
        _viewPopulator = viewPopulator;
    }
    return self;
}

@end
