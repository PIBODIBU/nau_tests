package ua.edu.nau.servlet;

import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.impl.TestDAOImpl;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.model.Question;
import ua.edu.nau.model.Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/tests/validator"})
public class TestValidatorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TestDAO testDAO = new TestDAOImpl();
        Integer testId = Integer.valueOf(request.getParameter(Parameter.PARAM_TEST_ID));

        Test test = testDAO.getById(testId);

        for (Question question : test.getQuestions()) {
            String[] answers = request.getParameterValues(String.valueOf(question.getId()));

            for (String answer : answers) {
                System.out.println("Question: " + question.getText() +
                        "Marked answer id: " + answer);
            }
        }
    }
}
