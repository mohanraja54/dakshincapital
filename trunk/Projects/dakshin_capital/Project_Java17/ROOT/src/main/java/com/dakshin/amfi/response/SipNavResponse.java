package com.dakshin.amfi.response;

import java.util.Date;

public class SipNavResponse {

	Date nav_date;
	Double net_asset_value;
	Double units;
	Double cumulative_units;
	Double amount;
	Double current_value;
	String trxn_type;
	String trxn_suffi;
	
	public Date getNav_date() {
		return nav_date;
	}
	public void setNav_date(Date nav_date) {
		this.nav_date = nav_date;
	}
	public Double getNet_asset_value() {
		return net_asset_value;
	}
	public void setNet_asset_value(Double net_asset_value) {
		this.net_asset_value = net_asset_value;
	}
	public Double getUnits() {
		return units;
	}
	public void setUnits(Double units) {
		this.units = units;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public String getTrxn_type() {
		return trxn_type;
	}
	public void setTrxn_type(String trxn_type) {
		this.trxn_type = trxn_type;
	}
	public Double getCumulative_units() {
		return cumulative_units;
	}
	public void setCumulative_units(Double cumulative_units) {
		this.cumulative_units = cumulative_units;
	}
	public Double getCurrent_value() {
		return current_value;
	}
	public void setCurrent_value(Double current_value) {
		this.current_value = current_value;
	}
	public String getTrxn_suffi() {
		return trxn_suffi;
	}
	public void setTrxn_suffi(String trxn_suffi) {
		this.trxn_suffi = trxn_suffi;
	}
}
