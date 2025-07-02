package com.mcd.controller;

import java.io.IOException;

import com.mcd.models.Dao.AdminDao;
import com.mcd.models.Dao.AdminDaoImpli;
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


@WebServlet("/updateProfile")
public class Updateprofile extends HttpServlet {

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


		
		User u=new User();
		UserDao udao=new UserDaoImpli();
		AdminDao adao=new AdminDaoImpli();
		HttpSession session=req.getSession(false);
		
		u.setUserId(Integer.parseInt(req.getParameter("uid")));
		u.setName(req.getParameter("name"));
		u.setEmail(req.getParameter("email"));
		u.setPhone(Long.parseLong(req.getParameter("phone")));
		u.setPassword(req.getParameter("password"));
		u.setDob(req.getParameter("dob"));
		RequestDispatcher rd=null;
		
		
		if(udao.updateAccount(u)) {
		u=adao.getUser(u.getUserId());
		session.setAttribute("pass", u);
			req.setAttribute("success", "update sucessfull");
			rd=req.getRequestDispatcher("profile.jsp");
			rd.forward(req, resp);
		}else {
			req.setAttribute("error", "failed to update");
			rd=req.getRequestDispatcher("profile.jsp");
			rd.forward(req, resp);
		}
	}	
}