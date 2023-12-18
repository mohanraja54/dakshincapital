package com.dakshin.amfi.response;

import java.util.List;

import com.dakshin.amfi.model.SchemeRollingReturns;

public class RollingReturnsMultipleSchemesAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	public List<List<SchemeRollingReturns>> list;
	public List<RollingReturnsSummaryResponse> rollingReturnsTable;
	
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
	public List<List<SchemeRollingReturns>> getList() {
		return list;
	}
	public void setList(List<List<SchemeRollingReturns>> list) {
		this.list = list;
	}
	public List<RollingReturnsSummaryResponse> getRollingReturnsTable() {
		return rollingReturnsTable;
	}
	public void setRollingReturnsTable(
			List<RollingReturnsSummaryResponse> rollingReturnsTable) {
		this.rollingReturnsTable = rollingReturnsTable;
	}
}
