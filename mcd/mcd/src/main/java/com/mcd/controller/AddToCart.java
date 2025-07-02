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
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		UserDao udao=new UserDaoImpli();
		HttpSession session=req.getSession(false);
		RequestDispatcher rd=null;
		
		if(udao.addtoCart(Integer.parseInt(req.getParameter("fid")), Integer.parseInt(req.getParameter("quantity")), Integer.parseInt(req.getParameter("uid")))) {
			req.setAttribute("pass", "1 item addedd to Cart");
			rd=req.getRequestDispatcher("menu.jsp");
			rd.forward(req, resp);
		}else {
			req.setAttribute("fail", "failed to add item to cart");
			rd=req.getRequestDispatcher("menu.jsp");
			rd.forward(req, resp);
		}
		
		
		
		
	}	
}