<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="cn.techtutorial.dao.ProductDao" %>
<%@ page import="cn.techtutorial.connection.DBCon" %>
<!DOCTYPE html>
<%@ include file="includes/head.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Product</title>
    <style>
    
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="file"],
        select {
            margin-bottom: 15px;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
 <%@ include file="admin_includes/admin_navbar.jsp"%>
<body>
   
    <div class="container">
        <h2>Upload Product</h2>

        <%
            // Fetch the list of categories from the database
            ProductDao pd = new ProductDao(DBCon.getConnection());
            List<String> categories = pd.getAllCategories();
        %>

        <form action="UploadProductServlet" method="post" enctype="multipart/form-data">
            <label for="name">Product Name:</label>
            <input type="text" id="name" name="name" required />

            <label for="price">Price:</label>
            <input type="text" id="price" name="price" required />

            <label for="category">Category:</label>
            <select id="category" name="category" required>
                <% for (String category : categories) { %>
                    <option value="<%= category %>"><%= category %></option>
                <% } %>
                <option value="other">Other</option>
            </select>

            <label for="customCategory">If "Other", specify category:</label>
            <input type="text" id="customCategory" name="customCategory" placeholder="Enter custom category" />

            <label for="image">Upload Image:</label>
            <input type="file" id="image" name="image" accept="image/*" required />

            <button type="submit">Upload Product</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    // Check if a message exists in the session
    <% String message = (String) session.getAttribute("uploadMessage"); %>
    <% if (message != null) { %>
        let uploadMessage = "<%= message %>";
        if (uploadMessage === "success") {
            Swal.fire({
                icon: 'success',
                title: 'Product Uploaded',
                text: 'Your product has been uploaded successfully!',
                showConfirmButton: false,
                timer: 2000
            });
        } else if (uploadMessage === "failure") {
            Swal.fire({
                icon: 'error',
                title: 'Upload Failed',
                text: 'There was an error uploading your product. Please try again.',
                showConfirmButton: true
            });
        }
        <% session.removeAttribute("uploadMessage"); %> <!-- Remove the message from the session -->
    <% } %>
</script>
</body>
</html>
