//
//  PPEditableResultItemView.h
//  IDVerifyFramework
//
//  Created by Jura on 12/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPFieldResultItemView.h"

@protocol PPEditableFieldResultItemViewDelegate;


@interface PPEditableFieldResultItemView : PPFieldResultItemView

@property (nonatomic, weak) id<PPEditableFieldResultItemViewDelegate> delegate;

@property (nonatomic) UIButton *editButton;

@property (nonatomic) BOOL edited;

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end


@protocol PPEditableFieldResultItemViewDelegate

- (void)editableFieldResultItemViewEditTapped:(PPEditableFieldResultItemView *)view;

@end
