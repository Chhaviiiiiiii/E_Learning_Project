<%@page import="com.cdgi.pojo.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Student Profile - Edukate Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --primary:#6c63ff; --dark:#0f172a; --sidebar-w:260px; --text:#475569; --border:#e2e8f0; --light-bg:#f8fafc; --white:#fff; --radius:12px; --shadow:0 4px 20px rgba(15,23,42,0.07); }
        body { font-family:'Inter',sans-serif; background:var(--light-bg); display:flex; min-height:100vh; }
        a { text-decoration:none; transition:all 0.25s; }

        /* SIDEBAR */
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

        /* MAIN */
        .main { margin-left:var(--sidebar-w); flex:1; display:flex; flex-direction:column; }
        .topbar { background:var(--white); border-bottom:1px solid var(--border); padding:0 32px; height:64px; display:flex; align-items:center; justify-content:space-between; position:sticky; top:0; z-index:50; box-shadow:0 1px 12px rgba(15,23,42,0.05); }
        .topbar h1 { font-size:1.1rem; font-weight:700; color:var(--dark); font-family:'Poppins',sans-serif; }
        .topbar p { font-size:0.8rem; color:var(--text); margin-top:1px; }
        .back-btn { display:flex; align-items:center; gap:8px; padding:8px 16px; background:var(--light-bg); border:1px solid var(--border); border-radius:8px; color:var(--text); font-size:0.85rem; font-weight:500; }
        .back-btn:hover { color:var(--primary); border-color:var(--primary); }
        .content { padding:32px; flex:1; }

        /* Alert */
        .alert-msg { background:#fffbeb; border:1px solid #fde68a; color:#92400e; padding:13px 18px; border-radius:var(--radius); font-size:0.88rem; margin-bottom:24px; display:flex; align-items:center; gap:10px; }

        /* Profile hero banner */
        .profile-banner {
            background:linear-gradient(135deg, var(--dark) 0%, #1a1060 100%);
            border-radius:var(--radius); padding:32px; margin-bottom:28px;
            display:flex; align-items:center; gap:24px; position:relative; overflow:hidden;
        }
        .profile-banner::after {
            content:''; position:absolute; width:260px; height:260px;
            background:radial-gradient(circle, rgba(108,99,255,0.2) 0%, transparent 70%);
            top:-80px; right:-60px; border-radius:50%; pointer-events:none;
        }
        .avatar-wrap { position:relative; z-index:1; flex-shrink:0; }
        .avatar-img { width:80px; height:80px; border-radius:50%; object-fit:cover; border:3px solid rgba(129,140,248,0.5); }
        .avatar-fallback { width:80px; height:80px; border-radius:50%; background:linear-gradient(135deg,#6c63ff,#4f46e5); display:flex; align-items:center; justify-content:center; font-size:2rem; font-weight:700; color:#fff; border:3px solid rgba(129,140,248,0.5); }
        .banner-info { position:relative; z-index:1; }
        .banner-info h2 { font-family:'Poppins',sans-serif; font-size:1.3rem; font-weight:700; color:#fff; margin-bottom:4px; }
        .banner-info p  { color:#94a3b8; font-size:0.85rem; margin-bottom:10px; }
        .status-tag { display:inline-flex; align-items:center; gap:6px; font-size:0.75rem; font-weight:700; padding:4px 12px; border-radius:50px; }
        .status-active   { background:rgba(16,185,129,0.2); color:#34d399; }
        .status-inactive { background:rgba(239,68,68,0.2);  color:#f87171; }
        .status-tag::before { content:''; width:6px; height:6px; border-radius:50%; background:currentColor; }

        /* Info card with grid */
        .info-card { background:var(--white); border-radius:var(--radius); border:1px solid var(--border); box-shadow:var(--shadow); overflow:hidden; }
        .info-card-header { padding:18px 24px; border-bottom:1px solid var(--border); display:flex; align-items:center; gap:10px; }
        .info-card-header i { color:var(--primary); }
        .info-card-header h3 { font-family:'Poppins',sans-serif; font-size:0.95rem; font-weight:700; color:var(--dark); margin:0; }
        .info-grid { display:grid; grid-template-columns:1fr 1fr; }
        .info-row { display:contents; }
        .info-cell { padding:16px 24px; border-bottom:1px solid #f1f5f9; }
        .info-cell:nth-child(odd)  { border-right:1px solid #f1f5f9; }
        .info-cell.full-row { grid-column:1/-1; border-right:none; }
        .info-label { font-size:0.72rem; font-weight:700; text-transform:uppercase; letter-spacing:0.5px; color:#94a3b8; margin-bottom:5px; display:flex; align-items:center; gap:6px; }
        .info-label i { font-size:0.7rem; }
        .info-value { font-size:0.9rem; font-weight:600; color:var(--dark); }
        .info-value.empty { color:#cbd5e1; font-weight:400; font-style:italic; }

        /* Action row */
        .action-row { padding:20px 24px; border-top:1px solid var(--border); display:flex; gap:12px; align-items:center; }
        .btn-block { display:inline-flex; align-items:center; gap:6px; padding:9px 18px; background:#fef2f2; color:#dc2626; border:1.5px solid #fecaca; border-radius:8px; font-size:0.85rem; font-weight:600; }
        .btn-block:hover { background:#fee2e2; color:#b91c1c; }
        .btn-unblock { display:inline-flex; align-items:center; gap:6px; padding:9px 18px; background:#f0fdf4; color:#059669; border:1.5px solid #bbf7d0; border-radius:8px; font-size:0.85rem; font-weight:600; }
        .btn-unblock:hover { background:#dcfce7; color:#047857; }
    </style>
</head>
<body>

<%
    /* Business logic unchanged — same attribute reads */
    UserInfo user = (UserInfo) request.getAttribute("user");

    String uName      = (user != null && user.getUsername()  != null) ? user.getUsername()  : "";
    String uEmail     = (user != null && user.getEmail()     != null) ? user.getEmail()     : "";
    String uPhone     = (user != null && user.getPhone()     != null) ? user.getPhone()     : "—";
    String uDob       = (user != null && user.getDob()       != null) ? user.getDob()       : "—";
    String uGender    = (user != null && user.getGender()    != null) ? user.getGender()    : "—";
    String uEducation = (user != null && user.getEducation() != null) ? user.getEducation() : "—";
    String uState     = (user != null && user.getState()     != null) ? user.getState()     : "—";
    String uCountry   = (user != null && user.getCountry()   != null) ? user.getCountry()   : "—";
    String uAddress   = (user != null && user.getAddress()   != null) ? user.getAddress()   : "—";
    String uDp        = (user != null && user.getDp()        != null && !user.getDp().trim().isEmpty()) ? user.getDp() : "";
    boolean isActive  = (user != null) && user.isActive();
    String initial    = (!uName.isEmpty()) ? String.valueOf(uName.charAt(0)).toUpperCase() : "S";
%>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Main Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/adminhome"          class="nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/addQuiz"            class="nav-item"><i class="fa fa-plus-circle"></i> Add New Quiz</a>
        <a href="<%=request.getContextPath()%>/updateQuiz"         class="nav-item"><i class="fa fa-edit"></i> Update Quiz</a>
        <a href="<%=request.getContextPath()%>/deleteQuiz"         class="nav-item"><i class="fa fa-trash-alt"></i> Delete Quiz</a>
        <a href="<%=request.getContextPath()%>/getAllQuizes"        class="nav-item"><i class="fa fa-list"></i> All Quizzes</a>
        <a href="<%=request.getContextPath()%>/questionManagement" class="nav-item"><i class="fa fa-question-circle"></i> Question Management</a>
        <a href="<%=request.getContextPath()%>/getAllStudents"      class="nav-item active"><i class="fa fa-users"></i> Enrolled Students</a>
        <a href="<%=request.getContextPath()%>/updateAdminProfile"  class="nav-item"><i class="fa fa-user-cog"></i> My Profile</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>

<!-- MAIN -->
<div class="main">
    <div class="topbar">
        <div>
            <h1>Student Profile</h1>
            <p>Viewing profile of <%=uName%></p>
        </div>
        <%-- back link unchanged --%>
        <a href="getAllStudents" class="back-btn"><i class="fa fa-arrow-left"></i> Back to Students</a>
    </div>

    <div class="content">

        <%-- msg display — logic unchanged --%>
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert-msg"><i class="fa fa-info-circle"></i> <%=msg%></div>
        <% } %>

        <!-- Profile Banner -->
        <div class="profile-banner">
            <div class="avatar-wrap">
                <% if (!uDp.isEmpty()) { %>
                    <img src="<%=request.getContextPath()%>/resources/dp/<%=uDp%>"
                         class="avatar-img" alt="avatar"
                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                    <div class="avatar-fallback" style="display:none;"><%=initial%></div>
                <% } else { %>
                    <div class="avatar-fallback"><%=initial%></div>
                <% } %>
            </div>
            <div class="banner-info">
                <h2><%=uName%></h2>
                <p><%=uEmail%></p>
                <span class="status-tag <%=isActive ? "status-active" : "status-inactive"%>">
                    <%=isActive ? "Active" : "Blocked"%>
                </span>
            </div>
        </div>

        <!-- Details Card -->
        <div class="info-card">
            <div class="info-card-header">
                <i class="fa fa-id-card"></i>
                <h3>Profile Details</h3>
            </div>

            <div class="info-grid">
                <div class="info-cell">
                    <div class="info-label"><i class="fa fa-user"></i> Username</div>
                    <div class="info-value"><%=uName.isEmpty() ? "—" : uName%></div>
                </div>
                <div class="info-cell">
                    <div class="info-label"><i class="fa fa-envelope"></i> Email</div>
                    <div class="info-value"><%=uEmail.isEmpty() ? "—" : uEmail%></div>
                </div>
                <div class="info-cell">
                    <div class="info-label"><i class="fa fa-phone"></i> Phone</div>
                    <div class="info-value"><%=uPhone%></div>
                </div>
                <div class="info-cell">
                    <div class="info-label"><i class="fa fa-calendar"></i> Date of Birth</div>
                    <div class="info-value"><%=uDob%></div>
                </div>
                <div class="info-cell">
                    <div class="info-label"><i class="fa fa-venus-mars"></i> Gender</div>
                    <div class="info-value"><%=uGender%></div>
                </div>
                <div class="info-cell">
                    <div class="info-label"><i class="fa fa-graduation-cap"></i> Education</div>
                    <div class="info-value"><%=uEducation%></div>
                </div>
                <div class="info-cell">
                    <div class="info-label"><i class="fa fa-map-marker-alt"></i> State</div>
                    <div class="info-value"><%=uState%></div>
                </div>
                <div class="info-cell">
                    <div class="info-label"><i class="fa fa-globe"></i> Country</div>
                    <div class="info-value"><%=uCountry%></div>
                </div>
                <div class="info-cell full-row">
                    <div class="info-label"><i class="fa fa-home"></i> Address</div>
                    <div class="info-value"><%=uAddress%></div>
                </div>
            </div>

            <!-- Block / Unblock actions -->
            <div class="action-row">
                <a href="blockStudent?username=<%=uName%>"
                   class="btn-block"
                   onclick="return confirm('Block this student?')">
                    <i class="fa fa-ban"></i> Block Student
                </a>
                <a href="unblockStudent?username=<%=uName%>"
                   class="btn-unblock"
                   onclick="return confirm('Unblock this student?')">
                    <i class="fa fa-check"></i> Unblock Student
                </a>
            </div>
        </div>

    </div>
</div>

</body>
</html>