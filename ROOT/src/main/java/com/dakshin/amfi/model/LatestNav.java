package com.dakshin.amfi.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "latest_nav")
public class LatestNav {

	Integer id;
	String mf_company;
	String scheme_nature;
	String scheme_code;
	String scheme_name;
	String isin_div_payout_growth_no;
	String isin_div_reinvestment_no;
	Double net_asset_value;
	Date nav_date;
	String category;
	Date create_date;
	Double prev_net_asset_value;
	Date prev_nav_date;
	Double change_percent;
	
  
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getScheme_name() {
		return scheme_name;
	}
	public void setScheme_name(String scheme_name) {
		this.scheme_name = scheme_name;
	}
	public double getNet_asset_value() {
		return net_asset_value;
	}
	public void setNet_asset_value(double net_asset_value) {
		this.net_asset_value = net_asset_value;
	}
	public Date getNav_date() {
		return nav_date;
	}
	public void setNav_date(Date nav_date) {
		this.nav_date = nav_date;
	}
	public String getMf_company() {
		return mf_company;
	}
	public void setMf_company(String mf_company) {
		this.mf_company = mf_company;
	}
	public String getScheme_nature() {
		return scheme_nature;
	}
	public void setScheme_nature(String scheme_nature) {
		this.scheme_nature = scheme_nature;
	}
	public String getIsin_div_payout_growth_no() {
		return isin_div_payout_growth_no;
	}
	public void setIsin_div_payout_growth_no(String isin_div_payout_growth_no) {
		this.isin_div_payout_growth_no = isin_div_payout_growth_no;
	}
	public String getIsin_div_reinvestment_no() {
		return isin_div_reinvestment_no;
	}
	public void setIsin_div_reinvestment_no(String isin_div_reinvestment_no) {
		this.isin_div_reinvestment_no = isin_div_reinvestment_no;
	}
	public String getScheme_code() {
		return scheme_code;
	}
	public void setScheme_code(String scheme_code) {
		this.scheme_code = scheme_code;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Double getPrev_net_asset_value() {
		return prev_net_asset_value;
	}
	public void setPrev_net_asset_value(Double prev_net_asset_value) {
		this.prev_net_asset_value = prev_net_asset_value;
	}
	public Date getPrev_nav_date() {
		return prev_nav_date;
	}
	public void setPrev_nav_date(Date prev_nav_date) {
		this.prev_nav_date = prev_nav_date;
	}
	public Double getChange_percent() {
		return change_percent;
	}
	public void setChange_percent(Double change_percent) {
		this.change_percent = change_percent;
	}
	public void setNet_asset_value(Double net_asset_value) {
		this.net_asset_value = net_asset_value;
	}
}
