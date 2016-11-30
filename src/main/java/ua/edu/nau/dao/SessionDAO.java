package ua.edu.nau.dao;

import ua.edu.nau.model.Session;

public interface SessionDAO extends BasicDAO<Session> {
    Session getByToken(String token);
}
