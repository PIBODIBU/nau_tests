package ua.edu.nau.servlet;

import org.hibernate.Criteria;
import org.hibernate.StatelessSession;
import org.hibernate.criterion.Restrictions;
import ua.edu.nau.dao.SessionDAO;
import ua.edu.nau.dao.impl.SessionDAOImpl;
import ua.edu.nau.helper.auth.AuthUtils;
import ua.edu.nau.helper.auth.impl.AuthUtilsImpl;
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
        AuthUtils authUtils = new AuthUtilsImpl();
        Session session = authUtils.checkHttpSession(request.getSession());

        if (!SessionUtils.isSessionTokenExists(request.getSession())) {
            SessionUtils.createSessionToken(request.getSession());
        }

        String sessionId = request.getSession().getId();
        System.out.println(sessionId);
        StatelessSession hS = HibernateUtil.getSessionFactory().openStatelessSession();
        Criteria criteria = hS.createCriteria(Session.class);
        criteria.add(
                Restrictions.eq("sessionId", SessionUtils.getSessionToken(request.getSession())));
        Session ss = ((Session) criteria.list().get(0));

        System.out.println(ss.getId());

        if (session == null) {
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
