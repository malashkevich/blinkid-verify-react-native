//
//  PPSloveniaIdResultViewPopulator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSloveniaIdResultViewPopulator.h"

@implementation PPSloveniaIdResultViewPopulator

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult editingEnabled:(BOOL)editingEnabled {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    PPConfiguration *configuration = nil;
    if (editingEnabled) {
        configuration = [[PPConfigurationStorage sharedStorage] configurationForType:viewResult.configurationType];
    }
    
    NSAssert([viewResult isKindOfClass:[PPSloveniaIdViewResult class]], @"View result should be PPSloveniaIdViewResult");
    
    PPSloveniaIdViewResult *sloveniaIdViewResult = (PPSloveniaIdViewResult *)viewResult;
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentno", @"ID document number")
                                     originalKey:sloveniaIdViewResult.idNumberKey
                                           value:sloveniaIdViewResult.idNumber
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.firstname", @"Name")
                                     originalKey:sloveniaIdViewResult.firstNameKey
                                           value:sloveniaIdViewResult.firstName
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.lastname", @"Surname")
                                     originalKey:sloveniaIdViewResult.lastNameKey
                                           value:sloveniaIdViewResult.lastName
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.personalIdentificationNumber", @"PIN")
                                     originalKey:sloveniaIdViewResult.personalIdentificationNumberKey
                                           value:sloveniaIdViewResult.personalIdentificationNumber
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.sex", @"Sex")
                                     originalKey:sloveniaIdViewResult.sexKey
                                           value:sloveniaIdViewResult.sex
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfBirth", @"Date of Birth")
                                     originalKey:sloveniaIdViewResult.dateOfBirthKey
                                           value:sloveniaIdViewResult.dateOfBirth
                            editingConfiguration:configuration]];
    
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.nationality", @"Nationality")
                                     originalKey:sloveniaIdViewResult.citizenshipKey
                                           value:sloveniaIdViewResult.citizenship
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.address", @"Address")
                                     originalKey:sloveniaIdViewResult.addressKey
                                           value:sloveniaIdViewResult.address
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.issuer", @"Issued by")
                                     originalKey:sloveniaIdViewResult.issuingAuthorityKey
                                           value:sloveniaIdViewResult.issuingAuthority
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfExpiry", @"Date of Expiry")
                                     originalKey:sloveniaIdViewResult.expiryDateKey
                                           value:sloveniaIdViewResult.expiryDate
                            editingConfiguration:configuration]];
    
    return views;
}

@end
