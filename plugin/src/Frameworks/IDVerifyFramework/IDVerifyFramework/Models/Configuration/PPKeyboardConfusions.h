//
//  PPKeyboardConfusions.h
//  IDVerifyFramework
//
//  Created by Jura on 30/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PPStringConfusion.h"

@interface PPKeyboardConfusions : NSObject <NSCoding>

@property (nonatomic) NSUInteger maxConfusionLength;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithConfusions:(NSArray<NSArray<NSString *> *> *)confusions NS_DESIGNATED_INITIALIZER;

- (NSArray<NSString *> *)confusionsForString:(NSString *)str;

- (NSArray<PPStringConfusion *> *)getStringConfusionsForText:(NSString *)text;

@end
