package com.dakshin.response;

import java.util.List;

public class CommonResponse 
{
	public int status;
	public String status_msg;
	public String msg;
	public List<String> list;
	public String encrypted_text;
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
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
	public String getEncrypted_text() {
		return encrypted_text;
	}
	public void setEncrypted_text(String encrypted_text) {
		this.encrypted_text = encrypted_text;
	}
}
