package com.cdgi.pojo;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Quiz {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String quizName;
    private int marks;
    private int duration;
    private String quizType;
    private double quizPrice;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQuizName() {
        return quizName;
    }

    public void setQuizName(String quizName) {
        this.quizName = quizName;
    }

    public int getMarks() {
        return marks;
    }

    public void setMarks(int marks) {
        this.marks = marks;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }
    
    public String getQuizType() {
		return quizType;
	}
    
    	public void setQuizType(String quizType) {
		this.quizType = quizType;
	}

		public double getQuizPrice() {
			return quizPrice;
		}

		public void setQuizPrice(double quizPrice) {
			this.quizPrice = quizPrice;
		}
    	
}