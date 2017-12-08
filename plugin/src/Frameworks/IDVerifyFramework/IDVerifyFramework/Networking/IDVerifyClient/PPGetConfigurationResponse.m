//
//  PPGetConfigurationResponse.m
//  IDVerifyFramework
//
//  Created by Jura on 06/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPGetConfigurationResponse.h"

#import "PPConfiguration.h"

@implementation PPGetConfigurationResponse

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _summary = dictionary[@"summary"];

        NSDictionary *data = dictionary[@"data"];
        if (data && ![[NSNull null] isEqual:data]) {
            _data = [[PPConfiguration alloc] initWithDictionary:data];
        }

        _loaded = (_data != nil);
    }
    return self;
}

- (NSString *)description {
    NSString *str = [super description];
    return [str stringByAppendingString:[NSString stringWithFormat:@" summary: %@, data %@,",
                                         _summary, _data]];
}

@end
