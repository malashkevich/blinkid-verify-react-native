//
//  PPIdScanViewController.h
//  LivenessTest
//
//  Created by Jura on 01/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdScanViewModel.h"

#import <MicroBlink/MicroBlink.h>

#import <UIKit/UIKit.h>

@protocol PPIdScanViewControllerDelegate;

@interface PPIdScanViewController : PPBaseOverlayViewController

@property (nonatomic) PPIdScanViewModel *viewModel;

@property (nonatomic, weak) id<PPIdScanViewControllerDelegate> delegate;

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle;

@end


@protocol PPIdScanViewControllerDelegate <NSObject>

- (void)idScanViewControllerFinishedScanningFrontSide:(PPIdScanViewController *)idScanViewController;

- (void)idScanViewControllerFinished:(PPIdScanViewController *)idScanViewController;

- (void)idScanViewControllerNeedsPauseScanning:(PPIdScanViewController *)idScanViewController;

- (void)idScanViewControllerNeedsResumeScanning:(PPIdScanViewController *)idScanViewController;

- (void)idScanViewControllerNeedsPauseCamera:(PPIdScanViewController *)idScanViewController;

- (void)idScanViewControllerNeedsResumeCamera:(PPIdScanViewController *)idScanViewController;

@end
