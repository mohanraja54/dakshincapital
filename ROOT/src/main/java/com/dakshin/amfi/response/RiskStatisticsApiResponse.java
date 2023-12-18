package com.dakshin.amfi.response;

public class RiskStatisticsApiResponse {
	
	public String scheme_category;
	public Double volatility_cm_3year;
	public Double sharpratio_cm_3year;
	public Double alpha_cm_1year;
	public Double beta_cm_1year;
	public Double yield_to_maturity;
	public Double average_maturity;
	
	
	public String getScheme_category() {
		return scheme_category;
	}
	public void setScheme_category(String scheme_category) {
		this.scheme_category = scheme_category;
	}
	public Double getVolatility_cm_3year() {
		return volatility_cm_3year;
	}
	public void setVolatility_cm_3year(Double volatility_cm_3year) {
		this.volatility_cm_3year = volatility_cm_3year;
	}
	public Double getSharpratio_cm_3year() {
		return sharpratio_cm_3year;
	}
	public void setSharpratio_cm_3year(Double sharpratio_cm_3year) {
		this.sharpratio_cm_3year = sharpratio_cm_3year;
	}
	public Double getAlpha_cm_1year() {
		return alpha_cm_1year;
	}
	public void setAlpha_cm_1year(Double alpha_cm_1year) {
		this.alpha_cm_1year = alpha_cm_1year;
	}
	public Double getBeta_cm_1year() {
		return beta_cm_1year;
	}
	public void setBeta_cm_1year(Double beta_cm_1year) {
		this.beta_cm_1year = beta_cm_1year;
	}
	public Double getYield_to_maturity() {
		return yield_to_maturity;
	}
	public void setYield_to_maturity(Double yield_to_maturity) {
		this.yield_to_maturity = yield_to_maturity;
	}
	public Double getAverage_maturity() {
		return average_maturity;
	}
	public void setAverage_maturity(Double average_maturity) {
		this.average_maturity = average_maturity;
	}
}
