//
//  PPIdVerifyResult.m
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdVerifyResult.h"

@implementation PPIdVerifyResult

- (instancetype)initWithViewResult:(PPIdViewResult *)viewResult {
    self = [super init];
    if (self) {
        _recognizerResults = [[PPIdRecognizerResults alloc] init];
        _viewResult = viewResult;
        _editedDictionary = [[NSMutableDictionary alloc] init];
        _insertedDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setViewResult:(PPIdViewResult *)viewResult {
    _viewResult = viewResult;
}

- (NSDictionary *)dictionary {
    exit(-1);
}

- (void)clear {
    [_recognizerResults clear];
}

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata {
    exit(-1);
}

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)recognizerResult {
    exit(-1);
}

- (void)editedKey:(NSString *)key newValue:(NSString *)value {
    [self.editedDictionary setObject:value forKey:key];
    [self.viewResult updatePropertyForKey:key value:value];
}

- (void)insertedKey:(NSString *)key value:(NSString *)value {
    [self.insertedDictionary setObject:value forKey:key];
    [self.viewResult updatePropertyForKey:key value:value];
}

- (BOOL)alive {
    PPRecognizerResult *res = [self.recognizerResults.results objectForKey:NSStringFromClass([PPLivenessRecognizerResult class])];

    if (res == nil || ![res isKindOfClass:[PPLivenessRecognizerResult class]]) {
        return NO;
    }

    PPLivenessRecognizerResult *livenessResult = (PPLivenessRecognizerResult *)res;

    return livenessResult.alive;
}

- (BOOL)edited {
    return [self.editedDictionary count] > 0;
}

@end
