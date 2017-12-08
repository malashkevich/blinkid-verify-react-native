//
//  PPAustriaIdVerifyResult+Updates.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 30/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPAustriaIdVerifyResult+Updates.h"

@implementation PPAustriaIdVerifyResult (Updates)

#pragma mark - updates

- (void)addImageMetadata:(PPImageMetadata *)imageMetadata {
    [self.recognizerResults addImageMetadata:imageMetadata];

    [self populateViewResultWithMetadata:imageMetadata];
}

- (void)addRecognizerResult:(PPRecognizerResult *)recognizerResult {
    [self.recognizerResults addRecognizerResult:recognizerResult];

    [self populateViewResultWithRecognizerResult:recognizerResult];
}

#pragma mark - validations

- (PPAusIDCombinedRecognizerResult *)getAusCombinedResult {

    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPAusIDCombinedRecognizerResult class])];

    if (res == nil)
        return nil;

    if (![res isKindOfClass:[PPAusIDCombinedRecognizerResult class]]) {
        NSLog(@"We expected %@, but didn't get it!", NSStringFromClass([PPAusIDCombinedRecognizerResult class]));
        return nil;
    }

    PPAusIDCombinedRecognizerResult *ausRes = (PPAusIDCombinedRecognizerResult *)res;

    return ausRes;
}

- (BOOL)hasAllDataInResult {

    PPAusIDCombinedRecognizerResult *ausRes = [self getAusCombinedResult];

    if (ausRes == nil) {
        return NO;
    }

    if ([ausRes.firstName length] == 0) {
        NSLog(@"Result: We don't have the first name");
        return NO;
    }

    if ([ausRes.lastName length] == 0) {
        NSLog(@"Result: We don't have the last name");
        return NO;
    }

    if ([ausRes.documentNumber length] == 0) {
        NSLog(@"Result: We don't have the identity number");
        return NO;
    }

    if ([ausRes.sex length] == 0) {
        NSLog(@"Result: We don't have sex");
        return NO;
    }

    if (ausRes.dateOfBirth == nil) {
        NSLog(@"Result: We don't have date of birth");
        return NO;
    }

    if (ausRes.documentDateOfExpiry == nil) {
        NSLog(@"Result: We don't have date of expiry");
        return NO;
    }

    if (ausRes.dateOfIssue == nil) {
        NSLog(@"Result: We don't have date of issue");
        return NO;
    }

    if ([ausRes.issuingAuthority length] == 0) {
        NSLog(@"Result: We don't have issuing authority");
        return NO;
    }

    return YES;
}

- (BOOL)hasMatchingData {

    PPAusIDCombinedRecognizerResult *ausRes = [self getAusCombinedResult];

    if (ausRes == nil) {
        return NO;
    }

    return ausRes.matchingData;
}


@end
