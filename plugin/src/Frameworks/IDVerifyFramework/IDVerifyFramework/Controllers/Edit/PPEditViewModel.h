//
//  PPEditViewModel.h
//  IDVerifyFramework
//
//  Created by Jura on 10/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdVerifyResult.h"
#import "PPIdResultViewPopulator.h"

#import <Foundation/Foundation.h>

@interface PPEditViewModel : NSObject

@property (nonatomic, readonly) PPIdResultViewPopulator *viewPopulator;

@property (nonatomic, readonly) PPIdVerifyResult *verifyResult;

- (instancetype)initWithVerifyResult:(PPIdVerifyResult *)verifyResult viewPopulator:(PPIdResultViewPopulator *)viewPopulator;

@end
