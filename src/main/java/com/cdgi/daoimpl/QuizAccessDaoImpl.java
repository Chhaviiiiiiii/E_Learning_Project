package com.cdgi.daoimpl;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cdgi.dao.QuizAccessDao;
import com.cdgi.pojo.QuizAccess;
import com.cdgi.repository.QuizAccessRepository;

@Repository
@Transactional
public class QuizAccessDaoImpl implements QuizAccessDao {

    private static final int ACCESS_MONTHS = 1; // 1 month validity

    @Autowired
    private QuizAccessRepository quizAccessRepository;

    @Override
    public boolean saveAccess(String userEmail, int quizId) {
        try {
            LocalDate today = LocalDate.now();
            Optional<QuizAccess> existing = quizAccessRepository.findByUserEmailAndQuizId(userEmail, quizId);

            QuizAccess access;
            if (existing.isPresent()) {
                // Renew: reset payment date and extend expiry
                access = existing.get();
                access.setPaymentDate(today);
                access.setExpiryDate(today.plusMonths(ACCESS_MONTHS));
            } else {
                access = new QuizAccess(userEmail, quizId, today, today.plusMonths(ACCESS_MONTHS));
            }

            quizAccessRepository.save(access);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean hasValidAccess(String userEmail, int quizId) {
        try {
            Optional<QuizAccess> opt = quizAccessRepository.findByUserEmailAndQuizId(userEmail, quizId);
            if (opt.isPresent()) {
                // Valid if expiry date is today or in the future
                return !opt.get().getExpiryDate().isBefore(LocalDate.now());
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public LocalDate getExpiryDate(String userEmail, int quizId) {
        try {
            Optional<QuizAccess> opt = quizAccessRepository.findByUserEmailAndQuizId(userEmail, quizId);
            return opt.map(QuizAccess::getExpiryDate).orElse(null);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
