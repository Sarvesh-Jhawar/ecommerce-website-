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

@WebServlet("/delete-product")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get product ID from request parameters
        int productId = Integer.parseInt(request.getParameter("id"));

        // Create ProductDao instance
        ProductDao productDao = null;
        boolean isDeleted = false;

        try {
            productDao = new ProductDao(DBCon.getConnection());
            isDeleted = productDao.deleteProduct(productId);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?message=Error occurred while deleting the product.");
            return;  // Exit here after error handling
        }

        // Redirect to the dashboard with appropriate message
        if (isDeleted) {
            response.sendRedirect("admin-dashboard.jsp?message=Product deleted successfully");
        } else {
            response.sendRedirect("admin-dashboard.jsp?message=Error deleting product");
        }
    }
}
