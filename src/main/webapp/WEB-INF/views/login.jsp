<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Edukate</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@700;800&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            background: #f8fafc;
        }

        /* ===== LEFT PANEL ===== */
        .left-panel {
            width: 45%;
            min-height: 100vh;
            background: linear-gradient(145deg, #0f172a 0%, #1e1060 55%, #4f46e5 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px 48px;
            position: relative;
            overflow: hidden;
        }
        .left-panel::before {
            content: '';
            position: absolute;
            width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(108,99,255,0.3) 0%, transparent 70%);
            top: -100px; right: -100px;
            border-radius: 50%;
        }
        .left-panel::after {
            content: '';
            position: absolute;
            width: 250px; height: 250px;
            background: radial-gradient(circle, rgba(249,115,22,0.15) 0%, transparent 70%);
            bottom: 60px; left: -60px;
            border-radius: 50%;
        }
        .left-content { position: relative; z-index: 1; text-align: center; }
        .brand {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            font-weight: 800;
            color: #fff;
            text-decoration: none;
            margin-bottom: 48px;
        }
        .brand i { color: #818cf8; font-size: 1.8rem; }
        .brand span { color: #818cf8; }

        .left-headline {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            font-weight: 700;
            color: #fff;
            line-height: 1.3;
            margin-bottom: 16px;
        }
        .left-sub {
            color: #94a3b8;
            font-size: 0.95rem;
            line-height: 1.7;
            max-width: 340px;
            margin: 0 auto 40px;
        }
        .features-list { list-style: none; text-align: left; display: inline-block; }
        .features-list li {
            color: #c7d2fe;
            font-size: 0.9rem;
            margin-bottom: 14px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .features-list li .icon {
            width: 32px; height: 32px;
            background: rgba(129,140,248,0.2);
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .features-list li .icon i { color: #818cf8; font-size: 0.85rem; }

        /* ===== RIGHT PANEL ===== */
        .right-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 24px;
        }
        .login-box {
            width: 100%;
            max-width: 420px;
        }
        .login-box h2 {
            font-family: 'Poppins', sans-serif;
            font-size: 1.75rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 6px;
        }
        .login-box .subtitle {
            color: #64748b;
            font-size: 0.9rem;
            margin-bottom: 32px;
        }

        /* Alert */
        .alert-error {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #dc2626;
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 0.88rem;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-error i { font-size: 1rem; flex-shrink: 0; }

        /* Form */
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
        }
        .input-wrap {
            position: relative;
        }
        .input-wrap i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 0.9rem;
        }
        .input-wrap input {
            width: 100%;
            padding: 13px 14px 13px 40px;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            font-size: 0.92rem;
            font-family: 'Inter', sans-serif;
            color: #0f172a;
            background: #fff;
            transition: border-color 0.25s, box-shadow 0.25s;
            outline: none;
        }
        .input-wrap input:focus {
            border-color: #6c63ff;
            box-shadow: 0 0 0 3px rgba(108,99,255,0.12);
        }
        .input-wrap input::placeholder { color: #94a3b8; }

        /* Toggle password visibility */
        .toggle-pw {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            cursor: pointer;
            font-size: 0.9rem;
            background: none;
            border: none;
            padding: 0;
        }
        .toggle-pw:hover { color: #6c63ff; }

        /* Remember me */
        .remember-row {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 24px;
        }
        .remember-row input[type="checkbox"] {
            width: 16px; height: 16px;
            accent-color: #6c63ff;
            cursor: pointer;
        }
        .remember-row label {
            font-size: 0.875rem;
            color: #475569;
            cursor: pointer;
        }

        /* Submit button */
        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #6c63ff, #4f46e5);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            box-shadow: 0 4px 16px rgba(108,99,255,0.35);
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .btn-login:hover {
            background: linear-gradient(135deg, #4f46e5, #3730a3);
            box-shadow: 0 6px 22px rgba(108,99,255,0.45);
            transform: translateY(-1px);
        }

        /* Divider */
        .divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 24px 0;
            color: #cbd5e1;
            font-size: 0.82rem;
        }
        .divider::before, .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #e2e8f0;
        }

        /* Register button */
        .btn-register {
            width: 100%;
            padding: 13px;
            background: #fff;
            color: #6c63ff;
            border: 1.5px solid #6c63ff;
            border-radius: 10px;
            font-size: 0.95rem;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            transition: all 0.25s;
        }
        .btn-register:hover {
            background: rgba(108,99,255,0.06);
            color: #4f46e5;
            text-decoration: none;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #64748b;
            font-size: 0.85rem;
            text-decoration: none;
            margin-bottom: 32px;
            transition: color 0.2s;
        }
        .back-link:hover { color: #6c63ff; text-decoration: none; }

        /* Responsive */
        @media (max-width: 768px) {
            .left-panel { display: none; }
            .right-panel { padding: 40px 20px; }
        }
    </style>
</head>
<body>

    <!-- LEFT BRANDING PANEL -->
    <div class="left-panel">
        <div class="left-content">
            <a href="${pageContext.request.contextPath}/" class="brand">
                <i class="fa fa-book-reader"></i>Edu<span>kate</span>
            </a>
            <h2 class="left-headline">Welcome Back,<br>Keep Learning!</h2>
            <p class="left-sub">Sign in to access your courses, track your progress, and continue your learning journey.</p>
            <ul class="features-list">
                <li>
                    <div class="icon"><i class="fa fa-graduation-cap"></i></div>
                    1,200+ courses from expert instructors
                </li>
                <li>
                    <div class="icon"><i class="fa fa-certificate"></i></div>
                    Industry-recognized certificates
                </li>
                <li>
                    <div class="icon"><i class="fa fa-laptop"></i></div>
                    Learn at your own pace, anytime
                </li>
            </ul>
        </div>
    </div>

    <!-- RIGHT LOGIN PANEL -->
    <div class="right-panel">
        <div class="login-box">

            <a href="${pageContext.request.contextPath}/" class="back-link">
                <i class="fa fa-arrow-left"></i> Back to Home
            </a>

            <h2>Sign In</h2>
            <p class="subtitle">Enter your credentials to access your account</p>

            <%-- Message Display — business logic unchanged --%>
            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
                <div class="alert-error">
                    <i class="fa fa-exclamation-circle"></i>
                    <%= msg %>
                </div>
            <% } %>

            <%-- Login Form — action, method, field names all unchanged --%>
            <form action="checkUser" method="post">

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrap">
                        <i class="fa fa-envelope"></i>
                        <input type="text" id="email" name="email"
                               placeholder="Enter your email" required autofocus>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrap">
                        <i class="fa fa-lock"></i>
                        <input type="password" id="password" name="password"
                               placeholder="Enter your password" required>
                        <button type="button" class="toggle-pw" onclick="togglePassword()" title="Show/hide password">
                            <i class="fa fa-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                </div>

                <div class="remember-row">
                    <input type="checkbox" id="customCheck1">
                    <label for="customCheck1">Remember password</label>
                </div>

                <button type="submit" class="btn-login">
                    <i class="fa fa-sign-in-alt"></i> Sign In
                </button>
            </form>

            <div class="divider">or</div>

            <a href="reg" class="btn-register">
                <i class="fa fa-user-plus"></i> New User? Register Here
            </a>

        </div>
    </div>

    <script>
        function togglePassword() {
            var input = document.getElementById('password');
            var icon = document.getElementById('eyeIcon');
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
    </script>

</body>
</html>