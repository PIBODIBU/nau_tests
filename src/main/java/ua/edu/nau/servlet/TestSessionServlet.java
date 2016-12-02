package ua.edu.nau.servlet;

import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.TestSessionDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.TestDAOImpl;
import ua.edu.nau.dao.impl.TestSessionDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.Test;
import ua.edu.nau.model.TestSession;
import ua.edu.nau.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/tests/sessions/start"})
public class TestSessionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        UserDAO userDAO = new UserDAOImpl();
        TestDAO testDAO = new TestDAOImpl();
        TestSessionDAO testSessionDAO = new TestSessionDAOImpl();
        User user;
        Test test;
        TestSession testSession;
        Integer testId = Integer.valueOf(request.getParameter(Parameter.PARAM_TEST_ID));
        Integer testSessionId = Integer.valueOf(request.getParameter(Parameter.PARAM_TEST_SESSION_ID));

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        user = userDAO.getById(sessionUtils.getUser().getId());
        test = testDAO.getById(testId);
        testSession = testSessionDAO.getById(testSessionId);

        request.setAttribute(Attribute.ATTR_USER_MODEL, user);
        request.setAttribute(Attribute.ATTR_TEST_MODEL, test);
        request.setAttribute(Attribute.ATTR_TEST_SESSION_MODEL, testSession);

        getServletContext().getRequestDispatcher("/test_session.jsp").forward(request, response);
    }
}
