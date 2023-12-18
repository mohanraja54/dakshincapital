package com.dakshin.amfi.model;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "scheme_assets")
public class SchemeAssets {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Integer id;
	private String scheme_ve;
	private String scheme_ve_citicode;
	private String scheme_amfi;
	private String scheme_amfi_code;
	private double asset_alt_invest_strategies;
	private double asset_alt_assets;
	private double asset_commodity_energy;
	private double asset_convertibles;
	private double asset_equities;
	private double asset_north_american_equities;
	private double asset_asia_pacific_equities;
	private double asset_indian_equities;
	private double asset_european_equities;
	private double asset_uk_equities;
	private double asset_global_emerging_market_equities;
	private double asset_international_equitites;
	private double asset_gcc_equities;
	private double asset_fixed_interest;
	private double asset_indian_fixed_interest;
	private double asset_uk_fixed_interest;
	private double asset_global_fixed_interest;
	private double asset_islamic_instruments;
	private double asset_mixed_assets;
	private double asset_money_market;
	private double asset_cash_equivalents;
	private double asset_net_current_liabilities;
	private double asset_mutual_funds;
	private double asset_others;
	private double asset_property;
	private double asset_unknown;
	private double asset_with_profits;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getScheme_ve() {
		return scheme_ve;
	}
	public void setScheme_ve(String scheme_ve) {
		this.scheme_ve = scheme_ve;
	}
	public String getScheme_ve_citicode() {
		return scheme_ve_citicode;
	}
	public void setScheme_ve_citicode(String scheme_ve_citicode) {
		this.scheme_ve_citicode = scheme_ve_citicode;
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
	public double getAsset_alt_invest_strategies() {
		return asset_alt_invest_strategies;
	}
	public void setAsset_alt_invest_strategies(double asset_alt_invest_strategies) {
		this.asset_alt_invest_strategies = asset_alt_invest_strategies;
	}
	public double getAsset_alt_assets() {
		return asset_alt_assets;
	}
	public void setAsset_alt_assets(double asset_alt_assets) {
		this.asset_alt_assets = asset_alt_assets;
	}
	public double getAsset_commodity_energy() {
		return asset_commodity_energy;
	}
	public void setAsset_commodity_energy(double asset_commodity_energy) {
		this.asset_commodity_energy = asset_commodity_energy;
	}
	public double getAsset_convertibles() {
		return asset_convertibles;
	}
	public void setAsset_convertibles(double asset_convertibles) {
		this.asset_convertibles = asset_convertibles;
	}
	public double getAsset_equities() {
		return asset_equities;
	}
	public void setAsset_equities(double asset_equities) {
		this.asset_equities = asset_equities;
	}
	public double getAsset_north_american_equities() {
		return asset_north_american_equities;
	}
	public void setAsset_north_american_equities(
			double asset_north_american_equities) {
		this.asset_north_american_equities = asset_north_american_equities;
	}
	public double getAsset_asia_pacific_equities() {
		return asset_asia_pacific_equities;
	}
	public void setAsset_asia_pacific_equities(double asset_asia_pacific_equities) {
		this.asset_asia_pacific_equities = asset_asia_pacific_equities;
	}
	public double getAsset_indian_equities() {
		return asset_indian_equities;
	}
	public void setAsset_indian_equities(double asset_indian_equities) {
		this.asset_indian_equities = asset_indian_equities;
	}
	public double getAsset_european_equities() {
		return asset_european_equities;
	}
	public void setAsset_european_equities(double asset_european_equities) {
		this.asset_european_equities = asset_european_equities;
	}
	public double getAsset_uk_equities() {
		return asset_uk_equities;
	}
	public void setAsset_uk_equities(double asset_uk_equities) {
		this.asset_uk_equities = asset_uk_equities;
	}
	public double getAsset_global_emerging_market_equities() {
		return asset_global_emerging_market_equities;
	}
	public void setAsset_global_emerging_market_equities(
			double asset_global_emerging_market_equities) {
		this.asset_global_emerging_market_equities = asset_global_emerging_market_equities;
	}
	public double getAsset_international_equitites() {
		return asset_international_equitites;
	}
	public void setAsset_international_equitites(
			double asset_international_equitites) {
		this.asset_international_equitites = asset_international_equitites;
	}
	public double getAsset_gcc_equities() {
		return asset_gcc_equities;
	}
	public void setAsset_gcc_equities(double asset_gcc_equities) {
		this.asset_gcc_equities = asset_gcc_equities;
	}
	public double getAsset_fixed_interest() {
		return asset_fixed_interest;
	}
	public void setAsset_fixed_interest(double asset_fixed_interest) {
		this.asset_fixed_interest = asset_fixed_interest;
	}
	public double getAsset_indian_fixed_interest() {
		return asset_indian_fixed_interest;
	}
	public void setAsset_indian_fixed_interest(double asset_indian_fixed_interest) {
		this.asset_indian_fixed_interest = asset_indian_fixed_interest;
	}
	public double getAsset_uk_fixed_interest() {
		return asset_uk_fixed_interest;
	}
	public void setAsset_uk_fixed_interest(double asset_uk_fixed_interest) {
		this.asset_uk_fixed_interest = asset_uk_fixed_interest;
	}
	public double getAsset_global_fixed_interest() {
		return asset_global_fixed_interest;
	}
	public void setAsset_global_fixed_interest(double asset_global_fixed_interest) {
		this.asset_global_fixed_interest = asset_global_fixed_interest;
	}
	public double getAsset_islamic_instruments() {
		return asset_islamic_instruments;
	}
	public void setAsset_islamic_instruments(double asset_islamic_instruments) {
		this.asset_islamic_instruments = asset_islamic_instruments;
	}
	public double getAsset_mixed_assets() {
		return asset_mixed_assets;
	}
	public void setAsset_mixed_assets(double asset_mixed_assets) {
		this.asset_mixed_assets = asset_mixed_assets;
	}
	public double getAsset_money_market() {
		return asset_money_market;
	}
	public void setAsset_money_market(double asset_money_market) {
		this.asset_money_market = asset_money_market;
	}
	public double getAsset_cash_equivalents() {
		return asset_cash_equivalents;
	}
	public void setAsset_cash_equivalents(double asset_cash_equivalents) {
		this.asset_cash_equivalents = asset_cash_equivalents;
	}
	public double getAsset_net_current_liabilities() {
		return asset_net_current_liabilities;
	}
	public void setAsset_net_current_liabilities(
			double asset_net_current_liabilities) {
		this.asset_net_current_liabilities = asset_net_current_liabilities;
	}
	public double getAsset_mutual_funds() {
		return asset_mutual_funds;
	}
	public void setAsset_mutual_funds(double asset_mutual_funds) {
		this.asset_mutual_funds = asset_mutual_funds;
	}
	public double getAsset_others() {
		return asset_others;
	}
	public void setAsset_others(double asset_others) {
		this.asset_others = asset_others;
	}
	public double getAsset_property() {
		return asset_property;
	}
	public void setAsset_property(double asset_property) {
		this.asset_property = asset_property;
	}
	public double getAsset_unknown() {
		return asset_unknown;
	}
	public void setAsset_unknown(double asset_unknown) {
		this.asset_unknown = asset_unknown;
	}
	public double getAsset_with_profits() {
		return asset_with_profits;
	}
	public void setAsset_with_profits(double asset_with_profits) {
		this.asset_with_profits = asset_with_profits;
	}
}
