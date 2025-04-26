<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="cn.techtutorial.connection.DBCon"%>
<%@ page import="cn.techtutorial.model.*"%>
<%@ page import="cn.techtutorial.dao.ProductDao"%>
<%@ page import="java.util.*"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}
ProductDao pd = new ProductDao(DBCon.getConnection());
String alert = request.getParameter("alert");
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}

// Fetch categories and handle single and multi-select filters
List<String> categories = pd.getAllCategories();
String selectedCategory = request.getParameter("category");
String[] selectedCategories = request.getParameterValues("categories");
List<Product> products;

if ("true".equals(request.getParameter("clear"))) {
	selectedCategory = "all"; // Clear the filters
	selectedCategories = null;
	products = pd.getProductsByCategory("all");
} else if (selectedCategories != null && selectedCategories.length > 0) {
	products = pd.getProductsByMultipleCategories(selectedCategories);
} else {
	products = pd.getProductsByCategory(selectedCategory != null ? selectedCategory : "all");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>WELCOME TO SHOPPING CART</title>
<%@include file="includes/head.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
/* Main Container */
.container {
	display: flex;
	flex-wrap: nowrap;
}

/* Sidebar Styling */
.sidebar {
	flex: 1;
	max-width: 20%;
	background-color: #f8f8f8;
	padding: 15px;
	border-right: 1px solid #ddd;
}

/* Product Section Styling */
.products {
	flex: 3;
	padding: 15px;
}

/* Row Container for Cards */
.row {
	display: flex;
	flex-wrap: wrap;
	gap: 15px; /* Space between cards */
	justify-content: flex-start;
}

/* Individual Card Styling */
.card {
	flex: 0 0 calc(25% - 15px); /* 4 cards per row */
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	max-width: 100%;
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
	background-color: #fff;
	margin-bottom: 15px;
}

/* Image Container Styling */
.image-container {
	height: 12rem;
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #f8f8f8;
}

.card-img-top {
	max-width: 100%;
	max-height: 100%;
	object-fit: contain;
}

/* Card Body Styling */
.card-body {
	padding: 10px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.card-title a {
	text-decoration: none;
	color: #333;
	font-weight: bold;
}

.card-title a:hover {
	color: #007bff;
}

.price {
	font-size: 1rem;
	color: #28a745;
	font-weight: bold;
}

.category {
	font-size: 0.9rem;
	color: #6c757d;
}

/* Button Styling */
.btn {
	margin-top: 10px;
	width: 48%; /* Adjust button width */
	text-align: center;
	font-size: 0.9rem;
	padding: 5px 10px;
	display: inline-block; /* Ensure buttons are inline */
}

.btn-primary {
	background-color: #007bff;
	border: none;
	color: #fff;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.btn-danger {
	background-color: #dc3545;
	border: none;
	color: #fff;
}

.btn-danger:hover {
	background-color: #c82333;
}

.btn-dark {
	background-color: #343a40;
	border: none;
	color: #fff;
}

.btn-dark:hover {
	background-color: #23272b;
}

/* Footer Styling in Card */
.card-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 10px;
	flex-wrap: wrap; /* Ensure footer content fits within the card */
}

/* Responsive Design */
@media ( max-width : 992px) {
	.card {
		flex: 0 0 calc(33.33% - 15px);
		/* 3 cards per row for medium screens */
	}
}

@media ( max-width : 768px) {
	.card {
		flex: 0 0 calc(50% - 15px); /* 2 cards per row for tablets */
	}
}

@media ( max-width : 576px) {
	.card {
		flex: 0 0 calc(100% - 15px); /* 1 card per row for small devices */
	}
}

/* Sidebar Category Links */
.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar ul li {
	margin-bottom: 10px;
}

.sidebar ul li a {
	text-decoration: none;
	color: #333;
	font-size: 1rem;
	transition: color 0.3s;
}

.sidebar ul li a.active {
	font-weight: bold;
	color: #007bff;
}

.sidebar ul li a:hover {
	color: #007bff;
}

/* General Body Styling */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
}

h3 {
	margin-bottom: 15px;
}
</style>

</head>
<body>
	<%@ include file="includes/navbar.jsp"%>
	<div class="container">
		<div class="sidebar">
			<h3>Categories</h3>
			<ul>
				<li><a href="?category=all"
					<%="all".equals(selectedCategory) ? "class='active'" : ""%>>All</a></li>
				<%
				if (categories != null) {
					for (String category : categories) {
				%>
				<li><a href="?category=<%=category%>"
					<%=category.equals(selectedCategory) ? "class='active'" : ""%>>
						<%=category%>
				</a></li>
				<%
				}
				}
				%>
			</ul>
		</div>

		<div class="products">
			<div class="row">
				<%
				if (products != null && !products.isEmpty()) {
					for (Product p : products) {
				%>
				<div class="col-md-3 my-3">
					<div class="card w-100">
						<div class="image-container">
							<a href="product-details.jsp?id=<%=p.getId()%>"> <img
								class="card-img-top" src="product-images/<%=p.getImage()%>"
								alt="Product Image">
							</a>
						</div>

						<div class="card-body">
							<h5 class="card-title">
								<a href="product-details.jsp?id=<%=p.getId()%>"><%=p.getName()%></a>
							</h5>
							<h6 class="price">
								Price: ₹<%=p.getPrice()%>
							</h6>
							<h6 class="category">
								Category:
								<%=p.getCategory()%>
							</h6>
							<div class="mt-3 d-flex justify-content-between">
								<%
								boolean inCart = false;
								if (cart_list != null) {
									for (Cart cartItem : cart_list) {
										if (cartItem.getId() == p.getId()) {
									inCart = true;
									break;
										}
									}
								}
								if (inCart) {
								%>
								<a href="remove-from-cart?id=<%=p.getId()%>"
									class="btn btn-danger">Remove from Cart</a>
								<%
								} else {
								%>
								<a href="add-to-cart?id=<%=p.getId()%>" class="btn btn-dark">Add
									to Cart</a>
								<%
								}
								%>
								<a href="order-now-servlet?quantity=1&id=<%=p.getId()%>"
									class="btn btn-primary">Buy Now</a>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				} else {
				%>
				<div class="col-12">
					<p>No products available in this category.</p>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<%@ include file="includes/footer.jsp"%>
	<script>
        const alert = "<%=alert != null ? alert : ""%>
		";
		if (alert === "added") {
			Swal.fire({
				icon : 'success',
				title : 'Added to Cart',
				text : 'The item has been successfully added to your cart!',
			});
		} else if (alert === "removed") {
			Swal
					.fire({
						icon : 'success',
						title : 'Removed from Cart',
						text : 'The item has been successfully removed from your cart!',
					});
		}
	</script>
</body>
</html>
