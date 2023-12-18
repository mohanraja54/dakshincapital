package com.dakshin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.internal.util.StringHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dakshin.amfi.response.ApiCalculatorAssetAllocation;
import com.dakshin.amfi.response.ApiCalculatorCompositePlanner;
import com.dakshin.amfi.response.ApiCalculatorEPF;
import com.dakshin.amfi.response.ApiCalculatorEPFTable;
import com.dakshin.amfi.response.ApiCalculatorEducationPlanner;
import com.dakshin.amfi.response.ApiCalculatorGoalSetting;
import com.dakshin.amfi.response.ApiCalculatorPPF;
import com.dakshin.amfi.response.ApiCalculatorPPFTable;
import com.dakshin.response.ApiCalculatorCrorepati;
import com.dakshin.response.ApiCalculatorSIP;
import com.dakshin.utils.StatusCodesAndMessages;
import com.google.gson.Gson;

@Controller
public class CalculatorController {
	
	@RequestMapping(value="/tools-and-calculators/become-a-crorepati")
   	public String crorepati2(HttpServletRequest request, HttpServletResponse response) 
   	{
		try 
   		{
			String current_age = request.getParameter("current_age");
	     	String retirement_age = request.getParameter("retirement_age");
            String wealth_amount = request.getParameter("wealth_amount");
            String inflation_rate = request.getParameter("inflation_rate");
            String expected_return = request.getParameter("expected_return");
            String savings_amount = request.getParameter("savings_amount");
            
            if(current_age == null || StringHelper.isEmpty(current_age)){current_age = "30";}
            if(retirement_age == null || StringHelper.isEmpty(retirement_age)){retirement_age = "60";}
            if(wealth_amount == null || StringHelper.isEmpty(wealth_amount)){wealth_amount = "50000000";}
            if(inflation_rate == null || StringHelper.isEmpty(inflation_rate)){inflation_rate = "5.0";}
            if(expected_return == null || StringHelper.isEmpty(expected_return)){expected_return = "12";}
            if(savings_amount == null || StringHelper.isEmpty(savings_amount)){savings_amount = "2500000";}
                     
            current_age = current_age.trim();
            retirement_age = retirement_age.trim();
            wealth_amount = wealth_amount.trim();
            inflation_rate = inflation_rate.trim();
            expected_return = expected_return.trim();
            savings_amount = savings_amount.trim();
			
			request.setAttribute("current_age", current_age);
			request.setAttribute("retirement_age", retirement_age);
			request.setAttribute("wealth_amount", wealth_amount);
			request.setAttribute("inflation_rate", inflation_rate);
			request.setAttribute("expected_return", expected_return);
			request.setAttribute("savings_amount", savings_amount);
			
			request.setAttribute("page", "tcalc");
			request.setAttribute("menu", "Become A Crorepati");
			request.setAttribute("jsp", "../calculator/crorpati.jsp");
   		}
		catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
		
		return "layout/layout";
   	}
	
	@RequestMapping(value="/tools-and-calculators/getCrorepatiResult")
	public void getSIPReturnCalculator(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		PrintWriter writer = null;		
		Gson gson = null;
		String origin = null;
		ApiCalculatorCrorepati result = null;
		String apiresponse = "";
		
		try 
		{	
			writer = response.getWriter();
			gson = new Gson();
			response.setContentType("text/html");
			origin = request.getHeader("Origin");
			if(origin == null){origin="";}
			
			result = new ApiCalculatorCrorepati();
			
			String current_age = request.getParameter("current_age");
	     	String retirement_age = request.getParameter("retirement_age");
            String wealth_amount = request.getParameter("wealth_amount");
            String inflation_rate = request.getParameter("inflation_rate");
            String expected_return = request.getParameter("expected_return");
            String savings_amount = request.getParameter("savings_amount");
            
			if(current_age == null || StringHelper.isEmpty(current_age)){current_age = "";}
            if(retirement_age == null || StringHelper.isEmpty(retirement_age)){retirement_age = "";}
            if(wealth_amount == null || StringHelper.isEmpty(wealth_amount)){wealth_amount = "";}
            if(inflation_rate == null || StringHelper.isEmpty(inflation_rate)){inflation_rate = "";}
            if(expected_return == null || StringHelper.isEmpty(expected_return)){expected_return = "";}
            if(savings_amount == null || StringHelper.isEmpty(savings_amount)){savings_amount = "";}
            
            current_age = current_age.trim();
            retirement_age = retirement_age.trim();
            wealth_amount = wealth_amount.trim();
            inflation_rate = inflation_rate.trim();
            expected_return = expected_return.trim();
            savings_amount = savings_amount.trim();
			
            
            Integer currentAge = Integer.parseInt(current_age);
        	Integer retirementAge = Integer.parseInt(retirement_age);
        	long wealthAmount = Long.parseLong(wealth_amount);
        	Double inflationRate = Double.parseDouble(inflation_rate);
        	Double expectedReturn = Double.parseDouble(expected_return);
        	long savingsAmount = Long.parseLong(savings_amount);
        	
        	//calculation for savings targets
        	Integer years = retirementAge - currentAge;
        	Double value1 = 1 + (inflationRate / 100);
        	Double value2 = Math.pow(value1, years);
        	long target_wealth = Math.round(wealthAmount * value2);
        	Double value3 = 1 + (expectedReturn / 100);
        	Double value5 = Math.pow(value3, years);
        	long target_savings = Math.round(savingsAmount * value5);
        	long target_amount = target_wealth - target_savings;

        	//calculation for monthly savings
        	Double value4 = 0.0;
        	for(int m = 1; m <= years; m++) 
        	{
        		value4 = value4 + Math.pow(value3, m);
        	}
        	
        	Double yearly_savings = (target_amount / value4);
        	long monthly_savings = Math.round(yearly_savings / 12);
        	long invested_amount = (years * 12) * monthly_savings;
        	long total_earnings = target_amount - invested_amount;
            
    		
        	result.setStatus(StatusCodesAndMessages.SuccessCode);
        	result.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
        	result.setMsg(StatusCodesAndMessages.SuccessMessage);
        	result.setCurrent_age(currentAge); 		
        	result.setRetirement_age(retirementAge);
        	result.setWealth_amount(wealthAmount);
        	result.setInflation_rate(inflationRate);
        	result.setExpected_return(expectedReturn);
        	result.setSavings_amount(savingsAmount);
        	result.setTarget_wealth(target_wealth);
        	result.setTarget_savings(target_savings);
        	result.setTarget_amount(target_amount);
        	result.setYears(years);
        	result.setMonthly_savings(monthly_savings);
        	result.setInvested_amount(invested_amount);
        	result.setTotal_earnings(total_earnings);
        	
            apiresponse = gson.toJson(result);
    		writer.print(apiresponse);
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/tools-and-calculators/systematic-investment-plan-calculator")
   	public String sipCalculator(HttpServletRequest request, HttpServletResponse response) 
   	{
       	try 
   		{	 		
	 		String sip_amount = request.getParameter("sip_amount");
	     	String interest_rate = request.getParameter("interest_rate");
            String period = request.getParameter("period");
            
			if(sip_amount == null || StringHelper.isEmpty(sip_amount)){sip_amount = "25000";}
            if(interest_rate == null || StringHelper.isEmpty(interest_rate)){interest_rate = "12.5";}
            if(period == null || StringHelper.isEmpty(period)){period = "120";}
            
            sip_amount = sip_amount.trim();
            interest_rate = interest_rate.trim();
            period = period.trim();
	 		
			request.setAttribute("sip_amount", sip_amount);
			request.setAttribute("interest_rate", interest_rate);
			request.setAttribute("period", period);
			request.setAttribute("page", "tcalc");
			request.setAttribute("menu", "SIP Calculator");
			request.setAttribute("jsp", "../calculator/sip-calculator.jsp");

   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
       	return "layout/layout";
   	}
	
	@RequestMapping(value="/tools-and-calculators/getSIPCalcResult")
	public void getSIPCalcResult(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		PrintWriter writer = null;		
		Gson gson = null;
		String origin = null;
		ApiCalculatorSIP result = null;
		String apiresponse = "";
		
		try 
		{	
			writer = response.getWriter();
			gson = new Gson();
			response.setContentType("text/html");
			origin = request.getHeader("Origin");
			if(origin == null){origin="";}
			result = new ApiCalculatorSIP();
			
			String sip_amount = request.getParameter("sip_amount");
	     	String interest_rate = request.getParameter("interest_rate");
            String period = request.getParameter("period");
            
			if(sip_amount == null || StringHelper.isEmpty(sip_amount)){sip_amount = "";}
            if(interest_rate == null || StringHelper.isEmpty(interest_rate)){interest_rate = "";}
            if(period == null || StringHelper.isEmpty(period)){period = "";}
            
            sip_amount = sip_amount.trim();
            interest_rate = interest_rate.trim();
            period = period.trim();
			

            long sipAmount = Long.parseLong(sip_amount);
        	Double interestRate = Double.parseDouble(interest_rate);
        	Integer sipMonth = Integer.parseInt(period);

        	Double value1 = (interestRate / 100) / 12;
        	Double value3 = 1 + value1;
        	Double value4 = Math.pow((value3), (sipMonth + 1));
        	Double amount1 = (value4 - 1);
        	Double amount2 = amount1 / value1;
        	Double final_amount = (sipAmount * amount2) - sipAmount;
        	long maturity_amount = Math.round(final_amount);
        	long invested_amount = sipAmount * sipMonth;
        	long growth_value = maturity_amount - invested_amount;
            
        	result.setStatus(StatusCodesAndMessages.SuccessCode);
        	result.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
        	result.setMsg(StatusCodesAndMessages.SuccessMessage);
        	result.setSip_amount(sipAmount);
        	result.setInterest_rate(interestRate);
        	result.setPeriod(sipMonth);
        	result.setInvested_amount(invested_amount);
        	result.setGrowth_value(growth_value);
        	result.setMaturity_amount(maturity_amount);
            
           
            apiresponse = gson.toJson(result);
    		writer.print(apiresponse);
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/tools-and-calculators/retirement-planning-calculator")
	public String retirementPlanning(HttpServletRequest request, HttpServletResponse response) 
	{
	       	try 
	   		{
		 		
		 		String current_age = request.getParameter("current_age");
		     	String retirement_age = request.getParameter("retirement_age");
	            String wealth_amount = request.getParameter("wealth_amount");
	            String inflation_rate = request.getParameter("inflation_rate");
	            String expected_return = request.getParameter("expected_return");
	            String savings_amount = request.getParameter("savings_amount");
	            
	            if(current_age == null || StringHelper.isEmpty(current_age)){current_age = "25";}
	            if(retirement_age == null || StringHelper.isEmpty(retirement_age)){retirement_age = "75";}
	            if(wealth_amount == null || StringHelper.isEmpty(wealth_amount)){wealth_amount = "20000000";}
	            if(inflation_rate == null || StringHelper.isEmpty(inflation_rate)){inflation_rate = "7.5";}
	            if(expected_return == null || StringHelper.isEmpty(expected_return)){expected_return = "12.5";}
	            if(savings_amount == null || StringHelper.isEmpty(savings_amount)){savings_amount = "100000";}
	            
	            current_age = current_age.trim();
	            retirement_age = retirement_age.trim();
	            wealth_amount = wealth_amount.trim();
	            inflation_rate = inflation_rate.trim();
	            expected_return = expected_return.trim();
	            savings_amount = savings_amount.trim();
				
				request.setAttribute("current_age", current_age);
				request.setAttribute("retirement_age", retirement_age);
				request.setAttribute("wealth_amount", wealth_amount);
				request.setAttribute("inflation_rate", inflation_rate);
				request.setAttribute("expected_return", expected_return);
				request.setAttribute("savings_amount", savings_amount);
				
				request.setAttribute("menu", "Retirement Planning");
				request.setAttribute("page", "tcalc");
				request.setAttribute("jsp", "../calculator/retirement_calculator.jsp");

	   		}
	       	catch(Exception ex)
	       	{
	       		ex.printStackTrace();
	       	}
	       	return "layout/layout";
	}
	
	@RequestMapping(value="/tools-and-calculators/asset-allocation")
   	public String assetcalc(HttpServletRequest request, HttpServletResponse response) 
   	{
       	try 
   		{
	 		
	 		String age = request.getParameter("age");
	     	String risk = request.getParameter("risk");
            String horizon = request.getParameter("horizon");
            String believe = request.getParameter("believe");
            
            if(age == null || StringHelper.isEmpty(age)){age = "3";}
            if(risk == null || StringHelper.isEmpty(risk)){risk = "3";}
            if(horizon == null || StringHelper.isEmpty(horizon)){horizon = "2";}
            if(believe == null || StringHelper.isEmpty(believe)){believe = "2";}
            
            age = age.trim();
            risk = risk.trim();
            horizon = horizon.trim();
            believe = believe.trim();
			
			request.setAttribute("age", age);
			request.setAttribute("risk", risk);
			request.setAttribute("horizon", horizon);
			request.setAttribute("believe", believe);
			
			request.setAttribute("menu", "Asset Allocation");
			request.setAttribute("page", "tcalc");
			request.setAttribute("jsp", "../calculator/asset_allocation_calculator.jsp");

   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
       	return "layout/layout";
   	}
	
	@RequestMapping(value="/tools-and-calculators/getAssetAllocationResult")
	public void getAssetAllocationResult(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		PrintWriter writer = null;		
		Gson gson = null;
		String origin = null;
		ApiCalculatorAssetAllocation result = null;
		String apiresponse = "";
		
		try 
		{	
			writer = response.getWriter();
			gson = new Gson();
			response.setContentType("text/html");
			origin = request.getHeader("Origin");
			if(origin == null){origin="";}
			result = new ApiCalculatorAssetAllocation();
			
			String current_age = request.getParameter("current_age");
            String risk_profile = request.getParameter("risk_profile");
            String investment_horizon = request.getParameter("investment_horizon");
            String do_you_know = request.getParameter("do_you_know");
            
            if(current_age == null || StringHelper.isEmpty(current_age)){current_age = "";}
            if(risk_profile == null || StringHelper.isEmpty(risk_profile)){risk_profile = "";}
            if(investment_horizon == null || StringHelper.isEmpty(investment_horizon)){investment_horizon = "";}
            if(do_you_know == null || StringHelper.isEmpty(do_you_know)){do_you_know = "";}
            
            current_age = current_age.trim();
            risk_profile = risk_profile.trim();
            investment_horizon = investment_horizon.trim();
            do_you_know = do_you_know.trim();
			
            
            Integer age = Integer.parseInt(current_age);
        	Integer risk = Integer.parseInt(risk_profile);
        	Integer horizon = Integer.parseInt(investment_horizon);
        	Integer believe = Integer.parseInt(do_you_know);
        	
        	int[] angles = {20, 25, 5, 5, 45};
        	
        	if (age == 1)
            {
                angles[0] = 10;
                angles[1] = 15;
                angles[2] = 5;
                angles[3] = 20;
                angles[4] = 50;
            }
            if (age == 2)
            {
                angles[0] = 15;
                angles[1] = 20;
                angles[2] = 5;
                angles[3] = 15;
                angles[4] = 45;
            }
            if (age == 3)
            {
                angles[0] = 20;
                angles[1] = 20;
                angles[2] = 10;
                angles[3] = 10;
                angles[4] = 40;
            }
            if (age == 4)
            {
                angles[0] = 30;
                angles[1] = 15;
                angles[2] = 15;
                angles[3] = 5;
                angles[4] = 35;
            }
            
            if (risk == 1)
            {
                angles[0] = angles[0] + 5;
                angles[1] = angles[1] + 5;
                angles[2] = angles[2];
                angles[3] = angles[3] - 5;
                angles[4] = angles[4] - 5;
            }
            if (risk == 2)
            {
                angles[0] = angles[0] + 2;
                angles[1] = angles[1] + 3;
                angles[2] = angles[2];
                angles[3] = angles[3] - 2;
                angles[4] = angles[4] - 3;
            }
            if (risk == 3)
            {
                angles[0] = angles[0];
                angles[1] = angles[1];
                angles[2] = angles[2];
                angles[3] = angles[3];
                angles[4] = angles[4];
            }
            if (risk == 4)
            {
                angles[0] = angles[0] - 2;
                angles[1] = angles[1] - 3;
                angles[2] = angles[2];
                angles[3] = angles[3] + 2;
                angles[4] = angles[4] + 3;
            }
            if (risk == 5)
            {
                angles[0] = angles[0] - 5;
                angles[1] = angles[1] - 5;
                angles[2] = angles[2];
                angles[3] = angles[3] + 5;
                angles[4] = angles[4] + 5;
            }
            
            if (horizon == 1)
            {
                angles[0] = angles[0] + 5;
                angles[1] = angles[1] + 5;
                angles[2] = angles[2];
                angles[3] = angles[3] - 5;
                angles[4] = angles[4] - 5;
            }
            if (horizon == 2)
            {
                angles[0] = angles[0] + 2;
                angles[1] = angles[1] + 3;
                angles[2] = angles[2];
                angles[3] = angles[3] - 2;
                angles[4] = angles[4] - 3;
            }
            if (horizon == 3)
            {
                angles[0] = angles[0];
                angles[1] = angles[1];
                angles[2] = angles[2];
                angles[3] = angles[3];
                angles[4] = angles[4];
            }
            if (horizon == 4)
            {
                angles[0] = angles[0] - 2;
                angles[1] = angles[1] - 3;
                angles[2] = angles[2];
                angles[3] = angles[3] + 2;
                angles[4] = angles[4] + 3;
            }
            
            if (believe == 1)
            {
                angles[0] = angles[0];
                angles[1] = angles[1];
                angles[2] = angles[2];
                angles[3] = angles[3] + 5;
                angles[4] = angles[4] - 5;
            }
            if (believe == 2)
            {
                angles[0] = angles[0];
                angles[1] = angles[1];
                angles[2] = angles[2];
                angles[3] = angles[3] - 5;
                angles[4] = angles[4] + 5;
            }
            if (believe == 3)
            {
                angles[0] = angles[0];
                angles[1] = angles[1];
                angles[2] = angles[2];
                angles[3] = angles[3];
                angles[4] = angles[4];
            }
            if (angles[3] < 0)
            {
                angles[4] = angles[4] + angles[3];
                angles[3] = angles[3] - angles[3];
            }
            
            Integer debt = angles[0] + angles[1] + angles[2];
            Integer equity = angles[3] + angles[4];
            Integer fmp_debt_value  = angles[0];
            Integer long_term_fixed_value = angles[1];
            Integer cash_liquid_value = angles[2];
            Integer mid_small_cap_value = angles[3];
            Integer large_cap_value = angles[4];
            
        	result.setStatus(StatusCodesAndMessages.SuccessCode);
        	result.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
        	result.setMsg(StatusCodesAndMessages.SuccessMessage);
        	result.setCurrent_age(age);
        	result.setRisk_profile(risk);
        	result.setInvestment_horizon(horizon);
        	result.setDo_you_know(believe);
        	result.setDebt(debt);
        	result.setEquity(equity);
        	result.setFmp_debt_value(fmp_debt_value);
        	result.setLong_term_fixed_value(long_term_fixed_value);
        	result.setCash_liquid_value(cash_liquid_value);
        	result.setMid_small_cap_value(mid_small_cap_value);
        	result.setLarge_cap_value(large_cap_value);
            
            
            apiresponse = gson.toJson(result);
    		writer.print(apiresponse);
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/tools-and-calculators/provident-fund-calculator")
   	public String ppfCalculator(HttpServletRequest request, HttpServletResponse response) 
   	{
       	try 
   		{
	 		String investment_type = request.getParameter("investment_type");
	     	String start_year = request.getParameter("start_year");
            String amount = request.getParameter("amount");
            
            if(investment_type == null || StringHelper.isEmpty(investment_type)){investment_type = "1";}
            if(start_year == null || StringHelper.isEmpty(start_year)){start_year = "2010";}
            if(amount == null || StringHelper.isEmpty(amount)){amount = "2000";}
            
            investment_type = investment_type.trim();
            start_year = start_year.trim();
            amount = amount.trim();
			
			request.setAttribute("investment_type", investment_type);
			request.setAttribute("start_year", start_year);
			request.setAttribute("amount", amount);

			request.setAttribute("menu", "PPF");
			request.setAttribute("page", "tcalc");
			request.setAttribute("jsp", "../calculator/ppf_calculator.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
       	return "layout/layout";
   	}
	
	@RequestMapping(value="/tools-and-calculators/getPPFCalcResult")
	public void getPPFCalcResult(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		PrintWriter writer = null;		
		Gson gson = null;
		String origin = null;
		ApiCalculatorPPF result = null;
		List<ApiCalculatorPPFTable> list = null;
		ApiCalculatorPPFTable table = null;
		String apiresponse = "";
		
		try 
		{	
			writer = response.getWriter();
			gson = new Gson();
			response.setContentType("text/html");
			origin = request.getHeader("Origin");
			if(origin == null){origin="";}
			result = new ApiCalculatorPPF();
			list = new ArrayList<ApiCalculatorPPFTable>();
			
			String ppf_type = request.getParameter("ppf_type");
	     	String ppf_start_year = request.getParameter("ppf_start_year");
            String amount_array = request.getParameter("amount_array");
            
			if(ppf_type == null || StringHelper.isEmpty(ppf_type)){ppf_type = "";}
            if(ppf_start_year == null || StringHelper.isEmpty(ppf_start_year)){ppf_start_year = "";}
            if(amount_array == null || StringHelper.isEmpty(amount_array)){amount_array = "";}
            
            ppf_type = ppf_type.trim();
            ppf_start_year = ppf_start_year.trim();
            amount_array = amount_array.trim();
			
            Integer value = Integer.parseInt(ppf_type);
        	Integer years = Integer.parseInt(ppf_start_year);
        	List<String> amountList = new ArrayList<String>(Arrays.asList(amount_array.split(",")));
        	
        	Double OBal = 0.0;
        	Double CBal = 0.0;
        	Double[] CBalA = new Double[100];
        	Double Loan = 0.0;
        	Double Wid = 0.0;
        	Integer yer = years;
        	Calendar cal1 = Calendar.getInstance();
        	Integer current_year = cal1.get(Calendar.YEAR);
        	
        	Double intRate = 0.0;
        	for(int i=1;i<16;i++)
        	{
        		Integer yearText = (yer+i)-1;
        		if(yearText > current_year)
        		{
        			continue;
        		}
        		Double RateOfInt = 0.080;
        		if(yearText == 1980)
        		{
        			RateOfInt = 0.080;
        			intRate = 8.00;
        			
        		}else if(yearText == 1981 || yearText == 1982)
        		{
        			RateOfInt = 0.085;
        			intRate = 8.50;
        			
        		}else if(yearText == 1983)
        		{
        			RateOfInt = 0.090;
        			intRate = 9.00;
        			
        		}else if(yearText == 1984)
        		{
        			RateOfInt = 0.095;
        			intRate = 9.50;
        			
        		}else if(yearText == 1985)
        		{
        			RateOfInt = 0.10;
        			intRate = 10.00;
        			
        		}else if(yearText >= 1986 && yearText <= 1999)
        		{
        			RateOfInt = 0.12;
        			intRate = 12.00;
        			
        		}else if(yearText == 2000)
        		{
        			RateOfInt = 0.11;
        			intRate = 11.00;
        			
        		}else if(yearText == 2001)
        		{
        			RateOfInt = 0.095;
        			intRate = 9.50;
        			
        		}else if(yearText == 2002)
        		{
        			RateOfInt = 0.090;
        			intRate = 9.00;
        			
        		}else if(yearText >= 2003 && yearText <= 2010)
        		{
        			RateOfInt = 0.080;
        			intRate = 8.00;
        			
        		}else if(yearText == 2011)
        		{
        			RateOfInt = 0.086;
        			intRate = 8.60;
        			
        		}else if (yearText == 2012)
        		{
        			RateOfInt = 0.088; 
        			intRate = 8.80; 
        			
        		}else if(yearText >= 2013 && yearText <= 2015)
        		{
        			RateOfInt = 0.087; 
        			intRate = 8.70; 
        			
        		}else if (yearText == 2016)
        		{
        			RateOfInt = 0.081; 
        			intRate = 8.10; 
        			
        		}else
        		{
        			RateOfInt = 0.087; 
        			intRate = 8.70; 
        		}
        		Double investAmount = 0.0;
        		if(value == 1)
        		{
        			investAmount = Double.parseDouble(amountList.get(i-1));
        		}else
        		{
        			investAmount = Double.parseDouble(amountList.get(0));
        		}
        		Double TInvAmt = OBal + investAmount;
        		Double Interest = RateOfInt * TInvAmt;					
        		CBal = (TInvAmt + Interest);
        		CBalA[i] = CBal;
        		if(i>2)
        		{
        			Loan = (CBalA[i-2]*0.25);
        		}else
        		{
        			Loan = 0.0;
        		}
        		if(i>6)
        		{
        			Wid = (CBalA[i-3]*0.5);
        		}else
        		{
        			Wid = 0.0;
        		}
        		
        		table = new ApiCalculatorPPFTable();
        		table.setYear(yearText);
        		table.setInterest_rate(intRate);
        		table.setOpening_balance(OBal);
        		table.setInvestment_amount(investAmount);
        		table.setTotal_investment_amount(TInvAmt);
        		table.setInterest(Interest);
        		table.setCloseing_balance(CBal);
        		table.setWithdrawal(Wid);
        		table.setLoan_value(Loan);
        		list.add(table);

        		OBal = CBal;		
        	}	
            
        	result.setStatus(StatusCodesAndMessages.SuccessCode);
        	result.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
        	result.setMsg(StatusCodesAndMessages.SuccessMessage);
        	result.setList(list); 
           
            apiresponse = gson.toJson(result);
    		writer.print(apiresponse);
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/tools-and-calculators/employees-provident-fund-calculator")
	public String epfCalculator(HttpServletRequest request, HttpServletResponse response) 
	{
    	try 
		{
 	 		
 	 		String age = request.getParameter("age");
 	     	String RetAge = request.getParameter("RetAge");
             String EPF = request.getParameter("EPF");
             String EmpC = request.getParameter("EmpC");
 	     	String EmprC = request.getParameter("EmprC");
             String GrthRate = request.getParameter("GrthRate");
             String Rate = request.getParameter("Rate");
             String CPF = request.getParameter("CPF");
             
             if(age == null || StringHelper.isEmpty(age)){age = "30";}
             if(RetAge == null || StringHelper.isEmpty(RetAge)){RetAge = "60";}
             if(EPF == null || StringHelper.isEmpty(EPF)){EPF = "25000";}
             if(EmpC == null || StringHelper.isEmpty(EmpC)){EmpC = "1000";}
             if(EmprC == null || StringHelper.isEmpty(EmprC)){EmprC = "1000";}
             if(GrthRate == null || StringHelper.isEmpty(GrthRate)){GrthRate = "8";}
             if(Rate == null || StringHelper.isEmpty(Rate)){Rate = "8";}
             if(CPF == null || StringHelper.isEmpty(CPF)){CPF = "25000";}
             
             age = age.trim();
             RetAge = RetAge.trim();
             EPF = EPF.trim();
             EmpC = EmpC.trim();
             EmprC = EmprC.trim();
             GrthRate = GrthRate.trim();
             Rate = Rate.trim();
             CPF = CPF.trim();
 			
 			request.setAttribute("age", age);
 			request.setAttribute("RetAge", RetAge);
 			request.setAttribute("EPF", EPF);
 			request.setAttribute("EmpC", EmpC);
 			request.setAttribute("EmprC", EmprC);
 			request.setAttribute("GrthRate", GrthRate);
 			request.setAttribute("Rate", Rate);
 			request.setAttribute("CPF", CPF);
 			
 			request.setAttribute("menu", "Employees PF");
 			request.setAttribute("page", "tcalc");
 			request.setAttribute("jsp", "../calculator/epf_calculator.jsp");

		}
    	catch(Exception ex)
    	{
    		ex.printStackTrace();
    	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/tools-and-calculators/getEPFCalcResult")
		public void getEPFCalcResult(HttpServletRequest request, HttpServletResponse response) throws IOException
		{
			PrintWriter writer = null;		
			Gson gson = null;
			String origin = null;
			ApiCalculatorEPF result = null;
			List<ApiCalculatorEPFTable> list = null;
			ApiCalculatorEPFTable table = null;
			String apiresponse = "";
			
			try 
			{	
				writer = response.getWriter();
				gson = new Gson();
				response.setContentType("text/html");
				origin = request.getHeader("Origin");
				if(origin == null){origin="";}
				result = new ApiCalculatorEPF();
				list = new ArrayList<ApiCalculatorEPFTable>();
				
				String current_age = request.getParameter("current_age");
		     	String retirement_age = request.getParameter("retirement_age");
	            String epf_balance = request.getParameter("epf_balance");
	            String employee_contibution = request.getParameter("employee_contibution");
	            String employer_contibution = request.getParameter("employer_contibution");
	            String epf_growth_rate = request.getParameter("epf_growth_rate");
	            String interest_rate = request.getParameter("interest_rate");
	            String pension_fund_balance = request.getParameter("pension_fund_balance");
	            
				if(current_age == null || StringHelper.isEmpty(current_age)){current_age = "";}
	            if(retirement_age == null || StringHelper.isEmpty(retirement_age)){retirement_age = "";}
	            if(epf_balance == null || StringHelper.isEmpty(epf_balance)){epf_balance = "";}
	            if(employee_contibution == null || StringHelper.isEmpty(employee_contibution)){employee_contibution = "";}
	            if(employer_contibution == null || StringHelper.isEmpty(employer_contibution)){employer_contibution = "";}
	            if(interest_rate == null || StringHelper.isEmpty(interest_rate)){interest_rate = "";}
	            if(epf_growth_rate == null || StringHelper.isEmpty(epf_growth_rate)){epf_growth_rate = "";}
	            if(pension_fund_balance == null || StringHelper.isEmpty(pension_fund_balance)){pension_fund_balance = "";}
	            
	            current_age = current_age.trim();
	            retirement_age = retirement_age.trim();
	            epf_balance = epf_balance.trim();
	            employee_contibution = employee_contibution.trim();
	            employer_contibution = employer_contibution.trim();
	            epf_growth_rate = epf_growth_rate.trim();
	            interest_rate = interest_rate.trim();
	            pension_fund_balance = pension_fund_balance.trim();
				
	            Integer age = Integer.parseInt(current_age);
	        	Integer RetAge = Integer.parseInt(retirement_age);
	        	Double EPF = Double.parseDouble(epf_balance);
	        	Double EmpC = Double.parseDouble(employee_contibution);
	        	Double EmprC = Double.parseDouble(employer_contibution);
	        	Double GrthRate = Double.parseDouble(epf_growth_rate);
	        	Double Rate = Double.parseDouble(interest_rate);
	        	Double CPF = Double.parseDouble(pension_fund_balance);
	        	
	        	Double clsEPF = 0.0;
	        	Double erCTR = 0.0;
	        	Double eCTR = 0.0;
	        	Double pens = 0.0;
	        	Double pens1 = 0.0;

	            eCTR = EmpC;
	            erCTR = EmprC - 541;
	            Double eprCtr = EmprC;
	            pens1 = (541.0 * 12);
	            pens = (+pens1) + (+CPF);
	            Integer yrs = RetAge - age;
	               
	            for (int i = 1; i <= yrs + 1; i++) 
	        	{
	            	clsEPF = futureValue(((Rate / 100) / 12), 12.0, -eCTR - erCTR, -EPF);
	            	
	            	table = new ApiCalculatorEPFTable();
	            	table.setAge(age);
	            	table.setOpening_epf_balance(EPF);
	            	table.setEmployee_contribution(eCTR);
	            	table.setEmployer_contribution(erCTR);
	            	table.setClosing_epf_balance(clsEPF);
	            	table.setPension_fund_value(pens);
	            	list.add(table);

	                age = age + 1;
	                EPF = clsEPF;
	                eCTR = eCTR * (1 + GrthRate / 100);
	                erCTR = (eprCtr * (1 + GrthRate / 100)) - 541;
	                eprCtr = eprCtr * (1 + GrthRate / 100);
	                pens = (+pens1) + (+pens);     
	            }
	            
	        	result.setStatus(StatusCodesAndMessages.SuccessCode);
	        	result.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
	        	result.setMsg(StatusCodesAndMessages.SuccessMessage);
	        	result.setList(list);            
	            
	            apiresponse = gson.toJson(result);
	    		writer.print(apiresponse);
			    writer.close();
			} 
			catch (Exception ex) 
			{
				ex.printStackTrace();
			}
	}
	
	@RequestMapping(value="/tools-and-calculators/goal-setting-calculator")
   	public String expenseGoalPlanner(HttpServletRequest request, HttpServletResponse response) 
   	{
       	try 
   		{
	 		
	 		String years = request.getParameter("years");
	     	String dream_amount = request.getParameter("dream_amount");
            String inflation_rate = request.getParameter("inflation_rate");
            String expected_return = request.getParameter("expected_return");
            String savings_amount = request.getParameter("savings_amount");
            
			if(years == null || StringHelper.isEmpty(years)){years = "30";}
            if(dream_amount == null || StringHelper.isEmpty(dream_amount)){dream_amount = "10000000";}
            if(inflation_rate == null || StringHelper.isEmpty(inflation_rate)){inflation_rate = "8";}
            if(expected_return == null || StringHelper.isEmpty(expected_return)){expected_return = "12";}
            if(savings_amount == null || StringHelper.isEmpty(savings_amount)){savings_amount = "0";}
            
            years = years.trim();
            dream_amount = dream_amount.trim();
            inflation_rate = inflation_rate.trim();
            expected_return = expected_return.trim();
            savings_amount = savings_amount.trim();
	 		
			request.setAttribute("years", years);
			request.setAttribute("dream_amount", dream_amount);
			request.setAttribute("inflation_rate", inflation_rate);
			request.setAttribute("expected_return", expected_return);
			request.setAttribute("savings_amount", savings_amount);
			
			request.setAttribute("menu", "Goal Setting");
			request.setAttribute("page", "tcalc");
			request.setAttribute("jsp", "../calculator/expense_calculator.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
       	return "layout/layout";
   	}
 
@RequestMapping(value="/tools-and-calculators/getGoalSettingCalcResult")
public void getGoalSettingCalcResult(HttpServletRequest request, HttpServletResponse response) throws IOException
{
		PrintWriter writer = null;		
		Gson gson = null;
		String origin = null;
		ApiCalculatorGoalSetting result = null;
		String apiresponse = "";
		
		try 
		{	
			writer = response.getWriter();
			gson = new Gson();
			response.setContentType("text/html");
			origin = request.getHeader("Origin");
			if(origin == null){origin="";}
			result = new ApiCalculatorGoalSetting();
			
			String years = request.getParameter("years");
	     	String dream_amount = request.getParameter("dream_amount");
            String inflation_rate = request.getParameter("inflation_rate");
            String expected_return = request.getParameter("expected_return");
            String savings_amount = request.getParameter("savings_amount");
            
			if(years == null || StringHelper.isEmpty(years)){years = "";}
            if(dream_amount == null || StringHelper.isEmpty(dream_amount)){dream_amount = "";}
            if(inflation_rate == null || StringHelper.isEmpty(inflation_rate)){inflation_rate = "";}
            if(expected_return == null || StringHelper.isEmpty(expected_return)){expected_return = "";}
            if(savings_amount == null || StringHelper.isEmpty(savings_amount)){savings_amount = "";}
            
            years = years.trim();
            dream_amount = dream_amount.trim();
            inflation_rate = inflation_rate.trim();
            expected_return = expected_return.trim();
            savings_amount = savings_amount.trim();
			
            Integer year1 = Integer.parseInt(years);
        	long amount = Long.parseLong(dream_amount);
        	long savings_amount1 = Long.parseLong(savings_amount);
        	Double inflation = Double.parseDouble(inflation_rate);
        	Double rate_of_return = Double.parseDouble(expected_return);

        	Double value1 = 1 + (inflation / 100);
        	Double value2 = Math.pow(value1, year1);
        	Double value3 = 1 + (rate_of_return / 100);
        	Double value5 = Math.pow(value3, year1);
        	long target_dream_amount = Math.round(amount * value2);
        	long target_savings_amount = Math.round(savings_amount1 * value5);
        	long target_amount = target_dream_amount - target_savings_amount;
        	
        	Double value4 = 0.0;
        	for(int k = 1; k <= year1; k++) 
        	{
        		value4 = value4 + Math.pow(value3,k);
        	}
        	long yearly_savings = Math.round(target_amount / value4);
        	long monthly_savings = (yearly_savings / 12);
        	monthly_savings = Math.round(monthly_savings);
        	long invested_amount = (year1 * 12) * monthly_savings;
        	long total_earnings = target_amount - invested_amount;
            
        	result.setStatus(StatusCodesAndMessages.SuccessCode);
        	result.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
        	result.setMsg(StatusCodesAndMessages.SuccessMessage);
        	result.setYears(year1);
        	result.setDream_amount(amount);
        	result.setInflation_rate(inflation);
        	result.setExpected_return(rate_of_return);
        	result.setSavings_amount(savings_amount1);
        	result.setTarget_dream_amount(target_dream_amount);
        	result.setTarget_savings_amount(target_savings_amount);
        	result.setTarget_amount(target_amount);
        	result.setMonthly_savings(monthly_savings);
        	result.setInvested_amount(invested_amount);
        	result.setTotal_earnings(total_earnings);            
            
            apiresponse = gson.toJson(result);
    		writer.print(apiresponse);
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}

	@RequestMapping(value="/tools-and-calculators/composite-financial-goal-planner-calculator")
	public String personalCompositeGoalPlanner(HttpServletRequest request, HttpServletResponse response) 
	{
   	try 
		{
 		
		String child_current_age = request.getParameter("child_current_age");
     	String child_education_age = request.getParameter("child_education_age");
        String education_amount = request.getParameter("education_amount");
        String current_age = request.getParameter("current_age");
        String wealth_age = request.getParameter("wealth_age");
     	String wealth_amount = request.getParameter("wealth_amount");
        String expense_amount = request.getParameter("expense_amount");
        String expense_year = request.getParameter("expense_year");
        String inflation_rate = request.getParameter("inflation_rate");
        String expected_return = request.getParameter("expected_return");
        String savings_amount = request.getParameter("savings_amount");
        
		if(child_current_age == null || StringHelper.isEmpty(child_current_age)){child_current_age = "5";}
        if(child_education_age == null || StringHelper.isEmpty(child_education_age)){child_education_age = "25";}
        if(education_amount == null || StringHelper.isEmpty(education_amount)){education_amount = "2500000";}
        if(current_age == null || StringHelper.isEmpty(current_age)){current_age = "25";}
        if(wealth_age == null || StringHelper.isEmpty(wealth_age)){wealth_age = "60";}
        if(wealth_amount == null || StringHelper.isEmpty(wealth_amount)){wealth_amount = "5000000";}
        if(expense_amount == null || StringHelper.isEmpty(expense_amount)){expense_amount = "1500000";}
        if(expense_year == null || StringHelper.isEmpty(expense_year)){expense_year = "30";}
        if(inflation_rate == null || StringHelper.isEmpty(inflation_rate)){inflation_rate = "7.5";}
        if(expected_return == null || StringHelper.isEmpty(expected_return)){expected_return = "12.5";}
        if(savings_amount == null || StringHelper.isEmpty(savings_amount)){savings_amount = "500000";}
        
        child_current_age = child_current_age.trim();
        child_education_age = child_education_age.trim();
        education_amount = education_amount.trim();
        current_age = current_age.trim();
        wealth_age = wealth_age.trim();
        wealth_amount = wealth_amount.trim();
        expense_amount = expense_amount.trim();
        expense_year = expense_year.trim();
        inflation_rate = inflation_rate.trim();
        expected_return = expected_return.trim();
        savings_amount = savings_amount.trim();
        
        request.setAttribute("child_current_age", child_current_age);
		request.setAttribute("child_education_age", child_education_age);
		request.setAttribute("education_amount", education_amount);
		request.setAttribute("current_age", current_age);
		request.setAttribute("wealth_age", wealth_age);
		request.setAttribute("wealth_amount", wealth_amount);
		request.setAttribute("expense_amount", expense_amount);
		request.setAttribute("expense_year", expense_year);
		request.setAttribute("inflation_rate", inflation_rate);
		request.setAttribute("expected_return", expected_return);
		request.setAttribute("savings_amount", savings_amount);
		
		request.setAttribute("menu", "Composite Financial Goal");
		request.setAttribute("page", "tcalc");
		request.setAttribute("jsp", "../calculator/personal_composite_calculator.jsp");
		}
   	catch(Exception ex)
   	{
   		ex.printStackTrace();
   	}
   	return "layout/layout";
	}

	@RequestMapping(value="/tools-and-calculators/getCompositeFinancialGoalPlannerResult")
	public void getCompositeFinancialGoalPlannerResult(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		PrintWriter writer = null;		
		Gson gson = null;
		String origin = null;
		ApiCalculatorCompositePlanner result = null;
		String apiresponse = "";
		
		try 
		{	
			writer = response.getWriter();
			gson = new Gson();
			response.setContentType("text/html");
			origin = request.getHeader("Origin");
			if(origin == null){origin="";}
			result = new ApiCalculatorCompositePlanner();
			
			String child_current_age = request.getParameter("child_current_age");
	     	String child_education_age = request.getParameter("child_education_age");
	        String education_amount = request.getParameter("education_amount");
	        String current_age = request.getParameter("current_age");
	        String wealth_age = request.getParameter("wealth_age");
	     	String wealth_amount = request.getParameter("wealth_amount");
	        String expense_amount = request.getParameter("expense_amount");
	        String expense_year = request.getParameter("expense_year");
	        String inflation_rate = request.getParameter("inflation_rate");
	        String expected_return = request.getParameter("expected_return");
	        String savings_amount = request.getParameter("savings_amount");
	        
			if(child_current_age == null || StringHelper.isEmpty(child_current_age)){child_current_age = "";}
	        if(child_education_age == null || StringHelper.isEmpty(child_education_age)){child_education_age = "";}
	        if(education_amount == null || StringHelper.isEmpty(education_amount)){education_amount = "";}
	        if(current_age == null || StringHelper.isEmpty(current_age)){current_age = "";}
	        if(wealth_age == null || StringHelper.isEmpty(wealth_age)){wealth_age = "";}
	        if(wealth_amount == null || StringHelper.isEmpty(wealth_amount)){wealth_amount = "";}
	        if(expense_amount == null || StringHelper.isEmpty(expense_amount)){expense_amount = "";}
	        if(expense_year == null || StringHelper.isEmpty(expense_year)){expense_year = "";}
	        if(inflation_rate == null || StringHelper.isEmpty(inflation_rate)){inflation_rate = "";}
	        if(expected_return == null || StringHelper.isEmpty(expected_return)){expected_return = "";}
	        if(savings_amount == null || StringHelper.isEmpty(savings_amount)){savings_amount = "";}
	        
	        child_current_age = child_current_age.trim();
	        child_education_age = child_education_age.trim();
	        education_amount = education_amount.trim();
	        current_age = current_age.trim();
	        wealth_age = wealth_age.trim();
	        wealth_amount = wealth_amount.trim();
	        expense_amount = expense_amount.trim();
	        expense_year = expense_year.trim();
	        inflation_rate = inflation_rate.trim();
	        expected_return = expected_return.trim();
	        savings_amount = savings_amount.trim();
			
	        Integer childAge = Integer.parseInt(child_current_age);
	    	Integer childEducationAge = Integer.parseInt(child_education_age);
	    	long educationAmount = Long.parseLong(education_amount);
	    	long educationAmount_init = Long.parseLong(education_amount);
	    	Integer currentAge = Integer.parseInt(current_age);
	    	Integer retireAge = Integer.parseInt(wealth_age);
	    	long wealthyAmount = Long.parseLong(wealth_amount);
	    	long wealthyAmount_init = Long.parseLong(wealth_amount);
	    	long dreamAmount = Long.parseLong(expense_amount);
	    	long dreamAmount_init = Long.parseLong(expense_amount);
	    	Integer dreamExpenseYear = Integer.parseInt(expense_year);
	    	Double increaseRate = Double.parseDouble(inflation_rate);
	    	Double rateOfReturn = Double.parseDouble(expected_return);
	    	long investmentAmount = Long.parseLong(savings_amount);
	    	long investmentAmount_init = Long.parseLong(savings_amount);
	
	    	long current_total_amount = educationAmount + wealthyAmount + dreamAmount;
	    	
	    	long currentAmountEdu = Math.round((investmentAmount * educationAmount) / current_total_amount);
	    	long currentAmountWel = Math.round((investmentAmount * wealthyAmount) / current_total_amount);
	    	long currentAmountDir = Math.round((investmentAmount * dreamAmount) / current_total_amount);
	    	
	    	Integer eduAgeDiff = childEducationAge - childAge;
	    	//calculation for savings targets
	    	Double edu_value1 = 1 + (increaseRate / 100);
	    	Double edu_value2 = Math.pow(edu_value1,eduAgeDiff);
	    	long eduSavingsTarget = Math.round(educationAmount * edu_value2);
	    	long eduSavingsTargetAmt = Math.round(currentAmountEdu * edu_value2);
	    	eduSavingsTargetAmt = eduSavingsTarget - eduSavingsTargetAmt;
	
	    	//calculation for monthly savings
	    	Double edu_value3 = 1 + (rateOfReturn / 100);
	    	Double edu_value4 = 0.0;
	    	for(int m = 1; m <= eduAgeDiff; m++) {
	    		edu_value4 = edu_value4 + Math.pow(edu_value3,m);
	    	}
	    	Double yearlySavingsEdu = (eduSavingsTargetAmt / edu_value4);
	    	long monthlySavingsEdu = Math.round(yearlySavingsEdu / 12.0);
	    	
	    	Integer welAgeDiff = retireAge - currentAge;
	    	//calculation for savings targets
	    	Double wel_value1 = 1 + (increaseRate / 100);
	    	Double wel_value2 = Math.pow(wel_value1,welAgeDiff);
	    	long welSavingsTarget = Math.round(wealthyAmount * wel_value2);
	    	long welSavingsTargetAmt = Math.round(currentAmountWel * wel_value2);
	    	welSavingsTargetAmt = welSavingsTarget - welSavingsTargetAmt;
	
	    	//calculation for monthly savings
	    	Double wel_value3 = 1 + (rateOfReturn / 100);
	    	Double wel_value4 = 0.0;
	    	for(int n = 1; n <= welAgeDiff; n++) {
	    		wel_value4 = wel_value4 + Math.pow(wel_value3,n);
	    	}
	    	Double yearlySavingsWel = (welSavingsTargetAmt / wel_value4);
	    	long monthlySavingsWel = Math.round(yearlySavingsWel / 12.0);
	    	
	    	Integer DreAgeDiff = dreamExpenseYear;
	    	//calculation for savings targets
	    	Double dre_value1 = 1 + (increaseRate / 100);
	    	Double dre_value2 = Math.pow(dre_value1,DreAgeDiff);
	    	long dreSavingsTarget = Math.round(dreamAmount * dre_value2);
	    	long dreSavingsTargetAmt = Math.round(currentAmountDir * dre_value2);
	    	dreSavingsTargetAmt = dreSavingsTarget - dreSavingsTargetAmt;
	
	    	//calculation for monthly savings
	    	Double dre_value3 = 1 + (rateOfReturn / 100);
	    	Double dre_value4 = 0.0;
	    	for(int p = 1; p <= DreAgeDiff; p++) {
	    		dre_value4 = dre_value4 + Math.pow(dre_value3,p);
	    	}
	    	Double yearlySavingsDre = (dreSavingsTargetAmt / dre_value4);
	    	long monthlySavingsDre = Math.round(yearlySavingsDre / 12.0);
	    	
	    	long totalCurrentPrice = educationAmount + wealthyAmount + dreamAmount;
	    	long totalPriceInc = eduSavingsTarget + welSavingsTarget + dreSavingsTarget;
	    	long totalMonthlySavings = Math.round(monthlySavingsEdu) + Math.round(monthlySavingsWel) + Math.round(monthlySavingsDre);
	        
	    	result.setStatus(StatusCodesAndMessages.SuccessCode);
	    	result.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
	    	result.setMsg(StatusCodesAndMessages.SuccessMessage);
	    	result.setChild_current_age(childAge);
	    	result.setChild_education_age(childEducationAge);
	    	result.setEducation_amount(educationAmount_init);
	    	result.setCurrent_age(currentAge);
	    	result.setWealth_age(retireAge);
	    	result.setWealth_amount(wealthyAmount_init);
	    	result.setExpense_amount(dreamAmount_init);
	    	result.setExpense_year(dreamExpenseYear);
	    	result.setInflation_rate(increaseRate);
	    	result.setExpected_return(rateOfReturn);
	    	result.setSavings_amount(investmentAmount_init);
	    	result.setTotal_education_amount(educationAmount);
	    	result.setTotal_wealth_amount(wealthyAmount);
	    	result.setTotal_expense_amount(dreamAmount);
	    	result.setTotal_current_value(totalCurrentPrice);
	    	result.setFinal_education_year(eduAgeDiff);
	    	result.setFinal_wealth_year(welAgeDiff);
	    	result.setFinal_expense_year(DreAgeDiff);
	    	result.setEducation_target(eduSavingsTarget);
	    	result.setWealth_target(welSavingsTarget);
	    	result.setExpense_target(dreSavingsTarget);
	    	result.setTotal_inflation_adjust_value(totalPriceInc);
	    	result.setEducation_savings_amount(currentAmountEdu);
	    	result.setWealth_savings_amount(currentAmountWel);
	    	result.setExpense_savings_amount(currentAmountDir);
	    	result.setTotal_savings_amount(investmentAmount);
	    	result.setEducation_monthly_savings(monthlySavingsEdu);
	    	result.setWealth_monthly_savings(monthlySavingsWel);
	    	result.setExpense_monthly_savings(monthlySavingsDre);
	    	result.setTotal_monthly_savings(totalMonthlySavings);
	        
	        apiresponse = gson.toJson(result);
			writer.print(apiresponse);
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/tools-and-calculators/children-education-planner")
   	public String educationplanner(HttpServletRequest request, HttpServletResponse response) 
   	{
       	try 
   		{
	 		
			String childName1 = request.getParameter("childName1");
	     	String childName2 = request.getParameter("childName2");
            String childAge1 = request.getParameter("childAge1");
            String childAge2 = request.getParameter("childAge2");
            String profEduAge1 = request.getParameter("profEduAge1");
	     	String profEduAge2 = request.getParameter("profEduAge2");
            String eduAmount1 = request.getParameter("eduAmount1");
            String eduAmount2 = request.getParameter("eduAmount2");
            String priceIncRate = request.getParameter("priceIncRate");
            String rateOfReturn = request.getParameter("rateOfReturn");
            String investAmount = request.getParameter("investAmount");
            
			if(childName1 == null || StringHelper.isEmpty(childName1)){childName1 = "Raju";}
            if(childName2 == null || StringHelper.isEmpty(childName2)){childName2 = "";}
            if(childAge1 == null || StringHelper.isEmpty(childAge1)){childAge1 = "10";}
            if(childAge2 == null || StringHelper.isEmpty(childAge2)){childAge2 = "";}
            if(profEduAge1 == null || StringHelper.isEmpty(profEduAge1)){profEduAge1 = "20";}
            if(profEduAge2 == null || StringHelper.isEmpty(profEduAge2)){profEduAge2 = "";}
            if(eduAmount1 == null || StringHelper.isEmpty(eduAmount1)){eduAmount1 = "500000";}
            if(eduAmount2 == null || StringHelper.isEmpty(eduAmount2)){eduAmount2 = "";}
            if(priceIncRate == null || StringHelper.isEmpty(priceIncRate)){priceIncRate = "5";}
            if(rateOfReturn == null || StringHelper.isEmpty(rateOfReturn)){rateOfReturn = "8";}
            if(investAmount == null || StringHelper.isEmpty(investAmount)){investAmount = "10000";}
            
            childName1 = childName1.trim();
            childName2 = childName2.trim();
            childAge1 = childAge1.trim();
            childAge2 = childAge2.trim();
            profEduAge1 = profEduAge1.trim();
            profEduAge2 = profEduAge2.trim();
            eduAmount1 = eduAmount1.trim();
            eduAmount2 = eduAmount2.trim();
            priceIncRate = priceIncRate.trim();
            rateOfReturn = rateOfReturn.trim();
            investAmount = investAmount.trim();
            
            request.setAttribute("childName1", childName1);
			request.setAttribute("childName2", childName2);
			request.setAttribute("childAge1", childAge1);
			request.setAttribute("childAge2", childAge2);
			request.setAttribute("profEduAge1", profEduAge1);
			request.setAttribute("profEduAge2", profEduAge2);
			request.setAttribute("eduAmount1", eduAmount1);
			request.setAttribute("eduAmount2", eduAmount2);
			request.setAttribute("priceIncRate", priceIncRate);
			request.setAttribute("rateOfReturn", rateOfReturn);
			request.setAttribute("investAmount", investAmount);

			request.setAttribute("menu", "Children Education");
			request.setAttribute("page", "tcalc");
			request.setAttribute("jsp", "../calculator/education_planner_calculator.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
       	return "layout/layout";
   	}
	
	 @RequestMapping(value="/tools-and-calculators/getEducationPlannerResult")
		public void getEducationPlannerResult(HttpServletRequest request, HttpServletResponse response) throws IOException
		{
			PrintWriter writer = null;		
			Gson gson = null;
			String origin = null;
			ApiCalculatorEducationPlanner result = null;
			String apiresponse = "";
			
			try 
			{	
				writer = response.getWriter();
				gson = new Gson();
				response.setContentType("text/html");
				origin = request.getHeader("Origin");
				if(origin == null){origin="";}
				result = new ApiCalculatorEducationPlanner();
				
				String child1_name = request.getParameter("child1_name");
		     	String child2_name = request.getParameter("child2_name");
	            String child1_current_age = request.getParameter("child1_current_age");
	            String child2_current_age = request.getParameter("child2_current_age");
	            String child1_education_age = request.getParameter("child1_education_age");
		     	String child2_education_age = request.getParameter("child2_education_age");
	            String child1_education_amount = request.getParameter("child1_education_amount");
	            String child2_education_amount = request.getParameter("child2_education_amount");
	            String inflation_rate = request.getParameter("inflation_rate");
	            String expected_return = request.getParameter("expected_return");
	            String savings_amount = request.getParameter("savings_amount");
	            
				if(child1_name == null || StringHelper.isEmpty(child1_name)){child1_name = "";}
	            if(child2_name == null || StringHelper.isEmpty(child2_name)){child2_name = "";}
	            if(child1_current_age == null || StringHelper.isEmpty(child1_current_age)){child1_current_age = "";}
	            if(child2_current_age == null || StringHelper.isEmpty(child2_current_age)){child2_current_age = "";}
	            if(child1_education_age == null || StringHelper.isEmpty(child1_education_age)){child1_education_age = "";}
	            if(child2_education_age == null || StringHelper.isEmpty(child2_education_age)){child2_education_age = "";}
	            if(child1_education_amount == null || StringHelper.isEmpty(child1_education_amount)){child1_education_amount = "";}
	            if(child2_education_amount == null || StringHelper.isEmpty(child2_education_amount)){child2_education_amount = "";}
	            if(inflation_rate == null || StringHelper.isEmpty(inflation_rate)){inflation_rate = "";}
	            if(expected_return == null || StringHelper.isEmpty(expected_return)){expected_return = "";}
	            if(savings_amount == null || StringHelper.isEmpty(savings_amount)){savings_amount = "";}
	            
	            child1_name = child1_name.trim();
	            child2_name = child2_name.trim();
	            child1_current_age = child1_current_age.trim();
	            child2_current_age = child2_current_age.trim();
	            child1_education_age = child1_education_age.trim();
	            child2_education_age = child2_education_age.trim();
	            child1_education_amount = child1_education_amount.trim();
	            child2_education_amount = child2_education_amount.trim();
	            inflation_rate = inflation_rate.trim();
	            expected_return = expected_return.trim();
	            savings_amount = savings_amount.trim();
				
	                        
	            String childName1 = child1_name;
	        	String childName2 = child2_name;
	        	
	        	Integer child_count = 0;
	            if(childName1 != "")
	            {
	            	child_count++;
	            }
	            if(childName2 != "")
	            {
	            	child_count++;
	            }
	        	
	        	Integer childAge1 = Integer.parseInt(child1_current_age);
	        	Integer profEduAge1 = Integer.parseInt(child1_education_age);
	        	long eduAmount1 = Long.parseLong(child1_education_amount);
	        	Integer childAge2 = 0;
	        	Integer profEduAge2 = 0;
	        	long eduAmount2 = 0;
	        	
	        	if(child_count == 2)
	        	{
	        		childAge2 = Integer.parseInt(child2_current_age);
	            	profEduAge2 = Integer.parseInt(child2_education_age);
	            	eduAmount2 = Long.parseLong(child2_education_amount);
	        	}
	        	
	        	Double priceIncRate = Double.parseDouble(inflation_rate);
	        	Double rateOfReturn = Double.parseDouble(expected_return);
	        	long investAmount = Long.parseLong(savings_amount);
	        	
	        	//Current Investment amount is divided between the children, if 2
	        	long currentInvestAmount1 = 0;
	        	long currentInvestAmount2 = 0;
	        	long totalEduAmount = 0;
	        	Integer ageDiff1 = 0;
	        	Integer ageDiff2 = 0;
	        	long savingsTarget1 = 0;
	        	long savingsTarget2 = 0;
	        	long monthlySavings1 = 0;
	        	long monthlySavings2 = 0;
	        	
	        	totalEduAmount = eduAmount1 + eduAmount2;
	        	
	        	if (child_count == 1) 
	        	{
	        		currentInvestAmount1 = investAmount;
	        	}else {
	        		currentInvestAmount1 = Math.round(investAmount * eduAmount1 / totalEduAmount);
	        		currentInvestAmount2 = Math.round(investAmount * eduAmount2 / totalEduAmount);
	        	}

	        	//------------Child 1------------
	        	if (StringHelper.isNotEmpty(childName1)) 
	        	{
	        		ageDiff1 = profEduAge1 - childAge1;
	        		//calculation for savings targets
	        		Double rate1 = 1 + (priceIncRate / 100);
	        		Double rate2 = Math.pow(rate1,ageDiff1);
	        		savingsTarget1 = Math.round(eduAmount1 * rate2);
	        		long investTarget1 = Math.round(currentInvestAmount1 * rate2);
	        		long targetAmount1 = savingsTarget1 - investTarget1;

	        		//calculation for monthly savings
	        		Double rate3 = 1 + (rateOfReturn / 100);
	        		Double rate4 = 0.0;
	        		for(int i = 1; i <= ageDiff1; i++) 
	        		{
	        			rate4 = rate4 + Math.pow(rate3,i);
	        		}
	        		Double yearlySavings1 = (targetAmount1 / rate4);
	        		monthlySavings1 = Math.round(yearlySavings1 / 12);
	        		monthlySavings1 = Math.round(monthlySavings1);
	        	}
	        	
	        	//------------Child 2------------
	        	if (StringHelper.isNotEmpty(childName2)) 
	        	{
	        		ageDiff2 = profEduAge2 - childAge2;
	        		//calculation for savings targets
	        		Double rate1 = 1 + (priceIncRate / 100);
	        		Double rate2 = Math.pow(rate1,ageDiff2);
	        		savingsTarget2 = Math.round(eduAmount2 * rate2);
	        		long investTarget2 = Math.round(currentInvestAmount2 * rate2);
	        		long targetAmount2 = savingsTarget2 - investTarget2;

	        		//calculation for monthly savings
	        		Double rate3 = 1 + (rateOfReturn / 100);
	        		Double rate4 = 0.0;
	        		for(int j = 1; j <= ageDiff2; j++) 
	        		{
	        			rate4 = rate4 + Math.pow(rate3,j);
	        		}
	        		Double yearlySavings2 = (targetAmount2 / rate4);
	        		monthlySavings2 = Math.round(yearlySavings2 / 12);
	        		monthlySavings2 = Math.round(monthlySavings2);
	        	}
	        	
	        	long total_savings_target = savingsTarget1 + savingsTarget2;
	        	long invest_total_amount = currentInvestAmount1 + currentInvestAmount2;
	        	long monthly_total_amount = monthlySavings1 + monthlySavings2;
	            
	        	result.setStatus(StatusCodesAndMessages.SuccessCode);
	        	result.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
	        	result.setMsg(StatusCodesAndMessages.SuccessMessage);
	        	result.setChild1_name(childName1);
	        	result.setChild2_name(childName2);
	        	result.setChild1_current_age(childAge1);
	        	result.setChild2_current_age(childAge2);
	        	result.setChild1_education_age(profEduAge1);
	        	result.setChild2_education_age(profEduAge2);
	        	result.setChild1_education_amount(eduAmount1);
	        	result.setChild2_education_amount(eduAmount2);
	        	result.setInflation_rate(priceIncRate);
	        	result.setExpected_return(rateOfReturn);
	        	result.setSavings_amount(investAmount);
	        	result.setTotal_education_amount(totalEduAmount);
	        	result.setChild1_prof_education_age(ageDiff1);
	        	result.setChild2_prof_education_age(ageDiff2);
	        	result.setChild1_inflation_adjust_education_amount(savingsTarget1);
	        	result.setChild2_inflation_adjust_education_amount(savingsTarget2);
	        	result.setToal_inflation_adjust_education_amount(total_savings_target);
	        	result.setChild1_savings_amount(currentInvestAmount1);
	        	result.setChild2_savings_amount(currentInvestAmount2);
	        	result.setTotal_savings_amount(invest_total_amount);
	        	result.setChild1_monthly_savings(monthlySavings1);
	        	result.setChild2_monthly_savings(monthlySavings2);
	        	result.setTotal_monthly_savings(monthly_total_amount);
	        	
	            apiresponse = gson.toJson(result);
	    		writer.print(apiresponse);
			    writer.close();
			} 
			catch (Exception ex) 
			{
				ex.printStackTrace();
			}
	}
	
	public Double futureValue(Double rate, Double nper, Double pmt, Double pv) throws Exception
	{
		Double fv_value = 0.0;
	    if (rate == 0)
	    {
	        fv_value = -(pv + (pmt * nper));
	    }else 
		{
	    	Double x = Math.pow(1 + rate, nper);
	        fv_value = -(-pmt + x * pmt + rate * x * pv) / rate;
	    }
	    return fv_value;
	}

}
