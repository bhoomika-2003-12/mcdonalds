package com.mcd.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.mcd.models.Dao.UserDao;
import com.mcd.models.Dao.UserDaoImpli;
import com.mcd.models.Dto.Cart;
import com.mcd.models.Dto.Orders;
import com.mcd.models.Dto.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order")
public class OrderFood extends HttpServlet{


	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession(false);
		RequestDispatcher rd=null;
		
		// Session validation
        if (session == null || session.getAttribute("pass") == null) {
            req.setAttribute("error", "Session expired. Please login again.");
            rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, resp);
            return;
        }

        User user = (User) session.getAttribute("pass");
        UserDao udao = new UserDaoImpli();
		
		
		
		
		ArrayList<Cart> cartList=udao.getCart(user.getUserId());
		
		Orders order=new Orders();
		order.setUser_id(user.getUserId());
		order.setTotal_price(Double.parseDouble(req.getParameter("tcost")));
		order.setPayment_method(req.getParameter("payment_method"));
		order.setOrder_status("pending");
		order.setAddress(req.getParameter("address"));
		order.setCity(req.getParameter("city"));
		order.setState(req.getParameter("state"));
		order.setPhone_number(Long.parseLong(req.getParameter("phonenumber")));
		
		
		if(udao.makeOrder(order,cartList)){
			boolean istrue=udao.deleteallCart(user.getUserId());
			System.out.println(istrue);
			System.out.println(user.getUserId());
			session.setAttribute("currentOrder",order);	
			req.setAttribute("success", "Your order has been placed successfully!");
			session.setAttribute("pass", user);
			rd=req.getRequestDispatcher("cart.jsp");
			rd.forward(req, resp);
		}else {
			req.setAttribute("error", "Failed to process your order. Please try again.");
			rd=req.getRequestDispatcher("cart.jsp");
			rd.forward(req, resp);
		}
		
	}
}