package ua.edu.nau.dao.impl;

import org.hibernate.Session;
import ua.edu.nau.dao.QuestionDAO;
import ua.edu.nau.hibernate.HibernateUtil;
import ua.edu.nau.model.Question;

import java.util.ArrayList;

public class QuestionDAOImpl extends BasicDAOImpl<Question> implements QuestionDAO {
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
        Session session = HibernateUtil.getSession();

        session.beginTransaction();
        Question question = ((Question) session.get(Question.class, id));
        session.refresh(question);
        session.getTransaction().commit();

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
