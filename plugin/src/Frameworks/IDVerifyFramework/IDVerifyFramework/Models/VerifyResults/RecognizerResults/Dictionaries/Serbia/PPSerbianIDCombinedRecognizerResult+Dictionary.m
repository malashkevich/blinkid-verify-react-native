//
//  PPSerbianIDCombinedRecognizerResult+Dictionary.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSerbianIDCombinedRecognizerResult+Dictionary.h"

#import "PPConfiguration.h"

@implementation PPSerbianIDCombinedRecognizerResult (Dictionary)

- (NSMutableDictionary<NSString *, NSObject *> *)dictionary {
    NSMutableDictionary<NSString *, NSObject *> * dict = [super dictionary];
    
    NSAssert(self.signatureVersion != nil, @"Signature version in PPSerbianIDCombinedRecognizerResult should not be nil!");
    
    [dict setObject:self.signatureVersion forKey:@"version"];
    [dict setObject:[PPConfiguration serbianConfigurationType] forKey:@"type"];
    
    return dict;
}

@end
