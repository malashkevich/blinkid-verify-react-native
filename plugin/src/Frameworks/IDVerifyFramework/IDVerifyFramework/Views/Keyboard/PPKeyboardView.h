//
//  PPKeyboardView.h
//  IDVerifyFramework
//
//  Created by Jura on 31/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPStringConfusion.h"

@protocol PPKeyboardViewDelegate;

@interface PPKeyboardView : UIView

@property (nonatomic, weak) id<PPKeyboardViewDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame confusion:(PPStringConfusion *)confusion NS_DESIGNATED_INITIALIZER;

@end

@protocol PPKeyboardViewDelegate

- (void)keyboardView:(PPKeyboardView *)keyboardView didTapStringConfusion:(NSString *)confusion;

@end
