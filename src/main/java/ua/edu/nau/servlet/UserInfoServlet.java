package ua.edu.nau.servlet;

import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.session.SessionUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/me"})
public class UserInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        request.setAttribute(Attribute.ATTR_USER_MODEL, sessionUtils.getUser());

        getServletContext().getRequestDispatcher("/my_page.jsp").forward(request, response);
    }
}
