package com.microblink.reactnative.blinkidverify.result.verification;

import android.support.annotation.NonNull;

import com.microblink.recognizers.blinkid.CombinedRecognitionResult;
import com.microblink.recognizers.liveness.LivenessRecognitionResult;

import org.json.JSONObject;

/**
 * Interface for recognition result JSON builders.
 */
public interface IRecognitionResultJSONBuilder {

    /**
     * Builds JSON representation of the given combined recognition result.
     * @param combinedRecognitionResult combined recognition result that will be serialized to JSON.
     * @return JSON representation of the given combined recognition result.
     */
    @NonNull
    JSONObject buildJsonFromCombinedRecognitionResult(@NonNull CombinedRecognitionResult combinedRecognitionResult);

    /**
     * Builds JSON representation of the given liveness recognition result.
     * @param livenessRecognitionResult liveness recognition result that will be serialized to JSON.
     * @return JSON representation of the given liveness recognition result.
     */
    @NonNull
    JSONObject buildJsonFromLivenessRecognitionResult(@NonNull LivenessRecognitionResult livenessRecognitionResult);

}
