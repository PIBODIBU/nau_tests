package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import ua.edu.nau.dao.BasicDAO;
import ua.edu.nau.hibernate.HibernateUtil;

import java.util.ArrayList;

public class BasicDAOImpl<T> implements BasicDAO<T> {
    @Override
    public ArrayList<T> getAll() {
        return null;
    }

    @Override
    public T get(Integer id) {
        return null;
    }

    @Override
    public T getById(Integer id) {
        return null;
    }

    @Override
    public Integer insert(T model) {
        Session session = HibernateUtil.getSession();

        Integer id;

        session.beginTransaction();
        id = ((Integer) session.save(model));
        session.getTransaction().commit();

        return id;
    }

    @Override
    public void insertOrUpdate(T model) {
        Session session = HibernateUtil.getSession();

        session.beginTransaction();
        session.saveOrUpdate(model);
        session.getTransaction().commit();
    }

    @Override
    public void update(T model) {

    }

    @Override
    public void delete(T model) {
    }
}
