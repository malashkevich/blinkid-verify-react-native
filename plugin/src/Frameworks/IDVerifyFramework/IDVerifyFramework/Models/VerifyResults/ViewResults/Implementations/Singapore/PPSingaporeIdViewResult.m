//
//  PPSingaporeIdViewResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSingaporeIdViewResult.h"
#import "PPConfiguration.h"

@implementation PPSingaporeIdViewResult

- (void)updatePropertyForKey:(NSString *)key value:(NSString *)value {
    if ([key isEqualToString:[self idNumberKey]]) {
        self.idNumber = value;
    } else if ([key isEqualToString:[self nameKey]]) {
        self.name = value;
    } else if ([key isEqualToString:[self sexKey]]) {
        self.sex = value;
    } else if ([key isEqualToString:[self bloodGroupKey]]) {
        self.bloodGroup = value;
    } else if ([key isEqualToString:[self raceKey]]) {
        self.race = value;
    } else if ([key isEqualToString:[self countryOfBirthKey]]) {
        self.countryOfBirth = value;
    } else if ([key isEqualToString:[self addressKey]]) {
        self.address = value;
    } else if ([key isEqualToString:[self dateOfBirthKey]]) {
        self.dateOfBirth = value;
    } else if ([key isEqualToString:[self dateOfIssueKey]]) {
        self.dateOfIssue = value;
    }
}

- (NSString *)idNumberKey {
    return @"SingaporeIDCombinedCardNumber";
}

- (NSString *)nameKey {
    return @"SingaporeIDCombinedName";
}

- (NSString *)sexKey {
    return @"SingaporeIDCombinedSex";
}

- (NSString *)bloodGroupKey {
    return @"SingaporeIDCombinedBloodGroup";
}

- (NSString *)countryOfBirthKey {
    return @"SingaporeIDCombinedCountryOfBirth";
}

- (NSString *)raceKey {
    return @"SingaporeIDCombinedRace";
}

- (NSString *)addressKey {
    return @"SingaporeIDCombinedAddress";
}

- (NSString *)dateOfBirthKey {
    return @"SingaporeIDCombinedDateOfBirth";
}

- (NSString *)dateOfIssueKey {
    return @"SingaporeIDCombinedDateOfIssue";
}

- (NSString *)configurationType {
    return [PPConfiguration singaporeConfigurationType];
}

@end
