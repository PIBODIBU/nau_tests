package ua.edu.nau.dao.impl;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.type.StringType;
import ua.edu.nau.dao.SettingDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.Setting;

import java.util.List;

public class SettingDAOImpl extends BasicDAOImpl<Setting> implements SettingDAO {
    public static final String SETTING_SESSION_TIME = "http_session_time";

    @Override
    public Setting getByName(String name) {
        Session session = HibernateUtil.getSession();
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
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        session.getTransaction().commit();

        return setting;
    }
}
