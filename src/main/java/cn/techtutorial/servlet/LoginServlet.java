package cn.techtutorial.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import cn.techtutorial.connection.DBCon;
import cn.techtutorial.dao.UserDao;
import cn.techtutorial.model.User;

@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String email = request.getParameter("login-email");
        String password = request.getParameter("login-password");
        
        try {
            // Validate user credentials
            UserDao udao = new UserDao(DBCon.getConnection());
            User user = udao.userLogin(email, password);
            
            if (user != null) {
                // Record login time in the database
                recordLoginTime(user.getId());
                
                // Store user in session
                HttpSession session = request.getSession();
                session.setAttribute("auth", user);

                // Redirect based on role
                if ("admin".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect("admin-dashboard.jsp"); // Admin Panel
                } else {
                    response.sendRedirect("index.jsp"); // Client Page
                }
            } else {
                // Login failed
                request.getSession().setAttribute("alertType", "error");
                request.getSession().setAttribute("alertMessage", 
                        "Invalid email or password. Please try again or register.");
                response.sendRedirect("login.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to a generic error page
        }
    }

    // Method to record login time
    private void recordLoginTime(int userId) {
        String query = "UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE id = ?";
        try (Connection con = DBCon.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
