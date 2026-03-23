<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Quiz - Edukate Admin</title>
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
        .topbar h1 { font-size: 1.1rem; font-weight: 700; color: var(--dark); font-family: 'Poppins', sans-serif; }
        .topbar p { font-size: 0.8rem; color: var(--text); margin-top: 1px; }
        .back-btn { display: flex; align-items: center; gap: 8px; padding: 8px 16px; background: var(--light-bg); border: 1px solid var(--border); border-radius: 8px; color: var(--text); font-size: 0.85rem; font-weight: 500; }
        .back-btn:hover { background: var(--white); color: var(--primary); border-color: var(--primary); }
        .content { padding: 32px; flex: 1; }

        /* ALERT */
        .alert-success { background: #f0fdf4; border: 1px solid #bbf7d0; color: #166534; padding: 14px 18px; border-radius: var(--radius); font-size: 0.88rem; display: flex; align-items: center; gap: 10px; margin-bottom: 28px; }
        .alert-error { background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; padding: 14px 18px; border-radius: var(--radius); font-size: 0.88rem; display: flex; align-items: center; gap: 10px; margin-bottom: 28px; }

        /* FORM CARD */
        .form-card { background: var(--white); border-radius: var(--radius); border: 1px solid var(--border); box-shadow: var(--shadow); max-width: 620px; }
        .form-card-header { padding: 24px 28px; border-bottom: 1px solid var(--border); display: flex; align-items: center; gap: 14px; }
        .form-card-header .icon { width: 44px; height: 44px; background: linear-gradient(135deg, #6c63ff, #4f46e5); border-radius: 10px; display: flex; align-items: center; justify-content: center; }
        .form-card-header .icon i { color: #fff; font-size: 1rem; }
        .form-card-header h2 { font-family: 'Poppins', sans-serif; font-size: 1.1rem; font-weight: 700; color: var(--dark); margin: 0; }
        .form-card-header p { font-size: 0.8rem; color: var(--text); margin: 2px 0 0; }
        .form-body { padding: 28px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 0.85rem; font-weight: 600; color: #334155; margin-bottom: 8px; }
        .form-group input[type="text"],
        .form-group input[type="number"] { width: 100%; padding: 11px 14px; border: 1.5px solid var(--border); border-radius: 8px; font-size: 0.9rem; font-family: 'Inter', sans-serif; color: var(--dark); background: #fff; outline: none; transition: border-color 0.2s, box-shadow 0.2s; }
        .form-group input:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(108,99,255,0.1); }
        .form-group input::placeholder { color: #94a3b8; }

        /* Radio group */
        .radio-group { display: flex; gap: 12px; }
        .radio-option { flex: 1; }
        .radio-option input[type="radio"] { display: none; }
        .radio-option label { display: flex; align-items: center; justify-content: center; gap: 8px; padding: 11px; border: 1.5px solid var(--border); border-radius: 8px; font-size: 0.88rem; font-weight: 600; color: var(--text); cursor: pointer; transition: all 0.2s; }
        .radio-option input[type="radio"]:checked + label { border-color: var(--primary); background: rgba(108,99,255,0.06); color: var(--primary); }
        .radio-option label:hover { border-color: var(--primary); color: var(--primary); }
        .free-label { color: #10b981 !important; }
        .free-label:hover, input:checked + .free-label { border-color: #10b981 !important; background: rgba(16,185,129,0.06) !important; color: #10b981 !important; }

        .btn-submit { width: 100%; padding: 13px; background: linear-gradient(135deg, #6c63ff, #4f46e5); color: #fff; border: none; border-radius: 10px; font-size: 0.95rem; font-weight: 600; font-family: 'Inter', sans-serif; cursor: pointer; box-shadow: 0 4px 16px rgba(108,99,255,0.3); transition: all 0.3s; display: flex; align-items: center; justify-content: center; gap: 8px; margin-top: 8px; }
        .btn-submit:hover { background: linear-gradient(135deg, #4f46e5, #3730a3); box-shadow: 0 6px 22px rgba(108,99,255,0.4); transform: translateY(-1px); }
    </style>
</head>
<body>
<%
    UserInfo loggedUser = (UserInfo) session.getAttribute("User");
    String username = (loggedUser != null) ? loggedUser.getUsername() : "Admin";
    String dpImage = (loggedUser != null && loggedUser.getDp() != null && !loggedUser.getDp().trim().isEmpty())
                     ? loggedUser.getDp() : "default.png";
%>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Main Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/adminhome" class="nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/addQuiz" class="nav-item active"><i class="fa fa-plus-circle"></i> Add New Quiz</a>
        <a href="<%=request.getContextPath()%>/updateQuiz" class="nav-item"><i class="fa fa-edit"></i> Update Quiz</a>
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

<!-- MAIN -->
<div class="main">
    <div class="topbar">
        <div>
            <h1>Add New Quiz</h1>
            <p>Create a new quiz for students</p>
        </div>
        <a href="<%=request.getContextPath()%>/adminhome" class="back-btn">
            <i class="fa fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <div class="content">

        <%-- Message Display — logic unchanged --%>
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert-success"><i class="fa fa-check-circle"></i> <%=msg%></div>
        <% } %>

        <div class="form-card">
            <div class="form-card-header">
                <div class="icon"><i class="fa fa-plus-circle"></i></div>
                <div>
                    <h2>Quiz Details</h2>
                    <p>Fill in the details below to create a new quiz</p>
                </div>
            </div>
            <div class="form-body">
                <%-- Form action, method, and all field names unchanged --%>
                <form action="<%=request.getContextPath()%>/addQuiz" method="post">

                    <div class="form-group">
                        <label>Quiz Name</label>
                        <input type="text" name="quizName" placeholder="e.g. Java Programming Basics" required>
                    </div>

                    <div class="form-group">
                        <label>Total Marks</label>
                        <input type="number" name="marks" placeholder="e.g. 100" required>
                    </div>

                    <div class="form-group">
                        <label>Duration (minutes)</label>
                        <input type="number" name="duration" placeholder="e.g. 30" required>
                    </div>

                    <div class="form-group">
                        <label>Quiz Type</label>
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" name="quizType" value="Free" id="free" required>
                                <label for="free" class="free-label"><i class="fa fa-gift"></i> Free</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" name="quizType" value="Paid" id="paid">
                                <label for="paid"><i class="fa fa-tag"></i> Paid</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Price (₹) <span style="color:#94a3b8; font-weight:400;">(enter 0 if Free)</span></label>
                        <input type="number" name="quizPrice" placeholder="0.00" step="0.01" value="0">
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fa fa-plus-circle"></i> Add Quiz
                    </button>

                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>