package com.dakshin.amfi.response;

public class ApiCommonResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	public String nav_date;
	public String scheme_name;
	public String category;
	public boolean validScheme;
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getStatus_msg() {
		return status_msg;
	}
	public void setStatus_msg(String status_msg) {
		this.status_msg = status_msg;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getNav_date() {
		return nav_date;
	}
	public void setNav_date(String nav_date) {
		this.nav_date = nav_date;
	}
	public boolean isValidScheme() {
		return validScheme;
	}
	public void setValidScheme(boolean validScheme) {
		this.validScheme = validScheme;
	}
	public String getScheme_name() {
		return scheme_name;
	}
	public void setScheme_name(String scheme_name) {
		this.scheme_name = scheme_name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
}
