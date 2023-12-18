package com.dakshin.amfi.response;

import java.util.Date;
import java.util.List;

import com.dakshin.amfi.model.SchemeDividendHistory;
import com.dakshin.amfi.model.SchemeMapping;
import com.dakshin.amfi.model.SchemePerformances;

public class SchemeInfoApiResponse {
	
	public Integer status;
	public String status_msg;
	public String msg;
	public String scheme_name;
	public String scheme_amfi_code;
	public double nav;
	public Date nav_date;
	public double nav_change;
	public double nav_change_percentage;
	public double scheme_inception_return;
	public double benchmark_inception_return;
	public String scheme_objective;
	public String scheme_manager;
	public String scheme_manager_biography;
	public String riskometer_value;
	public String riskometer_image;
	private String isin_no;
	private String isin_divreinvst_no;
	
	public String scheme_category;
	public String scheme_company;
	public Date scheme_inception_date;
	public String asset_class;
	public String scheme_benchmark;
	public String scheme_benchmark_code;
	public double expense_ratio_percentage;
	public String expense_ratio_date;
	public String scheme_status;
	public double minimum_investment;
	public double minimum_topup;
	public double scheme_assets;
	public String scheme_asset_date;
	public String scheme_turnover;
	
	public Date scheme_sip_start_date;
	public Date scheme_sip_end_date;
	public Date scheme_lumpsum_start_date;
	
	public List<SchemePerformanceApiResponse> scheme_performance_list;
	
	public List<RiskStatisticsApiResponse> risk_statistics_list;
	
	public List<SchemePerformanceApiResponse> scheme_peer_comparision_list;
	
	public boolean is_dividend_scheme;
	public List<SchemeDividendHistory> dividend_list;
	public SchemeMapping schemeMapping;
	public SchemePerformances schemePerformances;
	public FundPerformanceOverviewAgainstBenchmarkAndCategoryResponse fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse;
	public List<SchemePerformances> peerComparisonResponse;
	
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getStatus_msg() {
		return status_msg;
	}
	public void setStatus_msg(String status_msg) {
		this.status_msg = status_msg;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getScheme_name() {
		return scheme_name;
	}
	public void setScheme_name(String scheme_name) {
		this.scheme_name = scheme_name;
	}
	public double getNav() {
		return nav;
	}
	public void setNav(double nav) {
		this.nav = nav;
	}
	public Date getNav_date() {
		return nav_date;
	}
	public void setNav_date(Date nav_date) {
		this.nav_date = nav_date;
	}
	public double getNav_change() {
		return nav_change;
	}
	public void setNav_change(double nav_change) {
		this.nav_change = nav_change;
	}
	public double getNav_change_percentage() {
		return nav_change_percentage;
	}
	public void setNav_change_percentage(double nav_change_percentage) {
		this.nav_change_percentage = nav_change_percentage;
	}
	public String getScheme_objective() {
		return scheme_objective;
	}
	public void setScheme_objective(String scheme_objective) {
		this.scheme_objective = scheme_objective;
	}
	public String getScheme_manager() {
		return scheme_manager;
	}
	public void setScheme_manager(String scheme_manager) {
		this.scheme_manager = scheme_manager;
	}
	public String getScheme_manager_biography() {
		return scheme_manager_biography;
	}
	public void setScheme_manager_biography(String scheme_manager_biography) {
		this.scheme_manager_biography = scheme_manager_biography;
	}
	public String getScheme_category() {
		return scheme_category;
	}
	public void setScheme_category(String scheme_category) {
		this.scheme_category = scheme_category;
	}
	public Date getScheme_inception_date() {
		return scheme_inception_date;
	}
	public void setScheme_inception_date(Date scheme_inception_date) {
		this.scheme_inception_date = scheme_inception_date;
	}
	public String getAsset_class() {
		return asset_class;
	}
	public void setAsset_class(String asset_class) {
		this.asset_class = asset_class;
	}
	public String getScheme_benchmark() {
		return scheme_benchmark;
	}
	public void setScheme_benchmark(String scheme_benchmark) {
		this.scheme_benchmark = scheme_benchmark;
	}
	public String getScheme_status() {
		return scheme_status;
	}
	public void setScheme_status(String scheme_status) {
		this.scheme_status = scheme_status;
	}
	public String getScheme_asset_date() {
		return scheme_asset_date;
	}
	public void setScheme_asset_date(String scheme_asset_date) {
		this.scheme_asset_date = scheme_asset_date;
	}
	public String getScheme_turnover() {
		return scheme_turnover;
	}
	public void setScheme_turnover(String scheme_turnover) {
		this.scheme_turnover = scheme_turnover;
	}
	public Date getScheme_sip_start_date() {
		return scheme_sip_start_date;
	}
	public void setScheme_sip_start_date(Date scheme_sip_start_date) {
		this.scheme_sip_start_date = scheme_sip_start_date;
	}
	public Date getScheme_sip_end_date() {
		return scheme_sip_end_date;
	}
	public void setScheme_sip_end_date(Date scheme_sip_end_date) {
		this.scheme_sip_end_date = scheme_sip_end_date;
	}
	public Date getScheme_lumpsum_start_date() {
		return scheme_lumpsum_start_date;
	}
	public void setScheme_lumpsum_start_date(Date scheme_lumpsum_start_date) {
		this.scheme_lumpsum_start_date = scheme_lumpsum_start_date;
	}
	public List<SchemePerformanceApiResponse> getScheme_performance_list() {
		return scheme_performance_list;
	}
	public void setScheme_performance_list(
			List<SchemePerformanceApiResponse> scheme_performance_list) {
		this.scheme_performance_list = scheme_performance_list;
	}
	public List<SchemePerformanceApiResponse> getScheme_peer_comparision_list() {
		return scheme_peer_comparision_list;
	}
	public void setScheme_peer_comparision_list(
			List<SchemePerformanceApiResponse> scheme_peer_comparision_list) {
		this.scheme_peer_comparision_list = scheme_peer_comparision_list;
	}
	public boolean isIs_dividend_scheme() {
		return is_dividend_scheme;
	}
	public void setIs_dividend_scheme(boolean is_dividend_scheme) {
		this.is_dividend_scheme = is_dividend_scheme;
	}
	public List<SchemeDividendHistory> getDividend_list() {
		return dividend_list;
	}
	public void setDividend_list(List<SchemeDividendHistory> dividend_list) {
		this.dividend_list = dividend_list;
	}
	public double getExpense_ratio_percentage() {
		return expense_ratio_percentage;
	}
	public void setExpense_ratio_percentage(double expense_ratio_percentage) {
		this.expense_ratio_percentage = expense_ratio_percentage;
	}
	public String getExpense_ratio_date() {
		return expense_ratio_date;
	}
	public void setExpense_ratio_date(String expense_ratio_date) {
		this.expense_ratio_date = expense_ratio_date;
	}
	public double getMinimum_investment() {
		return minimum_investment;
	}
	public void setMinimum_investment(double minimum_investment) {
		this.minimum_investment = minimum_investment;
	}
	public double getMinimum_topup() {
		return minimum_topup;
	}
	public void setMinimum_topup(double minimum_topup) {
		this.minimum_topup = minimum_topup;
	}
	public double getScheme_assets() {
		return scheme_assets;
	}
	public void setScheme_assets(double scheme_assets) {
		this.scheme_assets = scheme_assets;
	}
	public double getScheme_inception_return() {
		return scheme_inception_return;
	}
	public void setScheme_inception_return(double scheme_inception_return) {
		this.scheme_inception_return = scheme_inception_return;
	}
	public double getBenchmark_inception_return() {
		return benchmark_inception_return;
	}
	public void setBenchmark_inception_return(double benchmark_inception_return) {
		this.benchmark_inception_return = benchmark_inception_return;
	}
	public String getRiskometer_value() {
		return riskometer_value;
	}
	public void setRiskometer_value(String riskometer_value) {
		this.riskometer_value = riskometer_value;
	}
	public String getRiskometer_image() {
		return riskometer_image;
	}
	public void setRiskometer_image(String riskometer_image) {
		this.riskometer_image = riskometer_image;
	}
	public List<RiskStatisticsApiResponse> getRisk_statistics_list() {
		return risk_statistics_list;
	}
	public void setRisk_statistics_list(List<RiskStatisticsApiResponse> risk_statistics_list) {
		this.risk_statistics_list = risk_statistics_list;
	}
	public String getScheme_amfi_code() {
		return scheme_amfi_code;
	}
	public void setScheme_amfi_code(String scheme_amfi_code) {
		this.scheme_amfi_code = scheme_amfi_code;
	}
	public String getScheme_benchmark_code() {
		return scheme_benchmark_code;
	}
	public void setScheme_benchmark_code(String scheme_benchmark_code) {
		this.scheme_benchmark_code = scheme_benchmark_code;
	}
	public String getScheme_company() {
		return scheme_company;
	}
	public void setScheme_company(String scheme_company) {
		this.scheme_company = scheme_company;
	}
	public String getIsin_no() {
		return isin_no;
	}
	public void setIsin_no(String isin_no) {
		this.isin_no = isin_no;
	}
	public String getIsin_divreinvst_no() {
		return isin_divreinvst_no;
	}
	public void setIsin_divreinvst_no(String isin_divreinvst_no) {
		this.isin_divreinvst_no = isin_divreinvst_no;
	}
	public SchemeMapping getSchemeMapping() {
		return schemeMapping;
	}
	public void setSchemeMapping(SchemeMapping schemeMapping) {
		this.schemeMapping = schemeMapping;
	}	
	public SchemePerformances getSchemePerformances() {
		return schemePerformances;
	}
	public void setSchemePerformances(SchemePerformances schemePerformances) {
		this.schemePerformances = schemePerformances;
	}
	public FundPerformanceOverviewAgainstBenchmarkAndCategoryResponse getFundPerformanceOverviewAgainstBenchmarkAndCategoryResponse() {
		return fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse;
	}
	public void setFundPerformanceOverviewAgainstBenchmarkAndCategoryResponse(
			FundPerformanceOverviewAgainstBenchmarkAndCategoryResponse fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse) {
		this.fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse = fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse;
	}
	
	public List<SchemePerformances> getPeerComparisonResponse() {
		return peerComparisonResponse;
	}
	public void setPeerComparisonResponse(List<SchemePerformances> peerComparisonResponse) {
		this.peerComparisonResponse = peerComparisonResponse;
	}
}
