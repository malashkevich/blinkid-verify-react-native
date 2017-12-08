//
//  PPStringConfusion.m
//  IDVerifyFramework
//
//  Created by Jura on 31/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPStringConfusion.h"

@implementation PPStringConfusion

- (instancetype)initWithOriginalString:(NSString *)originalString
                                 range:(NSRange)range
                          currentValue:(NSString *)currentValue
                            confusions:(NSArray<NSString *> *)confusions {
    self = [super init];
    if (self) {
        _originalString = originalString;
        _range = range;
        _currentValue = currentValue;
        _confusions = confusions;
    }
    return self;
}

@end
