package com.microblink.reactnative.blinkidverify.config;

/**
 * Configuration parameters for verification service (face matching).
 */
public class ConfigVerificationService {
    /**
     * URL where verification requests are sent (service where face matching is performed, and recognition data signatures are verified).
     */
    public static final String URL_VERIFICATION_SERVICE = "https://api.microblink.com/verify/verification";

    public static final String JSON_KEY_ID_DATA = "originalData";
    public static final String JSON_KEY_LIVENESS_DATA = "livenessData";
    public static final String JSON_KEY_EDITED_DATA = "editedData";
    public static final String JSON_KEY_INSERTED_DATA = "insertedData";

    public static final String RESPONSE_JSON_KEY_PERSON_VERIFIED = "isPersonVerified";
}
