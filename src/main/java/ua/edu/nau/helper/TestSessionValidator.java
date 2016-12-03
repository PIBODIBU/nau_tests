package ua.edu.nau.helper;


import ua.edu.nau.model.Test;
import ua.edu.nau.model.TestSession;

import java.util.Date;

public class TestSessionValidator {
    public static Boolean isTimeUp(TestSession testSession, Test test) {
        Date dateDeadLine = new Date(testSession.getStartTime().getTime() + test.getTime().getTime());
        Date now = new Date();

        return dateDeadLine.before(now);
    }
}
