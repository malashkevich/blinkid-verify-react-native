package com.microblink.reactnative.blinkidverify.result.verification;

import android.support.annotation.NonNull;
import android.util.Base64;

import com.microblink.recognizers.BaseRecognitionResult;
import com.microblink.recognizers.IResultHolder;
import com.microblink.recognizers.blinkid.CombinedRecognitionResult;
import com.microblink.recognizers.blinkid.mrtd.combined.MRTDCombinedRecognizerSettings;
import com.microblink.recognizers.liveness.LivenessRecognitionResult;
import com.microblink.results.date.Date;
import com.microblink.results.date.DateResult;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Locale;

/**
 * JSON builder for recognition results that serializes results in JSON format acceptable
 * by the verification service.
 */
public class RecognitionResultJSONBuilder implements IRecognitionResultJSONBuilder {

    /**
     * Full document front side image names that does not contain {@link #IMAGE_NAME_FRONT_SUBSTRING} substring.
     */
    private static final String[] FRONT_FULL_DOCUMENT_IMAGE_NAMES_SPECIAL = {
            MRTDCombinedRecognizerSettings.FULL_DOCUMENT_IMAGE_FRONT
    };

    /**
     * Full document back side image names that does not contain {@link #IMAGE_NAME_BACK_SUBSTRING} substring.
     */
    private static final String[] BACK_FULL_DOCUMENT_IMAGE_NAMES_SPECIAL = {
            MRTDCombinedRecognizerSettings.FULL_DOCUMENT_IMAGE_BACK,
    };

    // substrings from encoded image names
    private static final String ENCODED_IMAGE_NAME_SUFFIX = ".image";
    private static final String IMAGE_NAME_FRONT_SUBSTRING = "front";
    private static final String IMAGE_NAME_BACK_SUBSTRING = "back";
    private static final String IMAGE_NAME_FACE_SUBSTRING = "face";

    // json keys constants
    private static final String KEY_TYPE = "type";
    private static final String KEY_DATE_DAY = "day";
    private static final String KEY_DATE_MONTH = "month";
    private static final String KEY_DATE_YEAR = "year";
    private static final String KEY_DATE_ORIGINAL_STRING = "originalString";
    private static final String KEY_BASE64_DATA = "base64Data";
    private static final String KEY_IMAGE_FACE = "Face.Image";
    private static final String KEY_IMAGE_FULL_FRONT = "FrontFullDocument.Image";
    private static final String KEY_IMAGE_FULL_BACK = "BackFullDocument.Image";
    private static final String KEY_SIGNATURE = "signature";
    private static final String KEY_VERSION = "version";

    // json predefined values
    private static final String VALUE_TYPE_DATE = "date";
    private static final String VALUE_TYPE_BYTES = "bytes";
    private static final String VALUE_VERSION = "v3";

    @Override
    @NonNull
    public JSONObject buildJsonFromCombinedRecognitionResult(@NonNull CombinedRecognitionResult recognitionResult) {
        // all recognition results extend BaseRecognitionResult
        return buildJsonFromRecognitionResult((BaseRecognitionResult)recognitionResult, true);
    }


    @NonNull
    @Override
    public JSONObject buildJsonFromLivenessRecognitionResult(@NonNull LivenessRecognitionResult livenessRecognitionResult) {
        return buildJsonFromRecognitionResult(livenessRecognitionResult, false);
    }

    private JSONObject buildJsonFromRecognitionResult(@NonNull BaseRecognitionResult recognitionResult, boolean usePredefinedImageNames) {

        IResultHolder resultHolder = recognitionResult.getResultHolder();
        JSONObject resultJson = new JSONObject();
        boolean hasSignature = false;
        try {
            for (String key : resultHolder.keySet()) {
                Object value = resultHolder.getObject(key);
                if (value instanceof DateResult) {
                    JSONObject dateObject = new JSONObject();
                    dateObject.put(KEY_TYPE, VALUE_TYPE_DATE);
                    Date date = ((DateResult) value).getDate();
                    if (date == null) {
                        dateObject.put(KEY_DATE_DAY, JSONObject.NULL);
                        dateObject.put(KEY_DATE_MONTH, JSONObject.NULL);
                        dateObject.put(KEY_DATE_YEAR, JSONObject.NULL);
                    } else {
                        dateObject.put(KEY_DATE_DAY, date.getDay());
                        dateObject.put(KEY_DATE_MONTH, date.getMonth());
                        dateObject.put(KEY_DATE_YEAR, date.getYear());
                    }
                    dateObject.put(KEY_DATE_ORIGINAL_STRING, ((DateResult) value).getOriginalDateString());

                    resultJson.put(key, dateObject);
                } else if (value instanceof byte[]) {
                    boolean imageInserted = false;
                    if (usePredefinedImageNames) {
                        String imageKey = findPredefinedImageKey(key);
                        if (imageKey != null) {
                            resultJson.put(imageKey, createByteArrayDataJSONObject((byte[]) value));
                            imageInserted = true;
                        }
                    }
                    if (!imageInserted) {
                        resultJson.put(key, createByteArrayDataJSONObject((byte[]) value));
                        if (key.equals(KEY_SIGNATURE)) {
                            hasSignature = true;
                        }
                    }
                } else if (value == null) {
                    resultJson.put(key, JSONObject.NULL);
                } else {
                    resultJson.put(key, value);
                }
            }
            // signature field must be present even when signature is not checked
            if (!hasSignature) {
                resultJson.put(KEY_SIGNATURE, createByteArrayDataJSONObject(new byte[]{0}));
            }
            if (!resultJson.has(KEY_VERSION)) {
                resultJson.put(KEY_VERSION, VALUE_VERSION);
            }
        } catch (JSONException ex) {
            throw new RuntimeException("Failed building of JSON for recognition result");
        }

        return resultJson;
    }

    /**
     * Returns appropriate predefined image name for the given json key or {@code null} if predefined
     * image name for given key does not exist.
     * @param key json key for this recognition result entry which should be replaced with returned
     *            value if this key is image name.
     * @return json key that should be used as image name, which is acceptable by the verification service.
     */
    private String findPredefinedImageKey(String key) {
        String keyLowercase = key.toLowerCase(Locale.US);
        if (keyLowercase.contains(ENCODED_IMAGE_NAME_SUFFIX)) {
            if (keyLowercase.contains(IMAGE_NAME_FACE_SUBSTRING)) {
                return KEY_IMAGE_FACE;
            }
            if (keyLowercase.contains(IMAGE_NAME_FRONT_SUBSTRING)) {
                return KEY_IMAGE_FULL_FRONT;
            }
            if (keyLowercase.contains(IMAGE_NAME_BACK_SUBSTRING)) {
                return KEY_IMAGE_FULL_BACK;
            }
            for (String fullFrontSpecial : FRONT_FULL_DOCUMENT_IMAGE_NAMES_SPECIAL) {
                if (key.contains(fullFrontSpecial)) {
                    return KEY_IMAGE_FULL_FRONT;
                }
            }
            for (String fullBackSpecial : BACK_FULL_DOCUMENT_IMAGE_NAMES_SPECIAL) {
                if (key.contains(fullBackSpecial)) {
                    return KEY_IMAGE_FULL_BACK;
                }
            }
        }
        return null;
    }

    /**
     * Creates base64 encoded byte array JSON value that is acceptable by the verification service.
     * @param value byte array that should be encoded in base64 format.
     * @return base64 encoded byte array JSON value that is acceptable by the verification service.
     * @throws JSONException
     */
    private JSONObject createByteArrayDataJSONObject(byte[] value) throws JSONException {
        JSONObject bytesObject = new JSONObject();
        bytesObject.put(KEY_TYPE, VALUE_TYPE_BYTES);
        bytesObject.put(KEY_BASE64_DATA, Base64.encodeToString(value, Base64.DEFAULT | Base64.NO_WRAP));
        return bytesObject;
    }
}
