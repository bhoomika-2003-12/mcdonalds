package com.mcd.controller;

import java.io.IOException;



import com.mcd.models.Dao.UserDao;
import com.mcd.models.Dao.UserDaoImpli;
import com.mcd.models.Dto.User;
import com.mcd.utility.Mail;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class Signup extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		User u =new User();
		UserDao udao=new UserDaoImpli(); 
		Mail m=new Mail();
		
		u.setName(req.getParameter("name"));
		u.setEmail(req.getParameter("email"));
		u.setPhone(Long.parseLong(req.getParameter("phone")));
		u.setDob(req.getParameter("dob"));
		u.setPassword(req.getParameter("password"));
		
		RequestDispatcher rd=null;
		
		if(udao.createAccount(u)) {
			req.setAttribute("signupsuccess", "Account Created Successfully!..");
			m.sendWelcomeMail(u.getEmail(), u.getName());
			rd=req.getRequestDispatcher("login.jsp");
			rd.forward(req, resp);
		}else {
			req.setAttribute("fail", "Invalid details!..");
			rd=req.getRequestDispatcher("signup.jsp");
			rd.forward(req, resp);
		}	
	}	

	
	
}
