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
import jakarta.servlet.http.HttpSession;


@WebServlet("/loginservlete")
public class Login extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		
		UserDao udao=new UserDaoImpli();
		User u=null;
		HttpSession session=req.getSession(true);	
		RequestDispatcher rd=null;
		
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		
		u=udao.getAccount(email, password);
		
		if(u!=null) {
			if(u.getUserId()==1) {
				session.setAttribute("pass", u);
				rd=req.getRequestDispatcher("adminhome.jsp");
				rd.forward(req, resp);
			}else {
			session.setAttribute("pass", u);
			rd=req.getRequestDispatcher("userhome.jsp");
			rd.forward(req, resp);
			}
		}else {
			
			req.setAttribute("usernotfound", "Failed to login check details!..");
			rd=req.getRequestDispatcher("login.jsp");
			rd.forward(req, resp);
			
		}
		
		
	}

	
}
