//
//  PPIdVerifySettings.m
//  IDVerifyFramework
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdVerifySettings.h"

@implementation PPIdVerifySettings

+ (instancetype)sharedSettings {
    static PPIdVerifySettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];

        NSString *blinkIdBundlePath = [[NSBundle mainBundle] pathForResource:@"IDVerify" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:blinkIdBundlePath];
        sharedInstance.resourcesBundle = bundle;

        sharedInstance.uiSettings = [[PPIdVerifyUiSettings alloc] init];
        sharedInstance.localizationSettings = [[PPIdVerifyLocalizationSettings alloc] init];
        
    });
    return sharedInstance;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, bundle: %@, licenseKey: %@, uisettings: %@", [super description], self.resourcesBundle, self.licenseKey, self.uiSettings];
}

@end
