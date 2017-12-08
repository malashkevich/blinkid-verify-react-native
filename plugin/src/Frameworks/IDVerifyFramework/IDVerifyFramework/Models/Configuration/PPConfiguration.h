

//
//  PPConfiguration.h
//  IDVerifyFramework
//
//  Created by Jura on 06/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPKeyboardConfusions.h"

#import <Foundation/Foundation.h>

@interface PPConfiguration : NSObject <NSCoding>


@property (nonatomic, strong) NSArray<NSString *> *editableKeys;

@property (nonatomic, strong) PPKeyboardConfusions *transliterationMappings;

@property (nonatomic, strong) NSString *type;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

+ (instancetype)croIdConfiguration;

+ (NSString *)croIdConfigurationType;

+ (instancetype)mrtdConfiguration;

+ (NSString *)mrtdConfigurationType;

+ (instancetype)slovenianConfiguration;

+ (NSString *)slovenianConfigurationType;

+ (instancetype)czechConfiguration;

+ (NSString *)czechConfigurationType;

+ (instancetype)serbianConfiguration;

+ (NSString *)serbianConfigurationType;

+ (instancetype)singaporeConfiguration;

+ (NSString *)singaporeConfigurationType;

+ (instancetype)slovakConfiguration;

+ (NSString *)slovakConfigurationType;

+ (instancetype)austrianConfiguration;

+ (NSString *)austrianConfigurationType;

+ (instancetype)germanConfiguration;

+ (NSString *)germanConfigurationType;

+ (instancetype)usdlConfiguration;

+ (NSString *)usdlConfigurationType;

+ (NSString *)livenessConfigurationType;

+ (NSArray *)configurationTypes;

@end
