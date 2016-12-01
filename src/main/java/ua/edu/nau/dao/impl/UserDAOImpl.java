package ua.edu.nau.dao.impl;

import com.sun.istack.internal.Nullable;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.type.StringType;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.User;

import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {
    public ArrayList<User> getAll() {
        return null;
    }

    public User get(Integer id) {
        return null;
    }

    @SuppressWarnings("unchecked")
    @Nullable
    public User getByCredentials(String username, String password) {
        Session session = HibernateUtil.getSession();
        User user = null;

        session.beginTransaction();

        Criteria criteria = session.createCriteria(ua.edu.nau.model.User.class)
                .add(Expression.sql("BINARY username=?", username, new StringType()))
                .add(Expression.sql("BINARY password=?", password, new StringType()));

        List resultList = criteria.list();

        if (resultList.size() == 0) {
            return null;
        }

        try {
            user = ((User) criteria.list().get(0));
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        session.getTransaction().commit();

        return user;
    }

    @Override
    public Integer insert(User model) {
        Session session = HibernateUtil.getSession();

        Integer id = -1;

        session.beginTransaction();
        id = ((Integer) session.save(model));
        session.getTransaction().commit();

        return id;
    }

    @SuppressWarnings("unchecked")
    public User getById(Integer id) {
        Session session = HibernateUtil.getSession();

        session.beginTransaction();
        User user = ((User) session.get(User.class, id));
        session.refresh(user);
        session.getTransaction().commit();

        return user;
    }

    public void update(User newModel) {

    }

    public void delete(User model) {

    }
}
