//
//  PPSerbianBarcodeRecognizerResult.h
//  MicroBlinkDev
//
//  Created by Jura Skrlec on 21/06/2017.
//
//

#import "PPPhotoPayRecognizerResult.h"

/**
 * Result of scanning of Serbian payment barcodes
 */
PP_CLASS_AVAILABLE_IOS(6.0)
@interface PPSerbianBarcodeRecognizerResult : PPPhotoPayRecognizerResult

/**
 * Address of the payment receiver
 */
@property (nonatomic, readonly, nullable) NSString *recipientAddress;

/**
 * Additional address detailes for the payment receiver
 */
@property (nonatomic, readonly, nullable) NSString *recipientDetailedAddress;

/**
 * Additional data available at the end of HUB3 QR and PDF417 barcode
 */
@property (nonatomic, readonly, nullable) NSString *optionalData;

/**
 * Address of the payer
 */
@property (nonatomic, readonly, nullable) NSString *payerAddress;

/**
 * Additional detailed address of the payer
 */
@property (nonatomic, readonly, nullable) NSString *payerDetailedAddress;

/**
 * recipientName - name of the receiving side
 */
@property (nonatomic, readonly, nullable) NSString *recipientName;

/**
 * payer name - name of the payer
 */
@property (nonatomic, readonly, nullable) NSString *payerName;

/**
 * String representing valid bank account number to which the payment goes
 */
@property (nonatomic, readonly, nullable) NSString *accountNumber;

/**
 * String representing reference number of the payment
 */
@property (nonatomic, readonly, nullable) NSString *referenceNumber;

/**
 * String representing model of the reference
 */
@property (nonatomic, readonly, nullable) NSString *referenceModel;

/**
 * PaymentDescription - string that describes the payment purpose
 */
@property (nonatomic, readonly, nullable) NSString *paymentDescription;

/**
 * String that represents the purpose code
 */
@property (nonatomic, readonly, nullable) NSString *purposeCode;

/**
 * String that represents the ID of slip
 */
@property (nonatomic, readonly, nullable) NSString *slipID;


@end
