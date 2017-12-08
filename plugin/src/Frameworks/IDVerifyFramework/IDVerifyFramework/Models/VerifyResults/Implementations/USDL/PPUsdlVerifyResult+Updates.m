//
//  PPUsdlVerifyResult+Updates.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPUsdlVerifyResult+Updates.h"

@implementation PPUsdlVerifyResult (Updates)

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

- (PPUsdlCombinedRecognizerResult *)getUsdlCombinedResult {
    
    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPUsdlCombinedRecognizerResult class])];
    
    if (res == nil)
        return nil;
    
    if (![res isKindOfClass:[PPUsdlCombinedRecognizerResult class]]) {
        NSLog(@"We expected %@, but didn't get it!", NSStringFromClass([PPUsdlCombinedRecognizerResult class]));
        return nil;
    }
    
    PPUsdlCombinedRecognizerResult *usdlRes = (PPUsdlCombinedRecognizerResult *)res;
    
    return usdlRes;
}

- (BOOL)hasAllDataInResult {
    
    PPUsdlCombinedRecognizerResult *usdlRes = [self getUsdlCombinedResult];
    
    if (usdlRes == nil) {
        return NO;
    }
    
    if ([[usdlRes getField:kPPCustomerFirstName] length] == 0) {
        NSLog(@"Result: We don't have the first name");
        return NO;
    }
    
    if ([[usdlRes getField:kPPCustomerFamilyName] length] == 0) {
        NSLog(@"Result: We don't have the last name");
        return NO;
    }
    
    if ([[usdlRes getField:kPPCustomerIdNumber] length] == 0) {
        NSLog(@"Result: We don't have the identity number");
        return NO;
    }
    
    if ([[usdlRes getField:kPPSex] length] == 0) {
        NSLog(@"Result: We don't have sex");
        return NO;
    }
    
    if ([[usdlRes getField:kPPDateOfBirth] length] == 0) {
        NSLog(@"Result: We don't have date of birth");
        return NO;
    }
    
    if ([[usdlRes getField:kPPDocumentExpirationDate] length] == 0) {
        NSLog(@"Result: We don't have date of expiry");
        return NO;
    }
    
    if ([[usdlRes getField:kPPDocumentIssueDate] length] == 0) {
        NSLog(@"Result: We don't have date of issue");
        return NO;
    }
    
    if ([[usdlRes getField:kPPFullAddress] length] == 0) {
        NSLog(@"Result: We don't have address");
        return NO;
    }
    
    if ([[usdlRes getField:kPPAddressJurisdictionCode] length] == 0) {
        NSLog(@"Result: We don't have issuing authority");
        return NO;
    }
    
    return YES;
}

- (BOOL)hasMatchingData {
    
    PPUsdlCombinedRecognizerResult *usdlRes = [self getUsdlCombinedResult];
    
    if (usdlRes == nil) {
        return NO;
    }
    
    return usdlRes.matchingData;
}

@end
