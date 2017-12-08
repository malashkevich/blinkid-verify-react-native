//
//  PPLivenessViewController.h
//  LivenessTest
//
//  Created by Jura on 01/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPLivenessViewModel.h"

#import <MicroBlink/MicroBlink.h>

#import <UIKit/UIKit.h>

@protocol PPLivenessViewControllerDelegate;

@interface PPLivenessViewController : PPBaseOverlayViewController

@property (nonatomic) PPLivenessViewModel *viewModel;

@property (nonatomic, weak) id<PPLivenessViewControllerDelegate> delegate;

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle;

@end

@protocol PPLivenessViewControllerDelegate <NSObject>

- (void)livenessViewControllerDidFinish:(PPLivenessViewController *)viewController;

- (void)livenessViewControllerNeedsPauseScanning:(PPLivenessViewController *)viewController;

- (void)livenessViewControllerNeedsResumeScanning:(PPLivenessViewController *)viewController;

@end
