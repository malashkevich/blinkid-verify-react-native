package com.microblink.reactnative.blinkidverify.result.extract;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;

import com.microblink.reactnative.blinkidverify.R;
import com.microblink.blinkidverify.result.entries.ResultEntry;
import com.microblink.blinkidverify.result.entries.StringResultEntry;
import com.microblink.reactnative.blinkidverify.result.extract.utils.DateFormatter;
import com.microblink.recognizers.BaseRecognitionResult;
import com.microblink.recognizers.blinkid.mrtd.combined.MRTDCombinedRecognitionResult;

import java.util.ArrayList;
import java.util.List;

/**
 * Extracts and creates result entries from {@link com.microblink.recognizers.blinkid.mrtd.combined.MRTDCombinedRecognitionResult}
 *
 */
public class MRTDCombinedResultExtractor implements ResultExtractor {

    private Context mContext;

    public MRTDCombinedResultExtractor(@NonNull Context context) {
        mContext = context;
    }

    @Override
    public List<ResultEntry> extractResultEntries(BaseRecognitionResult result) throws ResultExtractException {

        MRTDCombinedRecognitionResult mrtdCombined = getConcreteResultType(result);
        if (!mrtdCombined.isDocumentDataMatch()) {
            throw new ResultExtractException("Front and back side don't match!");
        }
        List<ResultEntry> extractedResults = new ArrayList<>();
        // for every result entry, set tag which is equal to appropriate scan result constant

        extractedResults.add(createStringResultEntry(R.string.field_first_name, mrtdCombined.getSecondaryId()));
        extractedResults.add(createStringResultEntry(R.string.field_last_name, mrtdCombined.getPrimaryId()));
        String documentNumber = mrtdCombined.getDocumentNumber();
        if (documentNumber != null && !documentNumber.isEmpty()) {
            extractedResults.add(createStringResultEntry(R.string.field_document_number, documentNumber));
        }
        extractedResults.add(createStringResultEntry(R.string.field_document_code, mrtdCombined.getDocumentCode()));
        extractedResults.add(createStringResultEntry(R.string.field_birth_date, DateFormatter.formatCroDate(mrtdCombined.getDateOfBirth())));
        extractedResults.add(createStringResultEntry(R.string.field_sex, mrtdCombined.getSex()));
        extractedResults.add(createStringResultEntry(R.string.field_nationality, mrtdCombined.getNationality()));
        extractedResults.add(createStringResultEntry(R.string.field_issuer, mrtdCombined.getIssuer()));
        extractedResults.add(createStringResultEntry(R.string.field_expiry_date, DateFormatter.formatCroDate(mrtdCombined.getDateOfExpiry())));
        String opt1 = mrtdCombined.getOpt1();
        if (opt1 != null && !opt1.isEmpty()) {
            extractedResults.add(createStringResultEntry(R.string.field_opt1, opt1));
        }
        String opt2 = mrtdCombined.getOpt2();
        if (opt2 != null && !opt2.isEmpty()) {
            extractedResults.add(createStringResultEntry(R.string.field_opt2, opt2));
        }

        return extractedResults;

    }

    private MRTDCombinedRecognitionResult getConcreteResultType(BaseRecognitionResult recognitionResult) {
        if (!(recognitionResult instanceof MRTDCombinedRecognitionResult)) {
            throw new IllegalStateException("MRTD combined result is expected");
        } else {
            return (MRTDCombinedRecognitionResult) recognitionResult;
        }
    }

    @Nullable
    @Override
    public Bitmap extractFaceBitmap(BaseRecognitionResult result) {
        MRTDCombinedRecognitionResult mrtdCombined = getConcreteResultType(result);
        // to obtain face image, encoding of face images must be enabled in the recognizer settings
        // for the recognizer that has produced this result

        // encoded face image is in JPEG format
        byte[] faceJpeg = mrtdCombined.getEncodedFaceImage();
        if (faceJpeg != null) {
            Bitmap faceBitmap = BitmapFactory.decodeByteArray(faceJpeg, 0, faceJpeg.length);
            return faceBitmap;
        }
        return null;
    }

    /**
     * Creates string result entry which is not editable.
     * @param keyResID Resource ID of the entry name that will be shown to the user in the result list.
     * @param value Entry value.
     * @return string result entry which is not editable.
     */
    private ResultEntry createStringResultEntry(@StringRes int keyResID, String value) {
        String key = mContext.getString(keyResID);
        return new StringResultEntry(key, value);
    }

}
