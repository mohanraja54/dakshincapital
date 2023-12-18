package com.dakshin.amfi.response;

import java.util.List;

public class PPFvsELSSAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	public List<SIPSchemePerformanceResponse> list;
	public String result;
	
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
	public List<SIPSchemePerformanceResponse> getList() {
		return list;
	}
	public void setList(List<SIPSchemePerformanceResponse> list) {
		this.list = list;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
}
