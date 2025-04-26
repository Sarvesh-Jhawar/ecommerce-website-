<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.techtutorial.model.User" %>
<%@ page import="cn.techtutorial.dao.OrderDao" %>
<%@ page import="cn.techtutorial.connection.DBCon" %>

<%@ page import="cn.techtutorial.model.Order" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
if (auth == null) {
    response.sendRedirect("login.jsp"); // Redirect to login if the user is not authenticated
    return;
}

// Fetch all orders for the authenticated user
OrderDao orderDao = new OrderDao(DBCon.getConnection());
List<Order> userOrders = orderDao.userOrders(auth.getId());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<%@include file="includes/head.jsp"%>
<style>
    .profile-container {
        max-width: 600px;
        margin: 50px auto;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        background-color: #f9f9f9;
    }
    .profile-header {
        text-align: center;
        margin-bottom: 20px;
    }
    .profile-header h2 {
        margin: 0;
        color: #333;
    }
    .profile-details {
        margin: 20px 0;
    }
    .profile-details th, .profile-details td {
        padding: 10px;
        text-align: left;
    }
    .profile-actions {
        text-align: center;
    }
    .btn {
        margin: 5px;
    }
    .orders-container {
        margin-top: 30px;
    }
    .order-table {
        width: 100%;
        border-collapse: collapse;
    }
    .order-table th, .order-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    .order-table th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>
    <%@include file="includes/navbar.jsp"%>
     <!-- Back Button -->
    <div style="margin: 20px;">
        <a href="javascript:history.back()" class="btn btn-secondary" style="text-decoration: none;">
            &larr; Back
        </a>
    </div>
    <div class="container">
        <div class="profile-container">
            <div class="profile-header">
                <h2>Welcome, <%= auth.getName() %>!</h2>
            </div>
            <table class="table table-bordered profile-details">
                <tr>
                    <th>Name:</th>
                    <td><%= auth.getName() %></td>
                </tr>
                <tr>
                    <th>Email:</th>
                    <td><%= auth.getEmail() %></td>
                </tr>
            </table>
            <div class="profile-actions">
                <a href="#" class="btn btn-warning">Edit Profile</a>
                <a href="log-out" class="btn btn-danger">Logout</a>
            </div>
        </div>

        <div class="orders-container">
            <h3>Your Orders</h3>
            <table class="order-table">
                <thead>
                    <tr>
                        
                        <th> Date </th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Quantity</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                <% if (userOrders != null && !userOrders.isEmpty()) {
                    for (Order o : userOrders) { %>
                        <tr>
                            <td><%= o.getDate() %></td>
                        <td><%= o.getName() %></td>
                        <td><%= o.getCategory() %></td>
                        <td><%= o.getQuantity() %></td>
                        <td><%= dcf.format(o.getPrice()) %></td>
                        </tr>
                <%  } 
                } else { %>
                    <tr>
                        <td colspan="5" style="text-align: center;">No orders found.</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <%@include file="includes/footer.jsp"%>
</body>
</html>
