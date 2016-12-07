package ua.edu.nau.servlet;

import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.SettingDAOImpl;
import ua.edu.nau.dao.impl.TestDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.TimeFormatter;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

@WebServlet(urlPatterns = {"/me/tests"})
public class MyTestListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        TestDAO testDAO = new TestDAOImpl();
        UserDAO userDAO = new UserDAOImpl();

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return;
        }

        ArrayList<Test> tests = testDAO.getUserTests(sessionUtils.getUser());

        Date loginTime = userDAO.getLastSession(sessionUtils.getUser().getId()).getLoginTime();
        Date remain = new Date(new Date().getTime() - (loginTime.getTime() +
                TimeFormatter.minutesToMillisLong(new SettingDAOImpl().getByName(SettingDAOImpl.SETTING_SESSION_TIME).getValue())));
        request.setAttribute("remain", remain);


        request.setAttribute(Attribute.ATTR_ARRAY_LIST_TEST, tests);
        request.setAttribute(Attribute.ATTR_USER_MODEL, userDAO.getById(sessionUtils.getUser().getId()));

        getServletContext().getRequestDispatcher("/my_test_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }
    }
}
