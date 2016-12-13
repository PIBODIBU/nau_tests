package ua.edu.nau.servlet;

import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = {"/h/xml/*"})
public class HibernateXMLServlet extends HttpServlet {
    private PrintWriter printWriter;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        printWriter = response.getWriter();

        Configuration configuration = new AnnotationConfiguration();
        configuration.configure("/hibernate.cfg.xml");

        printWriter.println(configuration.getProperty("hibernate.connection.url"));

//        getServletContext().getRequestDispatcher("/hibernate_xml.jsp").forward(request, response);
    }
}

