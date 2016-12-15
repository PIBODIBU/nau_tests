package ua.edu.nau.dao;

import com.sun.istack.internal.Nullable;
import ua.edu.nau.model.HttpSession;
import ua.edu.nau.model.User;

public interface UserDAO extends BasicDAO<User> {
    @Nullable
    User getByCredentials(String username, String password);

    void randomizePassword(int userId);

    HttpSession getLastSession(Integer userId);

    User getStudentByBookNumber(String bookNumber);
}
