//
//  PPGlareStatusView.m
//  IDVerifyFramework
//
//  Created by Jura on 19/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPGlareStatusView.h"

#import "PPIdVerifySettings.h"
#import "PPLocalization.h"

@interface PPGlareStatusView ()

@property (nonatomic, assign) BOOL updating;

@end

@implementation PPGlareStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureStatusLabel];
    }
    return self;
}

- (void)configureStatusLabel {
    self.label = [[UILabel alloc] init];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.textColor = [UIColor whiteColor];
    self.label.numberOfLines = 0;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:3.0f];

    self.label.layer.shadowOffset = CGSizeMake(0.f, 1.f);
    self.label.layer.shadowRadius = 2.0f;
    self.label.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.label.layer.shadowOpacity = 0.6;

    [self addSubview:self.label];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0.0f];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:0.0f];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1.0
                                                                        constant:0.0f];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0
                                                                         constant:0.0f];

    [self addConstraints:@[ centerXConstraint, centerYConstraint, widthConstraint, heightConstraint ]];
}

- (void)setStatus:(PPRecognitionStatus)status {

    if (self.updating || status == PPRecognitionStatusSuccess) {
        return;
    }

    self.updating = YES;
    self.label.text = PP_LOCALIZED_CAMERA(@"scanning.status.glare", @"Move the card to avoid glare");
    self.label.alpha = 0.0f;
    self.label.hidden = NO;

    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        self.label.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f
                              delay:1.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.label.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             self.label.hidden = YES;
                             self.updating = NO;
                         }];
    }];
}

@end
