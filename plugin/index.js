'use strict';
/**
 * This exposes the appropriate native BlinkID module module as a JS module, based on 
 * detected platvorm: Android or iOS. This has a
 * function 'scan' which takes the following parameters:
 *
 * 1. String licenseKeyMicroblinkSDK: Microblink SDK license key bound to application ID for Android or iOS. To obtain
 *                                    valid license key, please contact us at http://help.microblink.com
 * 2. Object scanningOptions: key-value pairs which contains scanning options map with following key-value pairs:
 *                            enableBeep -> boolean: if it is set to true, successful scan will play a sound
 *                            shouldReturnCroppedImages -> boolean
 *                            shouldReturnFaceImages -> boolean
 *                            combinedRecognizer -> combined recognizer that will be used for document scan
 * 3. String licenseKeyLivenessRecognizer:  License key for the liveness recognizer which is used for user liveness
 *                                          recognition and taking the selfie picture
 * 4. Promise promise: promise for returning scan results
 */
import { Platform, NativeModules } from 'react-native';

export const BlinkIDVerify = Platform.select({
      ios: NativeModules.BlinkIDVerifyReactNative,
      android: NativeModules.BlinkIDVerifyAndroid
})

/**
 * Following exports expose the keys (string constants) for obtaining result values for
 * corresponding result types.
 */
export const MRTDKeys = require('./keys/mrtd_keys')
