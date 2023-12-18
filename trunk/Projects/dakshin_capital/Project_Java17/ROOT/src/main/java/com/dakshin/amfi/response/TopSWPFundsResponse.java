package com.dakshin.amfi.response;

import java.util.Date;

public class TopSWPFundsResponse {

	String scheme_name;
	Date inception_date;
	Integer no_of_installments;
	Double total_withdrawal_amount;
	Double current_value;
	Double returns;
	Date start_date;
	Date end_date;
	Date investment_date;
	String url;
	String scheme_amfi_url;
	
	
	public String getScheme_name() {
		return scheme_name;
	}
	public void setScheme_name(String scheme_name) {
		this.scheme_name = scheme_name;
	}
	public Integer getNo_of_installments() {
		return no_of_installments;
	}
	public void setNo_of_installments(Integer no_of_installments) {
		this.no_of_installments = no_of_installments;
	}
	public Double getTotal_withdrawal_amount() {
		return total_withdrawal_amount;
	}
	public void setTotal_withdrawal_amount(Double total_withdrawal_amount) {
		this.total_withdrawal_amount = total_withdrawal_amount;
	}
	public Double getCurrent_value() {
		return current_value;
	}
	public void setCurrent_value(Double current_value) {
		this.current_value = current_value;
	}
	public Double getReturns() {
		return returns;
	}
	public void setReturns(Double returns) {
		this.returns = returns;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public Date getInvestment_date() {
		return investment_date;
	}
	public void setInvestment_date(Date investment_date) {
		this.investment_date = investment_date;
	}
	public Date getInception_date() {
		return inception_date;
	}
	public void setInception_date(Date inception_date) {
		this.inception_date = inception_date;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getScheme_amfi_url() {
		return scheme_amfi_url;
	}
	public void setScheme_amfi_url(String scheme_amfi_url) {
		this.scheme_amfi_url = scheme_amfi_url;
	}	
}
