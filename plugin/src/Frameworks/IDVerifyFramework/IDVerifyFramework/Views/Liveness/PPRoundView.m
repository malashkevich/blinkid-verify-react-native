//
//  PPRoundView.m
//  LivenessTest
//
//  Created by Jura on 03/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPRoundView.h"

@implementation PPRoundView

- (instancetype)init {
    self = [super init];
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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure {
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 3.0f;
}

- (void)layoutSubviews {
    self.layer.cornerRadius = self.frame.size.width / 2.f;
}

@end
