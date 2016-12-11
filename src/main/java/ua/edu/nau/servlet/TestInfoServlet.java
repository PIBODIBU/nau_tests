package ua.edu.nau.servlet;

import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.TestSessionDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.TestDAOImpl;
import ua.edu.nau.dao.impl.TestSessionDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.Test;
import ua.edu.nau.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/test/info"})
public class TestInfoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        TestDAO testDAO = new TestDAOImpl();
        UserDAO userDAO = new UserDAOImpl();
        TestSessionDAO testSessionDAO = new TestSessionDAOImpl();
        String jspName;

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        Integer userId = sessionUtils.getUser().getId();
        User userModel = userDAO.getById(userId);
        Integer userRoleCode = userModel.getUserRole().getRoleCode();

        request.setAttribute(Attribute.ATTR_USER_MODEL, userModel);

        if (userRoleCode.equals(RoleCode.ADMIN)) {
            jspName = "/test_info.jsp";
        } else if (userRoleCode.equals(RoleCode.ROOT)) {
            jspName = "/test_info.jsp";
        } else if (userRoleCode.equals(RoleCode.STUDENT)) {
            jspName = "/test_info_student.jsp";
        } else if (userRoleCode.equals(RoleCode.MODERATOR)) {
            jspName = "/test_info.jsp";
        } else {
            response.sendRedirect("/logout");
            return;
        }

        Integer testId = Integer.valueOf(request.getParameter(Parameter.PARAM_TEST_ID));
        Test test = testDAO.getById(testId);

        request.setAttribute(Attribute.ATTR_TEST_MODEL, test);
        request.setAttribute(Attribute.ATTR_USER_MODEL, userModel);
        request.setAttribute(Attribute.ATTR_ARRAY_LIST_TEST_SESSION_TODAY, testSessionDAO.getTodayResult(test));

        getServletContext().getRequestDispatcher(jspName).forward(request, response);
    }
}