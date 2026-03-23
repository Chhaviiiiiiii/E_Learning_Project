<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cdgi.pojo.Question"%>
<%@ page import="com.cdgi.pojo.UserInfo"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update Question - Edukate Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --primary:#6c63ff; --dark:#0f172a; --sidebar-w:260px; --text:#475569; --border:#e2e8f0; --light-bg:#f8fafc; --white:#fff; --radius:12px; --shadow:0 4px 20px rgba(15,23,42,0.07); }
        body { font-family:'Inter',sans-serif; background:var(--light-bg); display:flex; min-height:100vh; }
        a { text-decoration:none; transition:all 0.25s; }

        .sidebar { width:var(--sidebar-w); min-height:100vh; background:var(--dark); display:flex; flex-direction:column; position:fixed; left:0; top:0; bottom:0; z-index:100; overflow-y:auto; }
        .sidebar-brand { padding:28px 24px 24px; border-bottom:1px solid rgba(255,255,255,0.07); display:flex; align-items:center; gap:10px; font-family:'Poppins',sans-serif; font-size:1.35rem; font-weight:800; color:#fff; }
        .sidebar-brand i { color:#818cf8; } .sidebar-brand span { color:#818cf8; }
        .sidebar-section-label { padding:20px 24px 8px; font-size:0.7rem; font-weight:700; letter-spacing:1.5px; text-transform:uppercase; color:#475569; }
        .sidebar-nav { padding:0 12px; flex:1; }
        .nav-item { display:flex; align-items:center; gap:12px; padding:11px 14px; border-radius:8px; margin-bottom:2px; color:#94a3b8; font-size:0.875rem; font-weight:500; }
        .nav-item:hover { background:rgba(255,255,255,0.06); color:#e2e8f0; }
        .nav-item.active { background:linear-gradient(135deg,rgba(108,99,255,0.25),rgba(79,70,229,0.15)); color:#a5b4fc; border-left:3px solid #818cf8; }
        .nav-item i { width:18px; text-align:center; font-size:0.9rem; flex-shrink:0; }
        .sidebar-bottom { padding:16px 12px; border-top:1px solid rgba(255,255,255,0.07); }
        .logout-btn { display:flex; align-items:center; gap:12px; padding:11px 14px; border-radius:8px; color:#f87171; font-size:0.875rem; font-weight:500; width:100%; }
        .logout-btn:hover { background:rgba(239,68,68,0.1); color:#ef4444; }

        .main { margin-left:var(--sidebar-w); flex:1; display:flex; flex-direction:column; }
        .topbar { background:var(--white); border-bottom:1px solid var(--border); padding:0 32px; height:64px; display:flex; align-items:center; justify-content:space-between; position:sticky; top:0; z-index:50; box-shadow:0 1px 12px rgba(15,23,42,0.05); }
        .topbar h1 { font-size:1.1rem; font-weight:700; color:var(--dark); font-family:'Poppins',sans-serif; }
        .topbar p { font-size:0.8rem; color:var(--text); margin-top:1px; }
        .back-btn { display:flex; align-items:center; gap:8px; padding:8px 16px; background:var(--light-bg); border:1px solid var(--border); border-radius:8px; color:var(--text); font-size:0.85rem; font-weight:500; }
        .back-btn:hover { color:var(--primary); border-color:var(--primary); }
        .content { padding:32px; flex:1; }

        .alert-success { background:#f0fdf4; border:1px solid #bbf7d0; color:#166534; padding:13px 18px; border-radius:var(--radius); font-size:0.88rem; display:flex; align-items:center; gap:10px; margin-bottom:24px; }
        .quiz-badge { display:inline-flex; align-items:center; gap:8px; background:linear-gradient(135deg,rgba(59,130,246,0.1),rgba(37,99,235,0.07)); border:1px solid rgba(59,130,246,0.2); color:#2563eb; font-size:0.82rem; font-weight:700; padding:6px 14px; border-radius:50px; margin-bottom:24px; }

        /* Question cards */
        .q-card { background:var(--white); border-radius:var(--radius); border:1px solid var(--border); box-shadow:var(--shadow); margin-bottom:24px; overflow:hidden; }
        .q-card-header { padding:16px 24px; background:linear-gradient(135deg,rgba(108,99,255,0.06),rgba(79,70,229,0.03)); border-bottom:1px solid var(--border); display:flex; align-items:center; gap:10px; }
        .q-num { width:28px; height:28px; border-radius:8px; background:linear-gradient(135deg,#6c63ff,#4f46e5); display:flex; align-items:center; justify-content:center; color:#fff; font-size:0.75rem; font-weight:800; flex-shrink:0; }
        .q-id-label { font-size:0.8rem; font-weight:600; color:#64748b; }
        .q-card-body { padding:24px; }

        .form-group { margin-bottom:18px; }
        .form-group label { display:block; font-size:0.82rem; font-weight:600; color:#334155; margin-bottom:7px; }
        .form-group input[type="text"],
        .form-group select { width:100%; padding:10px 14px; border:1.5px solid var(--border); border-radius:8px; font-size:0.88rem; font-family:'Inter',sans-serif; color:var(--dark); background:#fff; outline:none; transition:border-color 0.2s,box-shadow 0.2s; }
        .form-group input:focus, .form-group select:focus { border-color:var(--primary); box-shadow:0 0 0 3px rgba(108,99,255,0.1); }
        .form-group select { appearance:none; background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%2394a3b8' d='M1 1l5 5 5-5'/%3E%3C/svg%3E"); background-repeat:no-repeat; background-position:right 14px center; padding-right:36px; }

        /* Options 2-col */
        .options-grid { display:grid; grid-template-columns:1fr 1fr; gap:14px; }
        .option-wrap { position:relative; }
        .opt-badge { position:absolute; left:10px; top:50%; transform:translateY(-50%); width:20px; height:20px; border-radius:5px; display:flex; align-items:center; justify-content:center; font-size:0.68rem; font-weight:800; }
        .opt-a { background:rgba(108,99,255,0.12); color:#6c63ff; }
        .opt-b { background:rgba(16,185,129,0.12); color:#059669; }
        .opt-c { background:rgba(249,115,22,0.12); color:#ea580c; }
        .opt-d { background:rgba(239,68,68,0.12); color:#dc2626; }
        .option-wrap input { padding-left:38px !important; }

        .divider { border:none; border-top:1px solid var(--border); margin:18px 0; }

        .answer-wrap select { border-color:#bbf7d0; background-color:#f0fdf4; color:#059669; font-weight:600; }
        .answer-wrap select:focus { border-color:#10b981; box-shadow:0 0 0 3px rgba(16,185,129,0.12); }

        .btn-update { padding:10px 22px; background:linear-gradient(135deg,#3b82f6,#2563eb); color:#fff; border:none; border-radius:9px; font-size:0.9rem; font-weight:600; font-family:'Inter',sans-serif; cursor:pointer; box-shadow:0 4px 14px rgba(59,130,246,0.3); transition:all 0.25s; display:inline-flex; align-items:center; gap:7px; }
        .btn-update:hover { background:linear-gradient(135deg,#2563eb,#1d4ed8); transform:translateY(-1px); }

        .empty-state { background:var(--white); border-radius:var(--radius); border:1px solid var(--border); padding:60px 24px; text-align:center; color:#94a3b8; }
        .empty-state i { font-size:2.5rem; margin-bottom:12px; display:block; color:#cbd5e1; }
    </style>
</head>
<body>
<%
    UserInfo loggedUser = (UserInfo) session.getAttribute("User");
    /* Business logic unchanged — same attribute reads */
    List<Question> questions = (List<Question>) request.getAttribute("questions");
    int quizId = (Integer) request.getAttribute("quizId");
%>

<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Main Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/adminhome"          class="nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/addQuiz"            class="nav-item"><i class="fa fa-plus-circle"></i> Add New Quiz</a>
        <a href="<%=request.getContextPath()%>/updateQuiz"         class="nav-item"><i class="fa fa-edit"></i> Update Quiz</a>
        <a href="<%=request.getContextPath()%>/deleteQuiz"         class="nav-item"><i class="fa fa-trash-alt"></i> Delete Quiz</a>
        <a href="<%=request.getContextPath()%>/getAllQuizes"        class="nav-item"><i class="fa fa-list"></i> All Quizzes</a>
        <a href="<%=request.getContextPath()%>/questionManagement" class="nav-item active"><i class="fa fa-question-circle"></i> Question Management</a>
        <a href="<%=request.getContextPath()%>/getAllStudents"      class="nav-item"><i class="fa fa-users"></i> Enrolled Students</a>
        <a href="<%=request.getContextPath()%>/updateAdminProfile"  class="nav-item"><i class="fa fa-user-cog"></i> My Profile</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>

<div class="main">
    <div class="topbar">
        <div>
            <h1>Update Questions</h1>
            <p>Edit existing questions for Quiz ID: <%=quizId%></p>
        </div>
        <a href="questionManagement" class="back-btn"><i class="fa fa-arrow-left"></i> Back</a>
    </div>

    <div class="content">

        <%-- msg unchanged --%>
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert-success"><i class="fa fa-check-circle"></i> <%=msg%></div>
        <% } %>

        <div class="quiz-badge"><i class="fa fa-book"></i> Quiz ID: <%=quizId%></div>

        <%-- loop unchanged — same attribute, same form action, same hidden fields, same field names, same selected logic --%>
        <%
            if (questions != null && questions.size() > 0) {
                int num = 1;
                for (Question q : questions) {
        %>
        <div class="q-card">
            <div class="q-card-header">
                <div class="q-num"><%=num++%></div>
                <span class="q-id-label">Question ID: <%=q.getId()%></span>
            </div>
            <div class="q-card-body">
                <form action="updateQuestion" method="post">
                    <input type="hidden" name="id"     value="<%=q.getId()%>">
                    <input type="hidden" name="quizId" value="<%=quizId%>">

                    <div class="form-group">
                        <label><i class="fa fa-question" style="color:#94a3b8;margin-right:4px;font-size:0.75rem;"></i> Question</label>
                        <input type="text" name="question" value="<%=q.getQuestion()%>" required>
                    </div>

                    <hr class="divider">

                    <div class="form-group">
                        <label>Answer Options</label>
                        <div class="options-grid">
                            <div class="option-wrap">
                                <span class="opt-badge opt-a">A</span>
                                <input type="text" name="optionA" value="<%=q.getOptionA()%>" required>
                            </div>
                            <div class="option-wrap">
                                <span class="opt-badge opt-b">B</span>
                                <input type="text" name="optionB" value="<%=q.getOptionB()%>" required>
                            </div>
                            <div class="option-wrap">
                                <span class="opt-badge opt-c">C</span>
                                <input type="text" name="optionC" value="<%=q.getOptionC()%>" required>
                            </div>
                            <div class="option-wrap">
                                <span class="opt-badge opt-d">D</span>
                                <input type="text" name="optionD" value="<%=q.getOptionD()%>" required>
                            </div>
                        </div>
                    </div>

                    <hr class="divider">

                    <div class="form-group answer-wrap">
                        <label><i class="fa fa-check-circle" style="color:#10b981;margin-right:4px;font-size:0.82rem;"></i> Correct Answer</label>
                        <%-- selected logic unchanged --%>
                        <select name="answer" required>
                            <option value="A" <%=q.getAnswer().equals("A") ? "selected" : ""%>>A</option>
                            <option value="B" <%=q.getAnswer().equals("B") ? "selected" : ""%>>B</option>
                            <option value="C" <%=q.getAnswer().equals("C") ? "selected" : ""%>>C</option>
                            <option value="D" <%=q.getAnswer().equals("D") ? "selected" : ""%>>D</option>
                        </select>
                    </div>

                    <button type="submit" class="btn-update">
                        <i class="fa fa-save"></i> Save Changes
                    </button>
                </form>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="empty-state">
            <i class="fa fa-inbox"></i>
            <p>No questions found for this quiz.</p>
        </div>
        <% } %>

    </div>
</div>

</body>
</html>
