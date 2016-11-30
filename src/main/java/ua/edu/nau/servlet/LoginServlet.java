package ua.edu.nau.servlet;

import org.springframework.util.StringUtils;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

        if (sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/me");
            return;
        }

        getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute(Attribute.BAD_LOGIN_OR_PASSWORD, false);

        String username = request.getParameter(Parameter.PARAM_USERNAME);
        String password = request.getParameter(Parameter.PARAM_PASSWORD);

        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            onBadCredentials(request, response);
            return;
        }

        UserDAO userDAO = new UserDAOImpl();
        User user = userDAO.getByCredentials(username, password);

        if (user == null) {
            onBadCredentials(request, response);
            return;
        }

        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        sessionUtils.setUser(user);

        response.sendRedirect("/me");
    }

    private void onBadCredentials(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Bad username or password");
        request.setAttribute(Attribute.BAD_LOGIN_OR_PASSWORD, true);
        getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
    }
}