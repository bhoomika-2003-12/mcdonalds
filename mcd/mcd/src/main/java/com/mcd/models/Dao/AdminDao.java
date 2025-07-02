package com.mcd.models.Dao;

import java.util.ArrayList;
import java.util.List;

import com.mcd.models.Dto.Complaints;
import com.mcd.models.Dto.Food;
import com.mcd.models.Dto.User;

public interface AdminDao {

	User getUser(int user_Id); // ?? mobile number

	boolean deleteUser(int userId);

	ArrayList<User> getAllUser();
	
	
	
	boolean addFood(Food f);
	boolean updateFood(Food f);
	boolean deleteFood(int foodid);
	ArrayList<Food> getAllFood();
	Food getFoodbyId(int foodid);	
	ArrayList<Food> getFoodByCategory(String category);
	
	boolean updateOredr(String data,int order_Id);
	int getTodayOrderCount();
	int getTotalCustomer();
	
	public ArrayList<Complaints> getAllComplaints();
	public Complaints getComplaintsById(int userId);
	public boolean updateComplaint(int complaintId,int userId,String data);

}
