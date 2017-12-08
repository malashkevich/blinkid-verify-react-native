//
//  PPCroatiaIdViewResult.h
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPIdViewResult.h"

@interface PPCroatiaIdViewResult : PPIdViewResult

// ID
@property (nonatomic) NSString *idNumber;
@property (nonatomic) NSString *personalNumber;
@property (nonatomic) NSString *issuingAuthority;

// Person
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *sex;
@property (nonatomic) NSString *nationality;

// Address
@property (nonatomic) NSString *address;

// Dates are in the format "dd.MM.yyyy."
@property (nonatomic) NSString *expiryDate;
@property (nonatomic) NSString *dateOfBirth;
@property (nonatomic) NSString *dateOfIssue;


/*** KEYS */

@property (nonatomic, readonly) NSString *idNumberKey;
@property (nonatomic, readonly) NSString *personalNumberKey;
@property (nonatomic, readonly) NSString *issuingAuthorityKey;
@property (nonatomic, readonly) NSString *lastNameKey;
@property (nonatomic, readonly) NSString *firstNameKey;
@property (nonatomic, readonly) NSString *sexKey;
@property (nonatomic, readonly) NSString *nationalityKey;
@property (nonatomic, readonly) NSString *addressKey;
@property (nonatomic, readonly) NSString *expiryDateKey;
@property (nonatomic, readonly) NSString *dateOfBirthKey;
@property (nonatomic, readonly) NSString *dateOfIssueKey;

@end
