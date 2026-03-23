package com.cdgi.dao;

import java.util.List;
import com.cdgi.pojo.Question;

public interface QuestionDao {
    
    boolean addQuestion(Question q);
    
    boolean updateQuestion(Question q);
    
    boolean deleteQuestion(int questionId);
    
    List<Question> getQuestionByQuiz(int quizId);
}