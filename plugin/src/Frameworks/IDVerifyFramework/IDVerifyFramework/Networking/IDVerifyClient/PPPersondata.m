//
//  PPPersonData.m
//  IDVerify
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPPersonData.h"

@implementation PPPersonData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _data = dictionary;
    }
    return self;
}

- (NSString *)description {
    NSString *str = [super description];
    return [str stringByAppendingString:[NSString stringWithFormat:@"data: %@", _data]];
}

@end
