<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard - Edukate</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --primary: #6c63ff;
            --primary-dark: #4f46e5;
            --dark: #0f172a;
            --dark-2: #1e293b;
            --sidebar-w: 260px;
            --text: #475569;
            --border: #e2e8f0;
            --light-bg: #f8fafc;
            --white: #ffffff;
            --radius: 12px;
            --shadow: 0 4px 20px rgba(15,23,42,0.07);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--light-bg);
            color: var(--text);
            display: flex;
            min-height: 100vh;
        }

        a { text-decoration: none; transition: all 0.25s; }

        /* ===== SIDEBAR ===== */
        .sidebar {
            width: var(--sidebar-w);
            min-height: 100vh;
            background: var(--dark);
            display: flex;
            flex-direction: column;
            position: fixed;
            left: 0; top: 0; bottom: 0;
            z-index: 100;
            overflow-y: auto;
        }
        .sidebar-brand {
            padding: 28px 24px 24px;
            border-bottom: 1px solid rgba(255,255,255,0.07);
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Poppins', sans-serif;
            font-size: 1.35rem;
            font-weight: 800;
            color: #fff;
        }
        .sidebar-brand i { color: #818cf8; }
        .sidebar-brand span { color: #818cf8; }

        .sidebar-section-label {
            padding: 20px 24px 8px;
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #475569;
        }

        .sidebar-nav { padding: 0 12px; flex: 1; }
        .nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 14px;
            border-radius: 8px;
            margin-bottom: 2px;
            color: #94a3b8;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
        }
        .nav-item:hover {
            background: rgba(255,255,255,0.06);
            color: #e2e8f0;
        }
        .nav-item.active {
            background: linear-gradient(135deg, rgba(108,99,255,0.25), rgba(79,70,229,0.15));
            color: #a5b4fc;
            border-left: 3px solid #818cf8;
        }
        .nav-item i {
            width: 18px;
            text-align: center;
            font-size: 0.9rem;
            flex-shrink: 0;
        }

        .sidebar-bottom {
            padding: 16px 12px;
            border-top: 1px solid rgba(255,255,255,0.07);
        }
        .logout-btn {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 14px;
            border-radius: 8px;
            color: #f87171;
            font-size: 0.875rem;
            font-weight: 500;
            width: 100%;
        }
        .logout-btn:hover { background: rgba(239,68,68,0.1); color: #ef4444; }
        .logout-btn i { width: 18px; text-align: center; }

        /* ===== MAIN ===== */
        .main {
            margin-left: var(--sidebar-w);
            flex: 1;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* ===== TOP BAR ===== */
        .topbar {
            background: var(--white);
            border-bottom: 1px solid var(--border);
            padding: 0 32px;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 50;
            box-shadow: 0 1px 12px rgba(15,23,42,0.05);
        }
        .topbar-left h1 {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--dark);
            font-family: 'Poppins', sans-serif;
        }
        .topbar-left p { font-size: 0.8rem; color: var(--text); margin-top: 1px; }
        .topbar-right { display: flex; align-items: center; gap: 16px; }
        .user-chip {
            display: flex;
            align-items: center;
            gap: 10px;
            background: var(--light-bg);
            border: 1px solid var(--border);
            padding: 6px 14px 6px 8px;
            border-radius: 50px;
        }
        .user-chip img {
            width: 32px; height: 32px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--primary);
        }
        .user-chip span { font-size: 0.85rem; font-weight: 600; color: var(--dark); }
        .user-chip .role-badge {
            font-size: 0.7rem;
            background: rgba(108,99,255,0.1);
            color: var(--primary);
            padding: 2px 8px;
            border-radius: 50px;
            font-weight: 600;
        }

        /* ===== CONTENT ===== */
        .content { padding: 32px; flex: 1; }

        /* Alert msg */
        .alert-success-box {
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            color: #166534;
            padding: 12px 18px;
            border-radius: var(--radius);
            font-size: 0.88rem;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 28px;
        }

        /* Welcome card */
        .welcome-card {
            background: linear-gradient(135deg, var(--dark) 0%, #1a1060 100%);
            border-radius: var(--radius);
            padding: 32px 40px;
            margin-bottom: 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }
        .welcome-card::after {
            content: '';
            position: absolute;
            width: 280px; height: 280px;
            background: radial-gradient(circle, rgba(108,99,255,0.3) 0%, transparent 70%);
            top: -80px; right: -60px;
            border-radius: 50%;
        }
        .welcome-text { position: relative; z-index: 1; }
        .welcome-text h2 { color: #fff; font-size: 1.4rem; font-family: 'Poppins', sans-serif; margin-bottom: 6px; }
        .welcome-text p { color: #94a3b8; font-size: 0.88rem; }
        .welcome-icon {
            position: relative; z-index: 1;
            width: 72px; height: 72px;
            background: rgba(129,140,248,0.2);
            border-radius: 18px;
            display: flex; align-items: center; justify-content: center;
        }
        .welcome-icon i { color: #818cf8; font-size: 2rem; }

        /* Stats row */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }
        .stat-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 24px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .stat-icon {
            width: 50px; height: 50px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .stat-icon i { font-size: 1.2rem; color: var(--white); }
        .stat-info .num { font-size: 1.6rem; font-weight: 800; color: var(--dark); font-family: 'Poppins', sans-serif; line-height: 1; }
        .stat-info .lbl { font-size: 0.8rem; color: var(--text); margin-top: 4px; }

        /* Action cards grid */
        .section-heading {
            font-size: 1rem;
            font-weight: 700;
            color: var(--dark);
            font-family: 'Poppins', sans-serif;
            margin-bottom: 20px;
        }
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
        }
        .action-card {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 24px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 14px;
            box-shadow: var(--shadow);
            transition: all 0.3s;
            cursor: pointer;
        }
        .action-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 32px rgba(108,99,255,0.14);
            border-color: var(--primary);
            text-decoration: none;
        }
        .action-card-icon {
            width: 48px; height: 48px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
        }
        .action-card-icon i { font-size: 1.2rem; color: var(--white); }
        .action-card h4 {
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--dark);
            font-family: 'Poppins', sans-serif;
            margin: 0;
        }
        .action-card p {
            font-size: 0.8rem;
            color: var(--text);
            margin: 0;
            line-height: 1.5;
        }
        .action-card .arrow {
            margin-top: auto;
            font-size: 0.8rem;
            color: var(--primary);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        /* Responsive */
        @media (max-width: 900px) {
            .sidebar { transform: translateX(-100%); }
            .main { margin-left: 0; }
            .welcome-card { flex-direction: column; gap: 20px; }
        }
    </style>
</head>
<body>

<%
    UserInfo loggedUser = (UserInfo) session.getAttribute("User");
    String username = (loggedUser != null) ? loggedUser.getUsername() : "Admin";
    String dpImage = (loggedUser != null && loggedUser.getDp() != null && !loggedUser.getDp().trim().isEmpty())
                     ? loggedUser.getDp() : "Dp1.png";
%>

<!-- ===== SIDEBAR ===== -->
<aside class="sidebar">
    <div class="sidebar-brand">
        <i class="fa fa-book-reader"></i>Edu<span>kate</span>
    </div>

    <div class="sidebar-section-label">Main Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/adminhome" class="nav-item active">
            <i class="fa fa-th-large"></i> Dashboard
        </a>
        <a href="<%=request.getContextPath()%>/addQuiz" class="nav-item">
            <i class="fa fa-plus-circle"></i> Add New Quiz
        </a>
        <a href="<%=request.getContextPath()%>/updateQuiz" class="nav-item">
            <i class="fa fa-edit"></i> Update Quiz
        </a>
        <a href="<%=request.getContextPath()%>/deleteQuiz" class="nav-item">
            <i class="fa fa-trash-alt"></i> Delete Quiz
        </a>
        <a href="<%=request.getContextPath()%>/getAllQuizes" class="nav-item">
            <i class="fa fa-list"></i> All Quizzes
        </a>
        <a href="<%=request.getContextPath()%>/questionManagement" class="nav-item">
            <i class="fa fa-question-circle"></i> Question Management
        </a>
        <a href="<%=request.getContextPath()%>/getAllStudents" class="nav-item">
            <i class="fa fa-users"></i> Enrolled Students
        </a>
        <a href="<%=request.getContextPath()%>/updateAdminProfile" class="nav-item">
            <i class="fa fa-user-cog"></i> My Profile
        </a>
    </nav>

    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn">
            <i class="fa fa-sign-out-alt"></i> Logout
        </a>
    </div>
</aside>

<!-- ===== MAIN ===== -->
<div class="main">

    <!-- Top Bar -->
    <div class="topbar">
        <div class="topbar-left">
            <h1>Admin Dashboard</h1>
            <p>Manage quizzes, students and platform settings</p>
        </div>
        <div class="topbar-right">
            <div class="user-chip">
                <img src="<%=request.getContextPath()%>/resources/dp/<%=dpImage%>" alt="Profile">
                <span><%=username%></span>
                <span class="role-badge">Admin</span>
            </div>
        </div>
    </div>

    <!-- Content -->
    <div class="content">

        <%-- Message Display — logic unchanged --%>
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert-success-box">
            <i class="fa fa-check-circle"></i> <%=msg%>
        </div>
        <% } %>

        <!-- Welcome Banner -->
        <div class="welcome-card">
            <div class="welcome-text">
                <h2>Welcome back, <%=username%>! 👋</h2>
                <p>Here's a quick overview of your platform. Manage everything from here.</p>
            </div>
            <div class="welcome-icon">
                <i class="fa fa-user-shield"></i>
            </div>
        </div>

        <!-- Stats Row -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg,#6c63ff,#4f46e5);">
                    <i class="fa fa-book"></i>
                </div>
                <div class="stat-info">
                    <div class="num">${totalQuizzes}</div>
                    <div class="lbl">Total Quizzes</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg,#10b981,#059669);">
                    <i class="fa fa-users"></i>
                </div>
                <div class="stat-info">
                    <div class="num">${totalStudents}</div>
                    <div class="lbl">Enrolled Students</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg,#f97316,#ef4444);">
                    <i class="fa fa-question-circle"></i>
                </div>
                <div class="stat-info">
                    <div class="num">${totalQuestions}</div>
                    <div class="lbl">Total Questions</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg,#f59e0b,#d97706);">
                    <i class="fa fa-chart-bar"></i>
                </div>
                <div class="stat-info">
                    <div class="num">${totalResults}</div>
                    <div class="lbl">Results Submitted</div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="section-heading">Quick Actions</div>
        <div class="actions-grid">

            <a href="<%=request.getContextPath()%>/addQuiz" class="action-card">
                <div class="action-card-icon" style="background: linear-gradient(135deg,#6c63ff,#4f46e5);">
                    <i class="fa fa-plus-circle"></i>
                </div>
                <h4>Add New Quiz</h4>
                <p>Create a new quiz and assign questions to it.</p>
                <span class="arrow">Go <i class="fa fa-arrow-right"></i></span>
            </a>

            <a href="<%=request.getContextPath()%>/updateQuiz" class="action-card">
                <div class="action-card-icon" style="background: linear-gradient(135deg,#f97316,#ea580c);">
                    <i class="fa fa-edit"></i>
                </div>
                <h4>Update Quiz</h4>
                <p>Modify existing quiz details and settings.</p>
                <span class="arrow">Go <i class="fa fa-arrow-right"></i></span>
            </a>

            <a href="<%=request.getContextPath()%>/deleteQuiz" class="action-card">
                <div class="action-card-icon" style="background: linear-gradient(135deg,#ef4444,#dc2626);">
                    <i class="fa fa-trash-alt"></i>
                </div>
                <h4>Delete Quiz</h4>
                <p>Remove quizzes that are no longer needed.</p>
                <span class="arrow">Go <i class="fa fa-arrow-right"></i></span>
            </a>

            <a href="<%=request.getContextPath()%>/getAllQuizes" class="action-card">
                <div class="action-card-icon" style="background: linear-gradient(135deg,#10b981,#059669);">
                    <i class="fa fa-list"></i>
                </div>
                <h4>All Quizzes</h4>
                <p>View and manage all quizzes on the platform.</p>
                <span class="arrow">Go <i class="fa fa-arrow-right"></i></span>
            </a>

            <a href="<%=request.getContextPath()%>/questionManagement" class="action-card">
                <div class="action-card-icon" style="background: linear-gradient(135deg,#8b5cf6,#7c3aed);">
                    <i class="fa fa-question-circle"></i>
                </div>
                <h4>Question Management</h4>
                <p>Add, update, or delete questions for quizzes.</p>
                <span class="arrow">Go <i class="fa fa-arrow-right"></i></span>
            </a>

            <a href="<%=request.getContextPath()%>/getAllStudents" class="action-card">
                <div class="action-card-icon" style="background: linear-gradient(135deg,#f59e0b,#d97706);">
                    <i class="fa fa-users"></i>
                </div>
                <h4>Enrolled Students</h4>
                <p>View all registered students and manage accounts.</p>
                <span class="arrow">Go <i class="fa fa-arrow-right"></i></span>
            </a>

            <a href="<%=request.getContextPath()%>/updateAdminProfile" class="action-card">
                <div class="action-card-icon" style="background: linear-gradient(135deg,#06b6d4,#0891b2);">
                    <i class="fa fa-user-cog"></i>
                </div>
                <h4>My Profile</h4>
                <p>Update your admin profile details and photo.</p>
                <span class="arrow">Go <i class="fa fa-arrow-right"></i></span>
            </a>

        </div>
    </div>
</div>

</body>
</html>
