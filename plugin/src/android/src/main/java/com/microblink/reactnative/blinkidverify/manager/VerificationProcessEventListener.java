package com.microblink.reactnative.blinkidverify.manager;

/**
 * Listener for events that happen during recognition process and should be handled
 * outside of the verification flow. All callbacks are called when verification flow
 * is returning control to the activity which has started it.
 */
public interface VerificationProcessEventListener {

    /**
     * Callback that is called when verification process is canceled by user.
     */
    void onVerificationCanceled();

    /**
     * Callback when user requested to scan again.
     */
    void onScanAgainRequested();

    /**
     * Callback that is called when verification is successfully finished
     * and all verifications have successfully passed.
     */
    void onVerificationSuccess();
}
