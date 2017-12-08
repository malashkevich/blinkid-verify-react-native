package com.microblink.reactnative.blinkidverify.result;

import com.microblink.recognizers.blinkid.CombinedRecognitionResult;
import com.microblink.recognizers.liveness.LivenessRecognitionResult;

/**
 * Singleton that is holder for the scan results. Scan results contain encoded images and cannot
 * be passed through intent extras because of the android limitations on the intent size. Because
 * of that, this singleton should be used for storing the results of the scan activity.
 */
public class CombinedIDLivenessResultsHolder {

    private LivenessRecognitionResult mLivenessRecognitionResult;
    private CombinedRecognitionResult mCombinedIDRecognitionResult;

    private static CombinedIDLivenessResultsHolder ourInstance = new CombinedIDLivenessResultsHolder();

    public static CombinedIDLivenessResultsHolder getInstance() {
        return ourInstance;
    }

    private CombinedIDLivenessResultsHolder() {
    }

    /**
     * Sets the id combined recognition result.
     * @param combinedIDRecognitionResult id combined recognition result to be stored.
     */
    public void setCombinedIDRecognitionResult(CombinedRecognitionResult combinedIDRecognitionResult) {
        mCombinedIDRecognitionResult = combinedIDRecognitionResult;
    }

    /**
     * Returns last id combined recognition result.
     * @return last id combined recognition result.
     */
    public CombinedRecognitionResult getCombinedIDRecognitionResult() {
        return mCombinedIDRecognitionResult;
    }

    /**
     * Sets the liveness recognition result.
     * @param livenessRecognitionResult liveness recognition result to be stored.
     */
    public void setLivenessRecognitionResult(LivenessRecognitionResult livenessRecognitionResult) {
        mLivenessRecognitionResult = livenessRecognitionResult;
    }

    /**
     * Returns last liveness recognition result.
     * @return last liveness recognition result.
     */
    public LivenessRecognitionResult getLivenessRecognitionResult() {
        return mLivenessRecognitionResult;
    }

    /**
     * Clears all stored results.
     */
    public void clearResults() {
        mLivenessRecognitionResult = null;
        mCombinedIDRecognitionResult = null;
    }
}
