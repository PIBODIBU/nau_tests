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
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.Test;
import ua.edu.nau.model.TestSession;
import ua.edu.nau.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(urlPatterns = {"/test/sessions"})
public class TestSessionsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        TestSessionDAO testSessionDAO = new TestSessionDAOImpl();
        UserDAO userDAO = new UserDAOImpl();

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        ArrayList<TestSession> testSessions =
                new ArrayList<TestSession>(userDAO.getById(sessionUtils.getUser().getId()).getTestSessions());

//        ArrayList<TestSession> testSessions = testSessionDAO.getUserSessions(sessionUtils.getUser().getId());

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_TEST_SESSION, testSessions);

        getServletContext().getRequestDispatcher("/test_session_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        TestSessionDAO testSessionDAO = new TestSessionDAOImpl();
        UserDAO userDAO = new UserDAOImpl();
        TestDAO testDAO = new TestDAOImpl();
        Integer testId = Integer.valueOf(request.getParameter(Parameter.PARAM_TEST_ID));

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        TestSession testSession = new TestSession();

        testSession.setTest(testDAO.getById(testId));
        testSession.setUser(userDAO.getById(sessionUtils.getUser().getId()));
        testSession.setDone(false);
        testSessionDAO.insert(testSession);

        ArrayList<TestSession> testSessions =
                new ArrayList<TestSession>(userDAO.getById(sessionUtils.getUser().getId()).getTestSessions());

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_TEST_SESSION, testSessions);

        getServletContext().getRequestDispatcher("/test_session_list.jsp").forward(request, response);
    }
}
