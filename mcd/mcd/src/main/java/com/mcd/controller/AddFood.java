package com.mcd.controller;

import java.io.IOException;

import com.mcd.models.Dao.AdminDao;
import com.mcd.models.Dao.AdminDaoImpli;
import com.mcd.models.Dto.Food;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddFoodServlet")
public class AddFood extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Food f=new Food();
		AdminDao adao=new AdminDaoImpli();
		
		f.setFood_name(req.getParameter("foodName"));
		f.setFood_desc(req.getParameter("foodDescription"));
		f.setFood_category(req.getParameter("foodCategory"));
		f.setFood_type(req.getParameter("foodType"));
		f.setFood_image(req.getParameter("foodImage"));
		f.setFood_price(Double.parseDouble(req.getParameter("foodPrice")));
		
		RequestDispatcher rd=null;
		
		if(adao.addFood(f)) {
			req.setAttribute("success", "FoodAddedd Successfully!...");
			rd=req.getRequestDispatcher("addFood.jsp");
			rd.forward(req, resp);
		}else {
			req.setAttribute("fail", "failed to add Food?...");
			rd=req.getRequestDispatcher("addFood.jsp");
			rd.forward(req, resp);
		}
		
		
	}

}
