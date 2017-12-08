//
//  PPMatchResultView.m
//  LivenessTest
//
//  Created by Jura on 04/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPMatchResultView.h"
#import "PPIdVerifySettings.h"

@interface PPMatchResultView ()

@property (nonatomic) UILabel *confidenceLabel;

@property (nonatomic) UIView *containerView;

@property (nonatomic) CAShapeLayer *animationLayer;

@end

@implementation PPMatchResultView

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
    self.backgroundColor = [UIColor clearColor];

    [self configureContainer];
    [self configureConfidenceLabel];
}

- (void)configureContainer {
    self.containerView = [[UIView alloc] init];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.backgroundColor = [UIColor clearColor];

    [self addSubview:self.containerView];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0f];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0f];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0f];

    [self addConstraints:@[centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]];
}

- (void)configureConfidenceLabel {

    self.confidenceLabel = [[UILabel alloc] init];
    self.confidenceLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.confidenceLabel.text = @"";
    self.confidenceLabel.font = [UIFont systemFontOfSize:40.f weight:UIFontWeightRegular];
    self.confidenceLabel.textColor = [UIColor whiteColor];
    self.confidenceLabel.textAlignment = NSTextAlignmentLeft;
    self.confidenceLabel.adjustsFontSizeToFitWidth = YES;
    self.confidenceLabel.numberOfLines = 1;

    [self.containerView addSubview:self.confidenceLabel];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.confidenceLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0f];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.confidenceLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.confidenceLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-10.0f];

    [self addConstraints:@[centerXConstraint, centerYConstraint, widthConstraint]];
    
}

- (void)layoutSubviews {
    self.containerView.layer.cornerRadius = self.frame.size.width / 2.0f;
    self.containerView.clipsToBounds = YES;
}

- (void)setStatus:(PPMatchResultStatus)status withConfidence:(CGFloat)confidence {
    switch (status) {
        case PPMatchResultStatusWorking:
            [self setWorkingStatus];
            break;
        case PPMatchResultStatusMatch:
            [self setMatchStatusWithConfidenceText:@"✓"];
            break;
        case PPMatchResultStatusFail:
            [self setFailStatusWithConfidenceText:@"𐄂"];
            break;
    }
}

- (void)setWorkingStatus {
    self.containerView.backgroundColor = [UIColor clearColor];
    self.confidenceLabel.text = @"";

    [self.animationLayer removeFromSuperlayer];
    self.animationLayer = nil;

    [self animateProgress];
}

- (void)setMatchStatusWithConfidenceText:(NSString *)text {

    self.containerView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationPrimaryColor;
    self.confidenceLabel.text = text;

    [self animateShow];
}

- (void)setFailStatusWithConfidenceText:(NSString *)text {
    self.containerView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.livenessErrorColor;
    self.confidenceLabel.text = text;

    [self animateShow];
}

- (void)animateProgress {

    // set up some values to use in the curve
    CGFloat ovalStartAngle = -M_PI_2;
    CGFloat ovalEndAngle = ovalStartAngle + M_PI * 2;
    CGRect ovalRect = self.bounds;

    UIBezierPath *ovalPath = [[UIBezierPath alloc] init];
    [ovalPath addArcWithCenter:CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect))
                        radius:CGRectGetWidth(ovalRect) / 2.f
                    startAngle:ovalStartAngle
                      endAngle:ovalEndAngle
                     clockwise:YES];

    // create an object that represents how the curve
    // should be presented on the screen
    self.animationLayer = [[CAShapeLayer alloc] init];

    self.animationLayer.path = ovalPath.CGPath;
    self.animationLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.animationLayer.fillColor = [UIColor clearColor].CGColor;
    self.animationLayer.lineWidth = 4.0f;
    self.animationLayer.lineCap = kCALineCapRound;

    // add the curve to the screen
    [self.layer addSublayer:self.animationLayer];

    CABasicAnimation *animateStrokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animateStrokeEnd.fromValue = @(0.0);
    animateStrokeEnd.toValue = @(1.0);
    animateStrokeEnd.beginTime = 0.0f;
    animateStrokeEnd.duration = 2.0f;
    animateStrokeEnd.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CAAnimationGroup *strokeEndGroup = [[CAAnimationGroup alloc] init];
    strokeEndGroup.duration = 2.5;
    strokeEndGroup.repeatCount = HUGE_VALF;
    strokeEndGroup.animations = @[animateStrokeEnd];

        // create a basic animation that animates the value 'strokeStart'
    // from 0.0 to 1.0 over 3.0 seconds
    CABasicAnimation *animateStrokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animateStrokeStart.fromValue = @(0.0);
    animateStrokeStart.toValue = @(1.0);
    animateStrokeStart.beginTime = 0.5f;
    animateStrokeStart.duration = 2.0f;
    animateStrokeStart.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CAAnimationGroup *strokeStartGroup = [[CAAnimationGroup alloc] init];
    strokeStartGroup.duration = 2.5;
    strokeStartGroup.repeatCount = HUGE_VALF;
    strokeStartGroup.animations = @[animateStrokeStart];


    // add the animation
    [self.animationLayer addAnimation:strokeEndGroup forKey:@"strokeEnd"];
    [self.animationLayer addAnimation:strokeStartGroup forKey:@"strokeStart"];
}

- (void)animateShow {
    self.containerView.alpha = 0.0f;

    [self.animationLayer removeAllAnimations];

    [UIView animateWithDuration:0.4f animations:^{
        self.containerView.alpha = 1.0f;
    } completion:^(BOOL finished) {

    }];
}

@end
