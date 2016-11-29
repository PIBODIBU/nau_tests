package ua.edu.nau.dao.impl;

import com.sun.istack.internal.Nullable;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.type.StringType;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.User;

import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl<T> implements UserDAO<T> {
    public ArrayList<T> getAll() {
        return null;
    }

    public T get(Integer id) {
        return null;
    }

    @SuppressWarnings("unchecked")
    @Nullable
    public T getByCredentials(String username, String password) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Criteria criteria = session.createCriteria(ua.edu.nau.model.User.class)
                .add(Expression.sql("BINARY username=?", username, new StringType()))
                .add(Expression.sql("BINARY password=?", password, new StringType()));

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

    @Override
    public Integer insert(T model) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Integer id = -1;

        session.beginTransaction();
        id = ((Integer) session.save(model));
        session.getTransaction().commit();

        return id;
    }

    @SuppressWarnings("unchecked")
    public T getById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        return ((T) session.get(User.class, id));
    }

    public void update(T newModel) {

    }

    public void delete(T model) {

    }
}
