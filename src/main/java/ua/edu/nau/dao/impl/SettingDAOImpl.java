package ua.edu.nau.dao.impl;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Expression;
import org.hibernate.type.StringType;
import org.springframework.beans.factory.annotation.Autowired;
import ua.edu.nau.dao.SettingDAO;
import ua.edu.nau.model.Setting;

import java.util.List;

public class SettingDAOImpl extends GenericDAOImpl<Setting> implements SettingDAO {
    public static final String SETTING_SESSION_TIME = "http_session_time";

    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public Setting getByName(String name) {
        Session session = sessionFactory.openSession();
        Setting setting = null;

        session.beginTransaction();

        Criteria criteria = session.createCriteria(Setting.class)
                .add(Expression.sql("BINARY name=?", name, new StringType()));

        List resultList = criteria.list();

        if (resultList.size() == 0) {
            return null;
        }

        try {
            setting = ((Setting) criteria.list().get(0));
            session.refresh(setting);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        session.getTransaction().commit();

        session.close();

        return setting;
    }
}
