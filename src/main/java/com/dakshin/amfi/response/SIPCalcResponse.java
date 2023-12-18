package com.dakshin.amfi.response;

import java.util.Date;

public class SIPCalcResponse 
{
    public Date nav_date;
    public Double nav;
    public Double units;
    public Double cumulative_units;
    public Double average_cost;
    public Double cumulative_invested_amount;
    public Double current_value;
    
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
	public Double getCumulative_invested_amount() {
		return cumulative_invested_amount;
	}
	public void setCumulative_invested_amount(Double cumulative_invested_amount) {
		this.cumulative_invested_amount = cumulative_invested_amount;
	}
	public Double getCurrent_value() {
		return current_value;
	}
	public void setCurrent_value(Double current_value) {
		this.current_value = current_value;
	}
	public Double getAverage_cost() {
		return average_cost;
	}
	public void setAverage_cost(Double average_cost) {
		this.average_cost = average_cost;
	}
}
