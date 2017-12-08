//
//  PPInsertableResultItemView.m
//  IDVerifyFramework
//
//  Created by Jura on 12/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPInsertableResultItemView.h"

#import "PPLocalization.h"
#import "PPIdVerifySettings.h"

@interface PPInsertableFieldResultItemView () <UITextViewDelegate>

@property (nonatomic, strong) UIView *separatorView;

@property (nonatomic, strong) UILabel *validationErrorLabel;

@end

@implementation PPInsertableFieldResultItemView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame placeholderText:@"" keyboardType:UIKeyboardTypeDefault validationMessage:nil validationBlock:nil];
}

- (instancetype)initWithFrame:(CGRect)frame placeholderText:(NSString *)placeholderText keyboardType:(UIKeyboardType)type validationMessage:(NSString *)validationMessage validationBlock:(BOOL (^)(NSString *value))validationBlock {
    self = [super initWithFrame:frame];
    if (self) {
        self.valueView.editable = YES;
        self.valueView.delegate = self;
        self.valueView.keyboardType = type;

        [self removeConstraint:self.valueViewBottomConstraint];

        self.validationBlock = validationBlock;

        _textColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.cellTitleValueColor;
        _placeholderTextColor = [UIColor colorWithRed:118.f/255.f green:118.f/255.f blue:118.f/255.f alpha:1.0f];

        [self configureSeparator];
        [self configureAccessoryView];
        [self configureValidationErrorLabel];

        _validationErrorMessage = validationMessage;

        _placeholderText = placeholderText;

        self.valueView.returnKeyType = UIReturnKeyDone;

        self.valueView.text = placeholderText;
        self.valueView.textColor = self.placeholderTextColor;
    }
    return self;
}

- (void)configureSeparator {

    self.separatorView = [[UIView alloc] init];
    self.separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.separatorView.backgroundColor = self.placeholderTextColor;

    [self addSubview:self.separatorView];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.valueView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];

    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.valueView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.valueView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:5.0f];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0f constant:1.0f];

    [self addConstraints:@[leftConstraint, rightConstraint, topConstraint, heightConstraint]];
}

- (void)configureAccessoryView {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;

    UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:PP_LOCALIZED_RESULT(@"edit.keyboard.done", @"Done") style:UIBarButtonItemStyleDone target:self action:@selector(endEditing)];

    doneItem.tintColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor;

    toolbar.items = @[flexibleSpaceButtonItem, doneItem];
    [toolbar sizeToFit];
    self.valueView.inputAccessoryView = toolbar;
}

- (void)configureValidationErrorLabel {
    self.validationErrorLabel = [[UILabel alloc] init];
    self.validationErrorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.validationErrorLabel.textColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.livenessErrorColor;
    self.validationErrorLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightMedium pointSizeDiff:-1.f];

    [self addSubview:self.validationErrorLabel];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.validationErrorLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.valueView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];

    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.validationErrorLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.valueView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.validationErrorLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.separatorView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:4.0f];

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.validationErrorLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-6.f];

    [self.validationErrorLabel setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisVertical];

    [self addConstraints:@[leftConstraint, rightConstraint, topConstraint, bottomConstraint]];
}

- (void)endEditing {
    [self.valueView resignFirstResponder];
}

- (void)showErrorLabelIfNecessary {
    if (self.validationBlock && !self.validationBlock(self.valueView.text)) {
        [self showErrorLabel];
    }
}

- (void)showErrorLabel {
    self.separatorView.backgroundColor = [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.livenessErrorColor;
    self.validationErrorLabel.text = self.validationErrorMessage;
}

- (void)clearErrorLabel {
    self.separatorView.backgroundColor = self.placeholderTextColor;
    self.validationErrorLabel.text = nil;
}

+ (CGFloat)valueLabelBottom {
    return 15.f;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self.delegate insertableFieldDidBeginEditing:self];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self clearErrorLabel];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (!self.validationBlock) return YES;

    if (self.validationBlock(textView.text)) {
        [self clearErrorLabel];
        return YES;
    } else {
        [self showErrorLabel];
        return NO;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.placeholderText]) {
        textView.text = @"";
        textView.textColor = self.textColor;
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = self.placeholderText;
        textView.textColor = self.placeholderTextColor;
    }
    [textView resignFirstResponder];
    [self.delegate insertableFieldDidEndEditing:self];
}

@end
