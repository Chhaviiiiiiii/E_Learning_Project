package com.cdgi.dao;

import java.time.LocalDate;

public interface QuizAccessDao {

    /** Save or update a payment access record for 1 month from today. */
    boolean saveAccess(String userEmail, int quizId);

    /** Returns true if the user has a non-expired access record for this quiz. */
    boolean hasValidAccess(String userEmail, int quizId);

    /** Returns the expiry date for the user's access to this quiz, or null if none. */
    LocalDate getExpiryDate(String userEmail, int quizId);
}
