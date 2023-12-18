package com.dakshin.amfi.response;

public class FdVsDebtAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	public FDvsDebtResponse fDvsDebtResponse;
	
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
	public FDvsDebtResponse getfDvsDebtResponse() {
		return fDvsDebtResponse;
	}
	public void setfDvsDebtResponse(FDvsDebtResponse fDvsDebtResponse) {
		this.fDvsDebtResponse = fDvsDebtResponse;
	}
}
