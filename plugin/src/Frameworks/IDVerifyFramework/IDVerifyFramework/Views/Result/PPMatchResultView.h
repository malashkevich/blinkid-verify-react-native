//
//  PPMatchResultView.h
//  LivenessTest
//
//  Created by Jura on 04/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PPMatchResultStatus) {
    PPMatchResultStatusWorking,
    PPMatchResultStatusMatch,
    PPMatchResultStatusFail,
};

@interface PPMatchResultView : UIView

- (void)setStatus:(PPMatchResultStatus)status withConfidence:(CGFloat)confidence;

@end
