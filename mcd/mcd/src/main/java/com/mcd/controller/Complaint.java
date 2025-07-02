package com.mcd.controller;

import java.io.IOException;

import com.mcd.models.Dao.UserDao;
import com.mcd.models.Dao.UserDaoImpli;
import com.mcd.models.Dto.Complaints;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/complaint")
public class Complaint extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		Complaints c=new Complaints();
		UserDao udao=new UserDaoImpli();
		HttpSession session =req.getSession(false);
		RequestDispatcher rd=null;
		
		c.setUserId(Integer.parseInt(req.getParameter("userId")));
		c.setSubjecct(req.getParameter("subject"));
		c.setDesc(req.getParameter("message"));
		c.setOrderId(Integer.parseInt(req.getParameter("orderNumber")));
		c.setRestoLoc(req.getParameter("location"));
		c.setCallAssist(req.getParameter("followUp"));
		c.setStatus("processing");
		
		if(udao.makeComplaint(c)) {
			req.setAttribute("success", "Complaint Sent Successfully");
			rd=req.getRequestDispatcher("contact.jsp");
			rd.forward(req, resp);
		}else {
			req.setAttribute("fail", "failed to send Complaint");
			rd=req.getRequestDispatcher("contact.jsp");
			rd.forward(req, resp);
		}
	}
}
