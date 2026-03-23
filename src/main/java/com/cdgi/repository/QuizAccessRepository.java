package com.cdgi.repository;

import java.util.Optional;
import org.springframework.data.repository.CrudRepository;
import com.cdgi.pojo.QuizAccess;

public interface QuizAccessRepository extends CrudRepository<QuizAccess, Integer> {

    Optional<QuizAccess> findByUserEmailAndQuizId(String userEmail, int quizId);
}
