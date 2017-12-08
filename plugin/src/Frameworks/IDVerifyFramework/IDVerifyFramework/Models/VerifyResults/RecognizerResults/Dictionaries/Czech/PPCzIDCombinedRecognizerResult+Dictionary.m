//
//  PPCzIDCombinedRecognizerResult+Dictionary.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPCzIDCombinedRecognizerResult+Dictionary.h"

#import "PPConfiguration.h"

@implementation PPCzIDCombinedRecognizerResult (Dictionary)

- (NSMutableDictionary<NSString *, NSObject *> *)dictionary {
    NSMutableDictionary<NSString *, NSObject *> * dict = [super dictionary];
    
    NSAssert(self.signatureVersion != nil, @"Signature version in PPCzIDCombinedRecognizerResult should not be nil!");
    
    [dict setObject:self.signatureVersion forKey:@"version"];
    [dict setObject:[PPConfiguration czechConfigurationType] forKey:@"type"];
    
    return dict;
}

@end
