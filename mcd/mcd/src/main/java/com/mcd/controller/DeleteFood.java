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

@WebServlet("/DeleteFoodServlet")
public class DeleteFood extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	
		AdminDao adao=new AdminDaoImpli();
		RequestDispatcher rd=null;
		if(adao.deleteFood(Integer.parseInt(req.getParameter("foodId")))) {
			req.setAttribute("deleted0", "Food deleted Sucessfully!..");
			rd=req.getRequestDispatcher("showFood.jsp");
			rd.forward(req, resp);
		}else {
			req.setAttribute("deleted0", "failed to delete the Food?..");
			rd=req.getRequestDispatcher("showFood.jsp");
			rd.forward(req, resp);
		}
		
		
		
	}	
}