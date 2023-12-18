package com.dakshin.amfi.response;

import java.util.List;

import com.dakshin.amfi.model.SchemePerformancesLumpsum;

public class TopPerformingLumpsumFundsResponse {
	
	public Integer status;
	public String status_msg;
	public String msg;
	
	public String category;
	public String period;
	public String	amount;
		
	public List<SchemePerformancesLumpsum> list;
	public SchemePerformancesLumpsum benchmark_returns;
	
	
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
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public List<SchemePerformancesLumpsum> getList() {
		return list;
	}
	public void setList(List<SchemePerformancesLumpsum> list) {
		this.list = list;
	}
	public SchemePerformancesLumpsum getBenchmark_returns() {
		return benchmark_returns;
	}
	public void setBenchmark_returns(SchemePerformancesLumpsum benchmark_returns) {
		this.benchmark_returns = benchmark_returns;
	}
}
