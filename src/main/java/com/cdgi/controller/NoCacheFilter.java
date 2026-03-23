package com.cdgi.controller;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

/**
 * Prevents browser from caching protected pages.
 * After logout, pressing Back will re-check session and redirect to login
 * instead of showing a stale cached dashboard.
 */
@Component
public class NoCacheFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        // Apply no-cache headers to every response
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String uri = request.getRequestURI();
        String ctx = request.getContextPath();

        // Protected paths that require a valid session
        boolean isProtected = uri.startsWith(ctx + "/customerhome")
                           || uri.startsWith(ctx + "/adminhome")
                           || uri.startsWith(ctx + "/seeQuizes")
                           || uri.startsWith(ctx + "/studentProfile")
                           || uri.startsWith(ctx + "/studentProgress")
                           || uri.startsWith(ctx + "/feedback")
                           || uri.startsWith(ctx + "/getAllStudents")
                           || uri.startsWith(ctx + "/updateAdminProfile")
                           || uri.startsWith(ctx + "/editProfile");

        if (isProtected) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("User") == null) {
                // Session gone (logged out) — send to login instead of showing cached page
                response.sendRedirect(ctx + "/login");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
