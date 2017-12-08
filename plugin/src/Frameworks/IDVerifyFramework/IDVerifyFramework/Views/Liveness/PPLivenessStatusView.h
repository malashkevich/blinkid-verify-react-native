//
//  PPLivenessStatusView.h
//  LivenessTest
//
//  Created by Jura on 03/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PPLivenessStatus) {
    PPLivenessStatusOK,
    PPLivenessStatusFaceNotInFrame,
    PPLivenessStatusBlink,
    PPLivenessStatusSmile,
    PPLivenessStatusTooFar,
    PPLivenessStatusTooClose,
    PPLivenessStatusAngle
};

@interface PPLivenessStatusView : UIView

@property (nonatomic) UIColor *normalColor;

@property (nonatomic) UIColor *errorColor;

@property (nonatomic) UILabel *statusLabel;

@property (nonatomic) BOOL running;

- (void)updateForStatus:(PPLivenessStatus)status;

@end
