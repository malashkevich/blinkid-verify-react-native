//
//  PPViewfinderView.h
//  LivenessTest
//
//  Created by Jura on 02/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PPViewfinderViewDelegate;


@interface PPViewfinderView : UIView

@property (nonatomic) UILabel *helpLabel;

@property (nonatomic) UIImageView *helpImageView;

@property (nonatomic, weak) id<PPViewfinderViewDelegate> delegate;

- (void)animateHelp;

@end


@protocol PPViewfinderViewDelegate <NSObject>

- (void)viewfinderViewDidFinishAnimation:(PPViewfinderView *)viewfinder;

@end
