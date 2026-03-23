<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cdgi.pojo.UserInfo" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<style>
body { background: #f5f5f5; }
.edit-box {
    width: 420px;
    margin: 70px auto;
    padding: 30px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
.title { text-align: center; margin-bottom: 25px; font-weight: bold; }
</style>
</head>
<body>

<%
String msg = (String) request.getAttribute("msg");
if(msg != null) {
    String alertClass = msg.contains("Please fill") ? "alert-danger" : "alert-success";
%>
<div class="alert <%=alertClass%> text-center"><%= msg %></div>
<% } %>

<div class="edit-box">
    <h3 class="title">✏ Edit Profile</h3>

    <form action="updateProfile" method="post" enctype="multipart/form-data">

        <div class="form-group">
            <label>Phone</label>
            <input type="text" class="form-control" name="phone" placeholder="Enter new phone number">
        </div>

        <div class="form-group">
            <label>Education</label>
            <input type="text" class="form-control" name="education" placeholder="Enter new education">
        </div>

        <div class="form-group">
            <label>State</label>
            <input type="text" class="form-control" name="state" placeholder="Enter new state">
        </div>

        <div class="form-group">
            <label>Country</label>
            <input type="text" class="form-control" name="country" placeholder="Enter new country">
        </div>

        <div class="form-group">
            <label>Address</label>
            <input type="text" class="form-control" name="address" placeholder="Enter new address">
        </div>

        <div class="form-group">
            <label>Profile Photo</label>
            <input type="file" class="form-control" name="dp">
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-primary">Update Profile</button>
            <a href="studentProfile" class="btn btn-secondary">Back</a>
        </div>

    </form>
</div>

</body>
</html>
