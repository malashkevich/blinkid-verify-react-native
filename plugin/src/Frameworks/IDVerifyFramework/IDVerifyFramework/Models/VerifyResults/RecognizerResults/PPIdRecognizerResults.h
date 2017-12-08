//
//  PPIdScanResult.h
//  LivenessTest
//
//  Created by Jura on 02/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <MicroBlink/MicroBlink.h>

@interface PPIdRecognizerResults : NSObject

@property (nonatomic) NSMutableDictionary<NSString *, UIImage *> *images;

@property (nonatomic) NSMutableDictionary<NSString *, PPRecognizerResult *> *results;

- (void)clear;

- (void)addImageMetadata:(PPImageMetadata *)imageMetadata;

- (void)addRecognizerResult:(PPRecognizerResult *)recognizerResult;

- (NSDictionary<NSString *, NSDictionary *> *)dictionariesForResults;

@end
