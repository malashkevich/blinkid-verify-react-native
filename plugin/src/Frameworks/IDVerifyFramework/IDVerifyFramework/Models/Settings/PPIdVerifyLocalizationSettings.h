//
//  PPIdVerifyLocalizationSettings.h
//  IDVerifyFramework
//
//  Created by Jura on 12/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPIdVerifyLocalizationSettings : NSObject

/**
 * ID of the current language.
 *
 * Default: [[NSLocale preferredLanguages] objectAtIndex:0]
 */
@property (nonatomic) NSString *languageID;

/**
 * If not explicitly set, the getter returns default. If set, the getter returns set value.
 *
 * Default: [NSBundle bundleWithPath:[[[PPIdVerifySettings sharedSettings] resourcesBundle] pathForResource:self.languageID
 *                ofType:@"lproj"]]
 */
@property (nonatomic) NSBundle *bundleForCurrentLanguage;

/**
 * Table where the camera strings are searched.
 *
 * Default: PPCamera
 */
@property (nonatomic) NSString *tableForCameraStrings;

/**
 * Table where the camera strings are searched.
 *
 * Default: PPResult
 */
@property (nonatomic) NSString *tableForResultStrings;

@end
