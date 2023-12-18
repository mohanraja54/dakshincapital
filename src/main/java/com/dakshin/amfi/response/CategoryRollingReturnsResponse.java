package com.dakshin.amfi.response;


public class CategoryRollingReturnsResponse {

	String category;
	Double max_rolling_returns;
	Double min_rolling_returns;
	Double median_rolling_returns;
	Double average_rolling_returns;
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Double getMax_rolling_returns() {
		return max_rolling_returns;
	}
	public void setMax_rolling_returns(Double max_rolling_returns) {
		this.max_rolling_returns = max_rolling_returns;
	}
	public Double getMin_rolling_returns() {
		return min_rolling_returns;
	}
	public void setMin_rolling_returns(Double min_rolling_returns) {
		this.min_rolling_returns = min_rolling_returns;
	}
	public Double getMedian_rolling_returns() {
		return median_rolling_returns;
	}
	public void setMedian_rolling_returns(Double median_rolling_returns) {
		this.median_rolling_returns = median_rolling_returns;
	}
	public Double getAverage_rolling_returns() {
		return average_rolling_returns;
	}
	public void setAverage_rolling_returns(Double average_rolling_returns) {
		this.average_rolling_returns = average_rolling_returns;
	}
}