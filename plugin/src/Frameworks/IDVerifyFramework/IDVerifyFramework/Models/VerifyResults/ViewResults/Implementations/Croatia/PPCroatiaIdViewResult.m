//
//  PPCroatiaIdViewResult.m
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPCroatiaIdViewResult.h"
#import "PPConfiguration.h"

@implementation PPCroatiaIdViewResult

- (void)updatePropertyForKey:(NSString *)key value:(NSString *)value {
    if ([key isEqualToString:[self idNumberKey]]) {
        self.idNumber = value;
    } else if ([key isEqualToString:[self personalNumberKey]]) {
        self.personalNumber = value;
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
    return @"CroIDCombinedDocumentNumber";
}

- (NSString *)personalNumberKey {
    return @"CroIDCombinedOIB";
}

- (NSString *)issuingAuthorityKey {
    return @"CroIDCombinedIssuedBy";
}

- (NSString *)lastNameKey {
    return @"CroIDCombinedLastName";
}

- (NSString *)firstNameKey {
    return @"CroIDCombinedFirstName";
}

- (NSString *)sexKey {
    return @"CroIDCombinedSex";
}

- (NSString *)nationalityKey {
    return @"CroIDCombinedCitizenship";
}

- (NSString *)addressKey {
    return @"CroIDCombinedFullAddress";
}

- (NSString *)expiryDateKey {
    return @"CroIDCombinedDateOfExpiry";
}

- (NSString *)dateOfBirthKey {
    return @"CroIDCombinedDateOfBirth";
}

- (NSString *)dateOfIssueKey {
    return @"CroIDCombinedDateOfIssue";
}

- (NSString *)configurationType {
    return [PPConfiguration croIdConfigurationType];
}

@end
