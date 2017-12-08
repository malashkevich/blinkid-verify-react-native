//
//  PPCzechIdVerifyResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 30/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPCzechIdVerifyResult.h"

@implementation PPCzechIdVerifyResult

- (instancetype)init {
    self = [super initWithViewResult:[[PPCzechIdViewResult alloc] init]];
    if (self) {
        // nothing here
    }
    return self;
}

- (PPCzechIdViewResult *)czechViewResult {
    return (PPCzechIdViewResult *)self.viewResult;
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    [self czechViewResult].faceImage = [self.recognizerResults.images objectForKey:[PPCzIDCombinedRecognizerSettings ID_FACE]];
    [self czechViewResult].selfieImage = [self.recognizerResults.images objectForKey:[PPLivenessRecognizerSettings ID_FACE]];
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)res {
    
    if (res == nil) {
        return;
    }
    
    if (![res isKindOfClass:[PPCzIDCombinedRecognizerResult class]]) {
        return;
    }
    
    PPCzIDCombinedRecognizerResult *czRes = (PPCzIDCombinedRecognizerResult *)res;
    
    [self czechViewResult].idNumber = czRes.identityCardNumber;
    
    [self czechViewResult].firstName = czRes.firstName;
    [self czechViewResult].lastName = czRes.lastName;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];    
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setTimeStyle:NSDateFormatterNoStyle];
    [format setLocale:[NSLocale currentLocale]];
    
    [self czechViewResult].expiryDate = [format stringFromDate:czRes.documentDateOfExpiry];
    [self czechViewResult].issuingAuthority = czRes.issuingAuthority;
    [self czechViewResult].dateOfBirth = [format stringFromDate:czRes.dateOfBirth];
    [self czechViewResult].sex = czRes.sex;
    [self czechViewResult].address = czRes.address;
    [self czechViewResult].nationality = czRes.nationality;
    [self czechViewResult].placeOfBirth = czRes.placeOfBirth;
    [self czechViewResult].personalIdentificationNumber = czRes.personalIdentificationNumber;
    [self czechViewResult].dateOfIssue = [format stringFromDate:czRes.dateOfIssue];
}

- (NSDictionary *)dictionary {
    
    NSDictionary<NSString *, NSDictionary *> *recognizerDictionaries = [self.recognizerResults dictionariesForResults];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    {
        NSDictionary *czIdDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPCzIDCombinedRecognizerResult class])];
        if (czIdDict) {
            [dict setObject:czIdDict forKey:@"originalData"];
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
