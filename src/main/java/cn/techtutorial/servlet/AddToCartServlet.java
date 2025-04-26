package cn.techtutorial.servlet;
import cn.techtutorial.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		
		try {
            int id = Integer.parseInt(request.getParameter("id"));
            Cart cm = new Cart();
            cm.setId(id);
            cm.setQuantity(1);

            HttpSession session = request.getSession();
            ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

            if (cart_list == null) {
                cart_list = new ArrayList<>();
                cart_list.add(cm);
                session.setAttribute("cart-list", cart_list);

                response.sendRedirect("index.jsp?alert=added");
            } else {
                boolean exist = false;
                for (Cart c : cart_list) {
                    if (c.getId() == id) {
                        exist = true;
                        break;
                    }
                }
                if (exist) {
                    response.sendRedirect("index.jsp?alert=exists");
                } else {
                    cart_list.add(cm);
                    response.sendRedirect("index.jsp?alert=added");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("index.jsp?alert=error");
        }

}
}
