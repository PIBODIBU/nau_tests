package ua.edu.nau.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import ua.edu.nau.dao.GroupDAO;
import ua.edu.nau.dao.InstituteDAO;
import ua.edu.nau.dao.impl.GroupDAOImpl;
import ua.edu.nau.dao.impl.InstituteDAOImpl;
import ua.edu.nau.helper.hibernate.GroupSerializer;
import ua.edu.nau.helper.hibernate.InstituteSerializer;
import ua.edu.nau.model.UniversityStructure.Group;
import ua.edu.nau.model.UniversityStructure.Institute;

@Controller
@RequestMapping("/structure")
public class HelloWorldController {
    @RequestMapping("/institutes")
    public ModelAndView helloWorld() {
        ModelAndView modelAndView = new ModelAndView();
        InstituteDAO instituteDAO = new InstituteDAOImpl();

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(Institute.class, new InstituteSerializer())
                .create();

        modelAndView.setViewName("institutes.jsp");
        modelAndView.addObject("jsonData", gson.toJson(instituteDAO.getAll()));

        return modelAndView;
    }

    @RequestMapping("/groups")
    public ModelAndView listGroups() {
        ModelAndView modelAndView = new ModelAndView();
        GroupDAO groupDAO = new GroupDAOImpl();

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(Group.class, new GroupSerializer())
                .create();

        modelAndView.setViewName("groups.jsp");
        modelAndView.addObject("jsonData", gson.toJson(groupDAO.getAll()));

        return modelAndView;
    }

    @RequestMapping(value = "/institutes/{institute_id}/groups", method = RequestMethod.GET)
    public ModelAndView listInstituteGroups(@PathVariable("institute_id") Integer instituteId) {
        ModelAndView modelAndView = new ModelAndView();
        InstituteDAO instituteDAO = new InstituteDAOImpl();

        Institute institute = instituteDAO.getById(instituteId);

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(Group.class, new GroupSerializer())
                .create();

        modelAndView.setViewName("groups.jsp");
        modelAndView.addObject("jsonData", gson.toJson(institute.getGroups()));

        return modelAndView;
    }
}