package com.dakshin.amfi.response;

import java.util.List;

public class PointToPointReturnsCalculatorAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	public List<SIPReturnsCalculatorResponse> list;
	public List<PointToPointResponse> pointToPointResponseList;
	
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
	public List<SIPReturnsCalculatorResponse> getList() {	
		return list;
	}
	public void setList(List<SIPReturnsCalculatorResponse> list) {
		this.list = list;
	}
	public List<PointToPointResponse> getPointToPointResponseList() {
		return pointToPointResponseList;
	}
	public void setPointToPointResponseList(List<PointToPointResponse> pointToPointResponseList) {
		this.pointToPointResponseList = pointToPointResponseList;
	}
}
