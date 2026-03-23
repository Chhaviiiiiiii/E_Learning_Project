<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Feedback - Edukate</title>
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
        .content { padding:32px; flex:1; display:flex; justify-content:center; }
        /* Alert */
        .alert-success { background:#f0fdf4; border:1px solid #bbf7d0; color:#166534; padding:13px 18px; border-radius:var(--radius); font-size:0.88rem; display:flex; align-items:center; gap:10px; margin-bottom:24px; }
        /* Form card */
        .form-card { background:var(--white); border-radius:var(--radius); border:1px solid var(--border); box-shadow:var(--shadow); width:100%; max-width:560px; align-self:flex-start; overflow:hidden; }
        .form-card-header { padding:22px 28px; border-bottom:1px solid var(--border); display:flex; align-items:center; gap:14px; }
        .form-card-header .icon { width:44px; height:44px; background:linear-gradient(135deg,#3b82f6,#2563eb); border-radius:10px; display:flex; align-items:center; justify-content:center; }
        .form-card-header .icon i { color:#fff; font-size:1rem; }
        .form-card-header h2 { font-family:'Poppins',sans-serif; font-size:1.05rem; font-weight:700; color:var(--dark); margin:0; }
        .form-card-header p { font-size:0.78rem; color:var(--text); margin:2px 0 0; }
        .form-body { padding:28px; }
        /* Rating options — styled pill cards */
        .rating-label { font-size:0.82rem; font-weight:600; color:#334155; margin-bottom:14px; display:block; }
        .rating-options { display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:28px; }
        .rating-option { position:relative; }
        .rating-option input[type="radio"] { position:absolute; opacity:0; width:0; height:0; }
        .rating-option label { display:flex; align-items:center; gap:10px; padding:13px 16px; border:1.5px solid var(--border); border-radius:10px; cursor:pointer; font-size:0.88rem; font-weight:600; color:var(--text); transition:all 0.2s; background:var(--white); }
        .rating-option label .opt-icon { font-size:1.2rem; }
        .rating-option input[type="radio"]:checked + label { border-color:var(--primary); background:rgba(108,99,255,0.06); color:var(--primary); }
        .rating-option label:hover { border-color:#a5b4fc; background:#fafbff; }
        /* Submit button */
        .btn-submit { width:100%; padding:13px; background:linear-gradient(135deg,#6c63ff,#4f46e5); color:#fff; border:none; border-radius:10px; font-size:0.95rem; font-weight:600; font-family:'Inter',sans-serif; cursor:pointer; box-shadow:0 4px 16px rgba(108,99,255,0.3); transition:all 0.3s; display:flex; align-items:center; justify-content:center; gap:8px; }
        .btn-submit:hover { background:linear-gradient(135deg,#4f46e5,#3730a3); transform:translateY(-1px); }
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Student Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/customerhome"    class="nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/studentProfile"  class="nav-item"><i class="fa fa-user"></i> My Profile</a>
        <a href="<%=request.getContextPath()%>/seeQuizes"       class="nav-item"><i class="fa fa-play-circle"></i> Play Quizzes</a>
        <a href="<%=request.getContextPath()%>/studentProgress" class="nav-item"><i class="fa fa-chart-line"></i> My Progress</a>
        <a href="<%=request.getContextPath()%>/feedback"        class="nav-item active"><i class="fa fa-comment-dots"></i> Feedback</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>
<div class="main">
    <div class="topbar">
        <div><h1>Feedback</h1><p>Share your experience with us</p></div>
        <a href="<%=request.getContextPath()%>/customerhome" class="back-btn"><i class="fa fa-arrow-left"></i> Dashboard</a>
    </div>
    <div class="content">
        <div>
            <%-- session msg display + removeAttribute — logic unchanged --%>
            <%
                String msg = (String) session.getAttribute("msg");
                if (msg != null) {
            %>
            <div class="alert-success"><i class="fa fa-check-circle"></i> <%=msg%></div>
            <% session.removeAttribute("msg"); } %>

            <div class="form-card">
                <div class="form-card-header">
                    <div class="icon"><i class="fa fa-comment-dots"></i></div>
                    <div>
                        <h2>Rate Your Experience</h2>
                        <p>Your feedback helps us improve the platform</p>
                    </div>
                </div>
                <div class="form-body">
                    <%-- form action="submitFeedback" and name="rating" — unchanged --%>
                    <form action="submitFeedback" method="post">
                        <span class="rating-label">How was your experience?</span>
                        <div class="rating-options">
                            <div class="rating-option">
                                <input type="radio" id="r-excellent" name="rating" value="Excellent" required>
                                <label for="r-excellent"><span class="opt-icon">🌟</span> Excellent</label>
                            </div>
                            <div class="rating-option">
                                <input type="radio" id="r-good" name="rating" value="Good">
                                <label for="r-good"><span class="opt-icon">😊</span> Good</label>
                            </div>
                            <div class="rating-option">
                                <input type="radio" id="r-average" name="rating" value="Average">
                                <label for="r-average"><span class="opt-icon">😐</span> Average</label>
                            </div>
                            <div class="rating-option">
                                <input type="radio" id="r-poor" name="rating" value="Poor">
                                <label for="r-poor"><span class="opt-icon">😞</span> Poor</label>
                            </div>
                        </div>
                        <button type="submit" class="btn-submit">
                            <i class="fa fa-paper-plane"></i> Submit Feedback
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>