package com.cdgi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cdgi.dao.QuestionDao;
import com.cdgi.dao.QuizDao;
import com.cdgi.dao.ResultDao;
import com.cdgi.pojo.Question;
import com.cdgi.pojo.Quiz;
import com.cdgi.pojo.Result;
import com.cdgi.pojo.UserInfo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class QuizController {


	    @Autowired
	    private QuizDao quizDao;

	    @Autowired
	    private ResultDao resultDao;
	    
	    @Autowired
	    private QuestionDao questionDao;

	    // ==================== QUIZ MANAGEMENT (ADMIN) ====================

	
	    @GetMapping("/addQuiz")
	    public String showAddQuiz(HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";
	        return "addQuiz";
	    }

	  
	    @GetMapping("/addQuizPage")
	    public String addQuizPage() {
	        return "addQuiz";
	    }

	    @PostMapping("/addQuiz")
	    public String addQuiz(@RequestParam("quizName") String name,
	                          @RequestParam("marks") int marks,
	                          @RequestParam("duration") int duration,
	                          @RequestParam("quizType") String quizType,
	                          @RequestParam(value = "quizPrice", defaultValue = "0") double quizPrice,
	                          Model m) {
	try
	{
		

	        Quiz q = new Quiz();

	        q.setQuizName(name);
	        q.setMarks(marks);
	        q.setDuration(duration);
	        q.setQuizType(quizType);
	        q.setQuizPrice(quizPrice);

	        quizDao.addQuiz(q);

	        m.addAttribute("msg","Quiz Added Successfully");
	}
	catch(Exception e) {
	    m.addAttribute("msg","Quiz Could not be Added ");

	}
	        return "addQuiz";
	    }

	   
	    @GetMapping("/updateQuiz")
	    public String showUpdateQuiz(HttpServletRequest request, HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";
	        List<Quiz> quizzes = quizDao.getAllQuiz();
	        request.setAttribute("quizzes", quizzes);
	        return "updateQuiz";
	    }
	    
	  
	    @PostMapping("/updateQuizData")
	    public String updateQuizData(
	            @RequestParam("id") int id,
	            @RequestParam("quizName") String quizName,
	            @RequestParam(value = "marks", required = false, defaultValue = "0") int marks,
	            @RequestParam(value = "duration", required = false, defaultValue = "0") int duration,
	            HttpServletRequest request) {

	        Quiz q = new Quiz();
	        q.setId(id);
	        q.setQuizName(quizName);
	        q.setMarks(marks);
	        q.setDuration(duration);

	        boolean result = quizDao.updateQuiz(q);
	        List<Quiz> quizzes = quizDao.getAllQuiz();
	        request.setAttribute("quizzes", quizzes);

	        if (result) {
	            request.setAttribute("msg", "Quiz Updated Successfully!");
	        } else {
	            request.setAttribute("msg", "Quiz not found!");
	        }
	        return "updateQuiz";
	    }

	    @GetMapping("/deleteQuiz")
	    public String showDeleteQuiz(HttpServletRequest request, HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";
	        List<Quiz> quizzes = quizDao.getAllQuiz();
	        request.setAttribute("quizzes", quizzes);
	        return "deleteQuiz";
	    }

	    @PostMapping("/deleteQuizData")
	    public String deleteQuizData(
	            @RequestParam("id") int id,
	            HttpServletRequest request) {

	        boolean result = quizDao.deleteQuiz(id);
	        List<Quiz> quizzes = quizDao.getAllQuiz();
	        request.setAttribute("quizzes", quizzes);

	        if (result) {
	            request.setAttribute("msg", "Quiz Deleted Successfully!");
	        } else {
	            request.setAttribute("msg", "Quiz not found!");
	        }
	        return "deleteQuiz";
	    }

	    @GetMapping("/getAllQuizes")
	    public String getAllQuizes(HttpServletRequest request, HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";
	        List<Quiz> quizlist = quizDao.getAllQuiz();
	        request.setAttribute("quizlist", quizlist);
	        return "getAllQuizes";
	    }
	    
	    @GetMapping("/searchQuizes")
	    public String searchQuizes(HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";
	        return "searchQuizes";
	    }
	    
	    
	    
	    @PostMapping("/submitQuiz")
	    public String submitQuiz(HttpServletRequest request, HttpSession session) {
	        if (session.getAttribute("User") == null) return "login";

	        int quizId = Integer.parseInt(request.getParameter("quizId"));
	        List<Question> questions = questionDao.getQuestionByQuiz(quizId);
	        
	        Quiz quiz = quizDao.getQuizById(quizId);
	        int totalMarks = quiz.getMarks();
	        int totalQuestions = questions.size();
	        
	        double marksPerQuestion = (double) totalMarks / totalQuestions;

	        int correctAnswers = 0;
	        for (Question q : questions) {
	            String selected = request.getParameter("q" + q.getId());
	            if (selected != null && selected.equalsIgnoreCase(q.getAnswer())) {
	                correctAnswers++;
	            }
	        }

	        
	        int score = (int) Math.round(correctAnswers * marksPerQuestion);

	        UserInfo user = (UserInfo) session.getAttribute("User");
	        Result result = new Result();
	        result.setEmail(user.getEmail());
	        result.setQuizid(quizId);
	        result.setScore(score);
	        resultDao.saveResult(result);
	        MailSender.sendMailForQuizResult(user, score, questions.size(), quizId);

	        request.setAttribute("score", score);
	        request.setAttribute("total", totalMarks); 
	        request.setAttribute("quizId", quizId);

	        return "quizResult";
	    }
	
}
