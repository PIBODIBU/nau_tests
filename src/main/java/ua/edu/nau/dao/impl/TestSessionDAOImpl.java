package ua.edu.nau.dao.impl;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import ua.edu.nau.dao.TestSessionDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.TestSession;

import java.util.ArrayList;

public class TestSessionDAOImpl implements TestSessionDAO {
    @Override
    public ArrayList<TestSession> getAll() {
        return null;
    }

    @Override
    public TestSession get(Integer id) {
        return null;
    }

    @Override
    public TestSession getById(Integer id) {
        return null;
    }

    @Override
    public Integer insert(TestSession model) {
        Session session;

        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
        } catch (HibernateException ex) {
            session = HibernateUtil.getSessionFactory().openSession();
        }

        Integer id;

        session.beginTransaction();
        id = ((Integer) session.save(model));
        session.getTransaction().commit();

        return id;
    }

    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<TestSession> getUserSessions(Integer userId) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        ArrayList<TestSession> testSessions = new ArrayList<TestSession>(session.createCriteria(TestSession.class)
                .add(Restrictions.eqProperty("user_id", String.valueOf(userId)))
                .list());

        testSessions.forEach(session::refresh);

        return testSessions;
    }

    @Override
    public void update(TestSession newModel) {

    }

    @Override
    public void delete(TestSession model) {

    }
}
