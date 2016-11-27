package ua.edu.nau.servlet;

import org.hibernate.Session;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;
import org.hibernate.type.IntegerType;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.User;
import ua.edu.nau.model.UserRole;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(urlPatterns = {"/users"})
public class UserServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();

        ArrayList<User> users = ((ArrayList<User>) session.createCriteria(User.class).list());

        request.setAttribute("users", users);

        /*User newUser = new User();

        UserRole userRole = ((UserRole) session.get(UserRole.class, 1));

        newUser.setName("name2");
        newUser.setUsername("username2");
        newUser.setPassword("password2");
        newUser.setEmail("email2");
        newUser.setUserRole(userRole);

        Integer newUserPosition = (Integer) session.save(newUser);
        session.getTransaction().commit();

        User user = (User) session.get(User.class, newUserPosition);
        request.setAttribute("user", user);*/

        getServletContext().getRequestDispatcher("/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}