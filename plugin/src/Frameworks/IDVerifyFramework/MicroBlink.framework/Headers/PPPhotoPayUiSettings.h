//
//  PPPhotoPayUiSettings.h
//  PhotoPayFramework
//
//  Created by Jura on 25/02/15.
//  Copyright (c) 2015 MicroBlink Ltd. All rights reserved.
//

#import "PPUiSettings.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Settings class containing parameters for PhotoPay UI
 */
PP_CLASS_AVAILABLE_IOS(6.0)
@interface PPPhotoPayUiSettings : PPUiSettings

/**
 * If YES, Toast (tooltip) messages will appear on screen describing the next steps to the user
 *
 * Default: YES.
 */
@property (nonatomic, assign) BOOL presentToast;

/**
 * If YES, viewfinder (4 corner markers) will move when payslip is detected
 *
 * Default: YES
 */
@property (nonatomic, assign) BOOL viewfinderMoveable;

/**
 * If YES; barcode dots will be displayed if detected.
 *
 * Default: NO
 */
@property (nonatomic, assign) BOOL displayBarcodeDots;

/**
 * Initializes the object with default settings.
 *
 *  @return object initialized with default values.
 */
- (instancetype)init;

/**
 * Designated initializer. Initializes the object with default settings (see above for defaults).
 *
 * Also receives a path to the sound file used when scanning finishes successfully
 *
 *  @return object initialized with default values.
 */
- (instancetype)initWithSoundFilePath:(nullable NSString *)soundFilePath NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
