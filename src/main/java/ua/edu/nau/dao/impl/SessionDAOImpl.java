package ua.edu.nau.dao.impl;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.type.StringType;
import ua.edu.nau.dao.SessionDAO;
import ua.edu.nau.hibernate.HibernateUtil;

import java.util.ArrayList;
import java.util.List;

public class SessionDAOImpl<T> implements SessionDAO<T> {
    public ArrayList<T> getAll() {
        org.hibernate.Session session = HibernateUtil.getSessionFactory().openSession();
        return new ArrayList<T>(session.createCriteria(ua.edu.nau.model.Session.class).list());
    }

    public T get(Integer id) {
        return null;
    }

    @Override
    @SuppressWarnings("unckecked")
    public T getByToken(String token) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Criteria criteria = session.createCriteria(ua.edu.nau.model.User.class)
                .add(Expression.sql("BINARY token=?", token, new StringType()));

        List resultList = criteria.list();

        if (resultList.size() == 0) {
            return null;
        }

        try {
            return ((T) criteria.list().get(0));
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public T getById(Integer id) {
        return null;
    }

    public void update(T newModel) {

    }

    public void delete(T model) {

    }
}
