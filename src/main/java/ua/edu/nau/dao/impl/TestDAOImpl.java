package ua.edu.nau.dao.impl;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.Test;
import ua.edu.nau.model.User;

import java.util.ArrayList;

public class TestDAOImpl implements TestDAO {
    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<Test> getAll() {
        Session session = HibernateUtil.getSession();

        return new ArrayList<Test>(
                session.createCriteria(Test.class)
                        .addOrder(Order.asc("name"))
                        .list());
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
