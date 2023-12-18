package com.dakshin.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "investor_transaction_cams")
public class InvestorTransactionCams 
{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	Integer id;
	String amc_code;
	String folio_no;
	String prodcode;
	String scheme;
	String inv_name;
	String trxntype;
	int trxnno;
	String trxnmode;
	String trxnstat;
	String usercode;
	String usrtrxno;
	Date traddate;
	Date postdate;
	double purprice;
	double units;
	double amount;
	String brokcode;
	String subbrok;
	double brokperc;
	double brokcomm;
	int altfolio;
	Date rep_date;
	String time1;
	String trxnsubtyp;
	String applicatio;
	String trxn_natur;
	double tax;
	double total_tax;
	String te_15h;
	String micr_no;
	String remarks;
	String swflag;
	String old_folio;
	String seq_no;
	String reinvest_f;
	String mult_brok;
	double stt;
	String location;
	String scheme_typ;
	String tax_status;
	double loads;
	String scanrefno;
	String pan;
	int inv_iin;
	String targ_src_s;
	String trxn_type_;
	String ticob_trty;
	String ticob_trno;
	String ticob_post;
	String dp_id;
	double trxn_charg;
	double eligib_amt;
	String src_of_txn;
	String trxn_suffi;
	double siptrxnno;
	String ter_locati;
	String euin;
	String euin_valid;
	String euin_opted;
	String sub_brk_ar;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAmc_code() {
		return amc_code;
	}
	public void setAmc_code(String amc_code) {
		this.amc_code = amc_code;
	}
	public String getFolio_no() {
		return folio_no;
	}
	public void setFolio_no(String folio_no) {
		this.folio_no = folio_no;
	}
	public String getProdcode() {
		return prodcode;
	}
	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}
	public String getScheme() {
		return scheme;
	}
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	public String getInv_name() {
		return inv_name;
	}
	public void setInv_name(String inv_name) {
		this.inv_name = inv_name;
	}
	public String getTrxntype() {
		return trxntype;
	}
	public void setTrxntype(String trxntype) {
		this.trxntype = trxntype;
	}
	public int getTrxnno() {
		return trxnno;
	}
	public void setTrxnno(int trxnno) {
		this.trxnno = trxnno;
	}
	public String getTrxnmode() {
		return trxnmode;
	}
	public void setTrxnmode(String trxnmode) {
		this.trxnmode = trxnmode;
	}
	public String getTrxnstat() {
		return trxnstat;
	}
	public void setTrxnstat(String trxnstat) {
		this.trxnstat = trxnstat;
	}
	public String getUsercode() {
		return usercode;
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	public String getUsrtrxno() {
		return usrtrxno;
	}
	public void setUsrtrxno(String usrtrxno) {
		this.usrtrxno = usrtrxno;
	}
	public Date getTraddate() {
		return traddate;
	}
	public void setTraddate(Date traddate) {
		this.traddate = traddate;
	}
	public Date getPostdate() {
		return postdate;
	}
	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}
	public double getPurprice() {
		return purprice;
	}
	public void setPurprice(double purprice) {
		this.purprice = purprice;
	}
	public double getUnits() {
		return units;
	}
	public void setUnits(double units) {
		this.units = units;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getBrokcode() {
		return brokcode;
	}
	public void setBrokcode(String brokcode) {
		this.brokcode = brokcode;
	}
	public String getSubbrok() {
		return subbrok;
	}
	public void setSubbrok(String subbrok) {
		this.subbrok = subbrok;
	}
	public double getBrokperc() {
		return brokperc;
	}
	public void setBrokperc(double brokperc) {
		this.brokperc = brokperc;
	}
	public double getBrokcomm() {
		return brokcomm;
	}
	public void setBrokcomm(double brokcomm) {
		this.brokcomm = brokcomm;
	}
	public int getAltfolio() {
		return altfolio;
	}
	public void setAltfolio(int altfolio) {
		this.altfolio = altfolio;
	}
	public Date getRep_date() {
		return rep_date;
	}
	public void setRep_date(Date rep_date) {
		this.rep_date = rep_date;
	}
	public String getTime1() {
		return time1;
	}
	public void setTime1(String time1) {
		this.time1 = time1;
	}
	public String getTrxnsubtyp() {
		return trxnsubtyp;
	}
	public void setTrxnsubtyp(String trxnsubtyp) {
		this.trxnsubtyp = trxnsubtyp;
	}
	public String getApplicatio() {
		return applicatio;
	}
	public void setApplicatio(String applicatio) {
		this.applicatio = applicatio;
	}
	public String getTrxn_natur() {
		return trxn_natur;
	}
	public void setTrxn_natur(String trxn_natur) {
		this.trxn_natur = trxn_natur;
	}
	public double getTax() {
		return tax;
	}
	public void setTax(double tax) {
		this.tax = tax;
	}
	public double getTotal_tax() {
		return total_tax;
	}
	public void setTotal_tax(double total_tax) {
		this.total_tax = total_tax;
	}
	public String getTe_15h() {
		return te_15h;
	}
	public void setTe_15h(String te_15h) {
		this.te_15h = te_15h;
	}
	public String getMicr_no() {
		return micr_no;
	}
	public void setMicr_no(String micr_no) {
		this.micr_no = micr_no;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getSwflag() {
		return swflag;
	}
	public void setSwflag(String swflag) {
		this.swflag = swflag;
	}
	public String getOld_folio() {
		return old_folio;
	}
	public void setOld_folio(String old_folio) {
		this.old_folio = old_folio;
	}
	public String getSeq_no() {
		return seq_no;
	}
	public void setSeq_no(String seq_no) {
		this.seq_no = seq_no;
	}
	public String getReinvest_f() {
		return reinvest_f;
	}
	public void setReinvest_f(String reinvest_f) {
		this.reinvest_f = reinvest_f;
	}
	public String getMult_brok() {
		return mult_brok;
	}
	public void setMult_brok(String mult_brok) {
		this.mult_brok = mult_brok;
	}
	public double getStt() {
		return stt;
	}
	public void setStt(double stt) {
		this.stt = stt;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getScheme_typ() {
		return scheme_typ;
	}
	public void setScheme_typ(String scheme_typ) {
		this.scheme_typ = scheme_typ;
	}
	public String getTax_status() {
		return tax_status;
	}
	public void setTax_status(String tax_status) {
		this.tax_status = tax_status;
	}
	public double getLoads() {
		return loads;
	}
	public void setLoads(double loads) {
		this.loads = loads;
	}
	public String getScanrefno() {
		return scanrefno;
	}
	public void setScanrefno(String scanrefno) {
		this.scanrefno = scanrefno;
	}
	public String getPan() {
		return pan;
	}
	public void setPan(String pan) {
		this.pan = pan;
	}
	public int getInv_iin() {
		return inv_iin;
	}
	public void setInv_iin(int inv_iin) {
		this.inv_iin = inv_iin;
	}
	public String getTarg_src_s() {
		return targ_src_s;
	}
	public void setTarg_src_s(String targ_src_s) {
		this.targ_src_s = targ_src_s;
	}
	public String getTrxn_type_() {
		return trxn_type_;
	}
	public void setTrxn_type_(String trxn_type_) {
		this.trxn_type_ = trxn_type_;
	}
	public String getTicob_trty() {
		return ticob_trty;
	}
	public void setTicob_trty(String ticob_trty) {
		this.ticob_trty = ticob_trty;
	}
	public String getTicob_trno() {
		return ticob_trno;
	}
	public void setTicob_trno(String ticob_trno) {
		this.ticob_trno = ticob_trno;
	}
	public String getTicob_post() {
		return ticob_post;
	}
	public void setTicob_post(String ticob_post) {
		this.ticob_post = ticob_post;
	}
	public String getDp_id() {
		return dp_id;
	}
	public void setDp_id(String dp_id) {
		this.dp_id = dp_id;
	}
	public double getTrxn_charg() {
		return trxn_charg;
	}
	public void setTrxn_charg(double trxn_charg) {
		this.trxn_charg = trxn_charg;
	}
	public double getEligib_amt() {
		return eligib_amt;
	}
	public void setEligib_amt(double eligib_amt) {
		this.eligib_amt = eligib_amt;
	}
	public String getSrc_of_txn() {
		return src_of_txn;
	}
	public void setSrc_of_txn(String src_of_txn) {
		this.src_of_txn = src_of_txn;
	}
	public String getTrxn_suffi() {
		return trxn_suffi;
	}
	public void setTrxn_suffi(String trxn_suffi) {
		this.trxn_suffi = trxn_suffi;
	}
	public double getSiptrxnno() {
		return siptrxnno;
	}
	public void setSiptrxnno(double siptrxnno) {
		this.siptrxnno = siptrxnno;
	}
	public String getTer_locati() {
		return ter_locati;
	}
	public void setTer_locati(String ter_locati) {
		this.ter_locati = ter_locati;
	}
	public String getEuin() {
		return euin;
	}
	public void setEuin(String euin) {
		this.euin = euin;
	}
	public String getEuin_valid() {
		return euin_valid;
	}
	public void setEuin_valid(String euin_valid) {
		this.euin_valid = euin_valid;
	}
	public String getEuin_opted() {
		return euin_opted;
	}
	public void setEuin_opted(String euin_opted) {
		this.euin_opted = euin_opted;
	}
	public String getSub_brk_ar() {
		return sub_brk_ar;
	}
	public void setSub_brk_ar(String sub_brk_ar) {
		this.sub_brk_ar = sub_brk_ar;
	}
}
