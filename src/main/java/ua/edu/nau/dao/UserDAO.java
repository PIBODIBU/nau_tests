package ua.edu.nau.dao;

import com.sun.istack.internal.Nullable;

public interface UserDAO<T> extends BasicDAO<T> {
    @Nullable
    T getByCredentials(String username, String password);
}
