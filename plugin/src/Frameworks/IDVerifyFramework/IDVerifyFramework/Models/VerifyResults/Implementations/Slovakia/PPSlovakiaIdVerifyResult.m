//
//  PPSlovakiaIdVerifyResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSlovakiaIdVerifyResult.h"

@implementation PPSlovakiaIdVerifyResult

- (instancetype)init {
    self = [super initWithViewResult:[[PPSlovakiaIdViewResult alloc] init]];
    if (self) {
        // nothing here
    }
    return self;
}

- (PPSlovakiaIdViewResult *)slovakiaViewResult {
    return (PPSlovakiaIdViewResult *)self.viewResult;
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    [self slovakiaViewResult].faceImage = [self.recognizerResults.images objectForKey:[PPSlovakIDCombinedRecognizerSettings ID_FACE]];
    [self slovakiaViewResult].selfieImage = [self.recognizerResults.images objectForKey:[PPLivenessRecognizerSettings ID_FACE]];
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)res {
    
    if (res == nil) {
        return;
    }
    
    if (![res isKindOfClass:[PPSlovakIDCombinedRecognizerResult class]]) {
        return;
    }
    
    PPSlovakIDCombinedRecognizerResult *slovakRes = (PPSlovakIDCombinedRecognizerResult *)res;
    
    [self slovakiaViewResult].idNumber = slovakRes.identityCardNumber;
    
    [self slovakiaViewResult].firstName = slovakRes.firstName;
    [self slovakiaViewResult].lastName = slovakRes.lastName;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];    
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setTimeStyle:NSDateFormatterNoStyle];
    [format setLocale:[NSLocale currentLocale]];
    
    [self slovakiaViewResult].placeOfBirth = slovakRes.placeOfBirth;
    [self slovakiaViewResult].dateOfBirth = [format stringFromDate:slovakRes.dateOfBirth];
    [self slovakiaViewResult].sex = slovakRes.sex;
    [self slovakiaViewResult].nationality = slovakRes.nationality;
    [self slovakiaViewResult].address = slovakRes.address;
    [self slovakiaViewResult].issuingAuthority = slovakRes.issuingAuthority;
    [self slovakiaViewResult].personalIdentificationNumber = slovakRes.personalIdentificationNumber;
    [self slovakiaViewResult].specialRemarks = slovakRes.specialRemarks;
    [self slovakiaViewResult].surnameAtBirth = slovakRes.surnameAtBirth;
    [self slovakiaViewResult].dateOfIssue = [format stringFromDate:slovakRes.documentDateOfIssue];
    [self slovakiaViewResult].expiryDate = [format stringFromDate:slovakRes.documentDateOfExpiry];
}

- (NSDictionary *)dictionary {
    
    NSDictionary<NSString *, NSDictionary *> *recognizerDictionaries = [self.recognizerResults dictionariesForResults];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    {
        NSDictionary *slovakIdDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPSlovakIDCombinedRecognizerResult class])];
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
