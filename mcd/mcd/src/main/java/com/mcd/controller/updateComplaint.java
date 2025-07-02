package com.mcd.controller;

import java.io.IOException;

import com.mcd.models.Dao.AdminDao;
import com.mcd.models.Dao.AdminDaoImpli;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateComplaint")
public class updateComplaint extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		AdminDao adao=new AdminDaoImpli();
	    HttpSession session=req.getSession(false);
	    RequestDispatcher rd=null;
	     
		if(adao.updateComplaint(Integer.parseInt(req.getParameter("complaint_Id")), Integer.parseInt(req.getParameter("user_id")), req.getParameter("action"))){
			rd=req.getRequestDispatcher("adminComplaint.jsp");
			rd.forward(req, resp);
		}else {
			
			rd=req.getRequestDispatcher("adminComplaint.jsp");
			rd.forward(req, resp);
		}

	}	
}