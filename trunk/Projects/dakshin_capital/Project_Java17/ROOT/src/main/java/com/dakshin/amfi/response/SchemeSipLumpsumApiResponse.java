package com.dakshin.amfi.response;

public class SchemeSipLumpsumApiResponse {
	
	public String scheme_benchmark_name;
	public double amount_invested;
	public double fund_value;
	public double profit;
	public double returns;
	
	
	public String getScheme_benchmark_name() {
		return scheme_benchmark_name;
	}
	public void setScheme_benchmark_name(String scheme_benchmark_name) {
		this.scheme_benchmark_name = scheme_benchmark_name;
	}
	public double getAmount_invested() {
		return amount_invested;
	}
	public void setAmount_invested(double amount_invested) {
		this.amount_invested = amount_invested;
	}
	public double getFund_value() {
		return fund_value;
	}
	public void setFund_value(double fund_value) {
		this.fund_value = fund_value;
	}
	public double getProfit() {
		return profit;
	}
	public void setProfit(double profit) {
		this.profit = profit;
	}
	public double getReturns() {
		return returns;
	}
	public void setReturns(double returns) {
		this.returns = returns;
	}
}
