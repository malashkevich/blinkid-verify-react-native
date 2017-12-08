//
//  PPIdVerifyColorScheme.h
//  IDVerifyFramework
//
//  Created by Jura on 08/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface PPIdVerifyColorScheme : NSObject

@property (nonatomic, strong) UIColor *pronunciationPrimaryColor;

@property (nonatomic, strong) UIColor *pronunciationSecondaryColor;

@property (nonatomic, strong) UIColor *oddTableCellColor;

@property (nonatomic, strong) UIColor *evenTableCellColor;

@property (nonatomic, strong) UIColor *cellTitleLabelColor;

@property (nonatomic, strong) UIColor *cellTitleValueColor;

@property (nonatomic, strong) UIColor *livenessErrorColor;

@property (nonatomic, strong) UIColor *keyboardBackgroundColor;

- (instancetype)init;

@end
