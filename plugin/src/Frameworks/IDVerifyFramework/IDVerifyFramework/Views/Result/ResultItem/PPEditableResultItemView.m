//
//  PPEditableResultItemView.m
//  IDVerifyFramework
//
//  Created by Jura on 12/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPEditableResultItemView.h"

#import "PPIdVerifySettings.h"
#import "UIImage+Utils.h"

@implementation PPEditableFieldResultItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureEditButton];
    }
    return self;
}

- (void)configureEditButton {
    self.editButton = [[UIButton alloc] init];
    self.editButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.editButton setBackgroundImage:[[UIImage pp_imageInResourcesBundleNamed:@"editMaterialIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.editButton.tintColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;
    [self.editButton addTarget:self action:@selector(editTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editButton];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.editButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f];

    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.editButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-[[self class] titleLabelLeft]];

    [self addConstraints:@[centerYConstraint, trailingConstraint]];
}

- (void)editTapped:(id)sender {
    [self.delegate editableFieldResultItemViewEditTapped:self];
}

- (void)setEdited:(BOOL)edited {
    _edited = edited;
    [self.editButton setBackgroundImage:[[UIImage pp_imageInResourcesBundleNamed:@"kvacicaIkona"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.editButton.tintColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;
}

+ (CGFloat)titleLabelRight {
    return [[self class] titleLabelLeft] * 2 + 32.f;
}

+ (CGFloat)valueLabelRight {
    return [[self class] titleLabelRight];
}

@end
