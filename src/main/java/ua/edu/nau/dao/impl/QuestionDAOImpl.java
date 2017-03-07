package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import ua.edu.nau.dao.QuestionDAO;
import ua.edu.nau.model.Question;

import java.util.ArrayList;

public class QuestionDAOImpl extends GenericDAOImpl<Question> implements QuestionDAO {
    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public ArrayList<Question> getAll() {
        return super.getAll();
    }

    @Override
    public Question get(Integer id) {
        return super.get(id);
    }

    @Override
    public Question getById(Integer id) {
        Session session = sessionFactory.openSession();

        session.beginTransaction();
        Question question = ((Question) session.get(Question.class, id));
        session.refresh(question);
        session.getTransaction().commit();

        session.close();

        return question;
    }

    @Override
    public void update(Question model) {
        super.update(model);
    }

    @Override
    public void delete(Question model) {
        super.delete(model);
    }
}
