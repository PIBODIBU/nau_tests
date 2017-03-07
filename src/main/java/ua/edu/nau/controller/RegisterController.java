package ua.edu.nau.controller;

import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import ua.edu.nau.dao.DepartmentDAO;
import ua.edu.nau.dao.GroupDAO;
import ua.edu.nau.dao.InstituteDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.User;
import ua.edu.nau.model.UserRole;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class RegisterController {
    private UserDAO userDAO;
    private GroupDAO groupDAO;
    private InstituteDAO instituteDAO;
    private DepartmentDAO departmentDAO;

    @Autowired
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Autowired
    public void setGroupDAO(GroupDAO groupDAO) {
        this.groupDAO = groupDAO;
    }

    @Autowired
    public void setInstituteDAO(InstituteDAO instituteDAO) {
        this.instituteDAO = instituteDAO;
    }

    @Autowired
    public void setDepartmentDAO(DepartmentDAO departmentDAO) {
        this.departmentDAO = departmentDAO;
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ModelAndView modelAndView = new ModelAndView("register.jsp");
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/me");
            return null;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return null;
        }

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_INSTITUTE, instituteDAO.getAll());
        request.setAttribute(Attribute.ATTR_ARRAY_LIST_DEPARTMENT, departmentDAO.getAll());
        request.setAttribute(Attribute.ATTR_ARRAY_LIST_GROUP, groupDAO.getAll());

        return modelAndView;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session = HibernateUtil.getSessionFactory().openSession();
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

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

//        instituteId = Integer.valueOf(request.getParameter(Parameter.PARAM_INSTITUTE_ID));
//        departmentId = Integer.valueOf(request.getParameter(Parameter.PARAM_DEPARTMENT_ID));
        groupId = Integer.valueOf(request.getParameter(Parameter.PARAM_GROUP_ID));

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
