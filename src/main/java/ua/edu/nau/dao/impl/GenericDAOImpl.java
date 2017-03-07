package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import ua.edu.nau.dao.GenericDAO;

import java.util.ArrayList;

public abstract class GenericDAOImpl<T> implements GenericDAO<T> {
    protected SessionFactory sessionFactory;

    protected void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public ArrayList<T> getAll() {
        return null;
    }

    @Override
    public ArrayList<String> getAllAsJson() {
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
        Session session = sessionFactory.openSession();

        Integer id;

        session.beginTransaction();
        id = ((Integer) session.save(model));
        session.getTransaction().commit();

        session.close();

        return id;
    }

    @Override
    public void insertOrUpdate(T model) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        session.saveOrUpdate(model);
        session.getTransaction().commit();

        session.close();
    }

    @Override
    public void update(T model) {

    }

    @Override
    public void delete(T model) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        session.delete(model);
        session.getTransaction().commit();

        session.close();
    }
}
