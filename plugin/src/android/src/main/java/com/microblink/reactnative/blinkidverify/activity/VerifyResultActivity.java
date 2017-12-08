package com.microblink.reactnative.blinkidverify.activity;

import android.graphics.Bitmap;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.DrawableRes;
import android.support.annotation.StringRes;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.ScaleAnimation;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.microblink.blinkidverify.activity.BaseResultActivity;
import com.microblink.blinkidverify.result.image.ImageHolder;
import com.microblink.reactnative.blinkidverify.R;
import com.microblink.reactnative.blinkidverify.config.ConfigVerificationService;
import com.microblink.reactnative.blinkidverify.result.CombinedIDLivenessResultsHolder;
import com.microblink.reactnative.blinkidverify.result.verification.RecognitionResultJSONBuilder;
import com.microblink.reactnative.blinkidverify.result.verification.VerificationServiceJSONBuilder;
import com.microblink.recognizers.blinkid.CombinedRecognitionResult;
import com.microblink.recognizers.liveness.LivenessRecognitionResult;
import com.microblink.util.Log;

import org.json.JSONObject;

import java.io.Serializable;
import java.util.HashMap;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.ResponseBody;

/**
 * Activity which shows final result and performs face matching by using Microsoft Cognitive Services Face API.
 * @see <a href="https://www.microsoft.com/cognitive-services/">https://www.microsoft.com/cognitive-services/</a>
 */
public class VerifyResultActivity extends BaseResultActivity {

    /** Resource ID of the activity title. */
    public static final String EXTRAS_ACTIVITY_TITLE_STRING_RESOURCE_ID = "EXTRAS_ACTIVITY_TITLE_STRING_RESOURCE_ID";

    /**
     * HashMap<String, String> which contains edited data key-value pairs
     */
    public static final String EXTRAS_EDITED_DATA_HASH_MAP = "EXTRAS_EDITED_DATA_HASH_MAP";

    /**
     * HashMap<String, String> which contains inserted data key-value pairs
     */
    public static final String EXTRAS_INSERTED_DATA_HASH_MAP = "EXTRAS_INSERTED_DATA_HASH_MAP";

    /**
     * Extras key for name of the face bitmap from the ID card. Bitmap should be stored under passed
     * name in the {@link ImageHolder} singleton.
     */
    public static final String EXTRAS_ID_FACE_BITMAP_NAME = "EXTRAS_ID_FACE_BITMAP_NAME";
    /**
     * Extras key for name of the face bitmap from the selfie camera. Bitmap should be stored under passed
     * name in the {@link ImageHolder} singleton.
     */
    public static final String EXTRAS_SELFIE_FACE_BITMAP_NAME = "EXTRAS_SELFIE_FACE_BITMAP_NAME";

    /**
     * Boolean flag which tells whether liveness check was successful or unsuccessful.
     */
    public static final String EXTRAS_LIVENESS_CHECK_PASSED = "EXTRAS_LIVENESS_CHECK_PASSED";

    /**
     * Result code when verification did not pass and button "Repeat selfie" is clicked
     */
    public static final int RESULT_REPEAT_LIVENESS = 0x100;

    private static final String LOG_TAG = "VerifyResultActivity";

    private Button mButtonRepeatLiveness;
    private Button mButtonConfirm;

    private ImageView mIvIdFace;
    private ImageView mIvSelfieFace;
    private TextView mTvSelfieFace;
    private View mUnderlineResultImages;
    private TextView mTvFaceMatchFailedReason;
    private View mFaceImagesContainer;

    private ImageView mIvStatus;
    private ProgressBar mVerifyProgressBar;

    @StringRes
    private int mActivityTitleStringRes;

    private boolean mLivenessCheckPassed;

    private Bitmap mIdFaceBitmap;
    private Bitmap mSelfieBitmap;

    private CombinedRecognitionResult mCombinedRecognitionResult;
    private LivenessRecognitionResult mLivenessRecognitionResult;
    private HashMap<String, String> mEditedData;
    private HashMap<String, String> mInsertedData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            mActivityTitleStringRes = extras.getInt(EXTRAS_ACTIVITY_TITLE_STRING_RESOURCE_ID);
            if (mActivityTitleStringRes != 0) {
                getSupportActionBar().setTitle(getString(mActivityTitleStringRes));
            }
            mLivenessCheckPassed = extras.getBoolean(EXTRAS_LIVENESS_CHECK_PASSED, false);

            Serializable editedDataSerializable = extras.getSerializable(EXTRAS_EDITED_DATA_HASH_MAP);
            if (editedDataSerializable instanceof HashMap) {
                mEditedData = (HashMap<String, String>) editedDataSerializable;

            }
            Serializable insertedDataSerializable = extras.getSerializable(EXTRAS_INSERTED_DATA_HASH_MAP);
            if (insertedDataSerializable instanceof HashMap) {
                mInsertedData = (HashMap<String, String>) insertedDataSerializable;
            }

            String idFaceBitmapName =  extras.getString(EXTRAS_ID_FACE_BITMAP_NAME);
            mIdFaceBitmap = ImageHolder.getInstance().getBitmap(idFaceBitmapName);
            if (mIdFaceBitmap != null) {
                mIvIdFace.setImageBitmap(mIdFaceBitmap);
            } else {
                throw new NullPointerException("Document face bitmap is required");
            }

            String selfieFaceBitmapName = extras.getString(EXTRAS_SELFIE_FACE_BITMAP_NAME);
            mSelfieBitmap = ImageHolder.getInstance().getBitmap(selfieFaceBitmapName);
            if (mSelfieBitmap != null && mLivenessCheckPassed) {
                mIvSelfieFace.setImageBitmap(mSelfieBitmap);
                mIvSelfieFace.setVisibility(View.VISIBLE);
                mTvSelfieFace.setVisibility(View.GONE);
            }
        }

        mCombinedRecognitionResult = CombinedIDLivenessResultsHolder.getInstance().getCombinedIDRecognitionResult();
        if (mCombinedRecognitionResult == null) {
            throw new NullPointerException("CombinedRecognitionResult not set");
        }
        mLivenessRecognitionResult = CombinedIDLivenessResultsHolder.getInstance().getLivenessRecognitionResult();

        if (mLivenessCheckPassed && mLivenessRecognitionResult != null) {
            startFaceMatching();
        } else {
            mFaceImagesContainer.setVisibility(View.GONE);
            setupVerificationFailedUI(R.string.msg_face_match_failed_timeout_selfie);
        }
    }

    @Override
    protected View initHeaderView() {
        // add header view
        View headerView = getLayoutInflater().inflate(R.layout.result_list_header, mResultListView, false);

        mFaceImagesContainer = headerView.findViewById(R.id.faceImagesContainer);
        mIvIdFace = (ImageView) headerView.findViewById(R.id.ivIdFace);
        mIvSelfieFace = (ImageView) headerView.findViewById(R.id.ivSelfieFace);
        mTvSelfieFace = (TextView) headerView.findViewById(R.id.tvSelfieFace);
        mIvStatus = (ImageView) headerView.findViewById(R.id.ivCheckStatus);
        mVerifyProgressBar = (ProgressBar) headerView.findViewById(R.id.pbValidationProgress);
        mUnderlineResultImages = headerView.findViewById(R.id.underlineResultImages);
        mTvFaceMatchFailedReason = (TextView) headerView.findViewById(R.id.tvFaceMatchFailedReason);

        return headerView;
    }

    @Override
    protected View initFooterView() {
        // add footer view
        View footerView = getLayoutInflater().inflate(R.layout.result_list_verification_footer, mResultListView, false);
        mButtonRepeatLiveness = (Button) footerView.findViewById(R.id.btn_result_repeat_liveness);
        mButtonConfirm = (Button) footerView.findViewById(R.id.btn_result_confirm);

        mButtonConfirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setResult(RESULT_OK);
                finish();
            }
        });

        mButtonRepeatLiveness.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setResult(RESULT_REPEAT_LIVENESS);
                finish();
            }
        });

        return footerView;
    }

    /** Setups UI when verification has failed (liveness check failed or face matching failed) */
    private void setupVerificationFailedUI(@StringRes int verificaitonFailedReason) {
        showStatusImage(R.drawable.img_result_failed);
        mButtonRepeatLiveness.setVisibility(View.VISIBLE);
        mTvFaceMatchFailedReason.setVisibility(View.VISIBLE);
        mUnderlineResultImages.setVisibility(View.GONE);
        mTvFaceMatchFailedReason.setText(verificaitonFailedReason);
    }

    private void setupVerificationPassedUI() {
        showStatusImage(R.drawable.img_result_ok);
        mButtonConfirm.setVisibility(View.VISIBLE);
    }

    /** Launches face matching async task. */
    private void startFaceMatching() {
        VerifyResultsTask verifyResultTask = new VerifyResultsTask(ConfigVerificationService.URL_VERIFICATION_SERVICE);
        mVerifyProgressBar.setVisibility(View.VISIBLE);
        verifyResultTask.execute();
    }

    /** Displays given status message over the progress bar
     * @param imageResource Resource ID of the status image. */
    private void showStatusImage(@DrawableRes int imageResource) {
        mIvStatus.setImageResource(imageResource);
        mVerifyProgressBar.setVisibility(View.INVISIBLE);
        mIvStatus.setVisibility(View.VISIBLE);
        Animation alpha = new AlphaAnimation(0f, 1f);
        Animation scale = new ScaleAnimation(0f, 1f, 0f, 1f, Animation.RELATIVE_TO_SELF, 0.5f,
                Animation.RELATIVE_TO_SELF, 0.5f);
        alpha.setDuration(500);
        scale.setDuration(500);
        AnimationSet animations = new AnimationSet(true);
        animations.addAnimation(alpha);
        animations.addAnimation(scale);
        mIvStatus.startAnimation(animations);
    }

    private class VerifyResultsTask extends AsyncTask<Void, Integer, Boolean> {

        private String mVerificationServiceUrl;

        private OkHttpClient mHttpClient;

        private boolean mFaceMatchingError;

        public VerifyResultsTask(String verificationServiceUrl) {
            mVerificationServiceUrl = verificationServiceUrl;
        }

        @Override
        protected Boolean doInBackground(Void... params) {
            if (mHttpClient == null) {
                mHttpClient = new OkHttpClient();
            }

            VerificationServiceJSONBuilder jsonBuilder = new VerificationServiceJSONBuilder(new RecognitionResultJSONBuilder());
            JSONObject jsonBody = jsonBuilder.buildVerificationServiceJSONRequestBody(
                    mCombinedRecognitionResult,
                    mLivenessRecognitionResult,
                    mEditedData,
                    mInsertedData
            );

            MediaType jsonType = MediaType.parse("application/json; charset=utf-8");
            RequestBody requestBody = RequestBody.create(jsonType, jsonBody.toString());

            Request request = new Request.Builder()
                    .url(mVerificationServiceUrl)
                    .post(requestBody)
                    .build();

            Response response = null;
            mFaceMatchingError = false;
            try {
                response = mHttpClient.newCall(request).execute();
                if (response.isSuccessful()) {
                    ResponseBody responseBody = response.body();
                    JSONObject responseJson = new JSONObject(responseBody.string());
                    return responseJson.getBoolean(ConfigVerificationService.RESPONSE_JSON_KEY_PERSON_VERIFIED);
                } else {
                    mFaceMatchingError = true;
                    return false;
                }
            } catch (Exception ex) {
                Log.w(this, ex.getMessage());
                mFaceMatchingError = true;
                return false;
            } finally {
                if (response != null) {
                    response.body().close();
                }
            }
        }

        @Override
        protected void onPostExecute(Boolean success) {
            if (success) {
                setupVerificationPassedUI();
            } else if (mFaceMatchingError) {
                setupVerificationFailedUI(R.string.msg_face_match_failed_no_internet);
            } else {
                setupVerificationFailedUI(R.string.msg_face_match_failed);
            }
        }
    }
}
