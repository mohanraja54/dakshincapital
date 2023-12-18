package com.dakshin.response;


public class ApiCalculatorSIP {
	
	public Integer status;
	public String status_msg;
	public String msg;
    private long sip_amount;
    private Double interest_rate;
    private Integer period;
    private long invested_amount;
    private long growth_value;
    private long maturity_amount;
    
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
	public long getSip_amount() {
		return sip_amount;
	}
	public void setSip_amount(long sip_amount) {
		this.sip_amount = sip_amount;
	}
	public Double getInterest_rate() {
		return interest_rate;
	}
	public void setInterest_rate(Double interest_rate) {
		this.interest_rate = interest_rate;
	}
	public Integer getPeriod() {
		return period;
	}
	public void setPeriod(Integer period) {
		this.period = period;
	}
	public long getInvested_amount() {
		return invested_amount;
	}
	public void setInvested_amount(long invested_amount) {
		this.invested_amount = invested_amount;
	}
	public long getGrowth_value() {
		return growth_value;
	}
	public void setGrowth_value(long growth_value) {
		this.growth_value = growth_value;
	}
	public long getMaturity_amount() {
		return maturity_amount;
	}
	public void setMaturity_amount(long maturity_amount) {
		this.maturity_amount = maturity_amount;
	}
}
