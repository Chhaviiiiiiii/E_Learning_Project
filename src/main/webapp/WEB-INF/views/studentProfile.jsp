<%@page import="com.cdgi.pojo.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Profile - Edukate</title>
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
        .logout-btn { color:#f87171; } .logout-btn:hover { background:rgba(239,68,68,0.1); color:#ef4444; }
        .main { margin-left:var(--sidebar-w); flex:1; display:flex; flex-direction:column; }
        .topbar { background:var(--white); border-bottom:1px solid var(--border); padding:0 32px; height:64px; display:flex; align-items:center; justify-content:space-between; position:sticky; top:0; z-index:50; box-shadow:0 1px 12px rgba(15,23,42,0.05); }
        .topbar h1 { font-size:1.1rem; font-weight:700; color:var(--dark); font-family:'Poppins',sans-serif; }
        .topbar p { font-size:0.8rem; color:var(--text); margin-top:1px; }
        .back-btn { display:flex; align-items:center; gap:8px; padding:8px 16px; background:var(--light-bg); border:1px solid var(--border); border-radius:8px; color:var(--text); font-size:0.85rem; font-weight:500; }
        .back-btn:hover { color:var(--primary); border-color:var(--primary); }
        .content { padding:32px; flex:1; }
        .alert-msg { background:#fffbeb; border:1px solid #fde68a; color:#92400e; padding:13px 18px; border-radius:var(--radius); font-size:0.88rem; margin-bottom:24px; display:flex; align-items:center; gap:10px; }
        /* Profile banner */
        .profile-banner { background:linear-gradient(135deg,var(--dark) 0%,#1a1060 100%); border-radius:var(--radius); padding:30px 32px; margin-bottom:28px; display:flex; align-items:center; gap:22px; position:relative; overflow:hidden; }
        .profile-banner::before { content:''; position:absolute; width:250px; height:250px; background:radial-gradient(circle,rgba(108,99,255,0.2) 0%,transparent 70%); top:-80px; right:-60px; border-radius:50%; pointer-events:none; }
        .avatar-wrap { position:relative; z-index:1; flex-shrink:0; }
        .avatar-img  { width:72px; height:72px; border-radius:50%; object-fit:cover; border:3px solid rgba(129,140,248,0.5); }
        .avatar-init { width:72px; height:72px; border-radius:50%; background:linear-gradient(135deg,#6c63ff,#4f46e5); display:flex; align-items:center; justify-content:center; font-size:1.7rem; font-weight:700; color:#fff; border:3px solid rgba(129,140,248,0.5); }
        .banner-info { position:relative; z-index:1; }
        .banner-info h2 { font-family:'Poppins',sans-serif; font-size:1.2rem; font-weight:700; color:#fff; }
        .banner-info p  { color:#94a3b8; font-size:0.82rem; margin-top:3px; }
        .active-pill   { display:inline-flex; align-items:center; gap:5px; background:rgba(16,185,129,0.2); color:#34d399; font-size:0.72rem; font-weight:700; padding:3px 10px; border-radius:50px; margin-top:8px; }
        .active-pill::before { content:''; width:6px; height:6px; border-radius:50%; background:currentColor; }
        /* Info grid */
        .info-card { background:var(--white); border-radius:var(--radius); border:1px solid var(--border); box-shadow:var(--shadow); overflow:hidden; }
        .info-card-header { padding:16px 24px; border-bottom:1px solid var(--border); display:flex; align-items:center; gap:10px; }
        .info-card-header i { color:var(--primary); } .info-card-header h3 { font-family:'Poppins',sans-serif; font-size:0.95rem; font-weight:700; color:var(--dark); margin:0; }
        .info-grid { display:grid; grid-template-columns:1fr 1fr; }
        .info-cell { padding:14px 24px; border-bottom:1px solid #f1f5f9; }
        .info-cell:nth-child(odd) { border-right:1px solid #f1f5f9; }
        .info-cell.full { grid-column:1/-1; border-right:none; }
        .info-label { font-size:0.7rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px; color:#94a3b8; margin-bottom:4px; }
        .info-value { font-size:0.875rem; font-weight:600; color:var(--dark); }
        .card-footer-btns { padding:20px 24px; border-top:1px solid var(--border); display:flex; gap:12px; }
        .btn-edit { display:inline-flex; align-items:center; gap:6px; padding:10px 20px; background:linear-gradient(135deg,#f59e0b,#d97706); color:#fff; border-radius:9px; font-size:0.88rem; font-weight:600; box-shadow:0 4px 12px rgba(245,158,11,0.3); transition:all 0.2s; }
        .btn-edit:hover { transform:translateY(-1px); color:#fff; }
        .btn-back-link { display:inline-flex; align-items:center; gap:6px; padding:10px 20px; background:var(--white); border:1.5px solid var(--border); color:var(--text); border-radius:9px; font-size:0.88rem; font-weight:600; transition:all 0.2s; }
        .btn-back-link:hover { border-color:var(--primary); color:var(--primary); }
    </style>
</head>
<body>
<%
    /* Business logic unchanged — same attribute reads */
    UserInfo user = (UserInfo) request.getAttribute("user");
    String uName      = (user != null && user.getUsername()  != null) ? user.getUsername()  : "";
    String uEmail     = (user != null && user.getEmail()     != null) ? user.getEmail()     : "—";
    String uPhone     = (user != null && user.getPhone()     != null) ? user.getPhone()     : "—";
    String uDob       = (user != null && user.getDob()       != null) ? user.getDob()       : "—";
    String uGender    = (user != null && user.getGender()    != null) ? user.getGender()    : "—";
    String uEducation = (user != null && user.getEducation() != null) ? user.getEducation() : "—";
    String uState     = (user != null && user.getState()     != null) ? user.getState()     : "—";
    String uCountry   = (user != null && user.getCountry()   != null) ? user.getCountry()   : "—";
    String uAddress   = (user != null && user.getAddress()   != null) ? user.getAddress()   : "—";
    String uDp        = (user != null && user.getDp()        != null) ? user.getDp()        : "";
    String initial    = uName.isEmpty() ? "S" : String.valueOf(uName.charAt(0)).toUpperCase();
%>
<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Student Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/customerhome"    class="nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/studentProfile"  class="nav-item active"><i class="fa fa-user"></i> My Profile</a>
        <a href="<%=request.getContextPath()%>/seeQuizes"       class="nav-item"><i class="fa fa-play-circle"></i> Play Quizzes</a>
        <a href="<%=request.getContextPath()%>/studentProgress" class="nav-item"><i class="fa fa-chart-line"></i> My Progress</a>
        <a href="<%=request.getContextPath()%>/feedback"        class="nav-item"><i class="fa fa-comment-dots"></i> Feedback</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>
<div class="main">
    <div class="topbar">
        <div><h1>My Profile</h1><p>View your personal details</p></div>
        <a href="customerhome" class="back-btn"><i class="fa fa-arrow-left"></i> Dashboard</a>
    </div>
    <div class="content">
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %><div class="alert-msg"><i class="fa fa-info-circle"></i> <%=msg%></div><% } %>
        <div class="profile-banner">
            <div class="avatar-wrap">
                <% if (!uDp.isEmpty()) { %>
                    <img src="<%=request.getContextPath()%>/resources/dp/<%=uDp%>" class="avatar-img" alt="avatar"
                         onerror="this.style.display='none';this.nextElementSibling.style.display='flex';">
                    <div class="avatar-init" style="display:none;"><%=initial%></div>
                <% } else { %>
                    <div class="avatar-init"><%=initial%></div>
                <% } %>
            </div>
            <div class="banner-info">
                <h2><%=uName.isEmpty() ? "Student" : uName%></h2>
                <p><%=uEmail%></p>
                <span class="active-pill">Active</span>
            </div>
        </div>
        <div class="info-card">
            <div class="info-card-header"><i class="fa fa-id-card"></i><h3>Profile Details</h3></div>
            <div class="info-grid">
                <div class="info-cell"><div class="info-label">Username</div><div class="info-value"><%=user.getUsername()%></div></div>
                <div class="info-cell"><div class="info-label">Email</div><div class="info-value"><%=user.getEmail()%></div></div>
                <div class="info-cell"><div class="info-label">Phone</div><div class="info-value"><%=uPhone%></div></div>
                <div class="info-cell"><div class="info-label">Date of Birth</div><div class="info-value"><%=uDob%></div></div>
                <div class="info-cell"><div class="info-label">Gender</div><div class="info-value"><%=uGender%></div></div>
                <div class="info-cell"><div class="info-label">Education</div><div class="info-value"><%=uEducation%></div></div>
                <div class="info-cell"><div class="info-label">State</div><div class="info-value"><%=uState%></div></div>
                <div class="info-cell"><div class="info-label">Country</div><div class="info-value"><%=uCountry%></div></div>
                <div class="info-cell full"><div class="info-label">Address</div><div class="info-value"><%=uAddress%></div></div>
            </div>
            <div class="card-footer-btns">
                <%-- hrefs unchanged --%>
                <a href="editProfile" class="btn-edit"><i class="fa fa-pen"></i> Edit Profile</a>
                <a href="customerhome" class="btn-back-link"><i class="fa fa-arrow-left"></i> Back</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>