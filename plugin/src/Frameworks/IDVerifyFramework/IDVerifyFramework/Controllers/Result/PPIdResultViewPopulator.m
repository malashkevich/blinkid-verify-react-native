//
//  PPIdResultViewPopulator.m
//  LivenessTest
//
//  Created by Jura on 03/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdResultViewPopulator.h"

#import "PPCroatiaIdResultViewPopulator.h"

@implementation PPIdResultViewPopulator

- (PPFieldResultItemView *)fieldViewWithTitle:(NSString *)title originalKey:(NSString *)key value:(NSString *)value {
    PPFieldResultItemView *view = [[PPFieldResultItemView alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.originalKey = key;
    view.titleLabel.text = title;
    view.valueView.text = value;
    return view;
}

- (PPFieldResultItemView *)editableViewWithTitle:(NSString *)title originalKey:(NSString *)key value:(NSString *)value editingConfiguration:(PPConfiguration *)configuration {

    PPFieldResultItemView *view;
    if ([self isEditable:configuration key:key value:value]) {
        view = [[PPEditableFieldResultItemView alloc] initWithFrame:CGRectZero];
    } else {
        view = [[PPFieldResultItemView alloc] initWithFrame:CGRectZero];
    }
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.originalKey = key;
    view.titleLabel.text = title;
    view.valueView.text = value;
    return view;
}

- (PPTitleResultItemView *)titleViewWithTitle:(NSString *)title {
    PPTitleResultItemView *titleView = [[PPTitleResultItemView alloc] initWithFrame:CGRectZero];
    titleView.translatesAutoresizingMaskIntoConstraints = NO;
    titleView.titleLabel.text = title;
    return titleView;
}

- (PPInsertableFieldResultItemView *)insertableViewWithTitle:(NSString *)title originalKey:(NSString *)key placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)type validationMessage:(NSString *)validationMessage validationBlock:(BOOL (^)(NSString *value))validationBlock {

    PPInsertableFieldResultItemView *view = [[PPInsertableFieldResultItemView alloc] initWithFrame:CGRectZero placeholderText:placeholder keyboardType:type validationMessage:validationMessage validationBlock:validationBlock];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.originalKey = key;
    view.titleLabel.text = title;
    return view;
}

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult {
    return [self populateViewsForViewResult:viewResult editingEnabled:NO];
}

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult
                                               editingEnabled:(BOOL)editingEnabled {
    return [[NSMutableArray alloc] init];
}

- (BOOL)isEditable:(PPConfiguration *)configuration key:(NSString *)key value:(NSString *)value {
    if (configuration == nil || ![configuration.editableKeys containsObject:key]) {
        return NO;
    }
    return [[configuration.transliterationMappings getStringConfusionsForText:value] count] > 0;
}

@end
