package ua.edu.nau.dao;

public interface SessionDAO<T> extends BasicDAO<T> {
    T getByToken(String token);
}
