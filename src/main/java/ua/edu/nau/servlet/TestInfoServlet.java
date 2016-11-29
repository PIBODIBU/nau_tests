package ua.edu.nau.servlet;

import ua.edu.nau.dao.impl.TestDAO;
import ua.edu.nau.dao.impl.TestDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.Test;

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
        TestDAO<Test> testDAO = new TestDAOImpl();

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        Integer testId = Integer.valueOf(request.getParameter(Parameter.PARAM_TEST_ID));
        Test test = testDAO.getById(testId);

        request.setAttribute(Attribute.ATTR_TEST_MODEL, test);

        getServletContext().getRequestDispatcher("/test_info.jsp").forward(request, response);
    }
}