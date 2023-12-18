package com.dakshin.amfi.model;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "scheme_performances_category")
public class SchemePerformancesCategory {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Integer id;
	private String sector;
	private Double returns_abs_7days;
	private Double returns_abs_1month;
	private Double returns_abs_3month;
	private Double returns_abs_6month;
	private Double returns_abs_ytd;
	private Double returns_abs_1year;
	private Double returns_cmp_2year;
	private Double returns_cmp_3year;
	private Double returns_cmp_4year;
	private Double returns_cmp_5year;
	private Double returns_cmp_10year;
	private Double returns_cmp_inception;
	private Double returns_abs_2012;
	private Double returns_abs_2013;
	private Double returns_abs_2014;
	private Double returns_abs_2015;
	private Double returns_abs_2016;
	private Double volatility_cm_3year;
	private Double sharpratio_cm_3year;
	private Double alpha_cm_1year;
	private Double beta_cm_1year;
	private Double yield_to_maturity;
	private Double average_maturity;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getSector() {
		return sector;
	}
	public void setSector(String sector) {
		this.sector = sector;
	}
	public Double getReturns_abs_7days() {
		return returns_abs_7days;
	}
	public void setReturns_abs_7days(Double returns_abs_7days) {
		this.returns_abs_7days = returns_abs_7days;
	}
	public Double getReturns_abs_1month() {
		return returns_abs_1month;
	}
	public void setReturns_abs_1month(Double returns_abs_1month) {
		this.returns_abs_1month = returns_abs_1month;
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
	public Double getReturns_abs_ytd() {
		return returns_abs_ytd;
	}
	public void setReturns_abs_ytd(Double returns_abs_ytd) {
		this.returns_abs_ytd = returns_abs_ytd;
	}
	public Double getReturns_abs_1year() {
		return returns_abs_1year;
	}
	public void setReturns_abs_1year(Double returns_abs_1year) {
		this.returns_abs_1year = returns_abs_1year;
	}
	public Double getReturns_cmp_2year() {
		return returns_cmp_2year;
	}
	public void setReturns_cmp_2year(Double returns_cmp_2year) {
		this.returns_cmp_2year = returns_cmp_2year;
	}
	public Double getReturns_cmp_3year() {
		return returns_cmp_3year;
	}
	public void setReturns_cmp_3year(Double returns_cmp_3year) {
		this.returns_cmp_3year = returns_cmp_3year;
	}
	public Double getReturns_cmp_4year() {
		return returns_cmp_4year;
	}
	public void setReturns_cmp_4year(Double returns_cmp_4year) {
		this.returns_cmp_4year = returns_cmp_4year;
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
	public Double getReturns_cmp_inception() {
		return returns_cmp_inception;
	}
	public void setReturns_cmp_inception(Double returns_cmp_inception) {
		this.returns_cmp_inception = returns_cmp_inception;
	}
	public Double getReturns_abs_2012() {
		return returns_abs_2012;
	}
	public void setReturns_abs_2012(Double returns_abs_2012) {
		this.returns_abs_2012 = returns_abs_2012;
	}
	public Double getReturns_abs_2013() {
		return returns_abs_2013;
	}
	public void setReturns_abs_2013(Double returns_abs_2013) {
		this.returns_abs_2013 = returns_abs_2013;
	}
	public Double getReturns_abs_2014() {
		return returns_abs_2014;
	}
	public void setReturns_abs_2014(Double returns_abs_2014) {
		this.returns_abs_2014 = returns_abs_2014;
	}
	public Double getReturns_abs_2015() {
		return returns_abs_2015;
	}
	public void setReturns_abs_2015(Double returns_abs_2015) {
		this.returns_abs_2015 = returns_abs_2015;
	}
	public Double getReturns_abs_2016() {
		return returns_abs_2016;
	}
	public void setReturns_abs_2016(Double returns_abs_2016) {
		this.returns_abs_2016 = returns_abs_2016;
	}
	public Double getVolatility_cm_3year() {
		return volatility_cm_3year;
	}
	public void setVolatility_cm_3year(Double volatility_cm_3year) {
		this.volatility_cm_3year = volatility_cm_3year;
	}
	public Double getSharpratio_cm_3year() {
		return sharpratio_cm_3year;
	}
	public void setSharpratio_cm_3year(Double sharpratio_cm_3year) {
		this.sharpratio_cm_3year = sharpratio_cm_3year;
	}
	public Double getAlpha_cm_1year() {
		return alpha_cm_1year;
	}
	public void setAlpha_cm_1year(Double alpha_cm_1year) {
		this.alpha_cm_1year = alpha_cm_1year;
	}
	public Double getBeta_cm_1year() {
		return beta_cm_1year;
	}
	public void setBeta_cm_1year(Double beta_cm_1year) {
		this.beta_cm_1year = beta_cm_1year;
	}
	public Double getYield_to_maturity() {
		return yield_to_maturity;
	}
	public void setYield_to_maturity(Double yield_to_maturity) {
		this.yield_to_maturity = yield_to_maturity;
	}
	public Double getAverage_maturity() {
		return average_maturity;
	}
	public void setAverage_maturity(Double average_maturity) {
		this.average_maturity = average_maturity;
	}
}
