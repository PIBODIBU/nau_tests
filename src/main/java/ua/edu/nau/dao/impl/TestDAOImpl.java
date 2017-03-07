package ua.edu.nau.dao.impl;

import com.sun.istack.internal.NotNull;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.model.Test;
import ua.edu.nau.model.User;

import java.util.ArrayList;

@Component
public class TestDAOImpl extends GenericDAOImpl<Test> implements TestDAO {
    private SessionFactory sessionFactory;
    private UserDAO userDAO;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Autowired
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<Test> getAll() {
        Session session = sessionFactory.openSession();
        ArrayList<Test> tests;

        session.beginTransaction();

        tests = new ArrayList<Test>(
                session.createCriteria(Test.class)
                        .addOrder(Order.asc("name"))
                        .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                        .list());

        session.getTransaction().commit();

        session.close();

        return tests;
    }

    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<Test> getUserTests(User owner) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();

        ArrayList<Test> tests = new ArrayList<Test>(session.createCriteria(Test.class)
                .add(Restrictions.eq("owner", owner))
                .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                .list());

        tests.forEach(session::refresh);

        session.getTransaction().commit();

        session.close();

        return tests;
    }

    @Override
    public Test get(Integer id) {
        return null;
    }

    @Override
    public Test getById(Integer id) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        Test test = ((Test) session.get(Test.class, id));
        session.getTransaction().commit();

        session.close();

        return test;
    }

    @Override
    public void update(Test model) {

    }

    @Override
    public void delete(Test test) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        session.delete(test);
        session.getTransaction().commit();

        session.close();
    }

    @Override
    public Boolean isTestBelongsToUser(@NotNull Integer testId, @NotNull Integer userId) throws IllegalStateException {
        if (userId == null) {
            throw new IllegalStateException("User id cannot be null");
        }

        if (testId == null) {
            throw new IllegalStateException("Test id cannot be null");
        }

        User user = userDAO.getById(userId);
        Test test = getById(testId);

        return test.getOwner().getId().equals(user.getId());
    }
}
