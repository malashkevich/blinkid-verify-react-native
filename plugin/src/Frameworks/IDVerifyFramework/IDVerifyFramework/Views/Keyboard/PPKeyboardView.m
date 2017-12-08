//
//  PPKeyboardView.m
//  IDVerifyFramework
//
//  Created by Jura on 31/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPKeyboardView.h"

#import "PPKeyView.h"

@interface PPKeyboardView () <PPKeyViewDelegate>

@property (nonatomic, strong) NSMutableArray<PPKeyView *> *keyViews;

@property (nonatomic, strong) PPKeyView *currentActiveKeyView;

@end

@implementation PPKeyboardView

- (instancetype)initWithFrame:(CGRect)frame confusion:(PPStringConfusion *)confusion {
    self = [super initWithFrame:frame];
    if (self) {
        _keyViews = [[NSMutableArray alloc] init];
        for (NSString *variant in confusion.confusions) {
            PPKeyView *keyView = [[PPKeyView alloc] initWithFrame:frame value:variant];
            if ([confusion.currentValue isEqualToString:variant]) {
                self.currentActiveKeyView = keyView;
                [keyView setActive];
            } else {
                [keyView setInactive];
            }
            keyView.delegate = self;
            [_keyViews addObject:keyView];
            [self addSubview:keyView];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);

    CGFloat maxKeyWidth = width / (self.keyViews.count * 2 + 1);
    CGFloat dim = MIN(maxKeyWidth, height);

    const CGFloat sizeIncrease = 1.3f;
    CGFloat keyWidthForThreeButtons = width / 7;
    CGFloat size = MIN(dim, keyWidthForThreeButtons) * sizeIncrease;

    int i = 0;
    for (PPKeyView *keyView in self.keyViews) {
        keyView.bounds = CGRectMake(0, 0, size, size);
        keyView.center = CGPointMake((i * 2 + 3.f/2.f) * dim, self.center.y);
        i++;
    }
}

#pragma mark - PPKeyViewDelegate

- (void)keyViewWasPressed:(PPKeyView *)keyView {
    [self.delegate keyboardView:self didTapStringConfusion:keyView.value];
    [self.currentActiveKeyView setInactive];
    self.currentActiveKeyView = keyView;
    [self.currentActiveKeyView setActive];
}

@end
