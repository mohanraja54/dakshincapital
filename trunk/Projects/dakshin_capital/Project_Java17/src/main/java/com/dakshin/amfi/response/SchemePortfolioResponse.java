package com.dakshin.amfi.response;

import java.util.Map;

public class SchemePortfolioResponse {
	
	private Integer status;
	private String status_msg;
	private String msg;
	private Map<String, Double> stocksMap;
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getStatus_msg() {
		return status_msg;
	}
	public void setStatus_msg(String status_msg) {
		this.status_msg = status_msg;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Double> getStocksMap() {
		return stocksMap;
	}
	public void setStocksMap(Map<String, Double> stocksMap) {
		this.stocksMap = stocksMap;
	}
}
