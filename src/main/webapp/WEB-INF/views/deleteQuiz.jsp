<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Delete Quiz - Edukate Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --primary: #6c63ff; --dark: #0f172a; --sidebar-w: 260px;
            --text: #475569; --border: #e2e8f0; --light-bg: #f8fafc;
            --white: #ffffff; --radius: 12px; --shadow: 0 4px 20px rgba(15,23,42,0.07);
            --danger: #ef4444; --danger-dark: #dc2626;
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
        .nav-item.active { background: rgba(239,68,68,0.15); color: #fca5a5; border-left: 3px solid #f87171; }
        .nav-item i { width: 18px; text-align: center; font-size: 0.9rem; flex-shrink: 0; }
        .sidebar-bottom { padding: 16px 12px; border-top: 1px solid rgba(255,255,255,0.07); }
        .logout-btn { display: flex; align-items: center; gap: 12px; padding: 11px 14px; border-radius: 8px; color: #f87171; font-size: 0.875rem; font-weight: 500; width: 100%; }
        .logout-btn:hover { background: rgba(239,68,68,0.1); color: var(--danger); }

        .main { margin-left: var(--sidebar-w); flex: 1; display: flex; flex-direction: column; }
        .topbar { background: var(--white); border-bottom: 1px solid var(--border); padding: 0 32px; height: 64px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 50; box-shadow: 0 1px 12px rgba(15,23,42,0.05); }
        .topbar h1 { font-size: 1.1rem; font-weight: 700; color: var(--dark); font-family: 'Poppins', sans-serif; }
        .topbar p { font-size: 0.8rem; color: var(--text); margin-top: 1px; }
        .back-btn { display: flex; align-items: center; gap: 8px; padding: 8px 16px; background: var(--light-bg); border: 1px solid var(--border); border-radius: 8px; color: var(--text); font-size: 0.85rem; font-weight: 500; }
        .back-btn:hover { color: var(--primary); border-color: var(--primary); }
        .content { padding: 32px; flex: 1; }

        .alert-success { background: #f0fdf4; border: 1px solid #bbf7d0; color: #166534; padding: 14px 18px; border-radius: var(--radius); font-size: 0.88rem; display: flex; align-items: center; gap: 10px; margin-bottom: 28px; }

        .form-card { background: var(--white); border-radius: var(--radius); border: 1px solid var(--border); box-shadow: var(--shadow); max-width: 560px; }
        .form-card-header { padding: 24px 28px; border-bottom: 1px solid var(--border); display: flex; align-items: center; gap: 14px; }
        .form-card-header .icon { width: 44px; height: 44px; background: linear-gradient(135deg, var(--danger), var(--danger-dark)); border-radius: 10px; display: flex; align-items: center; justify-content: center; }
        .form-card-header .icon i { color: #fff; font-size: 1rem; }
        .form-card-header h2 { font-family: 'Poppins', sans-serif; font-size: 1.1rem; font-weight: 700; color: var(--dark); margin: 0; }
        .form-card-header p { font-size: 0.8rem; color: var(--text); margin: 2px 0 0; }
        .form-body { padding: 28px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 0.85rem; font-weight: 600; color: #334155; margin-bottom: 8px; }
        .form-group select { width: 100%; padding: 11px 14px; border: 1.5px solid var(--border); border-radius: 8px; font-size: 0.9rem; font-family: 'Inter', sans-serif; color: var(--dark); background: #fff; outline: none; transition: border-color 0.2s, box-shadow 0.2s; appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%2394a3b8' d='M1 1l5 5 5-5'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 14px center; padding-right: 36px; }
        .form-group select:focus { border-color: var(--danger); box-shadow: 0 0 0 3px rgba(239,68,68,0.1); }

        /* Warning box shown when a quiz is selected */
        .danger-warning { background: #fef2f2; border: 1px solid #fecaca; border-radius: 8px; padding: 14px 16px; margin-bottom: 20px; display: none; }
        .danger-warning .warn-title { font-size: 0.83rem; font-weight: 700; color: var(--danger); display: flex; align-items: center; gap: 6px; margin-bottom: 4px; }
        .danger-warning .warn-body { font-size: 0.82rem; color: #7f1d1d; }
        .selected-quiz-name { font-weight: 700; color: var(--danger-dark); }

        .btn-delete { width: 100%; padding: 13px; background: linear-gradient(135deg, var(--danger), var(--danger-dark)); color: #fff; border: none; border-radius: 10px; font-size: 0.95rem; font-weight: 600; font-family: 'Inter', sans-serif; cursor: pointer; box-shadow: 0 4px 16px rgba(239,68,68,0.3); transition: all 0.3s; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-delete:hover { background: linear-gradient(135deg, #dc2626, #b91c1c); transform: translateY(-1px); }
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
        <a href="<%=request.getContextPath()%>/deleteQuiz" class="nav-item active"><i class="fa fa-trash-alt"></i> Delete Quiz</a>
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
            <h1>Delete Quiz</h1>
            <p>Permanently remove a quiz from the platform</p>
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
                <div class="icon"><i class="fa fa-trash-alt"></i></div>
                <div>
                    <h2>Delete Quiz</h2>
                    <p>This action is permanent and cannot be undone</p>
                </div>
            </div>
            <div class="form-body">

                <%-- Form action, method, and field name 'id' unchanged --%>
                <form action="<%=request.getContextPath()%>/deleteQuizData" method="post"
                      onsubmit="return confirmDelete()">

                    <div class="form-group">
                        <label for="quizId">Select Quiz to Delete</label>
                        <select id="quizId" name="id" required onchange="showWarning()">
                            <option value="">-- Select a Quiz --</option>
                            <c:forEach var="quiz" items="${quizzes}">
                                <option value="${quiz.id}" data-name="${quiz.quizName}">
                                    ${quiz.quizName} (ID: ${quiz.id})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="danger-warning" id="dangerWarning">
                        <div class="warn-title"><i class="fa fa-exclamation-triangle"></i> Warning</div>
                        <div class="warn-body">
                            You are about to permanently delete
                            <span class="selected-quiz-name" id="selectedName"></span>.
                            All associated questions will also be removed. This cannot be undone.
                        </div>
                    </div>

                    <button type="submit" class="btn-delete">
                        <i class="fa fa-trash-alt"></i> Delete Quiz
                    </button>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function showWarning() {
        var select = document.getElementById('quizId');
        var warning = document.getElementById('dangerWarning');
        var nameSpan = document.getElementById('selectedName');
        if (select.value) {
            var option = select.options[select.selectedIndex];
            nameSpan.textContent = '"' + (option.getAttribute('data-name') || option.text) + '"';
            warning.style.display = 'block';
        } else {
            warning.style.display = 'none';
        }
    }
    function confirmDelete() {
        var select = document.getElementById('quizId');
        if (!select.value) return false;
        var option = select.options[select.selectedIndex];
        var name = option.getAttribute('data-name') || option.text;
        return confirm('Are you sure you want to permanently delete "' + name + '"? This cannot be undone.');
    }
</script>

</body>
</html>