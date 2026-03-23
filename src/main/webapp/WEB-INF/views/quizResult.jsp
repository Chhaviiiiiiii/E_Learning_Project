<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="header.jsp"%>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow text-center p-5">

                <h2 class="text-success mb-4">🎉 Quiz Completed!</h2>
                <hr>

                <%
                int score = (Integer) request.getAttribute("score");
                int total = (Integer) request.getAttribute("total");
                double percent = ((double) score / total) * 100;
                %>

                <h4>Your Score</h4>
                <h1 class="display-3 text-primary font-weight-bold">
                    <%= score %> / <%= total %>
                </h1>

                <p class="mt-3">
                <% if(percent >= 70) { %>
                    <span class="badge badge-success p-2" style="font-size:16px">
                        ✅ Excellent! Well Done!
                    </span>
                <% } else if(percent >= 40) { %>
                    <span class="badge badge-warning p-2" style="font-size:16px">
                        ⚠️ Good! Keep Practicing.
                    </span>
                <% } else { %>
                    <span class="badge badge-danger p-2" style="font-size:16px">
                        ❌ Need More Practice!
                    </span>
                <% } %>
                </p>

                <div class="mt-4">
                    <a href="customerhome" class="btn btn-primary btn-lg">🏠 Back to Home</a>
                    <a href="studentProgress" class="btn btn-info btn-lg ml-2">📊 View Progress</a>
                </div>

            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp"%>