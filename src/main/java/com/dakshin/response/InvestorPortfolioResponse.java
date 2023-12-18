package com.dakshin.response;

import java.util.Date;
import java.util.List;

public class InvestorPortfolioResponse 
{
	private List<InvestorSchemeWisePortfolioResponse> investorSchemeWisePortfolioResponses;
	
	private Integer id;
	private String investorName;
	private String investorPan;
	private String address1;
	private String address2;
	private String address3;
	private String city;
	private String pincode;
	private String state;
	private String guardian_pan;
	private String phone_office;
	private String phone_residence;
	private String email;
	private String date_of_birth;
	private String mobile;
	private String occupation;
	
	private String bank_name;
	private String bank_branch;
	private String acc_type;
	private String acc_no;
	private String bank_address1;
	private String bank_address2;
	private String bank_address3;
	private String bank_city;
	private String bank_pincode;
	private String ifsc_code;
	private String demat;
	
	private String nom_name;
	private String relation;
	private String nom_addr1;
	private String nom_addr2;
	private String nom_addr3;
	private String nom_city;
	private String nom_state;
	private String nom_pincod;
	private String nom_ph_off;
	private String nom_ph_res;
	private String nom_email;
	
	private double totalInflow;
    private double totalOutflow;
    private double totalCurrentcost;
    private double totalCurrentValue;
    private double totalUnReliasedGain;
    private double totalReliasedGain;
    private double totalCAGR;
    
    private double totalDividendReinvestment;
    private double totalDividendPaid;
    private double totalDividend;
    
	private double sip_totalCurrentCost;
    private double sip_totalCurrentValue;
    private double sip_totalUnReliasedGain;
    private double sip_totalReliasedGain;
    private double sip_total_annualized_return;
    
    private List<Date> cagr_dates_array;
    private List<Double> cagr_amount_array;
    private double family_portfolio_return;
    
    
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public List<InvestorSchemeWisePortfolioResponse> getInvestorSchemeWisePortfolioResponses() {
		return investorSchemeWisePortfolioResponses;
	}
	public void setInvestorSchemeWisePortfolioResponses(
			List<InvestorSchemeWisePortfolioResponse> investorSchemeWisePortfolioResponses) {
		this.investorSchemeWisePortfolioResponses = investorSchemeWisePortfolioResponses;
	}
	public String getInvestorName() {
		return investorName;
	}
	public void setInvestorName(String investorName) {
		this.investorName = investorName;
	}
	public String getInvestorPan() {
		return investorPan;
	}
	public void setInvestorPan(String investorPan) {
		this.investorPan = investorPan;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddress3() {
		return address3;
	}
	public void setAddress3(String address3) {
		this.address3 = address3;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getPincode() {
		return pincode;
	}
	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getGuardian_pan() {
		return guardian_pan;
	}
	public void setGuardian_pan(String guardian_pan) {
		this.guardian_pan = guardian_pan;
	}
	public String getPhone_office() {
		return phone_office;
	}
	public void setPhone_office(String phone_office) {
		this.phone_office = phone_office;
	}
	public String getPhone_residence() {
		return phone_residence;
	}
	public void setPhone_residence(String phone_residence) {
		this.phone_residence = phone_residence;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDate_of_birth() {
		return date_of_birth;
	}
	public void setDate_of_birth(String date_of_birth) {
		this.date_of_birth = date_of_birth;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getOccupation() {
		return occupation;
	}
	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	public String getBank_branch() {
		return bank_branch;
	}
	public void setBank_branch(String bank_branch) {
		this.bank_branch = bank_branch;
	}
	public String getAcc_type() {
		return acc_type;
	}
	public void setAcc_type(String acc_type) {
		this.acc_type = acc_type;
	}
	public String getAcc_no() {
		return acc_no;
	}
	public void setAcc_no(String acc_no) {
		this.acc_no = acc_no;
	}
	public String getBank_address1() {
		return bank_address1;
	}
	public void setBank_address1(String bank_address1) {
		this.bank_address1 = bank_address1;
	}
	public String getBank_address2() {
		return bank_address2;
	}
	public void setBank_address2(String bank_address2) {
		this.bank_address2 = bank_address2;
	}
	public String getBank_address3() {
		return bank_address3;
	}
	public void setBank_address3(String bank_address3) {
		this.bank_address3 = bank_address3;
	}
	public String getBank_city() {
		return bank_city;
	}
	public void setBank_city(String bank_city) {
		this.bank_city = bank_city;
	}
	public String getBank_pincode() {
		return bank_pincode;
	}
	public void setBank_pincode(String bank_pincode) {
		this.bank_pincode = bank_pincode;
	}
	public String getIfsc_code() {
		return ifsc_code;
	}
	public void setIfsc_code(String ifsc_code) {
		this.ifsc_code = ifsc_code;
	}
	public String getDemat() {
		return demat;
	}
	public void setDemat(String demat) {
		this.demat = demat;
	}
	public String getNom_name() {
		return nom_name;
	}
	public void setNom_name(String nom_name) {
		this.nom_name = nom_name;
	}
	public String getRelation() {
		return relation;
	}
	public void setRelation(String relation) {
		this.relation = relation;
	}
	public String getNom_addr1() {
		return nom_addr1;
	}
	public void setNom_addr1(String nom_addr1) {
		this.nom_addr1 = nom_addr1;
	}
	public String getNom_addr2() {
		return nom_addr2;
	}
	public void setNom_addr2(String nom_addr2) {
		this.nom_addr2 = nom_addr2;
	}
	public String getNom_addr3() {
		return nom_addr3;
	}
	public void setNom_addr3(String nom_addr3) {
		this.nom_addr3 = nom_addr3;
	}
	public String getNom_city() {
		return nom_city;
	}
	public void setNom_city(String nom_city) {
		this.nom_city = nom_city;
	}
	public String getNom_state() {
		return nom_state;
	}
	public void setNom_state(String nom_state) {
		this.nom_state = nom_state;
	}
	public String getNom_pincod() {
		return nom_pincod;
	}
	public void setNom_pincod(String nom_pincod) {
		this.nom_pincod = nom_pincod;
	}
	public String getNom_ph_off() {
		return nom_ph_off;
	}
	public void setNom_ph_off(String nom_ph_off) {
		this.nom_ph_off = nom_ph_off;
	}
	public String getNom_ph_res() {
		return nom_ph_res;
	}
	public void setNom_ph_res(String nom_ph_res) {
		this.nom_ph_res = nom_ph_res;
	}
	public String getNom_email() {
		return nom_email;
	}
	public void setNom_email(String nom_email) {
		this.nom_email = nom_email;
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
	public double getTotalCurrentcost() {
		return totalCurrentcost;
	}
	public void setTotalCurrentcost(double totalCurrentcost) {
		this.totalCurrentcost = totalCurrentcost;
	}
	public double getTotalCurrentValue() {
		return totalCurrentValue;
	}
	public void setTotalCurrentValue(double totalCurrentValue) {
		this.totalCurrentValue = totalCurrentValue;
	}
	public double getTotalUnReliasedGain() {
		return totalUnReliasedGain;
	}
	public void setTotalUnReliasedGain(double totalUnReliasedGain) {
		this.totalUnReliasedGain = totalUnReliasedGain;
	}
	public double getTotalReliasedGain() {
		return totalReliasedGain;
	}
	public void setTotalReliasedGain(double totalReliasedGain) {
		this.totalReliasedGain = totalReliasedGain;
	}
	public double getTotalCAGR() {
		return totalCAGR;
	}
	public void setTotalCAGR(double totalCAGR) {
		this.totalCAGR = totalCAGR;
	}
	public double getSip_totalCurrentValue() {
		return sip_totalCurrentValue;
	}
	public void setSip_totalCurrentValue(double sip_totalCurrentValue) {
		this.sip_totalCurrentValue = sip_totalCurrentValue;
	}
	public double getSip_total_annualized_return() {
		return sip_total_annualized_return;
	}
	public void setSip_total_annualized_return(double sip_total_annualized_return) {
		this.sip_total_annualized_return = sip_total_annualized_return;
	}
	public double getSip_totalCurrentCost() {
		return sip_totalCurrentCost;
	}
	public void setSip_totalCurrentCost(double sip_totalCurrentCost) {
		this.sip_totalCurrentCost = sip_totalCurrentCost;
	}
	public double getSip_totalUnReliasedGain() {
		return sip_totalUnReliasedGain;
	}
	public void setSip_totalUnReliasedGain(double sip_totalUnReliasedGain) {
		this.sip_totalUnReliasedGain = sip_totalUnReliasedGain;
	}
	public double getSip_totalReliasedGain() {
		return sip_totalReliasedGain;
	}
	public void setSip_totalReliasedGain(double sip_totalReliasedGain) {
		this.sip_totalReliasedGain = sip_totalReliasedGain;
	}
	public double getTotalDividendReinvestment() {
		return totalDividendReinvestment;
	}
	public void setTotalDividendReinvestment(double totalDividendReinvestment) {
		this.totalDividendReinvestment = totalDividendReinvestment;
	}
	public double getTotalDividendPaid() {
		return totalDividendPaid;
	}
	public void setTotalDividendPaid(double totalDividendPaid) {
		this.totalDividendPaid = totalDividendPaid;
	}
	public double getTotalDividend() {
		return totalDividend;
	}
	public void setTotalDividend(double totalDividend) {
		this.totalDividend = totalDividend;
	}
	public List<Date> getCagr_dates_array() {
		return cagr_dates_array;
	}
	public void setCagr_dates_array(List<Date> cagr_dates_array) {
		this.cagr_dates_array = cagr_dates_array;
	}
	public List<Double> getCagr_amount_array() {
		return cagr_amount_array;
	}
	public void setCagr_amount_array(List<Double> cagr_amount_array) {
		this.cagr_amount_array = cagr_amount_array;
	}
	public double getFamily_portfolio_return() {
		return family_portfolio_return;
	}
	public void setFamily_portfolio_return(double family_portfolio_return) {
		this.family_portfolio_return = family_portfolio_return;
	}
}
