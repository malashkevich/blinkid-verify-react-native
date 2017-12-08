//
//  PPIdResultViewController.h
//  LivenessTest
//
//  Created by Jura on 01/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//


#import "PPIdResultViewModel.h"
#import "PPIdResultViewPopulator.h"

#import <MicroBlink/MicroBlink.h>

#import <UIKit/UIKit.h>

@protocol PPIdResultViewControllerDelegate;


@interface PPIdResultViewController : UIViewController

@property (nonatomic) PPIdResultViewModel *viewModel;

@property (nonatomic, weak) id<PPIdResultViewControllerDelegate> delegate;

+ (instancetype)viewControllerFromStoryboardInBundle:(NSBundle *)bundle;

- (void)idVerifyResult:(PPIdVerifyResult *)result verifiedWithResponse:(PPIdVerifyResponse *)response error:(NSError *)error;

@end


@protocol PPIdResultViewControllerDelegate <NSObject>

- (void)idResultViewControllerRequiresRepeatedScan:(PPIdResultViewController *)resultViewController;

- (void)idResultViewController:(PPIdResultViewController *)resultViewController doVerifyForResult:(PPIdVerifyResult *)result;

- (void)idResultViewController:(PPIdResultViewController *)resultViewController didFinishWithoutVerification:(PPIdVerifyResult *)result;

- (void)idResultViewController:(PPIdResultViewController *)resultViewController didFinishWithSuccessfulVerification:(PPIdVerifyResult *)result;

@end
