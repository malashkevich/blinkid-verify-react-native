//
//  PPCroatiaIdVerifyResult+Updates.m
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPCroatiaIdVerifyResult+Updates.h"

@implementation PPCroatiaIdVerifyResult (Updates)

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

- (PPCroIDCombinedRecognizerResult *)getCroCombinedResult {

    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPCroIDCombinedRecognizerResult class])];

    if (res == nil)
        return nil;

    if (![res isKindOfClass:[PPCroIDCombinedRecognizerResult class]]) {
        NSLog(@"We expected %@, but didn't get it!", NSStringFromClass([PPCroIDCombinedRecognizerResult class]));
        return nil;
    }

    PPCroIDCombinedRecognizerResult *croRes = (PPCroIDCombinedRecognizerResult *)res;

    return croRes;
}

- (BOOL)hasAllDataInResult {

    PPCroIDCombinedRecognizerResult *croRes = [self getCroCombinedResult];

    if (croRes == nil) {
        return NO;
    }

    if ([croRes.firstName length] == 0) {
        NSLog(@"Result: We don't have the first name");
        return NO;
    }

    if ([croRes.lastName length] == 0) {
        NSLog(@"Result: We don't have the last name");
        return NO;
    }

    if ([croRes.identityCardNumber length] == 0) {
        NSLog(@"Result: We don't have the identity number");
        return NO;
    }

    if ([croRes.sex length] == 0) {
        NSLog(@"Result: We don't have sex");
        return NO;
    }

    if ([croRes.nationality length] == 0) {
        NSLog(@"Result: We don't have nationality");
        return NO;
    }

    if (croRes.dateOfBirth == nil) {
        NSLog(@"Result: We don't have date of birth");
        return NO;
    }

    if (croRes.documentDateOfExpiry == nil) {
        NSLog(@"Result: We don't have date of expiry");
        return NO;
    }

    if (croRes.documentDateOfIssue == nil) {
        NSLog(@"Result: We don't have date of issue");
        return NO;
    }

    if ([croRes.address length] == 0) {
        NSLog(@"Result: We don't have address");
        return NO;
    }

    if ([croRes.issuingAuthority length] == 0) {
        NSLog(@"Result: We don't have issuing authority");
        return NO;
    }

    return YES;
}

- (BOOL)hasMatchingData {

    PPCroIDCombinedRecognizerResult *croRes = [self getCroCombinedResult];

    if (croRes == nil) {
        return NO;
    }
    
    return croRes.matchingData;
}

@end
