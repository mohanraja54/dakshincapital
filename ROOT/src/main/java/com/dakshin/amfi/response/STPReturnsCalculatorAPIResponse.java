package com.dakshin.amfi.response;

import java.util.List;

import com.dakshin.amfi.model.SchemeMapping;

public class STPReturnsCalculatorAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	
	public String from_scheme_name;
	public Double from_scheme_initial_amount;
	public Double from_scheme_transfer_amount;
	public String from_scheme_period;
	public Integer from_scheme_installment;
	public Double from_scheme_total_amount_transferred;
	public Double from_scheme_remaining_units;
	public Double from_scheme_current_value;
	public String from_scheme_current_value_date;
	public Double from_scheme_end_value;
	public String from_scheme_end_value_date;
	public Double from_scheme_profit;
	public Double from_scheme_returns;
	
	public String to_scheme_name;
	public Double to_scheme_invested_amount;
	public String to_scheme_period;
	public Integer to_scheme_installment;
	public Double to_scheme_total_amount_invested;
	public Double to_scheme_accumulated_units;
	public Double to_scheme_current_value;
	public String to_scheme_current_value_date;
	public Double to_scheme_end_value;
	public String to_scheme_end_value_date;
	public Double to_scheme_profit;
	public Double to_scheme_returns;
	
	public Double total_invested_amount;
	public Double total_current_value;
	public Double total_profit;
	public Double total_returns;
	
	public SchemeMapping from_scheme_schemeMapping;
	public SchemeMapping to_scheme_schemeMapping;
	
	public List<STPCalcResponse> from_scheme_list;
	public List<STPCalcResponse> to_scheme_list;
	
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
	public Double getFrom_scheme_initial_amount() {
		return from_scheme_initial_amount;
	}
	public void setFrom_scheme_initial_amount(Double from_scheme_initial_amount) {
		this.from_scheme_initial_amount = from_scheme_initial_amount;
	}
	public Double getFrom_scheme_transfer_amount() {
		return from_scheme_transfer_amount;
	}
	public void setFrom_scheme_transfer_amount(Double from_scheme_transfer_amount) {
		this.from_scheme_transfer_amount = from_scheme_transfer_amount;
	}
	public String getFrom_scheme_period() {
		return from_scheme_period;
	}
	public void setFrom_scheme_period(String from_scheme_period) {
		this.from_scheme_period = from_scheme_period;
	}
	public Integer getFrom_scheme_installment() {
		return from_scheme_installment;
	}
	public void setFrom_scheme_installment(Integer from_scheme_installment) {
		this.from_scheme_installment = from_scheme_installment;
	}
	public Double getFrom_scheme_total_amount_transferred() {
		return from_scheme_total_amount_transferred;
	}
	public void setFrom_scheme_total_amount_transferred(
			Double from_scheme_total_amount_transferred) {
		this.from_scheme_total_amount_transferred = from_scheme_total_amount_transferred;
	}
	public Double getFrom_scheme_remaining_units() {
		return from_scheme_remaining_units;
	}
	public void setFrom_scheme_remaining_units(Double from_scheme_remaining_units) {
		this.from_scheme_remaining_units = from_scheme_remaining_units;
	}
	public Double getFrom_scheme_current_value() {
		return from_scheme_current_value;
	}
	public void setFrom_scheme_current_value(Double from_scheme_current_value) {
		this.from_scheme_current_value = from_scheme_current_value;
	}
	public Double getFrom_scheme_end_value() {
		return from_scheme_end_value;
	}
	public void setFrom_scheme_end_value(Double from_scheme_end_value) {
		this.from_scheme_end_value = from_scheme_end_value;
	}
	public Double getFrom_scheme_profit() {
		return from_scheme_profit;
	}
	public void setFrom_scheme_profit(Double from_scheme_profit) {
		this.from_scheme_profit = from_scheme_profit;
	}
	public Double getFrom_scheme_returns() {
		return from_scheme_returns;
	}
	public void setFrom_scheme_returns(Double from_scheme_returns) {
		this.from_scheme_returns = from_scheme_returns;
	}
	public Double getTo_scheme_invested_amount() {
		return to_scheme_invested_amount;
	}
	public void setTo_scheme_invested_amount(Double to_scheme_invested_amount) {
		this.to_scheme_invested_amount = to_scheme_invested_amount;
	}
	public String getTo_scheme_period() {
		return to_scheme_period;
	}
	public void setTo_scheme_period(String to_scheme_period) {
		this.to_scheme_period = to_scheme_period;
	}
	public Integer getTo_scheme_installment() {
		return to_scheme_installment;
	}
	public void setTo_scheme_installment(Integer to_scheme_installment) {
		this.to_scheme_installment = to_scheme_installment;
	}
	public Double getTo_scheme_total_amount_invested() {
		return to_scheme_total_amount_invested;
	}
	public void setTo_scheme_total_amount_invested(
			Double to_scheme_total_amount_invested) {
		this.to_scheme_total_amount_invested = to_scheme_total_amount_invested;
	}
	public Double getTo_scheme_accumulated_units() {
		return to_scheme_accumulated_units;
	}
	public void setTo_scheme_accumulated_units(Double to_scheme_accumulated_units) {
		this.to_scheme_accumulated_units = to_scheme_accumulated_units;
	}
	public Double getTo_scheme_current_value() {
		return to_scheme_current_value;
	}
	public void setTo_scheme_current_value(Double to_scheme_current_value) {
		this.to_scheme_current_value = to_scheme_current_value;
	}
	public Double getTo_scheme_end_value() {
		return to_scheme_end_value;
	}
	public void setTo_scheme_end_value(Double to_scheme_end_value) {
		this.to_scheme_end_value = to_scheme_end_value;
	}
	public Double getTo_scheme_profit() {
		return to_scheme_profit;
	}
	public void setTo_scheme_profit(Double to_scheme_profit) {
		this.to_scheme_profit = to_scheme_profit;
	}
	public Double getTo_scheme_returns() {
		return to_scheme_returns;
	}
	public void setTo_scheme_returns(Double to_scheme_returns) {
		this.to_scheme_returns = to_scheme_returns;
	}
	public Double getTotal_invested_amount() {
		return total_invested_amount;
	}
	public void setTotal_invested_amount(Double total_invested_amount) {
		this.total_invested_amount = total_invested_amount;
	}
	public Double getTotal_current_value() {
		return total_current_value;
	}
	public void setTotal_current_value(Double total_current_value) {
		this.total_current_value = total_current_value;
	}
	public Double getTotal_profit() {
		return total_profit;
	}
	public void setTotal_profit(Double total_profit) {
		this.total_profit = total_profit;
	}
	public Double getTotal_returns() {
		return total_returns;
	}
	public void setTotal_returns(Double total_returns) {
		this.total_returns = total_returns;
	}
	public List<STPCalcResponse> getFrom_scheme_list() {
		return from_scheme_list;
	}
	public void setFrom_scheme_list(List<STPCalcResponse> from_scheme_list) {
		this.from_scheme_list = from_scheme_list;
	}
	public List<STPCalcResponse> getTo_scheme_list() {
		return to_scheme_list;
	}
	public void setTo_scheme_list(List<STPCalcResponse> to_scheme_list) {
		this.to_scheme_list = to_scheme_list;
	}
	public String getFrom_scheme_current_value_date() {
		return from_scheme_current_value_date;
	}
	public void setFrom_scheme_current_value_date(
			String from_scheme_current_value_date) {
		this.from_scheme_current_value_date = from_scheme_current_value_date;
	}
	public String getFrom_scheme_end_value_date() {
		return from_scheme_end_value_date;
	}
	public void setFrom_scheme_end_value_date(String from_scheme_end_value_date) {
		this.from_scheme_end_value_date = from_scheme_end_value_date;
	}
	public String getTo_scheme_current_value_date() {
		return to_scheme_current_value_date;
	}
	public void setTo_scheme_current_value_date(String to_scheme_current_value_date) {
		this.to_scheme_current_value_date = to_scheme_current_value_date;
	}
	public String getTo_scheme_end_value_date() {
		return to_scheme_end_value_date;
	}
	public void setTo_scheme_end_value_date(String to_scheme_end_value_date) {
		this.to_scheme_end_value_date = to_scheme_end_value_date;
	}
	public String getFrom_scheme_name() {
		return from_scheme_name;
	}
	public void setFrom_scheme_name(String from_scheme_name) {
		this.from_scheme_name = from_scheme_name;
	}
	public String getTo_scheme_name() {
		return to_scheme_name;
	}
	public void setTo_scheme_name(String to_scheme_name) {
		this.to_scheme_name = to_scheme_name;
	}
	public SchemeMapping getFrom_scheme_schemeMapping() {
		return from_scheme_schemeMapping;
	}
	public void setFrom_scheme_schemeMapping(SchemeMapping from_scheme_schemeMapping) {
		this.from_scheme_schemeMapping = from_scheme_schemeMapping;
	}
	public SchemeMapping getTo_scheme_schemeMapping() {
		return to_scheme_schemeMapping;
	}
	public void setTo_scheme_schemeMapping(SchemeMapping to_scheme_schemeMapping) {
		this.to_scheme_schemeMapping = to_scheme_schemeMapping;
	}
}
