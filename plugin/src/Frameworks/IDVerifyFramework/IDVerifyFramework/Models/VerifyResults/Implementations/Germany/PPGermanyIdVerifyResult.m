
//
//  PPGermanyIdVerifyResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 29/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPGermanyIdVerifyResult.h"

#import "PPGermanyIdViewResult.h"

@implementation PPGermanyIdVerifyResult

- (instancetype)init {
    self = [super initWithViewResult:[[PPGermanyIdViewResult alloc] init]];
    if (self) {
        // nothing here
    }
    return self;
}

- (PPGermanyIdViewResult *)germanyViewResult {
    return (PPGermanyIdViewResult *)self.viewResult;
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    [self germanyViewResult].faceImage = [self.recognizerResults.images objectForKey:[PPGermanIDCombinedRecognizerSettings ID_FACE]];
    [self germanyViewResult].selfieImage = [self.recognizerResults.images objectForKey:[PPLivenessRecognizerSettings ID_FACE]];
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)res {

    if (res == nil) {
        return;
    }

    if (![res isKindOfClass:[PPGermanIDCombinedRecognizerResult class]]) {
        return;
    }

    PPGermanIDCombinedRecognizerResult *gerRes = (PPGermanIDCombinedRecognizerResult *)res;

    [self germanyViewResult].idNumber = gerRes.identityCardNumber;

    [self germanyViewResult].firstName = gerRes.firstName;
    [self germanyViewResult].lastName = gerRes.lastName;

    NSDateFormatter *format = [[NSDateFormatter alloc] init];    
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setTimeStyle:NSDateFormatterNoStyle];
    [format setLocale:[NSLocale currentLocale]];

    [self germanyViewResult].expiryDate = [format stringFromDate:gerRes.documentDateOfExpiry];
    [self germanyViewResult].issuingAuthority = gerRes.issuingAuthority;
    [self germanyViewResult].dateOfBirth = [format stringFromDate:gerRes.dateOfBirth];
    [self germanyViewResult].sex = gerRes.sex;
    [self germanyViewResult].address = gerRes.address;
    [self germanyViewResult].nationality = gerRes.nationality;
    [self germanyViewResult].placeOfBirth = gerRes.placeOfBirth;
    [self germanyViewResult].height = gerRes.height;
    [self germanyViewResult].eyeColor = gerRes.eyeColor;
    [self germanyViewResult].dateOfIssue = [format stringFromDate:gerRes.documentDateOfIssue];
}

- (NSDictionary *)dictionary {

    NSDictionary<NSString *, NSDictionary *> *recognizerDictionaries = [self.recognizerResults dictionariesForResults];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    {
        NSDictionary *gerIdDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPGermanIDCombinedRecognizerResult class])];
        if (gerIdDict) {
            [dict setObject:gerIdDict forKey:@"originalData"];
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
