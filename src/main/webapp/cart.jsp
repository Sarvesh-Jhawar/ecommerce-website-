<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="cn.techtutorial.connection.DBCon"%>
<%@ page import="cn.techtutorial.model.*"%>
<%@ page import="cn.techtutorial.dao.*"%>

<%@ page import="java.util.*"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}
ArrayList<Cart> cart_list=(ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct=null;
double totalPrice = 0;

if (cart_list != null) {
    ProductDao pDao = new ProductDao(DBCon.getConnection());
    cartProduct = pDao.getCartProducts(cart_list);
    totalPrice=pDao.getTotalCartPrice(cart_list);

    request.setAttribute("cart_list",cart_list);
    request.setAttribute("totalPrice",totalPrice);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Cart page</title>
<%@include file="includes/head.jsp"%>
<style type="text/css">
.table tbody td{
vertical-align: middle;
}
.btn-incre,.btn-decre{
box-shadow:none;
font-size:25px;
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
		<div class="d-flex py-3">
            <h3>Total price is <%= String.format("%.2f", totalPrice) %></h3>
			<a class="mx-3 btn btn-primary" href="check-out"> CheckOut</a>
		</div>
		<table class="table table-loght">
			<thead>
				<tr>
					<th = scope="col">Name</th>
					<th = scope="col">Category</th>
					<th = scope="col">Price</th>
					<th = scope="col">Buy Now</th>
					<th = scope="col">Cancel</th>


				</tr>
			</thead>
			<tbody>
                <% if (cart_list != null && cartProduct != null) {
                    for (Cart c : cartProduct) { %>
                        <tr>
                            <td><%=c.getName() %></td>
                            <td><%=c.getCategory() %></td>
                            <td><%= String.format("%.2f", c.getPrice()) %>/- </td>
                            <td>
                                <form action="order-now-servlet" method="post" class="form-inline">
                                    <input type="hidden" name="id" value="<%=c.getId() %>" class="form-input">
                                    <div class="form-group d-flex align-items-center">
                                        <a class="btn btn-sm btn-outline-primary px-3" href="quantity-Inc-dec?action=inc&id=<%=c.getId()%>">
                                            <i class="fa-solid fa-plus"></i>
                                        </a>
                                        <input type="text" name="quantity" class="form-control mx-2 text-center" value="<%=c.getQuantity() %>"
                                        readonly style="width: 50px; background-color: #f8f9fa; border: 1px solid #ddd;">
                                        <a class="btn btn-sm btn-outline-danger px-3" href="quantity-Inc-dec?action=dec&id=<%=c.getId()%>">
                                            <i class="fa-solid fa-minus"></i>
                                        </a>
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-sm"> Buy </button>
                                </form>
                            </td>
                            <td><a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%=c.getId() %>">Remove</a></td>
                        </tr>
                    <% }
                } %>
            </tbody>
		</table>
	</div>

	<%@include file="includes/footer.jsp"%>

</body>
</html>