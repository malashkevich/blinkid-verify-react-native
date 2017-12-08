package com.microblink.reactnative.blinkidverify.result.verification;

import android.support.annotation.NonNull;

import com.microblink.reactnative.blinkidverify.config.ConfigVerificationService;
import com.microblink.recognizers.blinkid.CombinedRecognitionResult;
import com.microblink.recognizers.liveness.LivenessRecognitionResult;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;

/**
 * Builder for verification service request body JSON.
 */
public class VerificationServiceJSONBuilder {

    private static final String KEY_TYPE = "type";

    private static final String VALUE_TYPE_ORIGINAL_DATA = "demo";
    private static final String VALUE_TYPE_LIVENESS = "liveness";

    private IRecognitionResultJSONBuilder mRecognitionResultJSONBuilder;

    public VerificationServiceJSONBuilder(@NonNull IRecognitionResultJSONBuilder recognitionResultJSONBuilder) {
        mRecognitionResultJSONBuilder = recognitionResultJSONBuilder;
    }

    public JSONObject buildVerificationServiceJSONRequestBody(
            CombinedRecognitionResult combinedRecognitionResult,
            LivenessRecognitionResult livenessRecognitionResult,
            Map<String, String> editedData,
            Map<String, String> insertedData) {
        JSONObject verificationJSON = new JSONObject();
        try {
            if (combinedRecognitionResult != null) {
                JSONObject documentJSON = mRecognitionResultJSONBuilder.buildJsonFromCombinedRecognitionResult(combinedRecognitionResult);
                documentJSON.put(KEY_TYPE, VALUE_TYPE_ORIGINAL_DATA);
                verificationJSON.put(ConfigVerificationService.JSON_KEY_ID_DATA, documentJSON);
            }
            if (livenessRecognitionResult != null) {
                JSONObject livenessJSON = mRecognitionResultJSONBuilder.buildJsonFromLivenessRecognitionResult(livenessRecognitionResult);
                livenessJSON.put(KEY_TYPE, VALUE_TYPE_LIVENESS);
                verificationJSON.put(ConfigVerificationService.JSON_KEY_LIVENESS_DATA, livenessJSON);
            }

            JSONObject editedDataJSON;
            if (editedData != null) {
                editedDataJSON = new JSONObject(editedData);
            } else {
                editedDataJSON = new JSONObject();
            }
            verificationJSON.put(ConfigVerificationService.JSON_KEY_EDITED_DATA, editedDataJSON);

            JSONObject insertedDataJSON;
            if (insertedData != null) {
                insertedDataJSON = new JSONObject(insertedData);
            } else {
                insertedDataJSON = new JSONObject();
            }
            verificationJSON.put(ConfigVerificationService.JSON_KEY_INSERTED_DATA, insertedDataJSON);
        } catch (JSONException ex) {
            // this should not happen
            ex.printStackTrace();
        }

        return verificationJSON;
    }

}
