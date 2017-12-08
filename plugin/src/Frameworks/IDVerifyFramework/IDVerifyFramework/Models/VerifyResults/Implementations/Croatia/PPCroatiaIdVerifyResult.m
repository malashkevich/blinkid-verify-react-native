//
//  PPCroatiaIdVerifyResult.m
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPCroatiaIdVerifyResult.h"
#import "PPCroatiaIdViewResult.h"

@implementation PPCroatiaIdVerifyResult

- (instancetype)init {
    self = [super initWithViewResult:[[PPCroatiaIdViewResult alloc] init]];
    if (self) {
        // nothing here
    }
    return self;
}

- (PPCroatiaIdViewResult *)croatiaViewResult {
    return (PPCroatiaIdViewResult *)self.viewResult;
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    [self croatiaViewResult].faceImage = [self.recognizerResults.images objectForKey:[PPCroIDCombinedRecognizerSettings ID_FACE]];
    [self croatiaViewResult].selfieImage = [self.recognizerResults.images objectForKey:[PPLivenessRecognizerSettings ID_FACE]];
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)res {

    if (res == nil) {
        return;
    }

    if (![res isKindOfClass:[PPCroIDCombinedRecognizerResult class]]) {
        return;
    }

    PPCroIDCombinedRecognizerResult *croRes = (PPCroIDCombinedRecognizerResult *)res;

    [self croatiaViewResult].idNumber = croRes.identityCardNumber;

    [self croatiaViewResult].firstName = croRes.firstName;
    [self croatiaViewResult].lastName = croRes.lastName;

    NSDateFormatter *format = [[NSDateFormatter alloc] init];    
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setTimeStyle:NSDateFormatterNoStyle];
    [format setLocale:[NSLocale currentLocale]];

    [self croatiaViewResult].personalNumber = croRes.oib;
    [self croatiaViewResult].expiryDate = [format stringFromDate:croRes.documentDateOfExpiry];
    [self croatiaViewResult].issuingAuthority = croRes.issuingAuthority;
    [self croatiaViewResult].dateOfBirth = [format stringFromDate:croRes.dateOfBirth];
    [self croatiaViewResult].sex = croRes.sex;
    [self croatiaViewResult].address = croRes.address;
    [self croatiaViewResult].nationality = croRes.nationality;
    [self croatiaViewResult].dateOfIssue = [format stringFromDate:croRes.documentDateOfIssue];
}

- (NSDictionary *)dictionary {

    NSDictionary<NSString *, NSDictionary *> *recognizerDictionaries = [self.recognizerResults dictionariesForResults];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    {
        NSDictionary *croIdDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPCroIDCombinedRecognizerResult class])];
        if (croIdDict) {
            [dict setObject:croIdDict forKey:@"originalData"];
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
