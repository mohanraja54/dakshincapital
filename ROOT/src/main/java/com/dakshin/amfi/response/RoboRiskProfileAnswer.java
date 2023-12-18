package com.dakshin.amfi.response;

public class RoboRiskProfileAnswer {

	public Integer status;
	public String status_msg;
	public String msg;
	private Integer answer_1;
	private Integer answer_2;
	private Integer answer_3;
	private Integer answer_4;
	private Integer answer_5;
	private Integer answer_6;
	/*private Integer answer_7;
	private Integer answer_8;*/
	private String risk_profile;
	
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
	public Integer getAnswer_1() {
		return answer_1;
	}
	public void setAnswer_1(Integer answer_1) {
		this.answer_1 = answer_1;
	}
	public Integer getAnswer_2() {
		return answer_2;
	}
	public void setAnswer_2(Integer answer_2) {
		this.answer_2 = answer_2;
	}
	public Integer getAnswer_3() {
		return answer_3;
	}
	public void setAnswer_3(Integer answer_3) {
		this.answer_3 = answer_3;
	}
	public Integer getAnswer_4() {
		return answer_4;
	}
	public void setAnswer_4(Integer answer_4) {
		this.answer_4 = answer_4;
	}
	public Integer getAnswer_5() {
		return answer_5;
	}
	public void setAnswer_5(Integer answer_5) {
		this.answer_5 = answer_5;
	}
	public Integer getAnswer_6() {
		return answer_6;
	}
	public void setAnswer_6(Integer answer_6) {
		this.answer_6 = answer_6;
	}
	/*public Integer getAnswer_7() {
		return answer_7;
	}
	public void setAnswer_7(Integer answer_7) {
		this.answer_7 = answer_7;
	}
	public Integer getAnswer_8() {
		return answer_8;
	}
	public void setAnswer_8(Integer answer_8) {
		this.answer_8 = answer_8;
	}*/
	public String getRisk_profile() {
		return risk_profile;
	}
	public void setRisk_profile(String risk_profile) {
		this.risk_profile = risk_profile;
	}
}
