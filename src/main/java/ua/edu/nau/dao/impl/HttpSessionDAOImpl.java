package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import ua.edu.nau.dao.HttpSessionDAO;
import ua.edu.nau.model.HttpSession;

import java.util.ArrayList;
import java.util.Date;

@Component
public class HttpSessionDAOImpl extends GenericDAOImpl<HttpSession> implements HttpSessionDAO {
    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    @Override
    public ArrayList<HttpSession> getAll() {
        return super.getAll();
    }

    @Override
    public HttpSession get(Integer id) {
        return super.get(id);
    }

    @Override
    public HttpSession getById(Integer id) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        HttpSession httpSession = ((HttpSession) session.get(HttpSession.class, id));
        session.refresh(httpSession);
        session.getTransaction().commit();

        session.close();

        return httpSession;
    }

    @Override
    public void update(HttpSession model) {
        super.update(model);
    }

    @Override
    public void delete(HttpSession model) {
        super.delete(model);
    }

    @Override
    public void invalidate(Integer httpSessionId) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        HttpSession httpSession = ((HttpSession) session.get(HttpSession.class, httpSessionId));
        session.refresh(httpSession);
        httpSession.setLogoutTime(new Date());
        httpSession.setInvalid(true);

        session.getTransaction().commit();

        session.close();
    }
}
