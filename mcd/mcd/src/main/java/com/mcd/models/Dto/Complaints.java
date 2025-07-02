package com.mcd.models.Dto;

public class Complaints {
	
	private int complaintId;
	private int userId;
	private String subjecct;
	private String desc;
	private int orderId;
	private String restoLoc;
	private String callAssist;
	private String status;
	private String date;
	private String resloveDate;
	
	
	public String getResloveDate() {
		return resloveDate;
	}
	public void setResloveDate(String resloveDate) {
		this.resloveDate = resloveDate;
	}
	public int getComplaintId() {
		return complaintId;
	}
	public void setComplaintId(int complaintId) {
		this.complaintId = complaintId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getSubjecct() {
		return subjecct;
	}
	public void setSubjecct(String subjecct) {
		this.subjecct = subjecct;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getRestoLoc() {
		return restoLoc;
	}
	public void setRestoLoc(String restoLoc) {
		this.restoLoc = restoLoc;
	}
	public String getCallAssist() {
		return callAssist;
	}
	public void setCallAssist(String callAssist) {
		this.callAssist = callAssist;
	}
	
	
	

}
