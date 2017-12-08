//
//  PPSerbiaIdViewResult.h
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdViewResult.h"

@interface PPSerbiaIdViewResult : PPIdViewResult

// ID
@property (nonatomic) NSString *idNumber;
@property (nonatomic) NSString *issuingAuthority;

// Person
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *sex;
@property (nonatomic) NSString *nationality;
@property (nonatomic) NSString *JMBG;

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
@property (nonatomic, readonly) NSString *nationalityKey;
@property (nonatomic, readonly) NSString *JMBGKey;
@property (nonatomic, readonly) NSString *expiryDateKey;
@property (nonatomic, readonly) NSString *dateOfBirthKey;
@property (nonatomic, readonly) NSString *dateOfIssueKey;

@end
