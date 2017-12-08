//
//  PPIdVerifyServiceTests.m
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Dino. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PPIdVerifyClient.h"
#import "PPCroatiaIdVerifyResult.h"

#import "PPIdVerifyResult+Updates.h"
#import "PPCroIDCombinedRecognizerResult+Test.h"
#import "PPLivenessRecognizerResult+Test.h"

@interface PPIdVerifyServiceTests : XCTestCase

@property (nonatomic) PPIdVerifyClient *client;

@end

@implementation PPIdVerifyServiceTests

- (void)setUp {
    [super setUp];

    self.client = [[PPIdVerifyClient alloc] initWithUrl:[NSURL URLWithString:@"https://blinkid-verify-test.microblink.com"]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItPerformsCheckSignatureRequestForCroatiaIdResult {
    PPCroatiaIdVerifyResult *verifyResult = [[PPCroatiaIdVerifyResult alloc] init];

    [verifyResult addRecognizerResult:[PPCroIDCombinedRecognizerResult emirResult]];
    [verifyResult addRecognizerResult:[PPLivenessRecognizerResult realSignatureResult]];

    XCTestExpectation *expectation = [self expectationWithDescription:@"Completes request"];

    [self.client checkSignature:verifyResult
                     completion:^(PPCheckSignatureResponse *_Nonnull response, NSError *_Nonnull error) {
                         if (response != nil) {
                             NSLog(@"%@", response);
                             [expectation fulfill];
                         }
                     }];

    [self waitForExpectationsWithTimeout:5.0f handler:nil];
}

- (void)testThatItPerformsVerificationRequestForCroatiaIdResult {
    PPCroatiaIdVerifyResult *verifyResult = [[PPCroatiaIdVerifyResult alloc] init];

    [verifyResult addRecognizerResult:[PPCroIDCombinedRecognizerResult emirResult]];
    [verifyResult addRecognizerResult:[PPLivenessRecognizerResult realSignatureResult]];

    XCTestExpectation *expectation = [self expectationWithDescription:@"Completes request"];

    [self.client verifyResult:verifyResult
                   completion:^(PPIdVerifyResponse *_Nonnull response, NSError *_Nonnull error) {
                       if (response != nil) {
                           NSLog(@"%@", response);
                           [expectation fulfill];
                       }
                   }];

    [self waitForExpectationsWithTimeout:5.0f handler:nil];
}

- (void)testThatItPerformsGetConfigurationRequestForCroatia {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Completes request"];

    [self.client getConfigurationForType:@"croID" completion:^(PPGetConfigurationResponse * _Nonnull response, NSError * _Nonnull error) {
        if (response != nil) {
            NSLog(@"%@", response);
            [expectation fulfill];
        }
    }];

    [self waitForExpectationsWithTimeout:5.0f handler:nil];
}

- (void)testThatItPerformsGetConfigurationRequestForUnknownType {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Completes request"];

    [self.client getConfigurationForType:@"asdasda" completion:^(PPGetConfigurationResponse * _Nonnull response, NSError * _Nonnull error) {
        if (response == nil || !response.loaded) {
            NSLog(@"%@", response);
            [expectation fulfill];
        }
    }];

    [self waitForExpectationsWithTimeout:5.0f handler:nil];
}


@end
