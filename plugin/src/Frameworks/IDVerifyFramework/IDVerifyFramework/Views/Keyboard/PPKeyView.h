//
//  PPKeyView.h
//  IDVerifyFramework
//
//  Created by Jura on 31/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PPKeyViewDelegate;


@interface PPKeyView : UIView

@property (nonatomic, strong) NSString *value;

@property (nonatomic, weak) id<PPKeyViewDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame value:(NSString *)value NS_DESIGNATED_INITIALIZER;

- (void)setActive;

- (void)setInactive;

@end

@protocol PPKeyViewDelegate

- (void)keyViewWasPressed:(PPKeyView *)keyView;

@end
