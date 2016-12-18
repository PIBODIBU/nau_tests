package ua.edu.nau.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/structure")
public class HelloWorldController {
    @RequestMapping("/groups")
    public ModelAndView helloWorld() {
        String message = "QWERTY";
        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName("hello.jsp");
        modelAndView.addObject("message", message);

        return modelAndView;
    }
}