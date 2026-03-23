<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo" %>

<!-- Topbar Start -->
<div class="container-fluid bg-dark">
    <div class="row py-2 px-lg-5">
        <div class="col-lg-6 text-center text-lg-left mb-2 mb-lg-0">
            <div class="d-inline-flex align-items-center text-white">
                <small><i class="fa fa-phone-alt mr-2"></i>+91 9131516788</small>
                <small class="px-3">|</small>
                <small><i class="fa fa-envelope mr-2"></i>deepikasingh@gmail.com</small>
            </div>
        </div>
        <div class="col-lg-6 text-center text-lg-right">
            <div class="d-inline-flex align-items-center">
                <a class="text-white px-2" href=""><i class="fab fa-facebook-f"></i></a>
                <a class="text-white px-2" href=""><i class="fab fa-twitter"></i></a>
                <a class="text-white px-2" href="https://www.linkedin.com/in/chhavi-sharma-769417290/"><i class="fab fa-linkedin-in"></i></a>
                <a class="text-white px-2" href=""><i class="fab fa-instagram"></i></a>
                <a class="text-white pl-2" href=""><i class="fab fa-youtube"></i></a>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->

<!-- Navbar Start -->
<div class="container-fluid p-0">
    <nav class="navbar navbar-expand-lg bg-white navbar-light py-3 py-lg-0 px-lg-5">
        <a href="/" class="navbar-brand ml-lg-3">
            <h1 class="m-0 text-uppercase text-primary"><i class="fa fa-book-reader mr-3"></i>Edukate</h1>
        </a>
        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-between px-lg-3" id="navbarCollapse">
            <div class="navbar-nav mx-auto py-0">
                <a href="/" class="nav-item nav-link">Home</a>
                <a href="/about" class="nav-item nav-link">About</a>
                <a href="/course" class="nav-item nav-link">Courses</a>
                <a href="/contact" class="nav-item nav-link">Contact</a>
            </div>

            <%
                // Try to read the user object from session. Older code used 'loggedUser', controllers set 'User'.
                UserInfo loggedUser = (UserInfo) session.getAttribute("User");
                if (loggedUser == null) {
                    loggedUser = (UserInfo) session.getAttribute("loggedUser");
                }
                if (loggedUser != null) {
                    String dpImage = loggedUser.getDp();
                    if(dpImage == null || dpImage.trim().equals("")) {
                        dpImage = "default.png";
                    }
            %>
                <!-- Logged in: dp + username + logout -->
                <div class="d-flex align-items-center">
                    <img src="<%=request.getContextPath()%>/resources/dp/<%= dpImage %>"
                         alt="DP"
                         style="width:42px; height:42px; border-radius:50%; object-fit:cover; border:2px solid #007bff; margin-right:8px;">
                    <span class="font-weight-bold mr-3" style="color:#333; font-size:14px;">
                        <%= loggedUser.getUsername() %>
                    </span>
                    <a href="#" onclick="window.location.replace('<%=request.getContextPath()%>/logout'); return false;" class="btn btn-danger py-2 px-4 d-none d-lg-block">Logout</a>
                </div>
            <%
                } else {
            %>
                <!-- Not logged in: Login button -->
                <a href="<%=request.getContextPath()%>/login" class="btn btn-primary py-2 px-4 d-none d-lg-block">Login</a>
            <%
                }
            %>
        </div>
    </nav>
</div>
<!-- Navbar End -->

<!-- CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/style.css" rel="stylesheet">