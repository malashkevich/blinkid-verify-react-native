//
//  BlinkIDVerifyReactNative.m
//  BlinkIDVerifyReactNative
//
//  Created by Jure Cular on 29/11/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "BlinkIDVerifyReactNative.h"
#import <IDVerify/IDVerify.h>

@interface BlinkIDVerifyReactNative() <PPIdVerifyDelegate>

@property (nonatomic) PPIdVerifyClient *idVerifyClient;

@property (nonatomic) PPIdVerify *idVerify;

@property (nonatomic, strong) UIImage *resultImageCroppedFront;

@property (nonatomic, strong) UIImage *resultImageCroppedBack;

@property (nonatomic) BOOL shouldReturnCroppedImages;

@property (nonatomic) BOOL shouldReturnCroppedFaceImages;

@property (nonatomic, strong) RCTPromiseResolveBlock promiseResolve;

@property (nonatomic, strong) RCTPromiseRejectBlock promiseReject;

@end

static NSString *const kLanguage = @"en";
static NSString* const kVerifyClientURL = @"https://blinkid-verify-test.microblink.com";

// promise reject message codes
static NSString* const kErrorLicenseKeyCode = @"ERROR_LICENSE_KEY_ERROR";
static NSString* const kErrorCombinedRecognizerNotDefinedCode = @"ERROR_COMBINED_RECOGNIZER_NOT_DEFINED";
static NSString* const kStatusScanCanceledCode = @"STATUS_SCAN_CANCELED";

// promise reject messages
static NSString* const kErrorLicenseKeyError = @"licenseKeyErrorMessage";
static NSString* const kErrorCombinedRecognizerNotDefined = @"Combined recognizer is not defined";
static NSString* const kStatusScanCanceled = @"Scanning has been canceled";

// js keys for scanning options
static NSString* const kOptionEnableBeepKey = @"enableBeep";
static NSString* const kOptionReturnCroppedImagesJsKey = @"shouldReturnCroppedImages";
static NSString* const kOptionReturnFaceImagesJsKey = @"shouldReturnFaceImages";
static NSString* const kCombinedRecognizerJsKey = @"combinedRecognizer";

// js keys for recognizer types
static NSString* const kRecognizerMRTDJsKey = @"RECOGNIZER_MRTD_COMBINED";

// js result keys
static NSString* const kResultImageCroppedFront = @"resultImageCroppedFront";
static NSString* const kResultImageCroppedBack = @"resultImageCroppedBack";
static NSString* const kResultImageCroppedSelfieFace = @"resultImageCroppedSelfieFace";
static NSString* const kResultImageCroppedIDFace = @"resultImageCroppedIDFace";
static NSString* const kResultType = @"resultType";
static NSString* const kRecognitionResult = @"recognitionResult";
static NSString* const kFields = @"fields";

// result values for resultType
static NSString* const kMRTDResultType = @"MRTD result";

// recognizer result keys
static NSString* const kRaw = @"raw";
static NSString* const kMRTDDateOfBirth = @"DateOfBirth";
static NSString* const kMRTDDateOExpiry = @"DateOfExpiry";

// NSError Domain
static NSString* const MBErrorDomain = @"microblink.error";

// Image postfix
static NSString* const kImagePostfix = @".Image";

@implementation BlinkIDVerifyReactNative


RCT_EXPORT_MODULE();

- (instancetype)init {
    if (self) {
        self.idVerifyClient = [[PPIdVerifyClient alloc] initWithUrl:[NSURL URLWithString:kVerifyClientURL]];

        self.idVerify = [[PPIdVerify alloc] init];
        self.idVerify.delegate = self;

    }
    return self;
}

- (NSDictionary *)constantsToExport {
    NSMutableDictionary* constants = [NSMutableDictionary dictionary];
    [constants setObject:kRecognizerMRTDJsKey forKey:kRecognizerMRTDJsKey];
    [constants setObject:kMRTDResultType forKey:kMRTDResultType];
    return [NSDictionary dictionaryWithDictionary:constants];
}

#pragma mark - PPIdVerifyDelegate

- (void)idVerify:(PPIdVerify *)idVerify didLoadContainerViewController:(PPIdVerifyContainerViewController *)containerViewController {
}

- (void)idVerifyDidStartScanning:(PPIdVerify *)idVerify {
    NSLog(@"Event 1: Front side scanning started!");
}

- (void)idVerify:(PPIdVerify *)idVerify didFinishScanningFrontSideWithResult:(PPIdVerifyResult *)result {
    NSLog(@"Event 2: Back side scanning started with intermediate result %@!", result);
}

- (void)idVerify:(PPIdVerify *)idVerify didFinishScanningWithResult:(PPIdVerifyResult *)result {
    NSLog(@"Event 3: Back and Front side scanning finished with result %@!", result);
}

- (void)idVerify:(PPIdVerify *)idVerify editedField:(NSString *)fieldKey oldValue:(NSString *)oldValue newValue:(NSString *)newValue {
    NSLog(@"Event 5: Field %@ was edited from %@ to %@", fieldKey, oldValue, newValue);
}

- (void)idVerify:(PPIdVerify *)idVerify didFinishEditingWithResult:(PPIdVerifyResult *)result {

    if (!result.edited) {
        NSLog(@"Event 6: Scanning results were accepted without changes!");
    }

    NSLog(@"Event 4: Selfie scanning started with result %@!", result);
}

- (void)idVerify:(PPIdVerify *)idVerify didFinishLivenessWithResult:(PPIdVerifyResult *)result {
    NSLog(@"Event 7: Selfie scanning finished with result %@!", result);
}

- (void)idVerify:(PPIdVerify *)idVerify doVerifyForResult:(PPIdVerifyResult *)result {
    [self.idVerifyClient verifyResult:result
                           completion:^(PPIdVerifyResponse *_Nonnull response, NSError *_Nonnull error) {
                               [idVerify idVerifyResult:result verifiedWithResponse:response error:error];
                           }];
}

- (void)idVerify:(PPIdVerify *)idVerify didFinishWithSuccessfulVerification:(nonnull PPIdVerifyResult *)idVerifyResult {
    NSMutableDictionary *resultDictionary;

    for (PPRecognizerResult *result in idVerifyResult.recognizerResults.results.allValues) {

        if ([result isKindOfClass:[PPMrtdCombinedRecognizerResult class]]) {
            PPMrtdCombinedRecognizerResult *combinedRecognizerResult = (PPMrtdCombinedRecognizerResult*)result;

            resultDictionary = [self createMRTDResult:combinedRecognizerResult];

            if (idVerifyResult.viewResult.selfieImage && self.shouldReturnCroppedFaceImages) {
                resultDictionary[kResultImageCroppedSelfieFace] = [self encodeImage:idVerifyResult.viewResult.selfieImage];
            }

            if (idVerifyResult.viewResult.faceImage && self.shouldReturnCroppedFaceImages) {
                resultDictionary[kResultImageCroppedIDFace] = [self encodeImage:idVerifyResult.viewResult.faceImage];
            }

            break;
        }

    }

    [self finishWithScanningResults:resultDictionary];
}

- (void)idVerify:(PPIdVerify *)idVerify didFinishWithoutVerification:(nonnull PPIdVerifyResult *)idVerifyResult {

}

#pragma mark - ResultExtract

/**
 Creates resulting dictionary from MRTD combined result
 Structure of the resulting dictionary is as follows:

 {
    resultImageCroppedFront: document front image
    resultImageCroppedBack: document back image
    resultImageCroppedSelfieFace: selfie image
    resultImageCroppedIDFace: document face image
    recognitionResult: {
                         fields: dictionary containing results
                         resultType: result type
                         raw: raw results
                        }

 }

 @param result MRTD combined rexognizer results
 @return resulting dictionary
 */
- (NSMutableDictionary *)createMRTDResult:(PPMrtdCombinedRecognizerResult *)result {

    NSMutableDictionary *stringElements = [NSMutableDictionary dictionaryWithDictionary:[result getAllStringElements]];
    // Add date of birth to dictionary
    stringElements[kMRTDDateOfBirth] = result.rawDateOfBirth;
    // Add date of exipiry to dictionary
    stringElements[kMRTDDateOExpiry] = result.rawDateOfExpiry;

    NSMutableDictionary *recognitionResult = [[NSMutableDictionary alloc] init];
    // Add all results to recognitionResult
    recognitionResult[kFields] = stringElements;
    // Add raw result to recognitionResult
    recognitionResult[kRaw] = result.mrzText;
    // Add result type to recognitionResult
    recognitionResult[kResultType] = kMRTDResultType;


    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] init];
    // Add recognitionResult to resulting dictionary
    resultDictionary[kRecognitionResult] = recognitionResult;

    // Add cropped images if needed
    if (self.shouldReturnCroppedImages) {
        resultDictionary[kResultImageCroppedFront] = [[result getDataElement:[[PPMrtdCombinedRecognizerSettings FULL_DOCUMENT_IMAGE_BACK] stringByAppendingString:kImagePostfix]] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        resultDictionary[kResultImageCroppedBack] = [[result getDataElement:[[PPMrtdCombinedRecognizerSettings FULL_DOCUMENT_IMAGE_FRONT] stringByAppendingString:kImagePostfix]] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }

    return resultDictionary;
}

/**
 Method creates jpeg representation of the given iamge and encodes it into base64

 @param image UIImage object being encoded to base64
 @return JPEG representation of image encoded to base64
 */
- (NSString *)encodeImage:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 0.9f);
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark - Scanning finished

/**
 Method used to reject promise with given error code and a message

 @param errorCode Error Code
 @param message Error message
 */
- (void)promiseRejectWithErrorCode:(NSString *)errorCode message:(NSString *)message {
    if (self.promiseReject) {
        self.promiseReject(errorCode, message, nil);
    }
}

/**
 Method used to resolve promise

 @param results Results sent as a result of promise resolve
 */
- (void)finishWithScanningResults:(NSDictionary*)results {
    if (self.promiseResolve && results) {
        self.promiseResolve(results);
    }

    [self dismissScanningView];
}

- (void)scanningCanceled {
    [self promiseRejectWithErrorCode:kStatusScanCanceledCode message:kStatusScanCanceled];
    [self dismissScanningView];
}

/**
 Method resets promise resolve and reject
 */
- (void)reset {
    self.promiseResolve = nil;
    self.promiseReject = nil;
}

/**
 Method dismisses view controller and rests promise reslove and reject
 */
- (void)dismissScanningView {
    [self reset];
    [[self getRootViewController] dismissViewControllerAnimated:YES completion:nil];
}

/**
 Method gets current root view controller

 @return Root view controller
 */
- (UIViewController*)getRootViewController {
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    return rootViewController;
}

#pragma mark - Scanning

RCT_REMAP_METHOD(scan, scan:(NSString *)key withOptions:(NSDictionary*)scanOptions  licenseKeyLivenessRecognizer:(NSString *)livenessKey resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {

    self.resultImageCroppedBack = nil;
    self.resultImageCroppedFront = nil;

    self.shouldReturnCroppedImages = [[scanOptions valueForKey:kOptionReturnCroppedImagesJsKey] boolValue];

    self.shouldReturnCroppedFaceImages = [[scanOptions valueForKey:kOptionReturnFaceImagesJsKey] boolValue];

    [self configureVerifySettingsLicenseKey:key licenseKeyLivenessRecognizer:livenessKey options:scanOptions];

    self.promiseResolve = resolve;
    self.promiseReject  = reject;

    dispatch_sync(dispatch_get_main_queue(), ^{
        UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        UIViewController *verifyContainerViewController = [self getIdVerifyContainerViewControllerForPreset:scanOptions[kCombinedRecognizerJsKey]];

        if (verifyContainerViewController == nil) {
            [self promiseRejectWithErrorCode:kErrorCombinedRecognizerNotDefinedCode message:kErrorCombinedRecognizerNotDefined];
            return;
        }

        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:verifyContainerViewController];
        verifyContainerViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(scanningCanceled)];
        [rootViewController presentViewController:navigationController animated:YES completion:nil];

    });
}

#pragma mark - network requests

- (void)updateConfigurationsWithCompletion:(nullable void (^)(NSError *_Nonnull))completion {
    [self.idVerifyClient
     getConfigurationWithCompletion:^(NSArray<PPGetConfigurationResponse *> *_Nonnull response, NSError *_Nonnull error) {
         if (error == nil) {
             if ([response count] > 0) {
                 for (PPGetConfigurationResponse *getConfigurationResponse in response) {
                     if (getConfigurationResponse.loaded) {
                         [[PPConfigurationStorage sharedStorage] storeConfiguration:getConfigurationResponse.data];
                     }
                 }
             }
         }

         dispatch_async(dispatch_get_main_queue(), ^{
             if (completion) {
                 completion(error);
             }
         });
     }];
}

#pragma mark - PPIdVerifyContainerViewController configuration

- (PPIdVerifyContainerViewController *)getIdVerifyContainerViewControllerForPreset:(NSString *)combinedRecognizerName {

    PPIdVerifyPreset preset;
    if ([combinedRecognizerName isEqualToString:kRecognizerMRTDJsKey]) {
        preset = PPIdVerifyPresetMrtd;
    } else {
        return nil;
    }

    PPIdVerifyContainerViewController *verifyContainerViewController =
    [PPIdVerifyContainerViewController verifyContainerViewControllerForCountryPreset:preset];

    [self.idVerify setVerifyContainerViewController:verifyContainerViewController];

    return verifyContainerViewController;
}

- (void)configureVerifySettingsLicenseKey:(NSString *)key licenseKeyLivenessRecognizer:(NSString *)livenessKey options:(NSDictionary *)scanOptions{
    [PPIdVerifySettings sharedSettings].licenseKey = key;

    // Development key - not valid for production!
    [PPIdVerifySettings sharedSettings].livenessLicenseKey = livenessKey;

    [PPIdVerifySettings sharedSettings].localizationSettings.languageID = kLanguage;

    [PPIdVerifySettings sharedSettings].enableBeep = [[scanOptions valueForKey:kOptionEnableBeepKey] boolValue];

    [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationPrimaryColor =
    [UIColor colorWithRed:135.f / 255.f green:197.f / 255.f blue:64.f / 255.f alpha:1.0f];
    [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.pronunciationSecondaryColor =
    [UIColor colorWithRed:13.f / 255.f green:162.f / 255.f blue:204.f / 255.f alpha:1.0f];
    [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.oddTableCellColor = [UIColor whiteColor];
    [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.evenTableCellColor =
    [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.cellTitleLabelColor =
    [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1.0];
    [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.livenessErrorColor =
    [UIColor colorWithRed:232.f / 255.f green:78.f / 255.f blue:64.f / 255.f alpha:1.0f];
    [PPIdVerifySettings sharedSettings].uiSettings.colorScheme.keyboardBackgroundColor = [UIColor whiteColor];

    [PPIdVerifySettings sharedSettings].uiSettings.scanHelpImage = [UIImage imageNamed:@"ScanHelp"];
    [PPIdVerifySettings sharedSettings].uiSettings.selfieHelpImage = [UIImage imageNamed:@"SelfieHelp"];
}

@end
