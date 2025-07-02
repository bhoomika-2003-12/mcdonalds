package com.mcd.models.Dao;

import java.util.ArrayList;


import com.mcd.models.Dto.Cart;
import com.mcd.models.Dto.Complaints;
import com.mcd.models.Dto.Food;
import com.mcd.models.Dto.OrderItems;
import com.mcd.models.Dto.Orders;
import com.mcd.models.Dto.User;
import com.mysql.cj.x.protobuf.MysqlxCrud.Order;

public interface UserDao {
	
	boolean createAccount(User user); // Adds a new customer to the database.

	User getAccount(String email, String password); // used for login.

	boolean updateAccount(User user); // Update Customer

	User forgetPassword(String email, long phoneNumber); // forgetPassword
	
	boolean addtoCart(int food_id,int quantity,int user_id);
	
	Cart checkCart(String food_Name,int user_id);
	
	ArrayList<Cart> getCart(int user_id);
	
	boolean deleteCart(int cartid);
	boolean deleteallCart(int userId);
	
	//int getCartCount(int userId);
	
	boolean makeOrder(Orders order, ArrayList<Cart> cartItems);
	
	ArrayList<Orders> getOrderbyId(int userId);
	ArrayList<Orders> getAllOrder();
	
	ArrayList<OrderItems> getOrderItemsById(int orderId);
	ArrayList<OrderItems> getAllOrderItemsd();
	
    boolean makeComplaint(Complaints c);
	
	
	
	



}
