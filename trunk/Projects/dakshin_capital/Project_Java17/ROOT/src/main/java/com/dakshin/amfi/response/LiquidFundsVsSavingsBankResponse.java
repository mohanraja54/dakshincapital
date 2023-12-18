package com.dakshin.amfi.response;


public class LiquidFundsVsSavingsBankResponse {
	
	public Integer status;
	public String status_msg;
	public String msg;
	
	public String amc;
	public String category;
	public String scheme;
	public String amount;
	public String start_date;
	public String end_date;
	public String tax_rate;
	public String savings_rate;
	public double years;
		
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
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getAmc() {
		return amc;
	}
	public void setAmc(String amc) {
		this.amc = amc;
	}
	public String getScheme() {
		return scheme;
	}
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	
	public String getTax_rate() {
		return tax_rate;
	}
	public void setTax_rate(String tax_rate) {
		this.tax_rate = tax_rate;
	}
	public String getSavings_rate() {
		return savings_rate;
	}
	public void setSavings_rate(String savings_rate) {
		this.savings_rate = savings_rate;
	}
	public FDvsDebtResponse getfDvsDebtResponse() {
		return fDvsDebtResponse;
	}
	public void setfDvsDebtResponse(FDvsDebtResponse fDvsDebtResponse) {
		this.fDvsDebtResponse = fDvsDebtResponse;
	}
	public double getYears() {
		return years;
	}
	public void setYears(double years) {
		this.years = years;
	}	
}