package ua.edu.nau.servlet;

import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.TestDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.Question;
import ua.edu.nau.model.Test;
import ua.edu.nau.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@WebServlet(urlPatterns = {"/tests/add"})
public class TestAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/test_add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        String testName, testDescription, testTime;
        TestDAO testDAO = new TestDAOImpl();
        UserDAO userDAO = new UserDAOImpl();
        ArrayList<Question> questions = new ArrayList<>();
        Test test;
        User user;

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        if (sessionUtils.getUserAccesLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return;
        }


        testName = request.getParameter(Parameter.PARAM_TEST_NAME);
        testDescription = request.getParameter(Parameter.PARAM_TEST_DESCRIPTION);
        testTime = request.getParameter(Parameter.PARAM_TEST_TIME);

        user = userDAO.getById(sessionUtils.getUser().getId());

        test = new Test();
        test.setName(testName);
        test.setDescription(testDescription);
        test.setTime(createDateFromString(testTime));
        test.setOwner(user);

        testDAO.insert(test);
    }

    private Date createDateFromString(String timeString) {
        timeString = "00:" + timeString + ":00";
        SimpleDateFormat dateFormat = new SimpleDateFormat("kk:mm:ss");

        try {
            return dateFormat.parse(timeString);
        } catch (ParseException e) {
            e.printStackTrace();
            return new Date();
        }
    }
}