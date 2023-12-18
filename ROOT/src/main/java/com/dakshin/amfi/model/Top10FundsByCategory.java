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
@Table(name = "top_10_funds_by_category")
public class Top10FundsByCategory {

	Integer id;
  	String scheme_amfi;
	String scheme_amfi_code;
	String scheme_category;
	String scheme_company;
	Date inception_date;
	
	Double returns_abs_3month;
	Double returns_abs_6month;
	Double returns_abs_1year;
	Double returns_cmp_3year;
	Double returns_cmp_5year;
	Double returns_cmp_10year;
	Double returns_cmp_inception;
	Double ter;
	
	Double returnToDisplay;
	Double lumpsumToDisplay;
	Double sipToDisplay;
	
	Date ter_date;
	String scheme_asset_date;
	Double scheme_assets;
	
	Double lumpsum_3month_current_value;
	Double lumpsum_6month_current_value;
	Double lumpsum_1year_current_value;
	Double lumpsum_3year_current_value;
	Double lumpsum_5year_current_value;
	Double lumpsum_10year_current_value;
	Double lumpsum_inception_current_value;
	
	Double sip_3month_invested_value;
	Double sip_6month_invested_value;
	Double sip_1year_invested_value;
	Double sip_3year_invested_value;
	Double sip_5year_invested_value;
	Double sip_10year_invested_value;
	Double sip_inception_invested_value;
	
	Double sip_3month_current_value;
	Double sip_6month_current_value;
	Double sip_1year_current_value;
	Double sip_3year_current_value;
	Double sip_5year_current_value;
	Double sip_10year_current_value;
	Double sip_inception_current_value;
	
	Date created_date;
	private String doubled_in;
	  
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")  
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getScheme_amfi() {
		return scheme_amfi;
	}
	public void setScheme_amfi(String scheme_amfi) {
		this.scheme_amfi = scheme_amfi;
	}
	public String getScheme_amfi_code() {
		return scheme_amfi_code;
	}
	public void setScheme_amfi_code(String scheme_amfi_code) {
		this.scheme_amfi_code = scheme_amfi_code;
	}
	public String getScheme_category() {
		return scheme_category;
	}
	public void setScheme_category(String scheme_category) {
		this.scheme_category = scheme_category;
	}
	public String getScheme_company() {
		return scheme_company;
	}
	public void setScheme_company(String scheme_company) {
		this.scheme_company = scheme_company;
	}
	public Date getInception_date() {
		return inception_date;
	}
	public void setInception_date(Date inception_date) {
		this.inception_date = inception_date;
	}
	public Double getReturns_abs_3month() {
		return returns_abs_3month;
	}
	public void setReturns_abs_3month(Double returns_abs_3month) {
		this.returns_abs_3month = returns_abs_3month;
	}
	public Double getReturns_abs_6month() {
		return returns_abs_6month;
	}
	public void setReturns_abs_6month(Double returns_abs_6month) {
		this.returns_abs_6month = returns_abs_6month;
	}
	public Double getReturns_abs_1year() {
		return returns_abs_1year;
	}
	public void setReturns_abs_1year(Double returns_abs_1year) {
		this.returns_abs_1year = returns_abs_1year;
	}
	public Double getReturns_cmp_3year() {
		return returns_cmp_3year;
	}
	public void setReturns_cmp_3year(Double returns_cmp_3year) {
		this.returns_cmp_3year = returns_cmp_3year;
	}
	public Double getReturns_cmp_5year() {
		return returns_cmp_5year;
	}
	public void setReturns_cmp_5year(Double returns_cmp_5year) {
		this.returns_cmp_5year = returns_cmp_5year;
	}
	public Double getReturns_cmp_10year() {
		return returns_cmp_10year;
	}
	public void setReturns_cmp_10year(Double returns_cmp_10year) {
		this.returns_cmp_10year = returns_cmp_10year;
	}
	public Double getTer() {
		return ter;
	}
	public void setTer(Double ter) {
		this.ter = ter;
	}
	public Date getTer_date() {
		return ter_date;
	}
	public void setTer_date(Date ter_date) {
		this.ter_date = ter_date;
	}
	public String getScheme_asset_date() {
		return scheme_asset_date;
	}
	public void setScheme_asset_date(String scheme_asset_date) {
		this.scheme_asset_date = scheme_asset_date;
	}
	public Double getScheme_assets() {
		return scheme_assets;
	}
	public void setScheme_assets(Double scheme_assets) {
		this.scheme_assets = scheme_assets;
	}
	public Double getLumpsum_3month_current_value() {
		return lumpsum_3month_current_value;
	}
	public void setLumpsum_3month_current_value(Double lumpsum_3month_current_value) {
		this.lumpsum_3month_current_value = lumpsum_3month_current_value;
	}
	public Double getLumpsum_6month_current_value() {
		return lumpsum_6month_current_value;
	}
	public void setLumpsum_6month_current_value(Double lumpsum_6month_current_value) {
		this.lumpsum_6month_current_value = lumpsum_6month_current_value;
	}
	public Double getLumpsum_1year_current_value() {
		return lumpsum_1year_current_value;
	}
	public void setLumpsum_1year_current_value(Double lumpsum_1year_current_value) {
		this.lumpsum_1year_current_value = lumpsum_1year_current_value;
	}
	public Double getLumpsum_3year_current_value() {
		return lumpsum_3year_current_value;
	}
	public void setLumpsum_3year_current_value(Double lumpsum_3year_current_value) {
		this.lumpsum_3year_current_value = lumpsum_3year_current_value;
	}
	public Double getLumpsum_5year_current_value() {
		return lumpsum_5year_current_value;
	}
	public void setLumpsum_5year_current_value(Double lumpsum_5year_current_value) {
		this.lumpsum_5year_current_value = lumpsum_5year_current_value;
	}
	public Double getLumpsum_10year_current_value() {
		return lumpsum_10year_current_value;
	}
	public void setLumpsum_10year_current_value(Double lumpsum_10year_current_value) {
		this.lumpsum_10year_current_value = lumpsum_10year_current_value;
	}
	public Double getSip_3month_invested_value() {
		return sip_3month_invested_value;
	}
	public void setSip_3month_invested_value(Double sip_3month_invested_value) {
		this.sip_3month_invested_value = sip_3month_invested_value;
	}
	public Double getSip_6month_invested_value() {
		return sip_6month_invested_value;
	}
	public void setSip_6month_invested_value(Double sip_6month_invested_value) {
		this.sip_6month_invested_value = sip_6month_invested_value;
	}
	public Double getSip_1year_invested_value() {
		return sip_1year_invested_value;
	}
	public void setSip_1year_invested_value(Double sip_1year_invested_value) {
		this.sip_1year_invested_value = sip_1year_invested_value;
	}
	public Double getSip_3year_invested_value() {
		return sip_3year_invested_value;
	}
	public void setSip_3year_invested_value(Double sip_3year_invested_value) {
		this.sip_3year_invested_value = sip_3year_invested_value;
	}
	public Double getSip_5year_invested_value() {
		return sip_5year_invested_value;
	}
	public void setSip_5year_invested_value(Double sip_5year_invested_value) {
		this.sip_5year_invested_value = sip_5year_invested_value;
	}
	public Double getSip_10year_invested_value() {
		return sip_10year_invested_value;
	}
	public void setSip_10year_invested_value(Double sip_10year_invested_value) {
		this.sip_10year_invested_value = sip_10year_invested_value;
	}
	public Double getSip_3month_current_value() {
		return sip_3month_current_value;
	}
	public void setSip_3month_current_value(Double sip_3month_current_value) {
		this.sip_3month_current_value = sip_3month_current_value;
	}
	public Double getSip_6month_current_value() {
		return sip_6month_current_value;
	}
	public void setSip_6month_current_value(Double sip_6month_current_value) {
		this.sip_6month_current_value = sip_6month_current_value;
	}
	public Double getSip_1year_current_value() {
		return sip_1year_current_value;
	}
	public void setSip_1year_current_value(Double sip_1year_current_value) {
		this.sip_1year_current_value = sip_1year_current_value;
	}
	public Double getSip_3year_current_value() {
		return sip_3year_current_value;
	}
	public void setSip_3year_current_value(Double sip_3year_current_value) {
		this.sip_3year_current_value = sip_3year_current_value;
	}
	public Double getSip_5year_current_value() {
		return sip_5year_current_value;
	}
	public void setSip_5year_current_value(Double sip_5year_current_value) {
		this.sip_5year_current_value = sip_5year_current_value;
	}
	public Double getSip_10year_current_value() {
		return sip_10year_current_value;
	}
	public void setSip_10year_current_value(Double sip_10year_current_value) {
		this.sip_10year_current_value = sip_10year_current_value;
	}
	public Date getCreated_date() {
		return created_date;
	}
	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}
	public Double getLumpsum_inception_current_value() {
		return lumpsum_inception_current_value;
	}
	public void setLumpsum_inception_current_value(Double lumpsum_inception_current_value) {
		this.lumpsum_inception_current_value = lumpsum_inception_current_value;
	}
	public Double getSip_inception_invested_value() {
		return sip_inception_invested_value;
	}
	public void setSip_inception_invested_value(Double sip_inception_invested_value) {
		this.sip_inception_invested_value = sip_inception_invested_value;
	}
	public Double getSip_inception_current_value() {
		return sip_inception_current_value;
	}
	public void setSip_inception_current_value(Double sip_inception_current_value) {
		this.sip_inception_current_value = sip_inception_current_value;
	}
	public Double getReturns_cmp_inception() {
		return returns_cmp_inception;
	}
	public void setReturns_cmp_inception(Double returns_cmp_inception) {
		this.returns_cmp_inception = returns_cmp_inception;
	}
	
	@Transient
	public Double getReturnToDisplay() {
		return returnToDisplay;
	}
	
	@Transient
	public void setReturnToDisplay(Double returnToDisplay) {
		this.returnToDisplay = returnToDisplay;
	}
	
	@Transient
	public Double getLumpsumToDisplay() {
		return lumpsumToDisplay;
	}
	
	@Transient
	public void setLumpsumToDisplay(Double lumpsumToDisplay) {
		this.lumpsumToDisplay = lumpsumToDisplay;
	}
	
	@Transient
	public Double getSipToDisplay() {
		return sipToDisplay;
	}
	
	@Transient
	public void setSipToDisplay(Double sipToDisplay) {
		this.sipToDisplay = sipToDisplay;
	}
	
	public String getDoubled_in() {
		return doubled_in;
	}
	public void setDoubled_in(String doubled_in) {
		this.doubled_in = doubled_in;
	}
}
