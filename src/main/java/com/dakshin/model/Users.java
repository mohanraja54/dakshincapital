package com.dakshin.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "users")
public class Users 
{
	private Integer id;
	private String name;
	private String pan;
	private String mobile;
	private String email;
	private Integer type_id;
	private String rm_name;
	private String subbroker_name;
	private String payout;
	private Integer active;
	private String user_password;
	private String user_pass;
	
	private String street_1;
	private String street_2;
	private String street_3;
	private String city;
	private String pincode;
	private String state;
	private String state_code;
	private String country;
	private String father_name;
	private String gender;
	private String date_of_birth;
	private String marital_status;
	private String place_of_birth;
	private String country_of_birth;
	private String country_birth_code;
	private String phone_office;
	private String phone_residence;
	private String resident_status;
	
	private String tax_status;
	private String tax_status_code;
	private String holding_nature;
	private String holding_nature_code;
	private String occupation;
	private String occupation_code;
	private String annual_income;
	private String annual_income_code;
	private String source_of_wealth;
	private String source_of_wealth_code;
	private String political;
	private String political_code;
	private String networth_amount;
	private String networth_dob;
	private String address_type;
	private String address_type_code;
	
	private String guard_name;
	private String guard_pan;
	private String guard_dob;
	private String guard_mobile;
	private String guard_email;
	private String guard_relationship;
	
	private String joint_holder_name1;
	private String joint_holder_pan1;
	private String joint_holder_dob1;
	private String joint_holder_email1;
	private String joint_holder_mobile1;
	private String joint_holder_signature1;
	private String joint_holder_name2;
	private String joint_holder_pan2;
	private String joint_holder_dob2;
	private String joint_holder_email2;
	private String joint_holder_mobile2;
	private String joint_holder_signature2;
	private String nri_address1;
	private String nri_address2;
	private String nri_address3;
	private String nri_city;
	private String nri_pincode;
	private String nri_state;
	private String nri_country;
	
	private String bank_code1;
	private String bank_mode1;
	private String bank_name1;
	private String bank_branch1;
	private String bank_address1;
	private String bank_account_number1;
	private String bank_account_holder_name1;
	private String bank_account_type1;
	private String bank_ifsc_code1;
	private String bank_micr_code1;
	private String default_bank1;
	
	private String bank_code2;
	private String bank_mode2;
	private String bank_name2;
	private String bank_branch2;
	private String bank_address2;
	private String bank_account_number2;
	private String bank_account_holder_name2;
	private String bank_account_type2;
	private String bank_ifsc_code2;
	private String bank_micr_code2;
	private String default_bank2;
	
	private String bank_code3;
	private String bank_mode3;
	private String bank_name3;
	private String bank_branch3;
	private String bank_address3;
	private String bank_account_number3;
	private String bank_account_holder_name3;
	private String bank_account_type3;
	private String bank_ifsc_code3;
	private String bank_micr_code3;
	private String default_bank3;
	
	private Integer email_verified;
	private String email_authcode;
	private Integer mobile_verified;
	private String mobile_otp;
	private Integer bse_customer;
	private Integer bse_active;
	private String bse_client_code;
	private Integer bse_steps_completed;
	private Integer bse_investor_info;
	private Integer bse_contact_info;
	private Integer bse_bank_info;
	private Integer bse_nominee_info;
	private Integer bse_signature_info;
	private String bse_signature;
	private String bse_chequeleaf; 
	private String bse_client_type;
	
	private String aadhaar;
	private String broker_code;
	private String client_name;
	private Date created_date;
	
	private String user_risk;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPan() {
		return pan;
	}
	public void setPan(String pan) {
		this.pan = pan;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getType_id() {
		return type_id;
	}
	public void setType_id(Integer type_id) {
		this.type_id = type_id;
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
	public String getPayout() {
		return payout;
	}
	public void setPayout(String payout) {
		this.payout = payout;
	}
	public Integer getActive() {
		return active;
	}
	public void setActive(Integer active) {
		this.active = active;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getUser_pass() {
		return user_pass;
	}
	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}
	public String getStreet_1() {
		return street_1;
	}
	public void setStreet_1(String street_1) {
		this.street_1 = street_1;
	}
	public String getStreet_2() {
		return street_2;
	}
	public void setStreet_2(String street_2) {
		this.street_2 = street_2;
	}
	public String getStreet_3() {
		return street_3;
	}
	public void setStreet_3(String street_3) {
		this.street_3 = street_3;
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
	public String getState_code() {
		return state_code;
	}
	public void setState_code(String state_code) {
		this.state_code = state_code;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getFather_name() {
		return father_name;
	}
	public void setFather_name(String father_name) {
		this.father_name = father_name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getDate_of_birth() {
		return date_of_birth;
	}
	public void setDate_of_birth(String date_of_birth) {
		this.date_of_birth = date_of_birth;
	}
	public String getMarital_status() {
		return marital_status;
	}
	public void setMarital_status(String marital_status) {
		this.marital_status = marital_status;
	}
	public String getPlace_of_birth() {
		return place_of_birth;
	}
	public void setPlace_of_birth(String place_of_birth) {
		this.place_of_birth = place_of_birth;
	}
	public String getCountry_of_birth() {
		return country_of_birth;
	}
	public void setCountry_of_birth(String country_of_birth) {
		this.country_of_birth = country_of_birth;
	}
	public String getCountry_birth_code() {
		return country_birth_code;
	}
	public void setCountry_birth_code(String country_birth_code) {
		this.country_birth_code = country_birth_code;
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
	public String getResident_status() {
		return resident_status;
	}
	public void setResident_status(String resident_status) {
		this.resident_status = resident_status;
	}
	public String getTax_status() {
		return tax_status;
	}
	public void setTax_status(String tax_status) {
		this.tax_status = tax_status;
	}
	public String getTax_status_code() {
		return tax_status_code;
	}
	public void setTax_status_code(String tax_status_code) {
		this.tax_status_code = tax_status_code;
	}
	public String getHolding_nature() {
		return holding_nature;
	}
	public void setHolding_nature(String holding_nature) {
		this.holding_nature = holding_nature;
	}
	public String getHolding_nature_code() {
		return holding_nature_code;
	}
	public void setHolding_nature_code(String holding_nature_code) {
		this.holding_nature_code = holding_nature_code;
	}
	public String getOccupation() {
		return occupation;
	}
	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}
	public String getOccupation_code() {
		return occupation_code;
	}
	public void setOccupation_code(String occupation_code) {
		this.occupation_code = occupation_code;
	}
	public String getAnnual_income() {
		return annual_income;
	}
	public void setAnnual_income(String annual_income) {
		this.annual_income = annual_income;
	}
	public String getAnnual_income_code() {
		return annual_income_code;
	}
	public void setAnnual_income_code(String annual_income_code) {
		this.annual_income_code = annual_income_code;
	}
	public String getSource_of_wealth() {
		return source_of_wealth;
	}
	public void setSource_of_wealth(String source_of_wealth) {
		this.source_of_wealth = source_of_wealth;
	}
	public String getSource_of_wealth_code() {
		return source_of_wealth_code;
	}
	public void setSource_of_wealth_code(String source_of_wealth_code) {
		this.source_of_wealth_code = source_of_wealth_code;
	}
	public String getPolitical() {
		return political;
	}
	public void setPolitical(String political) {
		this.political = political;
	}
	public String getPolitical_code() {
		return political_code;
	}
	public void setPolitical_code(String political_code) {
		this.political_code = political_code;
	}
	public String getNetworth_amount() {
		return networth_amount;
	}
	public void setNetworth_amount(String networth_amount) {
		this.networth_amount = networth_amount;
	}
	public String getNetworth_dob() {
		return networth_dob;
	}
	public void setNetworth_dob(String networth_dob) {
		this.networth_dob = networth_dob;
	}
	public String getAddress_type() {
		return address_type;
	}
	public void setAddress_type(String address_type) {
		this.address_type = address_type;
	}
	public String getAddress_type_code() {
		return address_type_code;
	}
	public void setAddress_type_code(String address_type_code) {
		this.address_type_code = address_type_code;
	}
	public String getGuard_name() {
		return guard_name;
	}
	public void setGuard_name(String guard_name) {
		this.guard_name = guard_name;
	}
	public String getGuard_pan() {
		return guard_pan;
	}
	public void setGuard_pan(String guard_pan) {
		this.guard_pan = guard_pan;
	}
	public String getGuard_dob() {
		return guard_dob;
	}
	public void setGuard_dob(String guard_dob) {
		this.guard_dob = guard_dob;
	}
	public String getGuard_mobile() {
		return guard_mobile;
	}
	public void setGuard_mobile(String guard_mobile) {
		this.guard_mobile = guard_mobile;
	}
	public String getGuard_email() {
		return guard_email;
	}
	public void setGuard_email(String guard_email) {
		this.guard_email = guard_email;
	}
	public String getGuard_relationship() {
		return guard_relationship;
	}
	public void setGuard_relationship(String guard_relationship) {
		this.guard_relationship = guard_relationship;
	}
	public String getJoint_holder_name1() {
		return joint_holder_name1;
	}
	public void setJoint_holder_name1(String joint_holder_name1) {
		this.joint_holder_name1 = joint_holder_name1;
	}
	public String getJoint_holder_pan1() {
		return joint_holder_pan1;
	}
	public void setJoint_holder_pan1(String joint_holder_pan1) {
		this.joint_holder_pan1 = joint_holder_pan1;
	}
	public String getJoint_holder_dob1() {
		return joint_holder_dob1;
	}
	public void setJoint_holder_dob1(String joint_holder_dob1) {
		this.joint_holder_dob1 = joint_holder_dob1;
	}
	public String getJoint_holder_email1() {
		return joint_holder_email1;
	}
	public void setJoint_holder_email1(String joint_holder_email1) {
		this.joint_holder_email1 = joint_holder_email1;
	}
	public String getJoint_holder_mobile1() {
		return joint_holder_mobile1;
	}
	public void setJoint_holder_mobile1(String joint_holder_mobile1) {
		this.joint_holder_mobile1 = joint_holder_mobile1;
	}
	public String getJoint_holder_signature1() {
		return joint_holder_signature1;
	}
	public void setJoint_holder_signature1(String joint_holder_signature1) {
		this.joint_holder_signature1 = joint_holder_signature1;
	}
	public String getJoint_holder_name2() {
		return joint_holder_name2;
	}
	public void setJoint_holder_name2(String joint_holder_name2) {
		this.joint_holder_name2 = joint_holder_name2;
	}
	public String getJoint_holder_pan2() {
		return joint_holder_pan2;
	}
	public void setJoint_holder_pan2(String joint_holder_pan2) {
		this.joint_holder_pan2 = joint_holder_pan2;
	}
	public String getJoint_holder_dob2() {
		return joint_holder_dob2;
	}
	public void setJoint_holder_dob2(String joint_holder_dob2) {
		this.joint_holder_dob2 = joint_holder_dob2;
	}
	public String getJoint_holder_email2() {
		return joint_holder_email2;
	}
	public void setJoint_holder_email2(String joint_holder_email2) {
		this.joint_holder_email2 = joint_holder_email2;
	}
	public String getJoint_holder_mobile2() {
		return joint_holder_mobile2;
	}
	public void setJoint_holder_mobile2(String joint_holder_mobile2) {
		this.joint_holder_mobile2 = joint_holder_mobile2;
	}
	public String getJoint_holder_signature2() {
		return joint_holder_signature2;
	}
	public void setJoint_holder_signature2(String joint_holder_signature2) {
		this.joint_holder_signature2 = joint_holder_signature2;
	}
	public String getNri_address1() {
		return nri_address1;
	}
	public void setNri_address1(String nri_address1) {
		this.nri_address1 = nri_address1;
	}
	public String getNri_address2() {
		return nri_address2;
	}
	public void setNri_address2(String nri_address2) {
		this.nri_address2 = nri_address2;
	}
	public String getNri_address3() {
		return nri_address3;
	}
	public void setNri_address3(String nri_address3) {
		this.nri_address3 = nri_address3;
	}
	public String getNri_city() {
		return nri_city;
	}
	public void setNri_city(String nri_city) {
		this.nri_city = nri_city;
	}
	public String getNri_pincode() {
		return nri_pincode;
	}
	public void setNri_pincode(String nri_pincode) {
		this.nri_pincode = nri_pincode;
	}
	public String getNri_state() {
		return nri_state;
	}
	public void setNri_state(String nri_state) {
		this.nri_state = nri_state;
	}
	public String getNri_country() {
		return nri_country;
	}
	public void setNri_country(String nri_country) {
		this.nri_country = nri_country;
	}
	public String getBank_code1() {
		return bank_code1;
	}
	public void setBank_code1(String bank_code1) {
		this.bank_code1 = bank_code1;
	}
	public String getBank_mode1() {
		return bank_mode1;
	}
	public void setBank_mode1(String bank_mode1) {
		this.bank_mode1 = bank_mode1;
	}
	public String getBank_name1() {
		return bank_name1;
	}
	public void setBank_name1(String bank_name1) {
		this.bank_name1 = bank_name1;
	}
	public String getBank_branch1() {
		return bank_branch1;
	}
	public void setBank_branch1(String bank_branch1) {
		this.bank_branch1 = bank_branch1;
	}
	public String getBank_address1() {
		return bank_address1;
	}
	public void setBank_address1(String bank_address1) {
		this.bank_address1 = bank_address1;
	}
	public String getBank_account_number1() {
		return bank_account_number1;
	}
	public void setBank_account_number1(String bank_account_number1) {
		this.bank_account_number1 = bank_account_number1;
	}
	public String getBank_account_holder_name1() {
		return bank_account_holder_name1;
	}
	public void setBank_account_holder_name1(String bank_account_holder_name1) {
		this.bank_account_holder_name1 = bank_account_holder_name1;
	}
	public String getBank_account_type1() {
		return bank_account_type1;
	}
	public void setBank_account_type1(String bank_account_type1) {
		this.bank_account_type1 = bank_account_type1;
	}
	public String getBank_ifsc_code1() {
		return bank_ifsc_code1;
	}
	public void setBank_ifsc_code1(String bank_ifsc_code1) {
		this.bank_ifsc_code1 = bank_ifsc_code1;
	}
	public String getBank_micr_code1() {
		return bank_micr_code1;
	}
	public void setBank_micr_code1(String bank_micr_code1) {
		this.bank_micr_code1 = bank_micr_code1;
	}
	public String getDefault_bank1() {
		return default_bank1;
	}
	public void setDefault_bank1(String default_bank1) {
		this.default_bank1 = default_bank1;
	}
	public String getBank_code2() {
		return bank_code2;
	}
	public void setBank_code2(String bank_code2) {
		this.bank_code2 = bank_code2;
	}
	public String getBank_mode2() {
		return bank_mode2;
	}
	public void setBank_mode2(String bank_mode2) {
		this.bank_mode2 = bank_mode2;
	}
	public String getBank_name2() {
		return bank_name2;
	}
	public void setBank_name2(String bank_name2) {
		this.bank_name2 = bank_name2;
	}
	public String getBank_branch2() {
		return bank_branch2;
	}
	public void setBank_branch2(String bank_branch2) {
		this.bank_branch2 = bank_branch2;
	}
	public String getBank_address2() {
		return bank_address2;
	}
	public void setBank_address2(String bank_address2) {
		this.bank_address2 = bank_address2;
	}
	public String getBank_account_number2() {
		return bank_account_number2;
	}
	public void setBank_account_number2(String bank_account_number2) {
		this.bank_account_number2 = bank_account_number2;
	}
	public String getBank_account_holder_name2() {
		return bank_account_holder_name2;
	}
	public void setBank_account_holder_name2(String bank_account_holder_name2) {
		this.bank_account_holder_name2 = bank_account_holder_name2;
	}
	public String getBank_account_type2() {
		return bank_account_type2;
	}
	public void setBank_account_type2(String bank_account_type2) {
		this.bank_account_type2 = bank_account_type2;
	}
	public String getBank_ifsc_code2() {
		return bank_ifsc_code2;
	}
	public void setBank_ifsc_code2(String bank_ifsc_code2) {
		this.bank_ifsc_code2 = bank_ifsc_code2;
	}
	public String getBank_micr_code2() {
		return bank_micr_code2;
	}
	public void setBank_micr_code2(String bank_micr_code2) {
		this.bank_micr_code2 = bank_micr_code2;
	}
	public String getDefault_bank2() {
		return default_bank2;
	}
	public void setDefault_bank2(String default_bank2) {
		this.default_bank2 = default_bank2;
	}
	public String getBank_code3() {
		return bank_code3;
	}
	public void setBank_code3(String bank_code3) {
		this.bank_code3 = bank_code3;
	}
	public String getBank_mode3() {
		return bank_mode3;
	}
	public void setBank_mode3(String bank_mode3) {
		this.bank_mode3 = bank_mode3;
	}
	public String getBank_name3() {
		return bank_name3;
	}
	public void setBank_name3(String bank_name3) {
		this.bank_name3 = bank_name3;
	}
	public String getBank_branch3() {
		return bank_branch3;
	}
	public void setBank_branch3(String bank_branch3) {
		this.bank_branch3 = bank_branch3;
	}
	public String getBank_address3() {
		return bank_address3;
	}
	public void setBank_address3(String bank_address3) {
		this.bank_address3 = bank_address3;
	}
	public String getBank_account_number3() {
		return bank_account_number3;
	}
	public void setBank_account_number3(String bank_account_number3) {
		this.bank_account_number3 = bank_account_number3;
	}
	public String getBank_account_holder_name3() {
		return bank_account_holder_name3;
	}
	public void setBank_account_holder_name3(String bank_account_holder_name3) {
		this.bank_account_holder_name3 = bank_account_holder_name3;
	}
	public String getBank_account_type3() {
		return bank_account_type3;
	}
	public void setBank_account_type3(String bank_account_type3) {
		this.bank_account_type3 = bank_account_type3;
	}
	public String getBank_ifsc_code3() {
		return bank_ifsc_code3;
	}
	public void setBank_ifsc_code3(String bank_ifsc_code3) {
		this.bank_ifsc_code3 = bank_ifsc_code3;
	}
	public String getBank_micr_code3() {
		return bank_micr_code3;
	}
	public void setBank_micr_code3(String bank_micr_code3) {
		this.bank_micr_code3 = bank_micr_code3;
	}
	public String getDefault_bank3() {
		return default_bank3;
	}
	public void setDefault_bank3(String default_bank3) {
		this.default_bank3 = default_bank3;
	}
	public Integer getEmail_verified() {
		return email_verified;
	}
	public void setEmail_verified(Integer email_verified) {
		this.email_verified = email_verified;
	}
	public String getEmail_authcode() {
		return email_authcode;
	}
	public void setEmail_authcode(String email_authcode) {
		this.email_authcode = email_authcode;
	}
	public Integer getMobile_verified() {
		return mobile_verified;
	}
	public void setMobile_verified(Integer mobile_verified) {
		this.mobile_verified = mobile_verified;
	}
	public String getMobile_otp() {
		return mobile_otp;
	}
	public void setMobile_otp(String mobile_otp) {
		this.mobile_otp = mobile_otp;
	}
	public Integer getBse_customer() {
		return bse_customer;
	}
	public void setBse_customer(Integer bse_customer) {
		this.bse_customer = bse_customer;
	}
	public Integer getBse_active() {
		return bse_active;
	}
	public void setBse_active(Integer bse_active) {
		this.bse_active = bse_active;
	}
	public String getBse_client_code() {
		return bse_client_code;
	}
	public void setBse_client_code(String bse_client_code) {
		this.bse_client_code = bse_client_code;
	}
	public Integer getBse_steps_completed() {
		return bse_steps_completed;
	}
	public void setBse_steps_completed(Integer bse_steps_completed) {
		this.bse_steps_completed = bse_steps_completed;
	}
	public Integer getBse_investor_info() {
		return bse_investor_info;
	}
	public void setBse_investor_info(Integer bse_investor_info) {
		this.bse_investor_info = bse_investor_info;
	}
	public Integer getBse_contact_info() {
		return bse_contact_info;
	}
	public void setBse_contact_info(Integer bse_contact_info) {
		this.bse_contact_info = bse_contact_info;
	}
	public Integer getBse_bank_info() {
		return bse_bank_info;
	}
	public void setBse_bank_info(Integer bse_bank_info) {
		this.bse_bank_info = bse_bank_info;
	}
	public Integer getBse_nominee_info() {
		return bse_nominee_info;
	}
	public void setBse_nominee_info(Integer bse_nominee_info) {
		this.bse_nominee_info = bse_nominee_info;
	}
	public Integer getBse_signature_info() {
		return bse_signature_info;
	}
	public void setBse_signature_info(Integer bse_signature_info) {
		this.bse_signature_info = bse_signature_info;
	}
	public String getBse_signature() {
		return bse_signature;
	}
	public void setBse_signature(String bse_signature) {
		this.bse_signature = bse_signature;
	}
	public String getBse_chequeleaf() {
		return bse_chequeleaf;
	}
	public void setBse_chequeleaf(String bse_chequeleaf) {
		this.bse_chequeleaf = bse_chequeleaf;
	}
	public String getBse_client_type() {
		return bse_client_type;
	}
	public void setBse_client_type(String bse_client_type) {
		this.bse_client_type = bse_client_type;
	}
	public String getAadhaar() {
		return aadhaar;
	}
	public void setAadhaar(String aadhaar) {
		this.aadhaar = aadhaar;
	}
	public String getBroker_code() {
		return broker_code;
	}
	public void setBroker_code(String broker_code) {
		this.broker_code = broker_code;
	}
	public String getClient_name() {
		return client_name;
	}
	public void setClient_name(String client_name) {
		this.client_name = client_name;
	}
	public Date getCreated_date() {
		return created_date;
	}
	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}
	public String getUser_risk() {
		return user_risk;
	}
	public void setUser_risk(String user_risk) {
		this.user_risk = user_risk;
	}
}
