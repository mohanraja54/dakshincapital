package com.dakshin.amfi.response;

import java.util.List;

public class SchemeByAmcAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	public List<String> schemes_list ;

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
	public List<String> getSchemes_list() {
		return schemes_list;
	}
	public void setSchemes_list(List<String> schemes_list) {
		this.schemes_list = schemes_list;
	}
}
