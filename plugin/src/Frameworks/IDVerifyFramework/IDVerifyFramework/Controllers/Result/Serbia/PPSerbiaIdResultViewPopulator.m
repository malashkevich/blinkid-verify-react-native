//
//  PPSerbiaIdResultViewPopulator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSerbiaIdResultViewPopulator.h"

#import "PPSerbiaIdViewResult.h"

#import "PPLocalization.h"
#import "PPConfigurationStorage.h"

@implementation PPSerbiaIdResultViewPopulator

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult editingEnabled:(BOOL)editingEnabled {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    PPConfiguration *configuration = nil;
    if (editingEnabled) {
        configuration = [[PPConfigurationStorage sharedStorage] configurationForType:viewResult.configurationType];
    }
    
    NSAssert([viewResult isKindOfClass:[PPSerbiaIdViewResult class]], @"View result should be PPserbiaIdViewResult");
    
    PPSerbiaIdViewResult *serbiaIdViewResult = (PPSerbiaIdViewResult *)viewResult;
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentno", @"ID document number")
                                     originalKey:serbiaIdViewResult.idNumberKey
                                           value:serbiaIdViewResult.idNumber
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.firstname", @"Name")
                                     originalKey:serbiaIdViewResult.firstNameKey
                                           value:serbiaIdViewResult.firstName
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.lastname", @"Surname")
                                     originalKey:serbiaIdViewResult.lastNameKey
                                           value:serbiaIdViewResult.lastName
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.sex", @"Sex")
                                     originalKey:serbiaIdViewResult.sexKey
                                           value:serbiaIdViewResult.sex
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfBirth", @"Date of Birth")
                                     originalKey:serbiaIdViewResult.dateOfBirthKey
                                           value:serbiaIdViewResult.dateOfBirth
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.jmbg", @"JMBG")
                                     originalKey:serbiaIdViewResult.JMBGKey
                                           value:serbiaIdViewResult.JMBG
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.nationality", @"Nationality")
                                     originalKey:serbiaIdViewResult.nationalityKey
                                           value:serbiaIdViewResult.nationality
                            editingConfiguration:configuration]];
    
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.issuer", @"Issued by")
                                     originalKey:serbiaIdViewResult.issuingAuthorityKey
                                           value:serbiaIdViewResult.issuingAuthority
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfExpiry", @"Date of Expiry")
                                     originalKey:serbiaIdViewResult.expiryDateKey
                                           value:serbiaIdViewResult.expiryDate
                            editingConfiguration:configuration]];
    
    return views;
}


@end
