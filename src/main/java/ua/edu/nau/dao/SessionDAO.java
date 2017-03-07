package ua.edu.nau.dao;

import ua.edu.nau.model.Session;

public interface SessionDAO extends GenericDAO<Session> {
    Session getByToken(String token);
}
