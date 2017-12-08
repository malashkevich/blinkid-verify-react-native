//
//  PPAustriaIdVerifyResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 30/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPAustriaIdVerifyResult.h"

@implementation PPAustriaIdVerifyResult

- (instancetype)init {
    self = [super initWithViewResult:[[PPAustriaIdViewResult alloc] init]];
    if (self) {
        // nothing here
    }
    return self;
}

- (PPAustriaIdViewResult *)austriaViewResult {
    return (PPAustriaIdViewResult *)self.viewResult;
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    [self austriaViewResult].faceImage = [self.recognizerResults.images objectForKey:[PPAusIDCombinedRecognizerSettings ID_FACE]];
    [self austriaViewResult].selfieImage = [self.recognizerResults.images objectForKey:[PPLivenessRecognizerSettings ID_FACE]];
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)res {

    if (res == nil) {
        return;
    }

    if (![res isKindOfClass:[PPAusIDCombinedRecognizerResult class]]) {
        return;
    }

    PPAusIDCombinedRecognizerResult *ausRes = (PPAusIDCombinedRecognizerResult *)res;

    [self austriaViewResult].idNumber = ausRes.documentNumber;

    [self austriaViewResult].firstName = ausRes.firstName;
    [self austriaViewResult].lastName = ausRes.lastName;

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy."];

    [self austriaViewResult].expiryDate = [format stringFromDate:ausRes.documentDateOfExpiry];
    [self austriaViewResult].issuingAuthority = ausRes.issuingAuthority;
    [self austriaViewResult].dateOfBirth = [format stringFromDate:ausRes.dateOfBirth];
    [self austriaViewResult].sex = ausRes.sex;
    [self austriaViewResult].principalResidence = ausRes.principalResidence;
    [self austriaViewResult].placeOfBirth = ausRes.placeOfBirth;
    [self austriaViewResult].height = ausRes.height;
    [self austriaViewResult].eyeColor = ausRes.eyeColor;
    [self austriaViewResult].dateOfIssue = [format stringFromDate:ausRes.dateOfIssue];
}

- (NSDictionary *)dictionary {

    NSDictionary<NSString *, NSDictionary *> *recognizerDictionaries = [self.recognizerResults dictionariesForResults];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    {
        NSDictionary *ausIdDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPAusIDCombinedRecognizerResult class])];
        if (ausIdDict) {
            [dict setObject:ausIdDict forKey:@"originalData"];
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
