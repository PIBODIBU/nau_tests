package ua.edu.nau.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ua.edu.nau.dao.GroupDAO;
import ua.edu.nau.dao.InstituteDAO;
import ua.edu.nau.dao.impl.GroupDAOImpl;
import ua.edu.nau.dao.impl.InstituteDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.hibernate.*;
import ua.edu.nau.model.UniversityStructure.Department;
import ua.edu.nau.model.UniversityStructure.Group;
import ua.edu.nau.model.UniversityStructure.Institute;
import ua.edu.nau.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/calendar"})
public class DemoCalendarServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GroupDAO groupDAO = new GroupDAOImpl();
        InstituteDAO instituteDAO = new InstituteDAOImpl();

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(Department.class, new DepartmentSerializer())
                .registerTypeAdapter(Group.class, new GroupSerializer())
                .registerTypeAdapter(Institute.class, new InstituteSerializer())
                .registerTypeAdapter(User.class, new UserSerializer())
                .create();

        request.setAttribute("json", gson.toJson(instituteDAO.getAll()));
        request.setAttribute(Attribute.ATTR_ARRAY_LIST_INSTITUTE, instituteDAO.getAll());
        getServletContext().getRequestDispatcher("/demo-calendar.jsp").forward(request, response);
    }
}
