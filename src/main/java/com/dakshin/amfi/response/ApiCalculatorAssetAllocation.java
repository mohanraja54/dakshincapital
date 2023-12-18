package com.dakshin.amfi.response;


public class ApiCalculatorAssetAllocation {
	
	public Integer status;
	public String status_msg;
	public String msg;
    private Integer current_age;
    private Integer risk_profile;
    private Integer investment_horizon;
    private Integer do_you_know;
    private Integer debt;
    private Integer equity;
    private Integer fmp_debt_value;
    private Integer long_term_fixed_value;
    private Integer cash_liquid_value;
    private Integer mid_small_cap_value;
    private Integer large_cap_value;
    
    
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
	public Integer getRisk_profile() {
		return risk_profile;
	}
	public void setRisk_profile(Integer risk_profile) {
		this.risk_profile = risk_profile;
	}
	public Integer getInvestment_horizon() {
		return investment_horizon;
	}
	public void setInvestment_horizon(Integer investment_horizon) {
		this.investment_horizon = investment_horizon;
	}
	public Integer getDo_you_know() {
		return do_you_know;
	}
	public void setDo_you_know(Integer do_you_know) {
		this.do_you_know = do_you_know;
	}
	public Integer getDebt() {
		return debt;
	}
	public void setDebt(Integer debt) {
		this.debt = debt;
	}
	public Integer getEquity() {
		return equity;
	}
	public void setEquity(Integer equity) {
		this.equity = equity;
	}
	public Integer getFmp_debt_value() {
		return fmp_debt_value;
	}
	public void setFmp_debt_value(Integer fmp_debt_value) {
		this.fmp_debt_value = fmp_debt_value;
	}
	public Integer getLong_term_fixed_value() {
		return long_term_fixed_value;
	}
	public void setLong_term_fixed_value(Integer long_term_fixed_value) {
		this.long_term_fixed_value = long_term_fixed_value;
	}
	public Integer getCash_liquid_value() {
		return cash_liquid_value;
	}
	public void setCash_liquid_value(Integer cash_liquid_value) {
		this.cash_liquid_value = cash_liquid_value;
	}
	public Integer getMid_small_cap_value() {
		return mid_small_cap_value;
	}
	public void setMid_small_cap_value(Integer mid_small_cap_value) {
		this.mid_small_cap_value = mid_small_cap_value;
	}
	public Integer getLarge_cap_value() {
		return large_cap_value;
	}
	public void setLarge_cap_value(Integer large_cap_value) {
		this.large_cap_value = large_cap_value;
	}
}
