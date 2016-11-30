package ua.edu.nau.dao.impl;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.type.StringType;
import ua.edu.nau.dao.SessionDAO;
import ua.edu.nau.hibernate.HibernateUtil;

import java.util.ArrayList;
import java.util.List;

public class SessionDAOImpl implements SessionDAO {
    public ArrayList<ua.edu.nau.model.Session> getAll() {
        org.hibernate.Session session = HibernateUtil.getSessionFactory().openSession();
        return new ArrayList<ua.edu.nau.model.Session>(session.createCriteria(ua.edu.nau.model.Session.class).list());
    }

    public ua.edu.nau.model.Session get(Integer id) {
        return null;
    }

    @Override
    @SuppressWarnings("unckecked")
    public ua.edu.nau.model.Session getByToken(String token) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Criteria criteria = session.createCriteria(ua.edu.nau.model.User.class)
                .add(Expression.sql("BINARY token=?", token, new StringType()));

        List resultList = criteria.list();

        if (resultList.size() == 0) {
            return null;
        }

        try {
            return ((ua.edu.nau.model.Session) criteria.list().get(0));
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
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
