//
//  PPConfigurationStorage.m
//  IDVerifyFramework
//
//  Created by Jura on 07/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPConfigurationStorage.h"

#import "PPConfiguration.h"

@implementation PPConfigurationStorage

+ (instancetype)sharedStorage {
    static PPConfigurationStorage *sharedStorage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStorage = [[self alloc] init];
    });
    return sharedStorage;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self configurationForType:[PPConfiguration croIdConfigurationType]] == nil) {
            [self storeConfiguration:[PPConfiguration croIdConfiguration]];
        }
        if ([self configurationForType:[PPConfiguration mrtdConfigurationType]] == nil) {
            [self storeConfiguration:[PPConfiguration mrtdConfiguration]];
        }
        if ([self configurationForType:[PPConfiguration slovenianConfigurationType]] == nil) {
            [self storeConfiguration:[PPConfiguration slovenianConfiguration]];
        }
        if ([self configurationForType:[PPConfiguration czechConfigurationType]] == nil) {
            [self storeConfiguration:[PPConfiguration czechConfiguration]];
        }
        if ([self configurationForType:[PPConfiguration serbianConfigurationType]] == nil) {
            [self storeConfiguration:[PPConfiguration serbianConfiguration]];
        }
        if ([self configurationForType:[PPConfiguration singaporeConfigurationType]] == nil) {
            [self storeConfiguration:[PPConfiguration singaporeConfiguration]];
        }
        if ([self configurationForType:[PPConfiguration slovakConfigurationType]] == nil) {
            [self storeConfiguration:[PPConfiguration slovakConfiguration]];
        }
        if ([self configurationForType:[PPConfiguration austrianConfigurationType]] == nil) {
            [self storeConfiguration:[PPConfiguration austrianConfiguration]];
        }
        if ([self configurationForType:[PPConfiguration germanConfigurationType]] == nil) {
            [self storeConfiguration:[PPConfiguration germanConfiguration]];
        }
        if ([self configurationForType:[PPConfiguration usdlConfigurationType]] == nil) {
            [self storeConfiguration:[PPConfiguration usdlConfiguration]];
        }
    }
    return self;
}

- (NSString *)keyForType:(NSString *)type {
    return [NSString stringWithFormat:@"PPConfigurationStorage.%@", type];
}

- (PPConfiguration *)configurationForType:(NSString *)type {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:[self keyForType:type]];
    PPConfiguration *configuration = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return configuration;
}

- (void)storeConfiguration:(PPConfiguration *)configuration {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:configuration];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:[self keyForType:configuration.type]];
    [defaults synchronize];
}

@end
