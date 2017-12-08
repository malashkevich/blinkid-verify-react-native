//
//  PPGermanIDCombinedRecognizerResultDictionary.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 29/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPGermanIDCombinedRecognizerResult+Dictionary.h"

#import "PPConfiguration.h"

@implementation PPGermanIDCombinedRecognizerResult (Dictionary)

- (NSMutableDictionary<NSString *, NSObject *> *)dictionary {
        NSMutableDictionary<NSString *, NSObject *> * dict = [super dictionary];
    
        NSAssert(self.signatureVersion != nil, @"Signature version in PPGermanIDCombinedRecognizerResult should not be nil!");
    
        [dict setObject:self.signatureVersion forKey:@"version"];
        [dict setObject:[PPConfiguration germanConfigurationType] forKey:@"type"];
    
        return dict;
    }

@end
