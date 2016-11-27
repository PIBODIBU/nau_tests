package ua.edu.nau.helper.session;

import javax.servlet.http.HttpSession;
import java.util.UUID;

public class SessionUtils {
    public static boolean isSessionTokenExists(HttpSession session) {
        Object sessionId = session.getAttribute("session_id");
        return sessionId != null;
    }

    public static String getSessionToken(HttpSession session) {
        return ((String) session.getAttribute("session_id"));
    }

    public static String createSessionToken(HttpSession session) {
        String uuid = UUID.randomUUID().toString();
        session.setAttribute("session_id", uuid);
        return uuid;
    }
}
