<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.techtutorial.dao.UserDao" %>
<%@ page import="cn.techtutorial.connection.*" %>
<%@ page import="cn.techtutorial.model.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%
    // Set up database connection
    UserDao userDao = new UserDao(DBCon.getConnection());
    List<User> userList = null;

    try {
        userList = userDao.getAllUsers();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <%@include file="includes/head.jsp"%>
    
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 18px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tbody tr:hover {
            background-color: #f1f1f1;
        }
        .button {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 14px;
            text-align: center;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <%@include file="admin_includes/admin_navbar.jsp"%>

    <h2>All Users</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Last Login</th> <!-- New column for the timestamp -->
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% if (userList != null && !userList.isEmpty()) { %>
                <% for (User user : userList) { %>
                    <tr>
                        <td><%= user.getId() %></td>
                        <td><%= user.getName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getRole() %></td>
                        <td><%= user.getLastLogin() != null ? user.getLastLogin() : "N/A" %></td> <!-- Display timestamp -->
                        <td>
                            <form action="admin-user.jsp" method="get">
                                <input type="hidden" name="userId" value="<%= user.getId() %>" />
                                <button class="button" type="submit">View User</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="6">No users found.</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
