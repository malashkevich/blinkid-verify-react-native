//
//  PPConfusion.h
//  IDVerifyFramework
//
//  Created by Jura on 31/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPStringConfusion : NSObject

@property (nonatomic, strong, readonly) NSString *originalString;

@property (nonatomic, readonly) NSRange range;

@property (nonatomic, strong) NSString *currentValue;

@property (nonatomic, strong, readonly) NSArray<NSString *> *confusions;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithOriginalString:(NSString *)originalString
                                 range:(NSRange)range
                          currentValue:(NSString *)currentValue
                            confusions:(NSArray<NSString *> *)confusions;

@end
