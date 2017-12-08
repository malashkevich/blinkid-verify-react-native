package com.microblink.reactnative.blinkidverify.result.extract;

/**
 * Exception that is used when extraction fails for some reason, e.g. when front and
 * back side of the document do not match.
 */

public class ResultExtractException extends Exception {

    public ResultExtractException() {
    }

    public ResultExtractException(String message) {
        super(message);
    }

}
