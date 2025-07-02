package com.mcd.models.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mcd.models.Dto.Complaints;
import com.mcd.models.Dto.Food;
import com.mcd.models.Dto.User;
import com.mcd.utility.Connector;

public class AdminDaoImpli implements AdminDao{

	
	private Connection con;
	public AdminDaoImpli() {
		
		this.con=Connector.getConnection();
	}
	
	@Override
	public boolean deleteUser(int userId) {
		
		String query = "DELETE FROM USER WHERE USERID = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setInt(1, userId);
			
			int i = ps.executeUpdate();
			
			if(i>0) return true;
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return false;
	}

	
	
	
	
	
	
	
	
	
	
	
	@Override
	public ArrayList<User> getAllUser() {
		
		ArrayList<User> allUsers = new ArrayList<User>();
		User user = null;
		
		String query = "SELECT * FROM USER WHERE USERID != 1";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				user = new User();
				user.setUserId(rs.getInt("userid"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPhone(rs.getLong("phone"));
				user.setDob(rs.getString("dob"));
				user.setDor(rs.getString("dor"));
				allUsers.add(user);
	
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return allUsers;
	}






	@Override
	public User getUser(int userid) {
		
		User user = null;
		
		String query = "SELECT * FROM USER WHERE userid = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setLong(1, userid);
			
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				user = new User();
				user.setUserId(rs.getInt("userid"));
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
	public boolean addFood(Food f) {
		int i=0;
		String query="INSERT INTO FOOD VALUES(0,?,?,?,?,?,?)";
		;
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, f.getFood_name());
			ps.setString(2, f.getFood_desc());
			ps.setString(3, f.getFood_type());
			ps.setString(4, f.getFood_category());
			ps.setDouble(5, f.getFood_price());
			ps.setString(6, f.getFood_image());
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
	public boolean updateFood(Food f) {
		int i=0;
		String query="UPDATE FOOD SET food_name=? ,food_desc=?, food_type=?, food_category=?, food_price=?, Food_image=? WHERE FOOD_ID=?";
		
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, f.getFood_name());
			ps.setString(2, f.getFood_desc());
			ps.setString(3, f.getFood_type());
			ps.setString(4, f.getFood_category());
			ps.setDouble(5, f.getFood_price());
			ps.setString(6, f.getFood_image());
			ps.setInt(7, f.getFood_id());
			
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
	public boolean deleteFood(int foodid) {
		int i=0;
		String query="DELETE FROM FOOD WHERE FOOD_ID=?";
		
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, foodid);
			
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
	public ArrayList<Food> getAllFood() {
		String query="SELECT * FROM FOOD";
		ArrayList<Food> foodList=new ArrayList<>();
		Food f=null;
		
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				f=new Food();
				f.setFood_id(rs.getInt("food_Id"));
				f.setFood_name(rs.getString("food_name"));
				f.setFood_desc(rs.getString("food_desc"));
				f.setFood_type(rs.getString("food_type"));
				f.setFood_category(rs.getString("food_category"));
				f.setFood_price(rs.getDouble("food_price"));
				f.setFood_image(rs.getString("Food_image"));
				
				foodList.add(f);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return foodList;
	}

	@Override
	public Food getFoodbyId(int foodid) {
		String query="SELECT * FROM FOOD WHERE FOOD_ID=?";
		
		Food f=null;
		PreparedStatement ps;
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1, foodid);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				f=new Food();
				f.setFood_id(rs.getInt("food_Id"));
				f.setFood_name(rs.getString("food_name"));
				f.setFood_desc(rs.getString("food_desc"));
				f.setFood_type(rs.getString("food_type"));
				f.setFood_category(rs.getString("food_category"));
				f.setFood_price(rs.getDouble("food_price"));
				f.setFood_image(rs.getString("Food_image"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}

	
	
	@Override
	public ArrayList<Food> getFoodByCategory(String category) {
		String query="SELECT * FROM FOOD WHERE food_category=?";
		ArrayList<Food> foodList=new ArrayList<Food>();
		ResultSet rs=null;
		Food f=null;
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, category);
			rs=ps.executeQuery();
			while(rs.next()) {
				f=new Food();
				f.setFood_id(rs.getInt("food_Id"));
				f.setFood_name(rs.getString("food_name"));
				f.setFood_desc(rs.getString("food_desc"));
				f.setFood_type(rs.getString("food_type"));
				f.setFood_category(rs.getString("food_category"));
				f.setFood_price(rs.getDouble("food_price"));
				f.setFood_image(rs.getString("Food_image"));
				
				foodList.add(f);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return foodList;
	}

	
	
	@Override
	public boolean updateOredr(String order_status, int order_Id) {
		int i=0;
		String query="UPDATE ORDERS SET ORDER_STATUS=? WHERE ORDER_ID=?";
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, order_status);
			ps.setInt(2, order_Id);
			
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
	public int getTodayOrderCount() {
		int count=0;
		String query="SELECT COUNT(*) as order_count FROM ORDERS WHERE ORDER_DATE=CURDATE()";
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				count=rs.getInt("order_count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}

	@Override
	public int getTotalCustomer() {
		int count=0;
		String query="SELECT COUNT(*) as customer_count FROM USER WHERE USERID!=1";
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				count=rs.getInt("customer_count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}

	@Override
	public ArrayList<Complaints> getAllComplaints() {
		ArrayList<Complaints> clist=new ArrayList<>();
		Complaints c=null;
		String query="SELECT * FROM COMPLAINTS";
		try {
			PreparedStatement ps=con.prepareStatement(query);
		    ResultSet rs=ps.executeQuery();
		    while(rs.next()) {
		    	c=new Complaints();
		    	c.setComplaintId(rs.getInt("complaintId"));
		    	c.setUserId(rs.getInt("userId"));
		    	c.setSubjecct(rs.getString("subject"));
		    	c.setDesc(rs.getString("detailedDesc"));
		    	c.setOrderId(rs.getInt("orderId"));
		    	c.setRestoLoc(rs.getString("restorentLoca"));
		    	c.setCallAssist(rs.getString("requireCallAsist"));
		    	c.setStatus(rs.getString("status"));
		    	c.setDate(rs.getString("submitDate"));
		    	c.setResloveDate(rs.getString("resolveDate"));
		    	clist.add(c);
		    }	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return clist;
	}
	
	
	

	@Override
	public Complaints getComplaintsById(int userId) {
		Complaints c=null;
		String query="SELECT * FROM COMPLAINTS WHERE USERID=?";
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, userId);
		    ResultSet rs=ps.executeQuery();
		    while(rs.next()) {
		    	c=new Complaints();
		    	c.setComplaintId(rs.getInt("complaintId"));
		    	c.setUserId(rs.getInt("userId"));
		    	c.setSubjecct(rs.getString("subject"));
		    	c.setDesc(rs.getString("detailedDesc"));
		    	c.setOrderId(rs.getInt("orderId"));
		    	c.setRestoLoc(rs.getString("restorentLoca"));
		    	c.setCallAssist(rs.getString("requireCallAsist"));	
		    	c.setStatus(rs.getString("status"));
		    	c.setDate(rs.getString("submitDate"));
		    	c.setResloveDate(rs.getString("resolveDate"));
		    }	
		    
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return c;
	}

	@Override
	public boolean updateComplaint(int complaintId, int userId, String status) {
		int i=0;
		String query="UPDATE COMPLAINTS SET STATUS=?, resolveDate=sysdate() WHERE complaintId=? AND USERID=?";
		PreparedStatement ps;
		try {
			ps = con.prepareStatement(query);
			ps.setString(1, status);
			ps.setInt(2, complaintId);
			ps.setInt(3, userId);
			
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
