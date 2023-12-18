package com.dakshin.response;


public class ApiCalculatorCrorepati {
	
	public Integer status;
	public String status_msg;
	public String msg;
    private Integer current_age;
    private Integer retirement_age;
    private long wealth_amount;
    private Double inflation_rate;
    private Double expected_return;
    private long savings_amount;
    private long target_wealth;
    private long target_savings;
    private long target_amount;
    private Integer years;
    private long monthly_savings;
    private long invested_amount;
    private long total_earnings;
    
    
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
	public Integer getCurrent_age() {
		return current_age;
	}
	public void setCurrent_age(Integer current_age) {
		this.current_age = current_age;
	}
	public Integer getRetirement_age() {
		return retirement_age;
	}
	public long getWealth_amount() {
		return wealth_amount;
	}
	public void setWealth_amount(long wealth_amount) {
		this.wealth_amount = wealth_amount;
	}
	public Double getInflation_rate() {
		return inflation_rate;
	}
	public void setInflation_rate(Double inflation_rate) {
		this.inflation_rate = inflation_rate;
	}
	public Double getExpected_return() {
		return expected_return;
	}
	public void setExpected_return(Double expected_return) {
		this.expected_return = expected_return;
	}
	public long getSavings_amount() {
		return savings_amount;
	}
	public void setSavings_amount(long savings_amount) {
		this.savings_amount = savings_amount;
	}
	public long getTarget_wealth() {
		return target_wealth;
	}
	public void setTarget_wealth(long target_wealth) {
		this.target_wealth = target_wealth;
	}
	public long getTarget_savings() {
		return target_savings;
	}
	public void setTarget_savings(long target_savings) {
		this.target_savings = target_savings;
	}
	public long getTarget_amount() {
		return target_amount;
	}
	public void setTarget_amount(long target_amount) {
		this.target_amount = target_amount;
	}
	public Integer getYears() {
		return years;
	}
	public void setYears(Integer years) {
		this.years = years;
	}
	public long getMonthly_savings() {
		return monthly_savings;
	}
	public void setMonthly_savings(long monthly_savings) {
		this.monthly_savings = monthly_savings;
	}
	public long getInvested_amount() {
		return invested_amount;
	}
	public void setInvested_amount(long invested_amount) {
		this.invested_amount = invested_amount;
	}
	public long getTotal_earnings() {
		return total_earnings;
	}
	public void setTotal_earnings(long total_earnings) {
		this.total_earnings = total_earnings;
	}
	public void setRetirement_age(Integer retirement_age) {
		this.retirement_age = retirement_age;
	}
}
