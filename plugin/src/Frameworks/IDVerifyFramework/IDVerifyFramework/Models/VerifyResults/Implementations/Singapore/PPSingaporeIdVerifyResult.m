//
//  PPSingaporeIdVerifyResult.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSingaporeIdVerifyResult.h"

@implementation PPSingaporeIdVerifyResult

- (instancetype)init {
    self = [super initWithViewResult:[[PPSingaporeIdViewResult alloc] init]];
    if (self) {
        // nothing here
    }
    return self;
}

- (PPSingaporeIdViewResult *)singaporeViewResult {
    return (PPSingaporeIdViewResult *)self.viewResult;
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    [self singaporeViewResult].faceImage = [self.recognizerResults.images objectForKey:[PPSingaporeIDCombinedRecognizerSettings ID_FACE]];
    [self singaporeViewResult].selfieImage = [self.recognizerResults.images objectForKey:[PPLivenessRecognizerSettings ID_FACE]];
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)res {
    
    if (res == nil) {
        return;
    }
    
    if (![res isKindOfClass:[PPSingaporeIDCombinedRecognizerResult class]]) {
        return;
    }
    
    PPSingaporeIDCombinedRecognizerResult *singaporeRes = (PPSingaporeIDCombinedRecognizerResult *)res;
    
    [self singaporeViewResult].idNumber = singaporeRes.identityCardNumber;
    
    [self singaporeViewResult].name = singaporeRes.name;
    [self singaporeViewResult].race = singaporeRes.race;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];    
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setTimeStyle:NSDateFormatterNoStyle];
    [format setLocale:[NSLocale currentLocale]];
    
    [self singaporeViewResult].countryOfBirth = singaporeRes.countryOfBirth;
    [self singaporeViewResult].dateOfBirth = [format stringFromDate:singaporeRes.dateOfBirth];
    [self singaporeViewResult].sex = singaporeRes.sex;
    [self singaporeViewResult].bloodGroup = singaporeRes.bloodGroup;
    [self singaporeViewResult].address = singaporeRes.address;
    [self singaporeViewResult].dateOfIssue = [format stringFromDate:singaporeRes.documentDateOfIssue];
}

- (NSDictionary *)dictionary {
    
    NSDictionary<NSString *, NSDictionary *> *recognizerDictionaries = [self.recognizerResults dictionariesForResults];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    {
        NSDictionary *singaporeIdDict = [recognizerDictionaries objectForKey:NSStringFromClass([PPSingaporeIDCombinedRecognizerResult class])];
        if (singaporeIdDict) {
            [dict setObject:singaporeIdDict forKey:@"originalData"];
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
