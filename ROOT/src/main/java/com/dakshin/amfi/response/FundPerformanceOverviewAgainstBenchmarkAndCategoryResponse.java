package com.dakshin.amfi.response;

import java.util.List;

import com.dakshin.amfi.model.SchemePerformances;
import com.dakshin.amfi.model.SchemePerformancesBenchmark;
import com.dakshin.amfi.model.SchemePerformancesCategory;


public class FundPerformanceOverviewAgainstBenchmarkAndCategoryResponse {

	SchemePerformances schemePerformances;
	SchemePerformancesBenchmark schemePerformancesBenchmark;
	SchemePerformancesCategory schemePerformancesCategory;
	
	List<SchemePerformances> peerComparisonList;
	
	String fund_name;
	Double fund_ytd;
	Double fund_one_month;
	Double fund_three_month;
	Double fund_one_year;
	Double fund_three_year;
	Double fund_five_year;
	Double fund_ten_year;
	String category_name;
	Double category_ytd;
	Double category_month;
	Double category_three_month;
	Double category_one_year;
	Double category_three_year;
	Double category_five_year;
	Double category_ten_year;
	int rank_ytd;
	int rank_month;
	int rank_three_month;
	int rank_one_year;
	int rank_three_year;
	int rank_five_year;
	int rank_ten_year;
	int no_of_funds_ytd;
	int no_of_funds_one_month;
	int no_of_funds_three_month;
	int no_of_funds_one_year;
	int no_of_funds_three_year;
	int no_of_funds_five_year;
	int no_of_funds_ten_year;
	
	
	
	public Double getFund_ytd() {
		return fund_ytd;
	}
	public void setFund_ytd(Double fund_ytd) {
		this.fund_ytd = fund_ytd;
	}
	public Double getFund_one_month() {
		return fund_one_month;
	}
	public void setFund_one_month(Double fund_one_month) {
		this.fund_one_month = fund_one_month;
	}
	public Double getFund_three_month() {
		return fund_three_month;
	}
	public void setFund_three_month(Double fund_three_month) {
		this.fund_three_month = fund_three_month;
	}
	public Double getFund_one_year() {
		return fund_one_year;
	}
	public void setFund_one_year(Double fund_one_year) {
		this.fund_one_year = fund_one_year;
	}
	public Double getFund_three_year() {
		return fund_three_year;
	}
	public void setFund_three_year(Double fund_three_year) {
		this.fund_three_year = fund_three_year;
	}
	public Double getFund_five_year() {
		return fund_five_year;
	}
	public void setFund_five_year(Double fund_five_year) {
		this.fund_five_year = fund_five_year;
	}
	public Double getFund_ten_year() {
		return fund_ten_year;
	}
	public void setFund_ten_year(Double fund_ten_year) {
		this.fund_ten_year = fund_ten_year;
	}
	public Double getCategory_ytd() {
		return category_ytd;
	}
	public void setCategory_ytd(Double category_ytd) {
		this.category_ytd = category_ytd;
	}
	public Double getCategory_month() {
		return category_month;
	}
	public void setCategory_month(Double category_month) {
		this.category_month = category_month;
	}
	public Double getCategory_three_month() {
		return category_three_month;
	}
	public void setCategory_three_month(Double category_three_month) {
		this.category_three_month = category_three_month;
	}
	public Double getCategory_one_year() {
		return category_one_year;
	}
	public void setCategory_one_year(Double category_one_year) {
		this.category_one_year = category_one_year;
	}
	public Double getCategory_three_year() {
		return category_three_year;
	}
	public void setCategory_three_year(Double category_three_year) {
		this.category_three_year = category_three_year;
	}
	public Double getCategory_five_year() {
		return category_five_year;
	}
	public void setCategory_five_year(Double category_five_year) {
		this.category_five_year = category_five_year;
	}
	public Double getCategory_ten_year() {
		return category_ten_year;
	}
	public void setCategory_ten_year(Double category_ten_year) {
		this.category_ten_year = category_ten_year;
	}		
	public int getRank_ytd() {
		return rank_ytd;
	}
	public void setRank_ytd(int rank_ytd) {
		this.rank_ytd = rank_ytd;
	}
	public int getRank_month() {
		return rank_month;
	}
	public void setRank_month(int rank_month) {
		this.rank_month = rank_month;
	}
	public int getRank_three_month() {
		return rank_three_month;
	}
	public void setRank_three_month(int rank_three_month) {
		this.rank_three_month = rank_three_month;
	}
	public int getRank_one_year() {
		return rank_one_year;
	}
	public void setRank_one_year(int rank_one_year) {
		this.rank_one_year = rank_one_year;
	}
	public int getRank_three_year() {
		return rank_three_year;
	}
	public void setRank_three_year(int rank_three_year) {
		this.rank_three_year = rank_three_year;
	}
	public int getRank_five_year() {
		return rank_five_year;
	}
	public void setRank_five_year(int rank_five_year) {
		this.rank_five_year = rank_five_year;
	}
	public int getRank_ten_year() {
		return rank_ten_year;
	}
	public void setRank_ten_year(int rank_ten_year) {
		this.rank_ten_year = rank_ten_year;
	}
	public int getNo_of_funds_ytd() {
		return no_of_funds_ytd;
	}
	public void setNo_of_funds_ytd(int no_of_funds_ytd) {
		this.no_of_funds_ytd = no_of_funds_ytd;
	}
	public int getNo_of_funds_one_month() {
		return no_of_funds_one_month;
	}
	public void setNo_of_funds_one_month(int no_of_funds_one_month) {
		this.no_of_funds_one_month = no_of_funds_one_month;
	}
	public int getNo_of_funds_three_month() {
		return no_of_funds_three_month;
	}
	public void setNo_of_funds_three_month(int no_of_funds_three_month) {
		this.no_of_funds_three_month = no_of_funds_three_month;
	}
	public int getNo_of_funds_one_year() {
		return no_of_funds_one_year;
	}
	public void setNo_of_funds_one_year(int no_of_funds_one_year) {
		this.no_of_funds_one_year = no_of_funds_one_year;
	}
	public int getNo_of_funds_three_year() {
		return no_of_funds_three_year;
	}
	public void setNo_of_funds_three_year(int no_of_funds_three_year) {
		this.no_of_funds_three_year = no_of_funds_three_year;
	}
	public int getNo_of_funds_five_year() {
		return no_of_funds_five_year;
	}
	public void setNo_of_funds_five_year(int no_of_funds_five_year) {
		this.no_of_funds_five_year = no_of_funds_five_year;
	}
	public int getNo_of_funds_ten_year() {
		return no_of_funds_ten_year;
	}
	public void setNo_of_funds_ten_year(int no_of_funds_ten_year) {
		this.no_of_funds_ten_year = no_of_funds_ten_year;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getFund_name() {
		return fund_name;
	}
	public void setFund_name(String fund_name) {
		this.fund_name = fund_name;
	}
	public SchemePerformances getSchemePerformances() {
		return schemePerformances;
	}
	public void setSchemePerformances(SchemePerformances schemePerformances) {
		this.schemePerformances = schemePerformances;
	}
	public SchemePerformancesBenchmark getSchemePerformancesBenchmark() {
		return schemePerformancesBenchmark;
	}
	public void setSchemePerformancesBenchmark(
			SchemePerformancesBenchmark schemePerformancesBenchmark) {
		this.schemePerformancesBenchmark = schemePerformancesBenchmark;
	}
	public List<SchemePerformances> getPeerComparisonList() {
		return peerComparisonList;
	}
	public void setPeerComparisonList(List<SchemePerformances> peerComparisonList) {
		this.peerComparisonList = peerComparisonList;
	}
	public SchemePerformancesCategory getSchemePerformancesCategory() {
		return schemePerformancesCategory;
	}
	public void setSchemePerformancesCategory(
			SchemePerformancesCategory schemePerformancesCategory) {
		this.schemePerformancesCategory = schemePerformancesCategory;
	}
}
