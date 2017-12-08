//
//  PPSingaporeIdViewResult.h
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdViewResult.h"

@interface PPSingaporeIdViewResult : PPIdViewResult

// ID
@property (nonatomic) NSString *idNumber;

// Person
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *sex;
@property (nonatomic) NSString *bloodGroup;
@property (nonatomic) NSString *race;
@property (nonatomic) NSString *countryOfBirth;

// Address
@property (nonatomic) NSString *address;

// Dates are in the format "dd.MM.yyyy."
@property (nonatomic) NSString *dateOfBirth;
@property (nonatomic) NSString *dateOfIssue;


/*** KEYS */

@property (nonatomic, readonly) NSString *idNumberKey;
@property (nonatomic, readonly) NSString *issuingAuthorityKey;
@property (nonatomic, readonly) NSString *nameKey;
@property (nonatomic, readonly) NSString *sexKey;
@property (nonatomic, readonly) NSString *bloodGroupKey;
@property (nonatomic, readonly) NSString *raceKey;
@property (nonatomic, readonly) NSString *addressKey;
@property (nonatomic, readonly) NSString *countryOfBirthKey;
@property (nonatomic, readonly) NSString *dateOfBirthKey;
@property (nonatomic, readonly) NSString *dateOfIssueKey;

@end
