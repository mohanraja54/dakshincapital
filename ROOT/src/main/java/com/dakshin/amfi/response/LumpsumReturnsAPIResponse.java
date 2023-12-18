package com.dakshin.amfi.response;

import java.util.List;

public class LumpsumReturnsAPIResponse {

	public Integer status;
	public String status_msg;
	public String msg;
	
	public String scheme;
	public List<SIPSchemePerformanceResponse> schemePerformance_list;
	
	public String result;
	public List <LumpsumReturnsAPIGraphResponse> graph_list ;
	
	public String lumpSumReturnsGraphData;
	public String scheme_benchmark_code;
	public String scheme_benchmark_name;
	public SIPSchemePerformanceResponse sipSchemePerformanceResponse;

	public List<SIPSchemePerformanceResponse> getSchemePerformance_list() {
		return schemePerformance_list;
	}
	public void setSchemePerformance_list(List<SIPSchemePerformanceResponse> schemePerformance_list) {
		this.schemePerformance_list = schemePerformance_list;
	}
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
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public List<LumpsumReturnsAPIGraphResponse> getGraph_list() {
		return graph_list;
	}
	public void setGraph_list(List<LumpsumReturnsAPIGraphResponse> graph_list) {
		this.graph_list = graph_list;
	}
	public String getScheme_benchmark_code() {
		return scheme_benchmark_code;
	}
	public void setScheme_benchmark_code(String scheme_benchmark_code) {
		this.scheme_benchmark_code = scheme_benchmark_code;
	}
	public String getScheme_benchmark_name() {
		return scheme_benchmark_name;
	}
	public void setScheme_benchmark_name(String scheme_benchmark_name) {
		this.scheme_benchmark_name = scheme_benchmark_name;
	}
	public String getScheme() {
		return scheme;
	}
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	public String getLumpSumReturnsGraphData() {
		return lumpSumReturnsGraphData;
	}
	public void setLumpSumReturnsGraphData(String lumpSumReturnsGraphData) {
		this.lumpSumReturnsGraphData = lumpSumReturnsGraphData;
	}
	public SIPSchemePerformanceResponse getSipSchemePerformanceResponse() {
		return sipSchemePerformanceResponse;
	}
	public void setSipSchemePerformanceResponse(SIPSchemePerformanceResponse sipSchemePerformanceResponse) {
		this.sipSchemePerformanceResponse = sipSchemePerformanceResponse;
	}
}
