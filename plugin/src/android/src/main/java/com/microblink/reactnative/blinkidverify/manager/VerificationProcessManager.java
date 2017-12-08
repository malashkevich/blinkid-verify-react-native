package com.microblink.reactnative.blinkidverify.manager;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Parcelable;
import android.support.annotation.NonNull;

import com.microblink.activity.LivenessVerificationFlowActivity;
import com.microblink.blinkidverify.activity.EditResultActivity;
import com.microblink.blinkidverify.result.edit.IEditableString;
import com.microblink.blinkidverify.result.entries.EditableStringResultEntry;
import com.microblink.blinkidverify.result.entries.InsertableStringResultEntry;
import com.microblink.blinkidverify.result.entries.ResultEntry;
import com.microblink.blinkidverify.result.image.ImageHolder;
import com.microblink.reactnative.blinkidverify.R;
import com.microblink.reactnative.blinkidverify.activity.VerifyResultActivity;
import com.microblink.reactnative.blinkidverify.result.CombinedIDLivenessResultsHolder;
import com.microblink.reactnative.blinkidverify.result.IDLivenessScanResultListener;
import com.microblink.reactnative.blinkidverify.result.extract.ResultExtractException;
import com.microblink.reactnative.blinkidverify.result.extract.ResultExtractor;
import com.microblink.recognizers.BaseRecognitionResult;
import com.microblink.recognizers.blinkid.CombinedRecognizerSettings;
import com.microblink.recognizers.liveness.LivenessRecognitionResult;
import com.microblink.recognizers.liveness.LivenessRecognizerSettings;
import com.microblink.util.Log;

import java.util.HashMap;
import java.util.List;

/**
 * Abstract verification process manager that is responsible for controlling the verification steps.
 * It uses intermediate results, prepares scanned data and launches appropriate activities. For each
 * supported document type, concrete manager should be implemented by subclassing this abstract class.
 *
 * Verification steps are following:<br>
 *     <ol>
 *         <li>Scanning all parts/sides of the document (scanning with camera)</li>
 *         <li>Document data confirmation (and editing)</li>
 *         <li>Liveness check on the user (scanning with camera)</li>
 *         <li>Final result and face matching</li>
 *     </ol>
 */
public abstract class VerificationProcessManager {

    private static final int REQ_CODE_DOCUMENT_SCAN = 1;
    private static final int REQ_CODE_LIVENESS = 2;
    private static final int REQ_CODE_RESULT_EDITING = 3;
    private static final int REQ_CODE_FINAL_RESULT = 4;

    /** Key for the face Bitmap that is scanned from the document. */
    private static final String DOCUMENT_FACE_IMAGE_NAME = "IDDocumentFaceImage";
    /** Key for the selfie face Bitmap that is obtained during liveness check. */
    private static final String SELFIE_FACE_IMAGE_NAME = "SelfieFaceImage";

    /** Result entries after the user has confirmed scanned document data (and maybe edited data). */
    private ResultEntry[] mEditedResultEntries;

    /** Activity which uses this manager for launching the verification process. */
    private Activity mHostActivity;
    /** Listener for verification events. */
    private VerificationProcessEventListener mVerificationEventListener;

    /** Result extractor for concrete type of the recognition result. */
    private ResultExtractor mResultExtractor;

    private BaseRecognitionResult mCombinedRecognitionResult;
    private LivenessRecognitionResult mLivenessRecognitionResult;

    private ScanningConfiguration mScanningConfiguration;

    /**
     *
     * @param hostActivity activity which uses this manager for launching the verification process.
     * @param listener listener for verification events.
     */
    public VerificationProcessManager(@NonNull Activity hostActivity, @NonNull ScanningConfiguration scanningConfiguration, @NonNull VerificationProcessEventListener listener) {
        mHostActivity = hostActivity;
        mScanningConfiguration = scanningConfiguration;
        mVerificationEventListener = listener;
        mResultExtractor = createResultExtractor(hostActivity);
    }

    /**
     * Starts the verification process. Given scan activity will be used.
     */
    public void startVerification() {
        // clear all previous scan results if they exist
        CombinedIDLivenessResultsHolder.getInstance().clearResults();
        mCombinedRecognitionResult = null;
        mLivenessRecognitionResult = null;
        ImageHolder.getInstance().clearImages();

        Intent intent = createCommonVerificationFlowIntent();
        intent.putExtra(LivenessVerificationFlowActivity.EXTRAS_COMBINED_RECOGNIZER_SETTINGS, createCombinedRecognizerSettings());

        // customise "dont't match" dialog title, message and button text
        // this dialog is shown when document sides don't match
//        intent.putExtra(LivenessVerificationFlowActivity.EXTRAS_WARNING_DIALOG_NOT_MATCH_TITLE_RES, R.string.dialog_not_match_title);
//        intent.putExtra(LivenessVerificationFlowActivity.EXTRAS_WARNING_DIALOG_NOT_MATCH_MESSAGE_RES, R.string.dialog_not_match_message);
//        intent.putExtra(LivenessVerificationFlowActivity.EXTRAS_WARNING_DIALOG_NOT_MATCH_BUTTON_TEXT_RES, R.string.dialog_not_match_button_text);

        mHostActivity.startActivityForResult(intent, REQ_CODE_DOCUMENT_SCAN);
    }

    /**
     * All host activity onActivityResult calls must be passed to this manager.
     * @param requestCode should be the same as requestCode from the host activity onActivityResult
     * @param resultCode should be the same as resultCode from the host activity onActivityResult
     * @param data should be the same as data from the host activity onActivityResult
     */
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        switch (requestCode) {
            case REQ_CODE_DOCUMENT_SCAN:
                handleDocumentScanResult(resultCode, data);
                break;
            case REQ_CODE_RESULT_EDITING:
                handleResultEditingResult(resultCode, data);
                break;
            case REQ_CODE_LIVENESS:
                handleLivenessResult(resultCode, data);
                break;
            case REQ_CODE_FINAL_RESULT:
                handleFinalResult(resultCode, data);
                break;
        }
    }

    /**
     * Should be used when results from scanning front and back side of the document are available.
     */
    private void handleDocumentScanResult(int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK) {
            // combined recognition result must be stored in CombinedIDLivenessResultsHolder
            mCombinedRecognitionResult = (BaseRecognitionResult)CombinedIDLivenessResultsHolder.getInstance().getCombinedIDRecognitionResult();
            if (mCombinedRecognitionResult != null) {
                Bitmap faceBitmap = mResultExtractor.extractFaceBitmap(mCombinedRecognitionResult);
                if (faceBitmap != null) {
                    // images can not be passed through intent extras because of intent size limitations
                    // -> ImageHolder singleton is used for passing images
                    ImageHolder.getInstance().addBitmap(faceBitmap, DOCUMENT_FACE_IMAGE_NAME);
                    showDocumentScanResultsForEditing(mCombinedRecognitionResult);
                } else {
                    // this should not happen
                    Log.e(this, "CombinedRecognitionResult does not contain valid encoded face image.");
                    throw new IllegalStateException("CombinedRecognitionResult does not contain valid encoded face image," +
                            "please check that you have enabled encoding of face images in the combined" +
                            "recognizer settings");
                }
            } else {
                // this should not happen
                Log.e(this, "CombinedRecognitionResult does not exist, but scan activity result was OK");
                // TODO show message to the user to scan again
            }
        } else {
            // canceled by user
            mVerificationEventListener.onVerificationCanceled();
        }
    }

    private void handleResultEditingResult(int resultCode, Intent data) {
        if (resultCode == EditResultActivity.RESULT_OK) {
            Parcelable[] resultsParc = data.getParcelableArrayExtra(EditResultActivity.RESULT_EXTRAS_RESULT_ENTRIES);
            if (resultsParc != null) {
                mEditedResultEntries = new ResultEntry[resultsParc.length];
                for (int i = 0; i < mEditedResultEntries.length; i++) {
                    mEditedResultEntries[i] = (ResultEntry) resultsParc[i];
                }
                startLivenessStep();
            } else {
                // this should not happen
                // TODO show message to the user to scan again
                Log.e(this, "ResultArray not set, but EditResultActivity result was OK");
            }
        } else if (resultCode == EditResultActivity.RESULT_SCAN_AGAIN) {
            mVerificationEventListener.onScanAgainRequested();
        } else {
            // canceled by user
            mVerificationEventListener.onVerificationCanceled();
        }
    }

    private void handleLivenessResult(int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK) {
            mLivenessRecognitionResult = CombinedIDLivenessResultsHolder.getInstance().getLivenessRecognitionResult();
            if (mLivenessRecognitionResult != null) {
                boolean hasFaceBitmap = false;
                // face image is in JPEG format
                byte[] faceJpeg = mLivenessRecognitionResult.getEncodedFaceImage();
                if (faceJpeg != null) {
                    Bitmap faceBitmap = BitmapFactory.decodeByteArray(faceJpeg, 0, faceJpeg.length);
                    if (faceBitmap != null) {
                        // images can not be passed through intent extras because of intent size limitations
                        // -> ImageHolder singleton is used for passing images
                        ImageHolder.getInstance().addBitmap(faceBitmap, SELFIE_FACE_IMAGE_NAME);
                        hasFaceBitmap = true;
                    }
                }
                if (!hasFaceBitmap) {
                    Log.w(this, "LivenessRecognitionResult does not contain valid encoded face image");
                }
                // show results and perform face images matching
                showFinalResultAndPerformVerification(mLivenessRecognitionResult.isAlive());
            } else {
                // this should not happen
                Log.e(this, "LivenessRecognitionResult does not exist, but scan activity result was OK");
                // TODO show message to the user to scan again
            }
        } else {
            // canceled by user or because of timeout
            mVerificationEventListener.onVerificationCanceled();
        }
    }

    private void handleFinalResult(int resultCode, Intent data) {
        if (resultCode == VerifyResultActivity.RESULT_OK) {
            mVerificationEventListener.onVerificationSuccess();
        } else if (resultCode == VerifyResultActivity.RESULT_REPEAT_LIVENESS) {
            startLivenessStep();
            // clear previous liveness result
            CombinedIDLivenessResultsHolder.getInstance().setLivenessRecognitionResult(null);
        } else {
            mVerificationEventListener.onVerificationCanceled();
        }
    }

    private void showDocumentScanResultsForEditing(BaseRecognitionResult result) {
        List<ResultEntry> extractedResultEntries;
        try {
            extractedResultEntries = mResultExtractor.extractResultEntries(result);
        } catch (ResultExtractException e) {
            e.printStackTrace();
            // this should not happen (both side does not match) because both side match is checked
            // during scan process
            Log.e(this, "Both sides don't match after scanning is done");
            mVerificationEventListener.onVerificationCanceled();
            return;
        }

        // ***** prepare result entries
        ResultEntry[] resultEntryArray = new ResultEntry[extractedResultEntries.size()];
        extractedResultEntries.toArray(resultEntryArray);

        Intent intent = new Intent(mHostActivity, EditResultActivity.class);
        intent.putExtra(EditResultActivity.EXTRAS_EDITING_ENABLED, true);
        intent.putExtra(EditResultActivity.EXTRAS_RESULT_ENTRIES, resultEntryArray);
        intent.putExtra(EditResultActivity.EXTRAS_LANGUAGE_CODE, getDocumentLanguageCode());
        // activity title when activity is  not in editing mode
        intent.putExtra(EditResultActivity.EXTRAS_EDITING_OFF_ACTIVITY_TITLE_STRING_RESOURCE_ID, R.string.activity_title_confirm_data_step);
        // activity title when activity is in editing mode
        intent.putExtra(EditResultActivity.EXTRAS_EDITING_ON_ACTIVITY_TITLE_STRING_RESOURCE_ID, R.string.activity_title_edit_data_step);

        mHostActivity.startActivityForResult(intent, REQ_CODE_RESULT_EDITING);
    }

    private void startLivenessStep() {
        Intent intent = createCommonVerificationFlowIntent();
        intent.putExtra(LivenessVerificationFlowActivity.EXTRAS_LIVENESS_RECOGNIZER_SETTINGS, createLivenessRecognizerSettings());
        mHostActivity.startActivityForResult(intent, REQ_CODE_LIVENESS);
    }

    private void showFinalResultAndPerformVerification(boolean livenessCheckPassed) {
        // map of edited entries: key -> edited entry tag; value -> edited entry value
        HashMap<String, String> editedData = new HashMap<>();
        // map of inserted entries: key -> edited entry tag; value -> edited entry value
        HashMap<String, String> insertedData = new HashMap<>();
        if (mEditedResultEntries == null) {
            throw new IllegalStateException("Edited result entries must not be null when final verification should be performed.");
        }
        for (ResultEntry entry : mEditedResultEntries) {
            String recognitionResultKey = entry.getTag();
            if (recognitionResultKey == null) {
                continue;
            }
            if (entry instanceof EditableStringResultEntry && recognitionResultKey != null) {
                IEditableString editableString = ((EditableStringResultEntry) entry).getEditableString();
                if (editableString.isEdited()) {
                    editedData.put(recognitionResultKey, editableString.getCurrentString());
                }
            } else if (entry instanceof InsertableStringResultEntry && recognitionResultKey != null) {
                InsertableStringResultEntry insertableEntry = (InsertableStringResultEntry) entry;
                if (insertableEntry.isValid()) {
                    insertedData.put(recognitionResultKey, insertableEntry.getValue());
                }
            }
        }
        // TODO you can do something with edited and inserted entries if this information is needed

        Intent intent = new Intent(mHostActivity, VerifyResultActivity.class);
        intent.putExtra(VerifyResultActivity.EXTRAS_RESULT_ENTRIES, mEditedResultEntries);
        intent.putExtra(VerifyResultActivity.EXTRAS_EDITED_DATA_HASH_MAP, editedData);
        intent.putExtra(VerifyResultActivity.EXTRAS_INSERTED_DATA_HASH_MAP, insertedData);
        intent.putExtra(VerifyResultActivity.EXTRAS_ID_FACE_BITMAP_NAME, DOCUMENT_FACE_IMAGE_NAME);
        intent.putExtra(VerifyResultActivity.EXTRAS_SELFIE_FACE_BITMAP_NAME, SELFIE_FACE_IMAGE_NAME);
        intent.putExtra(VerifyResultActivity.EXTRAS_LIVENESS_CHECK_PASSED, livenessCheckPassed);
        intent.putExtra(VerifyResultActivity.EXTRAS_ACTIVITY_TITLE_STRING_RESOURCE_ID, R.string.activity_title_confirm_data_step);

        mHostActivity.startActivityForResult(intent, REQ_CODE_FINAL_RESULT);
    }

    /**
     * Creates verification flow activity intent with common extras for document scan step and
     * liveness verification step.
     * @return verification flow activity intent with common extras for document scan step and
     * liveness verification step..
     */
    private Intent createCommonVerificationFlowIntent() {
        Intent intent = new Intent(mHostActivity, LivenessVerificationFlowActivity.class);
        intent.putExtra(LivenessVerificationFlowActivity.EXTRAS_LICENSE_KEY, mScanningConfiguration.getLicenseKeyMicroblinkSDK());
        if (mScanningConfiguration.isBeepEnabled()) {
            intent.putExtra(LivenessVerificationFlowActivity.EXTRAS_BEEP_RESOURCE, R.raw.beep);
        }
        intent.putExtra(LivenessVerificationFlowActivity.EXTRAS_SCAN_RESULT_LISTENER, new IDLivenessScanResultListener());
        return intent;
    }

    private LivenessRecognizerSettings createLivenessRecognizerSettings() {
        LivenessRecognizerSettings livenessSett = new LivenessRecognizerSettings();
        livenessSett.setLicenseKey(
                mHostActivity,
                mScanningConfiguration.getLicenseKeyLivenessRecognizer()
        );
        livenessSett.setEncodeFaceImage(true);
        return livenessSett;
    }

    public BaseRecognitionResult getCombinedRecognitionResult() {
        return mCombinedRecognitionResult;
    }

    public LivenessRecognitionResult getLivenessRecognitionResult() {
        return mLivenessRecognitionResult;
    }

    /**
     * Creates settings for the recognizer that is used in document scanning step. Encoding of the
     * face image must be enabled in the created settings.
     * @return settings for the recognizer for chosen document type.
     */
    protected abstract CombinedRecognizerSettings createCombinedRecognizerSettings();

    /**
     * Creates result extractor for result type that is expected for used combined recognizer settings.
     * @param context Application context.
     * @return result extractor for result type that is expected for used combined recognizer settings.
     */
    protected abstract ResultExtractor createResultExtractor(Context context);

    /**
     * String code of the document language - ISO 639 standard. This setting is important for
     * sorting edit field keyboard buttons.
     * @return code of the document language - ISO 639 standard
     */
    protected abstract String getDocumentLanguageCode();

}