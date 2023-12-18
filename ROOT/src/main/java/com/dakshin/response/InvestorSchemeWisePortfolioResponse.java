package com.dakshin.response;

import java.util.Date;
import java.util.List;

public class InvestorSchemeWisePortfolioResponse {

	private String scheme;
	private String scheme_registrar;
	private String scheme_code;
	private String amc_code;
	private String foliono;
	
	private Date investmentStartDate;
	private Date lastInvestmentDate;
	private Date lastTransactionDate;
	private double investmentStartNav;
	private double investmentStartValue;
	
	private double totalInflow;
	private double totalOutflow;
	private double partialInflow;
	private double partialOutflow;
	private double totalUnits;
	private double currentCostOfInvestment;
	private double purchaseNav;
	private double dividendReinvestment;
	private double dividendPaid;
	private double latestNav;
	private Date latestNavDate;
	private double totalCurrentValue;
	private double unrealisedProfitLoss;
	private double realisedProfitLoss;
	private double cagr;
	
	private Boolean isSipScheme = false;
	private Boolean isActiveSipScheme = false;
	private Boolean isDividendScheme = false;
	private Boolean isDividendReinvest = false;
	private Boolean isDividendDeclared = false;
	private Boolean isNegativeTransaction = false;
	
	private String scheme_company;
	private String scheme_advisorkhoj_category;
	private String scheme_amfi_code;
	
	private double sip_amount;
	private double total_sip_amount;
	private double sip_total_inflow;
	private double sip_total_units;
	private double sip_total_current_value;
	private double sip_annualized_return;
	
	private double total_dividend_paid;
	private double total_dividend_reinvest;
	private String isin_no;
	
	private List<InvestorSchemeWiseTransactionResponse> investorSchemeWiseTransactionResponses;

	public String getScheme() {
		return scheme;
	}

	public void setScheme(String scheme) {
		this.scheme = scheme;
	}

	public String getScheme_code() {
		return scheme_code;
	}

	public void setScheme_code(String scheme_code) {
		this.scheme_code = scheme_code;
	}

	public String getAmc_code() {
		return amc_code;
	}

	public void setAmc_code(String amc_code) {
		this.amc_code = amc_code;
	}

	public String getFoliono() {
		return foliono;
	}

	public void setFoliono(String foliono) {
		this.foliono = foliono;
	}

	public Date getInvestmentStartDate() {
		return investmentStartDate;
	}

	public void setInvestmentStartDate(Date investmentStartDate) {
		this.investmentStartDate = investmentStartDate;
	}

	public Date getLastInvestmentDate() {
		return lastInvestmentDate;
	}

	public void setLastInvestmentDate(Date lastInvestmentDate) {
		this.lastInvestmentDate = lastInvestmentDate;
	}

	public Date getLastTransactionDate() {
		return lastTransactionDate;
	}

	public void setLastTransactionDate(Date lastTransactionDate) {
		this.lastTransactionDate = lastTransactionDate;
	}

	public double getInvestmentStartNav() {
		return investmentStartNav;
	}

	public void setInvestmentStartNav(double investmentStartNav) {
		this.investmentStartNav = investmentStartNav;
	}

	public double getInvestmentStartValue() {
		return investmentStartValue;
	}

	public void setInvestmentStartValue(double investmentStartValue) {
		this.investmentStartValue = investmentStartValue;
	}

	public double getTotalInflow() {
		return totalInflow;
	}

	public void setTotalInflow(double totalInflow) {
		this.totalInflow = totalInflow;
	}

	public double getTotalOutflow() {
		return totalOutflow;
	}

	public void setTotalOutflow(double totalOutflow) {
		this.totalOutflow = totalOutflow;
	}

	public double getPartialInflow() {
		return partialInflow;
	}

	public void setPartialInflow(double partialInflow) {
		this.partialInflow = partialInflow;
	}

	public double getPartialOutflow() {
		return partialOutflow;
	}

	public void setPartialOutflow(double partialOutflow) {
		this.partialOutflow = partialOutflow;
	}

	public double getTotalUnits() {
		return totalUnits;
	}

	public void setTotalUnits(double totalUnits) {
		this.totalUnits = totalUnits;
	}

	public double getCurrentCostOfInvestment() {
		return currentCostOfInvestment;
	}

	public void setCurrentCostOfInvestment(double currentCostOfInvestment) {
		this.currentCostOfInvestment = currentCostOfInvestment;
	}

	public double getPurchaseNav() {
		return purchaseNav;
	}

	public void setPurchaseNav(double purchaseNav) {
		this.purchaseNav = purchaseNav;
	}

	public double getDividendReinvestment() {
		return dividendReinvestment;
	}

	public void setDividendReinvestment(double dividendReinvestment) {
		this.dividendReinvestment = dividendReinvestment;
	}

	public double getDividendPaid() {
		return dividendPaid;
	}

	public void setDividendPaid(double dividendPaid) {
		this.dividendPaid = dividendPaid;
	}

	public double getLatestNav() {
		return latestNav;
	}

	public void setLatestNav(double latestNav) {
		this.latestNav = latestNav;
	}

	public Date getLatestNavDate() {
		return latestNavDate;
	}

	public void setLatestNavDate(Date latestNavDate) {
		this.latestNavDate = latestNavDate;
	}

	public double getTotalCurrentValue() {
		return totalCurrentValue;
	}

	public void setTotalCurrentValue(double totalCurrentValue) {
		this.totalCurrentValue = totalCurrentValue;
	}

	public double getUnrealisedProfitLoss() {
		return unrealisedProfitLoss;
	}

	public void setUnrealisedProfitLoss(double unrealisedProfitLoss) {
		this.unrealisedProfitLoss = unrealisedProfitLoss;
	}

	public double getRealisedProfitLoss() {
		return realisedProfitLoss;
	}

	public void setRealisedProfitLoss(double realisedProfitLoss) {
		this.realisedProfitLoss = realisedProfitLoss;
	}

	public double getCagr() {
		return cagr;
	}

	public void setCagr(double cagr) {
		this.cagr = cagr;
	}

	public Boolean getIsSipScheme() {
		return isSipScheme;
	}

	public void setIsSipScheme(Boolean isSipScheme) {
		this.isSipScheme = isSipScheme;
	}

	public Boolean getIsDividendScheme() {
		return isDividendScheme;
	}

	public void setIsDividendScheme(Boolean isDividendScheme) {
		this.isDividendScheme = isDividendScheme;
	}

	public Boolean getIsDividendDeclared() {
		return isDividendDeclared;
	}

	public void setIsDividendDeclared(Boolean isDividendDeclared) {
		this.isDividendDeclared = isDividendDeclared;
	}

	public Boolean getIsNegativeTransaction() {
		return isNegativeTransaction;
	}

	public void setIsNegativeTransaction(Boolean isNegativeTransaction) {
		this.isNegativeTransaction = isNegativeTransaction;
	}

	public String getScheme_company() {
		return scheme_company;
	}

	public void setScheme_company(String scheme_company) {
		this.scheme_company = scheme_company;
	}

	public String getScheme_advisorkhoj_category() {
		return scheme_advisorkhoj_category;
	}

	public void setScheme_advisorkhoj_category(String scheme_advisorkhoj_category) {
		this.scheme_advisorkhoj_category = scheme_advisorkhoj_category;
	}

	public double getSip_amount() {
		return sip_amount;
	}

	public void setSip_amount(double sip_amount) {
		this.sip_amount = sip_amount;
	}

	public double getSip_total_inflow() {
		return sip_total_inflow;
	}

	public void setSip_total_inflow(double sip_total_inflow) {
		this.sip_total_inflow = sip_total_inflow;
	}

	public double getSip_total_units() {
		return sip_total_units;
	}

	public void setSip_total_units(double sip_total_units) {
		this.sip_total_units = sip_total_units;
	}

	public double getSip_total_current_value() {
		return sip_total_current_value;
	}

	public void setSip_total_current_value(double sip_total_current_value) {
		this.sip_total_current_value = sip_total_current_value;
	}

	public double getSip_annualized_return() {
		return sip_annualized_return;
	}

	public void setSip_annualized_return(double sip_annualized_return) {
		this.sip_annualized_return = sip_annualized_return;
	}

	public double getTotal_dividend_paid() {
		return total_dividend_paid;
	}

	public void setTotal_dividend_paid(double total_dividend_paid) {
		this.total_dividend_paid = total_dividend_paid;
	}

	public double getTotal_dividend_reinvest() {
		return total_dividend_reinvest;
	}

	public void setTotal_dividend_reinvest(double total_dividend_reinvest) {
		this.total_dividend_reinvest = total_dividend_reinvest;
	}

	public List<InvestorSchemeWiseTransactionResponse> getInvestorSchemeWiseTransactionResponses() {
		return investorSchemeWiseTransactionResponses;
	}

	public void setInvestorSchemeWiseTransactionResponses(
			List<InvestorSchemeWiseTransactionResponse> investorSchemeWiseTransactionResponses) {
		this.investorSchemeWiseTransactionResponses = investorSchemeWiseTransactionResponses;
	}

	public String getScheme_amfi_code() {
		return scheme_amfi_code;
	}

	public void setScheme_amfi_code(String scheme_amfi_code) {
		this.scheme_amfi_code = scheme_amfi_code;
	}

	public String getScheme_registrar() {
		return scheme_registrar;
	}

	public void setScheme_registrar(String scheme_registrar) {
		this.scheme_registrar = scheme_registrar;
	}

	public double getTotal_sip_amount() {
		return total_sip_amount;
	}

	public void setTotal_sip_amount(double total_sip_amount) {
		this.total_sip_amount = total_sip_amount;
	}

	public Boolean getIsActiveSipScheme() {
		return isActiveSipScheme;
	}

	public void setIsActiveSipScheme(Boolean isActiveSipScheme) {
		this.isActiveSipScheme = isActiveSipScheme;
	}

	public Boolean getIsDividendReinvest() {
		return isDividendReinvest;
	}

	public void setIsDividendReinvest(Boolean isDividendReinvest) {
		this.isDividendReinvest = isDividendReinvest;
	}

	public String getIsin_no() {
		return isin_no;
	}

	public void setIsin_no(String isin_no) {
		this.isin_no = isin_no;
	}

}
