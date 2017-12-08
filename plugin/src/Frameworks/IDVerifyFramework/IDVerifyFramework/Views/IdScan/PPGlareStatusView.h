//
//  PPGlareStatusView.h
//  IDVerifyFramework
//
//  Created by Jura on 19/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MicroBlink/MicroBlink.h>

@interface PPGlareStatusView : UIView

@property (nonatomic) UILabel *label;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

- (void)setStatus:(PPRecognitionStatus)status;

@end
