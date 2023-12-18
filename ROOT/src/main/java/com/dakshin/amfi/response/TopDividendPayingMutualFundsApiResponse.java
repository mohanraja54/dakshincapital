package com.dakshin.amfi.response;

import java.util.Date;
import java.util.List;

import com.dakshin.amfi.model.DividendAnnualizedReturns;


public class TopDividendPayingMutualFundsApiResponse {
	
	public Integer status;
	public String status_msg;
	public String msg;
	public List<DividendAnnualizedReturns> list;
	public Date end_date;
	
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
	public List<DividendAnnualizedReturns> getList() {
		return list;
	}
	public void setList(List<DividendAnnualizedReturns> list) {
		this.list = list;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
}
