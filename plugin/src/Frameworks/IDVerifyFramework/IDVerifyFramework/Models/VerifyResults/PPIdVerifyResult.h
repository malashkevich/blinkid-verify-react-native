//
//  PPIdVerifyResult.h
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdRecognizerResults.h"
#import "PPIdViewResult.h"

#import <Foundation/Foundation.h>

@class PPImageMetadata;
@class PPRecognizerResult;

@interface PPIdVerifyResult : NSObject

@property (nonatomic, readonly) PPIdRecognizerResults *recognizerResults;

@property (nonatomic, readonly) PPIdViewResult *viewResult;

@property (nonatomic, readonly) NSDictionary *dictionary;

@property (nonatomic, readonly) NSMutableDictionary<NSString *, NSString *> *editedDictionary;

@property (nonatomic, readonly) NSMutableDictionary<NSString *, NSString *> *insertedDictionary;

@property (nonatomic, readonly) BOOL alive;

@property (nonatomic, readonly) BOOL edited;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithViewResult:(PPIdViewResult *)viewResult NS_DESIGNATED_INITIALIZER;

- (void)clear;

- (void)populateViewResultWithMetadata:(PPImageMetadata *)imageMetadata;

- (void)populateViewResultWithRecognizerResult:(PPRecognizerResult *)recognizerResult;

- (void)editedKey:(NSString *)key newValue:(NSString *)value;

- (void)insertedKey:(NSString *)key value:(NSString *)value;

@end
