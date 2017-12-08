//
//  PPKeyboardViewModel.m
//  IDVerifyFramework
//
//  Created by Jura on 30/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPKeyboardViewModel.h"

@interface PPKeyboardViewModel ()

@end

@implementation PPKeyboardViewModel

- (instancetype)initWithValue:(NSString *)value confusions:(PPKeyboardConfusions *)confusions {
    self = [super init];
    if (self) {
        _value = value;
        _result = value;
        _confusions = confusions;
        _stringConfusions = [_confusions getStringConfusionsForText:value];
        _currentConfusionIndex = 0;
    }
    return self;
}

- (PPStringConfusion *)currentConfusion {
    return [self.stringConfusions objectAtIndex:self.currentConfusionIndex];
}

- (BOOL)isFirstCofusion {
    return self.currentConfusionIndex == 0;
}

- (BOOL)isLastConfusion {
    return self.currentConfusionIndex >= self.stringConfusions.count - 1;
}

- (void)moveToNextConfusion {
    _currentConfusionIndex++;
}

- (void)moveToPreviousConfusion {
    _currentConfusionIndex--;
}

- (void)moveToConfusionAtIndex:(NSUInteger)index {
    NSAssert(index >= 0 && index < self.stringConfusions.count, @"Confusion index out of range");
    _currentConfusionIndex = index;
}

@end
