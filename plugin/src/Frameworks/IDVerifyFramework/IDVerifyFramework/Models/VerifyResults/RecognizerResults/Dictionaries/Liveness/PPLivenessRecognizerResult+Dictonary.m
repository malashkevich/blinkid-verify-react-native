//
//  PPLivenessRecognizerResult+Dictonary.m
//  IDVerify
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPLivenessRecognizerResult+Dictonary.h"

#import "PPConfiguration.h"

@implementation PPLivenessRecognizerResult (Dictonary)

- (NSMutableDictionary<NSString *, NSObject *> *)dictionary {
    NSMutableDictionary<NSString *, NSObject *> * dict = [super dictionary];

    NSAssert(self.signatureVersion != nil, @"Signature version in PPLivenessRecognizerResult should not be nil!");

    [dict setObject:self.signatureVersion forKey:@"version"];
    [dict setObject:[PPConfiguration livenessConfigurationType] forKey:@"type"];

    return dict;
}

@end
