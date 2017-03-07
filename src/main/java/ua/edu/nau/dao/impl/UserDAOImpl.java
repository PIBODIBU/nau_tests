package ua.edu.nau.dao.impl;

import com.sun.istack.internal.Nullable;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.type.StringType;
import org.springframework.beans.factory.annotation.Autowired;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.helper.PasswordGenerator;
import ua.edu.nau.model.HttpSession;
import ua.edu.nau.model.User;

import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl extends GenericDAOImpl<User> implements UserDAO {
    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<User> getAll() {
        Session session = sessionFactory.openSession();
        ArrayList<User> users;

        session.beginTransaction();

        users = new ArrayList<User>(
                session.createCriteria(User.class)
                        .addOrder(Order.asc("name"))
                        .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                        .list());

        session.getTransaction().commit();

        session.close();

        return users;
    }

    public User get(Integer id) {
        return null;
    }

    @SuppressWarnings("unchecked")
    @Nullable
    public User getByCredentials(String username, String password) {
        Session session = sessionFactory.openSession();
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
        } finally {
            session.getTransaction().commit();
            session.close();
        }

        return user;
    }

    @Override
    public Integer insert(User model) {
        Session session = sessionFactory.openSession();

        Integer id = -1;

        session.beginTransaction();
        id = ((Integer) session.save(model));
        session.getTransaction().commit();

        session.close();

        return id;
    }

    @SuppressWarnings("unchecked")
    public User getById(Integer id) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        User user = ((User) session.get(User.class, id));
        session.refresh(user);
        session.getTransaction().commit();

        session.close();

        return user;
    }

    public void update(User model) {

    }

    @Override
    public void randomizePassword(int userId) {
        Session session = sessionFactory.openSession();
        User user;
        String newPassword = PasswordGenerator.generate(5);

        session.beginTransaction();

        user = ((User) session.get(User.class, userId));
        try {
            session.refresh(user);
        } catch (Exception ex) {

        }

        user.setPassword(newPassword);
        session.update(user);

        session.getTransaction().commit();
        session.close();
    }

    @Override
    public HttpSession getLastSession(Integer userId) {
        Session session = sessionFactory.openSession();
        HttpSession httpSession = null;

        session.beginTransaction();

        User user = ((User) session.get(User.class, userId));
        try {
            httpSession = user.getHttpSessions().iterator().next();
            session.refresh(user);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

        session.getTransaction().commit();
        session.close();

        return httpSession;
    }

    @Override
    public User getStudentByBookNumber(String bookNumber) {
        Session session = sessionFactory.openSession();
        User user = null;

        session.beginTransaction();
        Criteria criteria = session.createCriteria(ua.edu.nau.model.User.class)
                .add(Expression.sql("BINARY username=?", bookNumber, new StringType()));

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
        session.close();

        return user;
    }
}