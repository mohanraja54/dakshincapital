package com.dakshin.amfi.model;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Cacheable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Table(name = "scheme_performances_benchmark")
public class SchemePerformancesBenchmark {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Integer id;
	private String benchmark_name;
	private String citicode;	
	private Date price_date;
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
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getBenchmark_name() {
		return benchmark_name;
	}
	public void setBenchmark_name(String benchmark_name) {
		this.benchmark_name = benchmark_name;
	}
	public String getCiticode() {
		return citicode;
	}
	public void setCiticode(String citicode) {
		this.citicode = citicode;
	}
	public Date getPrice_date() {
		return price_date;
	}
	public void setPrice_date(Date price_date) {
		this.price_date = price_date;
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
}
