package com.microblink.reactnative.blinkidverify;

import android.app.Activity;
import android.content.Intent;
import android.util.Base64;
import android.util.Log;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;
import com.microblink.reactnative.blinkidverify.manager.ScanningConfiguration;
import com.microblink.reactnative.blinkidverify.manager.VerificationProcessEventListener;
import com.microblink.reactnative.blinkidverify.manager.VerificationProcessManager;
import com.microblink.reactnative.blinkidverify.manager.VerificationProcessManagerMRTD;
import com.microblink.recognizers.BaseRecognitionResult;
import com.microblink.recognizers.IResultHolder;
import com.microblink.recognizers.blinkid.mrtd.combined.MRTDCombinedRecognitionResult;
import com.microblink.recognizers.liveness.LivenessRecognitionResult;
import com.microblink.results.date.DateResult;

import java.util.HashMap;
import java.util.Map;

/**
 * React Native module for BlinkIDVerify.
 */
public class BlinkIDVerifyModule extends ReactContextBaseJavaModule {

    // promise reject message codes
    private static final String ERROR_ACTIVITY_DOES_NOT_EXIST = "ERROR_ACTIVITY_DOES_NOT_EXIST";
    private static final String ERROR_COMBINED_RECOGNIZER_NOT_DEFINED = "ERROR_COMBINED_RECOGNIZER_NOT_DEFINED";
    private static final String STATUS_SCAN_CANCELED = "STATUS_SCAN_CANCELED";

    // js keys for scanning options
    private static final String OPTION_ENABLE_BEEP_JS_KEY = "enableBeep";
    private static final String OPTION_SHOULD_RETURN_CROPPED_IMAGES_JS_KEY = "shouldReturnCroppedImages";
    private static final String OPTION_SHOULD_RETURN_FACE_IMAGES_JS_KEY = "shouldReturnFaceImages";
    private static final String COMBINED_RECOGNIZER_JS_KEY = "combinedRecognizer";

    // js keys for recognizer types
    private static final String RECOGNIZER_MRTD_COMBINED_JS_KEY = "RECOGNIZER_MRTD_COMBINED";

    // js result keys
    private static final String RESULT = "recognitionResult";
    private static final String RESULT_IMAGE_CROPPED_FRONT = "resultImageCroppedFront";
    private static final String RESULT_IMAGE_CROPPED_BACK = "resultImageCroppedBack";
    private static final String RESULT_IMAGE_CROPPED_ID_FACE = "resultImageCroppedIDFace";
    private static final String RESULT_IMAGE_CROPPED_SELFIE_FACE = "resultImageCroppedSelfieFace";
    private static final String RESULT_TYPE = "resultType";
    private static final String FIELDS = "fields";

    // result values for resultType
    private static final String MRTD_RESULT_TYPE = "MRTD result";

    // java mappings for recognizer types
    private static final int RECOGNIZER_MRTD_COMBINED = 1;

    private static final String LOG_TAG = "BlinkIDVerify";

    private Promise mScanPromise;
    private boolean mShouldReturnFaceImages;

    protected ScanningConfiguration mScanningConfiguration;

    private VerificationProcessManager mVerificationManager;

    public BlinkIDVerifyModule(ReactApplicationContext reactContext) {
        super(reactContext);

        // Add the listener for `onActivityResult`
        reactContext.addActivityEventListener(mScanActivityListener);
    }

    @Override
    public String getName() {
        return "BlinkIDVerifyAndroid";
    }

    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();
        constants.put(RECOGNIZER_MRTD_COMBINED_JS_KEY, RECOGNIZER_MRTD_COMBINED);
        return constants;
    }

    /**
     * React native method which invokes ScanCard activity with given BlinkID license key
     * and {@code scanningOptions}. It returns results as JS Promise object.
     *
     * @param licenseKeyMicroblinkSDK  Microblink license key which is bound to the application ID. To obtain
     *                        valid license key, please contact us at http://help.microblink.com
     * @param scanningOptions scanning options map with following key-value pairs:
     *                        [@link #OPTION_ENABLE_BEEP_JS_KEY} -> boolean
     *                        {@link #OPTION_SHOULD_RETURN_CROPPED_IMAGES_JS_KEY} -> boolean
     *                        {@link #COMBINED_RECOGNIZER_JS_KEY} -> int (id of combined recognizer)
     *                        [@link #OPTION_SHOULD_RETURN_FACE_IMAGES_JS_KEY} -> boolean
     * @param promise         Promise for returning scan results.
     */
    @ReactMethod
    public void scan(String licenseKeyMicroblinkSDK, ReadableMap scanningOptions, String licenseKeyLivenessRecognizer, Promise promise) {
        // Store the promise to resolve/reject when scanning is done
        mScanPromise = promise;

        final Activity currentActivity = getCurrentActivity();
        if (currentActivity == null) {
            rejectPromise(ERROR_ACTIVITY_DOES_NOT_EXIST, "Activity does not exist");
            return;
        }

        int combinedRecognizerType;
        if (scanningOptions.hasKey(COMBINED_RECOGNIZER_JS_KEY)) {
            combinedRecognizerType = scanningOptions.getInt(COMBINED_RECOGNIZER_JS_KEY);
        } else {
            rejectPromise(ERROR_COMBINED_RECOGNIZER_NOT_DEFINED, "Combined recognizer is not defined");
            return;
        }

        mScanningConfiguration = new ScanningConfiguration.Builder()
                .setLicenseKeyMicroblinkSDK(licenseKeyMicroblinkSDK)
                .setLicenseKeyLivenessRecognizer(licenseKeyLivenessRecognizer)
                .setBeepEnabled(readBooleanValue(scanningOptions, OPTION_ENABLE_BEEP_JS_KEY, true))
                .setReturningCroppedImages(readBooleanValue(scanningOptions, OPTION_SHOULD_RETURN_CROPPED_IMAGES_JS_KEY, false))
                .create();

        if (combinedRecognizerType == RECOGNIZER_MRTD_COMBINED) {
            mVerificationManager = new VerificationProcessManagerMRTD(currentActivity, mScanningConfiguration, mVerificationProcessEventListener);
        } else {
            throw new IllegalArgumentException("Illegal argument for combinedRecognizer type!");
        }

        mShouldReturnFaceImages = readBooleanValue(scanningOptions, OPTION_SHOULD_RETURN_FACE_IMAGES_JS_KEY, false);

        mVerificationManager.startVerification();
    }

    private String encodeByteArrayToBase64(byte[] bytes) {
        return Base64.encodeToString(bytes, Base64.DEFAULT);
    }

    private boolean readBooleanValue(ReadableMap optionsMap, String optionKey, boolean defaultValue) {
        if (optionsMap.hasKey(optionKey)) {
            return optionsMap.getBoolean(optionKey);
        }
        return defaultValue;
    }

    /**
     * Rejects scan promise with the given status/error code and message.
     *
     * @param code    status/error code.
     * @param message status/error message.
     */
    private void rejectPromise(String code, String message) {
        if (mScanPromise == null) {
            return;
        }
        mScanPromise.reject(code, message);
        mScanPromise = null;
    }

    /**
     * Builds MRTD result for returning to JS.
     *
     * @return map representation of the given {@code res} for returning to JS.
     */
    private WritableMap buildMRTDResult(MRTDCombinedRecognitionResult result) {
        return buildKeyValueResult(result, MRTD_RESULT_TYPE);
    }

    private WritableMap buildKeyValueResult(BaseRecognitionResult res, String resultType) {
        WritableMap fields = new WritableNativeMap();
        IResultHolder resultHolder = res.getResultHolder();
        for (String key : resultHolder.keySet()) {
            Object value = resultHolder.getObject(key);
            if (value instanceof String) {
                fields.putString(key, (String) value);
            } else if (value instanceof DateResult) {
                fields.putString(key, ((DateResult) value).getOriginalDateString());
            } else {
                Log.d(LOG_TAG, "Ignoring result key '" + key + "'");
            }
        }
        WritableMap result = new WritableNativeMap();
        result.putString(RESULT_TYPE, resultType);
        result.putMap(FIELDS, fields);
        return result;
    }

    private final VerificationProcessEventListener mVerificationProcessEventListener = new VerificationProcessEventListener() {
        @Override
        public void onVerificationCanceled() {
            rejectPromise(STATUS_SCAN_CANCELED, "Scanning has been canceled");
        }

        @Override
        public void onScanAgainRequested() {
            mVerificationManager.startVerification();
        }

        @Override
        public void onVerificationSuccess() {
            BaseRecognitionResult combinedRecognitionResult = mVerificationManager.getCombinedRecognitionResult();
            LivenessRecognitionResult livenessRecognitionResult = mVerificationManager.getLivenessRecognitionResult();

            WritableMap combinedResultMap = null;
            byte[] croppedFrontImage = null;
            byte[] croppedBackImage = null;
            byte[] croppedIDFaceImage = null;
            byte[] croppedSelfieFaceImage = livenessRecognitionResult.getEncodedFaceImage();

            if (combinedRecognitionResult instanceof MRTDCombinedRecognitionResult) {
                MRTDCombinedRecognitionResult mrtdCombined = (MRTDCombinedRecognitionResult) combinedRecognitionResult;
                combinedResultMap = buildMRTDResult(mrtdCombined);
                croppedFrontImage = mrtdCombined.getEncodedFrontFullDocumentImage();
                croppedBackImage = mrtdCombined.getEncodedBackFullDocumentImage();
                croppedIDFaceImage = mrtdCombined.getEncodedFaceImage();
            }

            WritableMap root = new WritableNativeMap();
            root.putMap(RESULT, combinedResultMap);
            if (mScanningConfiguration.isReturningCroppedImages()) {
                if (croppedFrontImage != null) {
                    root.putString(RESULT_IMAGE_CROPPED_FRONT, encodeByteArrayToBase64(croppedFrontImage));
                }
                if (croppedBackImage != null) {
                    root.putString(RESULT_IMAGE_CROPPED_BACK, encodeByteArrayToBase64(croppedBackImage));
                }
            }
            if (mShouldReturnFaceImages) {
                if (croppedIDFaceImage != null) {
                    root.putString(RESULT_IMAGE_CROPPED_ID_FACE, encodeByteArrayToBase64(croppedIDFaceImage));
                }

                if (croppedSelfieFaceImage != null) {
                    root.putString(RESULT_IMAGE_CROPPED_SELFIE_FACE, encodeByteArrayToBase64(croppedSelfieFaceImage));
                }
            }
            mScanPromise.resolve(root);
        }
    };

    private final ActivityEventListener mScanActivityListener = new BaseActivityEventListener() {
        @Override
        public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
            mVerificationManager.onActivityResult(requestCode, resultCode, data);
        }
    };
}
