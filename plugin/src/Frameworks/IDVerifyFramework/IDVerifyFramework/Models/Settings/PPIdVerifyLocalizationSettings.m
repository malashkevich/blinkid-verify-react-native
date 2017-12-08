//
//  PPIdVerifyLocalizationSettings.m
//  IDVerifyFramework
//
//  Created by Jura on 12/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdVerifyLocalizationSettings.h"

#import "PPIdVerifySettings.h"

@implementation PPIdVerifyLocalizationSettings

- (instancetype)init {
    self = [super init];
    if (self) {
        _languageID = [[NSLocale preferredLanguages] objectAtIndex:0];
        _bundleForCurrentLanguage = nil;
        _tableForCameraStrings = @"PPCamera";
        _tableForResultStrings = @"PPResult";
    }
    return self;
}

- (NSBundle *)bundleForCurrentLanguage {
    if (_bundleForCurrentLanguage != nil) {
        return _bundleForCurrentLanguage;
    } else {
        return [NSBundle
            bundleWithPath:[[[PPIdVerifySettings sharedSettings] resourcesBundle] pathForResource:self.languageID ofType:@"lproj"]];
    }
}

@end
