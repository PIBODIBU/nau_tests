package ua.edu.nau.dao.impl;

import com.sun.istack.Nullable;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.type.StringType;
import ua.edu.nau.dao.SessionDAO;
import ua.edu.nau.hibernate.HibernateUtil;

import java.util.ArrayList;
import java.util.List;

public class SessionDAOImpl implements SessionDAO {
    @Override
    @SuppressWarnings("unchecked")
    public ArrayList<ua.edu.nau.model.Session> getAll() {
        org.hibernate.Session session = HibernateUtil.getSession();
        ArrayList<ua.edu.nau.model.Session> sessions;

        session.beginTransaction();
        sessions = new ArrayList<>(session.createCriteria(ua.edu.nau.model.Session.class)
                .list());
        session.getTransaction().commit();

        return sessions;
    }

    @Override
    public ua.edu.nau.model.Session get(Integer id) {
        return null;
    }

    @Override
    @Nullable
    @SuppressWarnings("unckecked")
    public ua.edu.nau.model.Session getByToken(String token) {
        Session session = HibernateUtil.getSession();
        ua.edu.nau.model.Session searchedSession = null;

        session.beginTransaction();

        Criteria criteria = session.createCriteria(ua.edu.nau.model.User.class)
                .add(Expression.sql("BINARY token=?", token, new StringType()));

        List resultList = criteria.list();

        if (resultList.size() == 0) {
            return null;
        }

        try {
            searchedSession = ((ua.edu.nau.model.Session) criteria.list().get(0));
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        session.getTransaction().commit();

        return searchedSession;
    }

    public ua.edu.nau.model.Session getById(Integer id) {
        return null;
    }

    @Override
    public Integer insert(ua.edu.nau.model.Session model) {
        return null;
    }

    @Override
    public void update(ua.edu.nau.model.Session newModel) {

    }

    @Override
    public void delete(ua.edu.nau.model.Session model) {

    }
}
