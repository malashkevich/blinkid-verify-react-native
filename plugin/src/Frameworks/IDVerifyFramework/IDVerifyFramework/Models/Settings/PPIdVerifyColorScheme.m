//
//  PPIdVerifyColorScheme.m
//  IDVerifyFramework
//
//  Created by Jura on 08/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdVerifyColorScheme.h"

@implementation PPIdVerifyColorScheme

- (instancetype)init {
    self = [super init];
    if (self) {

        _pronunciationPrimaryColor = [UIColor colorWithRed:225./255.f green:23.f/255.f blue:25.f/255.f alpha:1.0f];

        _pronunciationSecondaryColor = [UIColor colorWithRed:44./255.f green:128.f/255.f blue:141.f/255.f alpha:1.0f];

        _oddTableCellColor = [UIColor colorWithRed:216.f / 255.f green:241.f / 255.f blue:251.f / 255.f alpha:1.0];

        _evenTableCellColor = [UIColor colorWithRed:176.f / 255.f green:226.f / 255.f blue:247.f / 255.f alpha:1.0];

        _cellTitleLabelColor = [UIColor colorWithRed:44./255.f green:128.f/255.f blue:141.f/255.f alpha:1.0f];

        _cellTitleValueColor = [UIColor colorWithRed:74./255.f green:74.f/255.f blue:74.f/255.f alpha:1.0f];

        _livenessErrorColor = [UIColor colorWithRed:232.f/255.f green:78.f/255.f blue:64.f/255.f alpha:1.0f];

        _keyboardBackgroundColor = [UIColor colorWithRed:216./255.f green:241.f/255.f blue:251.f/255.f alpha:1.0f];
    }
    return self;
}

@end
