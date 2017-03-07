package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import ua.edu.nau.dao.DepartmentDAO;
import ua.edu.nau.model.UniversityStructure.Department;

import java.util.ArrayList;

public class DepartmentDAOImpl extends GenericDAOImpl<Department> implements DepartmentDAO {
    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public Department getById(Integer id) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        Department department = ((Department) session.get(Department.class, id));
        session.refresh(department);
        session.getTransaction().commit();

        session.close();

        return department;
    }

    @SuppressWarnings("unchecked")
    @Override
    public ArrayList<Department> getAll() {
        Session session = sessionFactory.openSession();
        ArrayList<Department> departments;

        session.beginTransaction();

        departments = new ArrayList<Department>(session.createCriteria(Department.class)
                .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                .addOrder(Order.asc("name"))
                .list());

        session.getTransaction().commit();

        session.close();

        return departments;
    }
}
