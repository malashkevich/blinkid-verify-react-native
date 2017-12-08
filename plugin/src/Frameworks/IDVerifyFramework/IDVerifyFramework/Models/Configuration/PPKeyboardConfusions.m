//
//  PPKeyboardConfusions.m
//  IDVerifyFramework
//
//  Created by Jura on 30/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPKeyboardConfusions.h"

@interface PPKeyboardConfusions ()

@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *confusions;
@end

@implementation PPKeyboardConfusions

- (instancetype)initWithConfusions:(NSArray<NSArray<NSString *> *> *)confusions {
    self = [super init];
    if (self) {
        _confusions = confusions;
        _maxConfusionLength = [self calcMaxConfusionLength];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.confusions forKey:@"confusions"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)decoder {
    NSArray<NSArray<NSString *> *> *confusions = [decoder decodeObjectForKey:@"confusions"];

    self = [self initWithConfusions:confusions];
    if (self) {
        // nothing here
    }
    return self;
}

- (NSUInteger)calcMaxConfusionLength {
    NSUInteger maxLength = 0;

    for (NSArray<NSString *> *confusionList in self.confusions) {
        for (NSString *variant in confusionList) {
            if ([variant length] > maxLength) {
                maxLength = [variant length];
            }
        }
    }

    return maxLength;
}

- (NSArray<NSString *> *)confusionsForString:(NSString *)str {
    for (NSArray<NSString *> *confusionList in self.confusions) {
        for (NSString *variant in confusionList) {
            if ([str isEqualToString:variant]) {
                return confusionList;
            }
        }
    }
    return nil;
}

- (NSArray<PPStringConfusion *> *)getStringConfusionsForText:(NSString *)text {

    NSMutableArray<PPStringConfusion *> *confusions = [[NSMutableArray alloc] init];

    for (int loc = 0; loc < text.length; loc++) {
        for (int len = 1; len <= MIN(text.length - loc, self.maxConfusionLength); len++) {
            NSString *substr = [text substringWithRange:NSMakeRange(loc, len)];

            NSArray<NSString *> *conf = [self confusionsForString:substr];

            if ([conf count] > 0) {

                PPStringConfusion *confusion = [[PPStringConfusion alloc] initWithOriginalString:text
                                                                                           range:NSMakeRange(loc, len)
                                                                                    currentValue:substr
                                                                                      confusions:conf];

                [confusions addObject:confusion];

                break;
            }
        }
    }
    
    return confusions;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, confusions: %@", [super description], [self confusions]];
}

@end
