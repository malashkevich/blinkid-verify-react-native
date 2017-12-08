//
//  PPMrtdViewResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 06/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPMrtdViewResult.h"
#import "PPConfiguration.h"

@implementation PPMrtdViewResult

- (void)updatePropertyForKey:(NSString *)key value:(NSString *)value {
    if ([key isEqualToString:[self idNumberKey]]) {
        self.idNumber = value;
    } else if ([key isEqualToString:[self opt1Key]]) {
        self.opt1 = value;
    } else if ([key isEqualToString:[self opt2Key]]) {
        self.opt1 = value;
    } else if ([key isEqualToString:[self issuingAuthorityKey]]) {
        self.issuingAuthority = value;
    } else if ([key isEqualToString:[self documentCodeKey]]) {
        self.documentCode = value;
    } else if ([key isEqualToString:[self lastNameKey]]) {
        self.lastName = value;
    } else if ([key isEqualToString:[self firstNameKey]]) {
        self.firstName = value;
    } else if ([key isEqualToString:[self sexKey]]) {
        self.sex = value;
    } else if ([key isEqualToString:[self nationalityKey]]) {
        self.nationality = value;
    } else if ([key isEqualToString:[self expiryDateKey]]) {
        self.expiryDate = value;
    } else if ([key isEqualToString:[self dateOfBirthKey]]) {
        self.dateOfBirth = value;
    }
}

- (NSString *)idNumberKey {
    return @"DocumentNumber";
}

- (NSString *)opt1Key {
    return @"Opt1";
}

- (NSString *)opt2Key {
    return @"Opt2";
}

- (NSString *)issuingAuthorityKey {
    return @"Issuer";
}

- (NSString *)documentCodeKey {
    return @"DocumentCode";
}

- (NSString *)lastNameKey {
    return @"PrimaryId";
}

- (NSString *)firstNameKey {
    return @"SecondaryId";
}

- (NSString *)sexKey {
    return @"Sex";
}

- (NSString *)nationalityKey {
    return @"Nationality";
}

- (NSString *)expiryDateKey {
    return @"DateOfExpiry";
}

- (NSString *)dateOfBirthKey {
    return @"DateOfBirth";
}

- (NSString *)configurationType {
    return [PPConfiguration mrtdConfigurationType];
}

@end
