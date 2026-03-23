package com.cdgi.daoimpl;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.cdgi.dao.QuestionDao;
import com.cdgi.pojo.Question;
import com.cdgi.repository.QuestionRepository;

@Repository
@Transactional
public class QuestionDaoImpl implements QuestionDao {

    @Autowired
    private QuestionRepository questionRepository;

    @Override
    public boolean addQuestion(Question q) {
        try {
            Optional<Question> op = questionRepository.findById(q.getId());
            if (op.isPresent()) {
                return false;
            } else {
                questionRepository.save(q);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateQuestion(Question q) {
        try {
            Optional<Question> op = questionRepository.findById(q.getId());
            if (op.isPresent()) {
                questionRepository.save(q);
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteQuestion(int questionId) {
        try {
            // ✅ FIX: naya object nahi, parameter wala id use karo
            Optional<Question> op = questionRepository.findById(questionId);
            if (op.isPresent()) {
                questionRepository.deleteById(questionId);
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Question> getQuestionByQuiz(int quizId) {
        try {
            // ✅ FIX: findAll() → findByQuizId()
            List<Question> lst = questionRepository.findByQuizId(quizId);
            return lst;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}