package ua.edu.nau.servlet;

import ua.edu.nau.dao.GroupDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.GroupDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.UniversityStructure.Group;
import ua.edu.nau.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

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
        GroupDAO groupDAO = new GroupDAOImpl();

        Integer groupId = null;

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return;
        }

        try {
            groupId = Integer.valueOf(request.getParameter(Parameter.PARAM_GROUP_ID));
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
        }

        // Fetching all users or users of the specified group
        ArrayList<User> users = new ArrayList<User>();
        users.addAll(groupId == null ? userDAO.getAll() : groupDAO.getById(groupId).getUsers());

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_USER, users);
        request.setAttribute(Attribute.ATTR_ARRAY_LIST_GROUP, groupDAO.getAll());
        request.setAttribute(Attribute.ATTR_GROUP_ID, groupId);
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

        if (action == null) {
            response.sendRedirect("/users");
            return;
        }

        if (action.equals("action_randomize_pass")) {
            if (studentIds != null)
                for (String id : studentIds) {
                    userDAO.randomizePassword(Integer.valueOf(id));
                }

            response.sendRedirect("/users");
            return;
        } else if (action.equals("print_students")) {
            ArrayList<User> users = userDAO.getAll();

            for (Iterator<User> iterator = users.iterator(); iterator.hasNext(); ) {
                User user = iterator.next();
                Boolean wasFound = false;

                if (studentIds == null) {
                    response.sendRedirect("/users");
                    return;
                }

                for (String id : studentIds) {
                    if (user.getId().equals(Integer.valueOf(id))) {
                        wasFound = true;
                        break;
                    }
                }

                if (!wasFound)
                    iterator.remove();
            }

            request.setAttribute(Attribute.ATTR_ARRAY_LIST_USER, users);
            getServletContext().getRequestDispatcher("/print_students.jsp").forward(request, response);
        } else if (action.equals("action_delete_students")) {
            if (studentIds != null)
                for (String id : studentIds) {
                    try {
                        userDAO.delete(userDAO.getById(Integer.valueOf(id)));
                    } catch (NumberFormatException ex) {
                        ex.printStackTrace();
                    }
                }

            response.sendRedirect("/users");
            return;
        }
    }
}