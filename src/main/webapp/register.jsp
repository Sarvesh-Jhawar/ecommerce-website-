<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="includes/head.jsp"%>
<%@ page import="cn.techtutorial.model.*" %>
<%@ page import="java.util.*"%>

<% 
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Shopping Cart Registration</title>
<!-- SweetAlert CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<!-- SweetAlert JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<style>
    body {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        background-color: #f8f9fa;
    }
    .navbar {
        width: 100%;
        position: fixed;
        top: 0;
        z-index: 10;
        background-color: #ffffff;
        box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    }
    .content {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        margin-top: 60px;
    }
    .card {
        width: 100%;
        max-width: 400px;
    }
    .text-centre {
        text-align: center;
    }
</style>
</head>
<body>
    <%@include file="includes/navbar.jsp" %>

    <div class="content">
        <div class="container">
            <div class="card mx-auto my-5">
                <div class="card-header text-centre">
                    <h2>User Registration</h2>
                </div>
                <div class="card-body">
                    <form action="register" method="post">
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" class="form-control" name="register-name" placeholder="Enter your full name" required>
                        </div>
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" class="form-control" name="register-email" placeholder="Enter your email" required>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" class="form-control" name="register-password" placeholder="********" required>
                        </div>
                        <div class="form-group">
                            <label>Confirm Password</label>
                            <input type="password" class="form-control" name="register-confirm-password" placeholder="********" required>
                        </div>
                        <div class="text-centre">
                            <button type="submit" class="btn btn-primary">Register</button>
                        </div>
                        <div class="text-centre my-3">
                        <a href="login.jsp" class="btn btn-secondary">Click here to login</a>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <% 
        // Check for alert messages in the session
        String alertType = (String) session.getAttribute("alertType");
        String alertMessage = (String) session.getAttribute("alertMessage");
        if (alertType != null && alertMessage != null) {
            out.println("<script>");
            out.println("swal({");
            out.println("  title: '" + alertType.substring(0, 1).toUpperCase() + alertType.substring(1) + "!',");
            out.println("  text: '" + alertMessage + "',");
            out.println("  type: '" + alertType + "',");
            out.println("  confirmButtonText: 'OK'");
            out.println("}).then((result) => {");
            out.println("  if (result.value) {");
            out.println("    window.location.href = 'login.jsp';"); // Redirect to login.jsp
            out.println("  }");
            out.println("});");
            out.println("</script>");
            // Clear the alert message after displaying it
            session.removeAttribute("alertType");
            session.removeAttribute("alertMessage");
        }
    %>

    <%@include file="includes/footer.jsp"%>
</body>
</html>
