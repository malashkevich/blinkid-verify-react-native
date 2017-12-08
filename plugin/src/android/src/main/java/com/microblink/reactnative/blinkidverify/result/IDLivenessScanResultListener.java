package com.microblink.reactnative.blinkidverify.result;

import android.os.Parcel;
import android.support.annotation.Nullable;

import com.microblink.recognizers.BaseRecognitionResult;
import com.microblink.recognizers.RecognitionResults;
import com.microblink.recognizers.blinkid.CombinedRecognitionResult;
import com.microblink.recognizers.liveness.LivenessRecognitionResult;
import com.microblink.view.recognition.ParcelableScanResultListener;
import com.microblink.view.recognition.RecognitionType;

/**
 * Scan results listener that stores the recognition results to the {@link CombinedIDLivenessResultsHolder}.
 * When this listener is passed to {@link com.microblink.activity.LivenessVerificationFlowActivity},
 * activity will not return results through activity result intent when scanning is done. This is desired
 * behaviour because results will have encoded images which causes that their sizes are too large to be
 * passed through the Android intent (Android intent size limitations).
 */
public class IDLivenessScanResultListener implements ParcelableScanResultListener {

    @Override
    public void onScanningDone(@Nullable RecognitionResults results) {
        BaseRecognitionResult[] resultArray = results.getRecognitionResults();
        if (results.getRecognitionType() != RecognitionType.SUCCESSFUL || resultArray.length != 1) {
            return;
        }
        BaseRecognitionResult result = resultArray[0];
        if (result instanceof CombinedRecognitionResult) {
            CombinedIDLivenessResultsHolder.getInstance().setCombinedIDRecognitionResult((CombinedRecognitionResult)result);
        } else if (result instanceof LivenessRecognitionResult) {
            CombinedIDLivenessResultsHolder.getInstance().setLivenessRecognitionResult((LivenessRecognitionResult) result);
        }
    }

    public IDLivenessScanResultListener() {
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
    }

    protected IDLivenessScanResultListener(Parcel in) {
    }

    public static final Creator<IDLivenessScanResultListener> CREATOR = new Creator<IDLivenessScanResultListener>() {
        @Override
        public IDLivenessScanResultListener createFromParcel(Parcel source) {
            return new IDLivenessScanResultListener(source);
        }

        @Override
        public IDLivenessScanResultListener[] newArray(int size) {
            return new IDLivenessScanResultListener[size];
        }
    };
}
