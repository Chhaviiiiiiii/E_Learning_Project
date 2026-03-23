<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update Admin Profile - Edukate</title>
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
        .back-btn:hover { color: var(--primary); border-color: var(--primary); }
        .content { padding: 32px; flex: 1; }

        /* Alerts */
        .alert-success { background: #f0fdf4; border: 1px solid #bbf7d0; color: #166534; padding: 13px 18px; border-radius: var(--radius); font-size: 0.88rem; display: flex; align-items: center; gap: 10px; margin-bottom: 24px; }
        .alert-error   { background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; padding: 13px 18px; border-radius: var(--radius); font-size: 0.88rem; display: flex; align-items: center; gap: 10px; margin-bottom: 24px; }

        /* Profile banner */
        .profile-banner {
            display: flex; align-items: center; gap: 24px;
            background: linear-gradient(135deg, var(--dark) 0%, #1a1060 100%);
            border-radius: var(--radius); padding: 28px 32px; margin-bottom: 28px;
            position: relative; overflow: hidden;
        }
        .profile-banner::after {
            content: ''; position: absolute;
            width: 220px; height: 220px;
            background: radial-gradient(circle, rgba(108,99,255,0.25) 0%, transparent 70%);
            top: -60px; right: -40px; border-radius: 50%;
        }
        .dp-wrap { position: relative; z-index: 1; }
        .dp-wrap img { width: 72px; height: 72px; border-radius: 50%; object-fit: cover; border: 3px solid rgba(129,140,248,0.5); }
        .dp-fallback { width: 72px; height: 72px; border-radius: 50%; background: linear-gradient(135deg,#6c63ff,#4f46e5); display: flex; align-items: center; justify-content: center; font-size: 1.8rem; font-weight: 700; color: #fff; border: 3px solid rgba(129,140,248,0.5); }
        .banner-info { position: relative; z-index: 1; }
        .banner-info h2 { font-family: 'Poppins', sans-serif; font-size: 1.2rem; font-weight: 700; color: #fff; margin-bottom: 4px; }
        .banner-info p { color: #94a3b8; font-size: 0.85rem; }
        .banner-info .role-tag { display: inline-flex; align-items: center; gap: 5px; background: rgba(129,140,248,0.2); color: #a5b4fc; font-size: 0.75rem; font-weight: 600; padding: 3px 10px; border-radius: 50px; margin-top: 6px; }

        /* Form card */
        .form-card { background: var(--white); border-radius: var(--radius); border: 1px solid var(--border); box-shadow: var(--shadow); }
        .form-card-header { padding: 20px 28px; border-bottom: 1px solid var(--border); display: flex; align-items: center; gap: 12px; }
        .form-card-header i { color: var(--primary); font-size: 1rem; }
        .form-card-header h3 { font-family: 'Poppins', sans-serif; font-size: 0.95rem; font-weight: 700; color: var(--dark); margin: 0; }
        .form-body { padding: 28px; }

        /* Two-column grid */
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-grid .full-width { grid-column: 1 / -1; }
        .form-group { display: flex; flex-direction: column; gap: 7px; }
        .form-group label { font-size: 0.82rem; font-weight: 600; color: #334155; display: flex; align-items: center; gap: 6px; }
        .form-group label i { color: #94a3b8; font-size: 0.75rem; }
        .form-group input[type="text"],
        .form-group input[type="date"],
        .form-group select {
            padding: 11px 14px; border: 1.5px solid var(--border); border-radius: 8px;
            font-size: 0.88rem; font-family: 'Inter', sans-serif; color: var(--dark);
            background: #fff; outline: none; transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-group input:focus, .form-group select:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(108,99,255,0.1); }
        .form-group select { appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%2394a3b8' d='M1 1l5 5 5-5'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 14px center; padding-right: 36px; }

        /* File input */
        .file-wrap { position: relative; }
        .file-wrap input[type="file"] { width: 100%; padding: 10px 14px; border: 1.5px dashed var(--border); border-radius: 8px; font-size: 0.85rem; font-family: 'Inter', sans-serif; color: #64748b; background: #f8fafc; cursor: pointer; }
        .file-wrap input[type="file"]:hover { border-color: var(--primary); }

        /* Form footer */
        .form-footer { display: flex; gap: 12px; margin-top: 28px; padding-top: 24px; border-top: 1px solid var(--border); }
        .btn-submit { flex: 1; padding: 13px; background: linear-gradient(135deg, #6c63ff, #4f46e5); color: #fff; border: none; border-radius: 10px; font-size: 0.95rem; font-weight: 600; font-family: 'Inter', sans-serif; cursor: pointer; box-shadow: 0 4px 16px rgba(108,99,255,0.3); transition: all 0.3s; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-submit:hover { background: linear-gradient(135deg, #4f46e5, #3730a3); transform: translateY(-1px); }
        .btn-cancel { padding: 13px 24px; background: var(--white); color: var(--text); border: 1.5px solid var(--border); border-radius: 10px; font-size: 0.95rem; font-weight: 600; font-family: 'Inter', sans-serif; cursor: pointer; transition: all 0.2s; }
        .btn-cancel:hover { border-color: var(--primary); color: var(--primary); }

        @media (max-width: 680px) { .form-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>

<%
    /* Read user from session (set by controller via request.setAttribute) */
    UserInfo user = (UserInfo) request.getAttribute("user");
    if (user == null) user = (UserInfo) session.getAttribute("User"); // fallback

    String uUsername  = (user != null && user.getUsername()  != null) ? user.getUsername()  : "";
    String uPhone     = (user != null && user.getPhone()     != null) ? user.getPhone()     : "";
    String uDob       = (user != null && user.getDob()       != null) ? user.getDob()       : "";
    String uGender    = (user != null && user.getGender()    != null) ? user.getGender()    : "";
    String uEducation = (user != null && user.getEducation() != null) ? user.getEducation() : "";
    String uState     = (user != null && user.getState()     != null) ? user.getState()     : "";
    String uCountry   = (user != null && user.getCountry()   != null) ? user.getCountry()   : "";
    String uAddress   = (user != null && user.getAddress()   != null) ? user.getAddress()   : "";
    String uDp        = (user != null && user.getDp()        != null && !user.getDp().trim().isEmpty())
                        ? user.getDp() : "default.png";
    String initial    = (!uUsername.isEmpty()) ? String.valueOf(uUsername.charAt(0)).toUpperCase() : "A";
%>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Main Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/adminhome" class="nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/addQuiz" class="nav-item"><i class="fa fa-plus-circle"></i> Add New Quiz</a>
        <a href="<%=request.getContextPath()%>/updateQuiz" class="nav-item"><i class="fa fa-edit"></i> Update Quiz</a>
        <a href="<%=request.getContextPath()%>/deleteQuiz" class="nav-item"><i class="fa fa-trash-alt"></i> Delete Quiz</a>
        <a href="<%=request.getContextPath()%>/getAllQuizes" class="nav-item"><i class="fa fa-list"></i> All Quizzes</a>
        <a href="<%=request.getContextPath()%>/questionManagement" class="nav-item"><i class="fa fa-question-circle"></i> Question Management</a>
        <a href="<%=request.getContextPath()%>/getAllStudents" class="nav-item"><i class="fa fa-users"></i> Enrolled Students</a>
        <a href="<%=request.getContextPath()%>/updateAdminProfile" class="nav-item active"><i class="fa fa-user-cog"></i> My Profile</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>

<!-- MAIN -->
<div class="main">
    <div class="topbar">
        <div>
            <h1>My Profile</h1>
            <p>Update your admin profile information</p>
        </div>
        <a href="<%=request.getContextPath()%>/adminhome" class="back-btn">
            <i class="fa fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <div class="content">

        <%-- Message display — logic unchanged --%>
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
                boolean isError = msg.contains("Please fill");
        %>
        <div class="<%= isError ? "alert-error" : "alert-success" %>">
            <i class="fa fa-<%= isError ? "exclamation-circle" : "check-circle" %>"></i>
            <%=msg%>
        </div>
        <% } %>

        <!-- Profile Banner -->
        <div class="profile-banner">
            <div class="dp-wrap">
                <img src="<%=request.getContextPath()%>/resources/dp/<%=uDp%>"
                     alt="Profile Photo"
                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                <div class="dp-fallback" style="display:none;"><%=initial%></div>
            </div>
            <div class="banner-info">
                <h2><%=uUsername.isEmpty() ? "Admin" : uUsername%></h2>
                <p><%=user != null && user.getEmail() != null ? user.getEmail() : ""%></p>
                <span class="role-tag"><i class="fa fa-shield-alt"></i> Administrator</span>
            </div>
        </div>

        <!-- Edit Form -->
        <div class="form-card">
            <div class="form-card-header">
                <i class="fa fa-user-edit"></i>
                <h3>Edit Profile Details</h3>
            </div>
            <div class="form-body">

                <%-- form action, method, enctype — all unchanged --%>
                <form action="updateAdminProfile" method="post" enctype="multipart/form-data">

                    <div class="form-grid">

                        <div class="form-group">
                            <label><i class="fa fa-user"></i> Username</label>
                            <input type="text" name="username" value="<%=uUsername%>" placeholder="Enter username">
                        </div>

                        <div class="form-group">
                            <label><i class="fa fa-phone"></i> Phone</label>
                            <input type="text" name="phone" value="<%=uPhone%>" placeholder="Enter phone number">
                        </div>

                        <div class="form-group">
                            <label><i class="fa fa-calendar"></i> Date of Birth</label>
                            <input type="date" name="dob" value="<%=uDob%>">
                        </div>

                        <div class="form-group">
                            <label><i class="fa fa-venus-mars"></i> Gender</label>
                            <select name="gender">
                                <option value="">-- Select Gender --</option>
                                <option value="Male"   <%="Male".equalsIgnoreCase(uGender)   ? "selected" : ""%>>Male</option>
                                <option value="Female" <%="Female".equalsIgnoreCase(uGender) ? "selected" : ""%>>Female</option>
                                <option value="Other"  <%="Other".equalsIgnoreCase(uGender)  ? "selected" : ""%>>Other</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label><i class="fa fa-graduation-cap"></i> Education</label>
                            <input type="text" name="education" value="<%=uEducation%>" placeholder="Enter education">
                        </div>

                        <div class="form-group">
                            <label><i class="fa fa-map-marker-alt"></i> State</label>
                            <input type="text" name="state" value="<%=uState%>" placeholder="Enter state">
                        </div>

                        <div class="form-group">
                            <label><i class="fa fa-globe"></i> Country</label>
                            <input type="text" name="country" value="<%=uCountry%>" placeholder="Enter country">
                        </div>

                        <div class="form-group full-width">
                            <label><i class="fa fa-home"></i> Address</label>
                            <input type="text" name="address" value="<%=uAddress%>" placeholder="Enter address">
                        </div>

                        <div class="form-group full-width">
                            <label><i class="fa fa-camera"></i> Profile Photo <span style="color:#94a3b8;font-weight:400;">(leave blank to keep current)</span></label>
                            <div class="file-wrap">
                                <input type="file" name="dp" accept="image/*">
                            </div>
                        </div>

                    </div>

                    <div class="form-footer">
                        <button type="submit" class="btn-submit">
                            <i class="fa fa-save"></i> Save Changes
                        </button>
                        <a href="adminhome">
                            <button type="button" class="btn-cancel">Cancel</button>
                        </a>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
