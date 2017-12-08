//
//  PPUsdlVerifyResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPUsdlVerifyResult.h"

@implementation PPUsdlVerifyResult

- (instancetype)init {
    self = [super initWithViewResult:[[PPUsdlViewResult alloc] init]];
    if (self) {
        // nothing here
    }
    return self;
}

- (PPUsdlViewResult *)usdlViewResult {
    return (PPUsdlViewResult *)self.viewResult;
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    [self usdlViewResult].faceImage = [self.recognizerResults.images objectForKey:[PPUsdlCombinedRecognizerSettings ID_FACE]];
    [self usdlViewResult].selfieImage = [self.recognizerResults.images objectForKey:[PPLivenessRecognizerSettings ID_FACE]];
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)res {
    
    if (res == nil) {
        return;
    }
    
    if (![res isKindOfClass:[PPUsdlCombinedRecognizerResult class]]) {
        return;
    }
    
    PPUsdlCombinedRecognizerResult *usdlRes = (PPUsdlCombinedRecognizerResult *)res;
    
    [self usdlViewResult].idNumber = [usdlRes getField:kPPCustomerIdNumber];
    
    [self usdlViewResult].firstName = [usdlRes getField:kPPCustomerFirstName];
    [self usdlViewResult].lastName = [usdlRes getField:kPPCustomerFamilyName];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMddyyyy"];
    
    NSDate *dateOfBirth = [format dateFromString:[usdlRes getField:kPPDateOfBirth]];
    NSDate *dateofIssue = [format dateFromString:[usdlRes getField:kPPDocumentIssueDate]];
    NSDate *dateOfExpiration = [format dateFromString:[usdlRes getField:kPPDocumentExpirationDate]];
    
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setTimeStyle:NSDateFormatterNoStyle];
    [format setLocale:[NSLocale currentLocale]];
    
    [self usdlViewResult].dateOfBirth = [format stringFromDate:dateOfBirth];
    [self usdlViewResult].sex = [usdlRes getField:kPPSex];
    [self usdlViewResult].address = [usdlRes getField:kPPFullAddress];
    [self usdlViewResult].issuingAuthority = [usdlRes getField:kPPAddressJurisdictionCode];
    
    [self usdlViewResult].dateOfIssue = [format stringFromDate:dateofIssue];
    [self usdlViewResult].expiryDate = [format stringFromDate:dateOfExpiration];
}

- (NSDictionary *)dictionary {
    
    NSDictionary<NSString *, NSDictionary *> *recognizerDictionaries = [self.recognizerResults dictionariesForResults];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    {
        NSDictionary *slovakIdDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPUsdlCombinedRecognizerResult class])];
        if (slovakIdDict) {
            [dict setObject:slovakIdDict forKey:@"originalData"];
        }
    }
    
    {
        NSDictionary *livenessDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPLivenessRecognizerResult class])];
        if (livenessDict) {
            [dict setObject:livenessDict forKey:@"livenessData"];
        }
    }
    
    [dict setObject:[self editedDictionary] forKey:@"editedData"];
    [dict setObject:[self insertedDictionary] forKey:@"insertedData"];
    
    return dict;
}

@end
