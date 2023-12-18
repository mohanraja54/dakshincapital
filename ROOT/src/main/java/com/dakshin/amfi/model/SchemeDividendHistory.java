package com.dakshin.amfi.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "scheme_dividend_history")
public class SchemeDividendHistory
{
	Integer id;
	String mf_company;
	String category;
    String scheme_code;
    String scheme_name;
    String scheme_amfi_url;
    Double dividend_value;
    Date dividend_date;

  	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMf_company() {
		return mf_company;
	}
	public void setMf_company(String mf_company) {
		this.mf_company = mf_company;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getScheme_code() {
		return scheme_code;
	}
	public void setScheme_code(String scheme_code) {
		this.scheme_code = scheme_code;
	}
	public String getScheme_name() {
		return scheme_name;
	}
	public void setScheme_name(String scheme_name) {
		this.scheme_name = scheme_name;
	}
	public Double getDividend_value() {
		return dividend_value;
	}
	public void setDividend_value(Double dividend_value) {
		this.dividend_value = dividend_value;
	}
	public Date getDividend_date() {
		return dividend_date;
	}
	public void setDividend_date(Date dividend_date) {
		this.dividend_date = dividend_date;
	}
	public String getScheme_amfi_url() {
		return scheme_amfi_url;
	}
	public void setScheme_amfi_url(String scheme_amfi_url) {
		this.scheme_amfi_url = scheme_amfi_url;
	}
	
}
