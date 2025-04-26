<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.techtutorial.model.User" %>
<%@ page import="cn.techtutorial.dao.UserDao" %>
<%@ page import="cn.techtutorial.dao.OrderDao" %>
<%@ page import="cn.techtutorial.connection.DBCon" %>
<%@ page import="cn.techtutorial.model.Order" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);

// Fetch the userId parameter from the request
String userIdParam = request.getParameter("userId");

if (userIdParam != null) {
    try {
        int userId = Integer.parseInt(userIdParam);
        
        // Fetch user details
        UserDao userDao = new UserDao(DBCon.getConnection());
        User user = userDao.getUserById(userId);
        
        // Fetch user orders
        OrderDao orderDao = new OrderDao(DBCon.getConnection());
        List<Order> userOrders = orderDao.userOrders(userId);
        
        // Pass user and orders to the JSP
        request.setAttribute("user", user);
        request.setAttribute("userOrders", userOrders);
    } catch (NumberFormatException e) {
        // Handle invalid userId parameter
        request.setAttribute("error", "Invalid user ID.");
    }
} else {
    request.setAttribute("error", "No user ID provided.");
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <%@include file="includes/head.jsp"%>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-header h2 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }

        .profile-details th,
        .profile-details td {
            padding: 10px;
            text-align: left;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
        }

        .order-table th, .order-table td {
            border: 1px solid #ddd;
            padding: 12px;
        }

        .order-table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .order-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .order-table tr:hover {
            background-color: #f1f1f1;
        }

        .btn {
            display: inline-block;
            padding: 10px 15px;
            margin: 10px 5px;
            font-size: 14px;
            color: #fff;
            background: #007bff;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn:hover {
            background: #0056b3;
        }

        .btn-secondary {
            background: #6c757d;
        }

        .btn-warning {
            background: #ffc107;
        }

        .btn-warning:hover {
            background: #e0a800;
        }

        .error {
            text-align: center;
            color: red;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%@include file="admin_includes/admin_navbar.jsp"%>

    <div style="margin: 20px;">
        <a href="javascript:history.back()" class="btn btn-secondary" style="text-decoration: none;">
            &larr; Back
        </a>
    </div>

    <div class="container">
        <% 
        User user = (User) request.getAttribute("user");
        List<Order> userOrders = (List<Order>) request.getAttribute("userOrders");
        if (user != null) { 
        %>
            <div class="profile-container">
                <div class="profile-header">
                    <h2>Details of <%= user.getName() %>!</h2>
                </div>
                <table class="table profile-details">
                    <tr>
                        <th>Name:</th>
                        <td><%= user.getName() %></td>
                    </tr>
                    <tr>
                        <th>Email:</th>
                        <td><%= user.getEmail() %></td>
                    </tr>
                    <tr>
                        <th>Last Login:</th>
                        <td><%= user.getLastLogin() %></td>
                    </tr>
                </table>
                <div class="profile-actions">
                    <a href="#" class="btn btn-warning">Edit Profile</a>
                </div>
            </div>

            <div class="orders-container">
                <h3>Orders</h3>
                <table class="order-table">
                    <thead>
                        <tr>
                            <th>Date</th>
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
        <% } else { %>
            <div class="error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
    </div>

    <%@include file="includes/footer.jsp"%>
</body>
</html>
