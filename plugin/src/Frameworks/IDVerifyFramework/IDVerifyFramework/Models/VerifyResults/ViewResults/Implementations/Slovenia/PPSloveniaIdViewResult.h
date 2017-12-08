//
//  PPSloveniaIdViewResult.h
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdViewResult.h"

@interface PPSloveniaIdViewResult : PPIdViewResult

// ID
@property (nonatomic) NSString *idNumber;
@property (nonatomic) NSString *issuingAuthority;

// Person
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *sex;
@property (nonatomic) NSString *citizenship;
@property (nonatomic) NSString *personalIdentificationNumber;

// Address
@property (nonatomic) NSString *address;

// Dates are in the format "dd.MM.yyyy."
@property (nonatomic) NSString *expiryDate;
@property (nonatomic) NSString *dateOfBirth;
@property (nonatomic) NSString *dateOfIssue;

/*** KEYS */

@property (nonatomic, readonly) NSString *idNumberKey;
@property (nonatomic, readonly) NSString *issuingAuthorityKey;
@property (nonatomic, readonly) NSString *lastNameKey;
@property (nonatomic, readonly) NSString *firstNameKey;
@property (nonatomic, readonly) NSString *sexKey;
@property (nonatomic, readonly) NSString *citizenshipKey;
@property (nonatomic, readonly) NSString *personalIdentificationNumberKey;
@property (nonatomic, readonly) NSString *addressKey;
@property (nonatomic, readonly) NSString *expiryDateKey;
@property (nonatomic, readonly) NSString *dateOfBirthKey;
@property (nonatomic, readonly) NSString *dateOfIssueKey;

@end
