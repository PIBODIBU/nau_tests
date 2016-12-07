package ua.edu.nau.servlet;

import ua.edu.nau.dao.HttpSessionDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.HttpSessionDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;

import javax.management.relation.Role;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        HttpSessionDAO httpSessionDAO = new HttpSessionDAOImpl();

        if (sessionUtils.getHttpSessionId() != null)
            httpSessionDAO.invalidate(sessionUtils.getHttpSessionId());

        if (sessionUtils.getUser().getUserRole().getRoleCode().equals(RoleCode.STUDENT)) {
            UserDAO userDAO = new UserDAOImpl();
            userDAO.randomizePassword(sessionUtils.getUser().getId());
        }

        request.getSession().invalidate();
        response.sendRedirect("/login");
    }
}
