package ua.edu.nau.servlet;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import ua.edu.nau.dao.DepartmentDAO;
import ua.edu.nau.dao.GroupDAO;
import ua.edu.nau.dao.InstituteDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.DepartmentDAOImpl;
import ua.edu.nau.dao.impl.GroupDAOImpl;
import ua.edu.nau.dao.impl.InstituteDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.User;
import ua.edu.nau.model.UserRole;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        InstituteDAO instituteDAO = new InstituteDAOImpl();
        DepartmentDAO departmentDAO = new DepartmentDAOImpl();
        GroupDAO groupDAO = new GroupDAOImpl();

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/me");
            return;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return;
        }

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_INSTITUTE, instituteDAO.getAll());
        request.setAttribute(Attribute.ATTR_ARRAY_LIST_DEPARTMENT, departmentDAO.getAll());
        request.setAttribute(Attribute.ATTR_ARRAY_LIST_GROUP, groupDAO.getAll());

        getServletContext().getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session = HibernateUtil.getSessionFactory().openSession();
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        GroupDAO groupDAO = new GroupDAOImpl();

        Integer instituteId, departmentId, groupId;
        String name, email, username, password;

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/me");
            return;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return;
        }

        name = request.getParameter(Parameter.PARAM_NAME);
        email = request.getParameter(Parameter.PARAM_EMAIL);
        username = request.getParameter(Parameter.PARAM_USERNAME);
        password = request.getParameter(Parameter.PARAM_PASSWORD);

        instituteId = Integer.valueOf(request.getParameter(Parameter.PARAM_INSTITUTE_ID));
        departmentId = Integer.valueOf(request.getParameter(Parameter.PARAM_DEPARTMENT_ID));
        groupId = Integer.valueOf(request.getParameter(Parameter.PARAM_GROUP_ID));

        UserDAO userDAO = new UserDAOImpl();
        User user = new User();
        UserRole userRole;

        userRole = ((UserRole) session.createCriteria(UserRole.class)
                .add(Restrictions.eq("roleCode", RoleCode.STUDENT))
                .list().get(0));

        user.setName(name);
        user.setEmail(email);
        user.setUsername(username);
        user.setPassword(password);
        user.setUserRole(userRole);
        user.setGroup(groupDAO.getById(groupId));

        userDAO.insert(user);

        response.sendRedirect("/users");
    }
}
