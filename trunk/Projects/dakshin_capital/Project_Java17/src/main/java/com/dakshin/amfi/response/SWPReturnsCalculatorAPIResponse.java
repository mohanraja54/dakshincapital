package com.dakshin.amfi.response;

import java.util.List;

import com.dakshin.amfi.model.SchemeMapping;


public class SWPReturnsCalculatorAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	
	public String scheme_name;
	public String scheme_withdrawal_period;
	public Integer scheme_installment;
	public Double scheme_total_withdrawal_amount;
	public Double scheme_current_value;
	public String scheme_current_value_date;
	public Double scheme_returns;
	
	public Double scheme_investment_amount;
	public Double scheme_remaining_units;
	public Double scheme_profit;
	
	public List<STPCalcResponse> scheme_list;
	
	public String init_start_date;
	public String from_date;
	public String to_date;
	
	public SchemeMapping scheme_mapping; 
	
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
	public String getScheme_name() {
		return scheme_name;
	}
	public void setScheme_name(String scheme_name) {
		this.scheme_name = scheme_name;
	}
	public String getScheme_withdrawal_period() {
		return scheme_withdrawal_period;
	}
	public void setScheme_withdrawal_period(String scheme_withdrawal_period) {
		this.scheme_withdrawal_period = scheme_withdrawal_period;
	}
	public Integer getScheme_installment() {
		return scheme_installment;
	}
	public void setScheme_installment(Integer scheme_installment) {
		this.scheme_installment = scheme_installment;
	}
	public Double getScheme_total_withdrawal_amount() {
		return scheme_total_withdrawal_amount;
	}
	public void setScheme_total_withdrawal_amount(
			Double scheme_total_withdrawal_amount) {
		this.scheme_total_withdrawal_amount = scheme_total_withdrawal_amount;
	}
	public Double getScheme_current_value() {
		return scheme_current_value;
	}
	public void setScheme_current_value(Double scheme_current_value) {
		this.scheme_current_value = scheme_current_value;
	}
	public String getScheme_current_value_date() {
		return scheme_current_value_date;
	}
	public void setScheme_current_value_date(String scheme_current_value_date) {
		this.scheme_current_value_date = scheme_current_value_date;
	}
	public Double getScheme_returns() {
		return scheme_returns;
	}
	public void setScheme_returns(Double scheme_returns) {
		this.scheme_returns = scheme_returns;
	}
	public List<STPCalcResponse> getScheme_list() {
		return scheme_list;
	}
	public void setScheme_list(List<STPCalcResponse> scheme_list) {
		this.scheme_list = scheme_list;
	}
	public String getInit_start_date() {
		return init_start_date;
	}
	public void setInit_start_date(String init_start_date) {
		this.init_start_date = init_start_date;
	}
	public String getFrom_date() {
		return from_date;
	}
	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}
	public String getTo_date() {
		return to_date;
	}
	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}
	public SchemeMapping getScheme_mapping() {
		return scheme_mapping;
	}
	public void setScheme_mapping(SchemeMapping scheme_mapping) {
		this.scheme_mapping = scheme_mapping;
	}
	public Double getScheme_investment_amount() {
		return scheme_investment_amount;
	}
	public void setScheme_investment_amount(Double scheme_investment_amount) {
		this.scheme_investment_amount = scheme_investment_amount;
	}
	public Double getScheme_remaining_units() {
		return scheme_remaining_units;
	}
	public void setScheme_remaining_units(Double scheme_remaining_units) {
		this.scheme_remaining_units = scheme_remaining_units;
	}
	public Double getScheme_profit() {
		return scheme_profit;
	}
	public void setScheme_profit(Double scheme_profit) {
		this.scheme_profit = scheme_profit;
	}
}
