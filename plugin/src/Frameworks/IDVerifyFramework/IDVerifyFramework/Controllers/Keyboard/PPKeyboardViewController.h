//
//  PPKeyboardViewController.h
//  IDVerifyFramework
//
//  Created by Jura on 30/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPKeyboardViewModel.h"

@protocol PPKeyboardViewControllerDelegate;

@interface PPKeyboardViewController : UIViewController

@property (nonatomic, strong) PPKeyboardViewModel* viewModel;

@property (nonatomic, weak) id<PPKeyboardViewControllerDelegate> delegate;

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle;

@end

@protocol PPKeyboardViewControllerDelegate

- (void)keyboardViewController:(PPKeyboardViewController *)controller didFinishEditingWithResult:(NSString *)result;

@end
