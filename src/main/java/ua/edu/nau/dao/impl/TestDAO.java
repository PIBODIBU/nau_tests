package ua.edu.nau.dao.impl;

import ua.edu.nau.dao.BasicDAO;
import ua.edu.nau.model.User;

import java.util.ArrayList;

public interface TestDAO<T> extends BasicDAO<T> {
    ArrayList<T> getUserTests(User owner);
}
