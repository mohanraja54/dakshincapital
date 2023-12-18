package com.dakshin.response;

import java.util.Date;

public class ModelPortfolioResponse 
{
	Integer id;
  	String scheme_amfi;
	String scheme_amfi_code;
	String scheme_category;
	String scheme_company;
	Date inception_date;
	
	Double returns_abs_1year;
	Double returns_cmp_3year;
	Double returns_cmp_5year;
	Double returns_cmp_10year;
	Double ter;
	Date ter_date;
	String scheme_asset_date;
	Double scheme_assets;
	
	Double lumpsum_1year_current_value;
	Double lumpsum_3year_current_value;
	Double lumpsum_5year_current_value;
	Double lumpsum_10year_current_value;
	
	Date created_date;
	String client_name;
	
	String benchmark_name;
	Double benchmark_returns_abs_1year;
	Double benchmark_returns_cmp_3year;
	Double benchmark_returns_cmp_5year;
	Double benchmark_returns_cmp_10year;
	
	String category_name;
	Double category_returns_abs_1year;
	Double category_returns_cmp_3year;
	Double category_returns_cmp_5year;
	Double category_returns_cmp_10year;
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
	public Date getCreated_date() {
		return created_date;
	}
	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}
	public String getClient_name() {
		return client_name;
	}
	public void setClient_name(String client_name) {
		this.client_name = client_name;
	}
	public String getBenchmark_name() {
		return benchmark_name;
	}
	public void setBenchmark_name(String benchmark_name) {
		this.benchmark_name = benchmark_name;
	}
	public Double getBenchmark_returns_abs_1year() {
		return benchmark_returns_abs_1year;
	}
	public void setBenchmark_returns_abs_1year(Double benchmark_returns_abs_1year) {
		this.benchmark_returns_abs_1year = benchmark_returns_abs_1year;
	}
	public Double getBenchmark_returns_cmp_3year() {
		return benchmark_returns_cmp_3year;
	}
	public void setBenchmark_returns_cmp_3year(Double benchmark_returns_cmp_3year) {
		this.benchmark_returns_cmp_3year = benchmark_returns_cmp_3year;
	}
	public Double getBenchmark_returns_cmp_5year() {
		return benchmark_returns_cmp_5year;
	}
	public void setBenchmark_returns_cmp_5year(Double benchmark_returns_cmp_5year) {
		this.benchmark_returns_cmp_5year = benchmark_returns_cmp_5year;
	}
	public Double getBenchmark_returns_cmp_10year() {
		return benchmark_returns_cmp_10year;
	}
	public void setBenchmark_returns_cmp_10year(Double benchmark_returns_cmp_10year) {
		this.benchmark_returns_cmp_10year = benchmark_returns_cmp_10year;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public Double getCategory_returns_abs_1year() {
		return category_returns_abs_1year;
	}
	public void setCategory_returns_abs_1year(Double category_returns_abs_1year) {
		this.category_returns_abs_1year = category_returns_abs_1year;
	}
	public Double getCategory_returns_cmp_3year() {
		return category_returns_cmp_3year;
	}
	public void setCategory_returns_cmp_3year(Double category_returns_cmp_3year) {
		this.category_returns_cmp_3year = category_returns_cmp_3year;
	}
	public Double getCategory_returns_cmp_5year() {
		return category_returns_cmp_5year;
	}
	public void setCategory_returns_cmp_5year(Double category_returns_cmp_5year) {
		this.category_returns_cmp_5year = category_returns_cmp_5year;
	}
	public Double getCategory_returns_cmp_10year() {
		return category_returns_cmp_10year;
	}
	public void setCategory_returns_cmp_10year(Double category_returns_cmp_10year) {
		this.category_returns_cmp_10year = category_returns_cmp_10year;
	}
}
