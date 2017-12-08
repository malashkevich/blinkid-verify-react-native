//
//  PPIdScanViewStateUpdater.h
//  LivenessTest
//
//  Created by Jura on 02/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "PPViewfinderView.h"
#import "PPScanningState.h"


@interface PPIdScanViewStateUpdater : NSObject

@property (nonatomic) PPViewfinderView *viewfinderView;
@property (nonatomic) UILabel *statusLabel;
@property (nonatomic) UIImageView *statusImageView;

- (instancetype)initWithViewfinder:(PPViewfinderView *)viewfinderView statusLabel:(UILabel *)label statusImageView:(UIImageView *)imageView;

- (void)updateForState:(PPScanningState)state;

@end
