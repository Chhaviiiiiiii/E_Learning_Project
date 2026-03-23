<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Edukate - Online Learning Platform</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta name="description" content="Edukate - Premium online education platform with expert instructors and industry-recognized courses.">

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <!-- Owl Carousel -->
    <link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <style>
        :root {
            --primary: #6c63ff;
            --primary-dark: #4f46e5;
            --secondary: #f97316;
            --dark: #0f172a;
            --dark-2: #1e293b;
            --text: #475569;
            --light-bg: #f8fafc;
            --white: #ffffff;
            --border: #e2e8f0;
            --radius: 12px;
            --shadow: 0 4px 24px rgba(108,99,255,0.10);
            --shadow-md: 0 8px 40px rgba(108,99,255,0.16);
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Inter', sans-serif;
            color: var(--text);
            background: var(--white);
            overflow-x: hidden;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Poppins', sans-serif;
            color: var(--dark);
            font-weight: 700;
        }

        a { text-decoration: none; transition: all 0.3s ease; }

        /* ===================== TOPBAR ===================== */
        .topbar {
            background: var(--dark);
            padding: 10px 0;
            font-size: 0.82rem;
        }
        .topbar .topbar-inner {
            max-width: 1200px;
            margin: auto;
            padding: 0 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }
        .topbar-contact span { color: #94a3b8; margin-right: 20px; }
        .topbar-contact span i { color: var(--primary); margin-right: 6px; }
        .topbar-social a {
            color: #94a3b8;
            margin-left: 14px;
            font-size: 0.85rem;
        }
        .topbar-social a:hover { color: var(--primary); }

        /* ===================== NAVBAR ===================== */
        .main-nav {
            background: var(--white);
            padding: 0 24px;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 20px rgba(15,23,42,0.08);
        }
        .navbar-inner {
            max-width: 1200px;
            margin: auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 68px;
        }
        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Poppins', sans-serif;
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--dark);
        }
        .brand i { color: var(--primary); font-size: 1.4rem; }
        .brand span { color: var(--primary); }

        .nav-links { display: flex; align-items: center; gap: 4px; }
        .nav-links a {
            color: var(--text);
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.25s;
        }
        .nav-links a:hover, .nav-links a.active {
            color: var(--primary);
            background: rgba(108,99,255,0.08);
        }
        .btn-join {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: var(--white) !important;
            padding: 10px 26px !important;
            border-radius: 50px !important;
            font-weight: 600 !important;
            box-shadow: 0 4px 14px rgba(108,99,255,0.35);
        }
        .btn-join:hover {
            background: linear-gradient(135deg, var(--primary-dark), #3730a3) !important;
            box-shadow: 0 6px 20px rgba(108,99,255,0.45);
            transform: translateY(-1px);
            color: var(--white) !important;
        }
        .navbar-toggler-btn {
            display: none;
            background: none;
            border: none;
            font-size: 1.4rem;
            color: var(--dark);
            cursor: pointer;
        }
        @media (max-width: 768px) {
            .navbar-toggler-btn { display: block; }
            .nav-links { display: none; flex-direction: column; position: absolute; top: 68px; left: 0; right: 0; background: var(--white); padding: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); }
            .nav-links.open { display: flex; }
            .btn-join { display: none; }
        }

        /* ===================== HERO ===================== */
        .hero {
            background: linear-gradient(135deg, var(--dark) 0%, var(--dark-2) 50%, #1a1060 100%);
            min-height: 560px;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
        }
        .hero::before {
            content: '';
            position: absolute;
            width: 600px; height: 600px;
            background: radial-gradient(circle, rgba(108,99,255,0.25) 0%, transparent 70%);
            top: -100px; right: -100px;
            border-radius: 50%;
        }
        .hero::after {
            content: '';
            position: absolute;
            width: 300px; height: 300px;
            background: radial-gradient(circle, rgba(249,115,22,0.15) 0%, transparent 70%);
            bottom: -50px; left: 100px;
            border-radius: 50%;
        }
        .hero-inner {
            max-width: 1200px;
            margin: auto;
            padding: 80px 24px;
            position: relative;
            z-index: 1;
        }
        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(108,99,255,0.2);
            border: 1px solid rgba(108,99,255,0.4);
            color: #a5b4fc;
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 24px;
        }
        .hero-badge i { color: var(--secondary); font-size: 0.75rem; }
        .hero h1 {
            color: var(--white);
            font-size: clamp(2.2rem, 5vw, 3.5rem);
            line-height: 1.2;
            margin-bottom: 20px;
        }
        .hero h1 span {
            background: linear-gradient(135deg, var(--primary), #a78bfa);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .hero p {
            color: #94a3b8;
            font-size: 1.1rem;
            max-width: 560px;
            line-height: 1.75;
            margin-bottom: 36px;
        }
        .hero-btns { display: flex; gap: 16px; flex-wrap: wrap; }
        .btn-primary-hero {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: var(--white);
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            box-shadow: 0 4px 20px rgba(108,99,255,0.4);
            display: inline-block;
        }
        .btn-primary-hero:hover {
            color: var(--white);
            transform: translateY(-2px);
            box-shadow: 0 8px 28px rgba(108,99,255,0.5);
        }
        .btn-outline-hero {
            border: 2px solid rgba(255,255,255,0.3);
            color: var(--white);
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            display: inline-block;
        }
        .btn-outline-hero:hover {
            border-color: var(--primary);
            color: var(--primary);
            background: rgba(108,99,255,0.1);
        }
        .hero-stats {
            display: flex;
            gap: 40px;
            margin-top: 48px;
            flex-wrap: wrap;
        }
        .hero-stat { text-align: left; }
        .hero-stat .num {
            color: var(--white);
            font-size: 1.8rem;
            font-weight: 800;
            font-family: 'Poppins', sans-serif;
        }
        .hero-stat .lbl { color: #64748b; font-size: 0.85rem; font-weight: 500; }

        /* ===================== SECTION COMMON ===================== */
        .section { padding: 80px 0; }
        .section-alt { background: var(--light-bg); }
        .section-inner { max-width: 1200px; margin: auto; padding: 0 24px; }
        .section-label {
            display: inline-block;
            background: rgba(108,99,255,0.1);
            color: var(--primary);
            font-size: 0.8rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            padding: 4px 14px;
            border-radius: 50px;
            margin-bottom: 12px;
        }
        .section-title { font-size: clamp(1.6rem, 3vw, 2.2rem); margin-bottom: 16px; line-height: 1.3; }
        .section-sub { color: var(--text); max-width: 540px; line-height: 1.7; }

        /* ===================== ABOUT ===================== */
        .about-img-wrap {
            position: relative;
            border-radius: var(--radius);
            overflow: hidden;
            height: 420px;
        }
        .about-img-wrap img { width: 100%; height: 100%; object-fit: cover; border-radius: var(--radius); }
        .about-img-badge {
            position: absolute;
            bottom: 24px;
            left: 24px;
            background: var(--white);
            border-radius: var(--radius);
            padding: 16px 20px;
            box-shadow: var(--shadow-md);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .about-img-badge .badge-icon {
            width: 44px; height: 44px;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
        }
        .about-img-badge .badge-icon i { color: var(--white); font-size: 1.1rem; }
        .about-img-badge .badge-text strong { display: block; color: var(--dark); font-size: 1.1rem; }
        .about-img-badge .badge-text span { font-size: 0.8rem; color: var(--text); }

        .stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-top: 32px; }
        .stat-card {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 20px;
            text-align: center;
            transition: all 0.3s;
        }
        .stat-card:hover { border-color: var(--primary); box-shadow: var(--shadow); transform: translateY(-2px); }
        .stat-card .num {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary);
            font-family: 'Poppins', sans-serif;
        }
        .stat-card .lbl { font-size: 0.82rem; color: var(--text); font-weight: 500; margin-top: 4px; }

        /* ===================== FEATURES ===================== */
        .features-bg {
            background: linear-gradient(135deg, var(--dark) 0%, #1a1060 100%);
        }
        .feature-item { display: flex; gap: 20px; margin-bottom: 36px; }
        .feature-icon {
            flex-shrink: 0;
            width: 54px; height: 54px;
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
        }
        .feature-icon i { color: var(--white); font-size: 1.3rem; }
        .feature-item h4 { color: var(--white); margin-bottom: 6px; font-size: 1.05rem; }
        .feature-item p { color: #94a3b8; font-size: 0.9rem; line-height: 1.65; margin: 0; }
        .features-img-wrap { border-radius: var(--radius); overflow: hidden; height: 460px; }
        .features-img-wrap img { width: 100%; height: 100%; object-fit: cover; border-radius: var(--radius); }
        .features-bg .section-label { background: rgba(108,99,255,0.25); }
        .features-bg .section-title { color: var(--white); }
        .features-bg .section-sub { color: #94a3b8; }

        /* ===================== COURSES ===================== */
        .course-card {
            background: var(--white);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: 0 2px 16px rgba(15,23,42,0.07);
            transition: all 0.3s;
            border: 1px solid var(--border);
        }
        .course-card:hover { transform: translateY(-6px); box-shadow: var(--shadow-md); }
        .course-card img { width: 100%; height: 200px; object-fit: cover; }
        .course-card-body { padding: 20px; }
        .course-card-body h5 { font-size: 1rem; color: var(--dark); margin-bottom: 10px; line-height: 1.4; }
        .course-meta { display: flex; justify-content: space-between; align-items: center; margin-top: 14px; padding-top: 14px; border-top: 1px solid var(--border); }
        .course-meta span { font-size: 0.82rem; color: var(--text); }
        .course-meta .star i { color: #f59e0b; }
        .btn-course {
            display: block;
            text-align: center;
            background: rgba(108,99,255,0.08);
            color: var(--primary);
            padding: 10px;
            font-weight: 600;
            font-size: 0.9rem;
            border-top: 1px solid var(--border);
            transition: all 0.25s;
        }
        .btn-course:hover { background: var(--primary); color: var(--white); }

        /* ===================== CTA BANNER ===================== */
        .cta-banner {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border-radius: var(--radius);
            padding: 48px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .cta-banner::before {
            content: '';
            position: absolute;
            width: 300px; height: 300px;
            background: rgba(255,255,255,0.07);
            border-radius: 50%;
            top: -80px; right: -80px;
        }
        .cta-banner h2 { color: var(--white); font-size: 1.8rem; margin-bottom: 8px; }
        .cta-banner p { color: rgba(255,255,255,0.8); margin-bottom: 24px; }
        .btn-cta {
            background: var(--white);
            color: var(--primary);
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 700;
            display: inline-block;
        }
        .btn-cta:hover { background: var(--dark); color: var(--white); }

        /* ===================== TEAM ===================== */
        .team-card {
            background: var(--white);
            border-radius: var(--radius);
            overflow: hidden;
            border: 1px solid var(--border);
            text-align: center;
            transition: all 0.3s;
        }
        .team-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-md); }
        .team-card img { width: 100%; height: 240px; object-fit: cover; }
        .team-card-body { padding: 20px; }
        .team-card-body h5 { color: var(--dark); margin-bottom: 4px; font-size: 1rem; }
        .team-card-body span { color: var(--primary); font-size: 0.85rem; font-weight: 500; }
        .team-social { margin-top: 14px; display: flex; justify-content: center; gap: 10px; }
        .team-social a {
            width: 34px; height: 34px;
            border-radius: 50%;
            background: var(--light-bg);
            display: flex; align-items: center; justify-content: center;
            color: var(--text);
            font-size: 0.8rem;
            transition: all 0.25s;
        }
        .team-social a:hover { background: var(--primary); color: var(--white); }

        /* ===================== TESTIMONIALS ===================== */
        .testimonial-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 32px;
            border: 1px solid var(--border);
            box-shadow: 0 2px 12px rgba(15,23,42,0.05);
        }
        .testimonial-card .quote-icon { color: var(--primary); font-size: 2rem; margin-bottom: 16px; }
        .testimonial-card p { color: var(--text); line-height: 1.7; font-style: italic; }
        .testimonial-author { display: flex; align-items: center; gap: 14px; margin-top: 20px; }
        .testimonial-author img { width: 48px; height: 48px; border-radius: 50%; object-fit: cover; }
        .testimonial-author strong { display: block; color: var(--dark); font-size: 0.95rem; }
        .testimonial-author span { color: var(--text); font-size: 0.82rem; }

        /* ===================== CONTACT ===================== */
        .contact-info-card {
            background: linear-gradient(135deg, var(--dark) 0%, var(--dark-2) 100%);
            border-radius: var(--radius);
            padding: 40px;
            height: 100%;
        }
        .contact-info-item { display: flex; align-items: flex-start; gap: 16px; margin-bottom: 28px; }
        .contact-info-item:last-child { margin-bottom: 0; }
        .contact-info-icon {
            width: 46px; height: 46px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .contact-info-icon i { color: var(--white); font-size: 1.1rem; }
        .contact-info-item h5 { color: var(--white); font-size: 0.95rem; margin-bottom: 4px; }
        .contact-info-item p { color: #94a3b8; font-size: 0.88rem; margin: 0; }

        .contact-form-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 40px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
        }
        .form-group label { font-size: 0.85rem; font-weight: 600; color: var(--dark); margin-bottom: 6px; }
        .form-control {
            border: 1.5px solid var(--border);
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 0.9rem;
            transition: all 0.25s;
        }
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(108,99,255,0.12);
            outline: none;
        }
        textarea.form-control { resize: vertical; min-height: 110px; }
        .btn-send {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: var(--white);
            border: none;
            padding: 14px 36px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            box-shadow: 0 4px 16px rgba(108,99,255,0.35);
            transition: all 0.3s;
        }
        .btn-send:hover { transform: translateY(-2px); box-shadow: 0 6px 22px rgba(108,99,255,0.45); }

        /* ===================== FOOTER ===================== */
        .footer { background: var(--dark); padding: 64px 0 0; }
        .footer-inner { max-width: 1200px; margin: auto; padding: 0 24px; }
        .footer-brand { font-family: 'Poppins', sans-serif; font-size: 1.5rem; font-weight: 800; color: var(--white); margin-bottom: 14px; display: flex; align-items: center; gap: 10px; }
        .footer-brand i { color: var(--primary); }
        .footer p { color: #64748b; font-size: 0.9rem; line-height: 1.7; }
        .footer h5 { color: var(--white); font-size: 1rem; margin-bottom: 20px; }
        .footer-links a { display: flex; align-items: center; gap: 8px; color: #64748b; font-size: 0.88rem; margin-bottom: 10px; }
        .footer-links a i { color: var(--primary); font-size: 0.7rem; }
        .footer-links a:hover { color: var(--primary); }
        .footer-social { display: flex; gap: 10px; margin-top: 20px; }
        .footer-social a {
            width: 38px; height: 38px;
            border-radius: 50%;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            display: flex; align-items: center; justify-content: center;
            color: #94a3b8;
            font-size: 0.85rem;
            transition: all 0.25s;
        }
        .footer-social a:hover { background: var(--primary); border-color: var(--primary); color: var(--white); }
        .newsletter-input { display: flex; gap: 0; }
        .newsletter-input input {
            flex: 1;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            color: var(--white);
            padding: 12px 16px;
            border-radius: 8px 0 0 8px;
            font-size: 0.88rem;
        }
        .newsletter-input input::placeholder { color: #64748b; }
        .newsletter-input button {
            background: var(--primary);
            color: var(--white);
            border: none;
            padding: 12px 20px;
            border-radius: 0 8px 8px 0;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.25s;
        }
        .newsletter-input button:hover { background: var(--primary-dark); }
        .footer-bottom {
            border-top: 1px solid rgba(255,255,255,0.07);
            padding: 20px 24px;
            max-width: 1200px;
            margin: 40px auto 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }
        .footer-bottom p { color: #475569; font-size: 0.85rem; margin: 0; }
        .footer-bottom a { color: var(--primary); }

        /* ===================== BACK TO TOP ===================== */
        .back-to-top {
            position: fixed;
            bottom: 28px; right: 28px;
            width: 44px; height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: var(--white);
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem;
            box-shadow: 0 4px 16px rgba(108,99,255,0.4);
            opacity: 0;
            pointer-events: none;
            transition: all 0.3s;
            z-index: 999;
        }
        .back-to-top.show { opacity: 1; pointer-events: all; }
        .back-to-top:hover { color: var(--white); transform: translateY(-3px); }

        /* Owl carousel nav override */
        .owl-nav button { background: var(--white) !important; border: 1px solid var(--border) !important; width: 38px; height: 38px; border-radius: 50% !important; box-shadow: var(--shadow); }
        .owl-nav button span { font-size: 1.2rem; color: var(--primary) !important; line-height: 1; }
        .owl-dots .owl-dot span { background: var(--border) !important; }
        .owl-dots .owl-dot.active span { background: var(--primary) !important; }
    </style>
</head>
<body>



<!-- ============ NAVBAR ============ -->
<nav class="main-nav">
    <div class="navbar-inner">
        <a href="${pageContext.request.contextPath}/" class="brand">
            <i class="fa fa-book-reader"></i>Edu<span>kate</span>
        </a>
        <button class="navbar-toggler-btn" onclick="document.getElementById('navLinks').classList.toggle('open')">
            <i class="fa fa-bars"></i>
        </button>
        <div class="nav-links" id="navLinks">
            <a href="${pageContext.request.contextPath}/" class="active">Home</a>
            <a href="#about">About</a>
            <a href="#courses">Courses</a>
            <a href="#team">Instructors</a>
            <a href="#contact">Contact</a>
            <a href="${pageContext.request.contextPath}/login" class="btn-join">Join Us</a>
        </div>
    </div>
</nav>

<!-- ============ HERO ============ -->
<section class="hero">
    <div class="hero-inner">
        <div class="hero-badge">
            <i class="fa fa-circle"></i> #1 Online Learning Platform in India
        </div>
        <h1>Learn New Skills &<br><span>Grow Your Career</span></h1>
        <p>Access 1,200+ expert-led courses. Learn at your own pace from India's top educators and get industry-recognized certificates.</p>
        <div class="hero-btns">
            <a href="${pageContext.request.contextPath}/reg" class="btn-primary-hero">
                <i class="fa fa-rocket mr-2"></i>Get Started Free
            </a>
            <a href="#courses" class="btn-outline-hero">
                <i class="fa fa-search mr-2"></i>Explore Courses
            </a>
        </div>
        <div class="hero-stats">
            <div class="hero-stat">
                <div class="num">1,200+</div>
                <div class="lbl">Online Courses</div>
            </div>
            <div class="hero-stat">
                <div class="num">50K+</div>
                <div class="lbl">Happy Students</div>
            </div>
            <div class="hero-stat">
                <div class="num">120+</div>
                <div class="lbl">Expert Instructors</div>
            </div>
        </div>
    </div>
</section>

<!-- ============ ABOUT ============ -->
<section class="section" id="about">
    <div class="section-inner">
        <div class="row align-items-center">
            <div class="col-lg-5 mb-5 mb-lg-0">
                <div class="about-img-wrap">
                    <img src="${pageContext.request.contextPath}/resources/img/about.jpg" alt="About Edukate">
                    <div class="about-img-badge">
                        <div class="badge-icon"><i class="fa fa-trophy"></i></div>
                        <div class="badge-text">
                            <strong>10+ Years</strong>
                            <span>of Excellence</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-7 pl-lg-5">
                <div class="section-label">About Us</div>
                <h2 class="section-title">Your First Choice For<br>Online Education</h2>
                <p class="section-sub mb-4">We believe education is the most powerful tool to change the world. Our platform delivers quality courses from expert educators, helping you gain real-world skills and advance your career — from anywhere.</p>
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="num">123</div>
                        <div class="lbl">Available Subjects</div>
                    </div>
                    <div class="stat-card">
                        <div class="num">1,234</div>
                        <div class="lbl">Online Courses</div>
                    </div>
                    <div class="stat-card">
                        <div class="num">120</div>
                        <div class="lbl">Skilled Instructors</div>
                    </div>
                    <div class="stat-card">
                        <div class="num">50K+</div>
                        <div class="lbl">Happy Students</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============ FEATURES ============ -->
<section class="section features-bg">
    <div class="section-inner">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-5 mb-lg-0">
                <div class="section-label">Why Choose Us</div>
                <h2 class="section-title" style="color:#fff;">Why Learn With Edukate?</h2>
                <p class="section-sub mb-5" style="color:#94a3b8;">We combine world-class expertise with flexible learning so you can achieve your goals on your schedule.</p>
                <div class="feature-item">
                    <div class="feature-icon" style="background:linear-gradient(135deg,#6c63ff,#4f46e5);">
                        <i class="fa fa-graduation-cap"></i>
                    </div>
                    <div>
                        <h4>Expert Instructors</h4>
                        <p>Learn from industry professionals with proven track records. Our instructors bring real-world experience to every lesson.</p>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon" style="background:linear-gradient(135deg,#f97316,#ef4444);">
                        <i class="fa fa-certificate"></i>
                    </div>
                    <div>
                        <h4>Recognized Certificates</h4>
                        <p>Earn certificates that are recognized by top companies. Boost your resume and open new career opportunities.</p>
                    </div>
                </div>
                <div class="feature-item" style="margin-bottom:0;">
                    <div class="feature-icon" style="background:linear-gradient(135deg,#10b981,#059669);">
                        <i class="fa fa-laptop"></i>
                    </div>
                    <div>
                        <h4>Learn Anytime, Anywhere</h4>
                        <p>Access all course content at your own pace. Our mobile-friendly platform makes learning flexible for your lifestyle.</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 pl-lg-5">
                <div class="features-img-wrap">
                    <img src="${pageContext.request.contextPath}/resources/img/feature.jpg" alt="Why Choose Edukate">
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============ COURSES ============ -->
<section class="section section-alt" id="courses">
    <div class="section-inner">
        <div class="text-center mb-5">
            <div class="section-label">Our Courses</div>
            <h2 class="section-title">Explore Our Top Courses</h2>
            <p class="section-sub mx-auto">Discover a wide range of courses designed to help you level up your skills and build a successful career.</p>
        </div>
        <div class="owl-carousel courses-carousel">
            <div class="course-card">
                <img src="${pageContext.request.contextPath}/resources/img/courses-1.jpg" alt="Web Design">
                <div class="course-card-body">
                    <h5>Web Design &amp; Development for Beginners</h5>
                    <div class="course-meta">
                        <span><i class="fa fa-user mr-1"></i> John Doe</span>
                        <span class="star"><i class="fa fa-star"></i> 4.5 <small>(250)</small></span>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="btn-course">View Course <i class="fa fa-arrow-right ml-1"></i></a>
            </div>
            <div class="course-card">
                <img src="${pageContext.request.contextPath}/resources/img/courses-2.jpg" alt="Course 2">
                <div class="course-card-body">
                    <h5>Python Programming from Zero to Hero</h5>
                    <div class="course-meta">
                        <span><i class="fa fa-user mr-1"></i> Jane Smith</span>
                        <span class="star"><i class="fa fa-star"></i> 4.8 <small>(310)</small></span>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="btn-course">View Course <i class="fa fa-arrow-right ml-1"></i></a>
            </div>
            <div class="course-card">
                <img src="${pageContext.request.contextPath}/resources/img/courses-3.jpg" alt="Course 3">
                <div class="course-card-body">
                    <h5>Data Science &amp; Machine Learning Masterclass</h5>
                    <div class="course-meta">
                        <span><i class="fa fa-user mr-1"></i> Alex Kumar</span>
                        <span class="star"><i class="fa fa-star"></i> 4.7 <small>(198)</small></span>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="btn-course">View Course <i class="fa fa-arrow-right ml-1"></i></a>
            </div>
            <div class="course-card">
                <img src="${pageContext.request.contextPath}/resources/img/courses-4.jpg" alt="Course 4">
                <div class="course-card-body">
                    <h5>UI/UX Design Fundamentals &amp; Figma</h5>
                    <div class="course-meta">
                        <span><i class="fa fa-user mr-1"></i> Priya Verma</span>
                        <span class="star"><i class="fa fa-star"></i> 4.6 <small>(220)</small></span>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="btn-course">View Course <i class="fa fa-arrow-right ml-1"></i></a>
            </div>
            <div class="course-card">
                <img src="${pageContext.request.contextPath}/resources/img/courses-5.jpg" alt="Course 5">
                <div class="course-card-body">
                    <h5>Java Spring Boot Backend Development</h5>
                    <div class="course-meta">
                        <span><i class="fa fa-user mr-1"></i> Rahul Gupta</span>
                        <span class="star"><i class="fa fa-star"></i> 4.9 <small>(400)</small></span>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="btn-course">View Course <i class="fa fa-arrow-right ml-1"></i></a>
            </div>
            <div class="course-card">
                <img src="${pageContext.request.contextPath}/resources/img/courses-6.jpg" alt="Course 6">
                <div class="course-card-body">
                    <h5>Digital Marketing &amp; Social Media Strategy</h5>
                    <div class="course-meta">
                        <span><i class="fa fa-user mr-1"></i> Neha Singh</span>
                        <span class="star"><i class="fa fa-star"></i> 4.4 <small>(175)</small></span>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/login" class="btn-course">View Course <i class="fa fa-arrow-right ml-1"></i></a>
            </div>
        </div>

        <!-- CTA Banner -->
        <div class="cta-banner mt-5">
            <h2>🎓 30% Off For New Students</h2>
            <p>Sign up today and unlock your first month at a special discounted price.</p>
            <a href="${pageContext.request.contextPath}/reg" class="btn-cta">Register Now &rarr;</a>
        </div>
    </div>
</section>

<!-- ============ TEAM ============ -->
<section class="section" id="team">
    <div class="section-inner">
        <div class="text-center mb-5">
            <div class="section-label">Instructors</div>
            <h2 class="section-title">Meet Our Expert Instructors</h2>
        </div>
        <div class="owl-carousel team-carousel">
            <div class="team-card">
                <img src="${pageContext.request.contextPath}/resources/img/team-1.jpg" alt="Instructor 1">
                <div class="team-card-body">
                    <h5>Ankit Sharma</h5>
                    <span>Web Design &amp; Development</span>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="team-card">
                <img src="${pageContext.request.contextPath}/resources/img/team-2.jpg" alt="Instructor 2">
                <div class="team-card-body">
                    <h5>Priya Verma</h5>
                    <span>Data Science &amp; AI</span>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="team-card">
                <img src="${pageContext.request.contextPath}/resources/img/team-3.jpg" alt="Instructor 3">
                <div class="team-card-body">
                    <h5>Rahul Gupta</h5>
                    <span>Java &amp; Spring Boot</span>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="team-card">
                <img src="${pageContext.request.contextPath}/resources/img/team-4.jpg" alt="Instructor 4">
                <div class="team-card-body">
                    <h5>Sneha Joshi</h5>
                    <span>UI/UX &amp; Product Design</span>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============ TESTIMONIALS ============ -->
<section class="section section-alt">
    <div class="section-inner">
        <div class="row align-items-center">
            <div class="col-lg-4 mb-5 mb-lg-0">
                <div class="section-label">Testimonials</div>
                <h2 class="section-title">What Our Students Say</h2>
                <p class="section-sub">Join thousands of happy learners who have transformed their careers with Edukate.</p>
            </div>
            <div class="col-lg-8">
                <div class="owl-carousel testimonial-carousel">
                    <div class="testimonial-card">
                        <div class="quote-icon"><i class="fa fa-quote-left"></i></div>
                        <p>"Edukate completely changed my career. The courses are practical, well-structured, and the instructors are incredibly knowledgeable. Got a job within 3 months of completing my course!"</p>
                        <div class="testimonial-author">
                            <img src="${pageContext.request.contextPath}/resources/img/testimonial-1.jpg" alt="Student 1">
                            <div>
                                <strong>Vikram Patel</strong>
                                <span>Web Development Graduate</span>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-card">
                        <div class="quote-icon"><i class="fa fa-quote-left"></i></div>
                        <p>"The flexibility of learning at my own pace while getting world-class content is exactly what I needed as a working professional. Highly recommend Edukate to everyone!"</p>
                        <div class="testimonial-author">
                            <img src="${pageContext.request.contextPath}/resources/img/testimonial-2.jpg" alt="Student 2">
                            <div>
                                <strong>Riya Sharma</strong>
                                <span>Data Science Student</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============ CONTACT ============ -->
<section class="section" id="contact">
    <div class="section-inner">
        <div class="text-center mb-5">
            <div class="section-label">Contact</div>
            <h2 class="section-title">Get In Touch With Us</h2>
        </div>
        <div class="row">
            <div class="col-lg-4 mb-4 mb-lg-0">
                <div class="contact-info-card">
                    <div class="contact-info-item">
                        <div class="contact-info-icon" style="background:rgba(108,99,255,0.2);">
                            <i class="fa fa-map-marker-alt" style="color:#a5b4fc;"></i>
                        </div>
                        <div>
                            <h5>Our Location</h5>
                            <p>Madhya Pradesh, India</p>
                        </div>
                    </div>
                    <div class="contact-info-item">
                        <div class="contact-info-icon" style="background:rgba(249,115,22,0.2);">
                            <i class="fa fa-phone-alt" style="color:#fdba74;"></i>
                        </div>
                        <div>
                            <h5>Call Us</h5>
                            <p>+91 8319840970</p>
                        </div>
                    </div>
                    <div class="contact-info-item">
                        <div class="contact-info-icon" style="background:rgba(16,185,129,0.2);">
                            <i class="fa fa-envelope" style="color:#6ee7b7;"></i>
                        </div>
                        <div>
                            <h5>Email Us</h5>
                            <p>chhavisharma0707@gmail.com</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="contact-form-card">
                    <form action="${pageContext.request.contextPath}/contact" method="post">
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label>Your Name</label>
                                <input type="text" name="name" class="form-control" placeholder="Enter your name" required>
                            </div>
                            <div class="col-md-6 form-group">
                                <label>Your Email</label>
                                <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Subject</label>
                            <input type="text" name="subject" class="form-control" placeholder="What is this about?" required>
                        </div>
                        <div class="form-group">
                            <label>Message</label>
                            <textarea name="message" class="form-control" placeholder="Write your message..." required></textarea>
                        </div>
                        <button type="submit" class="btn-send">
                            <i class="fa fa-paper-plane mr-2"></i>Send Message
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============ FOOTER ============ -->
<footer class="footer">
    <div class="footer-inner">
        <div class="row">
            <div class="col-lg-4 mb-5">
                <div class="footer-brand"><i class="fa fa-book-reader"></i>Edukate</div>
                <p>Empowering learners across India with quality online education. Build real skills, earn recognized certificates, grow your career.</p>
                <div class="footer-social">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 mb-5">
                <h5>Quick Links</h5>
                <div class="footer-links">
                    <a href="${pageContext.request.contextPath}/"><i class="fa fa-angle-right"></i>Home</a>
                    <a href="#about"><i class="fa fa-angle-right"></i>About Us</a>
                    <a href="#courses"><i class="fa fa-angle-right"></i>Courses</a>
                    <a href="#team"><i class="fa fa-angle-right"></i>Instructors</a>
                    <a href="#contact"><i class="fa fa-angle-right"></i>Contact</a>
                    <a href="${pageContext.request.contextPath}/reg"><i class="fa fa-angle-right"></i>Register</a>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 mb-5">
                <h5>Newsletter</h5>
                <p class="mb-3">Subscribe to get the latest courses and offers directly in your inbox.</p>
                <div class="newsletter-input">
                    <input type="email" placeholder="Your email address">
                    <button type="button">Subscribe</button>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2025 <a href="#">Edukate</a>. All Rights Reserved.</p>
        <p>Designed by <a href="#">Chhavi Sharma</a></p>
    </div>
</footer>

<!-- Back to Top -->
<a href="#" class="back-to-top" id="backToTop"><i class="fa fa-arrow-up"></i></a>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>

<script>
    // Courses carousel
    $('.courses-carousel').owlCarousel({
        loop: true, margin: 24, autoplay: true, autoplayTimeout: 3500,
        responsive: { 0: {items:1}, 576: {items:2}, 992: {items:3} },
        nav: false, dots: true
    });

    // Team carousel
    $('.team-carousel').owlCarousel({
        loop: true, margin: 24, autoplay: true, autoplayTimeout: 4000,
        responsive: { 0: {items:1}, 576: {items:2}, 992: {items:3} },
        nav: true, dots: false,
        navText: ['<i class="fa fa-chevron-left"></i>','<i class="fa fa-chevron-right"></i>']
    });

    // Testimonial carousel
    $('.testimonial-carousel').owlCarousel({
        loop: true, margin: 24, autoplay: true, autoplayTimeout: 5000,
        items: 1, nav: false, dots: true
    });

    // Back to top
    window.addEventListener('scroll', function () {
        var btn = document.getElementById('backToTop');
        if (window.scrollY > 300) btn.classList.add('show');
        else btn.classList.remove('show');
    });
    document.getElementById('backToTop').addEventListener('click', function(e) {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
        anchor.addEventListener('click', function (e) {
            var target = document.querySelector(this.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });
</script>
</body>
</html>
