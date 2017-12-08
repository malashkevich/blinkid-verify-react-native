//
//  PPAustriaIdViewResult.h
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 30/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdViewResult.h"

@interface PPAustriaIdViewResult : PPIdViewResult

// ID
@property (nonatomic) NSString *idNumber;
@property (nonatomic) NSString *issuingAuthority;

// Person
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *sex;
@property (nonatomic) NSString *placeOfBirth;
@property (nonatomic) NSString *height;
@property (nonatomic) NSString *eyeColor;

// Address
@property (nonatomic) NSString *principalResidence;

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
@property (nonatomic, readonly) NSString *placeOfBirthKey;
@property (nonatomic, readonly) NSString *heightKey;
@property (nonatomic, readonly) NSString *eyeColorKey;
@property (nonatomic, readonly) NSString *principalResidenceKey;
@property (nonatomic, readonly) NSString *expiryDateKey;
@property (nonatomic, readonly) NSString *dateOfBirthKey;
@property (nonatomic, readonly) NSString *dateOfIssueKey;

@end
