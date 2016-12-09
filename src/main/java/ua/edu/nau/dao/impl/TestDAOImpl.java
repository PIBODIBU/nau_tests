package ua.edu.nau.dao.impl;

import com.sun.istack.internal.NotNull;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.Test;
import ua.edu.nau.model.User;

import java.util.ArrayList;

public class TestDAOImpl extends BasicDAOImpl<Test> implements TestDAO {
    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<Test> getAll() {
        Session session = HibernateUtil.getSession();
        ArrayList<Test> tests;

        session.beginTransaction();

        tests = new ArrayList<Test>(
                session.createCriteria(Test.class)
                        .addOrder(Order.asc("name"))
                        .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                        .list());

        session.getTransaction().commit();

        return tests;
    }

    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<Test> getUserTests(User owner) {
        Session session = HibernateUtil.getSession();

        session.beginTransaction();

        ArrayList<Test> tests = new ArrayList<Test>(session.createCriteria(Test.class)
                .add(Restrictions.eq("owner", owner))
                .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                .list());

        tests.forEach(session::refresh);

        session.getTransaction().commit();

        return tests;
    }

    @Override
    public Test get(Integer id) {
        return null;
    }

    @Override
    public Test getById(Integer id) {
        Session session = HibernateUtil.getSession();

        session.beginTransaction();
        Test test = ((Test) session.get(Test.class, id));
        session.getTransaction().commit();

        return test;
    }

    @Override
    public void update(Test model) {

    }

    @Override
    public void delete(Test test) {
        Session session = HibernateUtil.getSession();

        session.beginTransaction();
//        test.getQuestions().clear();
        session.delete(test);
        session.getTransaction().commit();
    }

    @Override
    public Boolean isTestBelongsToUser(@NotNull Integer testId, @NotNull Integer userId) throws IllegalStateException {
        UserDAO userDAO = new UserDAOImpl();

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
