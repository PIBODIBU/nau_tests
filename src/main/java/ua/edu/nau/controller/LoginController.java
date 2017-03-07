package ua.edu.nau.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import ua.edu.nau.dao.HttpSessionDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class LoginController {
    private UserDAO userDAO;
    private HttpSessionDAO httpSessionDAO;

    @Autowired
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Autowired
    public void setHttpSessionDAO(HttpSessionDAO httpSessionDAO) {
        this.httpSessionDAO = httpSessionDAO;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView doGet(HttpSession httpSession, HttpServletResponse response) throws IOException {
        SessionUtils sessionUtils = new SessionUtils(httpSession);

        if (sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/me");
            return null;
        }

        return new ModelAndView("login.jsp");
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        request.setAttribute(Attribute.ATTR_BAD_LOGIN_OR_PASSWORD, false);
        ua.edu.nau.model.HttpSession httpSession = new ua.edu.nau.model.HttpSession();

        Integer httpSessionId = -1;
        String username = request.getParameter(Parameter.PARAM_USERNAME);
        String password = request.getParameter(Parameter.PARAM_PASSWORD);

        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            onBadCredentials(request, response);
            return;
        }

        User user = userDAO.getByCredentials(username, password);

        if (user == null) {
            onBadCredentials(request, response);
            return;
        }

        if (user.getUserRole().getRoleCode().equals(RoleCode.STUDENT)) {
            // Student is logging in. Randomize password
            userDAO.randomizePassword(user.getId());
        }

        httpSession.setUser(user);
        httpSession.setInvalid(false);
        httpSessionId = httpSessionDAO.insert(httpSession);

        sessionUtils.setUser(user);
        sessionUtils.setHttpSessionId(httpSessionId);

        response.sendRedirect("me");
    }

    private void onBadCredentials(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("Bad username or password");
        request.setAttribute(Attribute.ATTR_BAD_LOGIN_OR_PASSWORD, true);

        response.sendRedirect("login");
    }
}