package ua.edu.nau.servlet;

import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.TestDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(urlPatterns = {"/tests"})
public class TestListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        TestDAO testDAO = new TestDAOImpl();
        UserDAO userDAO = new UserDAOImpl();

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }
        
        ArrayList<Test> tests = testDAO.getAll();

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_TEST, tests);
        request.setAttribute(Attribute.ATTR_USER_MODEL, userDAO.getById(sessionUtils.getUser().getId()));

        getServletContext().getRequestDispatcher("/test_list.jsp").forward(request, response);
    }
}
