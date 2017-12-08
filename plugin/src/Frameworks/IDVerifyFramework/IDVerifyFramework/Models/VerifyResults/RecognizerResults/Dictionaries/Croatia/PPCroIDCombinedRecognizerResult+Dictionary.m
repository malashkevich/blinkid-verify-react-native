//
//  PPCroIDCombinedRecognizerResult+Dictionary.m
//  IDVerify
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPCroIDCombinedRecognizerResult+Dictionary.h"

#import "PPConfiguration.h"

@implementation PPCroIDCombinedRecognizerResult (Dictionary)

- (NSMutableDictionary<NSString *, NSObject *> *)dictionary {
    NSMutableDictionary<NSString *, NSObject *> * dict = [super dictionary];

    NSAssert(self.signatureVersion != nil, @"Signature version in PPCroIDCombinedRecognizerResult should not be nil!");

    [dict setObject:self.signatureVersion forKey:@"version"];
    [dict setObject:[PPConfiguration croIdConfigurationType] forKey:@"type"];

    return dict;
}

@end
