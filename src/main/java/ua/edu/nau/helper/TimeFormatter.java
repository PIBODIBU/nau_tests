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
}