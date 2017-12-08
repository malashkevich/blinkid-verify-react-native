//
//  PPMrtdVerifyResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 06/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPMrtdVerifyResult.h"

@implementation PPMrtdVerifyResult

- (instancetype)init {
    self = [super initWithViewResult:[[PPMrtdViewResult alloc] init]];
    if (self) {
        // nothing here
    }
    return self;
}

- (PPMrtdViewResult *)mrtdViewResult {
    return (PPMrtdViewResult *)self.viewResult;
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    [self mrtdViewResult].faceImage = [self.recognizerResults.images objectForKey:[PPMrtdCombinedRecognizerSettings ID_FACE]];
    [self mrtdViewResult].selfieImage = [self.recognizerResults.images objectForKey:[PPLivenessRecognizerSettings ID_FACE]];
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)res {
    
    if (res == nil) {
        return;
    }
    
    if (![res isKindOfClass:[PPMrtdCombinedRecognizerResult class]]) {
        return;
    }
    
    PPMrtdCombinedRecognizerResult *mrtdRes = (PPMrtdCombinedRecognizerResult *)res;
    
    [self mrtdViewResult].idNumber = mrtdRes.documentNumber;
    [self mrtdViewResult].documentCode = mrtdRes.documentCode;
    
    [self mrtdViewResult].firstName = mrtdRes.secondaryId;
    [self mrtdViewResult].lastName = mrtdRes.primaryId;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy."];
    
    [self mrtdViewResult].expiryDate = [format stringFromDate:mrtdRes.dateOfExpiry];
    [self mrtdViewResult].issuingAuthority = mrtdRes.issuer;
    [self mrtdViewResult].dateOfBirth = [format stringFromDate:mrtdRes.dateOfBirth];
    [self mrtdViewResult].sex = mrtdRes.sex;
    [self mrtdViewResult].nationality = mrtdRes.nationality;

    [self mrtdViewResult].opt1 = mrtdRes.opt1;
    [self mrtdViewResult].opt2 = mrtdRes.opt2;
}

- (NSDictionary *)dictionary {
    
    NSDictionary<NSString *, NSDictionary *> *recognizerDictionaries = [self.recognizerResults dictionariesForResults];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    {
        NSDictionary *ausIdDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPMrtdCombinedRecognizerResult class])];
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
