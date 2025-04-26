package cn.techtutorial.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import cn.techtutorial.connection.DBCon;
import cn.techtutorial.dao.ProductDao;

/**
 * Servlet implementation class EditProductServlet
 */
@WebServlet("/edit-product")
public class EditProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        int productId = Integer.parseInt(request.getParameter("id"));
	        String name = request.getParameter("name");
	        //String description = request.getParameter("description");
	        double price = Double.parseDouble(request.getParameter("price"));
	        String category = request.getParameter("category");
	        String image = request.getParameter("image");

	        ProductDao productDao = null;
	        try {
	            productDao = new ProductDao(DBCon.getConnection());
	            boolean isUpdated = productDao.updateProduct(productId, name,  price, category, image);
	            if (isUpdated) {
	                response.sendRedirect("admin-dashboard.jsp?message=Product updated successfully");
	            } else {
	                response.sendRedirect("admin-dashboard.jsp?message=Error updating product");
	            }
	        } catch (ClassNotFoundException | SQLException e) {
	            ((Throwable) e).printStackTrace();
	            response.sendRedirect("admin-dashboard.jsp?message=Error updating product");
	        }
	    }

}
