package ua.edu.nau.helper.auth.impl;

import org.hibernate.Session;
import ua.edu.nau.helper.auth.AuthUtils;
import ua.edu.nau.hibernate.HibernateUtil;

import javax.servlet.http.HttpSession;

public class AuthUtilsImpl implements AuthUtils {
    private static final String TAG = "AuthUtils: ";

    public ua.edu.nau.model.Session checkHttpSession(HttpSession httpSession) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        if (httpSession == null) {
            System.out.println(TAG + "httpSession is null");
            return null;
        }

        if (httpSession.getId() == null) {
            System.out.println(TAG + "httpSession id is null");
            return null;
        }

        try {
            return (ua.edu.nau.model.Session)
                    session.get(ua.edu.nau.model.Session.class, httpSession.getId());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }
}
