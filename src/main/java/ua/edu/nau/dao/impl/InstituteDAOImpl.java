package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import ua.edu.nau.dao.InstituteDAO;
import ua.edu.nau.model.UniversityStructure.Institute;

import java.util.ArrayList;

public class InstituteDAOImpl extends GenericDAOImpl<Institute> implements InstituteDAO {
    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public Institute getById(Integer id) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        Institute institute = ((Institute) session.get(Institute.class, id));
        session.refresh(institute);
        session.getTransaction().commit();

        session.close();

        return institute;
    }

    @SuppressWarnings("unchecked")
    @Override
    public ArrayList<Institute> getAll() {
        Session session = sessionFactory.openSession();
        ArrayList<Institute> institutes;

        session.beginTransaction();

        institutes = new ArrayList<Institute>(session.createCriteria(Institute.class)
                .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                .addOrder(Order.asc("name"))
                .list());

        session.getTransaction().commit();

        session.close();

        return institutes;
    }
}
