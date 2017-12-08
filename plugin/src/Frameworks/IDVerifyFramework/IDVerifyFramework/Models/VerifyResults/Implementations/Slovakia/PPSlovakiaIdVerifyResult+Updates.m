//
//  PPSlovakiaIdVerifyResult+Updates.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSlovakiaIdVerifyResult+Updates.h"

@implementation PPSlovakiaIdVerifyResult (Updates)

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

- (PPSlovakIDCombinedRecognizerResult *)getSlovakCombinedResult {
    
    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPSlovakIDCombinedRecognizerResult class])];
    
    if (res == nil)
        return nil;
    
    if (![res isKindOfClass:[PPSlovakIDCombinedRecognizerResult class]]) {
        NSLog(@"We expected %@, but didn't get it!", NSStringFromClass([PPSlovakIDCombinedRecognizerResult class]));
        return nil;
    }
    
    PPSlovakIDCombinedRecognizerResult *slovakRes = (PPSlovakIDCombinedRecognizerResult *)res;
    
    return slovakRes;
}

- (BOOL)hasAllDataInResult {
    
    PPSlovakIDCombinedRecognizerResult *slovakRes = [self getSlovakCombinedResult];
    
    if (slovakRes == nil) {
        return NO;
    }
    
    if ([slovakRes.firstName length] == 0) {
        NSLog(@"Result: We don't have the first name");
        return NO;
    }
    
    if ([slovakRes.identityCardNumber length] == 0) {
        NSLog(@"Result: We don't have document number");
        return NO;
    }
    
    if ([slovakRes.lastName length] == 0) {
        NSLog(@"Result: We don't have the last name");
        return NO;
    }
    
    if ([slovakRes.sex length] == 0) {
        NSLog(@"Result: We don't have sex");
        return NO;
    }
    
    if ([slovakRes.nationality length] == 0) {
        NSLog(@"Result: We don't have nationality");
        return NO;
    }
    
    if (slovakRes.dateOfBirth == nil) {
        NSLog(@"Result: We don't have date of birth");
        return NO;
    }
    
    if (slovakRes.documentDateOfExpiry == nil) {
        NSLog(@"Result: We don't have date of expiry");
        return NO;
    }
    
    if (slovakRes.personalIdentificationNumber == nil) {
        NSLog(@"Result: We don't have personal identification number");
        return NO;
    }
    
    
    if ([slovakRes.address length] == 0) {
        NSLog(@"Result: We don't have address");
        return NO;
    }
    
    if ([slovakRes.issuingAuthority length] == 0) {
        NSLog(@"Result: We don't have issuing authority");
        return NO;
    }
    
    return YES;
}

- (BOOL)hasMatchingData {
    
    PPSlovakIDCombinedRecognizerResult *slovakRes = [self getSlovakCombinedResult];
    
    if (slovakRes == nil) {
        return NO;
    }
    
    return slovakRes.matchingData;
}


@end
