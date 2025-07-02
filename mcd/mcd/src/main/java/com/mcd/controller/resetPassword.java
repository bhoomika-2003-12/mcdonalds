package com.mcd.controller;

import java.io.IOException;

import com.mcd.models.Dao.UserDao;
import com.mcd.models.Dao.UserDaoImpli;
import com.mcd.models.Dto.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/resetpasswordservlet")
public class resetPassword extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	User u=null;
	UserDao udao=new UserDaoImpli();
	RequestDispatcher rd=null;
	u=udao.forgetPassword(req.getParameter("email"), Long.parseLong(req.getParameter("phone")));
	
	if(u!=null){
		u.setPassword(req.getParameter("confirmpassword"));
		if(udao.updateAccount(u)) {
		req.setAttribute("passwordChanged", "password  updated successfully");
		rd=req.getRequestDispatcher("login.jsp");
		rd.forward(req, resp);
	}else {
		req.setAttribute("failedtochangepassword", "failed to update password");
		rd=req.getRequestDispatcher("resetpassword.jsp");
		rd.forward(req, resp);
		}
	}else {
		req.setAttribute("failed", "no acount found for those details please signup first");
		rd=req.getRequestDispatcher("resetpassword.jsp");
		rd.forward(req, resp);
		}
	}
}
