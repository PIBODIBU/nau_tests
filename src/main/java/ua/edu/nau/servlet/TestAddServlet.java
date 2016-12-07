package ua.edu.nau.servlet;

import ua.edu.nau.dao.AnswerDAO;
import ua.edu.nau.dao.QuestionDAO;
import ua.edu.nau.dao.TestDAO;
import ua.edu.nau.dao.UserDAO;
import ua.edu.nau.dao.impl.AnswerDAOImpl;
import ua.edu.nau.dao.impl.QuestionDAOImpl;
import ua.edu.nau.dao.impl.TestDAOImpl;
import ua.edu.nau.dao.impl.UserDAOImpl;
import ua.edu.nau.helper.constant.Attribute;
import ua.edu.nau.helper.constant.Parameter;
import ua.edu.nau.helper.constant.RoleCode;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(urlPatterns = {"/tests/add"})
public class TestAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());
        UserDAO userDAO = new UserDAOImpl();

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return;
        }

        request.setAttribute(Attribute.ATTR_USER_MODEL, userDAO.getById(sessionUtils.getUser().getId()));

        getServletContext().getRequestDispatcher("/test_add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionUtils sessionUtils = new SessionUtils(request.getSession());

        String testName, testDescription, testTime;

        TestDAO testDAO = new TestDAOImpl();
        QuestionDAO questionDAO = new QuestionDAOImpl();
        AnswerDAO answerDAO = new AnswerDAOImpl();
        UserDAO userDAO = new UserDAOImpl();

        Test test;
        User user;
        Question questionModel;
        Answer answerModel;

        if (!sessionUtils.isUserLoggedIn()) {
            response.sendRedirect("/login");
            return;
        }

        if (sessionUtils.getUserAccessLevel().equals(RoleCode.STUDENT)) {
            response.sendRedirect("/me");
            return;
        }

        Integer questionsCount = Integer.valueOf(request.getParameter(Parameter.PARAM_ANSWER_COUNT));
        testName = request.getParameter(Parameter.PARAM_TEST_NAME);
        testDescription = request.getParameter(Parameter.PARAM_TEST_DESCRIPTION);
        testTime = request.getParameter(Parameter.PARAM_TEST_TIME);

        user = userDAO.getById(sessionUtils.getUser().getId());

        test = new Test();
        test.setName(testName);
        test.setDescription(testDescription);
        test.setTime(createDateFromString(testTime));
        test.setOwner(user);

        testDAO.insert(test);

        for (int qCounter = 1; qCounter <= questionsCount; qCounter++) {
            questionModel = new Question();

            // Question text
            String questionText = request.getParameter(Parameter.PARAM_QUESTION_TEXT + String.valueOf(qCounter));
            String questionImgUrl = request.getParameter(Parameter.PARAM_QUESTION_IMAGE_URL + String.valueOf(qCounter));
            if (questionText != null && questionImgUrl != null) {
                questionModel.setText(questionText);
                questionModel.setImgUrl(questionImgUrl);
                questionModel.setTest(test);

                questionDAO.insert(questionModel);
            }

            // Correct answer
            String correctAnswer =
                    request.getParameter(Parameter.PARAM_ANSWER_IS_CORRECT + String.valueOf(qCounter));

            // Answers
            String[] answers = request.getParameterValues(Parameter.PARAM_ANSWER_TEXT + String.valueOf(qCounter));
            if (answers != null)
                for (int i = 0; i < answers.length; i++) {
                    answerModel = new Answer();

                    answerModel.setText(answers[i]);
                    answerModel.setQuestion(questionModel);

                    if (i == Integer.valueOf(correctAnswer) - 1) {
                        // Answer is correct
                        answerModel.setCorrect(true);
                    } else {
                        // Common answer
                        answerModel.setCorrect(false);
                    }

                    answerDAO.insert(answerModel);
                }
        }

        response.sendRedirect("/me/tests");
    }

    private Date createDateFromString(String timeString) {
        timeString = "00:" + timeString + ":00";
        SimpleDateFormat dateFormat = new SimpleDateFormat("kk:mm:ss");

        try {
            return dateFormat.parse(timeString);
        } catch (ParseException e) {
            e.printStackTrace();
            return new Date();
        }
    }
}