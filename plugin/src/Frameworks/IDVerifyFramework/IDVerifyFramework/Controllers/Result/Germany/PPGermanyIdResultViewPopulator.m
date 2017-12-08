//
//  PPGermanyIdResultViewPopulator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 29/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPGermanyIdResultViewPopulator.h"

#import "PPGermanyIdViewResult.h"

#import "PPLocalization.h"
#import "PPConfigurationStorage.h"

@implementation PPGermanyIdResultViewPopulator

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult editingEnabled:(BOOL)editingEnabled {
    NSMutableArray *views = [[NSMutableArray alloc] init];

    PPConfiguration *configuration = nil;
    if (editingEnabled) {
        configuration = [[PPConfigurationStorage sharedStorage] configurationForType:viewResult.configurationType];
    }

    NSAssert([viewResult isKindOfClass:[PPGermanyIdViewResult class]], @"View result should be PPGermanyIdViewResult");

    PPGermanyIdViewResult *germanyIdViewResult = (PPGermanyIdViewResult *)viewResult;

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentno", @"ID document number")
                                     originalKey:germanyIdViewResult.idNumberKey
                                           value:germanyIdViewResult.idNumber
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.firstname", @"Name")
                                     originalKey:germanyIdViewResult.firstNameKey
                                           value:germanyIdViewResult.firstName
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.lastname", @"Surname")
                                     originalKey:germanyIdViewResult.lastNameKey
                                           value:germanyIdViewResult.lastName
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.sex", @"Sex")
                                     originalKey:germanyIdViewResult.sexKey
                                           value:germanyIdViewResult.sex
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfBirth", @"Date of Birth")
                                     originalKey:germanyIdViewResult.dateOfBirthKey
                                           value:germanyIdViewResult.dateOfBirth
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.placeOfBirth", @"Place of birth")
                                     originalKey:germanyIdViewResult.placeOfBirthKey
                                           value:germanyIdViewResult.placeOfBirth
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.nationality", @"Nationality")
                                     originalKey:germanyIdViewResult.nationalityKey
                                           value:germanyIdViewResult.nationality
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.address", @"Address")
                                     originalKey:germanyIdViewResult.addressKey
                                           value:germanyIdViewResult.address
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.issuer", @"Issued by")
                                     originalKey:germanyIdViewResult.issuingAuthorityKey
                                           value:germanyIdViewResult.issuingAuthority
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfExpiry", @"Date of Expiry")
                                     originalKey:germanyIdViewResult.expiryDateKey
                                           value:germanyIdViewResult.expiryDate
                            editingConfiguration:configuration]];

    return views;
}

@end
