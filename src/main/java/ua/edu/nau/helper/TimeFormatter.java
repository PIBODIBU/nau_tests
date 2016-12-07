package ua.edu.nau.helper;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import static java.lang.Math.toIntExact;

public class TimeFormatter {
    public static String dateToHumanReadable(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy - HH:mm");
        dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
        return dateFormat.format(date);
    }

    public static String dateToHumanMinutes(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
        return dateFormat.format(date);
    }

    public static Long minutesToMillisLong(String minutes) {
        return Long.valueOf(minutes) * 60000;
    }

    public static Integer millisToMinutes(Long millis) {
        return toIntExact(millis / 60000);
    }

    public static Integer minutesToMillisInteger(String minutes) {
        return Integer.valueOf(minutes) * 60000;
    }
}