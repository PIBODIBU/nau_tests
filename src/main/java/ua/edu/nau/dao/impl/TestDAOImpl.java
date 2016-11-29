package ua.edu.nau.dao.impl;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.Test;
import ua.edu.nau.model.User;

import java.util.ArrayList;

public class TestDAOImpl implements TestDAO<Test> {
    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<Test> getAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        return new ArrayList<Test>(
                session.createCriteria(Test.class)
                        .addOrder(Order.asc("name"))
                        .list());
    }

    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<Test> getUserTests(User owner) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        HibernateUtil.shutdown();

        ArrayList<Test> tests = new ArrayList<Test>(session.createCriteria(Test.class)
                .add(Restrictions.eq("owner", owner))
                .list());

        tests.forEach(session::refresh);

        return tests;
    }

    @Override
    public Test get(Integer id) {
        return null;
    }

    @Override
    public Test getById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Test test = ((Test) session.get(Test.class, id));
        HibernateUtil.shutdown();
        return test;
    }

    @Override
    public Integer insert(Test model) {
        return null;
    }

    @Override
    public void update(Test newModel) {

    }

    @Override
    public void delete(Test model) {

    }
}
