//
//  PPAustriaIdResultViewPopulator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 30/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPAustriaIdResultViewPopulator.h"
#import "PPAustriaIdViewResult.h"

#import "PPLocalization.h"
#import "PPConfigurationStorage.h"

@implementation PPAustriaIdResultViewPopulator

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult editingEnabled:(BOOL)editingEnabled {
    NSMutableArray *views = [[NSMutableArray alloc] init];

    PPConfiguration *configuration = nil;
    if (editingEnabled) {
        configuration = [[PPConfigurationStorage sharedStorage] configurationForType:viewResult.configurationType];
    }

    NSAssert([viewResult isKindOfClass:[PPAustriaIdViewResult class]], @"View result should be PPAustriaIdViewResult");

    PPAustriaIdViewResult *austriaIdViewResult = (PPAustriaIdViewResult *)viewResult;

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentno", @"ID document number")
                                     originalKey:austriaIdViewResult.idNumberKey
                                           value:austriaIdViewResult.idNumber
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.firstname", @"Name")
                                     originalKey:austriaIdViewResult.firstNameKey
                                           value:austriaIdViewResult.firstName
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.lastname", @"Surname")
                                     originalKey:austriaIdViewResult.lastNameKey
                                           value:austriaIdViewResult.lastName
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.sex", @"Sex")
                                     originalKey:austriaIdViewResult.sexKey
                                           value:austriaIdViewResult.sex
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfBirth", @"Date of Birth")
                                     originalKey:austriaIdViewResult.dateOfBirthKey
                                           value:austriaIdViewResult.dateOfBirth
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.placeOfBirth", @"Place of birth")
                                     originalKey:austriaIdViewResult.placeOfBirthKey
                                           value:austriaIdViewResult.placeOfBirth
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.issuer", @"Issued by")
                                     originalKey:austriaIdViewResult.issuingAuthorityKey
                                           value:austriaIdViewResult.issuingAuthority
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfExpiry", @"Date of Expiry")
                                     originalKey:austriaIdViewResult.expiryDateKey
                                           value:austriaIdViewResult.expiryDate
                            editingConfiguration:configuration]];

    return views;
}

@end
