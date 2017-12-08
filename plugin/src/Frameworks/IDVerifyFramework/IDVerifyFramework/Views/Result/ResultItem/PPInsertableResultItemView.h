//
//  PPInsertableResultItemView.h
//  IDVerifyFramework
//
//  Created by Jura on 12/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPFieldResultItemView.h"


@protocol PPInsertableFieldResultItemViewDelegate;


@interface PPInsertableFieldResultItemView : PPFieldResultItemView

@property (nonatomic, weak) id<PPInsertableFieldResultItemViewDelegate> delegate;

@property (nonatomic, strong, readonly) NSString *placeholderText;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIColor *placeholderTextColor;

@property (nonatomic, strong) NSString *validationErrorMessage;

@property (nonatomic, copy) BOOL (^validationBlock)(NSString *value);

- (instancetype)initWithFrame:(CGRect)frame placeholderText:(NSString *)placeholderText keyboardType:(UIKeyboardType)type validationMessage:(NSString *)validationMessage validationBlock:(BOOL (^)(NSString *value))validationBlock NS_DESIGNATED_INITIALIZER;

- (void)showErrorLabelIfNecessary;

@end


@protocol PPInsertableFieldResultItemViewDelegate

- (void)insertableFieldDidBeginEditing:(PPInsertableFieldResultItemView *)view;

- (void)insertableFieldDidEndEditing:(PPInsertableFieldResultItemView *)view;

@end
