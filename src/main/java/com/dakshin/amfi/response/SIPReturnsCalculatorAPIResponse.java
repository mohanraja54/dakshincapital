package com.dakshin.amfi.response;

import java.util.List;

public class SIPReturnsCalculatorAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	
	public String category;
	public String fund;
	public String amount;
	public String frequency;
	public String startdate;
    public String enddate;
	public List<SIPCalcFinalResponse> list;
	
	public String sipReturnsGraphData;
	
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
	public List<SIPCalcFinalResponse> getList() {
		return list;
	}
	public void setList(List<SIPCalcFinalResponse> list) {
		this.list = list;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getFund() {
		return fund;
	}
	public void setFund(String fund) {
		this.fund = fund;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getFrequency() {
		return frequency;
	}
	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getSipReturnsGraphData() {
		return sipReturnsGraphData;
	}
	public void setSipReturnsGraphData(String sipReturnsGraphData) {
		this.sipReturnsGraphData = sipReturnsGraphData;
	}
}
