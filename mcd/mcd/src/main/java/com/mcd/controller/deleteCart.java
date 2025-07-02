package com.mcd.controller;

import java.io.IOException;

import com.mcd.models.Dao.UserDao;
import com.mcd.models.Dao.UserDaoImpli;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/removeFromCart")
public class deleteCart extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		
		int id=Integer.parseInt(req.getParameter("cartId"));
		UserDao udao=new UserDaoImpli();
		RequestDispatcher rd=null;
		
		if(udao.deleteCart(id)) {
		req.setAttribute("deleted", "1 item deleted from your cart");
		rd=req.getRequestDispatcher("cart.jsp");
		rd.forward(req, resp);
		}else {
			req.setAttribute("notdeleted", "failed to delete the item from cart");
			rd=req.getRequestDispatcher("cart.jsp");
			rd.forward(req, resp);
		}
		
		
		
	}
}