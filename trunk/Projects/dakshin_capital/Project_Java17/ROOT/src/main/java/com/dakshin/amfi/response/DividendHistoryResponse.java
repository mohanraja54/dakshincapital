package com.dakshin.amfi.response;

import java.util.Date;

public class DividendHistoryResponse 
{
	public Date dividend_date;
	public Double net_asset_value;
	public Double dividend_value;
	public Double dividend_yield;
	
	public Date getDividend_date() {
		return dividend_date;
	}
	public void setDividend_date(Date dividend_date) {
		this.dividend_date = dividend_date;
	}
	public Double getNet_asset_value() {
		return net_asset_value;
	}
	public void setNet_asset_value(Double net_asset_value) {
		this.net_asset_value = net_asset_value;
	}
	public Double getDividend_value() {
		return dividend_value;
	}
	public void setDividend_value(Double dividend_value) {
		this.dividend_value = dividend_value;
	}
	public Double getDividend_yield() {
		return dividend_yield;
	}
	public void setDividend_yield(Double dividend_yield) {
		this.dividend_yield = dividend_yield;
	}
}
