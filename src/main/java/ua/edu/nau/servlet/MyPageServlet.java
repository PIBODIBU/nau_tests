package ua.edu.nau.servlet;

import ua.edu.nau.dao.HttpSessionDAO;
import ua.edu.nau.dao.SettingDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.HttpSessionDAOImpl;
import ua.edu.nau.dao.impl.SettingDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.TimeFormatter;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.RoleCode;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.Setting;
import ua.edu.nau.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet(urlPatterns = {"/me"})
public class MyPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        UserDAO userDAO = new UserDAOImpl();
        SettingDAO settingDAO = new SettingDAOImpl();
        HttpSessionDAO httpSessionDAO = new HttpSessionDAOImpl();
        String jspName;

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        Integer userId = sessionUtils.getUser().getId();
        User userModel = userDAO.getById(userId);
        Integer userRoleCode = userModel.getUserRole().getRoleCode();

        request.setAttribute(Attribute.ATTR_USER_MODEL, userModel);

        if (userRoleCode.equals(RoleCode.ADMIN)) {
            jspName = "/my_page.jsp";
        } else if (userRoleCode.equals(RoleCode.ROOT)) {
            jspName = "/my_page.jsp";
        } else if (userRoleCode.equals(RoleCode.STUDENT)) {
            jspName = "/my_page_student.jsp";
        } else if (userRoleCode.equals(RoleCode.MODERATOR)) {
            jspName = "/my_page.jsp";
        } else {
            response.sendRedirect("/logout");
            return;
        }

        if (userRoleCode.equals(RoleCode.STUDENT)) {
            Setting setting = settingDAO.getByName(SettingDAOImpl.SETTING_SESSION_TIME);

            Date loginTime = httpSessionDAO.getById(sessionUtils.getHttpSessionId()).getLoginTime();
            Date currentTime = new Date();
            Date remain = new Date(
                    loginTime.getTime() + TimeFormatter.minutesToMillisLong(setting.getValue()) - currentTime.getTime());

            request.setAttribute(Attribute.ATTR_DATE_SESSION_TIMER, remain);
        }

        request.setAttribute(Attribute.ATTR_USER_MODEL, userModel);

        getServletContext().getRequestDispatcher(jspName).forward(request, response);
    }
}