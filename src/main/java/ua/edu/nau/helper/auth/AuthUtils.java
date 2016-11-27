package ua.edu.nau.helper.auth;

import ua.edu.nau.model.Session;

import javax.servlet.http.HttpSession;

public interface AuthUtils {
    Session checkHttpSession(HttpSession session);
}
