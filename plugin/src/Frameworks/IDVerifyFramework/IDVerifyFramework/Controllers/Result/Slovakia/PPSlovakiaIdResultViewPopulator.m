//
//  PPSlovakiaIdResultViewPopulator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSlovakiaIdResultViewPopulator.h"

@implementation PPSlovakiaIdResultViewPopulator

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult editingEnabled:(BOOL)editingEnabled {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    PPConfiguration *configuration = nil;
    if (editingEnabled) {
        configuration = [[PPConfigurationStorage sharedStorage] configurationForType:viewResult.configurationType];
    }
    
    NSAssert([viewResult isKindOfClass:[PPSlovakiaIdViewResult class]], @"View result should be PPSlovakiaIdViewResult");
    
    PPSlovakiaIdViewResult *slovakiaIdViewResult = (PPSlovakiaIdViewResult *)viewResult;
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentno", @"ID document number")
                                     originalKey:slovakiaIdViewResult.idNumberKey
                                           value:slovakiaIdViewResult.idNumber
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.firstname", @"Name")
                                     originalKey:slovakiaIdViewResult.firstNameKey
                                           value:slovakiaIdViewResult.firstName
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.lastname", @"Surname")
                                     originalKey:slovakiaIdViewResult.lastNameKey
                                           value:slovakiaIdViewResult.lastName
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.personalIdentificationNumber", @"PIN")
                                     originalKey:slovakiaIdViewResult.personalIdentificationNumberKey
                                           value:slovakiaIdViewResult.personalIdentificationNumber
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.sex", @"Sex")
                                     originalKey:slovakiaIdViewResult.sexKey
                                           value:slovakiaIdViewResult.sex
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfBirth", @"Date of Birth")
                                     originalKey:slovakiaIdViewResult.dateOfBirthKey
                                           value:slovakiaIdViewResult.dateOfBirth
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.placeOfBirth", @"Place of birth")
                                     originalKey:slovakiaIdViewResult.placeOfBirthKey
                                           value:slovakiaIdViewResult.placeOfBirth
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.nationality", @"Nationality")
                                     originalKey:slovakiaIdViewResult.nationalityKey
                                           value:slovakiaIdViewResult.nationality
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.address", @"Address")
                                     originalKey:slovakiaIdViewResult.addressKey
                                           value:slovakiaIdViewResult.address
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.issuer", @"Issued by")
                                     originalKey:slovakiaIdViewResult.issuingAuthorityKey
                                           value:slovakiaIdViewResult.issuingAuthority
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfExpiry", @"Date of Expiry")
                                     originalKey:slovakiaIdViewResult.expiryDateKey
                                           value:slovakiaIdViewResult.expiryDate
                            editingConfiguration:configuration]];
    
    return views;
}

@end
