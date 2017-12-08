//
//  PPGermanyIdVerifyResultUpdates.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 29/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPGermanyIdVerifyResult+Updates.h"

@implementation PPGermanyIdVerifyResult (Updates)

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

- (PPGermanIDCombinedRecognizerResult *)getGerCombinedResult {

    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPGermanIDCombinedRecognizerResult class])];

    if (res == nil)
        return nil;

    if (![res isKindOfClass:[PPGermanIDCombinedRecognizerResult class]]) {
        NSLog(@"We expected %@, but didn't get it!", NSStringFromClass([PPGermanIDCombinedRecognizerResult class]));
        return nil;
    }

    PPGermanIDCombinedRecognizerResult *gerRes = (PPGermanIDCombinedRecognizerResult *)res;

    return gerRes;
}

- (BOOL)hasAllDataInResult {

    PPGermanIDCombinedRecognizerResult *gerRes = [self getGerCombinedResult];

    if (gerRes == nil) {
        return NO;
    }

    if ([gerRes.firstName length] == 0) {
        NSLog(@"Result: We don't have the first name");
        return NO;
    }

    if ([gerRes.lastName length] == 0) {
        NSLog(@"Result: We don't have the last name");
        return NO;
    }

    if ([gerRes.identityCardNumber length] == 0) {
        NSLog(@"Result: We don't have the identity number");
        return NO;
    }

    if ([gerRes.sex length] == 0) {
        NSLog(@"Result: We don't have sex");
        return NO;
    }

    if ([gerRes.nationality length] == 0) {
        NSLog(@"Result: We don't have nationality");
        return NO;
    }

    if (gerRes.dateOfBirth == nil) {
        NSLog(@"Result: We don't have date of birth");
        return NO;
    }

    if (gerRes.documentDateOfExpiry == nil) {
        NSLog(@"Result: We don't have date of expiry");
        return NO;
    }

    if (gerRes.documentDateOfIssue == nil) {
        NSLog(@"Result: We don't have date of issue");
        return NO;
    }

    if ([gerRes.address length] == 0) {
        NSLog(@"Result: We don't have address");
        return NO;
    }

    if ([gerRes.issuingAuthority length] == 0) {
        NSLog(@"Result: We don't have issuing authority");
        return NO;
    }

    return YES;
}

- (BOOL)hasMatchingData {

    PPGermanIDCombinedRecognizerResult *gerRes = [self getGerCombinedResult];

    if (gerRes == nil) {
        return NO;
    }

    return gerRes.matchingData;
}

@end
