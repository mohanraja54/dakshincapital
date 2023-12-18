package com.dakshin.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "investor_transaction_karvy")
public class InvestorTransactionKarvy 
{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	Integer id;
	String product_code;
	String fund;
	String folio_number;
	String scheme_code;
	String dividend_option;
	String fund_description;
	String transaction_head;
	String transaction_number;
	String switch_ref_no;
	String instrument_number;
	String investor_name;
	String transaction_mode;
	String transaction_status;
	String branch_name;
	String branch_transaction_no;
	Date transaction_date;
	Date process_date;
	Double price;
	Double load_percentage;
	Double units;
	Double amount;
	Double load_amount;
	String agent_code;
	String sub_broker_code;
	String brokerage_percentage;
	String commission;
	String investor_id;
	String report_date;
	String report_time;
	String transaction_sub;
	String application_number;
	String transaction_id;
	String transaction_description;
	String transaction_type;
	Date purchase_date1;
	String purchase_amount;
	String purchase_units;
	String transaction_flag;
	String switch_fund_date;
	String instrument_date;
	String instrument_bank;
	String nav;
	String purchase_transaction_no;
	Double stt;
	String ihno;
	String branch_code;
	String inward_number;
	String remarks;
	String pan1;
	String nct_change_date;
	String status;
	String rejtrnoorgno;
	String clientid;
	String dpid;
	String trcharges;
	String toproductcode;
	String nav_date;
	String portdate;
	String assettype;
	String subtrantype;
	String citycategory;
	String euin;
	String sub_broker_arn_code;
	String pan2;
	String pan3;
	Double tdsamount;
	String scheme;
	String plan;
	String td_trxnmode;
	String atmcardstatus;
	String atmcardremarks;
	String isin;
	String newunqno;
	String euin_valid_indicator;
	String euin_declaration_indicator;
	String sip_regn_date;
	String divper;
   	String isc_trno;
   	String brok_ent_date;
   	String guardian_pan;
   	String can;
   	String exchorg_tr6;
   	String elec_trxnf7;
   	String sip_reg_slno;
   	String cleared;
   	String inv_state;
	String client_name;
	Integer user_id;
	String user_name;
	String branch;
	String rm_name;
	String subbroker_name;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getFund() {
		return fund;
	}
	public void setFund(String fund) {
		this.fund = fund;
	}
	public String getFolio_number() {
		return folio_number;
	}
	public void setFolio_number(String folio_number) {
		this.folio_number = folio_number;
	}
	public String getScheme_code() {
		return scheme_code;
	}
	public void setScheme_code(String scheme_code) {
		this.scheme_code = scheme_code;
	}
	public String getDividend_option() {
		return dividend_option;
	}
	public void setDividend_option(String dividend_option) {
		this.dividend_option = dividend_option;
	}
	public String getFund_description() {
		return fund_description;
	}
	public void setFund_description(String fund_description) {
		this.fund_description = fund_description;
	}
	public String getTransaction_head() {
		return transaction_head;
	}
	public void setTransaction_head(String transaction_head) {
		this.transaction_head = transaction_head;
	}
	public String getTransaction_number() {
		return transaction_number;
	}
	public void setTransaction_number(String transaction_number) {
		this.transaction_number = transaction_number;
	}
	public String getSwitch_ref_no() {
		return switch_ref_no;
	}
	public void setSwitch_ref_no(String switch_ref_no) {
		this.switch_ref_no = switch_ref_no;
	}
	public String getInstrument_number() {
		return instrument_number;
	}
	public void setInstrument_number(String instrument_number) {
		this.instrument_number = instrument_number;
	}
	public String getInvestor_name() {
		return investor_name;
	}
	public void setInvestor_name(String investor_name) {
		this.investor_name = investor_name;
	}
	public String getTransaction_mode() {
		return transaction_mode;
	}
	public void setTransaction_mode(String transaction_mode) {
		this.transaction_mode = transaction_mode;
	}
	public String getTransaction_status() {
		return transaction_status;
	}
	public void setTransaction_status(String transaction_status) {
		this.transaction_status = transaction_status;
	}
	public String getBranch_name() {
		return branch_name;
	}
	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}
	public String getBranch_transaction_no() {
		return branch_transaction_no;
	}
	public void setBranch_transaction_no(String branch_transaction_no) {
		this.branch_transaction_no = branch_transaction_no;
	}
	public Date getTransaction_date() {
		return transaction_date;
	}
	public void setTransaction_date(Date transaction_date) {
		this.transaction_date = transaction_date;
	}
	public Date getProcess_date() {
		return process_date;
	}
	public void setProcess_date(Date process_date) {
		this.process_date = process_date;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getLoad_percentage() {
		return load_percentage;
	}
	public void setLoad_percentage(Double load_percentage) {
		this.load_percentage = load_percentage;
	}
	public Double getUnits() {
		return units;
	}
	public void setUnits(Double units) {
		this.units = units;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public Double getLoad_amount() {
		return load_amount;
	}
	public void setLoad_amount(Double load_amount) {
		this.load_amount = load_amount;
	}
	public String getAgent_code() {
		return agent_code;
	}
	public void setAgent_code(String agent_code) {
		this.agent_code = agent_code;
	}
	public String getSub_broker_code() {
		return sub_broker_code;
	}
	public void setSub_broker_code(String sub_broker_code) {
		this.sub_broker_code = sub_broker_code;
	}
	public String getBrokerage_percentage() {
		return brokerage_percentage;
	}
	public void setBrokerage_percentage(String brokerage_percentage) {
		this.brokerage_percentage = brokerage_percentage;
	}
	public String getCommission() {
		return commission;
	}
	public void setCommission(String commission) {
		this.commission = commission;
	}
	public String getInvestor_id() {
		return investor_id;
	}
	public void setInvestor_id(String investor_id) {
		this.investor_id = investor_id;
	}
	public String getReport_date() {
		return report_date;
	}
	public void setReport_date(String report_date) {
		this.report_date = report_date;
	}
	public String getReport_time() {
		return report_time;
	}
	public void setReport_time(String report_time) {
		this.report_time = report_time;
	}
	public String getTransaction_sub() {
		return transaction_sub;
	}
	public void setTransaction_sub(String transaction_sub) {
		this.transaction_sub = transaction_sub;
	}
	public String getApplication_number() {
		return application_number;
	}
	public void setApplication_number(String application_number) {
		this.application_number = application_number;
	}
	public String getTransaction_id() {
		return transaction_id;
	}
	public void setTransaction_id(String transaction_id) {
		this.transaction_id = transaction_id;
	}
	public String getTransaction_description() {
		return transaction_description;
	}
	public void setTransaction_description(String transaction_description) {
		this.transaction_description = transaction_description;
	}
	public String getTransaction_type() {
		return transaction_type;
	}
	public void setTransaction_type(String transaction_type) {
		this.transaction_type = transaction_type;
	}
	public Date getPurchase_date1() {
		return purchase_date1;
	}
	public void setPurchase_date1(Date purchase_date1) {
		this.purchase_date1 = purchase_date1;
	}
	public String getPurchase_amount() {
		return purchase_amount;
	}
	public void setPurchase_amount(String purchase_amount) {
		this.purchase_amount = purchase_amount;
	}
	public String getPurchase_units() {
		return purchase_units;
	}
	public void setPurchase_units(String purchase_units) {
		this.purchase_units = purchase_units;
	}
	public String getTransaction_flag() {
		return transaction_flag;
	}
	public void setTransaction_flag(String transaction_flag) {
		this.transaction_flag = transaction_flag;
	}
	public String getSwitch_fund_date() {
		return switch_fund_date;
	}
	public void setSwitch_fund_date(String switch_fund_date) {
		this.switch_fund_date = switch_fund_date;
	}
	public String getInstrument_date() {
		return instrument_date;
	}
	public void setInstrument_date(String instrument_date) {
		this.instrument_date = instrument_date;
	}
	public String getInstrument_bank() {
		return instrument_bank;
	}
	public void setInstrument_bank(String instrument_bank) {
		this.instrument_bank = instrument_bank;
	}
	public String getNav() {
		return nav;
	}
	public void setNav(String nav) {
		this.nav = nav;
	}
	public String getPurchase_transaction_no() {
		return purchase_transaction_no;
	}
	public void setPurchase_transaction_no(String purchase_transaction_no) {
		this.purchase_transaction_no = purchase_transaction_no;
	}
	public Double getStt() {
		return stt;
	}
	public void setStt(Double stt) {
		this.stt = stt;
	}
	public String getIhno() {
		return ihno;
	}
	public void setIhno(String ihno) {
		this.ihno = ihno;
	}
	public String getBranch_code() {
		return branch_code;
	}
	public void setBranch_code(String branch_code) {
		this.branch_code = branch_code;
	}
	public String getInward_number() {
		return inward_number;
	}
	public void setInward_number(String inward_number) {
		this.inward_number = inward_number;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getPan1() {
		return pan1;
	}
	public void setPan1(String pan1) {
		this.pan1 = pan1;
	}
	public String getNct_change_date() {
		return nct_change_date;
	}
	public void setNct_change_date(String nct_change_date) {
		this.nct_change_date = nct_change_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRejtrnoorgno() {
		return rejtrnoorgno;
	}
	public void setRejtrnoorgno(String rejtrnoorgno) {
		this.rejtrnoorgno = rejtrnoorgno;
	}
	public String getClientid() {
		return clientid;
	}
	public void setClientid(String clientid) {
		this.clientid = clientid;
	}
	public String getDpid() {
		return dpid;
	}
	public void setDpid(String dpid) {
		this.dpid = dpid;
	}
	public String getTrcharges() {
		return trcharges;
	}
	public void setTrcharges(String trcharges) {
		this.trcharges = trcharges;
	}
	public String getToproductcode() {
		return toproductcode;
	}
	public void setToproductcode(String toproductcode) {
		this.toproductcode = toproductcode;
	}
	public String getNav_date() {
		return nav_date;
	}
	public void setNav_date(String nav_date) {
		this.nav_date = nav_date;
	}
	public String getPortdate() {
		return portdate;
	}
	public void setPortdate(String portdate) {
		this.portdate = portdate;
	}
	public String getAssettype() {
		return assettype;
	}
	public void setAssettype(String assettype) {
		this.assettype = assettype;
	}
	public String getSubtrantype() {
		return subtrantype;
	}
	public void setSubtrantype(String subtrantype) {
		this.subtrantype = subtrantype;
	}
	public String getCitycategory() {
		return citycategory;
	}
	public void setCitycategory(String citycategory) {
		this.citycategory = citycategory;
	}
	public String getEuin() {
		return euin;
	}
	public void setEuin(String euin) {
		this.euin = euin;
	}
	public String getSub_broker_arn_code() {
		return sub_broker_arn_code;
	}
	public void setSub_broker_arn_code(String sub_broker_arn_code) {
		this.sub_broker_arn_code = sub_broker_arn_code;
	}
	public String getPan2() {
		return pan2;
	}
	public void setPan2(String pan2) {
		this.pan2 = pan2;
	}
	public String getPan3() {
		return pan3;
	}
	public void setPan3(String pan3) {
		this.pan3 = pan3;
	}
	public Double getTdsamount() {
		return tdsamount;
	}
	public void setTdsamount(Double tdsamount) {
		this.tdsamount = tdsamount;
	}
	public String getScheme() {
		return scheme;
	}
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	public String getPlan() {
		return plan;
	}
	public void setPlan(String plan) {
		this.plan = plan;
	}
	public String getTd_trxnmode() {
		return td_trxnmode;
	}
	public void setTd_trxnmode(String td_trxnmode) {
		this.td_trxnmode = td_trxnmode;
	}
	public String getAtmcardstatus() {
		return atmcardstatus;
	}
	public void setAtmcardstatus(String atmcardstatus) {
		this.atmcardstatus = atmcardstatus;
	}
	public String getAtmcardremarks() {
		return atmcardremarks;
	}
	public void setAtmcardremarks(String atmcardremarks) {
		this.atmcardremarks = atmcardremarks;
	}
	public String getIsin() {
		return isin;
	}
	public void setIsin(String isin) {
		this.isin = isin;
	}
	public String getNewunqno() {
		return newunqno;
	}
	public void setNewunqno(String newunqno) {
		this.newunqno = newunqno;
	}
	public String getEuin_valid_indicator() {
		return euin_valid_indicator;
	}
	public void setEuin_valid_indicator(String euin_valid_indicator) {
		this.euin_valid_indicator = euin_valid_indicator;
	}
	public String getEuin_declaration_indicator() {
		return euin_declaration_indicator;
	}
	public void setEuin_declaration_indicator(String euin_declaration_indicator) {
		this.euin_declaration_indicator = euin_declaration_indicator;
	}
	public String getSip_regn_date() {
		return sip_regn_date;
	}
	public void setSip_regn_date(String sip_regn_date) {
		this.sip_regn_date = sip_regn_date;
	}
	public String getDivper() {
		return divper;
	}
	public void setDivper(String divper) {
		this.divper = divper;
	}
	public String getClient_name() {
		return client_name;
	}
	public void setClient_name(String client_name) {
		this.client_name = client_name;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public String getRm_name() {
		return rm_name;
	}
	public void setRm_name(String rm_name) {
		this.rm_name = rm_name;
	}
	public String getSubbroker_name() {
		return subbroker_name;
	}
	public void setSubbroker_name(String subbroker_name) {
		this.subbroker_name = subbroker_name;
	}
	public String getIsc_trno() {
		return isc_trno;
	}
	public void setIsc_trno(String isc_trno) {
		this.isc_trno = isc_trno;
	}
	public String getBrok_ent_date() {
		return brok_ent_date;
	}
	public void setBrok_ent_date(String brok_ent_date) {
		this.brok_ent_date = brok_ent_date;
	}
	public String getGuardian_pan() {
		return guardian_pan;
	}
	public void setGuardian_pan(String guardian_pan) {
		this.guardian_pan = guardian_pan;
	}
	public String getCan() {
		return can;
	}
	public void setCan(String can) {
		this.can = can;
	}
	public String getExchorg_tr6() {
		return exchorg_tr6;
	}
	public void setExchorg_tr6(String exchorg_tr6) {
		this.exchorg_tr6 = exchorg_tr6;
	}
	public String getElec_trxnf7() {
		return elec_trxnf7;
	}
	public void setElec_trxnf7(String elec_trxnf7) {
		this.elec_trxnf7 = elec_trxnf7;
	}
	public String getSip_reg_slno() {
		return sip_reg_slno;
	}
	public void setSip_reg_slno(String sip_reg_slno) {
		this.sip_reg_slno = sip_reg_slno;
	}
	public String getCleared() {
		return cleared;
	}
	public void setCleared(String cleared) {
		this.cleared = cleared;
	}
	public String getInv_state() {
		return inv_state;
	}
	public void setInv_state(String inv_state) {
		this.inv_state = inv_state;
	}
}