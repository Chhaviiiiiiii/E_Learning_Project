package com.cdgi.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cdgi.dao.QuestionDao;
import com.cdgi.dao.QuizAccessDao;
import com.cdgi.dao.QuizDao;
import com.cdgi.dao.ResultDao;
import com.cdgi.dao.UserInfoDao;
import com.cdgi.pojo.Question;
import com.cdgi.pojo.Quiz;
import com.cdgi.pojo.Result;
import com.cdgi.pojo.UserInfo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@Controller

public class LoginController {

    @Autowired
    private UserInfoDao userInfoDao;

    @Autowired
    private QuizDao quizDao;

    @Autowired
    private QuestionDao questionDao;

    @Autowired
    private ResultDao resultDao;

    @Autowired
    private QuizAccessDao quizAccessDao;

    // ==================== HOME / INDEX ====================

    @GetMapping("/")
    public String home() {
        return "index";
    }

    // ==================== REGISTRATION ====================

   
    @GetMapping("/reg")
    public String addNewUser() {
        return "reg";
    }

    
    @PostMapping("/addNewUser")
    public String addNewUser(

            @RequestParam("username") String username,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam("dob") String dob,
            @RequestParam("gender") String gender,
            @RequestParam("education") String education,
            @RequestParam("state") String state,
            @RequestParam("country") String country,
            @RequestParam("address") String address,
            @RequestParam("password") String password,
            @RequestParam("dp") MultipartFile dpFile,
            HttpServletRequest request) {

        UserInfo u = new UserInfo();
        u.setUsername(username);
        u.setEmail(email);
        u.setPhone(phone);
        u.setDob(dob);
        u.setGender(gender);
        u.setEducation(education);
        u.setState(state);
        u.setCountry(country);
        u.setAddress(address);
        u.setPassword(password);
        u.setRole("USER");

       
        if (!dpFile.isEmpty()) {

            String uploadDir = request.getServletContext().getRealPath("/resources/dp/");
            File dir = new File(uploadDir);

            if (!dir.exists()) {
                dir.mkdirs();
            }

            String fileName = dpFile.getOriginalFilename();

            try {

                File saveFile = new File(uploadDir + File.separator + fileName);
                dpFile.transferTo(saveFile);

                u.setDp(fileName);

            } catch (IOException e) {
                e.printStackTrace();
                u.setDp("default.png");
            }

        } else {
            u.setDp("default.png");
        }

        boolean result = userInfoDao.addNewUser(u);

        if (result) {
        	MailSender.sendMailForRegistration(u);
            request.setAttribute("msg", "Registration Successful! Please Login.");
            return "login";

        } else {

            request.setAttribute("msg", "Email already registered! Try another.");
            return "reg";
        }
    }



    // ==================== LOGIN / LOGOUT ====================

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

   
    @PostMapping("/checkUser")
    public String checkUser(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            HttpServletRequest request)
    {
        System.out.println(email + "----------- " + password);
        HttpSession session = request.getSession(false);
        UserInfo u = new UserInfo();
        u.setEmail(email);
        u.setPassword(password);

        UserInfo loggedUser = userInfoDao.checkUserCredential(u);

        if (loggedUser != null) {

           
            if (!loggedUser.isActive()) {
                request.setAttribute("msg", "Your account has been blocked! Contact admin.");
                return "login";
            }

            session.setAttribute("User", loggedUser);

            if ("ADMIN".equalsIgnoreCase(loggedUser.getRole())) {
                return "redirect:/adminhome";
            } else {
                return "redirect:/customerhome";
            }
        } else {
            request.setAttribute("msg", "Invalid email or password!");
            return "login";
        }
    }

    
    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }
    // ==================== ADMIN HOME ====================

    @GetMapping("/adminhome")
    public String adminHome(HttpServletRequest request) {
        return "adminhome";
    }

    // ==================== CUSTOMER HOME ====================

    @GetMapping("/customerhome")
    public String customerHome(HttpSession session) {
        UserInfo user = (UserInfo) session.getAttribute("User");
        if (user == null) return "login";
        return "customerhome";
    }

   
  
    // ==================== STUDENT MANAGEMENT (ADMIN) ====================

    // GET - Get All Students
    @GetMapping("/getAllStudents")
    public String getAllStudents(HttpServletRequest request, HttpSession session) {
        if (session.getAttribute("User") != null) 
        {
        	
        	List<UserInfo> students = userInfoDao.getAllUsers();
			request.setAttribute("students", students);
			return "getAllStudents";
		}
		else
		{
			return "login";
        }
  
    }

    @GetMapping("/blockStudent")
    public String blockStudent(
            @RequestParam("username") String username,
            HttpServletRequest request,
            HttpSession session) {
        if (session.getAttribute("User") == null) return "login";
        
        UserInfo user = userInfoDao.getUserByUsername(username);
        user.setActive(false);
        userInfoDao.addNewUser(user);
        
        List<UserInfo> students = userInfoDao.getAllUsers();
        request.setAttribute("students", students);
        request.setAttribute("msg", username + " has been Blocked! 🚫");
        return "getAllStudents";
    }

    @GetMapping("/unblockStudent")
    public String unblockStudent(
            @RequestParam("username") String username,
            HttpServletRequest request,
            HttpSession session) {
        if (session.getAttribute("User") == null) return "login";
        
        UserInfo user = userInfoDao.getUserByUsername(username);
        user.setActive(true);
        userInfoDao.addNewUser(user);
        
        List<UserInfo> students = userInfoDao.getAllUsers();
        request.setAttribute("students", students);
        request.setAttribute("msg", username + " has been Unblocked! ✅");
        return "getAllStudents";
    }

    // ==================== STUDENT PROFILE ====================

    @GetMapping("/studentProfile")
    public String studentProfile(HttpServletRequest request, HttpSession session) {
        if (session.getAttribute("User") == null) return "login";
        UserInfo user = (UserInfo) session.getAttribute("User");
        request.setAttribute("user", user);
        return "studentProfile";
    }
    
    
    ////admin panel pr student profile view krne k liye
    @GetMapping("/adminShowStudentProfile")
    public String adminShowStudentProfile(HttpServletRequest request, HttpSession session) {
        UserInfo user = (UserInfo) session.getAttribute("User");
        request.setAttribute("user", user);
        return "adminShowStudentProfile";
    }

    @GetMapping("/editProfile")
    public String showEditProfile(HttpServletRequest request, HttpSession session) {
        if (session.getAttribute("User") == null) return "login";
        UserInfo user = (UserInfo) session.getAttribute("User");
        request.setAttribute("user", user);  
        return "editProfile";
    }

    @PostMapping("/updateProfile")
    public String updateProfile(
            @RequestParam("phone") String phone,
            @RequestParam("education") String education,
            @RequestParam("state") String state,
            @RequestParam("country") String country,
            @RequestParam("address") String address,
            @RequestParam("dp") MultipartFile dpFile,
            HttpServletRequest request,
            HttpSession session) {

        UserInfo user = (UserInfo) session.getAttribute("User");
        if (user == null) return "login";

      
        boolean allEmpty = (phone == null || phone.isEmpty()) &&
                           (education == null || education.isEmpty()) &&
                           (state == null || state.isEmpty()) &&
                           (country == null || country.isEmpty()) &&
                           (address == null || address.isEmpty()) &&
                           (dpFile == null || dpFile.isEmpty());

        if (allEmpty) {
            request.setAttribute("user", user);
            request.setAttribute("msg", "Please fill at least one field to update!");
            return "editProfile";
        }

       
        if(phone != null && !phone.isEmpty()) user.setPhone(phone);
        if(education != null && !education.isEmpty()) user.setEducation(education);
        if(state != null && !state.isEmpty()) user.setState(state);
        if(country != null && !country.isEmpty()) user.setCountry(country);
        if(address != null && !address.isEmpty()) user.setAddress(address);

       
        if (dpFile != null && !dpFile.isEmpty()) {
            String uploadDir = request.getServletContext().getRealPath("/resources/dp/");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            String fileName = dpFile.getOriginalFilename();
            try {
                dpFile.transferTo(new File(uploadDir + fileName));
                user.setDp(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        boolean result = userInfoDao.addNewUser(user);
        session.setAttribute("User", user);
        request.setAttribute("user", user);
        request.setAttribute("msg", result ? "Profile Updated Successfully!" : "Update Failed!");
        return "editProfile";
    }

    // ==================== QUIZ ATTEMPT (STUDENT) ====================

    @GetMapping("/seeQuizes")
    public String seeQuizes(HttpServletRequest request, HttpSession session) {
        if (session.getAttribute("User") == null) return "login";
        UserInfo user = (UserInfo) session.getAttribute("User");
        List<Quiz> quizlist = quizDao.getAllQuiz();
        request.setAttribute("quizlist", quizlist);

        // Compute which paid quizzes this user already has valid (non-expired) access to
        Set<Integer> paidQuizIds = new HashSet<>();
        Map<Integer, LocalDate> expiryMap = new HashMap<>();
        if (quizlist != null) {
            for (Quiz q : quizlist) {
                if ("Paid".equals(q.getQuizType())) {
                    if (quizAccessDao.hasValidAccess(user.getEmail(), q.getId())) {
                        paidQuizIds.add(q.getId());
                        expiryMap.put(q.getId(), quizAccessDao.getExpiryDate(user.getEmail(), q.getId()));
                    }
                }
            }
        }
        request.setAttribute("paidQuizIds", paidQuizIds);
        request.setAttribute("expiryMap", expiryMap);
        return "seeQuizes";
    }

    @PostMapping("/startQuiz")
    public String startQuiz(
            @RequestParam("quizId") int quizId,
            HttpServletRequest request,
            HttpSession session) {
        if (session.getAttribute("User") == null) return "login";
        UserInfo user = (UserInfo) session.getAttribute("User");

        Quiz quiz = quizDao.getQuizById(quizId);

        // Guard: if quiz is Paid and user has no valid access, block entry
        if (quiz != null && "Paid".equals(quiz.getQuizType())) {
            if (!quizAccessDao.hasValidAccess(user.getEmail(), quizId)) {
                request.setAttribute("msg", "Please subscribe to access this quiz.");
                List<Quiz> quizlist = quizDao.getAllQuiz();
                request.setAttribute("quizlist", quizlist);
                request.setAttribute("paidQuizIds", new HashSet<Integer>());
                request.setAttribute("expiryMap", new HashMap<Integer, LocalDate>());
                return "seeQuizes";
            }
        }

        List<Question> questions = questionDao.getQuestionByQuiz(quizId);
        request.setAttribute("questions", questions);
        request.setAttribute("quizId", quizId);
        if (quiz != null) {
            request.setAttribute("duration", quiz.getDuration());
        }
        return "attemptQuiz";
    }

    @PostMapping("/subscribe")
    public String subscribe(
            @RequestParam("quizId") int quizId,
            @RequestParam("amount") double amount,
            HttpServletRequest request,
            HttpSession session) {
        if (session.getAttribute("User") == null) return "login";

        UserInfo user = (UserInfo) session.getAttribute("User");

        // Save 1-month access record in DB
        quizAccessDao.saveAccess(user.getEmail(), quizId);

        // Send payment confirmation email
        MailSender.sendMailForPayment(user);

        // Redirect to dashboard with success message (NOT directly into quiz)
        request.setAttribute("msg", "✅ Payment successful! You now have 1-month access to this quiz. Go to 'Play Quizzes' to start.");
        return "customerhome";
    }

    // ==================== STUDENT PROGRESS ====================

    @GetMapping("/studentProgress")
    public String studentProgress(HttpServletRequest request, HttpSession session) {
        if (session.getAttribute("User") == null) return "login";

        UserInfo user = (UserInfo) session.getAttribute("User");
        List<Result> resultList = resultDao.getResultByUser(user.getEmail());
        request.setAttribute("resultList", resultList);
        return "studentProgress";
    }

    // ==================== FEEDBACK ====================

   
    @GetMapping("/feedback")
    public String showFeedback(HttpSession session) {
        if (session.getAttribute("User") == null) return "login";
        return "feedback";
    }

  
    @PostMapping("/submitFeedback")
    public String submitFeedback(
            @RequestParam("rating") String rating,
            HttpSession session) {
        if (session.getAttribute("User") == null) return "login";
        session.setAttribute("msg", "Thank you for your feedback: " + rating);
        return "feedback";
    }

    
    // ==================== Update Admin Profile ====================

    @GetMapping("/updateAdminProfile")
    public String showUpdateAdminProfile(HttpServletRequest request, HttpSession session) {
        if (session.getAttribute("User") == null) return "login";
        UserInfo user = (UserInfo) session.getAttribute("User");
        request.setAttribute("user", user);
        return "updateAdminProfile";
    }

    @PostMapping("/updateAdminProfile")
    public String updateAdminProfile(
            @RequestParam("username") String username,
            @RequestParam("phone") String phone,
            @RequestParam("dob") String dob,
            @RequestParam("gender") String gender,
            @RequestParam("education") String education,
            @RequestParam("state") String state,
            @RequestParam("country") String country,
            @RequestParam("address") String address,
            @RequestParam("dp") MultipartFile dpFile,
            HttpServletRequest request,
            HttpSession session) {

        UserInfo user = (UserInfo) session.getAttribute("User");
        if (user == null) return "login";

        boolean allEmpty = (username == null || username.isEmpty()) &&
                           (phone == null || phone.isEmpty()) &&
                           (dob == null || dob.isEmpty()) &&
                           (gender == null || gender.isEmpty()) &&
                           (education == null || education.isEmpty()) &&
                           (state == null || state.isEmpty()) &&
                           (country == null || country.isEmpty()) &&
                           (address == null || address.isEmpty()) &&
                           (dpFile == null || dpFile.isEmpty());

        if (allEmpty) {
            request.setAttribute("user", user);
            request.setAttribute("msg", "Please fill at least one field to update!");
            return "updateAdminProfile";
        }

        if(username != null && !username.isEmpty()) user.setUsername(username);
        if(phone != null && !phone.isEmpty()) user.setPhone(phone);
        if(dob != null && !dob.isEmpty()) user.setDob(dob);
        if(gender != null && !gender.isEmpty()) user.setGender(gender);
        if(education != null && !education.isEmpty()) user.setEducation(education);
        if(state != null && !state.isEmpty()) user.setState(state);
        if(country != null && !country.isEmpty()) user.setCountry(country);
        if(address != null && !address.isEmpty()) user.setAddress(address);

        if (dpFile != null && !dpFile.isEmpty()) {
            String uploadDir = request.getServletContext().getRealPath("/resources/dp/");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            String fileName = dpFile.getOriginalFilename();
            try {
                dpFile.transferTo(new File(uploadDir + fileName));
                user.setDp(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        userInfoDao.addNewUser(user);
        session.setAttribute("User", user);
        request.setAttribute("user", user);
        request.setAttribute("msg", "Profile Updated Successfully!");
        return "updateAdminProfile";
    }

}