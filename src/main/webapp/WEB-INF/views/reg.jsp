<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Registration - Edukate</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<!-- Style CSS -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/style.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
</head>

<body>

  <%@include file="header.jsp" %>

  <!-- Registration Section Start -->
  <div class="container py-5 mt-4">
    <div class="row justify-content-center">
      <div class="col-sm-10 col-md-8 col-lg-7">
        <div class="card shadow my-5">
          <div class="card-body p-5">
            <h4 class="card-title text-center mb-4">New User Registration</h4>

            <!-- Message Display -->
            <%
              String msg = (String) request.getAttribute("msg");
              if (msg != null) {
            %>
              <div class="alert alert-danger text-center"><%= msg %></div>
            <% } %>

            <!-- Registration Form -->
            <form action="addNewUser" method="post" enctype="multipart/form-data">

              <!-- 1. Username -->
              <div class="form-group">
                <label>Username</label>
                <input type="text" class="form-control" placeholder="Enter username"
                       name="username" required autofocus>
              </div>

              <!-- 2. Email -->
              <div class="form-group">
                <label>Email Address</label>
                <input type="email" class="form-control" placeholder="Enter email"
                       name="email" required>
              </div>

              <!-- 3. Phone No -->
              <div class="form-group">
                <label>Phone Number</label>
                <input type="number" class="form-control" placeholder="Enter phone number"
                       name="phone" maxlength="10"  maxlength="10" required>
              </div>

              <!-- 4. Date of Birth -->
              <div class="form-group">
                <label>Date of Birth</label>
                <input type="date" class="form-control" name="dob" required>
              </div>

              <!-- 5. Gender -->
              <div class="form-group">
                <label>Gender</label>
                <select class="form-control" name="gender" required>
                  <option value="">-- Select Gender --</option>
                  <option value="Male">Male</option>
                  <option value="Female">Female</option>
                  <option value="Other">Other</option>
                </select>
              </div>

              <!-- 6. Education -->
              <div class="form-group">
                <label>Education</label>
                <select class="form-control" name="education" required>
                  <option value="">-- Select Education --</option>
                  <option value="10th">10th</option>
                  <option value="12th">12th</option>
                  <option value="Graduation">Graduation</option>
                  <option value="Post Graduation">Post Graduation</option>
                  <option value="Other">Other</option>
                </select>
              </div>

              <!-- 7. State -->
              <div class="form-group">
                <label>State</label>
                <select class="form-control" name="state" required>
                  <option value="">-- Select State --</option>
                  <option>Andhra Pradesh</option>
                  <option>Arunachal Pradesh</option>
                  <option>Assam</option>
                  <option>Bihar</option>
                  <option>Chhattisgarh</option>
                  <option>Goa</option>
                  <option>Gujarat</option>
                  <option>Haryana</option>
                  <option>Himachal Pradesh</option>
                  <option>Jharkhand</option>
                  <option>Karnataka</option>
                  <option>Kerala</option>
                  <option>Madhya Pradesh</option>
                  <option>Maharashtra</option>
                  <option>Manipur</option>
                  <option>Meghalaya</option>
                  <option>Mizoram</option>
                  <option>Nagaland</option>
                  <option>Odisha</option>
                  <option>Punjab</option>
                  <option>Rajasthan</option>
                  <option>Sikkim</option>
                  <option>Tamil Nadu</option>
                  <option>Telangana</option>
                  <option>Tripura</option>
                  <option>Uttar Pradesh</option>
                  <option>Uttarakhand</option>
                  <option>West Bengal</option>
                  <option>Delhi</option>
                </select>
              </div>

              <!-- 8. Country -->
              <div class="form-group">
                <label>Country</label>
                <select class="form-control" name="country" required>
                  <option value="">-- Select Country --</option>
                  <option value="India">India</option>
                  <option value="USA">USA</option>
                  <option value="UK">UK</option>
                  <option value="Canada">Canada</option>
                  <option value="Australia">Australia</option>
                  <option value="Other">Other</option>
                </select>
              </div>

              <!-- 9. Address -->
              <div class="form-group">
                <label>Address</label>
                <textarea class="form-control" name="address" rows="2"
                          placeholder="Enter your address" required></textarea>
              </div>

              <!-- 10. Profile Photo (DP) -->
              <div class="form-group">
                <label>Profile Photo</label>
                <input type="file" class="form-control-file"
                       name="dp" accept="image/*" required>
              </div>

              <!-- Password -->
              <div class="form-group">
                <label>Password</label>
                <input type="password" class="form-control"
                       placeholder="Enter password" name="password" required>
              </div>

              <button class="btn btn-primary btn-block mt-3" type="submit">
                Register Here
              </button>
            </form>

            <hr class="my-4">

            <div class="text-center">
              <p>Already have an account?
                <a href="login" class="text-primary font-weight-bold">Login Here</a>
              </p>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Registration Section End -->

  <%@include file="footer.jsp" %>

  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
</body>
</html>
