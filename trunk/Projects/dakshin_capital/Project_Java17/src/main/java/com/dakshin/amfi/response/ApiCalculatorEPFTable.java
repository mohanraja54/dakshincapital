package com.dakshin.amfi.response;


public class ApiCalculatorEPFTable {
	
    private Integer age;
    private Double opening_epf_balance;
    private Double employee_contribution;
    private Double employer_contribution;
    private Double closing_epf_balance;
    private Double pension_fund_value;
    
    
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public Double getOpening_epf_balance() {
		return opening_epf_balance;
	}
	public void setOpening_epf_balance(Double opening_epf_balance) {
		this.opening_epf_balance = opening_epf_balance;
	}
	public Double getEmployee_contribution() {
		return employee_contribution;
	}
	public void setEmployee_contribution(Double employee_contribution) {
		this.employee_contribution = employee_contribution;
	}
	public Double getEmployer_contribution() {
		return employer_contribution;
	}
	public void setEmployer_contribution(Double employer_contribution) {
		this.employer_contribution = employer_contribution;
	}
	public Double getClosing_epf_balance() {
		return closing_epf_balance;
	}
	public void setClosing_epf_balance(Double closing_epf_balance) {
		this.closing_epf_balance = closing_epf_balance;
	}
	public Double getPension_fund_value() {
		return pension_fund_value;
	}
	public void setPension_fund_value(Double pension_fund_value) {
		this.pension_fund_value = pension_fund_value;
	}
}
