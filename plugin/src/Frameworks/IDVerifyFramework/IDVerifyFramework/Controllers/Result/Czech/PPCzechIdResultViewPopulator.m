//
//  PPCzechIdResultViewPopulator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 30/06/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPCzechIdResultViewPopulator.h"

#import "PPCzechIdViewResult.h"

#import "PPLocalization.h"
#import "PPConfigurationStorage.h"

@implementation PPCzechIdResultViewPopulator

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult editingEnabled:(BOOL)editingEnabled {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    PPConfiguration *configuration = nil;
    if (editingEnabled) {
        configuration = [[PPConfigurationStorage sharedStorage] configurationForType:viewResult.configurationType];
    }
    
    NSAssert([viewResult isKindOfClass:[PPCzechIdViewResult class]], @"View result should be PPCzechIdViewResult");
    
    PPCzechIdViewResult *czechIdViewResult = (PPCzechIdViewResult *)viewResult;
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentno", @"ID document number")
                                     originalKey:czechIdViewResult.idNumberKey
                                           value:czechIdViewResult.idNumber
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.firstname", @"Name")
                                     originalKey:czechIdViewResult.firstNameKey
                                           value:czechIdViewResult.firstName
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.lastname", @"Surname")
                                     originalKey:czechIdViewResult.lastNameKey
                                           value:czechIdViewResult.lastName
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.personalIdentificationNumber", @"PIN")
                                     originalKey:czechIdViewResult.personalIdentificationNumberKey
                                           value:czechIdViewResult.personalIdentificationNumber
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.sex", @"Sex")
                                     originalKey:czechIdViewResult.sexKey
                                           value:czechIdViewResult.sex
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfBirth", @"Date of Birth")
                                     originalKey:czechIdViewResult.dateOfBirthKey
                                           value:czechIdViewResult.dateOfBirth
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.placeOfBirth", @"Place of birth")
                                     originalKey:czechIdViewResult.placeOfBirthKey
                                           value:czechIdViewResult.placeOfBirth
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.nationality", @"Nationality")
                                     originalKey:czechIdViewResult.nationalityKey
                                           value:czechIdViewResult.nationality
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.address", @"Address")
                                     originalKey:czechIdViewResult.addressKey
                                           value:czechIdViewResult.address
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.issuer", @"Issued by")
                                     originalKey:czechIdViewResult.issuingAuthorityKey
                                           value:czechIdViewResult.issuingAuthority
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfExpiry", @"Date of Expiry")
                                     originalKey:czechIdViewResult.expiryDateKey
                                           value:czechIdViewResult.expiryDate
                            editingConfiguration:configuration]];
    
    return views;
}

@end
