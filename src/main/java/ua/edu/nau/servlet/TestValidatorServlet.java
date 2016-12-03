package ua.edu.nau.servlet;

import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.TestSessionDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.TestDAOImpl;
import ua.edu.nau.dao.impl.TestSessionDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.TestSessionValidator;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.session.SessionUtils;
import ua.edu.nau.model.*;

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
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        TestDAO testDAO = new TestDAOImpl();
        UserDAO userDAO = new UserDAOImpl();
        TestSessionDAO testSessionDAO = new TestSessionDAOImpl();
        TestSession testSession;
        User user;
        Test test;
        Integer testId = Integer.valueOf(request.getParameter(Parameter.PARAM_TEST_ID));
        Integer testSessionId = Integer.valueOf(request.getParameter(Parameter.PARAM_TEST_SESSION_ID));
        Integer correctAnswers = 0;
        Integer answersCount = 0;

        testSession = testSessionDAO.getById(testSessionId);
        test = testDAO.getById(testId);

        if (testSession.getDone()) {
            response.sendRedirect("/tests/sessions");
            return;
        }

        if (TestSessionValidator.isTimeUp(testSession, test)) {
            response.sendRedirect("/tests/sessions");
            return;
        }

        answersCount = test.getQuestions().size();
        user = userDAO.getById(sessionUtils.getUser().getId());

        testSession.setDone(true);
        testSessionDAO.update(testSession);


        for (Question question : test.getQuestions()) {
            String[] answers = request.getParameterValues(String.valueOf(question.getId()));

            for (Answer answer : question.getAnswers()) {
                if (answer.getId().equals(Integer.valueOf(answers[0]))) {
                    if (answer.getCorrect()) {
                        correctAnswers++;
                    }
                }
            }
        }

        testSession.setCorrectAnswers(correctAnswers);
        testSessionDAO.update(testSession);

        request.setAttribute(Attribute.ATTR_TEST_MODEL, test);
        request.setAttribute(Attribute.ATTR_USER_MODEL, user);
        request.setAttribute(Attribute.ATTR_ANSWERS_COUNT, answersCount);
        request.setAttribute(Attribute.ATTR_CORRECT_ANSWERS_COUNT, correctAnswers);

        getServletContext().getRequestDispatcher("/test_result.jsp").forward(request, response);
    }
}
