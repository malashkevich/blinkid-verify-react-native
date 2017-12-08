//
//  PPSingaporeIdVerifyResult+Updates.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSingaporeIdVerifyResult+Updates.h"

@implementation PPSingaporeIdVerifyResult (Updates)

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

- (PPSingaporeIDCombinedRecognizerResult *)getSingaporeCombinedResult {
    
    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPSingaporeIDCombinedRecognizerResult class])];
    
    if (res == nil)
        return nil;
    
    if (![res isKindOfClass:[PPSingaporeIDCombinedRecognizerResult class]]) {
        NSLog(@"We expected %@, but didn't get it!", NSStringFromClass([PPSingaporeIDCombinedRecognizerResult class]));
        return nil;
    }
    
    PPSingaporeIDCombinedRecognizerResult *singaporeRes = (PPSingaporeIDCombinedRecognizerResult *)res;
    
    return singaporeRes;
}

- (BOOL)hasAllDataInResult {
    
    PPSingaporeIDCombinedRecognizerResult *singaporeRes = [self getSingaporeCombinedResult];
    
    if (singaporeRes == nil) {
        return NO;
    }
    
    if ([singaporeRes.name length] == 0) {
        NSLog(@"Result: We don't have the first name");
        return NO;
    }
    
    if ([singaporeRes.address length] == 0) {
        NSLog(@"Result: We don't have the last name");
        return NO;
    }
    
    if ([singaporeRes.identityCardNumber length] == 0) {
        NSLog(@"Result: We don't have the identity number");
        return NO;
    }
    
    if ([singaporeRes.sex length] == 0) {
        NSLog(@"Result: We don't have sex");
        return NO;
    }
    
    if (singaporeRes.dateOfBirth == nil) {
        NSLog(@"Result: We don't have date of birth");
        return NO;
    }
    
    if (singaporeRes.documentDateOfIssue == nil) {
        NSLog(@"Result: We don't have date issue");
        return NO;
    }
    
    if (singaporeRes.race == nil) {
        NSLog(@"Result: We don't have race");
        return NO;
    }
    
    return YES;
}

- (BOOL)hasMatchingData {
    
    PPSingaporeIDCombinedRecognizerResult *singaporeRes = [self getSingaporeCombinedResult];
    
    if (singaporeRes == nil) {
        return NO;
    }
    
    return singaporeRes.matchingData;
}

@end
