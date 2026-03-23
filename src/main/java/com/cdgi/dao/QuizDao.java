package com.cdgi.dao;

import java.util.List;
import com.cdgi.pojo.Quiz;

public interface QuizDao {

    boolean addQuiz(Quiz q);

    boolean updateQuiz(Quiz q);

    boolean deleteQuiz(int id);

    List<Quiz> getAllQuiz();
    Quiz getQuizById(int id);

}