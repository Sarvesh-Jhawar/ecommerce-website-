<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="cn.techtutorial.connection.DBCon"%>
<%@ page import="cn.techtutorial.model.*"%>
<%@ page import="cn.techtutorial.dao.ProductDao"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - Manage Products</title>
<%@ include file="includes/head.jsp"%>
<!-- Include head section (Bootstrap, CSS) -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.product-card {
	margin-bottom: 20px;
}

.card-img-top {
	width: 100%;
	height: auto; /* Ensures the image maintains its aspect ratio */
}

.modal-body img {
	max-width: 100%;
	height: auto;
	object-fit: contain; /* Ensures the image fits well inside the modal */
}

.alert {
	margin-top: 20px;
}

.sidebar {
	margin-top: 20px;
	margin-bottom: 20px;
}

.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar ul li a {
	display: block;
	padding: 10px;
	text-decoration: none;
	color: #333;
}

.sidebar ul li a.active {
	font-weight: bold;
	color: #007bff;
}
</style>
</head>
<body>

	<%@ include file="admin_includes/admin_navbar.jsp"%>
	<!-- Include Navbar (Admin) -->

	<div class="container mt-5">
		<h1 class="text-center">Welcome Admin!</h1>
		<h3 class="text-center">Manage Products</h3>

		<!-- Alert messages for success/failure -->
		<div class="alert alert-success" role="alert" id="alertSuccess"
			style="display: none;">
			<strong>Success!</strong> Action completed successfully.
		</div>
		<div class="alert alert-danger" role="alert" id="alertError"
			style="display: none;">
			<strong>Error!</strong> Something went wrong.
		</div>

		<div class="row">
			<!-- Sidebar for Categories -->
			<div class="col-md-3 sidebar">
				<h3>Categories</h3>
				<ul>
					<%
					ProductDao pd = new ProductDao(DBCon.getConnection());
					List<String> categories = pd.getAllCategories();
					String selectedCategory = request.getParameter("category");
					%>
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

			<!-- Product Cards -->
			<div class="col-md-9">
				<div class="row">
					<%
					List<Product> products;
					if ("true".equals(request.getParameter("clear"))) {
						products = pd.getProductsByCategory("all"); // Clear the filters
					} else if (selectedCategory != null && !"all".equals(selectedCategory)) {
						products = pd.getProductsByCategory(selectedCategory);
					} else {
						products = pd.getProductsByCategory("all"); // Default to all products
					}

					if (products != null && !products.isEmpty()) {
						for (Product product : products) {
					%>
					<div class="col-md-4 product-card">
						<div class="card">
							<img class="card-img-top"
								src="product-images/<%=product.getImage()%>"
								alt="<%=product.getName()%>">
							<div class="card-body">
								<h5 class="card-title text-center"><%=product.getName()%></h5>
								<p class="card-text text-center">
									Price: ₹<%=product.getPrice()%></p>

								<!-- Button container for Edit and Delete -->
								<div class="d-flex justify-content-center mb-2">
									<a href="edit-product.jsp?id=<%=product.getId()%>"
										class="btn btn-warning btn-sm mx-2">Edit</a> <a
										href="delete-product?id=<%=product.getId()%>"
										class="btn btn-danger btn-sm mx-2"
										onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
								</div>

								<!-- View Details button -->
								<div class="text-center">
									<button class="btn btn-primary btn-sm" data-toggle="modal"
										data-target="#productModal<%=product.getId()%>">
										View Details</button>
								</div>
							</div>
						</div>
					</div>


					<!-- Product Details Modal -->
					<div class="modal fade" id="productModal<%=product.getId()%>"
						tabindex="-1" role="dialog"
						aria-labelledby="productModalLabel<%=product.getId()%>"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title"
										id="productModalLabel<%=product.getId()%>">
										Product Details:
										<%=product.getName()%></h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<img src="product-images/<%=product.getImage()%>"
										alt="<%=product.getName()%>" class="img-fluid">
									<p>
										<strong>Description:</strong>
										<%=product.getDescription() != null ? product.getDescription() : "No description available."%></p>
									<p>
										<strong>Price:</strong> ₹<%=product.getPrice()%></p>
									<p>
										<strong>Category:</strong>
										<%=product.getCategory()%></p>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
					<%
					}
					} else {
					%>
					<div class="col-12">
						<p class="text-center">No products found!</p>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS, Popper.js, and jQuery -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<!-- Custom Script for Alert -->
	<script>
		function showAlert(type, message) {
			if (type === "success") {
				document.getElementById("alertSuccess").style.display = "block";
				document.getElementById("alertError").style.display = "none";
			} else {
				document.getElementById("alertError").style.display = "block";
				document.getElementById("alertSuccess").style.display = "none";
			}
		}
	</script>

</body>
</html>
