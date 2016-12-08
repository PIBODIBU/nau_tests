package ua.edu.nau.servlet;

import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/users"})
public class UserListServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        UserDAO userDAO = new UserDAOImpl();

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return;
        }

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_USER, userDAO.getAll());
        request.setAttribute(Attribute.ATTR_USER_MODEL, userDAO.getById(sessionUtils.getUser().getId()));

        getServletContext().getRequestDispatcher("/user_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        UserDAO userDAO = new UserDAOImpl();
        String[] studentIds = request.getParameterValues("students");
        String action = request.getParameter("action");

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return;
        }

        if (action.equals("action_randomize_pass")) {
            for (String id : studentIds) {
                userDAO.randomizePassword(Integer.valueOf(id));
            }
        }

        doGet(request, response);
    }
}