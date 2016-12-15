package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import ua.edu.nau.dao.DepartmentDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.UniversityStructure.Department;

import java.util.ArrayList;

public class DepartmentDAOImpl extends BasicDAOImpl<Department> implements DepartmentDAO {
    @Override
    public Department getById(Integer id) {
        Session session = HibernateUtil.getSession();

        session.beginTransaction();
        Department department = ((Department) session.get(Department.class, id));
        session.refresh(department);
        session.getTransaction().commit();

        return department;
    }

    @SuppressWarnings("unchecked")
    @Override
    public ArrayList<Department> getAll() {
        Session session = HibernateUtil.getSession();
        ArrayList<Department> departments;

        session.beginTransaction();

        departments = new ArrayList<Department>(session.createCriteria(Department.class)
                .setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
                .addOrder(Order.asc("name"))
                .list());

        session.getTransaction().commit();

        return departments;
    }
}
