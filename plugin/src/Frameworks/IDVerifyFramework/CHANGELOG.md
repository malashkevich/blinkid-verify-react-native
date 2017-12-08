# Release notes

## 1.1.1

- Improvements for existing features
    - Improved reading of issuing authority on Croatian ID back side

## 1.1.0

- Updates and additions
    - Added support for reading Croatian ID with permanent DateOfExpiry in `PPCroIDFrontRecognizerResult` and `PPCroIDCombinedRecognizerResult` with BOOL property `isDocumentDateOfExpiryPermanent`
    - `PPBlinkOcrRecognizerResult` and `PPBlinkOcrRecognizerSettings` are now deprecated. Use `PPDetectorRecognizerResult` and `PPDetectorRecognizerSettings` for templating or `PPBlinkInputRecognizerResult` and `PPBlinkInputRecognizerSettings` for segment scan
    - `PPSerbianPdf417RecognizerResult` and `PPSerbianPdf417RecognizerSettings` are renamed to `PPSerbianBarcodeRecognizerResult` and `PPSerbianBarcodeRecognizerSettings`
    - Added Austrian Passport Recognizer `PPAusPassportRecognizerResult` and `PPAusPassportRecognizerSettings`
    - Added Swiss Passport Recognizer `PPSwissPassportRecognizerResult` and `PPSwissPassportRecognizerSettings`
    - Added Swiss ID Back Recognizer `PPSwissIDBackRecognizerResult` and `PPSwissIDBackRecognizerSettings`
    - Added support for scanning MRZ on Mexican voters card
    - Added support for reading Croatian ID with permanent DateOfExpiry in `PPCroIDFrontRecognizerResult` and `PPCroIDCombinedRecognizerResult` with BOOL property `isDocumentDateOfExpiryPermanent`
    - Added combining data from MRZ and fields in Austrian passport through `PPAusIDCombinedRecognizerResult` and `PPAusIDCombinedRecognizerSettings`
    - Added support for reading Serbian payment QR codes with `PPSerbianBarcodeRecognizerResult` and `PPSerbianBarcodeRecognizerSettings`
    - Added reading of mirrored QR codes

- Minor API changes
    - removed option to scan 1D Code39 and Code128 barcodes on US Driver's licenses that contain those barcodes alongside PDF417 barcode    

- Bugfixes:
    - fixed amount parsing from German BezahlCode
        - 0.8 is now parsed as 80 cents, not as 8 cents anymore
    - fixed autorotation of overlay view controller  
    - Fixed crash which sometimes happened while scanning MRTD documents
    - Fixed returning valid data for MRZ based recognizers when not all fields outside MRZ have been scanned  
    - fixed crash in QR code which happened periodically in all recognizers  

- Improvements for existing features
    - Improved scanning of IKad addresses
    - Improved reading of Croatian ID Address field
    - Improved reading of Croatian ID IssuedBy field
    - Date parsing improvements
    - Improved parsing of amounts with less than 2 decimals
    - better extraction of fields on back side of the Croatian ID card
    - improved USDLRecognizer - added support for new USDL standard
    - KosovoCode128Recognizer returns reference number for new barcode type

## 1.0.0

- BlinkID Verify SDK is a delightful component for quick and easy personal verification
- For now, ID scanning and verification are supported for 8 countries with addition of US Driver's License (USDL) and Machine Readable Travel Document (MRTD)
- Supporteed coountries:
    - Austria (`PPIdVerifyPresetAustria`)
    - Croatia (`PPIdVerifyPresetCroatia`)
    - Czech Republic (`PPIdVerifyPresetCzech`)
    - Germany (`PPIdVerifyPresetGermany`)
    - Serbia (`PPIdVerifyPresetSerbia`)
    - Singapore (`PPIdVerifyPresetSingapore`)
    - Slovakia (`PPIdVerifyPresetSlovakia`)
    - Slovenia (`PPIdVerifyPresetSlovenia`)
- For USDL and MRTD use: 
    - `PPIdVerifyPresetUsdl`
    - `PPIdVerifyPresetMrtd`

- **NOTE: For Austria and Germany, only NEW ID cards are supported for now**

- Please see [BlinkID Verify Wiki page](https://github.com/BlinkID/id-verify-ios/wiki) for more information and getting started with BlinkID Verify SDK