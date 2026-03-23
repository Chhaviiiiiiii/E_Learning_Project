<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home - Edukate</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --primary: #6c63ff; --primary-dark: #4f46e5;
            --dark: #0f172a; --sidebar-w: 260px;
            --text: #475569; --border: #e2e8f0;
            --light-bg: #f8fafc; --white: #fff;
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
        .logout-btn { color: #f87171; }
        .logout-btn:hover { background: rgba(239,68,68,0.1); color: #ef4444; }

        /* MAIN */
        .main { margin-left: var(--sidebar-w); flex: 1; display: flex; flex-direction: column; }
        .topbar { background: var(--white); border-bottom: 1px solid var(--border); padding: 0 32px; height: 64px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 50; box-shadow: 0 1px 12px rgba(15,23,42,0.05); }
        .topbar-user { display: flex; align-items: center; gap: 10px; }
        .topbar-avatar { width: 36px; height: 36px; border-radius: 50%; object-fit: cover; border: 2px solid var(--primary); }
        .topbar-name { font-size: 0.875rem; font-weight: 600; color: var(--dark); }
        .content { padding: 32px; flex: 1; }

        /* Alert */
        .alert-msg { background: #f0fdf4; border: 1px solid #bbf7d0; color: #166534; padding: 13px 18px; border-radius: var(--radius); font-size: 0.88rem; display: flex; align-items: center; gap: 10px; margin-bottom: 28px; }

        /* Welcome banner */
        .welcome-banner {
            background: linear-gradient(135deg, var(--dark) 0%, #1a1060 100%);
            border-radius: var(--radius); padding: 32px 36px; margin-bottom: 28px;
            display: flex; align-items: center; justify-content: space-between;
            position: relative; overflow: hidden;
        }
        .welcome-banner::before {
            content: ''; position: absolute;
            width: 300px; height: 300px;
            background: radial-gradient(circle, rgba(108,99,255,0.2) 0%, transparent 70%);
            top: -100px; right: -80px; border-radius: 50%;
        }
        .welcome-text { position: relative; z-index: 1; }
        .welcome-text p { color: #94a3b8; font-size: 0.88rem; margin-bottom: 6px; }
        .welcome-text h1 { font-family: 'Poppins', sans-serif; font-size: 1.7rem; font-weight: 800; color: #fff; line-height: 1.2; }
        .welcome-text h1 span { color: #a5b4fc; }
        .welcome-text .tagline { color: #64748b; font-size: 0.85rem; margin-top: 8px; }
        .welcome-icon { position: relative; z-index: 1; font-size: 4rem; opacity: 0.25; color: #a5b4fc; }

        /* Nav cards grid */
        .nav-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 18px; }

        .nav-card { background: var(--white); border-radius: var(--radius); border: 1px solid var(--border); box-shadow: var(--shadow); padding: 28px 24px; display: flex; align-items: center; gap: 20px; transition: all 0.25s; cursor: pointer; }
        .nav-card:hover { transform: translateY(-4px); box-shadow: 0 12px 30px rgba(15,23,42,0.10); border-color: transparent; }

        .card-icon { width: 52px; height: 52px; border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 1.25rem; flex-shrink: 0; }
        .card-info h3 { font-family: 'Poppins', sans-serif; font-size: 0.95rem; font-weight: 700; color: var(--dark); margin-bottom: 4px; }
        .card-info p  { font-size: 0.78rem; color: var(--text); line-height: 1.4; }

        /* Card themes */
        .card-profile .card-icon { background: linear-gradient(135deg, rgba(108,99,255,0.12), rgba(79,70,229,0.08)); color: #6c63ff; }
        .card-profile:hover { background: linear-gradient(135deg, rgba(108,99,255,0.04), var(--white)); }

        .card-quiz .card-icon { background: linear-gradient(135deg, rgba(245,158,11,0.12), rgba(217,119,6,0.08)); color: #d97706; }
        .card-quiz:hover { background: linear-gradient(135deg, rgba(245,158,11,0.04), var(--white)); }

        .card-progress .card-icon { background: linear-gradient(135deg, rgba(16,185,129,0.12), rgba(5,150,105,0.08)); color: #059669; }
        .card-progress:hover { background: linear-gradient(135deg, rgba(16,185,129,0.04), var(--white)); }

        .card-feedback .card-icon { background: linear-gradient(135deg, rgba(59,130,246,0.12), rgba(37,99,235,0.08)); color: #2563eb; }
        .card-feedback:hover { background: linear-gradient(135deg, rgba(59,130,246,0.04), var(--white)); }

        .card-arrow { margin-left: auto; color: #cbd5e1; font-size: 0.85rem; flex-shrink: 0; transition: transform 0.2s; }
        .nav-card:hover .card-arrow { transform: translateX(4px); color: var(--primary); }

        @media (max-width: 640px) { .nav-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>

<%
    /* Business logic unchanged — same session read */
    UserInfo user = (UserInfo) session.getAttribute("User");
    String uname   = (user != null && user.getUsername() != null) ? user.getUsername() : "Student";
    String uEmail  = (user != null && user.getEmail()    != null) ? user.getEmail()    : "";
    String uDp     = (user != null && user.getDp() != null && !user.getDp().trim().isEmpty())
                     ? user.getDp() : "Dp1.png";
%>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Student Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/customerhome"    class="nav-item active"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/studentProfile"  class="nav-item"><i class="fa fa-user"></i> My Profile</a>
        <a href="<%=request.getContextPath()%>/seeQuizes"       class="nav-item"><i class="fa fa-play-circle"></i> Play Quizzes</a>
        <a href="<%=request.getContextPath()%>/studentProgress" class="nav-item"><i class="fa fa-chart-line"></i> My Progress</a>
        <a href="<%=request.getContextPath()%>/feedback"        class="nav-item"><i class="fa fa-comment-dots"></i> Feedback</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>

<!-- MAIN -->
<div class="main">
    <div class="topbar">
        <div style="font-size:0.9rem;color:var(--text);">Student Dashboard</div>
        <div class="topbar-user">
            <img class="topbar-avatar" src="<%=request.getContextPath()%>/resources/dp/<%=uDp%>" alt="Profile">
            <span class="topbar-name"><%=uname%></span>
        </div>
    </div>

    <div class="content">

        <%-- msg display — logic unchanged --%>
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert-msg"><i class="fa fa-check-circle"></i> <%=msg%></div>
        <% } %>

        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <div class="welcome-text">
                <p>Welcome back 👋</p>
                <h1>Hello, <span><%=uname%>!</span></h1>
                <p class="tagline">Ready to learn something new today? Pick a quiz and get started.</p>
            </div>
            <div class="welcome-icon"><i class="fa fa-graduation-cap"></i></div>
        </div>

        <!-- Navigation Cards — all hrefs unchanged -->
        <div class="nav-grid">

            <a href="<%=request.getContextPath()%>/studentProfile" class="nav-card card-profile">
                <div class="card-icon"><i class="fa fa-user"></i></div>
                <div class="card-info">
                    <h3>My Profile</h3>
                    <p>View and update your personal information</p>
                </div>
                <i class="fa fa-chevron-right card-arrow"></i>
            </a>

            <a href="<%=request.getContextPath()%>/seeQuizes" class="nav-card card-quiz">
                <div class="card-icon"><i class="fa fa-play-circle"></i></div>
                <div class="card-info">
                    <h3>See Quizzes to Play</h3>
                    <p>Browse available quizzes and test your knowledge</p>
                </div>
                <i class="fa fa-chevron-right card-arrow"></i>
            </a>

            <a href="<%=request.getContextPath()%>/studentProgress" class="nav-card card-progress">
                <div class="card-icon"><i class="fa fa-chart-line"></i></div>
                <div class="card-info">
                    <h3>Student Progress</h3>
                    <p>Track your quiz results and performance over time</p>
                </div>
                <i class="fa fa-chevron-right card-arrow"></i>
            </a>

            <a href="<%=request.getContextPath()%>/feedback" class="nav-card card-feedback">
                <div class="card-icon"><i class="fa fa-comment-dots"></i></div>
                <div class="card-info">
                    <h3>Feedback</h3>
                    <p>Share your experience and help improve the platform</p>
                </div>
                <i class="fa fa-chevron-right card-arrow"></i>
            </a>

        </div>
    </div>
</div>

</body>
</html>
