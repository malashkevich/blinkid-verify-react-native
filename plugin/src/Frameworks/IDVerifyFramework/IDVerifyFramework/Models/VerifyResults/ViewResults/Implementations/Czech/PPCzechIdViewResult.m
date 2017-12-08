//
//  PPCzechIdViewResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 30/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPCzechIdViewResult.h"

#import "PPConfiguration.h"

@implementation PPCzechIdViewResult

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
    } else if ([key isEqualToString:[self placeOfBirthKey]]) {
        self.placeOfBirth = value;
    } else if ([key isEqualToString:[self nationalityKey]]) {
        self.nationality = value;
    } else if ([key isEqualToString:[self addressKey]]) {
        self.address = value;
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
    return @"CzIDCombinedDocumentNumber";
}

- (NSString *)issuingAuthorityKey {
    return @"CzIDCombinedIssuedBy";
}

- (NSString *)lastNameKey {
    return @"CzIDCombinedLastName";
}

- (NSString *)firstNameKey {
    return @"CzIDCombinedFirstName";
}

- (NSString *)sexKey {
    return @"CzIDCombinedSex";
}

- (NSString *)placeOfBirthKey {
    return @"CzIDCombinedPlaceOfBirth";
}

- (NSString *)nationalityKey {
    return @"CzIDCombinedNationality";
}

- (NSString *)addressKey {
    return @"CzIDCombinedFullAddress";
}

- (NSString *)personalIdentificationNumberKey {
    return @"CzIDCombinedPIN";
}

- (NSString *)expiryDateKey {
    return @"CzIDCombinedDateOfExpiry";
}

- (NSString *)dateOfBirthKey {
    return @"CzIDCombinedDateOfBirth";
}

- (NSString *)dateOfIssueKey {
    return @"CzIDCombinedDateOfIssue";
}

- (NSString *)configurationType {
    return [PPConfiguration czechConfigurationType];
}

@end
