//
//  PPLivenessStatusView.m
//  LivenessTest
//
//  Created by Jura on 03/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPLivenessStatusView.h"

#import "PPIdVerifySettings.h"
#import "PPLocalization.h"

static CGFloat statusLabelHeight = 60.f;

static CGFloat animationDuration = 0.4f;

static CGFloat animationDelay = 1.5f;

@interface PPLivenessStatusView ()

@property (nonatomic) PPLivenessStatus pendingStatus;

@property (nonatomic) PPLivenessStatus currentStatus;

@property (nonatomic) BOOL updateInProgress;

@end

@implementation PPLivenessStatusView

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
    [self configureLabel];
}

- (void)configureLabel {

    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.statusLabel.text = @"";
    self.statusLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium relativeScale:2.0f pointSizeDiff:-4.0f];
    self.statusLabel.textColor = [UIColor whiteColor];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.adjustsFontSizeToFitWidth = YES;
    self.statusLabel.numberOfLines = 0;

    self.statusLabel.layer.shadowOffset = CGSizeMake(0.f, 1.f);
    self.statusLabel.layer.shadowRadius = 2.0f;
    self.statusLabel.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.statusLabel.layer.shadowOpacity = 0.5;

    [self addSubview:self.statusLabel];

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0f];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-20.f];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.statusLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:statusLabelHeight];

    [self addConstraints:@[centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]];
}


- (void)layoutSubviews {
    self.layer.cornerRadius = self.frame.size.width / 2.f;
}

#pragma mark - State update

- (void)updateForStatus:(PPLivenessStatus)status {

    self.pendingStatus = status;

    [self startUpdate];
}

- (void)startUpdate {

    if (self.updateInProgress) {
        return;
    }

    self.currentStatus = self.pendingStatus;

    switch (self.currentStatus) {
        case PPLivenessStatusOK:
            [self setStatusOk];
            return;
            break;
        case PPLivenessStatusFaceNotInFrame:
            [self setStatusFaceNotInFrame];
            break;
        case PPLivenessStatusBlink:
            [self setStatusBlink];
            break;
        case PPLivenessStatusSmile:
            [self setStatusSmile];
            break;
        case PPLivenessStatusTooFar:
            [self setStatusTooFar];
            break;
         case PPLivenessStatusTooClose:
            [self setStatusTooCose];
            break;
        case PPLivenessStatusAngle:
            [self setStatusAngle];
            break;
    }

    [self animateShow];
}

- (void)setStatusOk {
    self.statusLabel.text = @"";
    self.backgroundColor = [UIColor clearColor];
}

- (void)setStatusFaceNotInFrame {
    self.statusLabel.text = PP_LOCALIZED_CAMERA(@"liveness.status.faceNotInFrame", @"Position face inside the frame");
    self.backgroundColor = self.normalColor;
}

- (void)setStatusBlink {
    self.statusLabel.text = PP_LOCALIZED_CAMERA(@"liveness.status.blink", @"Close eyes for a second");
    self.backgroundColor = [UIColor clearColor];
}

- (void)setStatusSmile {
    self.statusLabel.text = PP_LOCALIZED_CAMERA(@"liveness.status.smile", @"Smile while showing teeth");
    self.backgroundColor = [UIColor clearColor];
}

- (void)setStatusAngle {
    self.statusLabel.text = PP_LOCALIZED_CAMERA(@"liveness.status.angle", @"Align device with face");
    self.backgroundColor = self.errorColor;
}

- (void)setStatusTooFar {
    self.statusLabel.text = PP_LOCALIZED_CAMERA(@"liveness.status.tooFar", @"Get closer to the camera");
    self.backgroundColor = self.errorColor;
}

- (void)setStatusTooCose {
    self.statusLabel.text = PP_LOCALIZED_CAMERA(@"liveness.status.tooClose", @"Increase distance from the camera");
    self.backgroundColor = self.errorColor;
}

#pragma mark - Animation

- (void)animateShow {

    self.updateInProgress = YES;

    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:animationDuration
                                               delay:animationDelay
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.alpha = 0.0f;
                                          } completion:^(BOOL finished) {
                                              self.updateInProgress = NO;
                                              if (self.running) {
                                                  [self startUpdate];
                                              }
                                          }];
                     }];

}


@end
