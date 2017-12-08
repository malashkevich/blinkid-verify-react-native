//
//  PPConfigurationStorage.h
//  IDVerifyFramework
//
//  Created by Jura on 07/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPConfiguration;

@interface PPConfigurationStorage : NSObject

+ (instancetype)sharedStorage;

- (PPConfiguration *)configurationForType:(NSString *)type;

- (void)storeConfiguration:(PPConfiguration *)configuration;

@end
