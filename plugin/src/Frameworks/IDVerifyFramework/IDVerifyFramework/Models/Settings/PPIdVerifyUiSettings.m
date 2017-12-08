//
//  PPIdVerifyUiSettings.m
//  IDVerifyFramework
//
//  Created by Jura on 11/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPIdVerifyUiSettings.h"

@implementation PPIdVerifyUiSettings

- (instancetype)init {
    self = [super init];
    if (self) {
        _fontFamily = nil;
        _basicFontSize = 15.f;
        _basicFontScale = 1.0f;
        _colorScheme = [[PPIdVerifyColorScheme alloc] init];
    }
    return self;
}

- (UIFontDescriptor *)fontDescriptor {
    if (self.fontFamily) {
        return [UIFontDescriptor fontDescriptorWithFontAttributes:@{
            UIFontDescriptorFamilyAttribute : self.fontFamily,
            UIFontDescriptorSizeAttribute : @(self.basicFontSize)
        }];
    } else {
        UIFont *font = [UIFont systemFontOfSize:self.basicFontSize];
        return [font fontDescriptor];
    }
}

- (UIFont *)fontWithWeight:(CGFloat)weight pointSizeDiff:(CGFloat)pointSizeDiff {

    return [self fontWithWeight:weight relativeScale:1.0f pointSizeDiff:pointSizeDiff];
}

- (UIFont *)fontWithWeight:(CGFloat)weight relativeScale:(CGFloat)relativeScale pointSizeDiff:(CGFloat)pointSizeDiff {

    UIFontDescriptor *desc = [self.fontDescriptor fontDescriptorByAddingAttributes:@{
        UIFontDescriptorTraitsAttribute : @{UIFontWeightTrait : @(weight)}
    }];

    UIFont *font = [UIFont fontWithDescriptor:desc size:(self.basicFontSize * self.basicFontScale * relativeScale + pointSizeDiff)];

    return font;
}

NSString *instructionsKeyV1 = @"pp_instructions_v1";


- (BOOL)areInstructionPresented {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSObject *obj = [userDefaults objectForKey:instructionsKeyV1];
    if (obj == nil) {
        return NO;
    }
    NSAssert([obj isKindOfClass:[NSNumber class]], @"areInstructionPresented should be BOOL");
    return [((NSNumber *) obj) boolValue];
}

- (void)setInstructionsPresented:(BOOL)presented {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:presented] forKey:instructionsKeyV1];
}

@end
