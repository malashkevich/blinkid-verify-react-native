//
//  PPCroatiaIdVerifyResultTests.m
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <MicroBlink/MicroBlink.h>

#import "PPCroatiaIdViewResult.h"
#import "PPCroatiaIdVerifyResult.h"
#import "PPIdVerifyResult+Updates.h"
#import "PPCroIDCombinedRecognizerResult+Test.h"
#import "PPLivenessRecognizerResult+Test.h"
#import "NSDictionary+Utils.h"

#import "PPIdVerifyClient.h"

@interface PPCroatiaIdVerifyResultTests : XCTestCase

@end

@implementation PPCroatiaIdVerifyResultTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItCreatesIdViewResult {
    PPCroatiaIdVerifyResult *verifyResult = [[PPCroatiaIdVerifyResult alloc] init];

    [verifyResult addRecognizerResult:[PPCroIDCombinedRecognizerResult dinoResult]];
    [verifyResult addRecognizerResult:[PPLivenessRecognizerResult failedSignatureResult]];

    XCTAssertEqualObjects([verifyResult croatiaViewResult].personalNumber, @"40568374465");
    XCTAssertEqualObjects([verifyResult croatiaViewResult].idNumber, @"112251465");
    XCTAssertEqualObjects([verifyResult croatiaViewResult].firstName, @"DINO");
    XCTAssertEqualObjects([verifyResult croatiaViewResult].lastName, @"GUŠTIN");
    XCTAssertEqualObjects([verifyResult croatiaViewResult].expiryDate, @"30.10.2020.");
    XCTAssertEqualObjects([verifyResult croatiaViewResult].issuingAuthority, @"PU KARLOVACKA");
    XCTAssertEqualObjects([verifyResult croatiaViewResult].dateOfBirth, @"30.09.1991.");
    XCTAssertEqualObjects([verifyResult croatiaViewResult].dateOfIssue, @"30.10.2015.");
    XCTAssertEqualObjects([verifyResult croatiaViewResult].sex, @"M");
    XCTAssertEqualObjects([verifyResult croatiaViewResult].address, @"KARLOVAC, KARLOVAC ĐUKE BENCETIČA 2");
    XCTAssertEqualObjects([verifyResult croatiaViewResult].nationality, @"HRV");
}

- (void)testThatItOutputsValidJson {

    PPCroatiaIdVerifyResult *verifyResult = [[PPCroatiaIdVerifyResult alloc] init];

    [verifyResult addRecognizerResult:[PPCroIDCombinedRecognizerResult dinoResult]];
    [verifyResult addRecognizerResult:[PPLivenessRecognizerResult failedSignatureResult]];

    NSLog(@"%@", [verifyResult dictionary]);
    NSLog(@"%@", [PPCroatiaIdVerifyResultTests dinoDictionary]);

    XCTAssertEqualObjects([verifyResult dictionary], [PPCroatiaIdVerifyResultTests dinoDictionary]);
}

+ (NSData *)dataWithString:(NSString *)string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dinoDictionary {
    return @{
        @"originalData" : @{
            @"type" : @"croID",
            @"version" : @"v3",
            @"CroIDCombinedCitizenship" : @"HRV",
            @"CroIDCombinedDocumentBilingual" : @(NO),
            @"CroIDCombinedForNonResident" : @(NO),
            @"CroIDCombinedDateOfBirth" :
                @{@"type" : @"date", @"day" : @30, @"month" : @9, @"year" : @1991, @"originalString" : @"30.09.1991"},
            @"CroIDCombinedDateOfExpiry" :
                @{@"type" : @"date", @"day" : @30, @"month" : @10, @"year" : @2020, @"originalString" : @"30.10.2020"},
            @"CroIDCombinedDateOfIssue" :
                @{@"type" : @"date", @"day" : @30, @"month" : @10, @"year" : @2015, @"originalString" : @"30.10.2015"},
            @"CroIDCombinedDocumentNumber" : @"112251465",
            @"CroIDCombinedOIB" : @"40568374465",
            @"CroIDCombinedFirstName" : @"DINO",
            @"CroIDCombinedFullAddress" : @"KARLOVAC, KARLOVAC ĐUKE BENCETIČA 2",
            @"CroIDCombinedIssuedBy" : @"PU KARLOVACKA",
            @"CroIDCombinedMRTDVerified" : @(YES),
            @"CroIDCombinedLastName" : @"GUŠTIN",
            @"CroIDCombinedSex" : @"M",
            @"Face.Image" : @{@"type" : @"bytes", @"base64Data" : @"TGljZTE="},
            @"documentBothSidesMatch" : @(YES),
            @"signature" : @{@"type" : @"bytes", @"base64Data" : @"UHJvYmEx"}
        },
        @"livenessData" : @{
            @"version" : @"v3",
            @"type" : @"liveness",
            @"livenessStatus" : @(YES),
            @"LivenessFace.Image" : @{@"type" : @"bytes", @"base64Data" : @"TGljZTE="},
            @"signature" : @{@"type" : @"bytes", @"base64Data" : @"UHJvYmEx"}
        },
        @"editedData" : @{},
        @"insertedData" : @{},
    };
}

@end
