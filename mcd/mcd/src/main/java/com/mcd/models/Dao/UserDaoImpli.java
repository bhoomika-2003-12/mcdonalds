package com.mcd.models.Dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.mcd.models.Dto.Cart;
import com.mcd.models.Dto.Complaints;
import com.mcd.models.Dto.Food;
import com.mcd.models.Dto.OrderItems;
import com.mcd.models.Dto.Orders;
import com.mcd.models.Dto.User;
import com.mcd.utility.Connector;
import com.mysql.cj.protocol.Resultset;
import com.mysql.cj.x.protobuf.MysqlxCrud.Order;

public class UserDaoImpli implements UserDao{
	
	
	private Connection con;
	public UserDaoImpli() {
		
		this.con=Connector.getConnection();
	}

	@Override 
	public boolean createAccount(User user) {
		
		
		
		
		String query = "INSERT INTO USER VALUES (0,?, ?, ?, ?,?,CURDATE())";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setLong(3, user.getPhone());
			ps.setString(4, user.getDob());
			ps.setString(5, user.getPassword());
			
			int i = ps.executeUpdate();
			
			if (i>0) return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
		return false;
	}

	@Override
	public User getAccount(String email, String password) {
		
		String query = "SELECT * FROM USER WHERE EMAIL = ? AND PASSWORD = ?";
		User user = null;
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setString(1, email);
			ps.setString(2, password);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				user = new User();
				user.setUserId(rs.getInt("userId"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPhone(rs.getLong("phone"));
				user.setDob(rs.getString("dob"));
				user.setPassword(rs.getString("password"));
				user.setDor(rs.getString("dor"));
				
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
		
		return user;
	}

	@Override
	public boolean updateAccount(User user) {
		
	    String query = "UPDATE user SET name = ?, email = ?, phone = ?, dob = ?, password = ? WHERE userId = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setLong(3, user.getPhone());
			ps.setString(4, user.getDob());
			ps.setString(5, user.getPassword());
			ps.setInt(6, user.getUserId());
			
			int i = ps.executeUpdate();
			if(i>0) return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	@Override
	public User forgetPassword(String email, long phoneNumber) {
		
		String query = "select * from user where email =? and phone=?";
		User user = null;
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setString(1, email);
			ps.setLong(2, phoneNumber);
			
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				user = new User();
	            user.setUserId(rs.getInt("userId")); // Retrieve userId
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPhone(rs.getLong("phone"));
				user.setDob(rs.getString("dob"));
				user.setPassword(rs.getString("password"));
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return user;

	}

	@Override
	public Cart checkCart(String foodName, int user_id) {
	
		String query="SELECT * FROM CART WHERE FOOD_Name=? AND USER_ID=?";
		Cart c=null;
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, foodName);
			ps.setInt(2, user_id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				c=new Cart();
				c.setCart_id(rs.getInt("cart_id"));
				c.setUser_id(rs.getInt("user_id"));
				c.setFood_name(rs.getString("food_name"));
				c.setFood_image(rs.getString("food_image"));
				c.setQuantity(rs.getInt("quantity"));
				c.setPrice(rs.getDouble("price"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return c ;
	}
	
	@Override
	public boolean addtoCart(int food_id, int quantity,int user_id) {
		int i=0;
		String query="SELECT FOOD_NAME,FOOD_IMAGE,FOOD_PRICE FROM FOOD WHERE FOOD_ID=?";
		PreparedStatement ps,ps1,ps3;
		String foodname="";
		String foodImage="";
		double price=0.0;
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1, food_id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				foodname=rs.getString("FOOD_NAME");
				foodImage=rs.getString("FOOD_IMAGE");
				price=rs.getDouble("FOOD_PRICE");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Cart c=checkCart(foodname, user_id);
		
		if(c==null) {
		String query1="INSERT INTO CART VALUES(0,?,?,?,?,?,?,?)";
		try {
			ps1=con.prepareStatement(query1);
			ps1.setInt(1, user_id);
			ps1.setInt(2, food_id);
			ps1.setString(3, foodname);
			ps1.setString(4,foodImage);
			ps1.setInt(5, quantity);
			ps1.setDouble(6, price);
			ps1.setDouble(7, (price*quantity));
			
			i=ps1.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}else {
			
			String query3="UPDATE CART SET quantity=?, total_price=? WHERE USER_ID=? AND FOOD_NAME=?";
			try {
				ps3=con.prepareStatement(query3);
				ps3.setInt(1, c.getQuantity()+quantity);
				ps3.setDouble(2, c.getPrice()*(c.getQuantity()+quantity));
				ps3.setInt(3, user_id);
				ps3.setString(4, foodname);
				
				i=ps3.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(i>0) {
			return true;
			}
		return false;
	}

	
	
	@Override
	public ArrayList<Cart> getCart(int user_id) {
		String query="SELECT * FROM CART WHERE USER_ID=?";
		ArrayList<Cart> cartList=new ArrayList<Cart>();
		Cart c=null;
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, user_id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				c=new Cart();
				c.setCart_id(rs.getInt("cart_id"));
				c.setUser_id(rs.getInt("user_id"));
				c.setFood_id(rs.getInt("food_id"));
				c.setFood_name(rs.getString("food_name"));
				c.setFood_image(rs.getString("food_image"));
				c.setQuantity(rs.getInt("quantity"));
				c.setPrice(rs.getDouble("price"));
				c.setTotal_price(rs.getDouble("total_price"));
				cartList.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cartList;
	}

	@Override
	public boolean deleteCart(int cartid) {
		int i=0;
		String query="DELETE FROM CART WHERE CART_ID=?";	
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, cartid);
			i=ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(i>0) {
			return true;
		}
		return false;
	}
	
	@Override
	public boolean deleteallCart(int userId) {
		String query = "DELETE FROM cart WHERE user_id = ?"; // Use lowercase for consistency
	    
	    try  {
	         PreparedStatement ps = con.prepareStatement(query) ;
	        
	        ps.setInt(1, userId);
	      
	        
	        int rowsDeleted = ps.executeUpdate();
	          
	        System.out.println("Rows deleted: " + rowsDeleted);
	        return rowsDeleted >= 0; // Return true even if 0 rows (cart was empty)
	        
	    } catch (SQLException e) {
	        System.err.println("Error deleting cart for user " + userId);
	        e.printStackTrace();
	        return false;
	    }
	}



	@Override
	public boolean makeOrder(Orders order, ArrayList<Cart> cartItems) {
		int i=0;
		String query="INSERT INTO ORDERS (user_id, order_date, total_price, order_status,payment_method, address, city, state, contact_number) VALUES(?,CURDATE(),?,?,?,?,?,?,?)";
		PreparedStatement ps,ps1;
		ResultSet rs=null;
		int orderId=0;

		
		try {
			ps=con.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, order.getUser_id());
			ps.setDouble(2, order.getTotal_price());
			ps.setString(3, order.getOrder_status());
			ps.setString(4, order.getPayment_method());
			ps.setString(5, order.getAddress());
			ps.setString(6, order.getCity());
			ps.setString(7, order.getState());
			ps.setLong(8, order.getPhone_number());
			
			i=ps.executeUpdate();
			rs=ps.getGeneratedKeys();
			
			if(rs.next()) {
				orderId=rs.getInt(1);
			}
			
			
			String query2="INSERT INTO ORDER_ITEMS (order_id, food_id, food_image,food_name, quantity, total_price) VALUES (?,?,?,?,?,?)";
			ps1=con.prepareStatement(query2);
			for(Cart cartlist: cartItems) {
				ps1.setInt(1, orderId);
				ps1.setInt(2, cartlist.getFood_id());
				ps1.setString(3, cartlist.getFood_image());
				ps1.setString(4, cartlist.getFood_name());
				ps1.setInt(5, cartlist.getQuantity());
				ps1.setDouble(6, cartlist.getTotal_price());
				ps1.addBatch();
			}	
			
			int [] orderitemres=ps1.executeBatch();
			for(int res:orderitemres) {
				if(res==PreparedStatement.EXECUTE_FAILED) {
					return false;
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public ArrayList<Orders> getOrderbyId(int userId) {
		ArrayList<Orders> orderList=new ArrayList<Orders>();
		Orders order=null;
		String query="SELECT * FROM ORDERS WHERE USER_ID=?";
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, userId);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				order=new Orders();
				order.setOrder_id(rs.getInt("order_id"));
				order.setUser_id(rs.getInt("user_Id"));
				order.setOrder_date(rs.getString("order_date"));
				order.setPayment_method(rs.getString("payment_method"));
				order.setAddress(rs.getString("address"));
				order.setCity(rs.getString("city"));
				order.setState(rs.getString("state"));
				order.setPhone_number(rs.getLong("contact_number"));
				order.setTotal_price(rs.getDouble("total_price"));
				order.setOrder_status(rs.getString("order_status"));
				
				orderList.add(order);
				
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return orderList;
		
	}

	@Override
	public ArrayList<Orders> getAllOrder() {
		ArrayList<Orders> orderList=new ArrayList<Orders>();
		Orders order=null;
		String query="SELECT * FROM ORDERS";
		try {
			PreparedStatement ps=con.prepareStatement(query);			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				order=new Orders();
				order.setOrder_id(rs.getInt("order_id"));
				order.setUser_id(rs.getInt("user_Id"));
				order.setOrder_date(rs.getString("order_date"));
				order.setPayment_method(rs.getString("payment_method"));
				order.setAddress(rs.getString("address"));
				order.setCity(rs.getString("city"));
				order.setState(rs.getString("state"));
				order.setPhone_number(rs.getLong("contact_number"));
				order.setTotal_price(rs.getDouble("total_price"));
				order.setOrder_status(rs.getString("order_status"));
				
				orderList.add(order);
				
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return orderList;
	}

	@Override
	public ArrayList<OrderItems> getOrderItemsById(int orderId) {
		ArrayList<OrderItems> orderitemList=new ArrayList<OrderItems>();
		OrderItems orderitem=null;
		String query="SELECT * FROM ORDER_ITEMS WHERE ORDER_ID=?";
	
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, orderId);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				orderitem=new OrderItems();
				
				orderitem.setOrder_item_id(rs.getInt("order_items"));
				orderitem.setOrder_id(rs.getInt("order_id"));
				orderitem.setFood_id(rs.getInt("food_id"));
				orderitem.setFood_image(rs.getString("food_image"));
				orderitem.setFood_name(rs.getString("food_name"));
				orderitem.setQuantity(rs.getInt("quantity"));
				orderitem.setTotalPrice(rs.getDouble("total_price"));
				
				orderitemList.add(orderitem);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orderitemList;
	}

	@Override
	public ArrayList<OrderItems> getAllOrderItemsd() {
		ArrayList<OrderItems> orderitemList=new ArrayList<OrderItems>();
		OrderItems orderitem=null;
		String query="SELECT * FROM ORDER_ITEMS";
	
		try {
			PreparedStatement ps=con.prepareStatement(query);			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				orderitem=new OrderItems();
				
				orderitem.setOrder_item_id(rs.getInt("order_items"));
				orderitem.setOrder_id(rs.getInt("order_id"));
				orderitem.setFood_id(rs.getInt("food_id"));
				orderitem.setFood_image(rs.getString("food_image"));
				orderitem.setFood_name(rs.getString("food_name"));
				orderitem.setQuantity(rs.getInt("quantity"));
				orderitem.setTotalPrice(rs.getDouble("total_price"));
				
				orderitemList.add(orderitem);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orderitemList;	
	}

	@Override
	public boolean makeComplaint(Complaints c) {
		int id=0;
		int i=0;
		String query="INSERT INTO COMPLAINTS(userId,subject,detailedDesc,orderId,restorentLoca,requireCallAsist,status,submitDate) VALUES(?,?,?,?,?,?,?,SYSDATE())";
		try {
			PreparedStatement ps=con.prepareStatement(query);
			
			ps.setInt(1, c.getUserId());
			ps.setString(2, c.getSubjecct());
			ps.setString(3, c.getDesc());
			ps.setInt(4, c.getOrderId());
			ps.setString(5, c.getRestoLoc());
			ps.setString(6, c.getCallAssist());
			ps.setString(7, c.getStatus());
			
			i=ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(i>0) {
			return true;
		}
		return false;
	}


	
	
}
