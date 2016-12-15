package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import ua.edu.nau.dao.InstituteDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.UniversityStructure.Institute;

import java.util.ArrayList;

public class InstituteDAOImpl extends BasicDAOImpl<Institute> implements InstituteDAO {
    @Override
    public Institute getById(Integer id) {
        Session session = HibernateUtil.getSession();

        session.beginTransaction();
        Institute institute = ((Institute) session.get(Institute.class, id));
        session.refresh(institute);
        session.getTransaction().commit();

        return institute;
    }

    @SuppressWarnings("unchecked")
    @Override
    public ArrayList<Institute> getAll() {
        Session session = HibernateUtil.getSession();
        ArrayList<Institute> institutes;

        session.beginTransaction();

        institutes = new ArrayList<Institute>(session.createCriteria(Institute.class)
                .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                .addOrder(Order.asc("name"))
                .list());

        session.getTransaction().commit();

        return institutes;
    }
}
