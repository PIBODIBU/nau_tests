package ua.edu.nau.servlet;

import org.hibernate.Session;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.UserRole;

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Session session = new AnnotationConfiguration()
                .configure("hibernate.cfg.xml")
                .buildSessionFactory()
                .openSession();

        session.beginTransaction();
        UserRole stock = new UserRole();

        stock.setRoleCode(4715);
        stock.setDescription("GENM");

        session.save(stock);
        session.getTransaction().commit();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
