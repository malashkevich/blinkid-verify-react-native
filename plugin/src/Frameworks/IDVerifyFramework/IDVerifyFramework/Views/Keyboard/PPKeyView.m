//
//  PPKeyView.m
//  IDVerifyFramework
//
//  Created by Jura on 31/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPKeyView.h"
#import "PPIdVerifySettings.h"

@interface PPKeyView ()

@property (nonatomic, strong) UIView *roundView;

@property (nonatomic, strong) UIButton *button;

@end

@implementation PPKeyView

- (instancetype)initWithFrame:(CGRect)frame value:(NSString *)value {
    self = [super initWithFrame:frame];
    if (self) {
        _value = value;

        self.roundView = [[UIView alloc] initWithFrame:frame];
        self.roundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.roundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.roundView];

        self.button = [[UIButton alloc] initWithFrame:frame];
        self.button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.button setTitle:value forState:UIControlStateNormal];
        self.button.titleLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightBold relativeScale:2.0f pointSizeDiff:-5.0f];
        [self.button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:self.button];
    }
    return self;
}

- (void)buttonTapped {
    [self.delegate keyViewWasPressed:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.roundView.layer.cornerRadius = self.frame.size.width / 2;
}


- (void)setActive {
    self.roundView.backgroundColor = [UIColor whiteColor];
    [self.button setTitleColor:[PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationPrimaryColor forState:UIControlStateNormal];
}

- (void)setInactive {
    self.roundView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.keyboardBackgroundColor;
    [self.button setTitleColor:[PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor forState:UIControlStateNormal];
}

@end
