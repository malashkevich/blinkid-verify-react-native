//
//  PPMrtdVerifyResult+Updates.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 06/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPMrtdVerifyResult+Updates.h"

@implementation PPMrtdVerifyResult (Updates)

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

- (PPMrtdCombinedRecognizerResult *)getMrtdCombinedResult {
    
    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPMrtdCombinedRecognizerResult class])];
    
    if (res == nil)
        return nil;
    
    if (![res isKindOfClass:[PPMrtdCombinedRecognizerResult class]]) {
        NSLog(@"We expected %@, but didn't get it!", NSStringFromClass([PPMrtdCombinedRecognizerResult class]));
        return nil;
    }
    
    PPMrtdCombinedRecognizerResult *mrtdRes = (PPMrtdCombinedRecognizerResult *)res;
    
    return mrtdRes;
}

- (BOOL)hasAllDataInResult {
    
    PPMrtdCombinedRecognizerResult *mrtdRes = [self getMrtdCombinedResult];
    
    if (mrtdRes == nil) {
        return NO;
    }
    
    if ([mrtdRes.secondaryId length] == 0) {
        NSLog(@"Result: We don't have the first name");
        return NO;
    }
    
    if ([mrtdRes.primaryId length] == 0) {
        NSLog(@"Result: We don't have the last name");
        return NO;
    }
    
    if ([mrtdRes.documentNumber length] == 0) {
        NSLog(@"Result: We don't have the identity number");
        return NO;
    }
    
    if ([mrtdRes.sex length] == 0) {
        NSLog(@"Result: We don't have sex");
        return NO;
    }
    
    if ([mrtdRes.nationality length] == 0) {
        NSLog(@"Result: We don't have nationality");
        return NO;
    }
    
    if (mrtdRes.dateOfBirth == nil) {
        NSLog(@"Result: We don't have date of birth");
        return NO;
    }
    
    if (mrtdRes.dateOfExpiry == nil) {
        NSLog(@"Result: We don't have date of expiry");
        return NO;
    }
    
    return YES;
}

- (BOOL)hasMatchingData {
    
    PPMrtdCombinedRecognizerResult *mrtdRes = [self getMrtdCombinedResult];
    
    if (mrtdRes == nil) {
        return NO;
    }
    
    return mrtdRes.matchingData;
}


@end
