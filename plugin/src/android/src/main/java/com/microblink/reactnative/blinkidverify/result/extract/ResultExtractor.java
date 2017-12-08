package com.microblink.reactnative.blinkidverify.result.extract;

import android.graphics.Bitmap;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.microblink.blinkidverify.result.entries.ResultEntry;
import com.microblink.recognizers.BaseRecognitionResult;

import java.util.List;

/**
 * Interface which must be implemented by all concrete result extractors which know how to
 * extract fields of interest from the given recognition result type.
 */
public interface ResultExtractor {

    /**
     * From the given recognition result extracts and builds result entries.
     * @param result recognition result.
     * @return extracted result entries.
     * @throws ResultExtractException if the extraction has failed for some reason, e.g. when front and
     * back side of the document do not match in combined recognition result.
     */
    @NonNull
    List<ResultEntry> extractResultEntries(BaseRecognitionResult result) throws ResultExtractException;

    /**
     * From the given recognition result extract face image if it exists.
     * @param result recogition result.
     * @return extracted face image or {@code null} if the image does not exist.
     */
    @Nullable
    Bitmap extractFaceBitmap(BaseRecognitionResult result);
}
