<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>All Students - Edukate Admin</title>
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
        .logout-btn { display:flex; align-items:center; gap:12px; padding:11px 14px; border-radius:8px; color:#f87171; font-size:0.875rem; font-weight:500; width:100%; }
        .logout-btn:hover { background:rgba(239,68,68,0.1); color:#ef4444; }

        .main { margin-left:var(--sidebar-w); flex:1; display:flex; flex-direction:column; }
        .topbar { background:var(--white); border-bottom:1px solid var(--border); padding:0 32px; height:64px; display:flex; align-items:center; justify-content:space-between; position:sticky; top:0; z-index:50; box-shadow:0 1px 12px rgba(15,23,42,0.05); }
        .topbar h1 { font-size:1.1rem; font-weight:700; color:var(--dark); font-family:'Poppins',sans-serif; }
        .topbar p { font-size:0.8rem; color:var(--text); margin-top:1px; }
        .back-btn { display:flex; align-items:center; gap:8px; padding:8px 16px; background:var(--light-bg); border:1px solid var(--border); border-radius:8px; color:var(--text); font-size:0.85rem; font-weight:500; }
        .back-btn:hover { color:var(--primary); border-color:var(--primary); }
        .content { padding:32px; flex:1; }

        .alert-info { background:#eff6ff; border:1px solid #bfdbfe; color:#1d4ed8; padding:13px 18px; border-radius:var(--radius); font-size:0.88rem; display:flex; align-items:center; gap:10px; margin-bottom:24px; }

        /* Table */
        .table-card { background:var(--white); border-radius:var(--radius); border:1px solid var(--border); box-shadow:var(--shadow); overflow:hidden; }
        .table-card-header { padding:20px 24px; border-bottom:1px solid var(--border); display:flex; align-items:center; justify-content:space-between; }
        .table-card-header h2 { font-family:'Poppins',sans-serif; font-size:1rem; font-weight:700; color:var(--dark); display:flex; align-items:center; gap:10px; }
        .table-card-header h2 i { color:var(--primary); }
        .count-badge { background:rgba(108,99,255,0.1); color:var(--primary); font-size:0.78rem; font-weight:700; padding:3px 10px; border-radius:50px; }

        .data-table { width:100%; border-collapse:collapse; }
        .data-table thead th { background:#f1f5f9; padding:12px 16px; font-size:0.78rem; font-weight:700; color:#64748b; text-transform:uppercase; letter-spacing:0.5px; text-align:left; border-bottom:1px solid var(--border); }
        .data-table tbody tr { border-bottom:1px solid #f1f5f9; transition:background 0.15s; }
        .data-table tbody tr:last-child { border-bottom:none; }
        .data-table tbody tr:hover { background:#fafbff; }
        .data-table td { padding:14px 16px; font-size:0.875rem; color:var(--dark); vertical-align:middle; }

        /* Student row */
        .student-profile { display:flex; align-items:center; gap:12px; }
        .avatar { width:38px; height:38px; border-radius:50%; object-fit:cover; border:2px solid var(--border); }
        .avatar-fallback { width:38px; height:38px; border-radius:50%; background:linear-gradient(135deg,#6c63ff,#4f46e5); display:flex; align-items:center; justify-content:center; color:#fff; font-size:0.9rem; font-weight:700; flex-shrink:0; }
        .student-name { font-weight:600; color:var(--dark); }
        .student-email { font-size:0.8rem; color:#64748b; }

        .badge-active { display:inline-flex; align-items:center; gap:5px; background:#ecfdf5; color:#059669; font-size:0.75rem; font-weight:600; padding:5px 12px; border-radius:50px; }
        .badge-active::before { content:''; width:6px; height:6px; background:#059669; border-radius:50%; }
        .badge-blocked { display:inline-flex; align-items:center; gap:5px; background:#fef2f2; color:#dc2626; font-size:0.75rem; font-weight:600; padding:5px 12px; border-radius:50px; }
        .badge-blocked::before { content:''; width:6px; height:6px; background:#dc2626; border-radius:50%; }

        /* Action buttons */
        .actions { display:flex; gap:6px; }
        .btn-view { display:inline-flex; align-items:center; gap:5px; padding:6px 12px; background:#eff6ff; color:#2563eb; border:1px solid #bfdbfe; border-radius:7px; font-size:0.78rem; font-weight:600; }
        .btn-view:hover { background:#dbeafe; color:#1d4ed8; }
        .btn-block { display:inline-flex; align-items:center; justify-content:center; width:32px; height:32px; background:#fef2f2; color:#dc2626; border:1px solid #fecaca; border-radius:7px; font-size:0.85rem; }
        .btn-block:hover { background:#fee2e2; color:#b91c1c; }
        .btn-unblock { display:inline-flex; align-items:center; justify-content:center; width:32px; height:32px; background:#ecfdf5; color:#059669; border:1px solid #bbf7d0; border-radius:7px; font-size:0.85rem; }
        .btn-unblock:hover { background:#dcfce7; color:#047857; }

        .empty-state { padding:60px 24px; text-align:center; color:#94a3b8; }
        .empty-state i { font-size:2.5rem; margin-bottom:12px; color:#cbd5e1; }
        .empty-state p { font-size:0.9rem; }
    </style>
</head>
<body>
<%
    UserInfo loggedUser = (UserInfo) session.getAttribute("User");
    String username = (loggedUser != null) ? loggedUser.getUsername() : "Admin";
    List<UserInfo> studentList = (List<UserInfo>) request.getAttribute("students");
    int total = (studentList != null) ? studentList.size() : 0;
%>

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
        <a href="<%=request.getContextPath()%>/getAllStudents" class="nav-item active"><i class="fa fa-users"></i> Enrolled Students</a>
        <a href="<%=request.getContextPath()%>/updateAdminProfile" class="nav-item"><i class="fa fa-user-cog"></i> My Profile</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>

<div class="main">
    <div class="topbar">
        <div>
            <h1>Enrolled Students</h1>
            <p>Manage all registered students on the platform</p>
        </div>
        <a href="<%=request.getContextPath()%>/adminhome" class="back-btn">
            <i class="fa fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <div class="content">

        <%-- msg display — logic unchanged --%>
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert-info"><i class="fa fa-info-circle"></i> <%=msg%></div>
        <% } %>

        <div class="table-card">
            <div class="table-card-header">
                <h2><i class="fa fa-users"></i> Student List</h2>
                <span class="count-badge"><%=total%> Students</span>
            </div>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Student</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    /* Business logic unchanged — same scriptlet loop, same attributes */
                    if (studentList != null && studentList.size() > 0) {
                        int i = 1;
                        for (UserInfo student : studentList) {
                            String initial = (student.getUsername() != null && !student.getUsername().isEmpty())
                                             ? String.valueOf(student.getUsername().charAt(0)).toUpperCase() : "?";
                %>
                <tr>
                    <td style="color:#94a3b8;font-size:0.82rem;"><%=i++%></td>
                    <td>
                        <div class="student-profile">
                            <img src="<%=request.getContextPath()%>/resources/dp/<%=student.getDp()%>"
                                 class="avatar"
                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                                 alt="avatar">
                            <div class="avatar-fallback" style="display:none;"><%=initial%></div>
                            <div>
                                <div class="student-name"><%=student.getUsername()%></div>
                            </div>
                        </div>
                    </td>
                    <td><span class="student-email"><%=student.getEmail() != null ? student.getEmail() : "N/A"%></span></td>
                    <td>
                        <%-- Status badge — logic unchanged --%>
                        <% if (student.isActive()) { %>
                            <span class="badge-active">Active</span>
                        <% } else { %>
                            <span class="badge-blocked">Blocked</span>
                        <% } %>
                    </td>
                    <td>
                        <%-- All action hrefs unchanged --%>
                        <div class="actions">
                            <a href="<%=request.getContextPath()%>/adminShowStudentProfile?username=<%=student.getUsername()%>"
                               class="btn-view">
                                <i class="fa fa-eye"></i> View
                            </a>
                            <a href="blockStudent?username=<%=student.getUsername()%>"
                               class="btn-block"
                               title="Block Student"
                               onclick="return confirm('Block this student?')">
                                <i class="fa fa-ban"></i>
                            </a>
                            <a href="unblockStudent?username=<%=student.getUsername()%>"
                               class="btn-unblock"
                               title="Unblock Student"
                               onclick="return confirm('Unblock this student?')">
                                <i class="fa fa-check"></i>
                            </a>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">
                        <div class="empty-state">
                            <i class="fa fa-users"></i>
                            <p>No students registered yet.</p>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
