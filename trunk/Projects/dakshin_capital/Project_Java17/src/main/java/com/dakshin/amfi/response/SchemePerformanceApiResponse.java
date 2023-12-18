package com.dakshin.amfi.response;

import java.util.Date;

public class SchemePerformanceApiResponse {
	
	public String scheme_name;
	public Date scheme_inception_date;
	public double one_year_return;
	public double two_year_return;
	public double three_year_return;
	public double five_year_return;
	public double ten_year_return;
	public double inception_year_return;
	
	
	public String getScheme_name() {
		return scheme_name;
	}
	public void setScheme_name(String scheme_name) {
		this.scheme_name = scheme_name;
	}
	public double getOne_year_return() {
		return one_year_return;
	}
	public void setOne_year_return(double one_year_return) {
		this.one_year_return = one_year_return;
	}
	public double getThree_year_return() {
		return three_year_return;
	}
	public void setThree_year_return(double three_year_return) {
		this.three_year_return = three_year_return;
	}
	public double getFive_year_return() {
		return five_year_return;
	}
	public void setFive_year_return(double five_year_return) {
		this.five_year_return = five_year_return;
	}
	public double getTen_year_return() {
		return ten_year_return;
	}
	public void setTen_year_return(double ten_year_return) {
		this.ten_year_return = ten_year_return;
	}
	public double getInception_year_return() {
		return inception_year_return;
	}
	public void setInception_year_return(double inception_year_return) {
		this.inception_year_return = inception_year_return;
	}
	public Date getScheme_inception_date() {
		return scheme_inception_date;
	}
	public void setScheme_inception_date(Date scheme_inception_date) {
		this.scheme_inception_date = scheme_inception_date;
	}
	public double getTwo_year_return() {
		return two_year_return;
	}
	public void setTwo_year_return(double two_year_return) {
		this.two_year_return = two_year_return;
	}
}
