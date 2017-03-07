package ua.edu.nau.dao;

import org.hibernate.SessionFactory;

import java.util.ArrayList;

public interface GenericDAO<T> {
    ArrayList<T> getAll();

    ArrayList<String> getAllAsJson();

    T get(Integer id);

    T getById(Integer id);

    Integer insert(T model);

    void update(T model);

    void delete(T model);

    void insertOrUpdate(T model);
}
