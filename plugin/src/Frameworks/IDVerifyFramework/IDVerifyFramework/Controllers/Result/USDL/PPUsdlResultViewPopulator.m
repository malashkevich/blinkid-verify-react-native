//
//  PPUsdlResultViewPopulator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPUsdlResultViewPopulator.h"

@implementation PPUsdlResultViewPopulator

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult editingEnabled:(BOOL)editingEnabled {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    PPConfiguration *configuration = nil;
    if (editingEnabled) {
        configuration = [[PPConfigurationStorage sharedStorage] configurationForType:viewResult.configurationType];
    }
    
    NSAssert([viewResult isKindOfClass:[PPUsdlViewResult class]], @"View result should be PPUsdlViewResult");
    
    PPUsdlViewResult *usdlViewResult = (PPUsdlViewResult *)viewResult;
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentno", @"ID document number")
                                     originalKey:usdlViewResult.idNumberKey
                                           value:usdlViewResult.idNumber
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.firstname", @"Name")
                                     originalKey:usdlViewResult.firstNameKey
                                           value:usdlViewResult.firstName
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.lastname", @"Surname")
                                     originalKey:usdlViewResult.lastNameKey
                                           value:usdlViewResult.lastName
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.sex", @"Sex")
                                     originalKey:usdlViewResult.sexKey
                                           value:usdlViewResult.sex
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfBirth", @"Date of Birth")
                                     originalKey:usdlViewResult.dateOfBirthKey
                                           value:usdlViewResult.dateOfBirth
                            editingConfiguration:configuration]];
    
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.address", @"Address")
                                     originalKey:usdlViewResult.addressKey
                                           value:usdlViewResult.address
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.issuer", @"Issued by")
                                     originalKey:usdlViewResult.issuingAuthorityKey
                                           value:usdlViewResult.issuingAuthority
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfExpiry", @"Date of Expiry")
                                     originalKey:usdlViewResult.expiryDateKey
                                           value:usdlViewResult.expiryDate
                            editingConfiguration:configuration]];
    
    return views;
}

@end
