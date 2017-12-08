package com.microblink.reactnative.blinkidverify.manager;

import android.app.Activity;
import android.content.Context;
import android.support.annotation.NonNull;

import com.microblink.reactnative.blinkidverify.result.extract.MRTDCombinedResultExtractor;
import com.microblink.reactnative.blinkidverify.result.extract.ResultExtractor;
import com.microblink.recognizers.blinkid.CombinedRecognizerSettings;
import com.microblink.recognizers.blinkid.mrtd.combined.MRTDCombinedRecognizerSettings;

/**
 * Manager for documents that have face image and MRZ (Machine Readable Zone).
 */
public class VerificationProcessManagerMRTD extends VerificationProcessManager {


    public VerificationProcessManagerMRTD(@NonNull Activity hostActivity, @NonNull ScanningConfiguration scanningConfiguration, @NonNull VerificationProcessEventListener listener) {
        super(hostActivity, scanningConfiguration, listener);
    }

    @Override
    protected CombinedRecognizerSettings createCombinedRecognizerSettings() {
        MRTDCombinedRecognizerSettings mrtdCombined = new MRTDCombinedRecognizerSettings();
        // encoding of the face image must be enabled, if it is not enabled application will crash
        // during verification process
        mrtdCombined.setEncodeFaceImage(true);
        // encode full document images
        mrtdCombined.setEncodeFullDocumentImag(true);
        // if you need MRZ image, also enable encoding of
        // that image and add code which uses it later
//        mrtdCombined.setEncodeMRZImage(true);

        return mrtdCombined;
    }

    @Override
    protected ResultExtractor createResultExtractor(Context context) {
        return new MRTDCombinedResultExtractor(context);
    }

    @Override
    protected String getDocumentLanguageCode() {
        return null;
    }

}
