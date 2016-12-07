package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import ua.edu.nau.dao.HttpSessionDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.HttpSession;

import java.util.ArrayList;
import java.util.Date;

public class HttpSessionDAOImpl extends BasicDAOImpl<HttpSession> implements HttpSessionDAO {
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
        return super.getById(id);
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
        Session session = HibernateUtil.getSession();

        session.beginTransaction();
        HttpSession httpSession = ((HttpSession) session.get(HttpSession.class, httpSessionId));
        session.refresh(httpSession);
        httpSession.setLogoutTime(new Date());
        httpSession.setInvalid(true);
        session.getTransaction().commit();
    }
}
