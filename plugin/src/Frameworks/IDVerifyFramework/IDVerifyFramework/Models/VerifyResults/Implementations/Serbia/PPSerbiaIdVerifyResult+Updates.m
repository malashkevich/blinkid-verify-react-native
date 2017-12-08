//
//  PPSerbiaIdVerifyResult+Updates.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSerbiaIdVerifyResult+Updates.h"

@implementation PPSerbiaIdVerifyResult (Updates)

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

- (PPSerbianIDCombinedRecognizerResult *)getSerbianCombinedResult {
    
    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPSerbianIDCombinedRecognizerResult class])];
    
    if (res == nil)
        return nil;
    
    if (![res isKindOfClass:[PPSerbianIDCombinedRecognizerResult class]]) {
        NSLog(@"We expected %@, but didn't get it!", NSStringFromClass([PPSerbianIDCombinedRecognizerResult class]));
        return nil;
    }
    
    PPSerbianIDCombinedRecognizerResult *srbRes = (PPSerbianIDCombinedRecognizerResult *)res;
    
    return srbRes;
}

- (BOOL)hasAllDataInResult {
    
    PPSerbianIDCombinedRecognizerResult *srbRes = [self getSerbianCombinedResult];
    
    if (srbRes == nil) {
        return NO;
    }
    
    if ([srbRes.firstName length] == 0) {
        NSLog(@"Result: We don't have the first name");
        return NO;
    }
    
    if ([srbRes.lastName length] == 0) {
        NSLog(@"Result: We don't have the last name");
        return NO;
    }
    
    if ([srbRes.identityCardNumber length] == 0) {
        NSLog(@"Result: We don't have the identity number");
        return NO;
    }
    
    if ([srbRes.sex length] == 0) {
        NSLog(@"Result: We don't have sex");
        return NO;
    }
    
    if (srbRes.dateOfBirth == nil) {
        NSLog(@"Result: We don't have date of birth");
        return NO;
    }
    
    if (srbRes.documentDateOfExpiry == nil) {
        NSLog(@"Result: We don't have date of expiry");
        return NO;
    }
    
    if (srbRes.JMBG == nil) {
        NSLog(@"Result: We don't have date of issue");
        return NO;
    }
    
    if ([srbRes.issuingAuthority length] == 0) {
        NSLog(@"Result: We don't have issuing authority");
        return NO;
    }
    
    if (srbRes.documentDateOfIssue == nil) {
        NSLog(@"Result: We don't have date of issue");
        return NO;
    }
    
    return YES;
}

- (BOOL)hasMatchingData {
    
    PPSerbianIDCombinedRecognizerResult *srbRes = [self getSerbianCombinedResult];
    
    if (srbRes == nil) {
        return NO;
    }
    
    return srbRes.matchingData;
}


@end
