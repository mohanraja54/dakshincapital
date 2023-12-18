package com.dakshin.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "users_goal_saved_plan")
public class UsersGoalSavedPlan {

	private Integer id;
	private String user_id;
	private String name;
	private String pan;
	private String email;
	private String mobile;
	private String goal;
	private String goal_name;
	private String amount;
	private String horizon;
	private String inflation;
	private String risk;
	private String target_amount;
	private String achieved_amount;
	private String sip_amount;
	private String lumpsum_amount;
	private String scheme_array;
	private String category_array;
	private String percentage_array;
	private String amount_array;
	private String existing_folio;
	private String existing_scheme;
	private String existing_scheme_code;
	private String existing_scheme_sip;
	private String existing_scheme_current_value;
	private String auth_code;
	private String age;
	private String retire_age;
	private String life_age;
	private String tax;
	private String type;
	private String online_invest;
	private String client_name;
	private Date created_date;
	  
  	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")  
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGoal() {
		return goal;
	}
	public void setGoal(String goal) {
		this.goal = goal;
	}
	public String getGoal_name() {
		return goal_name;
	}
	public void setGoal_name(String goal_name) {
		this.goal_name = goal_name;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getHorizon() {
		return horizon;
	}
	public void setHorizon(String horizon) {
		this.horizon = horizon;
	}
	public String getInflation() {
		return inflation;
	}
	public void setInflation(String inflation) {
		this.inflation = inflation;
	}
	public String getRisk() {
		return risk;
	}
	public void setRisk(String risk) {
		this.risk = risk;
	}
	public String getTarget_amount() {
		return target_amount;
	}
	public void setTarget_amount(String target_amount) {
		this.target_amount = target_amount;
	}
	public String getSip_amount() {
		return sip_amount;
	}
	public void setSip_amount(String sip_amount) {
		this.sip_amount = sip_amount;
	}
	public String getScheme_array() {
		return scheme_array;
	}
	public void setScheme_array(String scheme_array) {
		this.scheme_array = scheme_array;
	}
	public String getCategory_array() {
		return category_array;
	}
	public void setCategory_array(String category_array) {
		this.category_array = category_array;
	}
	public String getPercentage_array() {
		return percentage_array;
	}
	public void setPercentage_array(String percentage_array) {
		this.percentage_array = percentage_array;
	}
	public String getAmount_array() {
		return amount_array;
	}
	public void setAmount_array(String amount_array) {
		this.amount_array = amount_array;
	}
	public Date getCreated_date() {
		return created_date;
	}
	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}
	public String getExisting_folio() {
		return existing_folio;
	}
	public void setExisting_folio(String existing_folio) {
		this.existing_folio = existing_folio;
	}
	public String getExisting_scheme() {
		return existing_scheme;
	}
	public void setExisting_scheme(String existing_scheme) {
		this.existing_scheme = existing_scheme;
	}
	public String getAchieved_amount() {
		return achieved_amount;
	}
	public void setAchieved_amount(String achieved_amount) {
		this.achieved_amount = achieved_amount;
	}
	public String getLumpsum_amount() {
		return lumpsum_amount;
	}
	public void setLumpsum_amount(String lumpsum_amount) {
		this.lumpsum_amount = lumpsum_amount;
	}
	public String getExisting_scheme_code() {
		return existing_scheme_code;
	}
	public void setExisting_scheme_code(String existing_scheme_code) {
		this.existing_scheme_code = existing_scheme_code;
	}
	public String getExisting_scheme_sip() {
		return existing_scheme_sip;
	}
	public void setExisting_scheme_sip(String existing_scheme_sip) {
		this.existing_scheme_sip = existing_scheme_sip;
	}
	public String getExisting_scheme_current_value() {
		return existing_scheme_current_value;
	}
	public void setExisting_scheme_current_value(
			String existing_scheme_current_value) {
		this.existing_scheme_current_value = existing_scheme_current_value;
	}
	public String getAuth_code() {
		return auth_code;
	}
	public void setAuth_code(String auth_code) {
		this.auth_code = auth_code;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getTax() {
		return tax;
	}
	public void setTax(String tax) {
		this.tax = tax;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getOnline_invest() {
		return online_invest;
	}
	public void setOnline_invest(String online_invest) {
		this.online_invest = online_invest;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getRetire_age() {
		return retire_age;
	}
	public void setRetire_age(String retire_age) {
		this.retire_age = retire_age;
	}
	public String getLife_age() {
		return life_age;
	}
	public void setLife_age(String life_age) {
		this.life_age = life_age;
	}
	public String getClient_name() {
		return client_name;
	}
	public void setClient_name(String client_name) {
		this.client_name = client_name;
	}
}
