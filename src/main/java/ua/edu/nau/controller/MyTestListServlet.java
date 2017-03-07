package ua.edu.nau.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import ua.edu.nau.dao.SettingDAO;
import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.SettingDAOImpl;
import ua.edu.nau.helper.TimeFormatter;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.JSPEvent;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.Test;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

@Controller
public class MyTestListServlet {
    private UserDAO userDAO;
    private TestDAO testDAO;

    @Autowired
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Autowired
    public void setTestDAO(TestDAO testDAO) {
        this.testDAO = testDAO;
    }

    @RequestMapping(value = "/me/tests", method = RequestMethod.GET)
    public ModelAndView doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ModelAndView modelAndView = new ModelAndView("my_test_list.jsp");
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return null;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return null;
        }

        ArrayList<Test> tests = testDAO.getUserTests(sessionUtils.getUser());

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_TEST, tests);
        request.setAttribute(Attribute.ATTR_USER_MODEL, userDAO.getById(sessionUtils.getUser().getId()));

        return modelAndView;
    }

    @RequestMapping(value = "/me/tests", method = RequestMethod.POST)
    public ModelAndView doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ModelAndView modelAndView = new ModelAndView("my_test_list.jsp");
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return null;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return null;
        }

        System.out.println(request.getParameter(Parameter.PARAM_ACTION));

        switch (request.getParameter(Parameter.PARAM_ACTION)) {
            case Parameter.PARAM_ACTION_DELETE_TEST: {
                Integer testId;

                try {
                    testId = Integer.valueOf(request.getParameter(Parameter.PARAM_TEST_ID));
                } catch (Exception ex) {
                    ex.printStackTrace();
                    break;
                }

                if (testId == null) {
                    System.out.println("Test id is null");
                    break;
                }

                if (testDAO.isTestBelongsToUser(testId, sessionUtils.getUser().getId())) {
                    testDAO.delete(testDAO.getById(testId));
                    request.setAttribute(Attribute.ATTR_JSP_EVENT, JSPEvent.TEST_DELETED);
                    break;
                } else {
                    System.out.println("Test is not belongs to this user");
                }

                break;
            }
            default:
                break;
        }

        // Proceed request
        ArrayList<Test> tests = testDAO.getUserTests(sessionUtils.getUser());

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_TEST, tests);
        request.setAttribute(Attribute.ATTR_USER_MODEL, userDAO.getById(sessionUtils.getUser().getId()));

        return modelAndView;
    }
}
