package ua.edu.nau.helper.cookie;

import javax.servlet.http.Cookie;

public class CookieUtils {
    public static final String SESSION_ID = "session_id";

    public static boolean isCookieExists(Cookie[] cookies, String name) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(name))
                return true;
        }

        return false;
    }

    public static Cookie getCookieByName(Cookie[] cookies, String name) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(name))
                return cookie;
        }

        return null;
    }
}