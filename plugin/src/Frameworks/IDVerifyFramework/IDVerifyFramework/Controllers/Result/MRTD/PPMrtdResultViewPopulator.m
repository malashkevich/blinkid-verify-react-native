//
//  PPMrtdResultViewPopulator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 06/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPMrtdResultViewPopulator.h"
#import "PPMrtdViewResult.h"

#import "PPLocalization.h"
#import "PPConfigurationStorage.h"

@implementation PPMrtdResultViewPopulator

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult editingEnabled:(BOOL)editingEnabled {
    NSMutableArray *views = [[NSMutableArray alloc] init];

    PPConfiguration *configuration = nil;
    if (editingEnabled) {
        configuration = [[PPConfigurationStorage sharedStorage] configurationForType:viewResult.configurationType];
    }

    NSAssert([viewResult isKindOfClass:[PPMrtdViewResult class]], @"View result should be PPMrtdViewResult");

    PPMrtdViewResult *mrtdIdViewResult = (PPMrtdViewResult *)viewResult;

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.firstname", @"Name")
                                     originalKey:mrtdIdViewResult.firstNameKey
                                           value:mrtdIdViewResult.firstName
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.lastname", @"Surname")
                                     originalKey:mrtdIdViewResult.lastNameKey
                                           value:mrtdIdViewResult.lastName
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentno", @"ID document number")
                                     originalKey:mrtdIdViewResult.idNumberKey
                                           value:mrtdIdViewResult.idNumber
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentcode", @"Document code")
                                     originalKey:mrtdIdViewResult.documentCodeKey
                                           value:mrtdIdViewResult.documentCode
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfBirth", @"Date of Birth")
                                     originalKey:mrtdIdViewResult.dateOfBirthKey
                                           value:mrtdIdViewResult.dateOfBirth
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.sex", @"Sex")
                                     originalKey:mrtdIdViewResult.sexKey
                                           value:mrtdIdViewResult.sex
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.nationality", @"Nationality")
                                     originalKey:mrtdIdViewResult.nationalityKey
                                           value:mrtdIdViewResult.nationality
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.issuer", @"Issued by")
                                     originalKey:mrtdIdViewResult.issuingAuthorityKey
                                           value:mrtdIdViewResult.issuingAuthority
                            editingConfiguration:configuration]];

    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfExpiry", @"Date of Expiry")
                                     originalKey:mrtdIdViewResult.expiryDateKey
                                           value:mrtdIdViewResult.expiryDate
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.opt1", @"Optional 1")
                                     originalKey:mrtdIdViewResult.opt1Key
                                           value:mrtdIdViewResult.opt1
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.opt2", @"Optional 2")
                                     originalKey:mrtdIdViewResult.opt2Key
                                           value:mrtdIdViewResult.opt2
                            editingConfiguration:configuration]];

    return views;
}

@end
