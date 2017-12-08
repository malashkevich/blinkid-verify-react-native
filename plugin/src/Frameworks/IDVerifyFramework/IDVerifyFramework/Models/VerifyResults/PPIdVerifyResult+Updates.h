//
//  PPIdVerifyResult+Updates.h
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPIdVerifyResult.h"

@interface PPIdVerifyResult (Updates)

- (void)addImageMetadata:(PPImageMetadata *)imageMetadata;

- (void)addRecognizerResult:(PPRecognizerResult *)recognizerResult;

@end
