package com.cdgi.pojo;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;


@Entity
public class Question {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int id;

private int quizId;

private String question;

private String optionA;
private String optionB;
private String optionC;
private String optionD;

private String answer;

public int getId() {
return id;
}

public void setId(int id) {
this.id = id;
}

public int getQuizId() {
return quizId;
}

public void setQuizId(int quizId) {
this.quizId = quizId;
}

public String getQuestion() {
return question;
}

public void setQuestion(String question) {
this.question = question;
}

public String getOptionA() {
return optionA;
}

public void setOptionA(String optionA) {
this.optionA = optionA;
}

public String getOptionB() {
return optionB;
}

public void setOptionB(String optionB) {
this.optionB = optionB;
}

public String getOptionC() {
return optionC;
}

public void setOptionC(String optionC) {
this.optionC = optionC;
}

public String getOptionD() {
return optionD;
}

public void setOptionD(String optionD) {
this.optionD = optionD;
}

public String getAnswer() {
return answer;
}

public void setAnswer(String answer) {
this.answer = answer;
}

}