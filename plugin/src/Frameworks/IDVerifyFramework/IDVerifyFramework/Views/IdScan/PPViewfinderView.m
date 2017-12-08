//
//  PPViewfinderView.m
//  LivenessTest
//
//  Created by Jura on 02/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPViewfinderView.h"
#import "PPIdVerifySettings.h"

#import "UIImage+Utils.h"

static CGFloat topHelpLabelMargin = 44.0f;

static CGFloat leftHelpLabelMargin = 14.0f;

static CGFloat helpLabelHeight = 20.0f;

static CGFloat animationDuration = 0.4f;

static CGFloat animationDelay = 1.5f;


@interface PPViewfinderView ()

@property (nonatomic) UIView *containerView;

@end


@implementation PPViewfinderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure {
    [self configureLayer];
    [self configureContainer];
    [self configureLabel];
    [self configureImageView];
}

- (void)configureLayer {
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.cornerRadius = 10.0f;
    self.layer.borderWidth = 3.0f;
    self.clipsToBounds = YES;
}

- (void)configureContainer {
    self.containerView = [[UIView alloc] init];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.backgroundColor = [[PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor colorWithAlphaComponent:0.9];

    [self addSubview:self.containerView];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.containerView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0.0f];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.containerView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:0.0f];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.containerView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1.0
                                                                        constant:0.0f];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.containerView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0
                                                                         constant:0.0f];

    [self addConstraints:@[ centerXConstraint, centerYConstraint, widthConstraint, heightConstraint ]];
}

- (void)configureLabel {

    self.helpLabel = [[UILabel alloc] init];
    self.helpLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.helpLabel.text = @"[[ PLACEHOLDER ]]";
    self.helpLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:3.f];
    
    self.helpLabel.textColor = [UIColor whiteColor];
    self.helpLabel.textAlignment = NSTextAlignmentCenter;
    self.helpLabel.adjustsFontSizeToFitWidth = YES;

    [self.containerView addSubview:self.helpLabel];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.helpLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.containerView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:topHelpLabelMargin];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.helpLabel
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.containerView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0.0f];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.helpLabel
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.containerView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:leftHelpLabelMargin];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.helpLabel
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:0.0
                                                                         constant:helpLabelHeight];

    [self.containerView addConstraints:@[ topConstraint, centerXConstraint, leftConstraint, heightConstraint ]];
}

- (void)configureImageView {

    self.helpImageView = [[UIImageView alloc] init];
    self.helpImageView.translatesAutoresizingMaskIntoConstraints = NO;

    self.helpImageView.image = [UIImage pp_imageInResourcesBundleNamed:@"icFrontSide"];

    [self.containerView addSubview:self.helpImageView];

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.helpImageView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.containerView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:-topHelpLabelMargin];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.helpImageView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.containerView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0.0f];


    [self.containerView addConstraints:@[ bottomConstraint, centerXConstraint ]];
}


- (void)animateHelp {

    [UIView animateWithDuration:animationDuration
        delay:0.0f
        options:UIViewAnimationOptionCurveEaseInOut
        animations:^{
            self.containerView.alpha = 1.0f;
        }
        completion:^(BOOL finished) {
            [UIView animateWithDuration:animationDuration
                delay:animationDelay
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    self.containerView.alpha = 0.0f;
                }
                completion:^(BOOL finished) {
                    [self.delegate viewfinderViewDidFinishAnimation:self];
                }];
        }];
}

@end
