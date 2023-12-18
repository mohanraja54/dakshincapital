package com.dakshin.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.dakshin.model.Users;
import com.dakshin.model.UsersGoalSavedPlan;
import com.dakshin.response.InvestorPortfolioResponse;
import com.dakshin.response.RmInvestorResponse;

@Component("CommonDao")
@Transactional
public interface MFCommonDao {

	public InvestorPortfolioResponse getInvestorPortfolio(Integer user_id, String client_name);

	public List<RmInvestorResponse> getFHMappedInvestor(String userid, String client_name); 
	
	public Users getUserDetails(Integer id, String client_name);
	
	public void saveGoalPlan(UsersGoalSavedPlan savePlan);
	
	public List<UsersGoalSavedPlan> getGoalDetails(String user_id, String type); 
}
