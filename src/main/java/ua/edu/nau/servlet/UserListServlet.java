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
        GroupDAO groupDAO = new GroupDAOImpl();
        UserDAO userDAO = new UserDAOImpl();

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return;
        }

        fetchGroupsAndUsers(request, response);

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_GROUP, groupDAO.getAll());
        request.setAttribute(Attribute.ATTR_USER_MODEL, userDAO.getById(sessionUtils.getUser().getId()));

        getServletContext().getRequestDispatcher("/user_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        UserDAO userDAO = new UserDAOImpl();
        GroupDAO groupDAO = new GroupDAOImpl();

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
            fetchGroupsAndUsers(request, response);
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

            fetchGroupsAndUsers(request, response);
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

            fetchGroupsAndUsers(request, response);
            response.sendRedirect("/users");
            return;
        } else if (action.equals("student_search")) {
            ArrayList<User> users = new ArrayList<>();
            String studentBookNumber = request.getParameter(Parameter.PARAM_STUDENT_BOOK_NUMBER);

            if (studentBookNumber == null || studentBookNumber.equals("")) {
                return;
            }

            users.add(userDAO.getStudentByBookNumber(studentBookNumber));

            request.setAttribute(Attribute.ATTR_ARRAY_LIST_USER, users);
            request.setAttribute(Attribute.ATTR_ARRAY_LIST_GROUP, groupDAO.getAll());
            request.setAttribute(Attribute.ATTR_USER_MODEL, userDAO.getById(sessionUtils.getUser().getId()));

            getServletContext().getRequestDispatcher("/user_list.jsp").forward(request, response);
        }
    }

    private void fetchGroupsAndUsers(HttpServletRequest request, HttpServletResponse response) {
        UserDAO userDAO = new UserDAOImpl();
        GroupDAO groupDAO = new GroupDAOImpl();

        Integer[] groupIds = null;
        String[] chooseGroupsIdsAsString = null;

        try {
            chooseGroupsIdsAsString = request.getParameterValues(Parameter.PARAM_GROUP_CHOOSE_ID);
            groupIds = new Integer[chooseGroupsIdsAsString.length];
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        if (chooseGroupsIdsAsString != null && groupIds != null)
            for (int i = 0; i < chooseGroupsIdsAsString.length; i++) {
                try {
                    groupIds[i] = Integer.valueOf(chooseGroupsIdsAsString[i]);
                    System.out.println(groupIds[i]);
                } catch (NumberFormatException ex) {
                    ex.printStackTrace();
                }
            }

        // Fetching all users or users of the specified group
        ArrayList<User> users = new ArrayList<User>();
        ArrayList<Group> chooseGroups = new ArrayList<Group>();

        if (groupIds == null) {
            users.addAll(userDAO.getAll());
        } else {
            for (Integer groupId : groupIds) {
                Group group = groupDAO.getById(groupId);
                chooseGroups.add(group);
                users.addAll(group.getUsers());
            }
        }

        request.setAttribute(Attribute.ATTR_ARRAY_LIST_GROUP_CHOOSE, chooseGroups);
        request.setAttribute(Attribute.ATTR_ARRAY_LIST_GROUP_CHOOSE, chooseGroups);
        request.setAttribute(Attribute.ATTR_ARRAY_LIST_USER, users);
    }
}