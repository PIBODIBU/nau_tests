package ua.edu.nau.dao;

import ua.edu.nau.model.TestSession;

import java.util.ArrayList;

public interface TestSessionDAO extends BasicDAO<TestSession> {
    ArrayList<TestSession> getUserSessions(Integer userId);
}
