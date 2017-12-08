//
//  PPLivenessRecognizerResult+Test.h
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import <MicroBlink/MicroBlink.h>

@interface PPLivenessRecognizerResult (Test)

- (instancetype)initWithAlive:(BOOL)alive
                    signature:(NSData *)signature
             signatureVersion:(NSString *)signatureVersion
                    faceImage:(NSData *)faceImage;

+ (PPLivenessRecognizerResult *)failedSignatureResult;

+ (PPLivenessRecognizerResult *)realSignatureResult;

@end
