package com.dakshin.amfi.model;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "scheme_performances")
public class SchemePerformances {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Integer id;
	private String scheme_ve;
	private String scheme_ve_citicode;
	private Date inception_date;
	private Date price_date;
	private String scheme_amfi;
	private String scheme_amfi_code;
	private String scheme_category;
	private String open_or_closed;
	private double returns_abs_7days;
	private double returns_abs_1month;
	private double returns_abs_3month;
	private double returns_abs_6month;
	private double returns_abs_ytd;
	private double returns_abs_1year;
	private double returns_cmp_2year;
	private double returns_cmp_3year;
	private double returns_cmp_4year;
	private double returns_cmp_5year;
	private double returns_cmp_10year;
	private double returns_cmp_inception;
	private double returns_abs_2007;
	private double returns_abs_2008;
	private double returns_abs_2009;
	private double returns_abs_2010;
	private double returns_abs_2011;
	private double returns_abs_2012;
	private double returns_abs_2013;
	private double returns_abs_2014;
	private double returns_abs_2015;
	private double returns_abs_2016;
	private double ter;
	private Date ter_date;
	private double price;
	private double price_change_onday;
	private double price_change_percent_onday;
	private String scheme_company;
	private String scheme_asset_date;
	private double scheme_assets;
	private String nav_table;
	private String url;
	private Integer etf_scheme;
	private String isin_no;
	private String isin_divreinvst_no;
	private String isin_sweep_no;
	
	private Integer returns_abs_7days_rank;
	private Integer returns_abs_1month_rank;
	private Integer returns_abs_3month_rank;
	private Integer returns_abs_6month_rank;
	private Integer returns_abs_ytd_rank;
	private Integer returns_abs_1year_rank;
	private Integer returns_cmp_2year_rank;
	private Integer returns_cmp_3year_rank;
	private Integer returns_cmp_4year_rank;
	private Integer returns_cmp_5year_rank;
	private Integer returns_cmp_10year_rank;
	private Integer returns_cmp_inception_rank;
	
	private Integer returns_abs_7days_totalrank;
	private Integer returns_abs_1month_totalrank;
	private Integer returns_abs_3month_totalrank;
	private Integer returns_abs_6month_totalrank;
	private Integer returns_abs_ytd_totalrank;
	private Integer returns_abs_1year_totalrank;
	private Integer returns_cmp_2year_totalrank;
	private Integer returns_cmp_3year_totalrank;
	private Integer returns_cmp_4year_totalrank;
	private Integer returns_cmp_5year_totalrank;
	private Integer returns_cmp_10year_totalrank;
	private Integer returns_cmp_inception_totalrank;
	
	@Transient
	private String scheme_amfi_url;
	
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
	public Date getInception_date() {
		return inception_date;
	}
	public void setInception_date(Date inception_date) {
		this.inception_date = inception_date;
	}
	public Date getPrice_date() {
		return price_date;
	}
	public void setPrice_date(Date price_date) {
		this.price_date = price_date;
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
	public String getOpen_or_closed() {
		return open_or_closed;
	}
	public void setOpen_or_closed(String open_or_closed) {
		this.open_or_closed = open_or_closed;
	}
	public double getReturns_abs_7days() {
		return returns_abs_7days;
	}
	public void setReturns_abs_7days(double returns_abs_7days) {
		this.returns_abs_7days = returns_abs_7days;
	}
	public double getReturns_abs_1month() {
		return returns_abs_1month;
	}
	public void setReturns_abs_1month(double returns_abs_1month) {
		this.returns_abs_1month = returns_abs_1month;
	}
	public double getReturns_abs_3month() {
		return returns_abs_3month;
	}
	public void setReturns_abs_3month(double returns_abs_3month) {
		this.returns_abs_3month = returns_abs_3month;
	}
	public double getReturns_abs_6month() {
		return returns_abs_6month;
	}
	public void setReturns_abs_6month(double returns_abs_6month) {
		this.returns_abs_6month = returns_abs_6month;
	}
	public double getReturns_abs_ytd() {
		return returns_abs_ytd;
	}
	public void setReturns_abs_ytd(double returns_abs_ytd) {
		this.returns_abs_ytd = returns_abs_ytd;
	}
	public double getReturns_abs_1year() {
		return returns_abs_1year;
	}
	public void setReturns_abs_1year(double returns_abs_1year) {
		this.returns_abs_1year = returns_abs_1year;
	}
	public double getReturns_cmp_2year() {
		return returns_cmp_2year;
	}
	public void setReturns_cmp_2year(double returns_cmp_2year) {
		this.returns_cmp_2year = returns_cmp_2year;
	}
	public double getReturns_cmp_3year() {
		return returns_cmp_3year;
	}
	public void setReturns_cmp_3year(double returns_cmp_3year) {
		this.returns_cmp_3year = returns_cmp_3year;
	}
	public double getReturns_cmp_4year() {
		return returns_cmp_4year;
	}
	public void setReturns_cmp_4year(double returns_cmp_4year) {
		this.returns_cmp_4year = returns_cmp_4year;
	}
	public double getReturns_cmp_5year() {
		return returns_cmp_5year;
	}
	public void setReturns_cmp_5year(double returns_cmp_5year) {
		this.returns_cmp_5year = returns_cmp_5year;
	}
	public double getReturns_cmp_10year() {
		return returns_cmp_10year;
	}
	public void setReturns_cmp_10year(double returns_cmp_10year) {
		this.returns_cmp_10year = returns_cmp_10year;
	}
	public double getReturns_cmp_inception() {
		return returns_cmp_inception;
	}
	public void setReturns_cmp_inception(double returns_cmp_inception) {
		this.returns_cmp_inception = returns_cmp_inception;
	}
	public double getReturns_abs_2010() {
		return returns_abs_2010;
	}
	public void setReturns_abs_2010(double returns_abs_2010) {
		this.returns_abs_2010 = returns_abs_2010;
	}
	public double getReturns_abs_2011() {
		return returns_abs_2011;
	}
	public void setReturns_abs_2011(double returns_abs_2011) {
		this.returns_abs_2011 = returns_abs_2011;
	}
	public double getReturns_abs_2012() {
		return returns_abs_2012;
	}
	public void setReturns_abs_2012(double returns_abs_2012) {
		this.returns_abs_2012 = returns_abs_2012;
	}
	public double getReturns_abs_2013() {
		return returns_abs_2013;
	}
	public void setReturns_abs_2013(double returns_abs_2013) {
		this.returns_abs_2013 = returns_abs_2013;
	}
	public double getReturns_abs_2014() {
		return returns_abs_2014;
	}
	public void setReturns_abs_2014(double returns_abs_2014) {
		this.returns_abs_2014 = returns_abs_2014;
	}
	public double getTer() {
		return ter;
	}
	public void setTer(double ter) {
		this.ter = ter;
	}
	public Date getTer_date() {
		return ter_date;
	}
	public void setTer_date(Date ter_date) {
		this.ter_date = ter_date;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getPrice_change_onday() {
		return price_change_onday;
	}
	public void setPrice_change_onday(double price_change_onday) {
		this.price_change_onday = price_change_onday;
	}
	public double getPrice_change_percent_onday() {
		return price_change_percent_onday;
	}
	public void setPrice_change_percent_onday(double price_change_percent_onday) {
		this.price_change_percent_onday = price_change_percent_onday;
	}
	public String getScheme_company() {
		return scheme_company;
	}
	public void setScheme_company(String scheme_company) {
		this.scheme_company = scheme_company;
	}
	public String getScheme_asset_date() {
		return scheme_asset_date;
	}
	public void setScheme_asset_date(String scheme_asset_date) {
		this.scheme_asset_date = scheme_asset_date;
	}
	public double getScheme_assets() {
		return scheme_assets;
	}
	public void setScheme_assets(double scheme_assets) {
		this.scheme_assets = scheme_assets;
	}
	public String getNav_table() {
		return nav_table;
	}
	public void setNav_table(String nav_table) {
		this.nav_table = nav_table;
	}
	public double getReturns_abs_2007() {
		return returns_abs_2007;
	}
	public void setReturns_abs_2007(double returns_abs_2007) {
		this.returns_abs_2007 = returns_abs_2007;
	}
	public double getReturns_abs_2008() {
		return returns_abs_2008;
	}
	public void setReturns_abs_2008(double returns_abs_2008) {
		this.returns_abs_2008 = returns_abs_2008;
	}
	public double getReturns_abs_2009() {
		return returns_abs_2009;
	}
	public void setReturns_abs_2009(double returns_abs_2009) {
		this.returns_abs_2009 = returns_abs_2009;
	}
	public double getReturns_abs_2015() {
		return returns_abs_2015;
	}
	public void setReturns_abs_2015(double returns_abs_2015) {
		this.returns_abs_2015 = returns_abs_2015;
	}
	public double getReturns_abs_2016() {
		return returns_abs_2016;
	}
	public void setReturns_abs_2016(double returns_abs_2016) {
		this.returns_abs_2016 = returns_abs_2016;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getEtf_scheme() {
		return etf_scheme;
	}
	public void setEtf_scheme(Integer etf_scheme) {
		this.etf_scheme = etf_scheme;
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
	public String getIsin_sweep_no() {
		return isin_sweep_no;
	}
	public void setIsin_sweep_no(String isin_sweep_no) {
		this.isin_sweep_no = isin_sweep_no;
	}
	public Integer getReturns_abs_7days_rank() {
		return returns_abs_7days_rank;
	}
	public void setReturns_abs_7days_rank(Integer returns_abs_7days_rank) {
		this.returns_abs_7days_rank = returns_abs_7days_rank;
	}
	public Integer getReturns_abs_1month_rank() {
		return returns_abs_1month_rank;
	}
	public void setReturns_abs_1month_rank(Integer returns_abs_1month_rank) {
		this.returns_abs_1month_rank = returns_abs_1month_rank;
	}
	public Integer getReturns_abs_3month_rank() {
		return returns_abs_3month_rank;
	}
	public void setReturns_abs_3month_rank(Integer returns_abs_3month_rank) {
		this.returns_abs_3month_rank = returns_abs_3month_rank;
	}
	public Integer getReturns_abs_6month_rank() {
		return returns_abs_6month_rank;
	}
	public void setReturns_abs_6month_rank(Integer returns_abs_6month_rank) {
		this.returns_abs_6month_rank = returns_abs_6month_rank;
	}
	public Integer getReturns_abs_ytd_rank() {
		return returns_abs_ytd_rank;
	}
	public void setReturns_abs_ytd_rank(Integer returns_abs_ytd_rank) {
		this.returns_abs_ytd_rank = returns_abs_ytd_rank;
	}
	public Integer getReturns_abs_1year_rank() {
		return returns_abs_1year_rank;
	}
	public void setReturns_abs_1year_rank(Integer returns_abs_1year_rank) {
		this.returns_abs_1year_rank = returns_abs_1year_rank;
	}
	public Integer getReturns_cmp_2year_rank() {
		return returns_cmp_2year_rank;
	}
	public void setReturns_cmp_2year_rank(Integer returns_cmp_2year_rank) {
		this.returns_cmp_2year_rank = returns_cmp_2year_rank;
	}
	public Integer getReturns_cmp_3year_rank() {
		return returns_cmp_3year_rank;
	}
	public void setReturns_cmp_3year_rank(Integer returns_cmp_3year_rank) {
		this.returns_cmp_3year_rank = returns_cmp_3year_rank;
	}
	public Integer getReturns_cmp_4year_rank() {
		return returns_cmp_4year_rank;
	}
	public void setReturns_cmp_4year_rank(Integer returns_cmp_4year_rank) {
		this.returns_cmp_4year_rank = returns_cmp_4year_rank;
	}
	public Integer getReturns_cmp_5year_rank() {
		return returns_cmp_5year_rank;
	}
	public void setReturns_cmp_5year_rank(Integer returns_cmp_5year_rank) {
		this.returns_cmp_5year_rank = returns_cmp_5year_rank;
	}
	public Integer getReturns_cmp_10year_rank() {
		return returns_cmp_10year_rank;
	}
	public void setReturns_cmp_10year_rank(Integer returns_cmp_10year_rank) {
		this.returns_cmp_10year_rank = returns_cmp_10year_rank;
	}
	public Integer getReturns_cmp_inception_rank() {
		return returns_cmp_inception_rank;
	}
	public void setReturns_cmp_inception_rank(Integer returns_cmp_inception_rank) {
		this.returns_cmp_inception_rank = returns_cmp_inception_rank;
	}
	public Integer getReturns_abs_7days_totalrank() {
		return returns_abs_7days_totalrank;
	}
	public void setReturns_abs_7days_totalrank(Integer returns_abs_7days_totalrank) {
		this.returns_abs_7days_totalrank = returns_abs_7days_totalrank;
	}
	public Integer getReturns_abs_1month_totalrank() {
		return returns_abs_1month_totalrank;
	}
	public void setReturns_abs_1month_totalrank(Integer returns_abs_1month_totalrank) {
		this.returns_abs_1month_totalrank = returns_abs_1month_totalrank;
	}
	public Integer getReturns_abs_3month_totalrank() {
		return returns_abs_3month_totalrank;
	}
	public void setReturns_abs_3month_totalrank(Integer returns_abs_3month_totalrank) {
		this.returns_abs_3month_totalrank = returns_abs_3month_totalrank;
	}
	public Integer getReturns_abs_6month_totalrank() {
		return returns_abs_6month_totalrank;
	}
	public void setReturns_abs_6month_totalrank(Integer returns_abs_6month_totalrank) {
		this.returns_abs_6month_totalrank = returns_abs_6month_totalrank;
	}
	public Integer getReturns_abs_ytd_totalrank() {
		return returns_abs_ytd_totalrank;
	}
	public void setReturns_abs_ytd_totalrank(Integer returns_abs_ytd_totalrank) {
		this.returns_abs_ytd_totalrank = returns_abs_ytd_totalrank;
	}
	public Integer getReturns_abs_1year_totalrank() {
		return returns_abs_1year_totalrank;
	}
	public void setReturns_abs_1year_totalrank(Integer returns_abs_1year_totalrank) {
		this.returns_abs_1year_totalrank = returns_abs_1year_totalrank;
	}
	public Integer getReturns_cmp_2year_totalrank() {
		return returns_cmp_2year_totalrank;
	}
	public void setReturns_cmp_2year_totalrank(Integer returns_cmp_2year_totalrank) {
		this.returns_cmp_2year_totalrank = returns_cmp_2year_totalrank;
	}
	public Integer getReturns_cmp_3year_totalrank() {
		return returns_cmp_3year_totalrank;
	}
	public void setReturns_cmp_3year_totalrank(Integer returns_cmp_3year_totalrank) {
		this.returns_cmp_3year_totalrank = returns_cmp_3year_totalrank;
	}
	public Integer getReturns_cmp_4year_totalrank() {
		return returns_cmp_4year_totalrank;
	}
	public void setReturns_cmp_4year_totalrank(Integer returns_cmp_4year_totalrank) {
		this.returns_cmp_4year_totalrank = returns_cmp_4year_totalrank;
	}
	public Integer getReturns_cmp_5year_totalrank() {
		return returns_cmp_5year_totalrank;
	}
	public void setReturns_cmp_5year_totalrank(Integer returns_cmp_5year_totalrank) {
		this.returns_cmp_5year_totalrank = returns_cmp_5year_totalrank;
	}
	public Integer getReturns_cmp_10year_totalrank() {
		return returns_cmp_10year_totalrank;
	}
	public void setReturns_cmp_10year_totalrank(Integer returns_cmp_10year_totalrank) {
		this.returns_cmp_10year_totalrank = returns_cmp_10year_totalrank;
	}
	public Integer getReturns_cmp_inception_totalrank() {
		return returns_cmp_inception_totalrank;
	}
	public void setReturns_cmp_inception_totalrank(Integer returns_cmp_inception_totalrank) {
		this.returns_cmp_inception_totalrank = returns_cmp_inception_totalrank;
	}
	public String getScheme_amfi_url() {
		return scheme_amfi_url;
	}
	public void setScheme_amfi_url(String scheme_amfi_url) {
		this.scheme_amfi_url = scheme_amfi_url;
	}
	
}
