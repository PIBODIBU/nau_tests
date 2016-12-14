package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import ua.edu.nau.dao.GroupDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.UniversityStructure.Group;

import java.util.ArrayList;

public class GroupDAOImpl extends BasicDAOImpl<Group> implements GroupDAO {
    @Override
    public Group getById(Integer id) {
        Session session = HibernateUtil.getSession();

        session.beginTransaction();
        Group group = ((Group) session.get(Group.class, id));
        session.refresh(group);
        session.getTransaction().commit();

        return group;
    }

    @SuppressWarnings("unchecked")
    @Override
    public ArrayList<Group> getAll() {
        Session session = HibernateUtil.getSession();
        ArrayList<Group> groups;

        session.beginTransaction();

        groups = new ArrayList<Group>(
                session.createCriteria(Group.class)
                        .addOrder(Order.asc("name"))
                        .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                        .list());

        session.getTransaction().commit();

        return groups;
    }
}
