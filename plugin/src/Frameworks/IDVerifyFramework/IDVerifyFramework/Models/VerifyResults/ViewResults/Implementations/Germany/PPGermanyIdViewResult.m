//
//  PPGermanyIdViewResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 29/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPGermanyIdViewResult.h"

#import "PPConfiguration.h"

@implementation PPGermanyIdViewResult

- (void)updatePropertyForKey:(NSString *)key value:(NSString *)value {
    if ([key isEqualToString:[self idNumberKey]]) {
        self.idNumber = value;
    } else if ([key isEqualToString:[self issuingAuthorityKey]]) {
        self.issuingAuthority = value;
    } else if ([key isEqualToString:[self lastNameKey]]) {
        self.lastName = value;
    } else if ([key isEqualToString:[self firstNameKey]]) {
        self.firstName = value;
    } else if ([key isEqualToString:[self sexKey]]) {
        self.sex = value;
    } else if ([key isEqualToString:[self nationalityKey]]) {
        self.nationality = value;
    } else if ([key isEqualToString:[self placeOfBirthKey]]) {
        self.placeOfBirth = value;
    } else if ([key isEqualToString:[self heightKey]]) {
        self.height = value;
    } else if ([key isEqualToString:[self eyeColorKey]]) {
        self.eyeColor = value;
    } else if ([key isEqualToString:[self addressKey]]) {
        self.address = value;
    } else if ([key isEqualToString:[self expiryDateKey]]) {
        self.expiryDate = value;
    } else if ([key isEqualToString:[self dateOfBirthKey]]) {
        self.dateOfBirth = value;
    } else if ([key isEqualToString:[self dateOfIssueKey]]) {
        self.dateOfIssue = value;
    }
}

- (NSString *)idNumberKey {
    return @"GermanCombinedDocumentNumber";
}

- (NSString *)issuingAuthorityKey {
    return @"GermanCombinedIssuedBy";
}

- (NSString *)lastNameKey {
    return @"GermanCombinedLastName";
}

- (NSString *)firstNameKey {
    return @"GermanCombinedFirstName";
}

- (NSString *)sexKey {
    return @"GermanCombinedSex";
}

- (NSString *)nationalityKey {
    return @"GermanCombinedCitizenship";
}

- (NSString *)placeOfBirthKey {
    return @"GermanCombinedPlaceOfBirth";
}

- (NSString *)heightKey {
    return @"GermanCombinedHeight";
}

- (NSString *)eyeColorKey {
    return @"GermanCombinedEyeColor";
}

- (NSString *)addressKey {
    return @"GermanCombinedFullAddress";
}

- (NSString *)expiryDateKey {
    return @"GermanCombinedDateOfExpiry";
}

- (NSString *)dateOfBirthKey {
    return @"GermanCombinedDateOfBirth";
}

- (NSString *)dateOfIssueKey {
    return @"GermanCombinedDateOfIssue";
}

- (NSString *)configurationType {
    return [PPConfiguration germanConfigurationType];
}

@end
