//
//  PPSingaporeIdResultViewPopulator.m
//  IDVerifyFramework
//
//  Created by Jura Skrlec on 03/07/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPSingaporeIdResultViewPopulator.h"

#import "PPSingaporeIdViewResult.h"

#import "PPLocalization.h"
#import "PPConfigurationStorage.h"

@implementation PPSingaporeIdResultViewPopulator

- (NSArray<PPIdResultItemView *> *)populateViewsForViewResult:(PPIdViewResult *)viewResult editingEnabled:(BOOL)editingEnabled {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    PPConfiguration *configuration = nil;
    if (editingEnabled) {
        configuration = [[PPConfigurationStorage sharedStorage] configurationForType:viewResult.configurationType];
    }
    
    NSAssert([viewResult isKindOfClass:[PPSingaporeIdViewResult class]], @"View result should be PPSingaporeIdViewResult");
    
    PPSingaporeIdViewResult *singaporeVerifyResult = (PPSingaporeIdViewResult *)viewResult;
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.documentno", @"ID document number")
                                     originalKey:singaporeVerifyResult.idNumberKey
                                           value:singaporeVerifyResult.idNumber
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.firstname", @"Name")
                                     originalKey:singaporeVerifyResult.nameKey
                                           value:singaporeVerifyResult.name
                            editingConfiguration:configuration]];
    
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.sex", @"Sex")
                                     originalKey:singaporeVerifyResult.sexKey
                                           value:singaporeVerifyResult.sex
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.race", @"Race")
                                     originalKey:singaporeVerifyResult.raceKey
                                           value:singaporeVerifyResult.race
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.bloodGroup", @"Blood Group")
                                     originalKey:singaporeVerifyResult.bloodGroupKey
                                           value:singaporeVerifyResult.bloodGroup
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.countryOfBirth", @"Country of Birth")
                                     originalKey:singaporeVerifyResult.countryOfBirthKey
                                           value:singaporeVerifyResult.countryOfBirth
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.dateOfBirth", @"Date of Birth")
                                     originalKey:singaporeVerifyResult.dateOfBirthKey
                                           value:singaporeVerifyResult.dateOfBirth
                            editingConfiguration:configuration]];
    
    [views addObject:[self editableViewWithTitle:PP_LOCALIZED_RESULT(@"result.fieldtitle.address", @"Address")
                                     originalKey:singaporeVerifyResult.addressKey
                                           value:singaporeVerifyResult.address
                            editingConfiguration:configuration]];
    
    return views;
}

@end
