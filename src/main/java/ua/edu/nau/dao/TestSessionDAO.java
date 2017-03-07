package ua.edu.nau.dao;

import ua.edu.nau.model.Test;
import ua.edu.nau.model.TestSession;

import java.util.ArrayList;

public interface TestSessionDAO extends GenericDAO<TestSession> {
    ArrayList<TestSession> getUserSessions(Integer userId);

    ArrayList<TestSession> getTodayResult(Test test);
}
