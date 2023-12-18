package com.dakshin.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "transaction_type")
public class TransactionType 
{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	Integer id;
	String registrar;
	String positive_transaction;
	String negative_transaction;
	String neutral_transaction;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRegistrar() {
		return registrar;
	}
	public void setRegistrar(String registrar) {
		this.registrar = registrar;
	}
	public String getPositive_transaction() {
		return positive_transaction;
	}
	public void setPositive_transaction(String positive_transaction) {
		this.positive_transaction = positive_transaction;
	}
	public String getNegative_transaction() {
		return negative_transaction;
	}
	public void setNegative_transaction(String negative_transaction) {
		this.negative_transaction = negative_transaction;
	}
	public String getNeutral_transaction() {
		return neutral_transaction;
	}
	public void setNeutral_transaction(String neutral_transaction) {
		this.neutral_transaction = neutral_transaction;
	}
}
