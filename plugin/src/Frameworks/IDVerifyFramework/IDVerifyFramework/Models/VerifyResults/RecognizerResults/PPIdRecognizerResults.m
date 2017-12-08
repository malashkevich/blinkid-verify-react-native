//
//  PPIdScanResult.m
//  LivenessTest
//
//  Created by Jura on 02/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdRecognizerResults.h"

#import "PPRecognizerResult+Dictionary.h"

@interface PPIdRecognizerResults ()

@end

@implementation PPIdRecognizerResults

- (instancetype)init {
    self = [super init];
    if (self) {
        _images = [[NSMutableDictionary alloc] init];
        _results = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)clear {
    [self.images removeAllObjects];
    [self.results removeAllObjects];
}

- (void)addImageMetadata:(PPImageMetadata *)imageMetadata {
    [self.images setObject:[imageMetadata image] forKey:[imageMetadata name]];
}

- (void)addRecognizerResult:(PPRecognizerResult *)recognizerResult {
    [self.results setObject:recognizerResult forKey:NSStringFromClass([recognizerResult class])];
}

- (NSDictionary<NSString *, NSDictionary *> *)dictionariesForResults {
    NSMutableDictionary<NSString *, NSDictionary *> *allValues = [[NSMutableDictionary alloc] init];

    [self.results enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, PPRecognizerResult * _Nonnull obj, BOOL * _Nonnull stop) {
        [allValues setObject:[obj dictionary] forKey:key];
    }];

    return allValues;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, images %@, results %@", [super description], self.images, self.results];
}

@end
