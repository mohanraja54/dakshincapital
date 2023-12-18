package com.dakshin.amfi.response;

import java.util.Date;
import java.util.List;

public class SchemeInceptionAndLatestNavDateAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	public List<Date> list;
	
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
	public List<Date> getList() {
		return list;
	}
	public void setList(List<Date> list) {
		this.list = list;
	}
}
