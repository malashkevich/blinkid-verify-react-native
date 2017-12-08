//
//  PPIdVerifyUiSettings.h
//  IDVerifyFramework
//
//  Created by Jura on 11/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PPIdVerifyColorScheme.h"

@interface PPIdVerifyUiSettings : NSObject


/**
 * Defines the font family used throughout the ID verification screens.
 *
 * If nil, system font will be used
 *
 * Default - nil
 */
@property (nonatomic) NSString *fontFamily;


/**
 * Basic font size used in ID Verify
 *
 * Default: 15.f
 */
@property (nonatomic) CGFloat basicFontSize;

/**
 * Basic font scale used in ID Verify
 *
 * Default: 1.0f;
 */
@property (nonatomic) CGFloat basicFontScale;

/**
 * Utility getter for font descriptor
 *
 * if fontFamily is set, we return FontDescriptor with font attributes set to this font family, and basicFontSize.
 *
 * If font family is not set, we return FontDescriptor of system font with size basicFontSize.
 */
@property (nonatomic, readonly) UIFontDescriptor *fontDescriptor;

/**
 * Color scheme used throughout the UX
 *
 * Default - color scheme initialzed with [[PPIdVerifyColorScheme alloc] init]
 */
@property (nonatomic, strong) PPIdVerifyColorScheme *colorScheme;

/**
 * UIImage used when presenting scan help
 *
 * Default is nil - if you want to present scan help - you need to set the image!
 */
@property (nonatomic, strong) UIImage *scanHelpImage;

/**
 * UIImage used when presenting selfie help
 *
 * Default is nil - if you want to present selfie help - you need to set the image!
 */
@property (nonatomic, strong) UIImage *selfieHelpImage;

/**
 * Initializes UI settings object with default properties
 *
 * @return instance with default properties
 */
- (instancetype)init;

/**
 * Method to get font with specified weight and a difference to basicFontSize.
 * 
 * If basicFontSize is 15, and pointSizeDiff is -2, we'll get a font with size 13.
 *
 * This method calles fontWithWeight:relativeScale:pointSizeDiff, with relativeScale set to 1.0f;
 *
 * @param weight weight of the font specified
 * @param pointSizeDiff difference to basicFontSize.
 * @return UIFont instance
 */
- (UIFont *)fontWithWeight:(CGFloat)weight pointSizeDiff:(CGFloat)pointSizeDiff;

/**
 * Method to get font with specified weight and a difference to basicFontSize
 *
 * If 
 *   basicFontSize is 15,
 *   basicFontScale is 1.5
 * and
 *   relative scale is 2.0f
 *   pointSizeDiff is -2
 *
 * We'll get a font of size 
 *   self.basicFontSize * self.basicFontScale * relativeScale + pointSizeDiff
 * Which is
 *   15 * 1.5 * 2.0 - 2 = 43
 *
 * @param weight weight of the font specified
 * @param relativeScale scale of the font.
 * @param pointSizeDiff difference to basicFontSize.
 * @return UIFont instance
 */
- (UIFont *)fontWithWeight:(CGFloat)weight relativeScale:(CGFloat)relativeScale pointSizeDiff:(CGFloat)pointSizeDiff;

/**
 * If NO, instructions will be presented automatically on first ID scan and liveness
 *
 * @return YES if instructions were presented, NO otherwise
 */
- (BOOL)areInstructionPresented;

/**
 * Persists the information that the instructions were presented (or not)
 *
 * @param presented value which is persisted
 */
- (void)setInstructionsPresented:(BOOL)presented;

@end
