package ua.edu.nau.listener;

import ua.edu.nau.dao.HttpSessionDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.HttpSessionDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class SessionListener implements HttpSessionListener {
    /**
     * Receives notification that a session has been created.
     *
     * @param se the HttpSessionEvent containing the session
     */
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        se.getSession().setMaxInactiveInterval(60 * 60 * 60);
    }

    /**
     * Receives notification that a session is about to be invalidated.
     *
     * @param se the HttpSessionEvent containing the session
     */
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        SessionUtils sessionUtils = new SessionUtils(se.getSession());
        HttpSessionDAO httpSessionDAO = new HttpSessionDAOImpl();

        if (sessionUtils.getHttpSessionId() != null)
            httpSessionDAO.invalidate(sessionUtils.getHttpSessionId());

        if (sessionUtils.getUser().getUserRole().getRoleCode().equals(RoleCode.STUDENT)) {
            UserDAO userDAO = new UserDAOImpl();
            userDAO.randomizePassword(sessionUtils.getUser().getId());
        }
    }
}
