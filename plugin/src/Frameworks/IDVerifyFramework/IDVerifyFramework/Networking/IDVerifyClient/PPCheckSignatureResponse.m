//
//  PPCheckSignatureResponse.m
//  IDVerifyFramework
//
//  Created by Jura on 13/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPCheckSignatureResponse.h"

@implementation PPCheckSignatureResponse

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _summary = dictionary[@"summary"];

        id signatureVal = dictionary[@"signatureOk"];
        if (![[NSNull null] isEqual:signatureVal]) {
            _signatureOk = [signatureVal boolValue];
        }

        id changesVal = dictionary[@"allowedChangesOk"];
        if (![[NSNull null] isEqual:changesVal]) {
            _allowedChangesOk = [changesVal boolValue];
        }

        NSDictionary *data = dictionary[@"personData"];
        if (data && ![[NSNull null] isEqual:data]) {
            _personData = [[PPPersonData alloc] initWithDictionary:data];
        }
    }
    return self;
}

- (NSString *)description {
    NSString *str = [super description];
    return [str stringByAppendingString:[NSString stringWithFormat:@"summary: %@, signatureOk %@, allowedChangesOk %@, personData %@",
                                                                   _summary, @(_signatureOk), @(_allowedChangesOk), _personData]];
}

@end
