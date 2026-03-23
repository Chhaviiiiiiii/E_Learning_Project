<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Question - Edukate Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --primary: #6c63ff; --primary-dark: #4f46e5;
            --dark: #0f172a; --sidebar-w: 260px;
            --text: #475569; --border: #e2e8f0;
            --light-bg: #f8fafc; --white: #ffffff;
            --radius: 12px; --shadow: 0 4px 20px rgba(15,23,42,0.07);
            --green: #10b981;
        }
        body { font-family: 'Inter', sans-serif; background: var(--light-bg); display: flex; min-height: 100vh; }
        a { text-decoration: none; transition: all 0.25s; }

        /* SIDEBAR */
        .sidebar { width: var(--sidebar-w); min-height: 100vh; background: var(--dark); display: flex; flex-direction: column; position: fixed; left: 0; top: 0; bottom: 0; z-index: 100; overflow-y: auto; }
        .sidebar-brand { padding: 28px 24px 24px; border-bottom: 1px solid rgba(255,255,255,0.07); display: flex; align-items: center; gap: 10px; font-family: 'Poppins', sans-serif; font-size: 1.35rem; font-weight: 800; color: #fff; }
        .sidebar-brand i { color: #818cf8; } .sidebar-brand span { color: #818cf8; }
        .sidebar-section-label { padding: 20px 24px 8px; font-size: 0.7rem; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase; color: #475569; }
        .sidebar-nav { padding: 0 12px; flex: 1; }
        .nav-item { display: flex; align-items: center; gap: 12px; padding: 11px 14px; border-radius: 8px; margin-bottom: 2px; color: #94a3b8; font-size: 0.875rem; font-weight: 500; }
        .nav-item:hover { background: rgba(255,255,255,0.06); color: #e2e8f0; }
        .nav-item.active { background: linear-gradient(135deg, rgba(108,99,255,0.25), rgba(79,70,229,0.15)); color: #a5b4fc; border-left: 3px solid #818cf8; }
        .nav-item i { width: 18px; text-align: center; font-size: 0.9rem; flex-shrink: 0; }
        .sidebar-bottom { padding: 16px 12px; border-top: 1px solid rgba(255,255,255,0.07); }
        .logout-btn { display: flex; align-items: center; gap: 12px; padding: 11px 14px; border-radius: 8px; color: #f87171; font-size: 0.875rem; font-weight: 500; width: 100%; }
        .logout-btn:hover { background: rgba(239,68,68,0.1); color: #ef4444; }

        /* MAIN */
        .main { margin-left: var(--sidebar-w); flex: 1; display: flex; flex-direction: column; }
        .topbar { background: var(--white); border-bottom: 1px solid var(--border); padding: 0 32px; height: 64px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 50; box-shadow: 0 1px 12px rgba(15,23,42,0.05); }
        .topbar-left h1 { font-size: 1.1rem; font-weight: 700; color: var(--dark); font-family: 'Poppins', sans-serif; }
        .topbar-left p  { font-size: 0.8rem; color: var(--text); margin-top: 1px; }
        .back-btn { display: flex; align-items: center; gap: 8px; padding: 8px 16px; background: var(--light-bg); border: 1px solid var(--border); border-radius: 8px; color: var(--text); font-size: 0.85rem; font-weight: 500; }
        .back-btn:hover { color: var(--primary); border-color: var(--primary); }
        .content { padding: 32px; flex: 1; }

        /* Alert */
        .alert-success { background: #f0fdf4; border: 1px solid #bbf7d0; color: #166534; padding: 13px 18px; border-radius: var(--radius); font-size: 0.88rem; display: flex; align-items: center; gap: 10px; margin-bottom: 24px; }

        /* Quiz ID badge */
        .quiz-badge { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg, rgba(108,99,255,0.1), rgba(79,70,229,0.07)); border: 1px solid rgba(108,99,255,0.2); color: var(--primary); font-size: 0.82rem; font-weight: 700; padding: 6px 14px; border-radius: 50px; margin-bottom: 28px; }
        .quiz-badge i { font-size: 0.75rem; }

        /* Form card */
        .form-card { background: var(--white); border-radius: var(--radius); border: 1px solid var(--border); box-shadow: var(--shadow); max-width: 680px; }
        .form-card-header { padding: 22px 28px; border-bottom: 1px solid var(--border); display: flex; align-items: center; gap: 14px; }
        .form-card-header .icon { width: 44px; height: 44px; background: linear-gradient(135deg, #10b981, #059669); border-radius: 10px; display: flex; align-items: center; justify-content: center; }
        .form-card-header .icon i { color: #fff; font-size: 1rem; }
        .form-card-header h2 { font-family: 'Poppins', sans-serif; font-size: 1.05rem; font-weight: 700; color: var(--dark); margin: 0; }
        .form-card-header p  { font-size: 0.78rem; color: var(--text); margin: 2px 0 0; }
        .form-body { padding: 28px; }

        /* Form fields */
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 0.82rem; font-weight: 600; color: #334155; margin-bottom: 7px; }
        .form-group input[type="text"],
        .form-group select,
        .form-group textarea { width: 100%; padding: 11px 14px; border: 1.5px solid var(--border); border-radius: 8px; font-size: 0.88rem; font-family: 'Inter', sans-serif; color: var(--dark); background: #fff; outline: none; transition: border-color 0.2s, box-shadow 0.2s; }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(108,99,255,0.1); }
        .form-group input::placeholder, .form-group textarea::placeholder { color: #94a3b8; }
        .form-group select { appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%2394a3b8' d='M1 1l5 5 5-5'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 14px center; padding-right: 36px; }

        /* Options grid — A B / C D */
        .options-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
        .option-group { position: relative; }
        .option-group .option-badge { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); width: 22px; height: 22px; border-radius: 6px; display: flex; align-items: center; justify-content: center; font-size: 0.72rem; font-weight: 800; }
        .opt-a { background: rgba(108,99,255,0.12); color: var(--primary); }
        .opt-b { background: rgba(16,185,129,0.12); color: #059669; }
        .opt-c { background: rgba(249,115,22,0.12); color: #ea580c; }
        .opt-d { background: rgba(239,68,68,0.12); color: #dc2626; }
        .option-group input { padding-left: 42px !important; }

        /* Divider */
        .divider { border: none; border-top: 1px solid var(--border); margin: 20px 0; }

        /* Answer select — styled with colour */
        .answer-select-wrap select { border-color: #bbf7d0; background-color: #f0fdf4; color: #059669; font-weight: 600; }
        .answer-select-wrap select:focus { border-color: var(--green); box-shadow: 0 0 0 3px rgba(16,185,129,0.12); }

        /* Buttons */
        .form-footer { display: flex; gap: 12px; margin-top: 8px; }
        .btn-submit { flex: 1; padding: 13px; background: linear-gradient(135deg, #10b981, #059669); color: #fff; border: none; border-radius: 10px; font-size: 0.95rem; font-weight: 600; font-family: 'Inter', sans-serif; cursor: pointer; box-shadow: 0 4px 16px rgba(16,185,129,0.3); transition: all 0.3s; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-submit:hover { background: linear-gradient(135deg, #059669, #047857); transform: translateY(-1px); }
        .btn-back { padding: 13px 22px; background: var(--white); color: var(--text); border: 1.5px solid var(--border); border-radius: 10px; font-size: 0.9rem; font-weight: 600; font-family: 'Inter', sans-serif; text-decoration: none; display: flex; align-items: center; gap: 8px; transition: all 0.2s; }
        .btn-back:hover { border-color: var(--primary); color: var(--primary); }
    </style>
</head>
<body>
<%
    UserInfo loggedUser = (UserInfo) session.getAttribute("User");
    String uname = (loggedUser != null) ? loggedUser.getUsername() : "Admin";
    Object qIdObj = request.getAttribute("quizId");
    String quizIdStr = (qIdObj != null) ? qIdObj.toString() : "";
%>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Main Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/adminhome"         class="nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/addQuiz"           class="nav-item"><i class="fa fa-plus-circle"></i> Add New Quiz</a>
        <a href="<%=request.getContextPath()%>/updateQuiz"        class="nav-item"><i class="fa fa-edit"></i> Update Quiz</a>
        <a href="<%=request.getContextPath()%>/deleteQuiz"        class="nav-item"><i class="fa fa-trash-alt"></i> Delete Quiz</a>
        <a href="<%=request.getContextPath()%>/getAllQuizes"       class="nav-item"><i class="fa fa-list"></i> All Quizzes</a>
        <a href="<%=request.getContextPath()%>/questionManagement" class="nav-item active"><i class="fa fa-question-circle"></i> Question Management</a>
        <a href="<%=request.getContextPath()%>/getAllStudents"     class="nav-item"><i class="fa fa-users"></i> Enrolled Students</a>
        <a href="<%=request.getContextPath()%>/updateAdminProfile" class="nav-item"><i class="fa fa-user-cog"></i> My Profile</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>

<!-- MAIN -->
<div class="main">
    <div class="topbar">
        <div class="topbar-left">
            <h1>Add Question</h1>
            <p>Create a new question for the selected quiz</p>
        </div>
        <a href="questionManagement" class="back-btn"><i class="fa fa-arrow-left"></i> Back</a>
    </div>

    <div class="content">

        <%-- msg display — logic unchanged --%>
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert-success"><i class="fa fa-check-circle"></i> <%=msg%></div>
        <% } %>

        <% if (!quizIdStr.isEmpty()) { %>
        <div class="quiz-badge"><i class="fa fa-book"></i> Quiz ID: <%=quizIdStr%></div>
        <% } %>

        <div class="form-card">
            <div class="form-card-header">
                <div class="icon"><i class="fa fa-plus"></i></div>
                <div>
                    <h2>New Question</h2>
                    <p>Fill in all fields — all 4 options and the correct answer are required</p>
                </div>
            </div>
            <div class="form-body">

                <%-- form action, method, and ALL field names unchanged --%>
                <form action="addQuestion" method="post">

                    <%-- Hidden quizId — unchanged --%>
                    <input type="hidden" name="quizId" value="<%=request.getAttribute("quizId")%>">

                    <div class="form-group">
                        <label><i class="fa fa-question" style="color:#94a3b8;margin-right:5px;"></i> Question</label>
                        <input type="text" name="question" placeholder="Type your question here..." required>
                    </div>

                    <hr class="divider">

                    <div class="form-group">
                        <label>Answer Options</label>
                        <div class="options-grid">

                            <div class="form-group option-group">
                                <span class="option-badge opt-a">A</span>
                                <input type="text" name="optionA" placeholder="Option A" required>
                            </div>

                            <div class="form-group option-group">
                                <span class="option-badge opt-b">B</span>
                                <input type="text" name="optionB" placeholder="Option B" required>
                            </div>

                            <div class="form-group option-group">
                                <span class="option-badge opt-c">C</span>
                                <input type="text" name="optionC" placeholder="Option C" required>
                            </div>

                            <div class="form-group option-group">
                                <span class="option-badge opt-d">D</span>
                                <input type="text" name="optionD" placeholder="Option D" required>
                            </div>

                        </div>
                    </div>

                    <hr class="divider">

                    <div class="form-group answer-select-wrap">
                        <label><i class="fa fa-check-circle" style="color:#10b981;margin-right:5px;"></i> Correct Answer</label>
                        <%-- select name="answer" and all option values unchanged --%>
                        <select name="answer" required>
                            <option value="">-- Select Correct Answer --</option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="C">C</option>
                            <option value="D">D</option>
                        </select>
                    </div>

                    <div class="form-footer">
                        <button type="submit" class="btn-submit">
                            <i class="fa fa-plus-circle"></i> Add Question
                        </button>
                        <a href="questionManagement" class="btn-back">
                            <i class="fa fa-times"></i> Cancel
                        </a>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
