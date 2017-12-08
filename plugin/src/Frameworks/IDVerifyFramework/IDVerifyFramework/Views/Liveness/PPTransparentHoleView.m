//
//  PPTransparentHoleView.m
//  LivenessTest
//
//  Created by Jura on 03/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPTransparentHoleView.h"

@interface PPTransparentHoleView ()

@end

@implementation PPTransparentHoleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure {
    self.opaque = NO;
}

- (void)drawRect:(CGRect)rect {

    [self.backgroundColor setFill];
    UIRectFill(rect);

    CGRect holeRectIntersection = CGRectIntersection(self.holeView.frame, rect);

    CGContextRef context = UIGraphicsGetCurrentContext();

    if (CGRectIntersectsRect(holeRectIntersection, rect)) {
        CGContextAddEllipseInRect(context, holeRectIntersection);
        CGContextClip(context);
        CGContextClearRect(context, holeRectIntersection);
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, holeRectIntersection);
    }
}

@end
