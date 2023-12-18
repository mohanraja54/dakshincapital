package com.dakshin.amfi.response;

import java.util.List;

import com.dakshin.amfi.model.SchemeMapping;

public class HistoricalDividendsResponse {
	
	public Integer status;
	public String status_msg;
	public String msg;
	public String scheme;
	public SchemeMapping schemeMapping;
	public List<DividendHistoryResponse> list;

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
	public String getScheme() {
		return scheme;
	}
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	public SchemeMapping getSchemeMapping() {
		return schemeMapping;
	}
	public void setSchemeMapping(SchemeMapping schemeMapping) {
		this.schemeMapping = schemeMapping;
	}
	public List<DividendHistoryResponse> getList() {
		return list;
	}
	public void setList(List<DividendHistoryResponse> list) {
		this.list = list;
	}
}
