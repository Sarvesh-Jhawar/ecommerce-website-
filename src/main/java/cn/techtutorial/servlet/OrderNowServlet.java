package cn.techtutorial.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import cn.techtutorial.connection.DBCon;
import cn.techtutorial.dao.OrderDao;
import cn.techtutorial.model.Cart;
import cn.techtutorial.model.Order;
import cn.techtutorial.model.User;

/**
 * Servlet implementation class OrderNowServlet
 */
@WebServlet("/order-now-servlet")
public class OrderNowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	try(PrintWriter out =response.getWriter()){
		SimpleDateFormat formatter=new SimpleDateFormat("dd-MM-yyyy");
		Date date=new Date();
		User auth=(User) request.getSession().getAttribute("auth");
		if(auth!=null) {
			String productId=request.getParameter("id");
			int quantity=Integer.parseInt(request.getParameter("quantity"));
			if(quantity<=0) {
				quantity=1;
			}
			Order orderModel=new Order();
			orderModel.setId(Integer.parseInt(request.getParameter("id")));
			orderModel.setUid(auth.getId());
			orderModel.setQuantity(quantity);
			orderModel.setDate(formatter.format(date));
			OrderDao orderDao=new OrderDao(DBCon.getConnection());
			boolean result=orderDao.insertOrder(orderModel);
			if(result) {
				ArrayList<Cart> cart_list=(ArrayList<Cart>) request.getSession().getAttribute("cart-list");
				if(cart_list!=null) {
					for(Cart c:cart_list) {
						if(c.getId()==Integer.parseInt(productId)) {
							cart_list.remove(cart_list.indexOf(c));
							break;
						}
					}
					response.sendRedirect("orders.jsp");
				}
			}else {
				out.print("order failed");
			}
		}
		else {
			response.sendRedirect("login.jsp");
		}
		
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
