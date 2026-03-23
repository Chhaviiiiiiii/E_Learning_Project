<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cdgi.pojo.Quiz"%>
<%@ page import="com.cdgi.pojo.UserInfo"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Question Management - Edukate Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        *, *::before, *::after { box-sizing:border-box; margin:0; padding:0; }
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

        /* Form card */
        .form-card { background:var(--white); border-radius:var(--radius); border:1px solid var(--border); box-shadow:var(--shadow); max-width:640px; }
        .form-card-header { padding:24px 28px; border-bottom:1px solid var(--border); display:flex; align-items:center; gap:14px; }
        .form-card-header .icon { width:44px; height:44px; background:linear-gradient(135deg,#6c63ff,#4f46e5); border-radius:10px; display:flex; align-items:center; justify-content:center; }
        .form-card-header .icon i { color:#fff; font-size:1rem; }
        .form-card-header h2 { font-family:'Poppins',sans-serif; font-size:1.1rem; font-weight:700; color:var(--dark); margin:0; }
        .form-card-header p { font-size:0.8rem; color:var(--text); margin:2px 0 0; }
        .form-body { padding:28px; }

        .form-group { margin-bottom:28px; }
        .form-group label { display:block; font-size:0.85rem; font-weight:600; color:#334155; margin-bottom:8px; }
        .form-group select { width:100%; padding:12px 14px; border:1.5px solid var(--border); border-radius:8px; font-size:0.9rem; font-family:'Inter',sans-serif; color:var(--dark); background:#fff; outline:none; transition:border-color 0.2s,box-shadow 0.2s; appearance:none; background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%2394a3b8' d='M1 1l5 5 5-5'/%3E%3C/svg%3E"); background-repeat:no-repeat; background-position:right 14px center; padding-right:36px; }
        .form-group select:focus { border-color:var(--primary); box-shadow:0 0 0 3px rgba(108,99,255,0.1); }

        /* Action buttons */
        .action-grid { display:grid; grid-template-columns:1fr 1fr 1fr; gap:14px; }
        .action-btn { display:flex; flex-direction:column; align-items:center; justify-content:center; gap:10px; padding:24px 16px; border:none; border-radius:var(--radius); font-family:'Inter',sans-serif; font-size:0.88rem; font-weight:700; cursor:pointer; transition:all 0.25s; }
        .action-btn:hover { transform:translateY(-3px); }
        .action-btn .btn-icon { width:48px; height:48px; border-radius:12px; display:flex; align-items:center; justify-content:center; }
        .action-btn .btn-icon i { font-size:1.2rem; color:#fff; }
        .action-btn span { font-size:0.85rem; }

        .btn-add { background:#f0fdf4; color:#059669; border:1.5px solid #bbf7d0; }
        .btn-add .btn-icon { background:linear-gradient(135deg,#10b981,#059669); }
        .btn-add:hover { background:#dcfce7; border-color:#86efac; box-shadow:0 8px 20px rgba(16,185,129,0.15); }

        .btn-edit { background:#eff6ff; color:#2563eb; border:1.5px solid #bfdbfe; }
        .btn-edit .btn-icon { background:linear-gradient(135deg,#3b82f6,#2563eb); }
        .btn-edit:hover { background:#dbeafe; border-color:#93c5fd; box-shadow:0 8px 20px rgba(59,130,246,0.15); }

        .btn-del { background:#fef2f2; color:#dc2626; border:1.5px solid #fecaca; }
        .btn-del .btn-icon { background:linear-gradient(135deg,#ef4444,#dc2626); }
        .btn-del:hover { background:#fee2e2; border-color:#fca5a5; box-shadow:0 8px 20px rgba(239,68,68,0.15); }

        .quiz-hint { background:#f8fafc; border:1px solid var(--border); border-radius:8px; padding:12px 16px; margin-bottom:28px; display:flex; align-items:center; gap:10px; font-size:0.83rem; color:#64748b; display:none; }
        .quiz-hint i { color:var(--primary); }
        .selected-quiz-name { font-weight:700; color:var(--dark); }
    </style>
</head>
<body>
<%
    UserInfo loggedUser = (UserInfo) session.getAttribute("User");
    String username = (loggedUser != null) ? loggedUser.getUsername() : "Admin";
%>

<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Main Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/adminhome" class="nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/addQuiz" class="nav-item"><i class="fa fa-plus-circle"></i> Add New Quiz</a>
        <a href="<%=request.getContextPath()%>/updateQuiz" class="nav-item"><i class="fa fa-edit"></i> Update Quiz</a>
        <a href="<%=request.getContextPath()%>/deleteQuiz" class="nav-item"><i class="fa fa-trash-alt"></i> Delete Quiz</a>
        <a href="<%=request.getContextPath()%>/getAllQuizes" class="nav-item"><i class="fa fa-list"></i> All Quizzes</a>
        <a href="<%=request.getContextPath()%>/questionManagement" class="nav-item active"><i class="fa fa-question-circle"></i> Question Management</a>
        <a href="<%=request.getContextPath()%>/getAllStudents" class="nav-item"><i class="fa fa-users"></i> Enrolled Students</a>
        <a href="<%=request.getContextPath()%>/updateAdminProfile" class="nav-item"><i class="fa fa-user-cog"></i> My Profile</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>

<div class="main">
    <div class="topbar">
        <div>
            <h1>Question Management</h1>
            <p>Add, update or delete quiz questions</p>
        </div>
        <a href="<%=request.getContextPath()%>/adminhome" class="back-btn">
            <i class="fa fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <div class="content">
        <div class="form-card">
            <div class="form-card-header">
                <div class="icon"><i class="fa fa-question-circle"></i></div>
                <div>
                    <h2>Select a Quiz</h2>
                    <p>Choose a quiz to manage its questions</p>
                </div>
            </div>
            <div class="form-body">

                <div class="form-group">
                    <label>Select Quiz</label>
                    <%-- quizDropdown id and goTo() calls preserved exactly --%>
                    <select id="quizDropdown" onchange="onQuizSelect()">
                        <option value="">-- Select a Quiz --</option>
                        <%
                            List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
                            if (quizzes != null) {
                                for (Quiz q : quizzes) {
                        %>
                        <option value="<%=q.getId()%>"><%=q.getQuizName()%></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="quiz-hint" id="quizHint">
                    <i class="fa fa-info-circle"></i>
                    Managing questions for: <span class="selected-quiz-name" id="selectedQuizName"></span>
                </div>

                <div class="action-grid">
                    <%-- onclick functions unchanged — goTo('addQuestion'), goTo('updateQuestionPage'), goTo('deleteQuestionPage') --%>
                    <button onclick="goTo('addQuestion')" class="action-btn btn-add">
                        <div class="btn-icon"><i class="fa fa-plus"></i></div>
                        <span>Add Question</span>
                    </button>
                    <button onclick="goTo('updateQuestionPage')" class="action-btn btn-edit">
                        <div class="btn-icon"><i class="fa fa-pen"></i></div>
                        <span>Update Question</span>
                    </button>
                    <button onclick="goTo('deleteQuestionPage')" class="action-btn btn-del">
                        <div class="btn-icon"><i class="fa fa-trash-alt"></i></div>
                        <span>Delete Question</span>
                    </button>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
    /* goTo() function — logic 100% unchanged */
    function goTo(action) {
        const quizId = document.getElementById("quizDropdown").value;
        if (quizId === "") {
            alert("Please select a quiz first!");
            return;
        }
        window.location = action + "?quizId=" + quizId;
    }

    function onQuizSelect() {
        var select = document.getElementById("quizDropdown");
        var hint = document.getElementById("quizHint");
        var nameEl = document.getElementById("selectedQuizName");
        if (select.value) {
            nameEl.textContent = select.options[select.selectedIndex].text;
            hint.style.display = "flex";
        } else {
            hint.style.display = "none";
        }
    }
</script>

</body>
</html>
