package com.mcd.controller;

import java.io.IOException;

import com.mcd.models.Dto.Food;
import com.mcd.models.Dao.AdminDao;
import com.mcd.models.Dao.AdminDaoImpli;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateFoodServlet")
public class UpdateFood extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String foodId = req.getParameter("foodId");
        
        try {
            // Validate required parameters
            if (foodId == null || foodId.isEmpty()) {
                throw new IllegalArgumentException("Food ID is required");
            }
            
            // Parse and validate numeric fields
            double foodPrice;
            try {
                foodPrice = Double.parseDouble(req.getParameter("foodPrice"));
                if (foodPrice <= 0) {
                    throw new IllegalArgumentException("Price must be greater than 0");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid price format");
            }
            
            // Create and populate Food object
            Food f = new Food();
            f.setFood_id(Integer.parseInt(foodId));
            f.setFood_name(req.getParameter("foodName"));
            f.setFood_desc(req.getParameter("foodDescription"));
            f.setFood_category(req.getParameter("foodCategory"));
            f.setFood_type(req.getParameter("foodType"));
            f.setFood_image(req.getParameter("foodImage"));
            f.setFood_price(foodPrice);
            
            // Update food
            AdminDao adao = new AdminDaoImpli();
            boolean success = adao.updateFood(f);
            
            // Set session attributes based on result
            if (success) {
                session.setAttribute("message", "Food updated successfully");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Failed to update food");
                session.setAttribute("messageType", "error");
            }
            
            // Redirect to avoid form resubmission
            resp.sendRedirect("updateFood.jsp?id=" + foodId);
            
        } catch (IllegalArgumentException e) {
            // Handle validation errors
            session.setAttribute("message", e.getMessage());
            session.setAttribute("messageType", "error");
            resp.sendRedirect("updateFood.jsp?id=" + foodId);
        } catch (Exception e) {
            // Handle other unexpected errors
            session.setAttribute("message", "An unexpected error occurred: " + e.getMessage());
            session.setAttribute("messageType", "error");
            resp.sendRedirect("updateFood.jsp?id=" + foodId);
            e.printStackTrace();
        }
    }
}