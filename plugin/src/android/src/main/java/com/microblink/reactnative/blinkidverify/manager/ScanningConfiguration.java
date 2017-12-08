package com.microblink.reactnative.blinkidverify.manager;

/**
 * Created by igrce on 20/11/2017.
 */

public class ScanningConfiguration {

    private String mLicenseKeyMicroblinkSDK;
    private String mLicenseKeyLivenessRecognizer;
    private boolean mBeepEnabled;
    private boolean mReturningCroppedImages;

    private ScanningConfiguration(String licenseKeyMicroblinkSDK, String licenseKeyLivenessRecognizer, boolean returningCroppedImages, boolean beepEnabled) {
        mLicenseKeyMicroblinkSDK = licenseKeyMicroblinkSDK;
        mLicenseKeyLivenessRecognizer = licenseKeyLivenessRecognizer;
        mReturningCroppedImages = returningCroppedImages;
        mBeepEnabled = beepEnabled;
    }

    public String getLicenseKeyMicroblinkSDK() {
        return mLicenseKeyMicroblinkSDK;
    }

    public String getLicenseKeyLivenessRecognizer() {
        return mLicenseKeyLivenessRecognizer;
    }

    public boolean isBeepEnabled() {
        return mBeepEnabled;
    }

    public boolean isReturningCroppedImages() {
        return mReturningCroppedImages;
    }

    public static class Builder {
        private String mLicenseKeyMicroblinkSDK;
        private String mLicenseKeyLivenessRecognizer;
        private boolean mBeepEnabled;
        private boolean mReturningCroppedImages;

        public Builder setLicenseKeyMicroblinkSDK(String licenseKeyMicroblinkSDK) {
            mLicenseKeyMicroblinkSDK = licenseKeyMicroblinkSDK;
            return this;
        }

        public Builder setLicenseKeyLivenessRecognizer(String licenseKeyLivenessRecognizer) {
            mLicenseKeyLivenessRecognizer = licenseKeyLivenessRecognizer;
            return this;
        }

        public Builder setBeepEnabled(boolean beepEnabled) {
            mBeepEnabled = beepEnabled;
            return this;
        }

        public Builder setReturningCroppedImages(boolean returningCroppedImages) {
            mReturningCroppedImages = returningCroppedImages;
            return this;
        }

        public ScanningConfiguration create() {
            if (mLicenseKeyLivenessRecognizer == null || mLicenseKeyLivenessRecognizer.isEmpty() || mLicenseKeyMicroblinkSDK == null || mLicenseKeyMicroblinkSDK.isEmpty()) {
                throw new IllegalStateException("Microblink SDK license key and liveness recognizer license key must be defined befora calling create()!");
            }
            return new ScanningConfiguration(mLicenseKeyMicroblinkSDK, mLicenseKeyLivenessRecognizer, mReturningCroppedImages, mBeepEnabled);
        }
    }
}
