//
//  PPMrtdViewResult.h
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 06/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdViewResult.h"

@interface PPMrtdViewResult : PPIdViewResult

// ID
@property (nonatomic) NSString *idNumber;
@property (nonatomic) NSString *opt1;
@property (nonatomic) NSString *opt2;
@property (nonatomic) NSString *issuingAuthority;
@property (nonatomic) NSString *documentCode;

// Person
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *sex;
@property (nonatomic) NSString *nationality;

// Dates are in the format "dd.MM.yyyy."
@property (nonatomic) NSString *expiryDate;
@property (nonatomic) NSString *dateOfBirth;


/*** KEYS */

@property (nonatomic, readonly) NSString *idNumberKey;
@property (nonatomic, readonly) NSString *opt1Key;
@property (nonatomic, readonly) NSString *opt2Key;
@property (nonatomic, readonly) NSString *issuingAuthorityKey;
@property (nonatomic, readonly) NSString *documentCodeKey;
@property (nonatomic, readonly) NSString *lastNameKey;
@property (nonatomic, readonly) NSString *firstNameKey;
@property (nonatomic, readonly) NSString *sexKey;
@property (nonatomic, readonly) NSString *nationalityKey;
@property (nonatomic, readonly) NSString *addressKey;
@property (nonatomic, readonly) NSString *expiryDateKey;
@property (nonatomic, readonly) NSString *dateOfBirthKey;

@end
