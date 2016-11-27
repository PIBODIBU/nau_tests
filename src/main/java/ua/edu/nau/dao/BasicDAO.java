package ua.edu.nau.dao;

import java.util.ArrayList;

public interface BasicDAO<T> {
    ArrayList<T> getAll();

    T get();

    T getById(Integer id);

    void update(T newModel);

    void delete(T model);
}