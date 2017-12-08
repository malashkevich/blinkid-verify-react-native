//
//  PPInstructionsViewController.h
//  IDVerifyFramework
//
//  Created by Jura on 17/05/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PPInstructionsViewControllerDelegate;


@interface PPInstructionsViewController : UIViewController

@property (nonatomic, weak) id<PPInstructionsViewControllerDelegate> delegate;

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle;

- (void)setScanPreset;

- (void)setSelfiePreset;

- (void)attachToParentViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)detachFromParentViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

@protocol PPInstructionsViewControllerDelegate

- (void)instructionsViewControllerFinished:(PPInstructionsViewController *)instructionsViewController;

@end
