//
//  PPCroatiaIdResultViewPopulator.m
//  LivenessTest
//
//  Created by Jura on 03/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPCroatiaIdResultViewPopulator.h"
#import "PPCroatiaIdViewResult.h"

#import "PPLocalization.h"
#import "PPConfigurationStorage.h"

@implementation PPCroatiaIdResultViewPopulator


- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult editingEnabled:(BOOL)editingEnabled {
    NSMutableArray *views = [[NSMutableArray alloc] init];

    PPConfiguration *configuration = nil;
    if (editingEnabled) {
        configuration = [[PPConfigurationStorage sharedStorage] configurationForType:viewResult.configurationType];
    }

    NSAssert([viewResult isKindOfClass:[PPCroatiaIdViewResult class]], @"View result should be PPCroatiaIdViewResult");

    PPCroatiaIdViewResult *croatiaIdViewResult = (PPCroatiaIdViewResult *)viewResult;

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentno", @"ID document number")
                                     originalKey:croatiaIdViewResult.idNumberKey
                                           value:croatiaIdViewResult.idNumber
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.firstname", @"Name")
                                     originalKey:croatiaIdViewResult.firstNameKey
                                           value:croatiaIdViewResult.firstName
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.lastname", @"Surname")
                                     originalKey:croatiaIdViewResult.lastNameKey
                                           value:croatiaIdViewResult.lastName
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.sex", @"Sex")
                                     originalKey:croatiaIdViewResult.sexKey
                                           value:croatiaIdViewResult.sex
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfBirth", @"Date of Birth")
                                     originalKey:croatiaIdViewResult.dateOfBirthKey
                                           value:croatiaIdViewResult.dateOfBirth
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.nationality", @"Nationality")
                                     originalKey:croatiaIdViewResult.nationalityKey
                                           value:croatiaIdViewResult.nationality
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.address", @"Address")
                                     originalKey:croatiaIdViewResult.addressKey
                                           value:croatiaIdViewResult.address
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.issuer", @"Issued by")
                                     originalKey:croatiaIdViewResult.issuingAuthorityKey
                                           value:croatiaIdViewResult.issuingAuthority
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfExpiry", @"Date of Expiry")
                                     originalKey:croatiaIdViewResult.expiryDateKey
                                           value:croatiaIdViewResult.expiryDate
                            editingConfiguration:configuration]];

    if ([self shouldInsertData:croatiaIdViewResult]) {
        [views addObject:[self titleViewWithTitle:PP_LOCALIZED_RESULT(@"edit.insert.title", "PLEASE INSERT FIELDS")]];
    }

    if ([self shouldInsertOib:croatiaIdViewResult]) {
        [views addObject:[self insertableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.oib", @"OIB")
                                           originalKey:[croatiaIdViewResult personalNumberKey]
                                           placeholder:PP_LOCALIZED_RESULT(@"result.insert.oib", "Enter your OIB")
                                          keyboardType:UIKeyboardTypeNumberPad
                                     validationMessage:PP_LOCALIZED_RESULT(@"result.insert.oib.error", @"OIB is not valid.")
                                       validationBlock:^BOOL(NSString *value) {
                                           return isOibValid(value);
                                       }]];
    } else {
        [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.oib", @"OIB")
                                         originalKey:[croatiaIdViewResult personalNumberKey]
                                               value:croatiaIdViewResult.personalNumber
                                editingConfiguration:configuration]];
    }

    return views;
}

BOOL isOibValid(NSString *value) {
    if (value.length != 11) {
        return NO;
    }

    for (int i = 0; i < (int)value.length; ++i) {
        if (!isdigit([value characterAtIndex:i])) {
            return NO;
        }
    }

    int mod = 10;

    for (int i = 0; i < (int)value.length - 1; ++i) {

        int x = [value characterAtIndex:i] - '0';
        x += mod;

        mod = x % 10;
        if (mod == 0) {
            mod = 10;
        }

        mod *= 2;
        mod = mod % 11;
    }

    int ctrl;
    switch (mod) {
        case 0:
            ctrl = 1;
            break;
        case 1:
            ctrl = 0;
            break;
        default:
            ctrl = 11 - mod;
            break;
    }

    int last = [value characterAtIndex:value.length - 1] - '0';

    return last == ctrl;
}

- (BOOL)shouldInsertData:(PPCroatiaIdViewResult *)viewResult {
    return [self shouldInsertOib:viewResult];
}

- (BOOL)shouldInsertOib:(PPCroatiaIdViewResult *)viewResult {
    return (viewResult.personalNumber == nil || viewResult.personalNumber.length == 0);
}

@end
