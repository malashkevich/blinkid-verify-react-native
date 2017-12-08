//
//  PPFaceMatchData.m
//  IDVerify
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPFaceMatchData.h"

@implementation PPFaceMatchData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _isIdentical = [dictionary[@"isIdentical"] boolValue];
        _confidence = [dictionary[@"confidence"] floatValue];
    }
    return self;
}

- (NSString *)description {
    NSString *str = [super description];
    return [str stringByAppendingString:[NSString stringWithFormat:@"isIdentical: %@, confidence %@", @(_isIdentical), @(_confidence)]];
}

@end
