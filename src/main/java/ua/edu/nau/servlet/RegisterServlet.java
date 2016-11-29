package ua.edu.nau.servlet;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.UserDAOImpl;
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

        if (sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/me");
            return;
        }

        getServletContext().getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session = HibernateUtil.getSessionFactory().openSession();
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

        if (sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/me");
            return;
        }

        String name = request.getParameter(Parameter.PARAM_NAME);
        String email = request.getParameter(Parameter.PARAM_EMAIL);
        String username = request.getParameter(Parameter.PARAM_USERNAME);
        String password = request.getParameter(Parameter.PARAM_PASSWORD);

        UserDAO<User> userDAO = new UserDAOImpl<>();
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

        Integer insertedId = userDAO.insert(user);

        sessionUtils.setUser(userDAO.getById(insertedId));

        response.sendRedirect("/me");
    }
}
