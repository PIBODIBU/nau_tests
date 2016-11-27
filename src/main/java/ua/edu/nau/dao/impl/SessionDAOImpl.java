package ua.edu.nau.dao.impl;

import ua.edu.nau.dao.SessionDAO;
import ua.edu.nau.hibernate.HibernateUtil;

import java.util.ArrayList;

public class SessionDAOImpl<Session> implements SessionDAO<Session> {
    public ArrayList<Session> getAll() {
        org.hibernate.Session session = HibernateUtil.getSessionFactory().openSession();
        return new ArrayList<Session>(session.createCriteria(ua.edu.nau.model.Session.class).list());
    }

    public Session get() {
        return null;
    }

    public Session getById(Integer id) {
        return null;
    }

    public void update(Session newModel) {

    }

    public void delete(Session model) {

    }
}
