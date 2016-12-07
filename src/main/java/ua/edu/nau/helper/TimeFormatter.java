package ua.edu.nau.helper;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeFormatter {
    public static String dateToHumanReadable(Date date) {
        return new SimpleDateFormat("dd.MM.yyyy - HH:mm").format(date);
    }

    public static String dateToHumanMinutes(Date date) {
        return new SimpleDateFormat("HH:mm:ss").format(date);
    }

    public static Long minutesToMillisLong(String minutes) {
        return Long.valueOf(minutes) * 60 * 60;
    }

    public static Integer minutesToMillisInteger(String minutes) {
        return Integer.valueOf(minutes) * 60 * 60;
    }
}