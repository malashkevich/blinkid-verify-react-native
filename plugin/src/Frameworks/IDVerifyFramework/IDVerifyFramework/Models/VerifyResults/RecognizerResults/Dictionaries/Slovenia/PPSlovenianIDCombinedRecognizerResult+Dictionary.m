//
//  PPSlovenianIDCombinedRecognizerResult+Dictionary.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSlovenianIDCombinedRecognizerResult+Dictionary.h"

#import "PPConfiguration.h"

@implementation PPSlovenianIDCombinedRecognizerResult (Dictionary)

- (NSMutableDictionary<NSString *, NSObject *> *)dictionary {
    NSMutableDictionary<NSString *, NSObject *> *dict = [super dictionary];

    NSAssert(self.signatureVersion != nil, @"Signature version in PPSlovenianIDCombinedRecognizerResult should not be nil!");

    [dict setObject:self.signatureVersion forKey:@"version"];
    [dict setObject:[PPConfiguration slovenianConfigurationType] forKey:@"type"];

    return dict;
}

@end
