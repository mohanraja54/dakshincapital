package com.dakshin.amfi.response;


public class ApiCalculatorGoalSetting {
	
	private Integer status;
	private String status_msg;
	private String msg;
    private Integer years;
    private long dream_amount;
    private Double inflation_rate;
    private Double expected_return;
    private long savings_amount;
    private long target_dream_amount;
    private long target_savings_amount;
    private long target_amount;
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
	public Integer getYears() {
		return years;
	}
	public void setYears(Integer years) {
		this.years = years;
	}
	public long getDream_amount() {
		return dream_amount;
	}
	public void setDream_amount(long dream_amount) {
		this.dream_amount = dream_amount;
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
	public long getTarget_dream_amount() {
		return target_dream_amount;
	}
	public void setTarget_dream_amount(long target_dream_amount) {
		this.target_dream_amount = target_dream_amount;
	}
	public long getTarget_savings_amount() {
		return target_savings_amount;
	}
	public void setTarget_savings_amount(long target_savings_amount) {
		this.target_savings_amount = target_savings_amount;
	}
	public long getTarget_amount() {
		return target_amount;
	}
	public void setTarget_amount(long target_amount) {
		this.target_amount = target_amount;
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
}
