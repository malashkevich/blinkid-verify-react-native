//
//  PPKeyboardViewModel.h
//  IDVerifyFramework
//
//  Created by Jura on 30/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPKeyboardConfusions.h"
#import "PPStringConfusion.h"

@interface PPKeyboardViewModel : NSObject

@property (nonatomic, strong, readonly) NSString *value;

@property (nonatomic, strong) NSString *result;

@property (nonatomic, strong, readonly) PPKeyboardConfusions* confusions;

@property (nonatomic, strong, readonly) NSArray<PPStringConfusion *> *stringConfusions;

@property (nonatomic, readonly) NSUInteger currentConfusionIndex;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithValue:(NSString *)value confusions:(PPKeyboardConfusions *)confusions NS_DESIGNATED_INITIALIZER;

- (PPStringConfusion *)currentConfusion;

- (BOOL)isFirstCofusion;

- (BOOL)isLastConfusion;

- (void)moveToNextConfusion;

- (void)moveToPreviousConfusion;

- (void)moveToConfusionAtIndex:(NSUInteger)index;

@end
