package ua.edu.nau.helper;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeFormatter {
    public static String dateToHumanReadable(Date date) {
        return new SimpleDateFormat("dd.MM.yyyy - kk:mm").format(date);
    }
}
