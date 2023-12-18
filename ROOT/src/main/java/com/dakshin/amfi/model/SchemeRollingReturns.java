package com.dakshin.amfi.model;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "scheme_rolling_returns")
public class SchemeRollingReturns {


	private int id;
    private String scheme_company;
    private String scheme_category;
    private String scheme_amfi_code;
    private String scheme_name;
    private String period;
    private Date nav_date;
    private Double scheme_nav;
    private Date scheme_forward_date;
    private Double scheme_forward_nav;
    private Double scheme_rolling_returns;
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getScheme_company() {
		return scheme_company;
	}
	public void setScheme_company(String scheme_company) {
		this.scheme_company = scheme_company;
	}
	public String getScheme_category() {
		return scheme_category;
	}
	public void setScheme_category(String scheme_category) {
		this.scheme_category = scheme_category;
	}
	public String getScheme_name() {
		return scheme_name;
	}
	public void setScheme_name(String scheme_name) {
		this.scheme_name = scheme_name;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public Date getNav_date() {
		return nav_date;
	}
	public void setNav_date(Date nav_date) {
		this.nav_date = nav_date;
	}
	public Double getScheme_nav() {
		return scheme_nav;
	}
	public void setScheme_nav(Double scheme_nav) {
		this.scheme_nav = scheme_nav;
	}
	public Date getScheme_forward_date() {
		return scheme_forward_date;
	}
	public void setScheme_forward_date(Date scheme_forward_date) {
		this.scheme_forward_date = scheme_forward_date;
	}
	public Double getScheme_forward_nav() {
		return scheme_forward_nav;
	}
	public void setScheme_forward_nav(Double scheme_forward_nav) {
		this.scheme_forward_nav = scheme_forward_nav;
	}
	public Double getScheme_rolling_returns() {
		return scheme_rolling_returns;
	}
	public void setScheme_rolling_returns(Double scheme_rolling_returns) {
		this.scheme_rolling_returns = scheme_rolling_returns;
	}
	public String getScheme_amfi_code() {
		return scheme_amfi_code;
	}
	public void setScheme_amfi_code(String scheme_amfi_code) {
		this.scheme_amfi_code = scheme_amfi_code;
	}
}
