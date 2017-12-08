//
//  PPFieldResultItemView.m
//  IDVerifyFramework
//
//  Created by Jura on 12/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPFieldResultItemView.h"

#import "PPIdVerifySettings.h"
#import "UIImage+Utils.h"

@implementation PPFieldResultItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureTitleLabel];
        [self configureValueView];
    }
    return self;
}

- (void)configureTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.titleLabel.text = @"Title";
    self.titleLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:-2.f];
    self.titleLabel.textColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.cellTitleLabelColor;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 0;

    [self addSubview:self.titleLabel];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:[[self class] titleLabelLeft]];

    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-[[self class] titleLabelRight]];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:[[self class] titleLabelTop]];

    [self addConstraints:@[leftConstraint, rightConstraint, topConstraint]];
}

- (void)configureValueView {
    self.valueView = [[UITextView alloc] init];
    self.valueView.translatesAutoresizingMaskIntoConstraints = NO;
    self.valueView.editable = NO;
    self.valueView.clipsToBounds = NO;
    self.valueView.textContainer.lineFragmentPadding = 0;
    self.valueView.textContainerInset = UIEdgeInsetsZero;
    self.valueView.scrollEnabled = NO;
    self.valueView.backgroundColor = [UIColor clearColor];

    self.valueView.text = @"Value";
    self.valueView.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightRegular pointSizeDiff:2.f];
    self.valueView.textColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.cellTitleValueColor;
    self.valueView.textAlignment = NSTextAlignmentLeft;

    [self addSubview:self.valueView];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.valueView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:[[self class] valueLabelLeft]];

    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.valueView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-[[self class] valueLabelRight]];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.valueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:[[self class] valueLabelTop]];

    self.valueViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.valueView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-[[self class] valueLabelBottom]];

    [self addConstraints:@[leftConstraint, rightConstraint, topConstraint, self.valueViewBottomConstraint]];

}

+ (CGFloat)titleLabelLeft {
    return 12.f;
}

+ (CGFloat)titleLabelRight {
    return [[self class] titleLabelLeft];
}

+ (CGFloat)titleLabelTop {
    return 6.f;
}

+ (CGFloat)valueLabelTop {
    return 3.f;
}

+ (CGFloat)valueLabelBottom {
    return 6.f;
}

+ (CGFloat)valueLabelLeft {
    return [[self class] titleLabelLeft];
}

+ (CGFloat)valueLabelRight {
    return [[self class] titleLabelLeft];
}

@end
