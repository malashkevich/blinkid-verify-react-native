//
//  PPSlovakIDCombinedRecognizerResult+Dictionary.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSlovakIDCombinedRecognizerResult+Dictionary.h"

#import "PPConfiguration.h"

@implementation PPSlovakIDCombinedRecognizerResult (Dictionary)

- (NSMutableDictionary<NSString *, NSObject *> *)dictionary {
    NSMutableDictionary<NSString *, NSObject *> *dict = [super dictionary];

    NSAssert(self.signatureVersion != nil, @"Signature version in PPSlovakIDCombinedRecognizerResult should not be nil!");

    [dict setObject:self.signatureVersion forKey:@"version"];
    [dict setObject:[PPConfiguration slovakConfigurationType] forKey:@"type"];

    return dict;
}

@end
