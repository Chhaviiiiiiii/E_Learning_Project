<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cdgi.pojo.Result"%>
<%@ page import="com.cdgi.pojo.UserInfo"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Progress - Edukate</title>
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
        .logout-btn { color:#f87171; } .logout-btn:hover { background:rgba(239,68,68,0.1); color:#ef4444; }
        .main { margin-left:var(--sidebar-w); flex:1; display:flex; flex-direction:column; }
        .topbar { background:var(--white); border-bottom:1px solid var(--border); padding:0 32px; height:64px; display:flex; align-items:center; justify-content:space-between; position:sticky; top:0; z-index:50; box-shadow:0 1px 12px rgba(15,23,42,0.05); }
        .topbar h1 { font-size:1.1rem; font-weight:700; color:var(--dark); font-family:'Poppins',sans-serif; }
        .topbar p { font-size:0.8rem; color:var(--text); margin-top:1px; }
        .back-btn { display:flex; align-items:center; gap:8px; padding:8px 16px; background:var(--light-bg); border:1px solid var(--border); border-radius:8px; color:var(--text); font-size:0.85rem; font-weight:500; }
        .back-btn:hover { color:var(--primary); border-color:var(--primary); }
        .content { padding:32px; flex:1; }
        /* Table */
        .table-card { background:var(--white); border-radius:var(--radius); border:1px solid var(--border); box-shadow:var(--shadow); overflow:hidden; }
        .table-card-header { padding:18px 24px; border-bottom:1px solid var(--border); display:flex; align-items:center; gap:10px; }
        .table-card-header i { color:var(--primary); }
        .table-card-header h2 { font-family:'Poppins',sans-serif; font-size:0.95rem; font-weight:700; color:var(--dark); margin:0; }
        .data-table { width:100%; border-collapse:collapse; }
        .data-table thead th { background:#f1f5f9; padding:11px 16px; font-size:0.75rem; font-weight:700; color:#64748b; text-transform:uppercase; letter-spacing:0.5px; text-align:left; border-bottom:1px solid var(--border); }
        .data-table tbody tr { border-bottom:1px solid #f1f5f9; transition:background 0.15s; }
        .data-table tbody tr:last-child { border-bottom:none; }
        .data-table tbody tr:hover { background:#fafbff; }
        .data-table td { padding:14px 16px; font-size:0.875rem; color:var(--dark); vertical-align:middle; }
        .quiz-id { font-family:monospace; background:#f1f5f9; color:#64748b; padding:2px 8px; border-radius:5px; font-size:0.8rem; }
        .score-val { font-weight:700; font-size:1rem; color:var(--dark); }
        /* Status badges — styled but PASS/FAIL logic unchanged (score>=5) */
        .badge-pass { display:inline-flex; align-items:center; gap:5px; background:#ecfdf5; color:#059669; font-size:0.75rem; font-weight:700; padding:5px 12px; border-radius:50px; }
        .badge-pass::before { content:''; width:6px; height:6px; border-radius:50%; background:#059669; }
        .badge-fail { display:inline-flex; align-items:center; gap:5px; background:#fef2f2; color:#dc2626; font-size:0.75rem; font-weight:700; padding:5px 12px; border-radius:50px; }
        .badge-fail::before { content:''; width:6px; height:6px; border-radius:50%; background:#dc2626; }
        .empty-state { padding:60px 24px; text-align:center; color:#94a3b8; }
        .empty-state i { font-size:2.5rem; margin-bottom:12px; display:block; color:#cbd5e1; }
    </style>
</head>
<body>
<%
    /* Business logic unchanged — same attribute reads */
    List<Result> list = (List<Result>) request.getAttribute("resultList");
    UserInfo loggedUser = (UserInfo) session.getAttribute("User");
%>
<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Student Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/customerhome"    class="nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/studentProfile"  class="nav-item"><i class="fa fa-user"></i> My Profile</a>
        <a href="<%=request.getContextPath()%>/seeQuizes"       class="nav-item"><i class="fa fa-play-circle"></i> Play Quizzes</a>
        <a href="<%=request.getContextPath()%>/studentProgress" class="nav-item active"><i class="fa fa-chart-line"></i> My Progress</a>
        <a href="<%=request.getContextPath()%>/feedback"        class="nav-item"><i class="fa fa-comment-dots"></i> Feedback</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>
<div class="main">
    <div class="topbar">
        <div><h1>My Progress</h1><p>Track your quiz results</p></div>
        <%-- Role-based back link — logic unchanged --%>
        <% if (loggedUser != null && loggedUser.getRole().equals("ADMIN")) { %>
            <a href="adminhome" class="back-btn"><i class="fa fa-arrow-left"></i> Admin Home</a>
        <% } else { %>
            <a href="customerhome" class="back-btn"><i class="fa fa-arrow-left"></i> Dashboard</a>
        <% } %>
    </div>
    <div class="content">
        <div class="table-card">
            <div class="table-card-header">
                <i class="fa fa-chart-line"></i>
                <h2>Quiz Results</h2>
            </div>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Quiz ID</th>
                        <th>Marks Obtained</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    /* Business logic unchanged — same resultList attribute, r.getQuizid(), r.getScore(), score>=5 check */
                    if (list != null && list.size() > 0) {
                        int i = 1;
                        for (Result r : list) {
                            int score = r.getScore();
                %>
                <tr>
                    <td style="color:#94a3b8;font-size:0.82rem;"><%=i++%></td>
                    <td><span class="quiz-id">#<%=r.getQuizid()%></span></td>
                    <td><span class="score-val"><%=score%></span></td>
                    <td>
                        <% if (score >= 5) { %>
                            <span class="badge-pass">PASS</span>
                        <% } else { %>
                            <span class="badge-fail">FAIL</span>
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="4">
                    <div class="empty-state"><i class="fa fa-inbox"></i><p>No results yet. Start a quiz to see your progress!</p></div>
                </td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>