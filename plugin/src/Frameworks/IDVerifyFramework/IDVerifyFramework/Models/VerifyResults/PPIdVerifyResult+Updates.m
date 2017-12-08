//
//  PPIdVerifyResult+Updates.m
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPIdVerifyResult+Updates.h"

@implementation PPIdVerifyResult (Updates)

- (void)addImageMetadata:(PPImageMetadata *)imageMetadata {
    [self.recognizerResults addImageMetadata:imageMetadata];
}

- (void)addRecognizerResult:(PPRecognizerResult *)recognizerResult {
    [self.recognizerResults addRecognizerResult:recognizerResult];
}

@end
