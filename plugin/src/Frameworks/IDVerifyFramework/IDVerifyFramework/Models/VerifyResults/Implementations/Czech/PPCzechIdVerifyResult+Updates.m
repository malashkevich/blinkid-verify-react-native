//
//  PPCzechIdVerifyResult+Updates.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 30/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPCzechIdVerifyResult+Updates.h"

@implementation PPCzechIdVerifyResult (Updates)

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

- (PPCzIDCombinedRecognizerResult *)getCzCombinedResult {
    
    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPCzIDCombinedRecognizerResult class])];
    
    if (res == nil)
        return nil;
    
    if (![res isKindOfClass:[PPCzIDCombinedRecognizerResult class]]) {
        NSLog(@"We expected %@, but didn't get it!", NSStringFromClass([PPCzIDCombinedRecognizerResult class]));
        return nil;
    }
    
    PPCzIDCombinedRecognizerResult *czRes = (PPCzIDCombinedRecognizerResult *)res;
    
    return czRes;
}

- (BOOL)hasAllDataInResult {
    
    PPCzIDCombinedRecognizerResult *czRes = [self getCzCombinedResult];
    
    if (czRes == nil) {
        return NO;
    }
    
    if ([czRes.firstName length] == 0) {
        NSLog(@"Result: We don't have the first name");
        return NO;
    }
    
    if ([czRes.identityCardNumber length] == 0) {
        NSLog(@"Result: We don't have document number");
        return NO;
    }
    
    if ([czRes.lastName length] == 0) {
        NSLog(@"Result: We don't have the last name");
        return NO;
    }
    
    if ([czRes.sex length] == 0) {
        NSLog(@"Result: We don't have sex");
        return NO;
    }
    
    if ([czRes.nationality length] == 0) {
        NSLog(@"Result: We don't have nationality");
        return NO;
    }
    
    if (czRes.dateOfBirth == nil) {
        NSLog(@"Result: We don't have date of birth");
        return NO;
    }
    
    if (czRes.documentDateOfExpiry == nil) {
        NSLog(@"Result: We don't have date of expiry");
        return NO;
    }
    
    if (czRes.personalIdentificationNumber == nil) {
        NSLog(@"Result: We don't have personal identification number");
        return NO;
    }
    
    
    if ([czRes.address length] == 0) {
        NSLog(@"Result: We don't have address");
        return NO;
    }
    
    if ([czRes.issuingAuthority length] == 0) {
        NSLog(@"Result: We don't have issuing authority");
        return NO;
    }
    
    return YES;
}

- (BOOL)hasMatchingData {
    
    PPCzIDCombinedRecognizerResult *czRes = [self getCzCombinedResult];
    
    if (czRes == nil) {
        return NO;
    }
    
    return czRes.matchingData;
}

@end
