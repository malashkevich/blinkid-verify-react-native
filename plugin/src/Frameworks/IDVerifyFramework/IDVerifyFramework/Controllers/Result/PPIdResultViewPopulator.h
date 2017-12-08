//
//  PPIdResultViewPopulator.h
//  LivenessTest
//
//  Created by Jura on 03/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdViewResult.h"
#import "PPIdResultItemView.h"
#import "PPFieldResultItemView.h"
#import "PPEditableResultItemView.h"
#import "PPInsertableResultItemView.h"
#import "PPTitleResultItemView.h"
#import "PPConfiguration.h"

#import <Foundation/Foundation.h>

@interface PPIdResultViewPopulator : NSObject

- (PPFieldResultItemView *)fieldViewWithTitle:(NSString *)title originalKey:(NSString *)key value:(NSString *)value;

- (PPFieldResultItemView *)editableViewWithTitle:(NSString *)title originalKey:(NSString *)key value:(NSString *)value editingConfiguration:(PPConfiguration *)configuration;

- (PPTitleResultItemView *)titleViewWithTitle:(NSString *)title;

- (PPInsertableFieldResultItemView *)insertableViewWithTitle:(NSString *)title originalKey:(NSString *)key placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)type validationMessage:(NSString *)validationMessage validationBlock:(BOOL (^)(NSString *value))validationBlock;

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult;

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult
                                               editingEnabled:(BOOL)editingEnabled;

- (BOOL)isEditable:(PPConfiguration *)configuration key:(NSString *)key value:(NSString *)value;

@end
