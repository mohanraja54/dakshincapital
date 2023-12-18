package com.dakshin.amfi.response;

import java.util.List;

public class SIPReturnsCalculatorAPIAnnualIncreaseResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	public List<SipYearlyEnhancementResponse> sipYearlyEnhancementResponse;
	public List<List<SipNavResponse>> sipNavResponseList;

	public List<SipYearlyEnhancementResponse> getSipYearlyEnhancementResponse() {
		return sipYearlyEnhancementResponse;
	}
	public void setSipYearlyEnhancementResponse(
			List<SipYearlyEnhancementResponse> sipYearlyEnhancementResponse) {
		this.sipYearlyEnhancementResponse = sipYearlyEnhancementResponse;
	}
	public List<List<SipNavResponse>> getSipNavResponseList() {
		return sipNavResponseList;
	}
	public void setSipNavResponseList(List<List<SipNavResponse>> sipNavResponseList) {
		this.sipNavResponseList = sipNavResponseList;
	}
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
	
}
