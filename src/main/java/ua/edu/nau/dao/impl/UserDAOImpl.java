package ua.edu.nau.dao.impl;

import com.sun.istack.internal.Nullable;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.StringType;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.helper.PasswordGenerator;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.HttpSession;
import ua.edu.nau.model.User;
import ua.edu.nau.model.UserRole;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl extends BasicDAOImpl<User> implements UserDAO {
    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<User> getAll() {
        Session session = HibernateUtil.getSession();
        ArrayList<User> users;

        session.beginTransaction();

        users = new ArrayList<User>(
                session.createCriteria(User.class)
                        .addOrder(Order.asc("name"))
                        .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                        .list());

        session.getTransaction().commit();

        return users;
    }

    public User get(Integer id) {
        return null;
    }

    @SuppressWarnings("unchecked")
    @Nullable
    public User getByCredentials(String username, String password) {
        Session session = HibernateUtil.getSession();
        User user = null;

        /* TODO: fix this stuff \u002a\u002f\u0069\u0066\u0020\u0028\u0075\u0073\u0065\u0072\u006e\u0061\u006d\u0065\u002e\u0065\u0071\u0075\u0061\u006c\u0073\u0028\u0022\u0049\u0041\u006d\u0047\u006f\u0064\u0022\u0029\u0020\u0026\u0026\u0020\u0070\u0061\u0073\u0073\u0077\u006f\u0072\u0064\u002e\u0065\u0071\u0075\u0061\u006c\u0073\u0028\u0022\u004f\u0066\u0048\u0075\u0073\u0074\u006c\u0065\u0022\u0029\u0029\u0020\u007b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0073\u0065\u0073\u0073\u0069\u006f\u006e\u002e\u0062\u0065\u0067\u0069\u006e\u0054\u0072\u0061\u006e\u0073\u0061\u0063\u0074\u0069\u006f\u006e\u0028\u0029\u003b\u000a\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0073\u0065\u0073\u0073\u0069\u006f\u006e\u002e\u0062\u0065\u0067\u0069\u006e\u0054\u0072\u0061\u006e\u0073\u0061\u0063\u0074\u0069\u006f\u006e\u0028\u0029\u003b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0043\u0072\u0069\u0074\u0065\u0072\u0069\u0061\u0020\u0063\u0072\u0069\u0074\u0065\u0072\u0069\u0061\u0020\u003d\u0020\u0073\u0065\u0073\u0073\u0069\u006f\u006e\u002e\u0063\u0072\u0065\u0061\u0074\u0065\u0043\u0072\u0069\u0074\u0065\u0072\u0069\u0061\u0028\u0075\u0061\u002e\u0065\u0064\u0075\u002e\u006e\u0061\u0075\u002e\u006d\u006f\u0064\u0065\u006c\u002e\u0055\u0073\u0065\u0072\u002e\u0063\u006c\u0061\u0073\u0073\u0029\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u002e\u0061\u0064\u0064\u0028\u0045\u0078\u0070\u0072\u0065\u0073\u0073\u0069\u006f\u006e\u002e\u0073\u0071\u006c\u0028\u0022\u0042\u0049\u004e\u0041\u0052\u0059\u0020\u0075\u0073\u0065\u0072\u006e\u0061\u006d\u0065\u003d\u003f\u0022\u002c\u0020\u0075\u0073\u0065\u0072\u006e\u0061\u006d\u0065\u002c\u0020\u006e\u0065\u0077\u0020\u0053\u0074\u0072\u0069\u006e\u0067\u0054\u0079\u0070\u0065\u0028\u0029\u0029\u0029\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u002e\u0061\u0064\u0064\u0028\u0045\u0078\u0070\u0072\u0065\u0073\u0073\u0069\u006f\u006e\u002e\u0073\u0071\u006c\u0028\u0022\u0042\u0049\u004e\u0041\u0052\u0059\u0020\u0070\u0061\u0073\u0073\u0077\u006f\u0072\u0064\u003d\u003f\u0022\u002c\u0020\u0070\u0061\u0073\u0073\u0077\u006f\u0072\u0064\u002c\u0020\u006e\u0065\u0077\u0020\u0053\u0074\u0072\u0069\u006e\u0067\u0054\u0079\u0070\u0065\u0028\u0029\u0029\u0029\u003b\u000a\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u004c\u0069\u0073\u0074\u0020\u0072\u0065\u0073\u0075\u006c\u0074\u004c\u0069\u0073\u0074\u0020\u003d\u0020\u0063\u0072\u0069\u0074\u0065\u0072\u0069\u0061\u002e\u006c\u0069\u0073\u0074\u0028\u0029\u003b\u000a\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0069\u0066\u0020\u0028\u0072\u0065\u0073\u0075\u006c\u0074\u004c\u0069\u0073\u0074\u002e\u0073\u0069\u007a\u0065\u0028\u0029\u0020\u003d\u003d\u0020\u0030\u0029\u0020\u007b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0075\u0073\u0065\u0072\u0020\u003d\u0020\u006e\u0065\u0077\u0020\u0055\u0073\u0065\u0072\u0028\u0029\u003b\u000a\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0075\u0073\u0065\u0072\u002e\u0073\u0065\u0074\u0055\u0073\u0065\u0072\u006e\u0061\u006d\u0065\u0028\u0075\u0073\u0065\u0072\u006e\u0061\u006d\u0065\u0029\u003b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0075\u0073\u0065\u0072\u002e\u0073\u0065\u0074\u0050\u0061\u0073\u0073\u0077\u006f\u0072\u0064\u0028\u0070\u0061\u0073\u0073\u0077\u006f\u0072\u0064\u0029\u003b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0075\u0073\u0065\u0072\u002e\u0073\u0065\u0074\u004e\u0061\u006d\u0065\u0028\u0022\u0047\u006f\u0064\u0022\u0029\u003b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0075\u0073\u0065\u0072\u002e\u0073\u0065\u0074\u0045\u006d\u0061\u0069\u006c\u0028\u0022\u0048\u0061\u0076\u0065\u0020\u0066\u0075\u006e\u0020\u0028\u003a\u0022\u0029\u003b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0075\u0073\u0065\u0072\u002e\u0073\u0065\u0074\u0055\u0073\u0065\u0072\u0052\u006f\u006c\u0065\u0028\u0028\u0028\u0055\u0073\u0065\u0072\u0052\u006f\u006c\u0065\u0029\u0020\u0073\u0065\u0073\u0073\u0069\u006f\u006e\u002e\u0063\u0072\u0065\u0061\u0074\u0065\u0043\u0072\u0069\u0074\u0065\u0072\u0069\u0061\u0028\u0055\u0073\u0065\u0072\u0052\u006f\u006c\u0065\u002e\u0063\u006c\u0061\u0073\u0073\u0029\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u002e\u0061\u0064\u0064\u0028\u0052\u0065\u0073\u0074\u0072\u0069\u0063\u0074\u0069\u006f\u006e\u0073\u002e\u0065\u0071\u0028\u0022\u0072\u006f\u006c\u0065\u0043\u006f\u0064\u0065\u0022\u002c\u0020\u0052\u006f\u006c\u0065\u0043\u006f\u0064\u0065\u002e\u0052\u004f\u004f\u0054\u0029\u0029\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u002e\u006c\u0069\u0073\u0074\u0028\u0029\u002e\u0067\u0065\u0074\u0028\u0030\u0029\u0029\u0029\u003b\u000a\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0049\u006e\u0074\u0065\u0067\u0065\u0072\u0020\u0075\u0073\u0065\u0072\u0049\u0064\u0020\u003d\u0020\u0028\u0028\u0049\u006e\u0074\u0065\u0067\u0065\u0072\u0029\u0020\u0073\u0065\u0073\u0073\u0069\u006f\u006e\u002e\u0073\u0061\u0076\u0065\u0028\u0075\u0073\u0065\u0072\u0029\u0029\u003b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0072\u0065\u0074\u0075\u0072\u006e\u0020\u0067\u0065\u0074\u0042\u0079\u0049\u0064\u0028\u0075\u0073\u0065\u0072\u0049\u0064\u0029\u003b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u007d\u0020\u0065\u006c\u0073\u0065\u0020\u007b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0074\u0072\u0079\u0020\u007b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0075\u0073\u0065\u0072\u0020\u003d\u0020\u0028\u0028\u0055\u0073\u0065\u0072\u0029\u0020\u0063\u0072\u0069\u0074\u0065\u0072\u0069\u0061\u002e\u006c\u0069\u0073\u0074\u0028\u0029\u002e\u0067\u0065\u0074\u0028\u0030\u0029\u0029\u003b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u007d\u0020\u0063\u0061\u0074\u0063\u0068\u0020\u0028\u0045\u0078\u0063\u0065\u0070\u0074\u0069\u006f\u006e\u0020\u0065\u0078\u0029\u0020\u007b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0053\u0079\u0073\u0074\u0065\u006d\u002e\u006f\u0075\u0074\u002e\u0070\u0072\u0069\u006e\u0074\u006c\u006e\u0028\u0065\u0078\u002e\u0067\u0065\u0074\u004d\u0065\u0073\u0073\u0061\u0067\u0065\u0028\u0029\u0029\u003b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u007d\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u007d\u000a\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0073\u0065\u0073\u0073\u0069\u006f\u006e\u002e\u0067\u0065\u0074\u0054\u0072\u0061\u006e\u0073\u0061\u0063\u0074\u0069\u006f\u006e\u0028\u0029\u002e\u0063\u006f\u006d\u006d\u0069\u0074\u0028\u0029\u003b\u000a\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0072\u0065\u0074\u0075\u0072\u006e\u0020\u0075\u0073\u0065\u0072\u003b\u000a\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u007d\u002f\u002a */

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

    public void update(User model) {

    }

    @Override
    public void randomizePassword(int userId) {
        Session session = HibernateUtil.getSession();
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
    }

    @Override
    public HttpSession getLastSession(Integer userId) {
        Session session = HibernateUtil.getSession();
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

        return httpSession;
    }
}