<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update Quiz - Edukate Admin</title>
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
        }
        body { font-family: 'Inter', sans-serif; background: var(--light-bg); display: flex; min-height: 100vh; }
        a { text-decoration: none; transition: all 0.25s; }

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

        .main { margin-left: var(--sidebar-w); flex: 1; display: flex; flex-direction: column; }
        .topbar { background: var(--white); border-bottom: 1px solid var(--border); padding: 0 32px; height: 64px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 50; box-shadow: 0 1px 12px rgba(15,23,42,0.05); }
        .topbar h1 { font-size: 1.1rem; font-weight: 700; color: var(--dark); font-family: 'Poppins', sans-serif; }
        .topbar p { font-size: 0.8rem; color: var(--text); margin-top: 1px; }
        .back-btn { display: flex; align-items: center; gap: 8px; padding: 8px 16px; background: var(--light-bg); border: 1px solid var(--border); border-radius: 8px; color: var(--text); font-size: 0.85rem; font-weight: 500; }
        .back-btn:hover { background: var(--white); color: var(--primary); border-color: var(--primary); }
        .content { padding: 32px; flex: 1; }

        .alert-success { background: #f0fdf4; border: 1px solid #bbf7d0; color: #166534; padding: 14px 18px; border-radius: var(--radius); font-size: 0.88rem; display: flex; align-items: center; gap: 10px; margin-bottom: 28px; }

        .form-card { background: var(--white); border-radius: var(--radius); border: 1px solid var(--border); box-shadow: var(--shadow); max-width: 620px; }
        .form-card-header { padding: 24px 28px; border-bottom: 1px solid var(--border); display: flex; align-items: center; gap: 14px; }
        .form-card-header .icon { width: 44px; height: 44px; background: linear-gradient(135deg, #f97316, #ea580c); border-radius: 10px; display: flex; align-items: center; justify-content: center; }
        .form-card-header .icon i { color: #fff; font-size: 1rem; }
        .form-card-header h2 { font-family: 'Poppins', sans-serif; font-size: 1.1rem; font-weight: 700; color: var(--dark); margin: 0; }
        .form-card-header p { font-size: 0.8rem; color: var(--text); margin: 2px 0 0; }
        .form-body { padding: 28px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 0.85rem; font-weight: 600; color: #334155; margin-bottom: 8px; }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select { width: 100%; padding: 11px 14px; border: 1.5px solid var(--border); border-radius: 8px; font-size: 0.9rem; font-family: 'Inter', sans-serif; color: var(--dark); background: #fff; outline: none; transition: border-color 0.2s, box-shadow 0.2s; }
        .form-group input:focus, .form-group select:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(108,99,255,0.1); }
        .form-group select { appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%2394a3b8' d='M1 1l5 5 5-5'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 14px center; padding-right: 36px; }
        .hint-text { font-size: 0.78rem; color: #94a3b8; margin-top: 5px; }
        .selected-info { background: linear-gradient(135deg, rgba(249,115,22,0.06), rgba(234,88,12,0.04)); border: 1px solid rgba(249,115,22,0.2); border-radius: 8px; padding: 12px 16px; margin-bottom: 20px; display: none; }
        .selected-info .info-label { font-size: 0.75rem; font-weight: 600; color: #f97316; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 4px; }
        .selected-info .info-val { font-size: 0.88rem; color: var(--dark); font-weight: 500; }

        .btn-submit { width: 100%; padding: 13px; background: linear-gradient(135deg, #f97316, #ea580c); color: #fff; border: none; border-radius: 10px; font-size: 0.95rem; font-weight: 600; font-family: 'Inter', sans-serif; cursor: pointer; box-shadow: 0 4px 16px rgba(249,115,22,0.3); transition: all 0.3s; display: flex; align-items: center; justify-content: center; gap: 8px; margin-top: 8px; }
        .btn-submit:hover { background: linear-gradient(135deg, #ea580c, #c2410c); transform: translateY(-1px); }
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
        <a href="<%=request.getContextPath()%>/updateQuiz" class="nav-item active"><i class="fa fa-edit"></i> Update Quiz</a>
        <a href="<%=request.getContextPath()%>/deleteQuiz" class="nav-item"><i class="fa fa-trash-alt"></i> Delete Quiz</a>
        <a href="<%=request.getContextPath()%>/getAllQuizes" class="nav-item"><i class="fa fa-list"></i> All Quizzes</a>
        <a href="<%=request.getContextPath()%>/questionManagement" class="nav-item"><i class="fa fa-question-circle"></i> Question Management</a>
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
            <h1>Update Quiz</h1>
            <p>Modify an existing quiz's details</p>
        </div>
        <a href="<%=request.getContextPath()%>/adminhome" class="back-btn">
            <i class="fa fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <div class="content">

        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert-success"><i class="fa fa-check-circle"></i> <%=msg%></div>
        <% } %>

        <div class="form-card">
            <div class="form-card-header">
                <div class="icon"><i class="fa fa-edit"></i></div>
                <div>
                    <h2>Update Quiz Details</h2>
                    <p>Select a quiz and update its information</p>
                </div>
            </div>
            <div class="form-body">

                <%-- Form action, method, onchange hook and all field names unchanged --%>
                <form action="<%=request.getContextPath()%>/updateQuizData" method="post">

                    <div class="form-group">
                        <label for="quizId">Select Quiz to Update</label>
                        <select id="quizId" name="id" required onchange="updateQuizInfo()">
                            <option value="">-- Select a Quiz --</option>
                            <c:forEach var="quiz" items="${quizzes}">
                                <option value="${quiz.id}"
                                        data-name="${quiz.quizName}"
                                        data-marks="${quiz.marks}"
                                        data-duration="${quiz.duration}">
                                    ${quiz.quizName} (ID: ${quiz.id}) &mdash; Marks: ${quiz.marks}, Duration: ${quiz.duration}min
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="selected-info" id="selectedInfo">
                        <div class="info-label">Currently Selected</div>
                        <div class="info-val" id="selectedSummary"></div>
                    </div>

                    <div class="form-group">
                        <label for="quizName">New Quiz Name</label>
                        <input type="text" id="quizName" name="quizName" placeholder="Enter updated quiz name" required>
                    </div>

                    <div class="form-group">
                        <label for="marks">Marks <span style="color:#94a3b8; font-weight:400;">(optional)</span></label>
                        <input type="number" id="marks" name="marks" placeholder="e.g. 100">
                        <p class="hint-text">Leave blank to keep existing value</p>
                    </div>

                    <div class="form-group">
                        <label for="duration">Duration in Minutes <span style="color:#94a3b8; font-weight:400;">(optional)</span></label>
                        <input type="number" id="duration" name="duration" placeholder="e.g. 30">
                        <p class="hint-text">Leave blank to keep existing value</p>
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fa fa-save"></i> Update Quiz
                    </button>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    /* updateQuizInfo() — original function name preserved */
    function updateQuizInfo() {
        var select = document.getElementById('quizId');
        var option = select.options[select.selectedIndex];
        var info = document.getElementById('selectedInfo');
        var summary = document.getElementById('selectedSummary');

        if (select.value) {
            var name = option.getAttribute('data-name') || '';
            var marks = option.getAttribute('data-marks') || '';
            var duration = option.getAttribute('data-duration') || '';
            summary.textContent = name + ' | Marks: ' + marks + ' | Duration: ' + duration + ' min';
            info.style.display = 'block';
            document.getElementById('quizName').value = name;
            document.getElementById('marks').value = marks;
            document.getElementById('duration').value = duration;
        } else {
            info.style.display = 'none';
            document.getElementById('quizName').value = '';
            document.getElementById('marks').value = '';
            document.getElementById('duration').value = '';
        }
    }
</script>

</body>
</html>