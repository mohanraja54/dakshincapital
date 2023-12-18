package com.dakshin.amfi.response;
public class RollingReturnsSummaryResponse {

	private String scheme_name;
	private Double minimum;
	private Double maximum;
	private Double average;
	private Double median;
	private Double less_than_0;
	private Double less_than_5;
	private Double less_than_10;
	private Double less_than_15;
	private Double less_than_20;
	private Double greater_than_20;
	private Integer category_flag;
	private Double std_dev;
	
	
	public String getScheme_name() {
		return scheme_name;
	}
	public void setScheme_name(String scheme_name) {
		this.scheme_name = scheme_name;
	}
	public Double getMinimum() {
		return minimum;
	}
	public void setMinimum(Double minimum) {
		this.minimum = minimum;
	}
	public Double getMaximum() {
		return maximum;
	}
	public void setMaximum(Double maximum) {
		this.maximum = maximum;
	}
	public Double getAverage() {
		return average;
	}
	public void setAverage(Double average) {
		this.average = average;
	}
	public Double getMedian() {
		return median;
	}
	public void setMedian(Double median) {
		this.median = median;
	}
	public Double getLess_than_0() {
		return less_than_0;
	}
	public void setLess_than_0(Double less_than_0) {
		this.less_than_0 = less_than_0;
	}
	public Double getLess_than_5() {
		return less_than_5;
	}
	public void setLess_than_5(Double less_than_5) {
		this.less_than_5 = less_than_5;
	}
	public Double getLess_than_10() {
		return less_than_10;
	}
	public void setLess_than_10(Double less_than_10) {
		this.less_than_10 = less_than_10;
	}
	public Double getLess_than_15() {
		return less_than_15;
	}
	public void setLess_than_15(Double less_than_15) {
		this.less_than_15 = less_than_15;
	}
	public Double getLess_than_20() {
		return less_than_20;
	}
	public void setLess_than_20(Double less_than_20) {
		this.less_than_20 = less_than_20;
	}
	public Double getGreater_than_20() {
		return greater_than_20;
	}
	public void setGreater_than_20(Double greater_than_20) {
		this.greater_than_20 = greater_than_20;
	}
	public Integer getCategory_flag() {
		return category_flag;
	}
	public void setCategory_flag(Integer category_flag) {
		this.category_flag = category_flag;
	}
	public Double getStd_dev() {
		return std_dev;
	}
	public void setStd_dev(Double std_dev) {
		this.std_dev = std_dev;
	}	
}
