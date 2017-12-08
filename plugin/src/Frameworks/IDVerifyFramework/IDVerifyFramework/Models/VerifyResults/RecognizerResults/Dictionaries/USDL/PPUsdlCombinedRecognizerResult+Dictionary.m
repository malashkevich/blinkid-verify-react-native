//
//  PPUsdlCombinedRecognizerResult+Dictionary.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPUsdlCombinedRecognizerResult+Dictionary.h"

#import "PPConfiguration.h"

@implementation PPUsdlCombinedRecognizerResult (Dictionary)

- (NSMutableDictionary<NSString *, NSObject *> *)dictionary {
    NSMutableDictionary<NSString *, NSObject *> *dict = [super dictionary];
    
    NSAssert(self.signatureVersion != nil, @"Signature version in PPUsdlCombinedRecognizerResult should not be nil!");
    
    [dict setObject:self.signatureVersion forKey:@"version"];
    [dict setObject:[PPConfiguration usdlConfigurationType] forKey:@"type"];
    
    return dict;
}

@end
