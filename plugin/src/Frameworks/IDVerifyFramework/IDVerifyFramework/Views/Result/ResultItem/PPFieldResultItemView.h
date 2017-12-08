//
//  PPFieldResultItemView.h
//  IDVerifyFramework
//
//  Created by Jura on 12/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdResultItemView.h"

@interface PPFieldResultItemView : PPIdResultItemView

/** Key under which the data is stored in IDVerifyResult */
@property (nonatomic) NSString *originalKey;

@property (nonatomic) UILabel *titleLabel;

@property (nonatomic) UITextView *valueView;

@property (nonatomic) NSLayoutConstraint *valueViewBottomConstraint;

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/** Margins */

+ (CGFloat)titleLabelLeft;
+ (CGFloat)titleLabelRight;
+ (CGFloat)titleLabelTop;
+ (CGFloat)valueLabelTop;
+ (CGFloat)valueLabelBottom;
+ (CGFloat)valueLabelLeft;
+ (CGFloat)valueLabelRight;

@end
