package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import ua.edu.nau.dao.TestSessionDAO;
import ua.edu.nau.model.Test;
import ua.edu.nau.model.TestSession;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class TestSessionDAOImpl extends GenericDAOImpl<TestSession> implements TestSessionDAO {
    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

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
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        TestSession testSession = ((TestSession) session.get(TestSession.class, id));
        session.refresh(testSession);
        session.getTransaction().commit();

        session.close();

        return testSession;
    }

   /* @Override
    public Integer insert(TestSession model) {
        Session session = HibernateUtil.getSession();

        Integer id;

        session.beginTransaction();
        id = ((Integer) session.save(model));
        session.getTransaction().commit();

        return id;
    }*/

    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<TestSession> getUserSessions(Integer userId) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();

        ArrayList<TestSession> testSessions = new ArrayList<TestSession>(session.createCriteria(TestSession.class)
                .add(Restrictions.eqProperty("user_id", String.valueOf(userId)))
                .list());

        testSessions.forEach(session::refresh);

        session.getTransaction().commit();

        session.close();

        return testSessions;
    }

    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<TestSession> getTodayResult(Test test) {
        Session session = sessionFactory.openSession();

        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0); //anything 0 - 23
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        Date midnight = calendar.getTime(); // The midnight, that's the first second of the day.

        session.beginTransaction();
        ArrayList<TestSession> testSessions = new ArrayList<TestSession>(session.createCriteria(TestSession.class)
                .add(Restrictions.eq("test", test))
                .add(Restrictions.gt("endTime", midnight))
                .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                .list());
        testSessions.forEach(session::refresh);
        session.getTransaction().commit();

        System.out.println(midnight.toString());

        session.close();

        return testSessions;
    }

    @Override
    public void update(TestSession model) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        session.update(model);
        session.getTransaction().commit();

        session.close();
    }

    @Override
    public void delete(TestSession model) {

    }
}
