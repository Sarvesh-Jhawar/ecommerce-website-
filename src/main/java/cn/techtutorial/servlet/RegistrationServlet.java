package cn.techtutorial.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import cn.techtutorial.connection.DBCon;
import cn.techtutorial.dao.UserDao;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // Retrieve user input from the registration form
        String name = request.getParameter("register-name");
        String email = request.getParameter("register-email");
        String password = request.getParameter("register-password");

        // Create an instance of UserDao
        UserDao userDao = null;
		try {
			userDao = new UserDao(DBCon.getConnection());
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Call userRegister method to register the user
        boolean isRegistered = userDao.userRegister(name, email, password);

        if (isRegistered) {
            // Registration successful
            session.setAttribute("alertType", "success");
            session.setAttribute("alertMessage", "Registration successful!");
        } else {
            // Registration failed
            session.setAttribute("alertType", "error");
            session.setAttribute("alertMessage", "Registration failed. Please try again.");
        }

        // Redirect to the registration page to show alert
        response.sendRedirect("register.jsp");
    }
}
