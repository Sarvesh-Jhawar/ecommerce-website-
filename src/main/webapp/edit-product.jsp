<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.techtutorial.model.Product"%>
<%@ page import="cn.techtutorial.dao.ProductDao"%>
<%@ page import="cn.techtutorial.connection.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Edit Product</h1>

    <%
        // Fetch the product ID from the request parameter
        int productId = Integer.parseInt(request.getParameter("id"));

        // Use the ProductDAO to get the product details
        ProductDao productDAO = new ProductDao(DBCon.getConnection());
        Product product = productDAO.getSingleProduct(productId);

        // Check if the product exists
        if (product == null) {
    %>
        <p class="text-danger">Product not found!</p>
    <%
        } else {
    %>

    <form action="edit-product" method="post">
        <input type="hidden" name="id" value="<%= product.getId() %>">
        
        <div class="form-group">
            <label for="name">Product Name</label>
            <input type="text" class="form-control" id="name" name="name" value="<%= product.getName() %>" required>
        </div>
        
        <div class="form-group">
            <label for="description">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3"><%= product.getDescription() %></textarea>
        </div>
        
        <div class="form-group">
            <label for="price">Price</label>
            <input type="number" class="form-control" id="price" name="price" value="<%= product.getPrice() %>" required>
        </div>
        
        <div class="form-group">
            <label for="category">Category</label>
            <input type="text" class="form-control" id="category" name="category" value="<%= product.getCategory() %>" required>
        </div>
        
        <div class="form-group">
            <label for="image">Image Filename</label>
            <input type="text" class="form-control" id="image" name="image" value="<%= product.getImage() %>" required>
        </div>

        <button type="submit" class="btn btn-primary">Update Product</button>
    </form>

    <%
        }
    %>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
