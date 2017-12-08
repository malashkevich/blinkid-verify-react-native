//
//  PPUsdlViewResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPUsdlViewResult.h"

#import "PPConfiguration.h"

#import "PPUsdlCombinedRecognizerResult+Dictionary.h"

@implementation PPUsdlViewResult

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
    return kPPCustomerIdNumber;
}

- (NSString *)issuingAuthorityKey {
    return kPPAddressJurisdictionCode;
}

- (NSString *)lastNameKey {
    return kPPCustomerFamilyName;
}

- (NSString *)firstNameKey {
    return kPPCustomerFirstName;
}

- (NSString *)sexKey {
    return kPPSex;
}

- (NSString *)addressKey {
    return kPPFullAddress;
}

- (NSString *)expiryDateKey {
    return kPPDocumentExpirationDate;
}

- (NSString *)dateOfBirthKey {
    return kPPDateOfBirth;
}

- (NSString *)dateOfIssueKey {
    return kPPDocumentIssueDate;
}

- (NSString *)configurationType {
    return [PPConfiguration usdlConfigurationType];
}

@end
