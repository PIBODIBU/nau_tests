package ua.edu.nau.helper.session;

import org.hibernate.Session;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.User;

import javax.servlet.http.HttpSession;
import java.util.UUID;

public class SessionUtils {
    private final String ATTR_SESSION_TOKEN = "token";
    private final String ATTR_USER = "user";
    private final String ATTR_HTTP_SESSION_ID = "http_session_id";

    private HttpSession httpSession;

    public SessionUtils(HttpSession httpSession) {
        this.httpSession = httpSession;

        if (!isSessionTokenExists()) {
            createSessionToken();
        }
    }

    private boolean isSessionTokenExists() {
        Object sessionId = httpSession.getAttribute(ATTR_SESSION_TOKEN);
        return sessionId != null;
    }

    public String getSessionToken() {
        return ((String) httpSession.getAttribute(ATTR_SESSION_TOKEN));
    }

    private String createSessionToken() {
        String uuid = UUID.randomUUID().toString();
        httpSession.setAttribute(ATTR_SESSION_TOKEN, uuid);
        return uuid;
    }

    public ua.edu.nau.model.Session getUserSession(HttpSession httpSession, String sessionId) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        if (httpSession == null) {
            System.out.println("httpSession is null");
            return null;
        }

        try {
            return (ua.edu.nau.model.Session)
                    session.get(ua.edu.nau.model.Session.class, sessionId);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public Boolean isUserLoggedIn() {
        return getUser() != null;
    }

    public Integer getUserAccessLevel() {
        return getUser().getUserRole().getRoleCode();
    }

    public void setHttpSessionId(Integer httpSessionId) {
        httpSession.setAttribute(ATTR_HTTP_SESSION_ID, httpSessionId);
    }

    public Integer getHttpSessionId() {
        return ((Integer) httpSession.getAttribute(ATTR_HTTP_SESSION_ID));
    }

    public void setUser(User user) {
        httpSession.setAttribute(ATTR_USER, user);
    }

    public User getUser() {
        return ((User) httpSession.getAttribute(ATTR_USER));
    }
}
