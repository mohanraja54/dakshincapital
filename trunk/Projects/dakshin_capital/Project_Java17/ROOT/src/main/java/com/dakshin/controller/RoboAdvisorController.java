package com.dakshin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.internal.util.StringHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dakshin.amfi.dao.AmfiApiAccessRepository;
import com.dakshin.amfi.dao.SchemeMappingRepository;
import com.dakshin.amfi.model.SchemePerformances;
import com.dakshin.amfi.model.SchemePerformancesCategory;
import com.dakshin.amfi.response.CategoryRollingReturnsResponse;
import com.dakshin.amfi.response.MutualFundCategoryMonitorResponse;
import com.dakshin.amfi.response.MutualFundSchemeAPIResponse;
import com.dakshin.amfi.response.RoboRiskProfileAnswer;
import com.dakshin.dao.MFCommonDao;
import com.dakshin.model.Users;
import com.dakshin.model.UsersGoalSavedPlan;
import com.dakshin.response.CommonResponse;
import com.dakshin.response.InvestorPortfolioResponse;
import com.dakshin.response.RmInvestorResponse;
import com.dakshin.utils.HttpPost;
import com.dakshin.utils.MfApiAccessor;
import com.dakshin.utils.MfApiUrls;
import com.dakshin.utils.StatusMessage;
import com.dakshin.utils.UniqueIDProvider;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@SuppressWarnings("unchecked")
@Controller
@RequestMapping(value="/goal")
public class RoboAdvisorController {

	@Autowired
	AmfiApiAccessRepository amfiApiAccessRepository;
	
	@Autowired
	MFCommonDao commonDao;
	
	@Autowired
	SchemeMappingRepository schemeMappingRepository;
	
	@RequestMapping(value="/retirement")
	public String retirement(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{	
		try 
   		{	
	     	String current_age = request.getParameter("current_age");
	     	String retire_age = request.getParameter("retire_age");
	     	String life_age = request.getParameter("life_age");
	     	String expense_amount = request.getParameter("expense_amount");
	     	String savings_amount = request.getParameter("savings_amount");
	     	String inflation = request.getParameter("inflation");
	     	String corpus_return = request.getParameter("corpus_return");
	     	String risk = request.getParameter("risk");
	     	String goal_name = request.getParameter("goal_name");
			
			if(current_age == null){current_age = "";}
			if(retire_age == null){retire_age = "";}
			if(life_age == null){life_age = "";}
			if(expense_amount == null){expense_amount = "";}
			if(savings_amount == null){savings_amount = "";}
			if(inflation == null){inflation = "";}
			if(corpus_return == null){corpus_return = "";}
			if(risk == null){risk = "";}
			if(goal_name == null){goal_name = "";}
			
			request.setAttribute("current_age", current_age);
			request.setAttribute("retire_age", retire_age);
			request.setAttribute("life_age", life_age);
			request.setAttribute("expense_amount", expense_amount);
			request.setAttribute("savings_amount", savings_amount);
			request.setAttribute("inflation", inflation);
			request.setAttribute("corpus_return", corpus_return);
			request.setAttribute("risk", risk);
			request.setAttribute("goal_name", goal_name);
			
			System.out.println("current_age--->"+current_age);
			System.out.println("retire_age--->"+retire_age);
			System.out.println("life_age--->"+life_age);
			System.out.println("expense_amount--->"+expense_amount);
			System.out.println("savings_amount--->"+savings_amount);
			System.out.println("inflation--->"+inflation);
			System.out.println("corpus_return--->"+corpus_return);
			System.out.println("risk--->"+risk);
			System.out.println("goal_name--->"+goal_name);
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
            if(accountMap != null)
            {   
            	String userid = accountMap.get("userid");
            	String pan = accountMap.get("pan");
            	String name = accountMap.get("firstname");
            	String usertypeid = accountMap.get("usertypeid");
            	
            	if(userid == null){userid = "";}
    			if(pan == null){pan = "";}
    			if(name == null){name = "";}
    			if(usertypeid == null){usertypeid = "";}
    			
    			userid = userid.trim();
    			pan = pan.trim();
    			name = name.trim();
    			usertypeid = usertypeid.trim();
    			
    			request.setAttribute("userid", userid);
    			request.setAttribute("pan", pan);
    			request.setAttribute("name", name);
    			
    			String folio_list_str = "";
    			String scheme_code_list_str = "";
    			
    			List<UsersGoalSavedPlan> list = commonDao.getGoalDetails(userid, "Goal Based Robo Advisor");
    			if(list != null && list.size() > 0)
    			{
    				List<String> master_folio_list = new ArrayList<String>();
    				List<String> master_scheme_code_list = new ArrayList<String>();
    				
    				for (UsersGoalSavedPlan usersGoalSavedPlan : list) 
    				{
    					String existing_folio = usersGoalSavedPlan.getExisting_folio();
    					String existing_scheme_code = usersGoalSavedPlan.getExisting_scheme_code();
    					
    					if(StringHelper.isNotEmpty(existing_folio))
    					{
    						List<String> folio_list = new ArrayList<String>(Arrays.asList(existing_folio.split(",")));
        					List<String> scheme_code_list = new ArrayList<String>(Arrays.asList(existing_scheme_code.split(",")));
        					
        					master_folio_list.addAll(folio_list);
        					master_scheme_code_list.addAll(scheme_code_list);
    					}
					}
    				folio_list_str = StringUtils.join(master_folio_list, ',');
    				scheme_code_list_str = StringUtils.join(master_scheme_code_list, ',');
    			}
    			request.setAttribute("goal_list", list);
    			request.setAttribute("folio_list", folio_list_str);
				request.setAttribute("scheme_code_list", scheme_code_list_str);
            }
            
			request.setAttribute("goalType", "retirement");
    		request.setAttribute("subpage", "retirement");
    		request.setAttribute("jsp", "../goals/retirement.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/dream-home")
	public String dream_home(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{	
		try 
   		{	
	     	String amount = request.getParameter("amount");
	     	String inflation = request.getParameter("inflation");
	     	String horizon = request.getParameter("horizon");
	     	String risk = request.getParameter("risk");
	     	String goal_name = request.getParameter("goal_name");
			
			if(amount == null){amount = "";}
			if(inflation == null){inflation = "";}
			if(horizon == null){horizon = "";}
			if(risk == null){risk = "";}
			if(goal_name == null){goal_name = "";}
			
			request.setAttribute("amount", amount);
			request.setAttribute("inflation", inflation);
			request.setAttribute("horizon", horizon);
			request.setAttribute("risk", risk);
			request.setAttribute("goal_name", goal_name);
			
			System.out.println("amount--->"+amount);
			System.out.println("inflation--->"+inflation);
			System.out.println("horizon--->"+horizon);
			System.out.println("risk--->"+risk);
			System.out.println("goal_name--->"+goal_name);
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
            if(accountMap != null)
            {   
            	String userid = accountMap.get("userid");
            	String pan = accountMap.get("pan");
            	String name = accountMap.get("firstname");
            	String usertypeid = accountMap.get("usertypeid");
            	
            	if(userid == null){userid = "";}
    			if(pan == null){pan = "";}
    			if(name == null){name = "";}
    			if(usertypeid == null){usertypeid = "";}
    			
    			userid = userid.trim();
    			pan = pan.trim();
    			name = name.trim();
    			usertypeid = usertypeid.trim();
    			
    			request.setAttribute("userid", userid);
    			request.setAttribute("pan", pan);
    			request.setAttribute("name", name);
    			
    			String folio_list_str = "";
    			String scheme_code_list_str = "";
    			
    			List<UsersGoalSavedPlan> list = commonDao.getGoalDetails(userid, "Goal Based Robo Advisor");
    			if(list != null && list.size() > 0)
    			{
    				List<String> master_folio_list = new ArrayList<String>();
    				List<String> master_scheme_code_list = new ArrayList<String>();
    				
    				for (UsersGoalSavedPlan usersGoalSavedPlan : list) 
    				{
    					String existing_folio = usersGoalSavedPlan.getExisting_folio();
    					String existing_scheme_code = usersGoalSavedPlan.getExisting_scheme_code();
    					
    					if(StringHelper.isNotEmpty(existing_folio))
    					{
    						List<String> folio_list = new ArrayList<String>(Arrays.asList(existing_folio.split(",")));
        					List<String> scheme_code_list = new ArrayList<String>(Arrays.asList(existing_scheme_code.split(",")));
        					
        					master_folio_list.addAll(folio_list);
        					master_scheme_code_list.addAll(scheme_code_list);
    					}
					}
    				folio_list_str = StringUtils.join(master_folio_list, ',');
    				scheme_code_list_str = StringUtils.join(master_scheme_code_list, ',');
    			}
    			request.setAttribute("goal_list", list);
    			request.setAttribute("folio_list", folio_list_str);
				request.setAttribute("scheme_code_list", scheme_code_list_str);
            }
            
			request.setAttribute("goalType", "dream-home");
    		request.setAttribute("subpage", "dream-home");
    		request.setAttribute("jsp", "../goals/dream-home.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/child-education")
	public String child_education(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{	
		try 
   		{	
	     	String amount = request.getParameter("amount");
	     	String inflation = request.getParameter("inflation");
	     	String horizon = request.getParameter("horizon");
	     	String risk = request.getParameter("risk");
	     	String goal_name = request.getParameter("goal_name");
			
			if(amount == null){amount = "";}
			if(inflation == null){inflation = "";}
			if(horizon == null){horizon = "";}
			if(risk == null){risk = "";}
			if(goal_name == null){goal_name = "";}
			
			request.setAttribute("amount", amount);
			request.setAttribute("inflation", inflation);
			request.setAttribute("horizon", horizon);
			request.setAttribute("risk", risk);
			request.setAttribute("goal_name", goal_name);
			
			System.out.println("amount--->"+amount);
			System.out.println("inflation--->"+inflation);
			System.out.println("horizon--->"+horizon);
			System.out.println("risk--->"+risk);
			System.out.println("goal_name--->"+goal_name);
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
            if(accountMap != null)
            {   
            	String userid = accountMap.get("userid");
            	String pan = accountMap.get("pan");
            	String name = accountMap.get("firstname");
            	String usertypeid = accountMap.get("usertypeid");
            	
            	if(userid == null){userid = "";}
    			if(pan == null){pan = "";}
    			if(name == null){name = "";}
    			if(usertypeid == null){usertypeid = "";}
    			
    			userid = userid.trim();
    			pan = pan.trim();
    			name = name.trim();
    			usertypeid = usertypeid.trim();
    			
    			request.setAttribute("userid", userid);
    			request.setAttribute("pan", pan);
    			request.setAttribute("name", name);
    			
    			String folio_list_str = "";
    			String scheme_code_list_str = "";
    			
    			List<UsersGoalSavedPlan> list = commonDao.getGoalDetails(userid, "Goal Based Robo Advisor");
    			if(list != null && list.size() > 0)
    			{
    				List<String> master_folio_list = new ArrayList<String>();
    				List<String> master_scheme_code_list = new ArrayList<String>();
    				
    				for (UsersGoalSavedPlan usersGoalSavedPlan : list) 
    				{
    					String existing_folio = usersGoalSavedPlan.getExisting_folio();
    					String existing_scheme_code = usersGoalSavedPlan.getExisting_scheme_code();
    					
    					if(StringHelper.isNotEmpty(existing_folio))
    					{
    						List<String> folio_list = new ArrayList<String>(Arrays.asList(existing_folio.split(",")));
        					List<String> scheme_code_list = new ArrayList<String>(Arrays.asList(existing_scheme_code.split(",")));
        					
        					master_folio_list.addAll(folio_list);
        					master_scheme_code_list.addAll(scheme_code_list);
    					}
					}
    				folio_list_str = StringUtils.join(master_folio_list, ',');
    				scheme_code_list_str = StringUtils.join(master_scheme_code_list, ',');
    			}
    			request.setAttribute("goal_list", list);
    			request.setAttribute("folio_list", folio_list_str);
				request.setAttribute("scheme_code_list", scheme_code_list_str);
            }
            
			request.setAttribute("goalType", "child-education");
    		request.setAttribute("subpage", "child-education");
    		request.setAttribute("jsp", "../goals/child-education.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/marriage")
	public String marriage(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{	
		try 
   		{	
	     	String amount = request.getParameter("amount");
	     	String inflation = request.getParameter("inflation");
	     	String horizon = request.getParameter("horizon");
	     	String risk = request.getParameter("risk");
	     	String goal_name = request.getParameter("goal_name");
			
			if(amount == null){amount = "";}
			if(inflation == null){inflation = "";}
			if(horizon == null){horizon = "";}
			if(risk == null){risk = "";}
			if(goal_name == null){goal_name = "";}
			
			request.setAttribute("amount", amount);
			request.setAttribute("inflation", inflation);
			request.setAttribute("horizon", horizon);
			request.setAttribute("risk", risk);
			request.setAttribute("goal_name", goal_name);
			
			System.out.println("amount--->"+amount);
			System.out.println("inflation--->"+inflation);
			System.out.println("horizon--->"+horizon);
			System.out.println("risk--->"+risk);
			System.out.println("goal_name--->"+goal_name);
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
            if(accountMap != null)
            {   
            	String userid = accountMap.get("userid");
            	String pan = accountMap.get("pan");
            	String name = accountMap.get("firstname");
            	String usertypeid = accountMap.get("usertypeid");
            	
            	if(userid == null){userid = "";}
    			if(pan == null){pan = "";}
    			if(name == null){name = "";}
    			if(usertypeid == null){usertypeid = "";}
    			
    			userid = userid.trim();
    			pan = pan.trim();
    			name = name.trim();
    			usertypeid = usertypeid.trim();
    			
    			request.setAttribute("userid", userid);
    			request.setAttribute("pan", pan);
    			request.setAttribute("name", name);
    			
    			String folio_list_str = "";
    			String scheme_code_list_str = "";
    			
    			List<UsersGoalSavedPlan> list = commonDao.getGoalDetails(userid, "Goal Based Robo Advisor");
    			if(list != null && list.size() > 0)
    			{
    				List<String> master_folio_list = new ArrayList<String>();
    				List<String> master_scheme_code_list = new ArrayList<String>();
    				
    				for (UsersGoalSavedPlan usersGoalSavedPlan : list) 
    				{
    					String existing_folio = usersGoalSavedPlan.getExisting_folio();
    					String existing_scheme_code = usersGoalSavedPlan.getExisting_scheme_code();
    					
    					if(StringHelper.isNotEmpty(existing_folio))
    					{
    						List<String> folio_list = new ArrayList<String>(Arrays.asList(existing_folio.split(",")));
        					List<String> scheme_code_list = new ArrayList<String>(Arrays.asList(existing_scheme_code.split(",")));
        					
        					master_folio_list.addAll(folio_list);
        					master_scheme_code_list.addAll(scheme_code_list);
    					}
					}
    				folio_list_str = StringUtils.join(master_folio_list, ',');
    				scheme_code_list_str = StringUtils.join(master_scheme_code_list, ',');
    			}
    			request.setAttribute("goal_list", list);
    			request.setAttribute("folio_list", folio_list_str);
				request.setAttribute("scheme_code_list", scheme_code_list_str);
            }
            
			request.setAttribute("goalType", "marriage");
    		request.setAttribute("subpage", "marriage");
    		request.setAttribute("jsp", "../goals/marriage.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/emergency")
	public String emergency(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{	
		try 
   		{	
	     	String amount = request.getParameter("amount");
	     	String inflation = request.getParameter("inflation");
	     	String age = request.getParameter("age");
	     	String risk = request.getParameter("risk");
	     	String goal_name = request.getParameter("goal_name");
			
			if(amount == null){amount = "";}
			if(inflation == null){inflation = "";}
			if(age == null){age = "";}
			if(risk == null){risk = "";}
			if(goal_name == null){goal_name = "";}
			
			request.setAttribute("amount", amount);
			request.setAttribute("inflation", inflation);
			request.setAttribute("age", age);
			request.setAttribute("risk", risk);
			request.setAttribute("goal_name", goal_name);
			
			System.out.println("amount--->"+amount);
			System.out.println("inflation--->"+inflation);
			System.out.println("age--->"+age);
			System.out.println("risk--->"+risk);
			System.out.println("goal_name--->"+goal_name);
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
            if(accountMap != null)
            {   
            	String userid = accountMap.get("userid");
            	String pan = accountMap.get("pan");
            	String name = accountMap.get("firstname");
            	String usertypeid = accountMap.get("usertypeid");
            	
            	if(userid == null){userid = "";}
    			if(pan == null){pan = "";}
    			if(name == null){name = "";}
    			if(usertypeid == null){usertypeid = "";}
    			
    			userid = userid.trim();
    			pan = pan.trim();
    			name = name.trim();
    			usertypeid = usertypeid.trim();
    			
    			request.setAttribute("userid", userid);
    			request.setAttribute("pan", pan);
    			request.setAttribute("name", name);
    			
    			String folio_list_str = "";
    			String scheme_code_list_str = "";
    			
    			List<UsersGoalSavedPlan> list = commonDao.getGoalDetails(userid, "Goal Based Robo Advisor");
    			if(list != null && list.size() > 0)
    			{
    				List<String> master_folio_list = new ArrayList<String>();
    				List<String> master_scheme_code_list = new ArrayList<String>();
    				
    				for (UsersGoalSavedPlan usersGoalSavedPlan : list) 
    				{
    					String existing_folio = usersGoalSavedPlan.getExisting_folio();
    					String existing_scheme_code = usersGoalSavedPlan.getExisting_scheme_code();
    					
    					if(StringHelper.isNotEmpty(existing_folio))
    					{
    						List<String> folio_list = new ArrayList<String>(Arrays.asList(existing_folio.split(",")));
        					List<String> scheme_code_list = new ArrayList<String>(Arrays.asList(existing_scheme_code.split(",")));
        					
        					master_folio_list.addAll(folio_list);
        					master_scheme_code_list.addAll(scheme_code_list);
    					}
					}
    				folio_list_str = StringUtils.join(master_folio_list, ',');
    				scheme_code_list_str = StringUtils.join(master_scheme_code_list, ',');
    			}
    			request.setAttribute("goal_list", list);
    			request.setAttribute("folio_list", folio_list_str);
				request.setAttribute("scheme_code_list", scheme_code_list_str);
            }
            
			request.setAttribute("goalType", "emergency");
    		request.setAttribute("subpage", "emergency");
    		request.setAttribute("jsp", "../goals/emergency.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/save-tax")
	public String save_tax(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{	
		try 
   		{	
	     	String amount = request.getParameter("amount");
	     	String horizon = request.getParameter("horizon");
	     	String goal_name = request.getParameter("goal_name");
			
			if(amount == null){amount = "";}
			if(horizon == null){horizon = "";}
			if(goal_name == null){goal_name = "";}
			
			request.setAttribute("amount", amount);
			request.setAttribute("horizon", horizon);
			request.setAttribute("goal_name", goal_name);
			
			System.out.println("amount--->"+amount);
			System.out.println("horizon--->"+horizon);
			System.out.println("goal_name--->"+goal_name);
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
            if(accountMap != null)
            {   
            	String userid = accountMap.get("userid");
            	String pan = accountMap.get("pan");
            	String name = accountMap.get("firstname");
            	String usertypeid = accountMap.get("usertypeid");
            	
            	if(userid == null){userid = "";}
    			if(pan == null){pan = "";}
    			if(name == null){name = "";}
    			if(usertypeid == null){usertypeid = "";}
    			
    			userid = userid.trim();
    			pan = pan.trim();
    			name = name.trim();
    			usertypeid = usertypeid.trim();
    			
    			request.setAttribute("userid", userid);
    			request.setAttribute("pan", pan);
    			request.setAttribute("name", name);
    			
    			String folio_list_str = "";
    			String scheme_code_list_str = "";
    			
    			List<UsersGoalSavedPlan> list = commonDao.getGoalDetails(userid, "Goal Based Robo Advisor");
    			if(list != null && list.size() > 0)
    			{
    				List<String> master_folio_list = new ArrayList<String>();
    				List<String> master_scheme_code_list = new ArrayList<String>();
    				
    				for (UsersGoalSavedPlan usersGoalSavedPlan : list) 
    				{
    					String existing_folio = usersGoalSavedPlan.getExisting_folio();
    					String existing_scheme_code = usersGoalSavedPlan.getExisting_scheme_code();
    					
    					if(StringHelper.isNotEmpty(existing_folio))
    					{
    						List<String> folio_list = new ArrayList<String>(Arrays.asList(existing_folio.split(",")));
        					List<String> scheme_code_list = new ArrayList<String>(Arrays.asList(existing_scheme_code.split(",")));
        					
        					master_folio_list.addAll(folio_list);
        					master_scheme_code_list.addAll(scheme_code_list);
    					}
					}
    				folio_list_str = StringUtils.join(master_folio_list, ',');
    				scheme_code_list_str = StringUtils.join(master_scheme_code_list, ',');
    			}
    			request.setAttribute("goal_list", list);
    			request.setAttribute("folio_list", folio_list_str);
				request.setAttribute("scheme_code_list", scheme_code_list_str);
            }
            
			request.setAttribute("goalType", "save-tax");
    		request.setAttribute("subpage", "save-tax");
    		request.setAttribute("jsp", "../goals/save-tax.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/robo-sip")
	public String roboSip(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{	
		try 
   		{	
			String sessionid = request.getParameter("sessionid");
			
			if(sessionid == null){sessionid = "";}
			
			request.setAttribute("sessionid", sessionid);
			
			System.out.println("sessionid--->"+sessionid);
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
			if(StringHelper.isNotEmpty(sessionid) && accountMap == null)
			{
				String client_name = "dakshin";
				Integer user_id = Integer.parseInt(sessionid);
				
				Users user = commonDao.getUserDetails(user_id, client_name);
				String name = user.getName();
				String pan = user.getPan();
				String mobile = user.getMobile();
				String email = user.getEmail();
				String type_id = String.valueOf(user.getType_id());
				
				System.out.println("name--->"+name);
				
	        	accountMap =  new HashMap<String, String>();
	        	accountMap.put("userid", String.valueOf(user_id));
	        	accountMap.put("firstname", name);
	        	accountMap.put("mobile", mobile);
	        	accountMap.put("email", email);
	        	accountMap.put("pan", pan );
	        	accountMap.put("client_name", client_name);
	        	accountMap.put("usertypeid", type_id);
	    		request.getSession().setAttribute("accountMap", accountMap);
			}
			request.setAttribute("accountMap", accountMap);	
			
			request.setAttribute("jsp", "../goals/robo-sip.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/robo-advisor")
	public String roboAdvisor(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{	
		try 
   		{	
			String sessionid = request.getParameter("sessionid");
			
			if(sessionid == null){sessionid = "";}
			
			request.setAttribute("sessionid", sessionid);
			
			System.out.println("sessionid--->"+sessionid);
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
			if(StringHelper.isNotEmpty(sessionid) && accountMap == null)
			{
				String client_name = "dakshin";
				Integer user_id = Integer.parseInt(sessionid);
				
				Users user = commonDao.getUserDetails(user_id, client_name);
				String name = user.getName();
				String pan = user.getPan();
				String mobile = user.getMobile();
				String email = user.getEmail();
				String type_id = String.valueOf(user.getType_id());
				
				System.out.println("name--->"+name);
				
	        	accountMap =  new HashMap<String, String>();
	        	accountMap.put("userid", String.valueOf(user_id));
	        	accountMap.put("firstname", name);
	        	accountMap.put("mobile", mobile);
	        	accountMap.put("email", email);
	        	accountMap.put("pan", pan );
	        	accountMap.put("client_name", client_name);
	        	accountMap.put("usertypeid", type_id);
	    		request.getSession().setAttribute("accountMap", accountMap);
			}
			request.setAttribute("accountMap", accountMap);	
			
			request.setAttribute("jsp", "../goals/robo-advisor.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/getPortfolioDetails")
	public void getPortfolioDetails(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		Gson gson = new Gson();
		
		try 
		{
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
            if(accountMap != null)
            {   
            	String userid = accountMap.get("userid");
            	String pan = accountMap.get("pan");
            	String name = accountMap.get("firstname");
            	String usertypeid = accountMap.get("usertypeid");
            	
            	if(userid == null){userid = "";}
    			if(pan == null){pan = "";}
    			if(name == null){name = "";}
    			if(usertypeid == null){usertypeid = "";}
    			
    			userid = userid.trim();
    			pan = pan.trim();
    			name = name.trim();
    			usertypeid = usertypeid.trim();
    			
    			System.out.println("userid-->"+userid);
    			System.out.println("name-->"+name);
    			System.out.println("pan-->"+pan);
    			System.out.println("usertypeid-->"+usertypeid);
    			
    			List<InvestorPortfolioResponse> mutualfund_list = new ArrayList<InvestorPortfolioResponse>();
    			
    			String client_name = "dakshin";
    			Integer user_id = Integer.parseInt(userid);
    			
    			InvestorPortfolioResponse investorPortfolioResponse =  commonDao.getInvestorPortfolio(user_id, client_name);
    			System.out.println("investorPortfolioResponse-->"+investorPortfolioResponse);
    			System.out.println("getInvestorSchemeWisePortfolioResponses-->"+investorPortfolioResponse.getInvestorSchemeWisePortfolioResponses().size());
				mutualfund_list.add(investorPortfolioResponse);
    			
				/*
				 * if(usertypeid.equalsIgnoreCase("1")) { InvestorPortfolioResponse
				 * investorPortfolioResponse = commonDao.getInvestorPortfolio(user_id,
				 * client_name); mutualfund_list.add(investorPortfolioResponse);
				 * 
				 * }else if(usertypeid.equalsIgnoreCase("3")) { List<RmInvestorResponse>
				 * rmInvestorResponse = commonDao.getFHMappedInvestor(userid, client_name);
				 * 
				 * for (RmInvestorResponse rmInvestorResponse2 : rmInvestorResponse) { Integer
				 * investor_id = Integer.parseInt(rmInvestorResponse2.getId());
				 * 
				 * InvestorPortfolioResponse investorPortfolioResponse =
				 * commonDao.getInvestorPortfolio(investor_id, client_name);
				 * mutualfund_list.add(investorPortfolioResponse); } }else {
				 * 
				 * }
				 */
    			
	    		writer.print(gson.toJson(mutualfund_list));
				writer.close();
				return;
            }
            else
            {
        		writer.print(gson.toJson(null));
    			writer.close();
    			return;
            }
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/getFundRatingBasedSchemes")
	public void getFundRatingBasedSchemes(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{		
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		Gson gson = new Gson();
		
    	try 
   		{
    		String category =  request.getParameter("category");
	 		String max_count =  request.getParameter("max_count");
	 		
	 		if(category == null || StringHelper.isEmpty(category)){category= "Equity: Large Cap";}
	 		if(max_count == null || StringHelper.isEmpty(max_count)){max_count= "1";}
	 		
	 		category = category.trim();
	 		max_count = max_count.trim();
	 		
	 		int count = Integer.parseInt(max_count);
	 		
	 		String formattedUrl, result = "";
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("category", category);
            hashMap.put("max_count", String.valueOf(count));
	 		
	 		List<String> debt_fund_list = schemeMappingRepository.getDebtCategories();
	     	
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getFundRatingBasedSchemesPerformance, hashMap);
			result = HttpPost.SendHttpPost(formattedUrl, "");
			gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
			MutualFundSchemeAPIResponse mutualFundSchemeAPIResponse = gson.fromJson(result, MutualFundSchemeAPIResponse.class);
			List<SchemePerformances> schemePerformances = mutualFundSchemeAPIResponse.getList();
	 		
	 		if(schemePerformances != null && schemePerformances.size() > 0)
	 		{
	 			for (SchemePerformances schemePerformances2 : schemePerformances) 
		 		{
		 			String scheme_category = schemePerformances2.getScheme_category();
		 			if(debt_fund_list.contains(scheme_category))
		 			{
		 				double one_year_return = schemePerformances2.getReturns_abs_1year();
		 				double ytd_return = schemePerformances2.getReturns_abs_ytd();
		 				if(one_year_return > 20 || ytd_return > 20)
		 				{
		 					schemePerformances2.setReturns_abs_1year(0);
		 					schemePerformances2.setReturns_abs_ytd(0);
		 				}
		 			}
				}
	 		}
	 		
	 		writer.print(gson.toJson(schemePerformances));
			writer.close();
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
	}

	@RequestMapping(value="/saveGoalWithOutLogin")
	public void saveGoalWithOutLogin(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{		
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		CommonResponse commonResponse = new CommonResponse();
		Gson gson = new Gson();
		
    	try 
   		{
        	String target_goal = request.getParameter("target_goal");
        	String goal_name = request.getParameter("goal_name");
        	String amount = request.getParameter("amount");
        	String horizon = request.getParameter("horizon");
        	String inflation = request.getParameter("inflation");
			String risk = request.getParameter("risk");
			String target_amount = request.getParameter("target_amount");
			String sip_amount = request.getParameter("sip_amount");
			String scheme_array = request.getParameter("scheme_array");
			String category_array = request.getParameter("category_array");
			String percentage_array = request.getParameter("percentage_array");
			String amount_array = request.getParameter("amount_array"); 
			String existing_folio = request.getParameter("existing_folio"); 
			String existing_scheme = request.getParameter("existing_scheme"); 
			String existing_scheme_code = request.getParameter("existing_scheme_code"); 
			String existing_scheme_sip = request.getParameter("existing_scheme_sip"); 
			String existing_scheme_current_value = request.getParameter("existing_scheme_current_value");
			
			if(target_goal == null){target_goal = "";};
			if(goal_name == null){goal_name = "";};
			if(amount == null){amount = "";};
			if(horizon == null){horizon = "";};
			if(inflation == null){inflation = "";};
			if(risk == null){risk = "";};
			if(target_amount == null){target_amount = "";};
			if(sip_amount == null){sip_amount = "";};
			if(scheme_array == null){scheme_array = "";};
			if(category_array == null){category_array = "";};
			if(percentage_array == null){percentage_array = "";};
			if(amount_array == null){amount_array = "";};
			if(existing_folio == null){existing_folio = "";};
			if(existing_scheme == null){existing_scheme = "";};
			if(existing_scheme_code == null){existing_scheme_code = "";};
			if(existing_scheme_sip == null){existing_scheme_sip = "";};
			if(existing_scheme_current_value == null){existing_scheme_current_value = "";};
			
			target_goal = target_goal.trim();
			goal_name = goal_name.trim();
			amount = amount.trim();
			horizon = horizon.trim();
			inflation = inflation.trim();
			risk = risk.trim();
			target_amount = target_amount.trim();
			sip_amount = sip_amount.trim();
			scheme_array = scheme_array.trim();
			category_array = category_array.trim();
			percentage_array = percentage_array.trim();
			amount_array = amount_array.trim();
			existing_folio = existing_folio.trim();
			existing_scheme = existing_scheme.trim();
			existing_scheme_code = existing_scheme_code.trim();
			existing_scheme_sip = existing_scheme_sip.trim();
			existing_scheme_current_value = existing_scheme_current_value.trim();
			
			String auth_code = UniqueIDProvider.generateUniquePin(6);
			
			UsersGoalSavedPlan savePlan = new UsersGoalSavedPlan();
			savePlan.setUser_id("");
			savePlan.setName("");
			savePlan.setPan("");
			savePlan.setEmail("");
			savePlan.setGoal(target_goal);
			savePlan.setGoal_name(goal_name);
			savePlan.setAmount(amount);
			savePlan.setHorizon(horizon);
			savePlan.setInflation(inflation);
			savePlan.setRisk(risk);
			savePlan.setTarget_amount(target_amount);
			savePlan.setAchieved_amount("0");
			savePlan.setSip_amount(sip_amount);
			savePlan.setLumpsum_amount("0");
			savePlan.setScheme_array(scheme_array);
			savePlan.setCategory_array(category_array);
			savePlan.setPercentage_array(percentage_array);
			savePlan.setAmount_array(amount_array);
			savePlan.setExisting_folio(existing_folio);
			savePlan.setExisting_scheme(existing_scheme);
			savePlan.setExisting_scheme_code(existing_scheme_code);
			savePlan.setExisting_scheme_sip(existing_scheme_sip);
			savePlan.setExisting_scheme_current_value(existing_scheme_current_value);
			savePlan.setAuth_code(auth_code);
			savePlan.setType("Goal Based Robo Advisor");
			savePlan.setOnline_invest("Progress");
			savePlan.setCreated_date(new Date());
			savePlan.setClient_name("dakshin");
			commonDao.saveGoalPlan(savePlan);
			
			commonResponse.setStatus(StatusMessage.SuccessCode);
			commonResponse.setStatus_msg(StatusMessage.SuccessMessage);
			commonResponse.setMsg(auth_code);
    		writer.print(gson.toJson(commonResponse));
			writer.close();
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
	}
	
	@RequestMapping(value="/getRiskProfile")
	public void getRiskProfile(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		PrintWriter writer = null;		
		Gson gson = null; 
		RoboRiskProfileAnswer result = null;
		String apiresponse = "";
		
		try 
		{	
			writer = response.getWriter();
			gson = new Gson();
			response.setContentType("text/html");
			result = new RoboRiskProfileAnswer();
			
			String answer1 = request.getParameter("answer1");
		 	String answer2 = request.getParameter("answer2");
		    String answer3 = request.getParameter("answer3");
		    String answer4 = request.getParameter("answer4");
		    String answer5 = request.getParameter("answer5");
		    String answer6 = request.getParameter("answer6");
		    /*String answer7 = request.getParameter("answer7");
		    String answer8 = request.getParameter("answer8");*/
		    
			if(answer1 == null || StringHelper.isEmpty(answer1)){answer1 = "1";}
		    if(answer2 == null || StringHelper.isEmpty(answer2)){answer2 = "1";}
		    if(answer3 == null || StringHelper.isEmpty(answer3)){answer3 = "1";}
		    if(answer4 == null || StringHelper.isEmpty(answer4)){answer4 = "1";}
		    if(answer5 == null || StringHelper.isEmpty(answer5)){answer5 = "1";}
		    if(answer6 == null || StringHelper.isEmpty(answer6)){answer6 = "1";}
		    /*if(answer7 == null || StringHelper.isEmpty(answer7)){answer7 = "1";}
		    if(answer8 == null || StringHelper.isEmpty(answer8)){answer8 = "1";}*/
		    
		    answer1 = answer1.trim();
		    answer2 = answer2.trim();
		    answer3 = answer3.trim();
		    answer4 = answer4.trim();
		    answer5 = answer5.trim();
		    answer6 = answer6.trim();
		    /*answer7 = answer7.trim();
		    answer8 = answer8.trim();*/
		    
            //if()
            {    
        	   Integer ans1 = Integer.parseInt(answer1);
        	   Integer ans2 = Integer.parseInt(answer2);
        	   Integer ans3 = Integer.parseInt(answer3);
        	   Integer ans4 = Integer.parseInt(answer4);
        	   Integer ans5 = Integer.parseInt(answer5);
        	   Integer ans6 = Integer.parseInt(answer6);
        	   /*Integer ans7 = Integer.parseInt(answer7);
        	   Integer ans8 = Integer.parseInt(answer8);*/
        	   
        	   Integer total_points = ans1 + ans2 + ans3 + ans4 + ans5 + ans6;
        	   
        	   String risk_profile = "";
        	    
        	    if(total_points <= 6)
        	    {
        	    	risk_profile = "Conservative";
        	    }else if(total_points <= 12)
        	    {
        	    	risk_profile = "Moderately Conservative";
        	    }else if(total_points <= 16)
        	    {
        	    	risk_profile = "Moderate";
        	    }else if(total_points <= 20)
        	    {
        	    	risk_profile = "Moderately Aggressive";
        	    }else
        	    {
        	    	risk_profile = "Aggressive";
        	    }
        		
            	result.setStatus(StatusMessage.SuccessCode);
            	result.setStatus_msg(StatusMessage.SuccessMessage);
            	result.setMsg(StatusMessage.SuccessMessage);
            	result.setAnswer_1(ans1); 		
            	result.setAnswer_2(ans2);
            	result.setAnswer_3(ans3);
            	result.setAnswer_4(ans4);
            	result.setAnswer_5(ans5);
            	result.setAnswer_6(ans6);
/*            	result.setAnswer_7(ans7);
            	result.setAnswer_7(ans7);
            	result.setAnswer_8(ans8);*/
            	result.setRisk_profile(risk_profile);
            }
            apiresponse = gson.toJson(result);
    		writer.print(apiresponse);
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/getSipHistoricalReturnsByCategory")
	public void getSipHistoricalReturnsByCategory(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{		
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		Gson gson = new Gson();
		
    	try 
   		{
    		String categoryList = request.getParameter("category");
			if(categoryList == null || StringHelper.isEmpty(categoryList)){categoryList="Equity: Large Cap";}
			categoryList = categoryList.trim();
						
			List<String> category_list = new ArrayList<String>(Arrays.asList(categoryList.split(",")));
			List<CategoryRollingReturnsResponse> return_list = new ArrayList<CategoryRollingReturnsResponse>();
			
			String formattedUrl, result = "";
			
			formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getCategoryPerformance, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl, "");
	 		gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		MutualFundCategoryMonitorResponse mutualFundCategoryMonitorResponse = gson.fromJson(result, MutualFundCategoryMonitorResponse.class);
			List<SchemePerformancesCategory> list = mutualFundCategoryMonitorResponse.getList();
			
			if(list != null && list.size() > 0)
			{
				for (SchemePerformancesCategory schemePerformancesCategory : list) 
				{
					String category = schemePerformancesCategory.getSector();
					Double six_month_return = schemePerformancesCategory.getReturns_abs_6month();
					Double one_year_return = schemePerformancesCategory.getReturns_abs_1year();
					Double three_year_return = schemePerformancesCategory.getReturns_cmp_3year();
					Double five_year_return = schemePerformancesCategory.getReturns_cmp_5year();
					//Double ten_year_return = schemePerformancesCategory.getReturns_cmp_10year();
					
					if(category_list.contains("Debt: Liquid") && category.equalsIgnoreCase("Debt: Liquid"))
					{
						CategoryRollingReturnsResponse returnsResponse = new CategoryRollingReturnsResponse();
						returnsResponse.setCategory("Debt: Liquid");
						returnsResponse.setMedian_rolling_returns(six_month_return);
						return_list.add(returnsResponse);
					}
					if(category_list.contains("Debt: Short Duration") && category.equalsIgnoreCase("Debt: Short Duration"))
					{
						CategoryRollingReturnsResponse returnsResponse = new CategoryRollingReturnsResponse();
						returnsResponse.setCategory("Debt: Short Duration");
						returnsResponse.setMedian_rolling_returns(one_year_return);
						return_list.add(returnsResponse);
					}
					if(category_list.contains("Debt: Long Duration") && category.equalsIgnoreCase("Debt: Long Duration"))
					{
						CategoryRollingReturnsResponse returnsResponse = new CategoryRollingReturnsResponse();
						returnsResponse.setCategory("Debt: Long Duration");
						returnsResponse.setMedian_rolling_returns(three_year_return);
						return_list.add(returnsResponse);
					}
					if(category_list.contains("Hybrid: Conservative") && category.equalsIgnoreCase("Hybrid: Conservative"))
					{
						CategoryRollingReturnsResponse returnsResponse = new CategoryRollingReturnsResponse();
						returnsResponse.setCategory("Hybrid: Conservative");
						returnsResponse.setMedian_rolling_returns(three_year_return);
						return_list.add(returnsResponse);
					}
					if(category_list.contains("Hybrid: Aggressive") && category.equalsIgnoreCase("Hybrid: Aggressive"))
					{
						CategoryRollingReturnsResponse returnsResponse = new CategoryRollingReturnsResponse();
						returnsResponse.setCategory("Hybrid: Aggressive");
						returnsResponse.setMedian_rolling_returns(five_year_return);
						return_list.add(returnsResponse);
					}
					if(category_list.contains("Equity: Large Cap") && category.equalsIgnoreCase("Equity: Large Cap"))
					{
						CategoryRollingReturnsResponse returnsResponse = new CategoryRollingReturnsResponse();
						returnsResponse.setCategory("Equity: Large Cap");
						returnsResponse.setMedian_rolling_returns(five_year_return);
						return_list.add(returnsResponse);
					}
					if(category_list.contains("Equity: Mid Cap") && category.equalsIgnoreCase("Equity: Mid Cap"))
					{
						CategoryRollingReturnsResponse returnsResponse = new CategoryRollingReturnsResponse();
						returnsResponse.setCategory("Equity: Mid Cap");
						returnsResponse.setMedian_rolling_returns(five_year_return);
						return_list.add(returnsResponse);
					}
					if(category_list.contains("Equity: Multi Cap") && category.equalsIgnoreCase("Equity: Multi Cap"))
					{
						CategoryRollingReturnsResponse returnsResponse = new CategoryRollingReturnsResponse();
						returnsResponse.setCategory("Equity: Multi Cap");
						returnsResponse.setMedian_rolling_returns(five_year_return);
						return_list.add(returnsResponse);
					}
					if(category_list.contains("Equity: ELSS") && category.equalsIgnoreCase("Equity: ELSS"))
					{
						CategoryRollingReturnsResponse returnsResponse = new CategoryRollingReturnsResponse();
						returnsResponse.setCategory("Equity: ELSS");
						returnsResponse.setMedian_rolling_returns(five_year_return);
						return_list.add(returnsResponse);
					}
				}
			}
			
	 		writer.print(gson.toJson(return_list));
			writer.close();
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
	}
	
	@RequestMapping(value="/saveGoal")
	public void saveGoal(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{		
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		CommonResponse commonResponse = new CommonResponse();
		Gson gson = new Gson();
		
    	try 
   		{
    		HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
    		
    		if(accountMap == null) 
    		{
	    		String sessionid = request.getParameter("sessionid");
				
				if(sessionid == null){sessionid = "";}
				
				request.setAttribute("sessionid", sessionid);
				
				accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
				if(StringHelper.isNotEmpty(sessionid) && accountMap == null)
				{
					String client_name = "dakshin";
					Integer user_id = Integer.parseInt(sessionid);
					
					Users user = commonDao.getUserDetails(user_id, client_name);
					String name = user.getName();
					String pan = user.getPan();
					String mobile = user.getMobile();
					String email = user.getEmail();
					String type_id = String.valueOf(user.getType_id());
					
		        	accountMap =  new HashMap<String, String>();
		        	accountMap.put("userid", String.valueOf(user_id));
		        	accountMap.put("firstname", name);
		        	accountMap.put("mobile", mobile);
		        	accountMap.put("email", email);
		        	accountMap.put("pan", pan );
		        	accountMap.put("client_name", client_name);
		        	accountMap.put("usertypeid", type_id);
		    		request.getSession().setAttribute("accountMap", accountMap);
				}
				request.setAttribute("accountMap", accountMap);
    		}
    		
            if(accountMap != null)
            {   
            	String userid = accountMap.get("userid");
            	String name = accountMap.get("firstname");
            	String pan = accountMap.get("pan");
            	String email = accountMap.get("email");
            	
            	String target_goal = request.getParameter("target_goal");
            	String goal_name = request.getParameter("goal_name");
            	String amount = request.getParameter("amount");
            	String horizon = request.getParameter("horizon");
            	String inflation = request.getParameter("inflation");
    			String risk = request.getParameter("risk");
    			String target_amount = request.getParameter("target_amount");
    			String sip_amount = request.getParameter("sip_amount");
    			String scheme_array = request.getParameter("scheme_array");
    			String category_array = request.getParameter("category_array");
    			String percentage_array = request.getParameter("percentage_array");
    			String amount_array = request.getParameter("amount_array"); 
    			String existing_folio = request.getParameter("existing_folio"); 
    			String existing_scheme = request.getParameter("existing_scheme"); 
    			String existing_scheme_code = request.getParameter("existing_scheme_code"); 
    			String existing_scheme_sip = request.getParameter("existing_scheme_sip"); 
    			String existing_scheme_current_value = request.getParameter("existing_scheme_current_value");
    			
    			if(userid == null){userid = "";};
    			if(name == null){name = "";};
    			if(pan == null){pan = "";};
    			if(email == null){email = "";};
    			if(target_goal == null){target_goal = "";};
    			if(goal_name == null){goal_name = "";};
    			if(amount == null){amount = "";};
    			if(horizon == null){horizon = "";};
    			if(inflation == null){inflation = "";};
    			if(risk == null){risk = "";};
    			if(target_amount == null){target_amount = "";};
    			if(sip_amount == null){sip_amount = "";};
    			if(scheme_array == null){scheme_array = "";};
    			if(category_array == null){category_array = "";};
    			if(percentage_array == null){percentage_array = "";};
    			if(amount_array == null){amount_array = "";};
    			if(existing_folio == null){existing_folio = "";};
    			if(existing_scheme == null){existing_scheme = "";};
    			if(existing_scheme_code == null){existing_scheme_code = "";};
    			if(existing_scheme_sip == null){existing_scheme_sip = "";};
    			if(existing_scheme_current_value == null){existing_scheme_current_value = "";};
    			
    			userid = userid.trim();
    			name = name.trim();
    			pan = pan.trim();
    			email = email.trim();
    			target_goal = target_goal.trim();
    			goal_name = goal_name.trim();
    			amount = amount.trim();
    			horizon = horizon.trim();
    			inflation = inflation.trim();
    			risk = risk.trim();
    			target_amount = target_amount.trim();
    			sip_amount = sip_amount.trim();
    			scheme_array = scheme_array.trim();
    			category_array = category_array.trim();
    			percentage_array = percentage_array.trim();
    			amount_array = amount_array.trim();
    			existing_folio = existing_folio.trim();
    			existing_scheme = existing_scheme.trim();
    			existing_scheme_code = existing_scheme_code.trim();
    			existing_scheme_sip = existing_scheme_sip.trim();
    			existing_scheme_current_value = existing_scheme_current_value.trim();
    			
    			UsersGoalSavedPlan savePlan = new UsersGoalSavedPlan();
    			savePlan.setUser_id(userid);
    			savePlan.setName(name);
    			savePlan.setPan(pan);
    			savePlan.setEmail(email);
    			savePlan.setGoal(target_goal);
    			savePlan.setGoal_name(goal_name);
    			savePlan.setAmount(amount);
    			savePlan.setHorizon(horizon);
    			savePlan.setInflation(inflation);
    			savePlan.setRisk(risk);
    			savePlan.setTarget_amount(target_amount);
    			savePlan.setAchieved_amount("0");
    			savePlan.setSip_amount(sip_amount);
    			savePlan.setLumpsum_amount("0");
    			savePlan.setScheme_array(scheme_array);
    			savePlan.setCategory_array(category_array);
    			savePlan.setPercentage_array(percentage_array);
    			savePlan.setAmount_array(amount_array);
    			savePlan.setExisting_folio(existing_folio);
    			savePlan.setExisting_scheme(existing_scheme);
    			savePlan.setExisting_scheme_code(existing_scheme_code);
    			savePlan.setExisting_scheme_sip(existing_scheme_sip);
    			savePlan.setExisting_scheme_current_value(existing_scheme_current_value);
    			savePlan.setAuth_code("");
    			savePlan.setType("Goal Based Robo Advisor");
    			savePlan.setOnline_invest("Progress");
    			savePlan.setCreated_date(new Date());
    			savePlan.setClient_name("dakshin");
    			commonDao.saveGoalPlan(savePlan);
    			
    			commonResponse.setStatus(StatusMessage.SuccessCode);
				commonResponse.setStatus_msg(StatusMessage.SuccessMessage);
				commonResponse.setMsg(""+savePlan.getId());
	    		writer.print(gson.toJson(commonResponse));
				writer.close();
				return;
            }
            else
            {
            	commonResponse.setStatus(StatusMessage.FailureCode);
        		commonResponse.setStatus_msg(StatusMessage.FailureMessage);
        		commonResponse.setMsg("Your session expired. Please login again.");
        		writer.print(gson.toJson(commonResponse));
    			writer.close();
    			return;
            }
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
	}
	
	@RequestMapping(value="/saveRoboPlanWithoutLogin")
	public void saveRoboPlanWithoutLogin(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{		
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		CommonResponse commonResponse = new CommonResponse();
		Gson gson = new Gson();
		
    	try 
   		{
    		String age = request.getParameter("age");
			String risk = request.getParameter("risk");
			String amount = request.getParameter("amount");
			String horizon = request.getParameter("horizon");
			String tax = request.getParameter("tax");
			String type = request.getParameter("type");
			String inflation = request.getParameter("inflation");
			String goal = request.getParameter("goal");
			String sip_amount = request.getParameter("sip_amount");
			String scheme_array = request.getParameter("scheme_array");
			String category_array = request.getParameter("category_array");
			String percentage_array = request.getParameter("percentage_array");
			String amount_array = request.getParameter("amount_array"); 
			
			if(age == null){age = "0";};
			if(risk == null){risk = "";};
			if(amount == null){amount = "0";};
			if(horizon == null){horizon = "0";};
			if(tax == null){tax = "0";};
			if(type == null){type = "";};
			if(inflation == null){inflation = "0";};
			if(goal == null){goal = "";};
			if(sip_amount == null){sip_amount = "0";};
			if(scheme_array == null){scheme_array = "";};
			if(category_array == null){category_array = "";};
			if(percentage_array == null){percentage_array = "";};
			if(amount_array == null){amount_array = "0";};
			
			age = age.trim();
			risk = risk.trim();
			amount = amount.trim();
			horizon = horizon.trim();
			tax = tax.trim();
			type = type.trim();
			inflation = inflation.trim();
			goal = goal.trim();
			sip_amount = sip_amount.trim();
			scheme_array = scheme_array.trim();
			category_array = category_array.trim();
			percentage_array = percentage_array.trim();
			amount_array = amount_array.trim();
			
			String auth_code = UniqueIDProvider.generateUniquePin(6);
			
			UsersGoalSavedPlan savePlan = new UsersGoalSavedPlan();
			savePlan.setUser_id("");
			savePlan.setName("");
			savePlan.setPan("");
			savePlan.setEmail("");
			savePlan.setAge(age);
			savePlan.setRisk(risk);
			savePlan.setAmount(amount);
			savePlan.setTarget_amount(amount);
			savePlan.setHorizon(horizon);
			savePlan.setTax(tax);
			savePlan.setGoal(goal);
			savePlan.setInflation(inflation);
			savePlan.setSip_amount(sip_amount);
			savePlan.setScheme_array(scheme_array);
			savePlan.setCategory_array(category_array);
			savePlan.setPercentage_array(percentage_array);
			savePlan.setAmount_array(amount_array);
			savePlan.setGoal_name("");
			savePlan.setAchieved_amount("0");
			savePlan.setLumpsum_amount("0");
			savePlan.setExisting_folio("");
			savePlan.setExisting_scheme("");
			savePlan.setExisting_scheme_code("");
			savePlan.setExisting_scheme_sip("0");
			savePlan.setExisting_scheme_current_value("0");
			savePlan.setAuth_code(auth_code);
			savePlan.setType(type);
			savePlan.setOnline_invest("Progress");
			savePlan.setCreated_date(new Date());
			savePlan.setClient_name("dakshin");
			commonDao.saveGoalPlan(savePlan);
			
			commonResponse.setStatus(StatusMessage.SuccessCode);
			commonResponse.setStatus_msg(StatusMessage.SuccessMessage);
			commonResponse.setMsg(auth_code);
    		writer.print(gson.toJson(commonResponse));
			writer.close();
			return;
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
	}
	
	@RequestMapping(value="/saveRoboPlan")
	public void saveRoboPlan(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{		
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		CommonResponse commonResponse = new CommonResponse();
		Gson gson = new Gson();
		
    	try 
   		{
    		HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
    		
    		if(accountMap == null) 
    		{
	    		String sessionid = request.getParameter("sessionid");
				
				if(sessionid == null){sessionid = "";}
				
				request.setAttribute("sessionid", sessionid);
				
				accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
				if(StringHelper.isNotEmpty(sessionid) && accountMap == null)
				{
					String client_name = "dakshin";
					Integer user_id = Integer.parseInt(sessionid);
					
					Users user = commonDao.getUserDetails(user_id, client_name);
					String name = user.getName();
					String pan = user.getPan();
					String mobile = user.getMobile();
					String email = user.getEmail();
					String type_id = String.valueOf(user.getType_id());
					
		        	accountMap =  new HashMap<String, String>();
		        	accountMap.put("userid", String.valueOf(user_id));
		        	accountMap.put("firstname", name);
		        	accountMap.put("mobile", mobile);
		        	accountMap.put("email", email);
		        	accountMap.put("pan", pan );
		        	accountMap.put("client_name", client_name);
		        	accountMap.put("usertypeid", type_id);
		    		request.getSession().setAttribute("accountMap", accountMap);
				}
				request.setAttribute("accountMap", accountMap);
    		}
    		
            if(accountMap != null)
            {   
            	String userid = accountMap.get("userid");
            	String name = accountMap.get("firstname");
            	String pan = accountMap.get("pan");
            	String email = accountMap.get("email");
            	
            	String age = request.getParameter("age");
    			String risk = request.getParameter("risk");
    			String amount = request.getParameter("amount");
    			String horizon = request.getParameter("horizon");
    			String tax = request.getParameter("tax");
    			String type = request.getParameter("type");
    			String inflation = request.getParameter("inflation");
    			String goal = request.getParameter("goal");
    			String sip_amount = request.getParameter("sip_amount");
    			String scheme_array = request.getParameter("scheme_array");
    			String category_array = request.getParameter("category_array");
    			String percentage_array = request.getParameter("percentage_array");
    			String amount_array = request.getParameter("amount_array"); 
    			
    			if(userid == null){userid = "";};
    			if(name == null){name = "";};
    			if(email == null){email = "";};
    			if(pan == null){pan = "";};
    			if(age == null){age = "0";};
    			if(risk == null){risk = "";};
    			if(amount == null){amount = "0";};
    			if(horizon == null){horizon = "0";};
    			if(tax == null){tax = "0";};
    			if(type == null){type = "";};
    			if(inflation == null){inflation = "0";};
    			if(goal == null){goal = "";};
    			if(sip_amount == null){sip_amount = "0";};
    			if(scheme_array == null){scheme_array = "";};
    			if(category_array == null){category_array = "";};
    			if(percentage_array == null){percentage_array = "";};
    			if(amount_array == null){amount_array = "0";};
    			
    			userid = userid.trim();
    			name = name.trim();
    			pan = pan.trim();
    			email = email.trim();
    			age = age.trim();
    			risk = risk.trim();
    			amount = amount.trim();
    			horizon = horizon.trim();
    			tax = tax.trim();
    			type = type.trim();
    			inflation = inflation.trim();
    			goal = goal.trim();
    			sip_amount = sip_amount.trim();
    			scheme_array = scheme_array.trim();
    			category_array = category_array.trim();
    			percentage_array = percentage_array.trim();
    			amount_array = amount_array.trim();
    			
    			UsersGoalSavedPlan savePlan = new UsersGoalSavedPlan();
    			savePlan.setUser_id(userid);
    			savePlan.setName(name);
    			savePlan.setPan(pan);
    			savePlan.setEmail(email);
    			savePlan.setAge(age);
    			savePlan.setRisk(risk);
    			savePlan.setAmount(amount);
    			savePlan.setTarget_amount(amount);
    			savePlan.setHorizon(horizon);
    			savePlan.setTax(tax);
    			savePlan.setGoal(goal);
    			savePlan.setInflation(inflation);
    			savePlan.setSip_amount(sip_amount);
    			savePlan.setScheme_array(scheme_array);
    			savePlan.setCategory_array(category_array);
    			savePlan.setPercentage_array(percentage_array);
    			savePlan.setAmount_array(amount_array);
    			savePlan.setGoal_name("");
    			savePlan.setAchieved_amount("0");
    			savePlan.setLumpsum_amount("0");
    			savePlan.setExisting_folio("");
    			savePlan.setExisting_scheme("");
    			savePlan.setExisting_scheme_code("");
    			savePlan.setExisting_scheme_sip("0");
    			savePlan.setExisting_scheme_current_value("0");
    			savePlan.setAuth_code("");
    			savePlan.setType(type);
    			savePlan.setOnline_invest("Progress");
    			savePlan.setCreated_date(new Date());
    			savePlan.setClient_name("dakshin");
    			commonDao.saveGoalPlan(savePlan);
    			
    			commonResponse.setStatus(StatusMessage.SuccessCode);
				commonResponse.setStatus_msg(StatusMessage.SuccessMessage);
				commonResponse.setMsg(""+savePlan.getId());
	    		writer.print(gson.toJson(commonResponse));
				writer.close();
				return;
            }
            else
            {
            	commonResponse.setStatus(StatusMessage.FailureCode);
        		commonResponse.setStatus_msg(StatusMessage.FailureMessage);
        		commonResponse.setMsg("Your session expired. Please login again.");
        		writer.print(gson.toJson(commonResponse));
    			writer.close();
    			return;
            }
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
	}	
}
