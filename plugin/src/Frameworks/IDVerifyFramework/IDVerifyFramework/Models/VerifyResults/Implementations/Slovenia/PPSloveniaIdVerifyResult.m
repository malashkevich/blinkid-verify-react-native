//
//  PPSloveniaIdVerifyResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSloveniaIdVerifyResult.h"

@implementation PPSloveniaIdVerifyResult

- (instancetype)init {
    self = [super initWithViewResult:[[PPSloveniaIdViewResult alloc] init]];
    if (self) {
        // nothing here
    }
    return self;
}

- (PPSloveniaIdViewResult *)sloveniaViewResult {
    return (PPSloveniaIdViewResult *)self.viewResult;
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    [self sloveniaViewResult].faceImage = [self.recognizerResults.images objectForKey:[PPSlovenianIDCombinedRecognizerSettings ID_FACE]];
    [self sloveniaViewResult].selfieImage = [self.recognizerResults.images objectForKey:[PPLivenessRecognizerSettings ID_FACE]];
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)res {
    
    if (res == nil) {
        return;
    }
    
    if (![res isKindOfClass:[PPSlovenianIDCombinedRecognizerResult class]]) {
        return;
    }
    
    PPSlovenianIDCombinedRecognizerResult *sloveniaRes = (PPSlovenianIDCombinedRecognizerResult *)res;
    
    [self sloveniaViewResult].idNumber = sloveniaRes.identityCardNumber;
    
    [self sloveniaViewResult].firstName = sloveniaRes.firstName;
    [self sloveniaViewResult].lastName = sloveniaRes.lastName;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];    
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setTimeStyle:NSDateFormatterNoStyle];
    [format setLocale:[NSLocale currentLocale]];
    
    [self sloveniaViewResult].dateOfBirth = [format stringFromDate:sloveniaRes.dateOfBirth];
    [self sloveniaViewResult].sex = sloveniaRes.sex;
    [self sloveniaViewResult].citizenship = sloveniaRes.citizenship;
    [self sloveniaViewResult].address = sloveniaRes.address;
    [self sloveniaViewResult].issuingAuthority = sloveniaRes.issuingAuthority;
    [self sloveniaViewResult].personalIdentificationNumber = sloveniaRes.personalIdentificationNumber;
    [self sloveniaViewResult].dateOfIssue = [format stringFromDate:sloveniaRes.documentDateOfIssue];
    [self sloveniaViewResult].expiryDate = [format stringFromDate:sloveniaRes.documentDateOfExpiry];
}

- (NSDictionary *)dictionary {
    
    NSDictionary<NSString *, NSDictionary *> *recognizerDictionaries = [self.recognizerResults dictionariesForResults];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    {
        NSDictionary *slovakIdDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPSlovenianIDCombinedRecognizerResult class])];
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
