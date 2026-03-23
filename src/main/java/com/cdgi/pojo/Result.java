package com.cdgi.pojo;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="result")
public class Result {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String email;

    private int score;

    
    private int quizid;

    public int getQuizid() {
        return quizid;
    }
    public void setQuizid(int quizid) {
        this.quizid = quizid;
    }
    
    
    public Result() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
   
    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }
}