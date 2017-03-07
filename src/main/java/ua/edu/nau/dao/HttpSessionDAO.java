package ua.edu.nau.dao;

import ua.edu.nau.model.HttpSession;

public interface HttpSessionDAO extends GenericDAO<HttpSession> {
    void invalidate(Integer httpSessionId);
}
