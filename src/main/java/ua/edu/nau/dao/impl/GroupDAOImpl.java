package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import ua.edu.nau.dao.GroupDAO;
import ua.edu.nau.model.UniversityStructure.Group;

import java.util.*;

public class GroupDAOImpl extends GenericDAOImpl<Group> implements GroupDAO {
    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    
    @Override
    public Group getById(Integer id) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        Group group = ((Group) session.get(Group.class, id));
        session.refresh(group);
        session.getTransaction().commit();

        session.close();

        return group;
    }

    @SuppressWarnings("unchecked")
    @Override
    public ArrayList<Group> getAll() {
        Session session = sessionFactory.openSession();
        ArrayList<Group> groups;

        session.beginTransaction();
        List<Group> groupSet = session.createCriteria(Group.class)
                .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                .addOrder(Order.asc("name"))
                .list();

        groups = new ArrayList<Group>(groupSet);

        session.getTransaction().commit();

        session.close();

        return groups;
    }
}
