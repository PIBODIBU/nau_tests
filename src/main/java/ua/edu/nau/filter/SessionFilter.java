package ua.edu.nau.filter;

import ua.edu.nau.dao.SessionDAO;
import ua.edu.nau.dao.impl.SessionDAOImpl;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.Session;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//@WebFilter(urlPatterns = {"/*"})
public class SessionFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest servletRequest = ((HttpServletRequest) request);
        HttpServletResponse servletResponse = ((HttpServletResponse) response);

        SessionUtils sessionUtils = new SessionUtils(servletRequest.getSession());

        SessionDAO<Session> sessionDAO = new SessionDAOImpl<>();
        Session session = sessionDAO.getByToken(sessionUtils.getSessionToken());

        if (session == null) {
            System.out.println("Can't get session");
            return;
        }


    }

    @Override
    public void destroy() {

    }
}
