package com.mcd.controller;

import java.io.IOException;

import com.mcd.models.Dao.AdminDao;
import com.mcd.models.Dao.AdminDaoImpli;
import com.mcd.models.Dto.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateOrder")
public class AdminUpdateOrder extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	
		AdminDao adao=new AdminDaoImpli();
		HttpSession session=req.getSession(false);
		RequestDispatcher rd=null;
		
		
		if(req.getParameter("action").equals("Confirm")) {
			if(adao.updateOredr("Delivered", Integer.parseInt(req.getParameter("order_id")))) {
			   rd=req.getRequestDispatcher("AdminOrder.jsp");
				rd.forward(req, resp);
				}
			}else { if(adao.updateOredr("cancelled", Integer.parseInt(req.getParameter("order_id")))) {
				   rd=req.getRequestDispatcher("AdminOrder.jsp");
					rd.forward(req, resp);
			}
		}
		
		
		
	}
}	