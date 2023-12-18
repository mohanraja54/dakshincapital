package com.dakshin.amfi.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "scheme_performances_sip")
public class SchemePerformancesSip {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
    private String scheme_name;
	private String scheme_category;
	private Boolean dividend_scheme;
	private Date inception_date;
	private Date start_date;
	private Date end_date;
	private Integer period;
	private Double amount;
	private Double current_cost;
	private Double current_value;
	private Double returns;
	private Double ter;
	private String ter_date;
	private Double scheme_assets;
	private String scheme_asset_date;
	private String url;
	@Transient
	private String scheme_amfi_url;
	
	
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
	public String getScheme_category() {
		return scheme_category;
	}
	public void setScheme_category(String scheme_category) {
		this.scheme_category = scheme_category;
	}
	public Boolean getDividend_scheme() {
		return dividend_scheme;
	}
	public void setDividend_scheme(Boolean dividend_scheme) {
		this.dividend_scheme = dividend_scheme;
	}
	public Date getInception_date() {
		return inception_date;
	}
	public void setInception_date(Date inception_date) {
		this.inception_date = inception_date;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public Integer getPeriod() {
		return period;
	}
	public void setPeriod(Integer period) {
		this.period = period;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public Double getCurrent_cost() {
		return current_cost;
	}
	public void setCurrent_cost(Double current_cost) {
		this.current_cost = current_cost;
	}
	public Double getCurrent_value() {
		return current_value;
	}
	public void setCurrent_value(Double current_value) {
		this.current_value = current_value;
	}
	public Double getReturns() {
		return returns;
	}
	public void setReturns(Double returns) {
		this.returns = returns;
	}
	public Double getTer() {
		return ter;
	}
	public void setTer(Double ter) {
		this.ter = ter;
	}
	public String getTer_date() {
		return ter_date;
	}
	public void setTer_date(String ter_date) {
		this.ter_date = ter_date;
	}
	public Double getScheme_assets() {
		return scheme_assets;
	}
	public void setScheme_assets(Double scheme_assets) {
		this.scheme_assets = scheme_assets;
	}
	public String getScheme_asset_date() {
		return scheme_asset_date;
	}
	public void setScheme_asset_date(String scheme_asset_date) {
		this.scheme_asset_date = scheme_asset_date;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getScheme_amfi_url() {
		return scheme_amfi_url;
	}
	public void setScheme_amfi_url(String scheme_amfi_url) {
		this.scheme_amfi_url = scheme_amfi_url;
	}	
}
