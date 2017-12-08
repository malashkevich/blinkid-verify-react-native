//
//  PPAustriaIdViewResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 30/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPAustriaIdViewResult.h"

#import "PPConfiguration.h"

@implementation PPAustriaIdViewResult


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
    } else if ([key isEqualToString:[self heightKey]]) {
        self.height = value;
    } else if ([key isEqualToString:[self eyeColorKey]]) {
        self.eyeColor = value;
    } else if ([key isEqualToString:[self principalResidenceKey]]) {
        self.principalResidence = value;
    } else if ([key isEqualToString:[self expiryDateKey]]) {
        self.expiryDate = value;
    } else if ([key isEqualToString:[self dateOfBirthKey]]) {
        self.dateOfBirth = value;
    } else if ([key isEqualToString:[self dateOfIssueKey]]) {
        self.dateOfIssue = value;
    }
}

- (NSString *)idNumberKey {
    return @"AusIDCombinedDocumentNumber";
}

- (NSString *)issuingAuthorityKey {
    return @"AusIDCombinedIssuingAuthority";
}

- (NSString *)lastNameKey {
    return @"AusIDCombinedLastName";
}

- (NSString *)firstNameKey {
    return @"AusIDCombinedFirstName";
}

- (NSString *)sexKey {
    return @"AusIDCombinedSex";
}

- (NSString *)placeOfBirthKey {
    return @"AusIDCombinedPlaceOfBirth";
}

- (NSString *)heightKey {
    return @"AusIDCombinedHeight";
}

- (NSString *)eyeColorKey {
    return @"AusIDCombinedEyeColour";
}

- (NSString *)principalResidenceKey {
    return @"AusIDCombinedPrincipalResidence";
}

- (NSString *)expiryDateKey {
    return @"AusIDCombinedDateOfExpiry";
}

- (NSString *)dateOfBirthKey {
    return @"AusIDCombinedDateOfBirth";
}

- (NSString *)dateOfIssueKey {
    return @"AusIDCombinedDateOfIssuance";
}

- (NSString *)configurationType {
    return [PPConfiguration austrianConfigurationType];
}

@end
