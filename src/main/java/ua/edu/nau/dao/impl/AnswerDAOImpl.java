package ua.edu.nau.dao.impl;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import ua.edu.nau.dao.AnswerDAO;
import ua.edu.nau.model.Answer;

import java.util.ArrayList;

public class AnswerDAOImpl extends GenericDAOImpl<Answer> implements AnswerDAO {
    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public ArrayList<Answer> getAll() {
        return null;
    }

    @Override
    public Answer get(Integer id) {
        return null;
    }

    @Override
    public Answer getById(Integer id) {
        return null;
    }

    @Override
    public void update(Answer model) {

    }

    @Override
    public void delete(Answer model) {

    }
}
