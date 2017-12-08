//
//  PPNonMatchingDataView.h
//  LivenessTest
//
//  Created by Jura on 06/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PPNonMatchingDataViewDelegate;


@interface PPNonMatchingDataView : UIView

@property (nonatomic, weak) id<PPNonMatchingDataViewDelegate> delegate;

+ (instancetype)allocFromNibInBundle:(NSBundle *)bundle;

@end


@protocol PPNonMatchingDataViewDelegate <NSObject>

- (void)nonMatchingDataViewScanAgainTapped:(PPNonMatchingDataView *)view;

@end
