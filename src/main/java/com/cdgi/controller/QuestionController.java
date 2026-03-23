package com.cdgi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cdgi.dao.QuestionDao;
import com.cdgi.dao.QuizDao;
import com.cdgi.pojo.Question;
import com.cdgi.pojo.Quiz;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class QuestionController {

  
    @Autowired
    private QuizDao quizDao;

    @Autowired
    private QuestionDao questionDao;

    
	
	  // ==================== QUESTION MANAGEMENT (ADMIN) ====================

	    @GetMapping("/questionManagement")
	    public String questionManagement(HttpServletRequest request, HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";
	        List<Quiz> quizzes = quizDao.getAllQuiz();  
	        request.setAttribute("quizzes", quizzes);  
	        return "questionManagement";
	    }

	    @GetMapping("/addQuestion")
	    public String showAddQuestion(
	            @RequestParam(value="quizId", required=false) Integer quizId, 
	            HttpServletRequest request,
	            HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";
	        if(quizId != null) request.setAttribute("quizId", quizId); 
	        return "addQuestion";
	    }

	
	    @PostMapping("/addQuestion")
	    public String addQuestion(
	            @RequestParam("quizId") int quizId,
	            @RequestParam("question") String questionText,
	            @RequestParam("optionA") String optionA,
	            @RequestParam("optionB") String optionB,
	            @RequestParam("optionC") String optionC,
	            @RequestParam("optionD") String optionD,
	            @RequestParam("answer") String answer,
	            HttpServletRequest request) {

	        Question q = new Question();
	        q.setQuizId(quizId);
	        q.setQuestion(questionText);
	        q.setOptionA(optionA);
	        q.setOptionB(optionB);
	        q.setOptionC(optionC);
	        q.setOptionD(optionD);
	        q.setAnswer(answer);

	        boolean result = questionDao.addQuestion(q);
	        if (result) {
	            request.setAttribute("msg", "Question Added Successfully!");
	        } else {
	            request.setAttribute("msg", "Error adding question!");
	        }
	        return "addQuestion";
	    }
	    
	    @GetMapping("/updateQuestionPage")
	    public String updateQuestionPage(
	            @RequestParam("quizId") int quizId,
	            HttpServletRequest request,
	            HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";
	        List<Question> questions = questionDao.getQuestionByQuiz(quizId);
	        request.setAttribute("questions", questions);
	        request.setAttribute("quizId", quizId);
	        return "updateQuestion";
	    }

	    @PostMapping("/updateQuestion")
	    public String updateQuestion(
	            @RequestParam("id") int id,
	            @RequestParam("quizId") int quizId,
	            @RequestParam("question") String questionText,
	            @RequestParam("optionA") String optionA,
	            @RequestParam("optionB") String optionB,
	            @RequestParam("optionC") String optionC,
	            @RequestParam("optionD") String optionD,
	            @RequestParam("answer") String answer,
	            HttpServletRequest request) {
	        Question q = new Question();
	        q.setId(id);
	        q.setQuizId(quizId);
	        q.setQuestion(questionText);
	        q.setOptionA(optionA);
	        q.setOptionB(optionB);
	        q.setOptionC(optionC);
	        q.setOptionD(optionD);
	        q.setAnswer(answer);
	        boolean result = questionDao.updateQuestion(q);
	        List<Question> questions = questionDao.getQuestionByQuiz(quizId);
	        request.setAttribute("questions", questions);
	        request.setAttribute("quizId", quizId);
	        request.setAttribute("msg", result ? "Updated Successfully!" : "Update Failed!");
	        return "updateQuestion";
	    }

	    @GetMapping("/deleteQuestionPage")
	    public String deleteQuestionPage(
	            @RequestParam("quizId") int quizId,
	            HttpServletRequest request,
	            HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";
	        List<Question> questions = questionDao.getQuestionByQuiz(quizId);
	        request.setAttribute("questions", questions);
	        request.setAttribute("quizId", quizId);
	        return "deleteQuestion";
	    }

	    @GetMapping("/deleteQuestionById")
	    public String deleteQuestionById(
	            @RequestParam("id") int id,
	            @RequestParam("quizId") int quizId,
	            HttpServletRequest request,
	            HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";
	        questionDao.deleteQuestion(id);
	        List<Question> questions = questionDao.getQuestionByQuiz(quizId);
	        request.setAttribute("questions", questions);
	        request.setAttribute("quizId", quizId);
	        request.setAttribute("msg", "Question Deleted Successfully!");
	        return "deleteQuestion";
	    }

	
}
