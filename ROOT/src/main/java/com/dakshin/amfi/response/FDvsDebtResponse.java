package com.dakshin.amfi.response;

public class FDvsDebtResponse {
    public String scheme;
    public double investment_amount;
    public String start_date;
    public double start_nav;
    public String end_date;
    public double end_nav;
    
    public double scheme_investment_value;
    public double scheme_absolute_return;
    public double scheme_annualized_return;
    
    public double scheme_interest_amount;
    public double post_tax_scheme_interest_amount;
    public double scheme_income_tax;
    public double post_tax_scheme_investment_value;
    public double post_tax_scheme_absolute_return;
    public double post_tax_scheme_annualized_return;
    public double scheme_indexed_cost_of_purchase;
    
    public double fd_investment_value;
    public double fd_absolute_return;
    public double fd_annualized_return;
    
    public double fd_interest_amount;
    public double post_tax_fd_interest_amount;
    public double fd_income_tax;
    public double post_tax_fd_investment_value;
    public double post_tax_fd_absolute_return;
    public double post_tax_fd_annualized_return;
    private String url;
    
    
	public String getScheme() {
		return scheme;
	}
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	public double getInvestment_amount() {
		return investment_amount;
	}
	public void setInvestment_amount(double investment_amount) {
		this.investment_amount = investment_amount;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public double getStart_nav() {
		return start_nav;
	}
	public void setStart_nav(double start_nav) {
		this.start_nav = start_nav;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public double getEnd_nav() {
		return end_nav;
	}
	public void setEnd_nav(double end_nav) {
		this.end_nav = end_nav;
	}
	public double getScheme_investment_value() {
		return scheme_investment_value;
	}
	public void setScheme_investment_value(double scheme_investment_value) {
		this.scheme_investment_value = scheme_investment_value;
	}
	public double getScheme_absolute_return() {
		return scheme_absolute_return;
	}
	public void setScheme_absolute_return(double scheme_absolute_return) {
		this.scheme_absolute_return = scheme_absolute_return;
	}
	public double getScheme_annualized_return() {
		return scheme_annualized_return;
	}
	public void setScheme_annualized_return(double scheme_annualized_return) {
		this.scheme_annualized_return = scheme_annualized_return;
	}
	public double getScheme_interest_amount() {
		return scheme_interest_amount;
	}
	public void setScheme_interest_amount(double scheme_interest_amount) {
		this.scheme_interest_amount = scheme_interest_amount;
	}
	public double getPost_tax_scheme_interest_amount() {
		return post_tax_scheme_interest_amount;
	}
	public void setPost_tax_scheme_interest_amount(
			double post_tax_scheme_interest_amount) {
		this.post_tax_scheme_interest_amount = post_tax_scheme_interest_amount;
	}
	public double getScheme_income_tax() {
		return scheme_income_tax;
	}
	public void setScheme_income_tax(double scheme_income_tax) {
		this.scheme_income_tax = scheme_income_tax;
	}
	public double getPost_tax_scheme_investment_value() {
		return post_tax_scheme_investment_value;
	}
	public void setPost_tax_scheme_investment_value(
			double post_tax_scheme_investment_value) {
		this.post_tax_scheme_investment_value = post_tax_scheme_investment_value;
	}
	public double getPost_tax_scheme_absolute_return() {
		return post_tax_scheme_absolute_return;
	}
	public void setPost_tax_scheme_absolute_return(
			double post_tax_scheme_absolute_return) {
		this.post_tax_scheme_absolute_return = post_tax_scheme_absolute_return;
	}
	public double getPost_tax_scheme_annualized_return() {
		return post_tax_scheme_annualized_return;
	}
	public void setPost_tax_scheme_annualized_return(
			double post_tax_scheme_annualized_return) {
		this.post_tax_scheme_annualized_return = post_tax_scheme_annualized_return;
	}
	public double getFd_investment_value() {
		return fd_investment_value;
	}
	public void setFd_investment_value(double fd_investment_value) {
		this.fd_investment_value = fd_investment_value;
	}
	public double getFd_absolute_return() {
		return fd_absolute_return;
	}
	public void setFd_absolute_return(double fd_absolute_return) {
		this.fd_absolute_return = fd_absolute_return;
	}
	public double getFd_annualized_return() {
		return fd_annualized_return;
	}
	public void setFd_annualized_return(double fd_annualized_return) {
		this.fd_annualized_return = fd_annualized_return;
	}
	public double getFd_interest_amount() {
		return fd_interest_amount;
	}
	public void setFd_interest_amount(double fd_interest_amount) {
		this.fd_interest_amount = fd_interest_amount;
	}
	public double getPost_tax_fd_interest_amount() {
		return post_tax_fd_interest_amount;
	}
	public void setPost_tax_fd_interest_amount(double post_tax_fd_interest_amount) {
		this.post_tax_fd_interest_amount = post_tax_fd_interest_amount;
	}
	public double getFd_income_tax() {
		return fd_income_tax;
	}
	public void setFd_income_tax(double fd_income_tax) {
		this.fd_income_tax = fd_income_tax;
	}
	public double getPost_tax_fd_investment_value() {
		return post_tax_fd_investment_value;
	}
	public void setPost_tax_fd_investment_value(double post_tax_fd_investment_value) {
		this.post_tax_fd_investment_value = post_tax_fd_investment_value;
	}
	public double getPost_tax_fd_absolute_return() {
		return post_tax_fd_absolute_return;
	}
	public void setPost_tax_fd_absolute_return(double post_tax_fd_absolute_return) {
		this.post_tax_fd_absolute_return = post_tax_fd_absolute_return;
	}
	public double getPost_tax_fd_annualized_return() {
		return post_tax_fd_annualized_return;
	}
	public void setPost_tax_fd_annualized_return(
			double post_tax_fd_annualized_return) {
		this.post_tax_fd_annualized_return = post_tax_fd_annualized_return;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public double getScheme_indexed_cost_of_purchase() {
		return scheme_indexed_cost_of_purchase;
	}
	public void setScheme_indexed_cost_of_purchase(
			double scheme_indexed_cost_of_purchase) {
		this.scheme_indexed_cost_of_purchase = scheme_indexed_cost_of_purchase;
	}
}