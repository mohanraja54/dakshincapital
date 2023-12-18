package com.dakshin.amfi.response;


public class ApiCalculatorCompositePlanner {
	
	public Integer status;
	public String status_msg;
	public String msg;
    private Integer child_current_age;
    private Integer child_education_age;
    private long education_amount;
    private Integer current_age;
    private Integer wealth_age;
    private long wealth_amount;
    private long expense_amount;
    private Integer expense_year;
    private Double inflation_rate;
    private Double expected_return;
    private long savings_amount;
    private long total_education_amount;
    private long total_wealth_amount;
    private long total_expense_amount;
    private long total_current_value;
    private Integer final_education_year;
    private Integer final_wealth_year;
    private Integer final_expense_year;
    private long education_target;
    private long wealth_target;
    private long expense_target;
    private long total_inflation_adjust_value;
    private long education_savings_amount;
    private long wealth_savings_amount;
    private long expense_savings_amount;
    private long total_savings_amount;
    private long education_monthly_savings;
    private long wealth_monthly_savings;
    private long expense_monthly_savings;
    private long total_monthly_savings;
    
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
	public Integer getChild_current_age() {
		return child_current_age;
	}
	public void setChild_current_age(Integer child_current_age) {
		this.child_current_age = child_current_age;
	}
	public Integer getChild_education_age() {
		return child_education_age;
	}
	public long getEducation_amount() {
		return education_amount;
	}
	public void setEducation_amount(long education_amount) {
		this.education_amount = education_amount;
	}
	public Integer getCurrent_age() {
		return current_age;
	}
	public void setCurrent_age(Integer current_age) {
		this.current_age = current_age;
	}
	public Integer getWealth_age() {
		return wealth_age;
	}
	public void setWealth_age(Integer wealth_age) {
		this.wealth_age = wealth_age;
	}
	public long getWealth_amount() {
		return wealth_amount;
	}
	public void setWealth_amount(long wealth_amount) {
		this.wealth_amount = wealth_amount;
	}
	public long getExpense_amount() {
		return expense_amount;
	}
	public void setExpense_amount(long expense_amount) {
		this.expense_amount = expense_amount;
	}
	public Integer getExpense_year() {
		return expense_year;
	}
	public void setExpense_year(Integer expense_year) {
		this.expense_year = expense_year;
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
	public long getTotal_education_amount() {
		return total_education_amount;
	}
	public void setTotal_education_amount(long total_education_amount) {
		this.total_education_amount = total_education_amount;
	}
	public long getTotal_wealth_amount() {
		return total_wealth_amount;
	}
	public void setTotal_wealth_amount(long total_wealth_amount) {
		this.total_wealth_amount = total_wealth_amount;
	}
	public long getTotal_expense_amount() {
		return total_expense_amount;
	}
	public void setTotal_expense_amount(long total_expense_amount) {
		this.total_expense_amount = total_expense_amount;
	}
	public long getTotal_current_value() {
		return total_current_value;
	}
	public void setTotal_current_value(long total_current_value) {
		this.total_current_value = total_current_value;
	}
	public Integer getFinal_education_year() {
		return final_education_year;
	}
	public void setFinal_education_year(Integer final_education_year) {
		this.final_education_year = final_education_year;
	}
	public Integer getFinal_wealth_year() {
		return final_wealth_year;
	}
	public void setFinal_wealth_year(Integer final_wealth_year) {
		this.final_wealth_year = final_wealth_year;
	}
	public Integer getFinal_expense_year() {
		return final_expense_year;
	}
	public void setFinal_expense_year(Integer final_expense_year) {
		this.final_expense_year = final_expense_year;
	}
	public long getEducation_target() {
		return education_target;
	}
	public void setEducation_target(long education_target) {
		this.education_target = education_target;
	}
	public long getWealth_target() {
		return wealth_target;
	}
	public void setWealth_target(long wealth_target) {
		this.wealth_target = wealth_target;
	}
	public long getExpense_target() {
		return expense_target;
	}
	public void setExpense_target(long expense_target) {
		this.expense_target = expense_target;
	}
	public long getTotal_inflation_adjust_value() {
		return total_inflation_adjust_value;
	}
	public void setTotal_inflation_adjust_value(long total_inflation_adjust_value) {
		this.total_inflation_adjust_value = total_inflation_adjust_value;
	}
	public long getEducation_savings_amount() {
		return education_savings_amount;
	}
	public void setEducation_savings_amount(long education_savings_amount) {
		this.education_savings_amount = education_savings_amount;
	}
	public long getWealth_savings_amount() {
		return wealth_savings_amount;
	}
	public void setWealth_savings_amount(long wealth_savings_amount) {
		this.wealth_savings_amount = wealth_savings_amount;
	}
	public long getExpense_savings_amount() {
		return expense_savings_amount;
	}
	public void setExpense_savings_amount(long expense_savings_amount) {
		this.expense_savings_amount = expense_savings_amount;
	}
	public long getTotal_savings_amount() {
		return total_savings_amount;
	}
	public void setTotal_savings_amount(long total_savings_amount) {
		this.total_savings_amount = total_savings_amount;
	}
	public long getEducation_monthly_savings() {
		return education_monthly_savings;
	}
	public void setEducation_monthly_savings(long education_monthly_savings) {
		this.education_monthly_savings = education_monthly_savings;
	}
	public long getWealth_monthly_savings() {
		return wealth_monthly_savings;
	}
	public void setWealth_monthly_savings(long wealth_monthly_savings) {
		this.wealth_monthly_savings = wealth_monthly_savings;
	}
	public long getExpense_monthly_savings() {
		return expense_monthly_savings;
	}
	public void setExpense_monthly_savings(long expense_monthly_savings) {
		this.expense_monthly_savings = expense_monthly_savings;
	}
	public long getTotal_monthly_savings() {
		return total_monthly_savings;
	}
	public void setTotal_monthly_savings(long total_monthly_savings) {
		this.total_monthly_savings = total_monthly_savings;
	}
	public void setChild_education_age(Integer child_education_age) {
		this.child_education_age = child_education_age;
	}
}
