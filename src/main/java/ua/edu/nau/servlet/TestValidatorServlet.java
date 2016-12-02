package ua.edu.nau.servlet;

import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.TestDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.Answer;
import ua.edu.nau.model.Question;
import ua.edu.nau.model.Test;
import ua.edu.nau.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Iterator;

@WebServlet(urlPatterns = {"/tests/validator"})
public class TestValidatorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TestDAO testDAO = new TestDAOImpl();
        UserDAO userDAO = new UserDAOImpl();
        User user;
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        Integer testId = Integer.valueOf(request.getParameter(Parameter.PARAM_TEST_ID));
        Integer correctAnswers = 0;
        Integer answersCount = 0;

        Test test = testDAO.getById(testId);
        answersCount = test.getQuestions().size();
        user = userDAO.getById(sessionUtils.getUser().getId());

        for (Question question : test.getQuestions()) {
            String[] answers = request.getParameterValues(String.valueOf(question.getId()));

            for (Answer answer : question.getAnswers()) {
                if (answer.getId().equals(Integer.valueOf(answers[0]))) {
                    if (answer.getCorrect()) {
                        correctAnswers++;
                    }
                }
            }

            /*for (String answer : answers) {
                System.out.println("Question: " + question.getText() +
                        "Marked answer id: " + answer);
            }*/
        }

        request.setAttribute(Attribute.ATTR_TEST_MODEL, test);
        request.setAttribute(Attribute.ATTR_USER_MODEL, user);
        request.setAttribute(Attribute.ATTR_ANSWERS_COUNT, answersCount);
        request.setAttribute(Attribute.ATTR_CORRECT_ANSWERS_COUNT, correctAnswers);

        getServletContext().getRequestDispatcher("/test_result.jsp").forward(request, response);
    }
}
