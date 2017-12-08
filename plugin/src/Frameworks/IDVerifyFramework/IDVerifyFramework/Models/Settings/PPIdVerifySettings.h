//
//  PPIdVerifySettings.h
//  IDVerifyFramework
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdVerifyUiSettings.h"
#import "PPIdVerifyLocalizationSettings.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPIdVerifySettings : NSObject

@property (nonatomic) BOOL enableBeep;

@property (nonatomic) NSBundle *resourcesBundle;

@property (nonatomic) NSString *licenseKey;

@property (nonatomic) NSString *livenessLicenseKey;

@property (nonatomic) NSString *licensee;

@property (nonatomic) PPIdVerifyLocalizationSettings *localizationSettings;

@property (nonatomic) PPIdVerifyUiSettings *uiSettings;

+ (instancetype)sharedSettings;

@end

NS_ASSUME_NONNULL_END
