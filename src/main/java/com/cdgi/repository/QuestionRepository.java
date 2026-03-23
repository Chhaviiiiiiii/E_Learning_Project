package com.cdgi.repository;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.cdgi.pojo.Question;

public interface QuestionRepository extends JpaRepository<Question, Integer> {
    List<Question> findByQuizId(int quizId);
}