package com.dakshin.amfi.response;

import com.dakshin.amfi.model.SchemeAssets;

public class SchemePortfolioAnalysisApiResponse {
	
	public Integer status;
	public String status_msg;
	public String msg;
	private SchemeAssets schemeAssets;
	private SchemePortfolioAnalysisResponse schemePortfolioAnalysisResponse;
	
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
	public SchemeAssets getSchemeAssets() {
		return schemeAssets;
	}
	public void setSchemeAssets(SchemeAssets schemeAssets) {
		this.schemeAssets = schemeAssets;
	}
	public SchemePortfolioAnalysisResponse getSchemePortfolioAnalysisResponse() {
		return schemePortfolioAnalysisResponse;
	}
	public void setSchemePortfolioAnalysisResponse(
			SchemePortfolioAnalysisResponse schemePortfolioAnalysisResponse) {
		this.schemePortfolioAnalysisResponse = schemePortfolioAnalysisResponse;
	}
}
