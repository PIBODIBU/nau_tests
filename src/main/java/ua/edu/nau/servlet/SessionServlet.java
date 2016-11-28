package ua.edu.nau.servlet;

import org.hibernate.Criteria;
import org.hibernate.StatelessSession;
import org.hibernate.criterion.Restrictions;
import ua.edu.nau.dao.SessionDAO;
import ua.edu.nau.dao.impl.SessionDAOImpl;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.Session;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/sessions"})
public class SessionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

        if (true) {
            getServletContext().getRequestDispatcher("/bad_session.jsp").forward(request, resp);
            return;
        }

        SessionDAO<Session> sessionDAO = new SessionDAOImpl<Session>();

        request.setAttribute("sessions", sessionDAO.getAll());

        getServletContext().getRequestDispatcher("/sessions.jsp").forward(request, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Override
    public void destroy() {
        HibernateUtil.shutdown();
        super.destroy();
    }
}
