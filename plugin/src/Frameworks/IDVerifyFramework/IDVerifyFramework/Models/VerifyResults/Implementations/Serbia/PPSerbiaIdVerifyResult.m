//
//  PPSerbiaIdVerifyResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSerbiaIdVerifyResult.h"

@implementation PPSerbiaIdVerifyResult

- (instancetype)init {
    self = [super initWithViewResult:[[PPSerbiaIdViewResult alloc] init]];
    if (self) {
        // nothing here
    }
    return self;
}

- (PPSerbiaIdViewResult *)serbiaViewResult {
    return (PPSerbiaIdViewResult *)self.viewResult;
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    [self serbiaViewResult].faceImage = [self.recognizerResults.images objectForKey:[PPSerbianIDCombinedRecognizerSettings ID_FACE]];
    [self serbiaViewResult].selfieImage = [self.recognizerResults.images objectForKey:[PPLivenessRecognizerSettings ID_FACE]];
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)res {
    
    if (res == nil) {
        return;
    }
    
    if (![res isKindOfClass:[PPSerbianIDCombinedRecognizerResult class]]) {
        return;
    }
    
    PPSerbianIDCombinedRecognizerResult *srbRes = (PPSerbianIDCombinedRecognizerResult *)res;
    
    [self serbiaViewResult].idNumber = srbRes.identityCardNumber;
    
    [self serbiaViewResult].firstName = srbRes.firstName;
    [self serbiaViewResult].lastName = srbRes.lastName;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];    
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setTimeStyle:NSDateFormatterNoStyle];
    [format setLocale:[NSLocale currentLocale]];
    
    [self serbiaViewResult].expiryDate = [format stringFromDate:srbRes.documentDateOfExpiry];
    [self serbiaViewResult].issuingAuthority = srbRes.issuingAuthority;
    [self serbiaViewResult].dateOfBirth = [format stringFromDate:srbRes.dateOfBirth];
    [self serbiaViewResult].sex = srbRes.sex;
    [self serbiaViewResult].nationality = srbRes.nationality;
    [self serbiaViewResult].JMBG = srbRes.JMBG;
    [self serbiaViewResult].dateOfIssue = [format stringFromDate:srbRes.documentDateOfIssue];
}

- (NSDictionary *)dictionary {
    
    NSDictionary<NSString *, NSDictionary *> *recognizerDictionaries = [self.recognizerResults dictionariesForResults];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    {
        NSDictionary *srbIdDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPSerbianIDCombinedRecognizerResult class])];
        if (srbIdDict) {
            [dict setObject:srbIdDict forKey:@"originalData"];
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
