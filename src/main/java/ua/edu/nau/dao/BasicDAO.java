package ua.edu.nau.dao;

import java.util.ArrayList;

public interface BasicDAO<T> {
    ArrayList<T> getAll();

    T get(Integer id);

    T getById(Integer id);

    void insert(T model);

    void update(T newModel);

    void delete(T model);
}
