//
//  PPTitleResultItemView.m
//  IDVerifyFramework
//
//  Created by Jura on 12/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPTitleResultItemView.h"

#import "PPIdVerifySettings.h"

@implementation PPTitleResultItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureTitleLabel];
    }
    return self;
}

- (void)configureTitleLabel {

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.titleLabel.text = @"Title";
    self.titleLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightRegular pointSizeDiff:2.f];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 0;

    [self addSubview:self.titleLabel];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:[[self class] titleLabelLeft]];

    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-[[self class] titleLabelRight]];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:[[self class] titleLabelTop]];

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-[[self class] titleLabelBottom]];

    [self addConstraints:@[leftConstraint, rightConstraint, topConstraint, bottomConstraint]];
}

+ (CGFloat)titleLabelLeft {
    return 12.f;
}

+ (CGFloat)titleLabelRight {
    return [[self class] titleLabelLeft];
}

+ (CGFloat)titleLabelTop {
    return 14.5f;
}

+ (CGFloat)titleLabelBottom {
    return [[self class] titleLabelTop];
}

@end
