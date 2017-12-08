package com.microblink.reactnative.blinkidverify.result.extract.utils;

import java.util.Locale;

public class DateFormatter {

    public static String formatCroDate(com.microblink.results.date.Date value) {
        if (value == null) return "";
        return String.format(Locale.US, "%02d.%02d.%d.", value.getDay(), value.getMonth(), value.getYear());
    }

}
