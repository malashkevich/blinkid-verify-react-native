//
//  PPPhotoPayResult.h
//  PhotoPayFramework
//
//  Created by Jura on 08/03/15.
//  Copyright (c) 2015 MicroBlink Ltd. All rights reserved.
//

#import "PPRecognizerResult.h"

/**
 * Common class for all PhotoPay recognizer results. Contains getters for amount and currency.
 */
PP_CLASS_AVAILABLE_IOS(6.0) @interface PPPhotoPayRecognizerResult : PPRecognizerResult

/**
 * Amount as Integer, in the sallest possible denomination. If the currency is EUR and
 * amount is 10.23 EUR, this value will be 1023
 *
 * 0 if no value is specified
 */
@property (nonatomic, readonly) NSInteger intAmount;

/**
 * Amount as a decimal number. If the currency is EUR and amount is 10.23 EUR, this value will be 10.23, in full floating point precision.
 */
@property (nonatomic, readonly, nonnull) NSDecimalNumber *amount;

/**
 * String representing the currency for payment. In ISO 4217 standard.
 *  @see http://en.wikipedia.org/wiki/ISO_4217
 */
@property (nonatomic, readonly, nullable) NSString *currency;

@end
