//
//  PPFaceLivenessOverlaySubview.h
//  BlinkIdFramework
//
//  Created by Jura on 10/09/16.
//  Copyright © 2016 MicroBlink Ltd. All rights reserved.
//

#import "PPOverlaySubview.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PPFaceLivenessOverlaySubviewDelegate;

PP_CLASS_AVAILABLE_IOS(6.0) @interface PPFaceLivenessOverlaySubview : PPOverlaySubview

@property (nonatomic, weak) id<PPFaceLivenessOverlaySubviewDelegate> subviewDelegate;

@end

@protocol PPFaceLivenessOverlaySubviewDelegate <NSObject>

- (void)faceLivenessOverlaySubview:(PPFaceLivenessOverlaySubview *)subview
          didRequestLivenessAction:(PPLivenessAction)action;


- (void)faceLivenessOverlaySubview:(PPFaceLivenessOverlaySubview *)subview
        didFindLivenessActionError:(PPLivenessError)error;

@end

NS_ASSUME_NONNULL_END
