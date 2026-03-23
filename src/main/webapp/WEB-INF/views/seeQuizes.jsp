<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<%@ page import="com.cdgi.pojo.Quiz"%>
<%@ page import="com.cdgi.pojo.UserInfo"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Available Quizzes - Edukate</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <%-- Razorpay script preserved --%>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
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
        .topbar p  { font-size:0.8rem; color:var(--text); margin-top:1px; }
        .back-btn { display:flex; align-items:center; gap:8px; padding:8px 16px; background:var(--light-bg); border:1px solid var(--border); border-radius:8px; color:var(--text); font-size:0.85rem; font-weight:500; }
        .back-btn:hover { color:var(--primary); border-color:var(--primary); }
        .content { padding:32px; flex:1; }
        /* Alert */
        .alert-msg { background:#fef2f2; border:1px solid #fecaca; color:#991b1b; padding:13px 18px; border-radius:var(--radius); font-size:0.88rem; display:flex; align-items:center; gap:10px; margin-bottom:24px; }
        /* Table */
        .table-card { background:var(--white); border-radius:var(--radius); border:1px solid var(--border); box-shadow:var(--shadow); overflow:hidden; }
        .table-card-header { padding:18px 24px; border-bottom:1px solid var(--border); display:flex; align-items:center; justify-content:space-between; }
        .table-card-header h2 { font-family:'Poppins',sans-serif; font-size:0.95rem; font-weight:700; color:var(--dark); display:flex; align-items:center; gap:8px; }
        .table-card-header h2 i { color:var(--primary); }
        .data-table { width:100%; border-collapse:collapse; }
        .data-table thead th { background:#f1f5f9; padding:11px 16px; font-size:0.75rem; font-weight:700; color:#64748b; text-transform:uppercase; letter-spacing:0.5px; text-align:left; border-bottom:1px solid var(--border); }
        .data-table tbody tr { border-bottom:1px solid #f1f5f9; transition:background 0.15s; }
        .data-table tbody tr:last-child { border-bottom:none; }
        .data-table tbody tr:hover { background:#fafbff; }
        .data-table td { padding:14px 16px; font-size:0.875rem; color:var(--dark); vertical-align:middle; }
        .sno { color:#94a3b8; font-size:0.82rem; }
        .quiz-name { font-weight:600; }
        .badge-free { display:inline-flex; align-items:center; gap:4px; background:#ecfdf5; color:#059669; font-size:0.73rem; font-weight:700; padding:3px 9px; border-radius:50px; }
        .badge-paid { display:inline-flex; align-items:center; gap:4px; background:#fff7ed; color:#d97706; font-size:0.73rem; font-weight:700; padding:3px 9px; border-radius:50px; }
        /* Buttons */
        .btn-start { display:inline-flex; align-items:center; gap:6px; padding:7px 16px; background:linear-gradient(135deg,#10b981,#059669); color:#fff; border:none; border-radius:8px; font-size:0.8rem; font-weight:600; font-family:'Inter',sans-serif; cursor:pointer; box-shadow:0 3px 10px rgba(16,185,129,0.25); transition:all 0.2s; }
        .btn-start:hover { transform:translateY(-1px); }
        .btn-subscribe { display:inline-flex; align-items:center; gap:6px; padding:7px 16px; background:linear-gradient(135deg,#f59e0b,#d97706); color:#fff; border:none; border-radius:8px; font-size:0.8rem; font-weight:600; font-family:'Inter',sans-serif; cursor:pointer; box-shadow:0 3px 10px rgba(245,158,11,0.25); transition:all 0.2s; }
        .btn-subscribe:hover { transform:translateY(-1px); }
        /* Access badge */
        .access-badge { display:inline-flex; align-items:center; gap:4px; background:#f0fdf4; color:#16a34a; font-size:0.72rem; font-weight:600; padding:3px 8px; border-radius:50px; border:1px solid #bbf7d0; margin-top:4px; }
        .expired-badge { display:inline-flex; align-items:center; gap:4px; background:#fef2f2; color:#dc2626; font-size:0.72rem; font-weight:600; padding:3px 8px; border-radius:50px; border:1px solid #fecaca; margin-top:4px; }
        .empty-state { padding:60px 24px; text-align:center; color:#94a3b8; }
        .empty-state i { font-size:2.5rem; margin-bottom:12px; display:block; color:#cbd5e1; }
        .action-cell { display:flex; flex-direction:column; align-items:flex-start; gap:4px; }
    </style>
</head>
<body>
<%
    UserInfo loggedUser = (UserInfo) session.getAttribute("User");
    List<Quiz> lst = (List<Quiz>) request.getAttribute("quizlist");
    @SuppressWarnings("unchecked")
    Set<Integer> paidQuizIds = (Set<Integer>) request.getAttribute("paidQuizIds");
    @SuppressWarnings("unchecked")
    Map<Integer, LocalDate> expiryMap = (Map<Integer, LocalDate>) request.getAttribute("expiryMap");
    if (paidQuizIds == null) paidQuizIds = new java.util.HashSet<>();
    if (expiryMap == null) expiryMap = new java.util.HashMap<>();
    int formIndex = 0;
    String msg = (String) request.getAttribute("msg");
%>
<aside class="sidebar">
    <div class="sidebar-brand"><i class="fa fa-book-reader"></i>Edu<span>kate</span></div>
    <div class="sidebar-section-label">Student Menu</div>
    <nav class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/customerhome"    class="nav-item"><i class="fa fa-th-large"></i> Dashboard</a>
        <a href="<%=request.getContextPath()%>/studentProfile"  class="nav-item"><i class="fa fa-user"></i> My Profile</a>
        <a href="<%=request.getContextPath()%>/seeQuizes"       class="nav-item active"><i class="fa fa-play-circle"></i> Play Quizzes</a>
        <a href="<%=request.getContextPath()%>/studentProgress" class="nav-item"><i class="fa fa-chart-line"></i> My Progress</a>
        <a href="<%=request.getContextPath()%>/feedback"        class="nav-item"><i class="fa fa-comment-dots"></i> Feedback</a>
    </nav>
    <div class="sidebar-bottom">
        <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="nav-item logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>
</aside>
<div class="main">
    <div class="topbar">
        <div><h1>Available Quizzes</h1><p>Browse and play quizzes</p></div>
        <a href="<%=request.getContextPath()%>/customerhome" class="back-btn"><i class="fa fa-arrow-left"></i> Dashboard</a>
    </div>
    <div class="content">

        <% if (msg != null) { %>
        <div class="alert-msg"><i class="fa fa-exclamation-circle"></i> <%=msg%></div>
        <% } %>

        <div class="table-card">
            <div class="table-card-header">
                <h2><i class="fa fa-play-circle"></i> Quizzes</h2>
            </div>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>S.No.</th>
                        <th>Quiz Name</th>
                        <th>Marks</th>
                        <th>Duration</th>
                        <th>Mode</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (lst != null && lst.size() > 0) {
                        for (int i = 0; i < lst.size(); i++) {
                            Quiz q = lst.get(i);
                            formIndex++;
                            boolean isPaid = "Paid".equals(q.getQuizType());
                            boolean hasAccess = isPaid && paidQuizIds.contains(q.getId());
                            LocalDate expiry = hasAccess ? expiryMap.get(q.getId()) : null;
                            long daysLeft = (expiry != null) ? ChronoUnit.DAYS.between(LocalDate.now(), expiry) : 0;
                %>
                <tr>
                    <td><span class="sno"><%=i+1%></span></td>
                    <td><span class="quiz-name"><%=q.getQuizName()%></span></td>
                    <td><%=q.getMarks()%></td>
                    <td><i class="fa fa-clock" style="color:#94a3b8;font-size:0.78rem;margin-right:3px;"></i><%=q.getDuration()%> min</td>
                    <td>
                        <% if (isPaid) { %>
                            <span class="badge-paid"><i class="fa fa-tag"></i> Paid</span>
                        <% } else { %>
                            <span class="badge-free"><i class="fa fa-gift"></i> Free</span>
                        <% } %>
                    </td>
                    <td>
                        <div class="action-cell">
                        <% if (!isPaid) { %>
                            <%-- Free quiz: always show Start Quiz --%>
                            <form action="startQuiz" method="post">
                                <input type="hidden" name="quizId" value="<%=q.getId()%>">
                                <button type="submit" class="btn-start">
                                    <i class="fa fa-play"></i> Start Quiz
                                </button>
                            </form>
                        <% } else if (hasAccess) { %>
                            <%-- Paid quiz with valid access: show Start Quiz + expiry info --%>
                            <form action="startQuiz" method="post">
                                <input type="hidden" name="quizId" value="<%=q.getId()%>">
                                <button type="submit" class="btn-start">
                                    <i class="fa fa-play"></i> Start Quiz
                                </button>
                            </form>
                            <span class="access-badge">
                                <i class="fa fa-check-circle"></i>
                                Access valid &bull; <%=daysLeft%> day<%=daysLeft == 1 ? "" : "s"%> left
                            </span>
                        <% } else { %>
                            <%-- Paid quiz with no/expired access: show Subscribe --%>
                            <form id="paymentForm<%=formIndex%>" method="post">
                                <input type="hidden" name="amount" value="<%=q.getQuizPrice()%>" id="amount<%=formIndex%>">
                                <input type="hidden" name="quizId" value="<%=q.getId()%>">
                                <button type="submit" class="btn-subscribe"
                                        onclick="handlePayment(<%=formIndex%>, <%=q.getQuizPrice()%>, <%=q.getId()%>); return false;">
                                    <i class="fa fa-coins"></i> Subscribe ₹<%=q.getQuizPrice()%>
                                </button>
                            </form>
                        <% } %>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="6">
                    <div class="empty-state"><i class="fa fa-inbox"></i><p>No Quizzes Available!</p></div>
                </td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%-- handlePayment() JS function — completely unchanged --%>
<script>
    function handlePayment(formIndex, amount, quizId) {
        fetch("<%=request.getContextPath()%>/order/create", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "amount=" + amount
        })
        .then(res => {
            if (!res.ok) throw new Error("Server error: " + res.status);
            return res.json();
        })
        .then(order => {
            const options = {
                key: "rzp_test_SQc4j5P0Dh1RxX",
                amount: order.amount,
                currency: "INR",
                name: "Student E-Commerce",
                order_id: order.id,
                handler: function (response) {
                    const form = document.createElement("form");
                    form.method = "POST";
                    form.action = "<%=request.getContextPath()%>/subscribe";
                    const amountInput = document.createElement("input");
                    amountInput.type = "hidden";
                    amountInput.name = "amount";
                    amountInput.value = amount;
                    const quizIdInput = document.createElement("input");
                    quizIdInput.type = "hidden";
                    quizIdInput.name = "quizId";
                    quizIdInput.value = quizId;
                    form.appendChild(amountInput);
                    form.appendChild(quizIdInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            };
            const rzp1 = new Razorpay(options);
            rzp1.open();
        })
        .catch(err => alert("Error creating order: " + err));
    }
</script>
</body>
</html>