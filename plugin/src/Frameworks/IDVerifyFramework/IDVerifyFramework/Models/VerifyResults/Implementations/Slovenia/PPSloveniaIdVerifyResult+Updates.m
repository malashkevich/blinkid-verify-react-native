//
//  PPSloveniaIdVerifyResult+Updates.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSloveniaIdVerifyResult+Updates.h"

@implementation PPSloveniaIdVerifyResult (Updates)

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

- (PPSlovenianIDCombinedRecognizerResult *)getSlovenianCombinedResult {
    
    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPSlovenianIDCombinedRecognizerResult class])];
    
    if (res == nil)
        return nil;
    
    if (![res isKindOfClass:[PPSlovenianIDCombinedRecognizerResult class]]) {
        NSLog(@"We expected %@, but didn't get it!", NSStringFromClass([PPSlovenianIDCombinedRecognizerResult class]));
        return nil;
    }
    
    PPSlovenianIDCombinedRecognizerResult *slovenianRes = (PPSlovenianIDCombinedRecognizerResult *)res;
    
    return slovenianRes;
}

- (BOOL)hasAllDataInResult {
    
    PPSlovenianIDCombinedRecognizerResult *slovenianRes = [self getSlovenianCombinedResult];
    
    if (slovenianRes == nil) {
        return NO;
    }
    
    if ([slovenianRes.firstName length] == 0) {
        NSLog(@"Result: We don't have the first name");
        return NO;
    }
    
    if ([slovenianRes.identityCardNumber length] == 0) {
        NSLog(@"Result: We don't have document number");
        return NO;
    }
    
    if ([slovenianRes.lastName length] == 0) {
        NSLog(@"Result: We don't have the last name");
        return NO;
    }
    
    if ([slovenianRes.sex length] == 0) {
        NSLog(@"Result: We don't have sex");
        return NO;
    }
    
    if ([slovenianRes.citizenship length] == 0) {
        NSLog(@"Result: We don't have nationality");
        return NO;
    }
    
    if (slovenianRes.dateOfBirth == nil) {
        NSLog(@"Result: We don't have date of birth");
        return NO;
    }
    
    if (slovenianRes.documentDateOfExpiry == nil) {
        NSLog(@"Result: We don't have date of expiry");
        return NO;
    }
    
    if (slovenianRes.personalIdentificationNumber == nil) {
        NSLog(@"Result: We don't have personal identification number");
        return NO;
    }
    
    
    if ([slovenianRes.address length] == 0) {
        NSLog(@"Result: We don't have address");
        return NO;
    }
    
    if ([slovenianRes.issuingAuthority length] == 0) {
        NSLog(@"Result: We don't have issuing authority");
        return NO;
    }
    
    return YES;
}

- (BOOL)hasMatchingData {
    
    PPSlovenianIDCombinedRecognizerResult *slovenianRes = [self getSlovenianCombinedResult];
    
    if (slovenianRes == nil) {
        return NO;
    }
    
    return slovenianRes.matchingData;
}

@end
