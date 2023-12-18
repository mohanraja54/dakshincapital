package com.dakshin.amfi.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "scheme_portfolio")
public class SchemePortfolio
{
	Integer id;
	String scheme_code;
	String scheme_name;
	String scheme_amfi_common;
	Date portfolio_date;
	String instrument;
	String asset_class;
	String asset_subclass;
	String asset_type;
	String isin;
	String industry;
	String rating;
	Double quantity;
	Double value;
	Double holdings;
	String stocks;
	Date maturity_date;
	String issuer_name;

  	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public Date getPortfolio_date() {
		return portfolio_date;
	}
	public void setPortfolio_date(Date portfolio_date) {
		this.portfolio_date = portfolio_date;
	}
	public String getInstrument() {
		return instrument;
	}
	public void setInstrument(String instrument) {
		this.instrument = instrument;
	}
	public String getAsset_class() {
		return asset_class;
	}
	public void setAsset_class(String asset_class) {
		this.asset_class = asset_class;
	}
	public String getAsset_subclass() {
		return asset_subclass;
	}
	public void setAsset_subclass(String asset_subclass) {
		this.asset_subclass = asset_subclass;
	}
	public String getAsset_type() {
		return asset_type;
	}
	public void setAsset_type(String asset_type) {
		this.asset_type = asset_type;
	}
	public String getIsin() {
		return isin;
	}
	public void setIsin(String isin) {
		this.isin = isin;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	
	public Double getQuantity() {
		return quantity;
	}
	public void setQuantity(Double quantity) {
		this.quantity = quantity;
	}
	public Double getValue() {
		return value;
	}
	public void setValue(Double value) {
		this.value = value;
	}
	public Double getHoldings() {
		return holdings;
	}
	public void setHoldings(Double holdings) {
		this.holdings = holdings;
	}
	public String getScheme_amfi_common() {
		return scheme_amfi_common;
	}
	public void setScheme_amfi_common(String scheme_amfi_common) {
		this.scheme_amfi_common = scheme_amfi_common;
	}
	public String getStocks() {
		return stocks;
	}
	public void setStocks(String stocks) {
		this.stocks = stocks;
	}
	public Date getMaturity_date() {
		return maturity_date;
	}
	public void setMaturity_date(Date maturity_date) {
		this.maturity_date = maturity_date;
	}
	public String getIssuer_name() {
		return issuer_name;
	}
	public void setIssuer_name(String issuer_name) {
		this.issuer_name = issuer_name;
	}
}
