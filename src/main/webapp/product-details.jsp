<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="cn.techtutorial.connection.DBCon"%>
<%@ page import="cn.techtutorial.dao.ProductDao"%>
<%@ page import="cn.techtutorial.model.Product"%>
<%@ page import="cn.techtutorial.model.User"%>
<%@ page import="java.util.*"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}
int productId = Integer.parseInt(request.getParameter("id")); // Get product ID from URL
ProductDao productDao = new ProductDao(DBCon.getConnection());
Product product = productDao.getSingleProduct(productId); // Fetch product details

// Fetch related products from the same category excluding the current product
List<Product> relatedProducts = productDao.getProductsByCategory(product.getCategory());
relatedProducts.removeIf(p -> p.getId() == productId); // Remove the current product from the list
%>

<!DOCTYPE html>
<html>
<head>
<title>Product Details</title>
<%@ include file="includes/head.jsp"%>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	padding: 20px;
}

.back-button {
	display: inline-block;
	margin-bottom: 20px;
	text-decoration: none;
	color: #000;
	background-color: white;
	padding: 10px 20px;
	border-radius: 5px;
	transition: background-color 0.3s, color 0.3s;
}

.back-button:hover {
	background-color: #0056b3; /* Blue background on hover */
	color: #fff; /* Change text color to white on hover */
}

.product-details {
	display: flex;
	background-color: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.product-image {
	flex: 1;
	max-width: 400px;
	padding-right: 20px; /* Space between image and details */
}

.product-image img {
	width: 100%;
	height: auto;
	object-fit: contain;
}

.product-info {
	flex: 2;
}

.product-info h2 {
	margin: 0 0 10px 0;
}

.product-info h4 {
	margin: 5px 0;
}

.price {
	font-size: 24px;
	font-weight: bold;
	color: #b12704; /* Amazon price color */
}

.btn {
	margin-top: 10px;
	padding: 10px 15px;
	border-radius: 5px;
	color: white;
	text-decoration: none;
	transition: background-color 0.3s;
	display: inline-block; /* Ensure buttons are inline */
}

.btn-dark {
	background-color: #343a40; /* Dark background */
}

.btn-dark:hover {
	background-color: #23272b; /* Darker on hover */
}

.btn-primary {
	background-color: #007bff; /* Blue background */
}

.btn-primary:hover {
	background-color: #0056b3; /* Darker blue on hover */
}

.button-container {
	display: flex;
	gap: 10px; /* Space between buttons */
	margin-top: 15px;
}

.related-products .product-card {
    display: inline-block;
    width: calc(25% - 20px); /* 4 products per row with spacing */
    margin: 10px;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    text-align: center;
    padding: 15px;
    height: 380px; /* Fixed height for uniformity */
}

.related-products .product-card img {
    width: 100%;
    height: 200px;
    object-fit: contain;
    margin-bottom: 10px;
}

.related-products .product-card .product-info {
    padding: 10px 0;
}

.related-products .product-card .btn {
    margin-top: 10px;
    display: inline-block;
    padding: 8px 12px;
    color: #fff;
    background-color: #007bff; /* Button color */
    border: none;
    border-radius: 4px;
    text-decoration: none;
    transition: background-color 0.3s;
}

.related-products .product-card .btn:hover {
    background-color: #0056b3; /* Darker blue on hover */
}
</style>
</head>
<body>
	<%@ include file="includes/navbar.jsp"%>

	<div class="container my-5">
		<!-- Back Button -->
		<a href="index.jsp" class="back-button">← Back to Home</a>
		<h1>Product Details</h1>
		<div class="product-details">
			<div class="product-image">
				<img src="product-images/<%=product.getImage()%>"
					alt="<%=product.getName()%>">
			</div>
			<div class="product-info">
				<h2><%=product.getName()%></h2>
				<h4 class="price">
					Price: ₹<%=product.getPrice()%></h4>
				<h4>
					Category:
					<%=product.getCategory()%></h4>
				<p>
					<strong>Description:</strong> "No description available."
				</p>
				<div class="button-container">
					<a href="add-to-cart?id=<%=product.getId()%>" class="btn btn-dark">Add
						to Cart</a> <a
						href="order-now-servlet?quantity=1&id=<%=product.getId()%>"
						class="btn btn-primary">Buy Now</a>
				</div>
			</div>
		</div>

		<!-- Related Products Section -->
<div class="related-products">
    <h3>Related Products</h3>
    <div class="row">
        <% if (!relatedProducts.isEmpty()) { 
            for (Product relatedProduct : relatedProducts) { %>
                <div class="product-card">
                    <!-- Wrap the image in an anchor tag -->
                    <a href="product-details.jsp?id=<%=relatedProduct.getId()%>">
                        <img src="product-images/<%=relatedProduct.getImage()%>"
                            alt="<%=relatedProduct.getName()%>">
                    </a>
                    <div class="product-info">
                        <h4><%=relatedProduct.getName()%></h4>
                        <p class="price">
                            ₹<%=relatedProduct.getPrice()%>
                        </p>
                        <!-- Add a View Details button -->
                        <a href="product-details.jsp?id=<%=relatedProduct.getId()%>"
                            class="btn btn-primary">View Details</a>
                    </div>
                </div>
        <% } 
        } else { %>
            <p>No related products available.</p>
        <% } %>
    </div>
</div>



	<%@ include file="includes/footer.jsp"%>
</body>
</html>
