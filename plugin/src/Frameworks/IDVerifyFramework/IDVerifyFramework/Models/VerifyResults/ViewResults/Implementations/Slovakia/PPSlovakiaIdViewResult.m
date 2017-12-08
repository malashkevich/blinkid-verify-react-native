//
//  PPSlovakiaIdViewResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSlovakiaIdViewResult.h"

#import "PPConfiguration.h"

@implementation PPSlovakiaIdViewResult

- (void)updatePropertyForKey:(NSString *)key value:(NSString *)value {
    if ([key isEqualToString:[self idNumberKey]]) {
        self.idNumber = value;
    } else if ([key isEqualToString:[self issuingAuthorityKey]]) {
        self.issuingAuthority = value;
    } else if ([key isEqualToString:[self specialRemarksKey]]) {
        self.specialRemarks = value;
    } else if ([key isEqualToString:[self lastNameKey]]) {
        self.lastName = value;
    } else if ([key isEqualToString:[self firstNameKey]]) {
        self.firstName = value;
    } else if ([key isEqualToString:[self sexKey]]) {
        self.sex = value;
    } else if ([key isEqualToString:[self placeOfBirthKey]]) {
        self.placeOfBirth = value;
    } else if ([key isEqualToString:[self nationalityKey]]) {
        self.nationality = value;
    } else if ([key isEqualToString:[self addressKey]]) {
        self.address = value;
    } else if ([key isEqualToString:[self surnameAtBirthKey]]) {
        self.surnameAtBirth = value;
    } else if ([key isEqualToString:[self personalIdentificationNumberKey]]) {
        self.personalIdentificationNumber = value;
    } else if ([key isEqualToString:[self expiryDateKey]]) {
        self.expiryDate = value;
    } else if ([key isEqualToString:[self dateOfBirthKey]]) {
        self.dateOfBirth = value;
    } else if ([key isEqualToString:[self dateOfIssueKey]]) {
        self.dateOfIssue = value;
    }
}

- (NSString *)idNumberKey {
    return @"SvkIDCombinedDocumentNumber";
}

- (NSString *)issuingAuthorityKey {
    return @"SvkIDCombinedIssuedBy";
}

- (NSString *)specialRemarksKey {
    return @"SvkIDCombinedSpecialRemarks";
}

- (NSString *)lastNameKey {
    return @"SvkIDCombinedLastName";
}

- (NSString *)firstNameKey {
    return @"SvkIDCombinedFirstName";
}

- (NSString *)sexKey {
    return @"SvkIDCombinedSex";
}

- (NSString *)placeOfBirthKey {
    return @"SvkIDCombinedPlaceOfBirth";
}

- (NSString *)nationalityKey {
    return @"SvkIDCombinedNationality";
}

- (NSString *)addressKey {
    return @"SvkIDCombinedFullAddress";
}

- (NSString *)surnameAtBirthKey {
    return @"SvkIdCombinedSurnameAtBirth";
}

- (NSString *)personalIdentificationNumberKey {
    return @"SvkIDCombinedPIN";
}

- (NSString *)expiryDateKey {
    return @"SvkIDCombinedDateOfExpiry";
}

- (NSString *)dateOfBirthKey {
    return @"SvkIDCombinedDateOfBirth";
}

- (NSString *)dateOfIssueKey {
    return @"SvkIDCombinedDateOfIssue";
}

- (NSString *)configurationType {
    return [PPConfiguration slovakConfigurationType];
}

@end
