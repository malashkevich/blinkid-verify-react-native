//
//  PPMrtdCombinedRecognizerResult+Dictionary.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 06/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPMrtdCombinedRecognizerResult+Dictionary.h"

#import "PPConfiguration.h"

@implementation PPMrtdCombinedRecognizerResult (Dictionary)

- (NSMutableDictionary<NSString *, NSObject *> *)dictionary {
    NSMutableDictionary<NSString *, NSObject *> * dict = [super dictionary];
    
    NSAssert(self.signatureVersion != nil, @"Signature version in PPMrtdCombinedRecognizerResult should not be nil!");
    
    [dict setObject:self.signatureVersion forKey:@"version"];
    [dict setObject:[PPConfiguration mrtdConfigurationType] forKey:@"type"];
    
    return dict;
}


@end
