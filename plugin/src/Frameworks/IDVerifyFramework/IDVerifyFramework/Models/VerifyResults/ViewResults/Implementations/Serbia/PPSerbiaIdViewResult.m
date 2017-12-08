//
//  PPSerbiaIdViewResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSerbiaIdViewResult.h"

#import "PPConfiguration.h"

@implementation PPSerbiaIdViewResult

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
    } else if ([key isEqualToString:[self JMBGKey]]) {
        self.JMBG = value;
    } else if ([key isEqualToString:[self expiryDateKey]]) {
        self.expiryDate = value;
    } else if ([key isEqualToString:[self dateOfBirthKey]]) {
        self.dateOfBirth = value;
    } else if ([key isEqualToString:[self dateOfIssueKey]]) {
        self.dateOfIssue = value;
    }
}

- (NSString *)idNumberKey {
    return @"SrbIDCombinedDocumentNumber";
}

- (NSString *)issuingAuthorityKey {
    return @"SrbIDCombinedIssuer";
}

- (NSString *)lastNameKey {
    return @"SrbIDCombinedLastName";
}

- (NSString *)firstNameKey {
    return @"SrbIDCombinedFirstName";
}

- (NSString *)sexKey {
    return @"SrbIDCombinedSex";
}

- (NSString *)nationalityKey {
    return @"SrbIDCombinedNationality";
}

- (NSString *)JMBGKey {
    return @"SrbIDCombinedJMBG";
}

- (NSString *)expiryDateKey {
    return @"SrbIDCombinedDateOfExpiry";
}

- (NSString *)dateOfBirthKey {
    return @"SrbIDCombinedDateOfBirth";
}

- (NSString *)dateOfIssueKey {
    return @"SrbIDCombinedDateOfIssue";
}

- (NSString *)configurationType {
    return [PPConfiguration serbianConfigurationType];
}

@end
