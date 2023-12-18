package com.dakshin.amfi.response;

import java.util.Date;

public class STPCalcResponse 
{
	public String scheme;
    public Date nav_date;
    public Double nav;
    public Double units;
    public Double cumulative_units;
    public Double cash_flow;
    public Double amount;
    public Double capital_gain;
    public Integer no_of_days;
    public Double current_value;
    
	public String getScheme() {
		return scheme;
	}
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	public Date getNav_date() {
		return nav_date;
	}
	public void setNav_date(Date nav_date) {
		this.nav_date = nav_date;
	}
	public Double getNav() {
		return nav;
	}
	public void setNav(Double nav) {
		this.nav = nav;
	}
	public Double getUnits() {
		return units;
	}
	public void setUnits(Double units) {
		this.units = units;
	}
	public Double getCumulative_units() {
		return cumulative_units;
	}
	public void setCumulative_units(Double cumulative_units) {
		this.cumulative_units = cumulative_units;
	}
	public Double getCash_flow() {
		return cash_flow;
	}
	public void setCash_flow(Double cash_flow) {
		this.cash_flow = cash_flow;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public Double getCurrent_value() {
		return current_value;
	}
	public void setCurrent_value(Double current_value) {
		this.current_value = current_value;
	}
	public Double getCapital_gain() {
		return capital_gain;
	}
	public void setCapital_gain(Double capital_gain) {
		this.capital_gain = capital_gain;
	}
	public Integer getNo_of_days() {
		return no_of_days;
	}
	public void setNo_of_days(Integer no_of_days) {
		this.no_of_days = no_of_days;
	}
}
