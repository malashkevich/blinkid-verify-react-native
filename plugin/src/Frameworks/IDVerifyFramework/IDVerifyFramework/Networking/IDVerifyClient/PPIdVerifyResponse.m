//
//  PPIdVerifyResponse.m
//  IDVerify
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPIdVerifyResponse.h"

@implementation PPIdVerifyResponse

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _summary = dictionary[@"summary"];
        _isPersonVerified = [dictionary[@"isPersonVerified"] boolValue];

        {
            NSDictionary *data = dictionary[@"faceMatchData"];
            if (data && ![[NSNull null] isEqual:data]) {
                _faceMatchData = [[PPFaceMatchData alloc] initWithDictionary:data];
            }
        }

        {
            NSDictionary *data = dictionary[@"personData"];
            if (data && ![[NSNull null] isEqual:data]) {
                _personData = [[PPPersonData alloc] initWithDictionary:data];
            }
        }
    }
    return self;
}

- (instancetype)initAsVerified:(BOOL)verified {
    NSDictionary *dict = @{@"summary" : @"ID Verify result created locally", @"isPersonVerified" : @(verified)};
    return [self initWithDictionary:dict];
}

- (NSString *)description {
    NSString *str = [super description];
    return [str stringByAppendingString:[NSString stringWithFormat:@"summary: %@, isPersonVerified %@, faceMatchData %@, personData %@",
                                                                   _summary, @(_isPersonVerified), _faceMatchData, _personData]];
}

@end
