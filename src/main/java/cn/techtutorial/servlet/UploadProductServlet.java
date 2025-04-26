package cn.techtutorial.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import cn.techtutorial.connection.DBCon;

/**
 * Servlet implementation class UploadProductServlet
 */
@WebServlet("/UploadProductServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UploadProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String category = request.getParameter("category");
        String customCategory = request.getParameter("customCategory");
        Part imagePart = request.getPart("image");

        // Determine the category to save
        if ("other".equalsIgnoreCase(category) && customCategory != null && !customCategory.isEmpty()) {
            category = customCategory; // Use the custom category provided by the user
        }

        double price = Double.parseDouble(priceStr);
        String imageName = imagePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("product-images") + File.separator + imageName;

        // Ensure the upload directory exists
        File uploadDir = new File(getServletContext().getRealPath("product-images"));
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Save the image file to the server
        try (FileOutputStream fos = new FileOutputStream(uploadPath);
             InputStream is = imagePart.getInputStream()) {

            byte[] buffer = new byte[1024];
            int bytesRead;

            while ((bytesRead = is.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }

        // Save product details to the database
        try (Connection con = DBCon.getConnection()) {
            String query = "INSERT INTO products (name, price, category, image) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setDouble(2, price);
            pst.setString(3, category);
            pst.setString(4, imageName);

            int row = pst.executeUpdate();

            if (row > 0) {
                // Product uploaded successfully
                request.getSession().setAttribute("uploadMessage", "success");
            } else {
                // Product upload failed
                request.getSession().setAttribute("uploadMessage", "failure");
            }
            response.sendRedirect("upload_product.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }

}
