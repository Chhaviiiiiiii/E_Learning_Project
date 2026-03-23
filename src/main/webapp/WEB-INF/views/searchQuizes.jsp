<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.cdgi.pojo.Quiz" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Quizzes</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<style>
body {
    background: #f4f6f9;
}
.card {
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    padding: 20px;
}
.table th {
    background-color: #007bff;
    color: white;
}
</style>

</head>
<body>

<div class="container mt-5">

<div class="card">

<h3 class="text-center text-primary mb-4">🔍 Search Quizzes</h3>

<!-- Search Form -->
<form action="searchQuizes" method="get" class="form-inline justify-content-center mb-4">
    <input type="text" name="query" class="form-control mr-2" placeholder="Enter quiz name" required>
    <button type="submit" class="btn btn-success">Search</button>
</form>

<!-- Results Table -->
<table class="table table-bordered table-hover text-center">
<thead>
<tr>
<th>ID</th>
<th>Quiz Name</th>
<th>Marks</th>
<th>Duration</th>
<th>Type</th>
</tr>
</thead>

<tbody>
<%
List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
if(quizzes != null && !quizzes.isEmpty()) {
    for(Quiz q : quizzes) {
%>
<tr>
<td><%= q.getId() %></td>
<td><%= q.getQuizName() %></td>
<td><%= q.getMarks() %></td>
<td><%= q.getDuration() %></td>
<td><%= q.getQuizType() %></td>
</tr>
<%
    }
} else {
%>
<tr>
<td colspan="5" class="text-muted">No quizzes found!</td>
</tr>
<%
}
%>
</tbody>
</table>

<div class="text-center mt-3">
<a href="customerhome" class="btn btn-secondary">⬅ Back</a>
</div>

</div>

</div>

</body>
</html>