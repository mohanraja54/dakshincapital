package com.dakshin.amfi.response;

import java.util.List;

import com.dakshin.amfi.model.SchemeMapping;


public class MutualFundAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	public List<String> list;
	public List<SchemeMapping> schemeMappingList;
	
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
	public List<String> getList() {
		return list;
	}
	public void setList(List<String> list) {
		this.list = list;
	}
	public List<SchemeMapping> getSchemeMappingList() {
		return schemeMappingList;
	}
	public void setSchemeMappingList(List<SchemeMapping> schemeMappingList) {
		this.schemeMappingList = schemeMappingList;
	}	
}
