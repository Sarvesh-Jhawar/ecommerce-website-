package cn.techtutorial.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import cn.techtutorial.connection.DBCon;
import cn.techtutorial.dao.OrderDao;
import cn.techtutorial.model.Cart;
import cn.techtutorial.model.Order;
import cn.techtutorial.model.User;

@WebServlet("/check-out")
public class CheckOutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            Date date = new Date();
            ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
            User auth = (User) request.getSession().getAttribute("auth");

            if (cart_list != null && auth != null) {
                try (Connection con = DBCon.getConnection()) {
                    OrderDao odao = new OrderDao(con);
                    for (Cart c : cart_list) {
                        Order order = new Order();
                        order.setId(c.getId());
                        order.setUid(auth.getId());
                        order.setQuantity(c.getQuantity());
                        order.setDate(formatter.format(date));
                        if (!odao.insertOrder(order)) {
                            throw new Exception("Failed to insert order for cart item: " + c);
                        }
                    }
                    // Replace the cart list with a new empty list
                    request.getSession().setAttribute("cart-list", new ArrayList<Cart>());
                    response.sendRedirect("orders.jsp");
                }
            } else {
                if (auth == null) {
                    response.sendRedirect("login.jsp");
                } else {
                    response.sendRedirect("cart.jsp?error=cart_is_empty");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=checkout_failed");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
