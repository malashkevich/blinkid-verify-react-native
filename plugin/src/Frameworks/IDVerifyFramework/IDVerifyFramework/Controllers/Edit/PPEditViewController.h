//
//  PPEditViewController.h
//  IDVerifyFramework
//
//  Created by Jura on 10/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPEditViewModel.h"
#import "PPIdResultViewPopulator.h"

#import <UIKit/UIKit.h>


@protocol PPEditViewControllerDelegate;


@interface PPEditViewController : UIViewController

@property (nonatomic) PPEditViewModel *viewModel;

@property (nonatomic, weak) id<PPEditViewControllerDelegate> delegate;

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle;

@end


@protocol PPEditViewControllerDelegate <NSObject>

- (void)editViewControllerRequiresRepeatedScan:(PPEditViewController *)editViewController;

- (void)editViewControllerStarted:(PPEditViewController *)editViewController;

- (void)editViewControllerFinished:(PPEditViewController *)editViewController;

- (void)editViewController:(PPEditViewController *)editViewController
               editedField:(NSString *)fieldKey
                  oldValue:(NSString *)oldValue
                  newValue:(NSString *)newValue;

@end
