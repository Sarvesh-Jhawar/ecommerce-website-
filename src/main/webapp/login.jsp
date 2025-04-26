<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="includes/head.jsp"%>
<%@ page import="cn.techtutorial.model.*" %>
<%@ page import="java.util.*"%>

  <% 
        User auth =(User)request.getSession().getAttribute("auth");
        if(auth!=null){
        	//request.setAttribute("auth",auth);
        	response.sendRedirect("index.jsp");

        }
        ArrayList<Cart> cart_list=(ArrayList<Cart>) session.getAttribute("cart-list");

        if (cart_list != null) {
           
            request.setAttribute("cart_list",cart_list);
            
        }
        %>
<!DOCTYPE html>
<html>
<head>
<title>Shopping Cart Login</title>
<!-- SweetAlert CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<!-- SweetAlert JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<style>
    body {
        display: flex;
        flex-direction: column; /* Arrange content vertically */
        justify-content: center;
        align-items: center;
        min-height: 100vh; /* Full height of the viewport */
        margin: 0; /* Remove default body margin */
        background-color: #f8f9fa; /* Optional: Add a subtle background color */
    }
    .navbar {
        width: 100%; /* Full-width navbar */
        position: fixed; /* Fix the navbar at the top */
        top: 0; /* Position at the very top */
        z-index: 10; /* Ensure it stays above other elements */
        background-color: #ffffff; /* Optional: Background color for navbar */
        box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1); /* Optional: Add a shadow */
    }
    .content {
        flex: 1; /* Take up remaining vertical space */
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        margin-top: 60px; /* Adjust for navbar height */
    }
    .card {
        width: 100%; /* Responsive card width */
        max-width: 400px; /* Set a maximum width for the card */
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
                    <h2>User Login</h2>
                </div>
                <div class="card-body">
                    <form action="user-login" method="post">
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" class="form-control" name="login-email" placeholder="Enter your email" required>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" class="form-control" name="login-password" placeholder="********" required>
                        </div>
                        <div class="text-centre">
                            <button type="submit" class="btn btn-primary">Login</button>
                        </div>
                        <div class="text-centre my-3">
                        <a href="register.jsp" class="btn btn-secondary">click here to register</a>
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
            out.println("  title: 'Error!',");
            out.println("  text: '" + alertMessage + "',");
            out.println("  type: '" + alertType + "',");
            out.println("  confirmButtonText: 'OK'");
            out.println("}).then((result) => {");
            out.println("  if (result.value) {");
            out.println("    window.location.href = 'register.jsp';"); // Redirect to registration page
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
