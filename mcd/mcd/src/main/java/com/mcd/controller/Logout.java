package com.mcd.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Logout")
public class Logout extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		
		        HttpSession session = req.getSession(false);
		        if (session != null) {
		            session.invalidate();
		        }
		        RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
				req.setAttribute("logout", "You have successfully logged out");
				rd.forward(req, resp);

		    
		
		
		
	}	
}