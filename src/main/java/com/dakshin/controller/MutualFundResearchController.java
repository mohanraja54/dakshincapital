package com.dakshin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.internal.util.StringHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dakshin.amfi.dao.AmfiApiAccessRepository;
import com.dakshin.amfi.model.SchemePerformancesBenchmark;
import com.dakshin.amfi.model.SchemePerformancesCategory;
import com.dakshin.amfi.model.SchemePerformances;
import com.dakshin.amfi.model.Top10FundsByCategory;
import com.dakshin.amfi.response.ApiCommonResponse;
import com.dakshin.amfi.response.DividendHistoryResponse;
import com.dakshin.amfi.response.FdVsDebtAPIResponse;
import com.dakshin.amfi.response.HistoricalDividendsResponse;
import com.dakshin.amfi.response.LiquidFundsVsSavingsBankResponse;
import com.dakshin.amfi.response.MutualFundAPIResponse;
import com.dakshin.amfi.response.MutualFundSIPReturnsAPIResponse;
import com.dakshin.amfi.response.MutualFundSchemeAPIResponse;
import com.dakshin.amfi.response.PPFvsELSSAPIResponse;
import com.dakshin.amfi.response.PointToPointReturnsCalculatorAPIResponse;
import com.dakshin.amfi.response.SIPReturnsCalculatorAPIAnnualIncreaseResponse;
import com.dakshin.amfi.response.SIPReturnsCalculatorAPIResponse;
import com.dakshin.amfi.response.STPReturnsCalculatorAPIResponse;
import com.dakshin.amfi.response.SWPReturnsCalculatorAPIResponse;
import com.dakshin.amfi.response.SchemeByAmcAPIResponse;
import com.dakshin.amfi.response.SchemeInceptionAndLatestNavDateAPIResponse;
import com.dakshin.amfi.response.TopDividendPayingMutualFundsApiResponse;
import com.dakshin.amfi.response.TopSWPFundsResponse;
import com.dakshin.amfi.response.TopSwpFundsApiResponse;
import com.dakshin.dao.CommonDao;
import com.dakshin.model.ModelPortfolioSchemes;
import com.dakshin.response.ModelPortfolioResponse;
import com.dakshin.utils.HttpPost;
import com.dakshin.utils.MfApiAccessor;
import com.dakshin.utils.MfApiUrls;
import com.dakshin.utils.UniqueIDProvider;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping(value="/mutual-funds-research")
public class MutualFundResearchController {
	
	@Autowired
	AmfiApiAccessRepository amfiApiAccessRepository;
	
	@Autowired
	CommonDao commonDao;

	@RequestMapping(value="/top-performing-mutual-funds")
	public String top_performing_funds(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{		 
    	try 
   		{   
    		String category =  request.getParameter("category");
	 		String period = request.getParameter("period");
	 		String type = request.getParameter("type");
	 		String mode = request.getParameter("mode");
	 		String category_name = category;
	 		
	 		if(category == null){category= "Equity: Multi Cap";}
	 		if(category_name == null){category_name= "";}
	 		if(period == null){period= "1y";}
	 		if(type == null){type= "Open";}
	 		if(mode == null){mode= "Growth";}
	 		
	 		category = category.trim();
	 		category_name = category_name.trim();
	 		period = period.trim();
	 		type = type.trim();
	 		mode = mode.trim();

	 		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("period", period);
	 		hashMap.put("category", category);
	 		hashMap.put("type", type);
	 		hashMap.put("maxno","1000");
	 		hashMap.put("mode",mode);
	 		
	 		String formattedUrl, result = "";
	 		 
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemePerformanceReturns, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		MutualFundSchemeAPIResponse mutualFundSchemeAPIResponse = new Gson().fromJson(result, MutualFundSchemeAPIResponse.class); 		
	 		request.setAttribute("benchmark_returns", mutualFundSchemeAPIResponse.getBenchmark_returns());	 	
	 		request.setAttribute("schemePerformances", mutualFundSchemeAPIResponse.getList());	 		
	 		request.setAttribute("category_returns", mutualFundSchemeAPIResponse.getCategory_returns());
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);	 		
	     	request.setAttribute("schemeCategories", mutualFundAPIResponse.getList());
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLatestNavDate, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
	 		request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	 		
	     	request.setAttribute("category", category);
	 		request.setAttribute("category_name", category_name);
	 		request.setAttribute("period", period);
	 		request.setAttribute("type", type);
	 		request.setAttribute("mode", mode);
    		
	     	request.setAttribute("page", "top-performing-mutual-funds");
	     	request.setAttribute("menu", "mf-research");
	     	request.setAttribute("jsp", "../amfi/top-performing-funds.jsp");
	     	
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
    }
	
	@RequestMapping(value="/mutual-funds-performance-comparison")
	public String fund_performance(HttpServletRequest request, HttpServletResponse response)
	{
		try 
		{
			String fund = request.getParameter("fund");
			String category = request.getParameter("category");
			
			if(fund == null || StringHelper.isEmpty(fund)){fund= "ICICI Prudential Value Discovery Fund - Growth";}
			if(category == null || StringHelper.isEmpty(category)){category= "Equity: Value";}
			
			fund = fund.trim();
			category = category.trim();
			String formattedUrl , result = "";
			MutualFundAPIResponse mfapiResponse = null;
			
			request.setAttribute("fund", fund);
			request.setAttribute("category", category);
			
			formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		mfapiResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);	 		
	     	request.setAttribute("schemeCategories", mfapiResponse.getList());
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("category", category);
	 		hashMap.put("fund", fund);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemePerformanceForFundComparison, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundSchemeAPIResponse mutualFundSchemeAPIResponse = new Gson().fromJson(result, MutualFundSchemeAPIResponse.class);
	 		
            request.setAttribute("schemePerformances", mutualFundSchemeAPIResponse.getList());
            request.setAttribute("benchmark_returns", mutualFundSchemeAPIResponse.getBenchmark_returns());
            request.setAttribute("category_returns", mutualFundSchemeAPIResponse.getCategory_returns());
            
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLatestNavDate, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
	 		request.setAttribute("nav_date", apiCommonResponse.getNav_date());
			
            request.setAttribute("page", "mutual-funds-performance-comparison");
            request.setAttribute("menu", "mf-research");
            request.setAttribute("jsp", "../amfi/fund-comparision.jsp");
            
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/autoSuggestAllMfSchemes")
	public void autoSuggestAllMfSchemes(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		PrintWriter writer = response.getWriter();
		Gson gson = null;
		
		try 
		{
			gson = new Gson();
			String keyword = request.getParameter("query");
			String category = request.getParameter("category");
			String amc = request.getParameter("amc");
			if(keyword == null || StringHelper.isEmpty(keyword)){keyword = "Ax";}
			if(category == null || StringHelper.isEmpty(category)){category = "All";}
			if(amc == null || StringHelper.isEmpty(amc)){amc = "All";}
	 			 		
	 		String formattedUrl, result = "";
	 		
			HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("query", keyword);
	 		hashMap.put("category", category);
	 		hashMap.put("amc", amc);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.autoSuggestAllMfSchemes, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class); 		
			List<String> schemeList = mutualFundAPIResponse.getList();
			
			response.setContentType("application/json");
			writer.println(gson.toJson(schemeList));
			writer.close();
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/mutual-fund-returns-comparison")
	public String returns_calculator(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
    	try 
   		{
    		String category = request.getParameter("category");
    		String schemes = request.getParameter("schemes");
    		String amount = request.getParameter("amount");
            String startDates = request.getParameter("startDates");
            String endDates = request.getParameter("endDates");
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -1);
			cal1.add(Calendar.MONTH, 1);
			String start_date_str = sdf.format(cal1.getTime());
            
			if(category == null || StringHelper.isEmpty(category)){category = "Equity: Flexi Cap";}
            if(schemes == null || StringHelper.isEmpty(schemes)){schemes = "HSBC Flexi Cap Fund - Growth";}
            if(amount == null || StringHelper.isEmpty(amount)){amount = "10000";}
            if(startDates == null || StringHelper.isEmpty(startDates)){startDates = start_date_str;}
            if(endDates == null || StringHelper.isEmpty(endDates)){endDates = end_date_str;}
            
            category = category.trim();
            schemes = schemes.trim();
            amount = amount.trim();
            startDates = startDates.trim();
            endDates = endDates.trim();
            
            request.setAttribute("category", category);
            request.setAttribute("schemes", schemes);
            request.setAttribute("amount", amount);
            request.setAttribute("startDates", startDates);
            request.setAttribute("endDates", endDates);
            
			List<String> start_date_array = new ArrayList<String>(Arrays.asList(startDates.split(",")));
			request.setAttribute("date_size", start_date_array.size());
			
            String formattedUrl, result = "";
            
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("schemeCategories", mutualFundAPIResponse.getList());
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("amc", "");
	 		hashMap.put("category", category);
	 		hashMap.put("schemes", schemes);
	 		hashMap.put("startdate", startDates);
	 		hashMap.put("enddate", endDates);
	 		hashMap.put("amount", amount);
	 		hashMap.put("isin", "");
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getPointToPointReturnsComparison, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		PointToPointReturnsCalculatorAPIResponse list = new Gson().fromJson(result, PointToPointReturnsCalculatorAPIResponse.class);
	 		
	 		request.setAttribute("schemePerformances", list.getPointToPointResponseList());
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLatestNavDate, new HashMap<String, String>());
		 	result = HttpPost.SendHttpPost(formattedUrl);	 		
		 	ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
		 	request.setAttribute("nav_date", apiCommonResponse.getNav_date());
            
	     	request.setAttribute("page", "mutual-fund-returns-comparison");
	     	request.setAttribute("menu", "mf-research");
	     	request.setAttribute("jsp", "../amfi/returns-calculator.jsp");
	     	
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/mutual-fund-sip-investment-calculator")
	 public String sip_calculator(HttpServletRequest request, HttpServletResponse response) throws Exception
	 {
     try
     {
  	   	  String category = request.getParameter("category");
         String fund = request.getParameter("fund");
         String amount = request.getParameter("amount");
         String frequency = request.getParameter("frequency");
         String start_date = request.getParameter("startdate");
         String end_date = request.getParameter("enddate");
         String category_name = category;
        
         SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
         Calendar cal1 = Calendar.getInstance();
         cal1.add(Calendar.DATE, -1);
         String end_date_str = sdf.format(cal1.getTime());
         cal1.add(Calendar.YEAR, -1);
         cal1.add(Calendar.MONTH, 1);
         String start_date_str = sdf.format(cal1.getTime());
        
         if(category == null){category = "Equity: Large Cap";}
         if(category_name == null){category_name = "";}
         if(fund == null){fund = "ICICI Prudential Bluechip Fund - Growth";}
         if(amount == null || !amount.matches("[0-9]+")){amount = "3000";}
         if(frequency == null){frequency = "Monthly";}
         if(start_date == null || StringHelper.isEmpty(start_date) || !start_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){start_date = start_date_str;}
	 	  if(end_date == null || StringHelper.isEmpty(end_date) || !end_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){end_date = end_date_str;}
         
         category = category.trim();
         category_name = category_name.trim();
         fund = fund.trim();
         amount = amount.trim();
         frequency = frequency.trim();
         start_date = start_date.trim();
         end_date = end_date.trim(); 
         
         start_date = start_date.replaceAll("/","-");
         end_date = end_date.replaceAll("/","-");
         
         request.setAttribute("category", category);
         request.setAttribute("category_name", category_name);
         request.setAttribute("fund", fund);
         request.setAttribute("amount", amount);
         request.setAttribute("frequency", frequency);
         request.setAttribute("start_date", start_date);
         request.setAttribute("end_date", end_date);
         
         String formattedUrl, result = "";
         
         formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeCategories, new HashMap<String, String>());
	      result = HttpPost.SendHttpPost(formattedUrl);
	 	  MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	      request.setAttribute("schemeCategories", mutualFundAPIResponse.getList());
        
         HashMap<String, String> hashMap = new HashMap<String, String>();
         hashMap.put("category", category);
	 	  hashMap.put("fund", fund);
	 	  hashMap.put("startdate", start_date);
	 	  hashMap.put("enddate", end_date);
	 	  hashMap.put("frequency", frequency);
	 	  hashMap.put("amount",amount);
	 		
		  formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSIPReturnCalculator, hashMap);
		  result = HttpPost.SendHttpPost(formattedUrl);
		  Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
		  SIPReturnsCalculatorAPIResponse sip_list = gson.fromJson(result, SIPReturnsCalculatorAPIResponse.class);
		  request.setAttribute("sip_list", sip_list.getList());
		  
		 formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLatestNavDate, new HashMap<String, String>());
		 result = HttpPost.SendHttpPost(formattedUrl);	 		
		 ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
		 request.setAttribute("nav_date", apiCommonResponse.getNav_date());
         
         request.setAttribute("page", "mutual-fund-sip-investment-calculator");
         request.setAttribute("menu", "mf-research");
         request.setAttribute("jsp", "../amfi/sip-calculator.jsp");
     }
     catch(Exception ex)
     {
     	ex.printStackTrace();
     }
     return "layout/layout";
	} 
	
	@RequestMapping(value="/getSchemeStartAndEndDate")
	public void getSchemeStartAndEndDate(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		Gson gson = null;
		try 
		{	
    		String scheme_amfi = request.getParameter("scheme_name");   
    		if(scheme_amfi == null){scheme_amfi = "";}
    		scheme_amfi = scheme_amfi.trim();
    		
    		scheme_amfi = URLDecoder.decode(scheme_amfi, "UTF-8");
    		
	 		 String formattedUrl, result = "";
	 		 
	         HashMap<String, String> hashMap = new HashMap<String, String>();
	 		 hashMap.put("scheme", scheme_amfi);
		 		
	 		 formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemeInceptionAndLatestNavDate, hashMap);
	 		 result = HttpPost.SendHttpPost(formattedUrl);	 	
	 		 gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		 SchemeInceptionAndLatestNavDateAPIResponse mutualFundSchemeAPIResponse = gson.fromJson(result, SchemeInceptionAndLatestNavDateAPIResponse.class);
    		 List<Date> dateMap = mutualFundSchemeAPIResponse.getList();
    		
	 		writer.print(gson.toJson(dateMap));
		    writer.close();
		    return;
		}
		catch (Exception ex) 
		{
		    writer.close();
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/top-performing-systematic-investment-plan")
	public String top_performing_sip_funds_new(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{		 
    	try 
   		{	 		
    		String category =  request.getParameter("category");
	 		String period = request.getParameter("period");
	 		String amount = request.getParameter("amount");
	 		String category_name = category;
	 		
	 		if(category == null || StringHelper.isEmpty(category)){category= "Equity: Multi Cap";}
	 		if(category_name == null){category_name= "";}
	 		if(period == null || StringHelper.isEmpty(period) || !period.matches("[0-9]+")){period= "1";}
	 		if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount= "3000";}
	 		
	 		category = category.trim();
	 		category_name = category_name.trim();
	 		period = period.trim();
	 		amount = amount.trim();
	 		String formattedUrl , result = "";
	 		
	 		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("period", period);
	 		hashMap.put("category", category);
	 		hashMap.put("amount", amount);
	 		hashMap.put("maxno","1000");	 		
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSIPReturnsForCategoryPeriodAmount, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		MutualFundSIPReturnsAPIResponse mutualFundAPIResponse = gson.fromJson(result, MutualFundSIPReturnsAPIResponse.class);
	 		
	 		request.setAttribute("schemePerformances", mutualFundAPIResponse.getList());
	 		//request.setAttribute("schemePerformances", schemePerformances);
	 		request.setAttribute("category_returns", mutualFundAPIResponse.getCategory_returns());
	 		request.setAttribute("benchmark_returns", mutualFundAPIResponse.getBenchmark_returns());	 		
	 		
	 		request.setAttribute("category", category);
	 		request.setAttribute("category_name", category_name);
	 		request.setAttribute("period", period);
	 		request.setAttribute("amount", amount);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mfapiResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);	 		
	     	request.setAttribute("schemeCategories", mfapiResponse.getList());
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
	     	request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	     	
	     	request.setAttribute("page", "top-performing-systematic-investment-plan");
	     	request.setAttribute("menu", "mf-research");
	     	request.setAttribute("jsp", "../amfi/top-performing-sip-funds.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/top-performing-sip-plans-elss-funds")
	public String top_performing_sip_elss_funds(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{		 
    	try 
   		{
            String category =  request.getParameter("category");
	 		String period = request.getParameter("period");
	 		String amount = request.getParameter("amount");
	 		
	 		if(category == null || StringHelper.isEmpty(category)){category= "Equity: ELSS";}
	 		if(period == null || StringHelper.isEmpty(period) || !period.matches("[0-9]+")){period= "1";}
	 		if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount= "3000";}
	 		
	 		category = category.trim();
	 		period = period.trim();
	 		amount = amount.trim();
	 		String formattedUrl , result = "";
	 		
	 		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("period", period);
	 		hashMap.put("category", category);
	 		hashMap.put("amount", amount);
	 		hashMap.put("maxno","1000");	 		
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSIPReturnsForCategoryPeriodAmount, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		MutualFundSIPReturnsAPIResponse mutualFundAPIResponse = gson.fromJson(result, MutualFundSIPReturnsAPIResponse.class);
	 		
	 		request.setAttribute("schemePerformances", mutualFundAPIResponse.getList());
	 		request.setAttribute("category_returns", mutualFundAPIResponse.getCategory_returns());
	 		request.setAttribute("benchmark_returns", mutualFundAPIResponse.getBenchmark_returns());
	 		
	 		request.setAttribute("category", category);
	 		request.setAttribute("period", period);
	 		request.setAttribute("amount", amount);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
	     	request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	     	
	     	request.setAttribute("page", "top-performing-sip-plans-elss-funds");
	     	request.setAttribute("menu", "mf-research");
	     	request.setAttribute("jsp", "../amfi/top-performing-sip-elss-funds.jsp");
	     	
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/sip-with-annual-increase")
	public String sip_with_annual_increase(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		try 
		{	
			String scheme = "Aditya Birla Sun Life Frontline Equity Fund-Growth";
			String start_date = "01-01-2010";
			String end_date = sdf.format(new Date());
			String amount =  "5000";
			String frequency = "Monthly";
			String enhancementPercentage = "10";
			String enhancementAmount = "500";
			
			request.setAttribute("scheme", scheme);
			request.setAttribute("start_date", start_date);
			request.setAttribute("end_date", end_date);
			request.setAttribute("amount", amount);
			request.setAttribute("frequency", frequency);
			request.setAttribute("enhancementPercentage", enhancementPercentage);
			request.setAttribute("enhancementAmount", enhancementAmount);
			
            String formattedUrl, result = "";
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("scheme", scheme);
            hashMap.put("start_date", start_date);
            hashMap.put("end_date", end_date);
            hashMap.put("amount", amount);
            hashMap.put("frequency", frequency);
            hashMap.put("enhancement_percentage", enhancementPercentage);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSIPReturnWithAnnualIncrease, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		SIPReturnsCalculatorAPIAnnualIncreaseResponse list = gson.fromJson(result, SIPReturnsCalculatorAPIAnnualIncreaseResponse.class);
			if(list != null)
			{
				request.setAttribute("sipYearlyEnhancementResponse", list.getSipYearlyEnhancementResponse());
				request.setAttribute("sipNavResponseList", list.getSipNavResponseList());
			}
			
			formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
	     	request.setAttribute("nav_date", apiCommonResponse.getNav_date());
			
			request.setAttribute("page", "sip-with-annual-increase");
			request.setAttribute("menu", "mf-research");
			request.setAttribute("jsp", "../amfi/sip-yearly-enhancement.jsp");
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/sip-with-annual-increase/{scheme:.+}")
	public String sip_enhancement_scheme(@PathVariable(value="scheme") String scheme,HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	
			
			String start_date = request.getParameter("start_date");
			String end_date = request.getParameter("end_date");
			String amount =  request.getParameter("amount");
			String frequency = request.getParameter("frequency");
			String enhancement_percentage = request.getParameter("enhancement_percentage");
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -1);
			cal1.add(Calendar.MONTH, 1);
			String start_date_str = sdf.format(cal1.getTime());
	 		
			if(scheme == null || StringHelper.isEmpty(scheme)){scheme= "HDFC Equity Fund - Growth Option";}
	 		if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount= "3000";}
	 		if(frequency == null || StringHelper.isEmpty(frequency)){frequency= "Monthly";}
	 		if(start_date == null || StringHelper.isEmpty(start_date) || !start_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){start_date= start_date_str;}
	 		if(end_date == null || StringHelper.isEmpty(end_date) || !end_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){end_date= end_date_str;}
	 		if(enhancement_percentage == null || StringHelper.isEmpty(enhancement_percentage) || !enhancement_percentage.matches("[0-9]+")){enhancement_percentage = "8";}
			
	 		scheme = scheme.trim();
	 		amount = amount.trim();
	 		frequency = frequency.trim();
	 		start_date = start_date.trim();
	 		end_date = end_date.trim();
	 		scheme = scheme.replaceAll("&amp;", "&");
 			enhancement_percentage = enhancement_percentage.trim();
			
			int enhancement_amount = (Integer.parseInt(amount)/100) * Integer.parseInt(enhancement_percentage);
			
			request.setAttribute("scheme", scheme);
			request.setAttribute("start_date", start_date);
			request.setAttribute("end_date", end_date);
			request.setAttribute("amount", amount);
			request.setAttribute("frequency", frequency);
			request.setAttribute("enhancementPercentage", enhancement_percentage);
			request.setAttribute("enhancementAmount", enhancement_amount);
			
            String formattedUrl, result = "";
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("scheme", scheme);
            hashMap.put("start_date", start_date);
            hashMap.put("end_date", end_date);
            hashMap.put("amount", amount);
            hashMap.put("frequency", frequency);
            hashMap.put("enhancement_percentage", enhancement_percentage);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSIPReturnWithAnnualIncrease, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		SIPReturnsCalculatorAPIAnnualIncreaseResponse list = gson.fromJson(result, SIPReturnsCalculatorAPIAnnualIncreaseResponse.class);
			if(list != null)
			{
				request.setAttribute("sipYearlyEnhancementResponse", list.getSipYearlyEnhancementResponse());
				request.setAttribute("scheme_name", list.getSipYearlyEnhancementResponse().get(0).getScheme());
				request.setAttribute("sipNavResponseList", list.getSipNavResponseList());
			}
			
			formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
	     	request.setAttribute("nav_date", apiCommonResponse.getNav_date());
			
	     	request.setAttribute("page", "sip-with-annual-increase");
	     	request.setAttribute("menu", "mf-research");
	     	request.setAttribute("jsp", "../amfi/sip-yearly-enhancement.jsp");
	     	
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/getSipEnhancementGraph")
	public void getSipEnhancementGraph(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		try 
		{	
			String scheme_with_parameter = request.getParameter("scheme");
			String start_date = request.getParameter("start_date");
			String end_date = request.getParameter("end_date");
			String amount =  request.getParameter("amount");
			String frequency = request.getParameter("frequency");
			String enhancement_percentage = request.getParameter("enhancement_percentage");

			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -1);
			cal1.add(Calendar.MONTH, 1);
			String start_date_str = sdf.format(cal1.getTime());
			
			if(scheme_with_parameter == null || StringHelper.isEmpty(scheme_with_parameter)){scheme_with_parameter= "HDFC Equity Fund - Growth Option||false";}
	 		if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount= "3000";}
	 		if(frequency == null || StringHelper.isEmpty(frequency)){frequency= "Monthly";}
	 		if(start_date == null || StringHelper.isEmpty(start_date) || !start_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){start_date= start_date_str;}
	 		if(end_date == null || StringHelper.isEmpty(end_date) || !end_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){end_date= end_date_str;}
	 		if(enhancement_percentage == null || StringHelper.isEmpty(enhancement_percentage) || !enhancement_percentage.matches("[0-9]+")){enhancement_percentage= "10";}
			
	 		scheme_with_parameter = scheme_with_parameter.trim();
	 		amount = amount.trim();
	 		frequency = frequency.trim();
	 		start_date = start_date.trim();
	 		end_date = end_date.trim();
	 		enhancement_percentage = enhancement_percentage.trim();
	 		
            String formattedUrl, result = "";
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("scheme", scheme_with_parameter);
            hashMap.put("start_date", start_date);
            hashMap.put("end_date", end_date);
            hashMap.put("amount", amount);
            hashMap.put("frequency", frequency);
            hashMap.put("enhancement_percentage", enhancement_percentage);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSipEnhancementGraph, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		SIPReturnsCalculatorAPIResponse list = gson.fromJson(result, SIPReturnsCalculatorAPIResponse.class);
	     	String sipReturnsGraphData = list.getSipReturnsGraphData();
	     	
	     	writer.print(sipReturnsGraphData);
		    writer.close();
		    return;
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/ppf-vs-elss")
	public String ppf_vs_elss(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{
			String schemes = request.getParameter("schemes");
			String start_date = request.getParameter("start_date");
			String end_date = request.getParameter("end_date");
			String period = request.getParameter("period");
			String amount = request.getParameter("amount");
			String type = request.getParameter("type");
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -15);
			String start_date_str = sdf.format(cal1.getTime());
			
			if(schemes == null || StringHelper.isEmpty(schemes)){schemes="HDFC TaxSaver-Growth Plan";}
			if(start_date == null || StringHelper.isEmpty(start_date) || !start_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){start_date=start_date_str;}
			if(end_date == null || StringHelper.isEmpty(end_date) || !end_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){end_date=end_date_str;}
			if(period == null || StringHelper.isEmpty(period)){period="Monthly";}
			if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount = "10000";}
			if(type == null || StringHelper.isEmpty(type)){type="lumpsum";}
			
			schemes = schemes.trim();
			start_date = start_date.trim();
			end_date = end_date.trim();
			period = period.trim();
			amount = amount.trim();
			type = type.trim();
            
            request.setAttribute("schemes", schemes);
            request.setAttribute("start_date", start_date);
            request.setAttribute("end_date", end_date);
            request.setAttribute("period", period);
            request.setAttribute("amount", amount);
            request.setAttribute("type", type);
            
            String formattedUrl, result = "";
	     	
			HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("schemes", schemes);
            hashMap.put("start_date", start_date);
            hashMap.put("end_date", end_date);
            hashMap.put("period", period);
            hashMap.put("amount", amount);
            hashMap.put("type", type);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getPPFvsELSS, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		PPFvsELSSAPIResponse list = new Gson().fromJson(result, PPFvsELSSAPIResponse.class);
	 		request.setAttribute("list", list.getList());
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
		 	result = HttpPost.SendHttpPost(formattedUrl);
		 	ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
		    request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	     	
	 		request.setAttribute("page", "ppf-vs-elss");		
	 		request.setAttribute("menu", "mf-research");
	 		request.setAttribute("jsp", "../amfi/ppf-vs-elss.jsp");
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/getPPFGraphData")
	public void getPPFGraphData(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		
		try 
		{	
			String scheme = request.getParameter("scheme");
    	    String amount = request.getParameter("amount");
    		String start_date = request.getParameter("startdate");
            String end_date = request.getParameter("enddate");
            String frequency = request.getParameter("frequency");
            String type = request.getParameter("type");
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -15);
			String start_date_str = sdf.format(cal1.getTime());
			
			if(scheme == null || StringHelper.isEmpty(scheme)){scheme="HDFC TaxSaver-Growth Plan";}
			if(start_date == null || StringHelper.isEmpty(start_date) || !start_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){start_date=start_date_str;}
			if(end_date == null || StringHelper.isEmpty(end_date) || !end_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){end_date=end_date_str;}
			if(frequency == null || StringHelper.isEmpty(frequency)){frequency="Monthly";}
			if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount = "10000";}
			if(type == null || StringHelper.isEmpty(type)){type="lumpsum";}
			
			scheme = scheme.trim();
			start_date = start_date.trim();
			end_date = end_date.trim();
			frequency = frequency.trim();
			amount = amount.trim();
			type = type.trim();
			
			scheme = URLDecoder.decode(scheme, "UTF-8");
			
            String formattedUrl, result = "";
	     	
			HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("scheme", scheme);
            hashMap.put("startdate", start_date);
            hashMap.put("enddate", end_date);
            hashMap.put("frequency", frequency);
            hashMap.put("amount", amount);
            hashMap.put("type", type);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getPPFvsELSSGraphData, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		PPFvsELSSAPIResponse list = new Gson().fromJson(result, PPFvsELSSAPIResponse.class);
			String graph_data = list.getResult();
            
    		writer.print(graph_data);
		    writer.close();
		    return;
		} 
		catch (Exception ex) 
		{
		    writer.close();
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/mutual-fund-stp-investment-calculator")
	public String stp_calculator(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
    	try 
   		{
    		String amc = request.getParameter("amc");
            String from_scheme = request.getParameter("from_scheme");
            String to_scheme = request.getParameter("to_scheme");
            String initial_amount = request.getParameter("intial_amount");
            String stp_date = request.getParameter("stp_date");
            String transfer_amount = request.getParameter("transfer_amount");
            String period = request.getParameter("period");
            String from_date = request.getParameter("from_date");
            String to_date = request.getParameter("to_date");
            String init_start_date = request.getParameter("init_start_date");
            String lumpsum_option = request.getParameter("lumpsum_option");
            String lumpsum_year = request.getParameter("lumpsum_year");
            String amc_name = amc;
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
            
			if(amc == null || StringHelper.isEmpty(amc)){amc = "ICICI Prudential Mutual Fund";}
			if(amc_name == null){amc_name = "";}
            if(from_scheme == null || StringHelper.isEmpty(from_scheme)){from_scheme = "ICICI Prudential Liquid Fund - Growth";}
            if(to_scheme == null || StringHelper.isEmpty(to_scheme)){to_scheme = "ICICI Prudential Equity & Debt Fund - Growth";}
            if(initial_amount == null || StringHelper.isEmpty(initial_amount)){initial_amount = "200000";}
            if(stp_date == null || StringHelper.isEmpty(stp_date) || !stp_date.matches("[0-9]+")){stp_date = "5";}
            if(transfer_amount == null || StringHelper.isEmpty(transfer_amount)){transfer_amount = "10000";}
            if(period == null || StringHelper.isEmpty(period)){period = "Monthly";}
            if(from_date == null || StringHelper.isEmpty(from_date) || !from_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){from_date = "05-07-2015";}
	 		if(to_date == null || StringHelper.isEmpty(to_date) || !to_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){to_date = end_date_str;}
            if(init_start_date == null || StringHelper.isEmpty(init_start_date)){init_start_date = "01-07-2015";}
            if(lumpsum_option == null || StringHelper.isEmpty(lumpsum_option)){lumpsum_option = "LAEP";}
            if(lumpsum_year == null || StringHelper.isEmpty(lumpsum_year)){lumpsum_year = "1";}
            
            amc = amc.trim();
            amc_name = amc_name.trim();
            from_scheme = from_scheme.trim();
            to_scheme = to_scheme.trim();
            initial_amount = initial_amount.trim();
            stp_date = stp_date.trim();
            transfer_amount = transfer_amount.trim();
            period = period.trim();
            from_date = from_date.trim();
            to_date = to_date.trim();
            init_start_date = init_start_date.trim();
            lumpsum_option = lumpsum_option.trim();
            lumpsum_year = lumpsum_year.trim();
            
            request.setAttribute("amc", amc);
            request.setAttribute("amc_name", amc_name);
            request.setAttribute("from_scheme", from_scheme);
            request.setAttribute("to_scheme", to_scheme);
            request.setAttribute("initial_amount", initial_amount);
            request.setAttribute("stp_date", stp_date);
            request.setAttribute("transfer_amount", transfer_amount);
            request.setAttribute("period", period);
            request.setAttribute("from_date", from_date);
            request.setAttribute("to_date", to_date);
            request.setAttribute("init_start_date", init_start_date);
            request.setAttribute("lumpsum_option", lumpsum_option);
            request.setAttribute("lumpsum_year", lumpsum_year);
            
            String formattedUrl, result = "";
            
            formattedUrl = MfApiAccessor.	getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllCompanies, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("amcCompanies", mutualFundAPIResponse.getList());
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("amc", amc);
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemeByAmcApi, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		SchemeByAmcAPIResponse schemes_list = new Gson().fromJson(result, SchemeByAmcAPIResponse.class);
	     	request.setAttribute("schemes", schemes_list.getSchemes_list());
	     	
	     	hashMap = new HashMap<String, String>();
            hashMap.put("amc", amc);
	 		hashMap.put("from_scheme", from_scheme);
	 		hashMap.put("to_scheme", to_scheme);
	 		hashMap.put("initial_amount", initial_amount);
	 		hashMap.put("stp_date", stp_date);
	 		hashMap.put("transfer_amount", transfer_amount);
	 		hashMap.put("period", period);
	 		hashMap.put("from_date", from_date);
	 		hashMap.put("to_date", to_date);
	 		hashMap.put("init_start_date", init_start_date);
	 		hashMap.put("lumpsum_option", lumpsum_option);
	 		hashMap.put("lumpsum_year", lumpsum_year);
	 		
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSTPReturnCalculator, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		STPReturnsCalculatorAPIResponse list = gson.fromJson(result, STPReturnsCalculatorAPIResponse.class);
	     	
	     	request.setAttribute("installments", list.getTo_scheme_installment());
	     	request.setAttribute("trans_amount", list.getTo_scheme_total_amount_invested());
	     	request.setAttribute("total_lumpsum_amount", list.getTotal_invested_amount());
	     	request.setAttribute("from_remain_units", list.getFrom_scheme_remaining_units());
	     	request.setAttribute("to_remain_units", list.getTo_scheme_accumulated_units());
	     	request.setAttribute("from_current_value", list.getFrom_scheme_current_value());
	     	request.setAttribute("from_current_value_date", list.getFrom_scheme_current_value_date());
	     	request.setAttribute("from_final_current_value", list.getFrom_scheme_end_value());
	     	request.setAttribute("from_final_nav_date", list.getFrom_scheme_end_value_date());
	     	request.setAttribute("to_current_value", list.getTo_scheme_current_value());
	     	request.setAttribute("to_current_value_date", list.getTo_scheme_current_value_date());
	     	request.setAttribute("to_final_current_value", list.getTo_scheme_end_value());
	     	request.setAttribute("to_final_nav_date", list.getTo_scheme_end_value_date());
	     	request.setAttribute("from_profit", list.getFrom_scheme_profit());
	     	request.setAttribute("to_profit", list.getTo_scheme_profit());
	     	request.setAttribute("from_returns", list.getFrom_scheme_returns());
	     	request.setAttribute("to_returns", list.getTo_scheme_returns());
	     	request.setAttribute("total_returns", list.getTotal_returns());
	     	request.setAttribute("total_current_value", list.getTotal_current_value());
	     	request.setAttribute("total_profit", list.getTotal_profit());
	     	request.setAttribute("from_scheme_list", list.getFrom_scheme_list());
	     	request.setAttribute("to_scheme_list", list.getTo_scheme_list());
	     	
	     	request.setAttribute("schemeMapping_from", list.getFrom_scheme_schemeMapping());
	     	request.setAttribute("schemeMapping_to", list.getTo_scheme_schemeMapping());
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
		 	result = HttpPost.SendHttpPost(formattedUrl);
		 	ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
		    request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	     	
	     	request.setAttribute("page", "mutual-fund-stp-investment-calculator");
	     	request.setAttribute("menu", "mf-research");
	     	request.setAttribute("submenu", "Mutual Fund Investment STP Calculator");
	     	request.setAttribute("jsp", "../amfi/stp-calculator.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/getSchemeByAmcAndCategoryAndDate", method= RequestMethod.POST)
	public void getSchemeByAmcAndCategoryAndDate(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
    	PrintWriter writer = response.getWriter();
		response.setContentType("text/Html");
		Gson gson = new Gson();
		
		try 
		{
			String amc = request.getParameter("amc");
            String category = request.getParameter("category");
            String start_date = request.getParameter("start_date");
            if(amc == null || StringHelper.isEmpty(amc) || category == null || StringHelper.isEmpty(category) || start_date == null || StringHelper.isEmpty(start_date))
            {
        		writer.print(gson.toJson(null));
    		    writer.close();
    		    return;
            }
            
	 		String formattedUrl, result = "";
	 		
	 		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("amc", amc);
	 		hashMap.put("category", category);
	 		hashMap.put("start_date", start_date);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemeByAmcAndCategoryAndDate, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class); 
	 		List<String> schemeCategories = mutualFundAPIResponse.getList();
            
    		writer.print(gson.toJson(schemeCategories));
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/getSchemeByAmc", method= RequestMethod.POST)
	public void getSchemeByAmc(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
    	PrintWriter writer = response.getWriter();
		response.setContentType("text/Html");
		Gson gson = new Gson();
        
		try 
		{

    		String amc = request.getParameter("amc");
    		
	 		String formattedUrl, result = "";
	 		
	 		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("amc", amc);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemeByAmcApi, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		SchemeByAmcAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, SchemeByAmcAPIResponse.class); 		
			List<String> schemes_list = mutualFundAPIResponse.getSchemes_list();
    		
    		writer.print(gson.toJson(schemes_list));
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/top-swp-funds")
	public String top_swp_funds(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
    	try 
   		{
	     	String amc = request.getParameter("amc");
            String category = request.getParameter("category");
            String initial_amount = request.getParameter("intial_amount");
            String swp_date = request.getParameter("swp_date");
            String withdrawal_amount = request.getParameter("withdrawal_amount");
            String period = request.getParameter("period");
            String from_date = request.getParameter("from_date");
            String to_date = request.getParameter("to_date");
            String init_start_date = request.getParameter("init_start_date");
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -1);
			cal1.add(Calendar.MONTH, 1);
			String start_date_str = sdf.format(cal1.getTime());
            
			if(amc == null || StringHelper.isEmpty(amc)){amc = "ICICI Prudential Mutual Fund";}
            if(category == null || StringHelper.isEmpty(category)){category = "Equity: Multi Cap";}
            if(initial_amount == null || StringHelper.isEmpty(initial_amount) || !initial_amount.matches("[0-9]+")){initial_amount = "100000";}
            if(swp_date == null || StringHelper.isEmpty(swp_date) || !swp_date.matches("[0-9]+")){swp_date = "10";}
            if(withdrawal_amount == null || StringHelper.isEmpty(withdrawal_amount) || !withdrawal_amount.matches("[0-9]+")){withdrawal_amount= "3000";}
            if(period == null || StringHelper.isEmpty(period)){period = "Monthly";}
            if(init_start_date == null || StringHelper.isEmpty(init_start_date) || !init_start_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){init_start_date = start_date_str;}
            if(from_date == null || StringHelper.isEmpty(from_date) || !from_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){from_date = start_date_str;}
	 		if(to_date == null || StringHelper.isEmpty(to_date) || !to_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){to_date = end_date_str;}
            
            amc = amc.trim();
            category = category.trim();
            initial_amount = initial_amount.trim();
            swp_date = swp_date.trim();
            withdrawal_amount = withdrawal_amount.trim();
            period = period.trim();
            from_date = from_date.trim();
            to_date = to_date.trim();
            
            request.setAttribute("amc", amc);
            request.setAttribute("category", category);
            request.setAttribute("initial_amount", initial_amount);
            request.setAttribute("swp_date", swp_date);
            request.setAttribute("withdrawal_amount", withdrawal_amount);
            request.setAttribute("period", period);
            request.setAttribute("from_date", from_date);
            request.setAttribute("to_date", to_date);
            request.setAttribute("init_start_date", init_start_date);
			
            String formattedUrl, result = "";
            
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllCompanies, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("amcCompanies", mutualFundAPIResponse.getList());
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("schemeCategories", mutualFundAPIResponse.getList());
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("amc", amc);
            hashMap.put("category", category);
            hashMap.put("initial_amount", initial_amount);
            hashMap.put("withdrawal_amount", withdrawal_amount);
            hashMap.put("swp_date", swp_date);
            hashMap.put("period", period);
            hashMap.put("from_date", from_date);
            hashMap.put("to_date", to_date);
            hashMap.put("init_start_date", init_start_date);
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getTopSWPFunds, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		TopSwpFundsApiResponse list = gson.fromJson(result, TopSwpFundsApiResponse.class);
	 		List<TopSWPFundsResponse> topList = list.getList();
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
		 	result = HttpPost.SendHttpPost(formattedUrl);
		 	ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
		    request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	 		
	     	request.setAttribute("swp_funds_list", topList);
	     	request.setAttribute("page", "top-swp-funds");
	     	request.setAttribute("menu", "mf-research");
	     	request.setAttribute("jsp", "../amfi/top-swp-funds.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/mutual-fund-swp-investment-calculator")
	public String swp_calculator(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
    	try 
   		{
    		String amc = request.getParameter("amc");
            String scheme_name = request.getParameter("scheme_name");
            String initial_amount = request.getParameter("intial_amount");
            String swp_date = request.getParameter("swp_date");
            String withdrawal_amount = request.getParameter("withdrawal_amount");
            String period = request.getParameter("period");
            String from_date = request.getParameter("from_date");
            String to_date = request.getParameter("to_date");
            String init_start_date = request.getParameter("init_start_date");
            String scheme = scheme_name;
            
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
            
			if(amc == null || StringHelper.isEmpty(amc)){amc = "SBI Mutual Fund";}
            if(scheme_name == null || StringHelper.isEmpty(scheme_name)){scheme_name = "SBI Magnum Income Fund-Regular Plan-Growth";}
            if(scheme == null || StringHelper.isEmpty(scheme)){scheme = "SBI Magnum Income Fund-Regular Plan-Growth";}
            if(initial_amount == null || StringHelper.isEmpty(initial_amount) || !initial_amount.matches("[0-9]+")){initial_amount = "100000";}
            if(swp_date == null || StringHelper.isEmpty(swp_date) || !swp_date.matches("[0-9]+")){swp_date = "10";}
            if(withdrawal_amount == null || StringHelper.isEmpty(withdrawal_amount) || !withdrawal_amount.matches("[0-9]+")){withdrawal_amount= "3000";}
            if(period == null || StringHelper.isEmpty(period)){period = "Monthly";}
            if(init_start_date == null || StringHelper.isEmpty(init_start_date) || !init_start_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){init_start_date = "20-08-2016";}
            if(from_date == null || StringHelper.isEmpty(from_date) || !from_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){from_date = "20-08-2016";}
	 		if(to_date == null || StringHelper.isEmpty(to_date) || !to_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){to_date = end_date_str;}
            
            amc = amc.trim();
            scheme_name = scheme_name.trim();
            scheme = scheme.trim();
            initial_amount = initial_amount.trim();
            swp_date = swp_date.trim();
            withdrawal_amount = withdrawal_amount.trim();
            period = period.trim();
            from_date = from_date.trim();
            to_date = to_date.trim();
            
            request.setAttribute("amc", amc);
            request.setAttribute("scheme_name", scheme_name);
            request.setAttribute("scheme", scheme);
            request.setAttribute("initial_amount", initial_amount);
            request.setAttribute("swp_date", swp_date);
            request.setAttribute("withdrawal_amount", withdrawal_amount);
            request.setAttribute("period", period);
            request.setAttribute("from_date", from_date);
            request.setAttribute("to_date", to_date);
            request.setAttribute("init_start_date", init_start_date);
			
            String formattedUrl, result = "";
            
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllCompanies, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("amcCompanies", mutualFundAPIResponse.getList());
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("amc", amc);
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemeByAmcApi, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		SchemeByAmcAPIResponse schemes_list = new Gson().fromJson(result, SchemeByAmcAPIResponse.class);
	     	request.setAttribute("schemes", schemes_list.getSchemes_list());
	 		
	     	hashMap = new HashMap<String, String>();
            hashMap.put("amc", amc);
            hashMap.put("scheme_name", scheme_name);
            hashMap.put("initial_amount", initial_amount);
            hashMap.put("withdrawal_amount", withdrawal_amount);
            hashMap.put("period", period);
            hashMap.put("from_date", from_date);
            hashMap.put("to_date", to_date);
            hashMap.put("swp_date", swp_date);
            hashMap.put("init_start_date", init_start_date);
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSWPReturnCalculator, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		SWPReturnsCalculatorAPIResponse list = gson.fromJson(result, SWPReturnsCalculatorAPIResponse.class);
	     	
	     	request.setAttribute("transfer_out_count", list.getScheme_installment());
	     	request.setAttribute("total_amount_transferred", list.getScheme_total_withdrawal_amount());
	     	request.setAttribute("total_lumpsum_amount", list.getScheme_investment_amount());
	     	request.setAttribute("from_remain_units", list.getScheme_remaining_units());
	     	request.setAttribute("from_current_value", list.getScheme_current_value());
	     	request.setAttribute("from_profit", list.getScheme_profit());
	     	request.setAttribute("from_returns", list.getScheme_returns());
	     	request.setAttribute("from_scheme_list", list.getScheme_list());
	     	request.setAttribute("from_nav_date", list.getScheme_current_value_date());
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
		 	result = HttpPost.SendHttpPost(formattedUrl);
		 	ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
		    request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	     	
	 		request.setAttribute("schemeMapping", list.getScheme_mapping());
	     	request.setAttribute("page", "mutual-fund-swp-investment-calculator");
	     	request.setAttribute("menu", "mf-research");
	     	request.setAttribute("jsp", "../amfi/swp-calculator.jsp");
	     	
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/fixed-deposit-vs-debt-funds")
	public String fixed_deposit_vs_debt_funds(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -1);
			String start_date_str = sdf.format(cal1.getTime());
			
			String amc = "HDFC Mutual Fund";
    		String category = "Debt: Dynamic Bond";
    		String scheme = "HDFC Dynamic Debt Fund - Growth Option";
    		String amount = "100000";
    		String start_date = start_date_str;
    		String end_date = end_date_str;
    		String tax_rate = "30";
    		
    		request.setAttribute("amc", amc);
            request.setAttribute("category", category);
            request.setAttribute("scheme_name", scheme);
            request.setAttribute("amount", amount);
            request.setAttribute("start_date", start_date);
            request.setAttribute("end_date", end_date);
            request.setAttribute("tax_rate", tax_rate);
            
	     	Date startDate = sdf.parse(start_date);
            Date endDate = sdf.parse(end_date);
	     	double years = UniqueIDProvider.getDiffYears(startDate, endDate);
	     	request.setAttribute("years", years);
    		
            String formattedUrl, result = "";
            
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllCompanies, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("amcCompanies", mutualFundAPIResponse.getList());
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeDebtCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("schemeCategories", mutualFundAPIResponse.getList());
	     	
            HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("amc", amc);
            hashMap.put("category", category);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllMutualFundSchemesbyAmcAndCategory, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("schemes", mutualFundAPIResponse.getList());
	     	
            hashMap = new HashMap<String, String>();
            hashMap.put("scheme", scheme);
            hashMap.put("amount", amount);
            hashMap.put("start_date", start_date);
            hashMap.put("end_date", end_date);
            hashMap.put("tax_rate", tax_rate);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getFdVsDebt, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		FdVsDebtAPIResponse list = new Gson().fromJson(result, FdVsDebtAPIResponse.class);
	     	request.setAttribute("fDvsDebtResponse", list.getfDvsDebtResponse());
		    
		    String top_category =  request.getParameter("top_category");
	 		String top_period = request.getParameter("top_period");
	 		String type = "Open";
	 		String mode = "Growth";
	 		
	 		if(top_category == null){top_category= "Debt: Dynamic Bond";}
	 		if(top_period == null){top_period= "1y";}
	 		
	 		top_category = top_category.trim();
	 		top_period = top_period.trim();
	 		
            hashMap = new HashMap<String, String>();
            hashMap.put("period", top_period);
            hashMap.put("category", top_category);
            hashMap.put("type", type);
            hashMap.put("mode", mode);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemePerformanceReturns, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundSchemeAPIResponse schemePerformancesList = new Gson().fromJson(result, MutualFundSchemeAPIResponse.class);
	     	request.setAttribute("schemePerformances", schemePerformancesList.getList());
	 		
	 		request.setAttribute("top_category", top_category);
	 		request.setAttribute("top_period", top_period);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLatestNavDate, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);
	     	request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	     	
	     	request.setAttribute("page", "fixed-deposit-vs-debt-funds");	
	     	request.setAttribute("menu", "mf-research");
	     	request.setAttribute("jsp", "../amfi/fd-vs-debt.jsp");
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/fixed-deposit-vs-debt-funds/{scheme:.+}")
	public String fixed_deposit_vs_debt_funds_scheme(@PathVariable(value="scheme") String scheme,
			HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	     	
			String amc = request.getParameter("amc");
    		String category = request.getParameter("category");
    		String amount = request.getParameter("amount");
    		String start_date = request.getParameter("start_date");
    		String end_date = request.getParameter("end_date");
    		String tax_rate = request.getParameter("tax_rate");
    		
	     	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -1);
			String start_date_str = sdf.format(cal1.getTime());
			
			if(amc == null){amc = "HDFC Mutual Fund";}
			if(category == null){category = "Debt: Dynamic Bond";}
			if(scheme == null || StringHelper.isEmpty(scheme)){scheme = "HDFC Dynamic Debt Fund - Growth Option";}
			if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount = "100000";}
			if(start_date == null || StringHelper.isEmpty(start_date)){start_date = start_date_str;}
			if(end_date == null || StringHelper.isEmpty(end_date)){end_date = end_date_str;}
            if(tax_rate == null || StringHelper.isEmpty(tax_rate) || !tax_rate.matches("[0-9]+")){tax_rate = "30";}
            
            amc = amc.trim();
            category = category.trim();
            scheme = scheme.trim();
            amount = amount.trim();
            start_date = start_date.trim();
            end_date = end_date.trim();
            tax_rate = tax_rate.trim();
            
            request.setAttribute("amc", amc);
            request.setAttribute("category", category);
            request.setAttribute("scheme_name", scheme);
            request.setAttribute("amount", amount);
            request.setAttribute("start_date", start_date);
            request.setAttribute("end_date", end_date);
            request.setAttribute("tax_rate", tax_rate);
            
            Date startDate = sdf.parse(start_date);
            Date endDate = sdf.parse(end_date);
            double years = UniqueIDProvider.getDiffYears(startDate, endDate);
            request.setAttribute("years", years);
            
            String formattedUrl, result = "";
            
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllCompanies, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("amcCompanies", mutualFundAPIResponse.getList());
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeDebtCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("schemeCategories", mutualFundAPIResponse.getList());
	     	
            HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("amc", amc);
            hashMap.put("category", category);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllMutualFundSchemesbyAmcAndCategory, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("schemes", mutualFundAPIResponse.getList());

            hashMap = new HashMap<String, String>();
            hashMap.put("scheme", scheme);
            hashMap.put("amount", amount);
            hashMap.put("start_date", start_date);
            hashMap.put("end_date", end_date);
            hashMap.put("tax_rate", tax_rate);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getFdVsDebt, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		FdVsDebtAPIResponse list = new Gson().fromJson(result, FdVsDebtAPIResponse.class);
	     	request.setAttribute("fDvsDebtResponse", list.getfDvsDebtResponse());
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
		 	result = HttpPost.SendHttpPost(formattedUrl);
		 	ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
		      request.setAttribute("nav_date", apiCommonResponse.getNav_date());
		    
		    String top_category =  request.getParameter("top_category");
	 		String top_period = request.getParameter("top_period");
	 		String type = "Open";
	 		String mode = "Growth";
	 		
	 		if(top_category == null){top_category= "Debt: Dynamic Bond";}
	 		if(top_period == null){top_period= "1y";}
	 		
	 		top_category = top_category.trim();
	 		top_period = top_period.trim();
	 		
            hashMap = new HashMap<String, String>();
            hashMap.put("period", top_period);
            hashMap.put("category", top_category);
            hashMap.put("type", type);
            hashMap.put("mode", mode);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemePerformanceReturns, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundSchemeAPIResponse schemePerformancesList = new Gson().fromJson(result, MutualFundSchemeAPIResponse.class);
	     	request.setAttribute("schemePerformances", schemePerformancesList.getList());
	 		
	 		request.setAttribute("top_category", top_category);
	 		request.setAttribute("top_period", top_period);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLatestNavDate, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);
	     	request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	     	
	     	request.setAttribute("page", "fixed-deposit-vs-debt-funds");	
	     	request.setAttribute("menu", "mf-research");
	     	request.setAttribute("jsp", "../amfi/fd-vs-debt.jsp");
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/liquid-funds-vs-savings-bank")
	public String liquid_funds_vs_savings_bank(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -1);
			String start_date_str = sdf.format(cal1.getTime());
            
			String amc = request.getParameter("amc");
    		String category = request.getParameter("category");
    		String scheme = request.getParameter("scheme");
    		String amount = request.getParameter("amount");
    		String start_date = request.getParameter("start_date");
    		String end_date = request.getParameter("end_date");
    		String tax_rate = request.getParameter("tax_rate");
    		String savings_rate = request.getParameter("savings_rate");
			
			if(amc == null){amc = "ICICI Prudential Mutual Fund";}
			if(category == null){category = "Debt: Liquid";}
			if(scheme == null || StringHelper.isEmpty(scheme)){scheme = "ICICI Prudential Liquid Fund - Growth";}
			if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount = "100000";}
			if(start_date == null || StringHelper.isEmpty(start_date)){start_date = start_date_str;}
			if(end_date == null || StringHelper.isEmpty(end_date)){end_date = end_date_str;}
            if(tax_rate == null || StringHelper.isEmpty(tax_rate) || !tax_rate.matches("[0-9]+")){tax_rate = "30";}
            if(savings_rate == null || StringHelper.isEmpty(savings_rate) || !savings_rate.matches("[0-9]+")){savings_rate = "4";}
            
            amc = amc.trim();
            category = category.trim();
            scheme = scheme.trim();
            amount = amount.trim();
            start_date = start_date.trim();
            end_date = end_date.trim();
            tax_rate = tax_rate.trim();
            savings_rate = savings_rate.trim();
            
            request.setAttribute("amc", amc);
            request.setAttribute("category", category);
            request.setAttribute("scheme_name", scheme);
            request.setAttribute("amount", amount);
            request.setAttribute("start_date", start_date);
            request.setAttribute("end_date", end_date);
            request.setAttribute("tax_rate", tax_rate);
            request.setAttribute("savings_rate", savings_rate);
            
            Date startDate = sdf.parse(start_date);
            Date endDate = sdf.parse(end_date);
            
            double years = UniqueIDProvider.getDiffYears(startDate, endDate);
            request.setAttribute("years", years);
    		
            String formattedUrl, result = "";
            
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllCompanies, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("amcCompanies", mutualFundAPIResponse.getList());
	     	
            HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("amc", amc);
            hashMap.put("category", category);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllMutualFundSchemesbyAmcAndCategory, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("schemes", mutualFundAPIResponse.getList());
	     	
            hashMap = new HashMap<String, String>();
            hashMap.put("amc", amc);
            hashMap.put("category", category);
            hashMap.put("scheme", scheme);
            hashMap.put("amount", amount);
            hashMap.put("start_date", start_date);
            hashMap.put("end_date", end_date);
            hashMap.put("tax_rate", tax_rate);
            hashMap.put("savings_rate", savings_rate);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLiquidFundsVsSavingsBank, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		LiquidFundsVsSavingsBankResponse schemePerformancesList = new Gson().fromJson(result, LiquidFundsVsSavingsBankResponse.class);
	     	request.setAttribute("fDvsDebtResponse", schemePerformancesList.getfDvsDebtResponse());
	     	
	     	formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
		 	result = HttpPost.SendHttpPost(formattedUrl);
		 	ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
		    request.setAttribute("nav_date", apiCommonResponse.getNav_date());
			
			request.setAttribute("page", "liquid-funds-vs-savings-bank");	  
			request.setAttribute("menu", "mf-research");
			request.setAttribute("jsp", "../amfi/savings-vs-liquid.jsp");
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/top-dividend-paying-mutual-funds")
	public String top_dividend_paying_mutual_funds(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{
			String category = request.getParameter("category");
			String period = request.getParameter("period");
			
			if(category == null || StringHelper.isEmpty(category)){category="Equity: Multi Cap";}
			if(period == null || StringHelper.isEmpty(period) || !period.matches("[0-9]+")){period="3";}
			
			category = category.trim();
			period = period.trim();
			
			String scheme_category = category.replaceAll("-", " ");
			
			request.setAttribute("category", category);
			request.setAttribute("scheme_category", scheme_category);
			request.setAttribute("period", period);
			
            String formattedUrl, result = "";
            
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("schemeCategories", mutualFundAPIResponse.getList());
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("category", category);
            hashMap.put("period", period);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getTopDividendPayingMutualFunds, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		TopDividendPayingMutualFundsApiResponse list = gson.fromJson(result, TopDividendPayingMutualFundsApiResponse.class);
	     	request.setAttribute("divided_annualized_returns_list", list.getList());
	     	
	     	Calendar cal = Calendar.getInstance();
			Date end_date = cal.getTime();
			request.setAttribute("end_date", end_date);
			
			formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
		 	result = HttpPost.SendHttpPost(formattedUrl);
		 	ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
		    request.setAttribute("nav_date", apiCommonResponse.getNav_date());
			
			request.setAttribute("page", "top-dividend-paying-mutual-funds");	
			request.setAttribute("menu", "mf-research");
			request.setAttribute("jsp", "../amfi/top-dividend-paying-mutual-funds.jsp");
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/top-dividend-paying-mutual-funds/{category}")
	public String top_dividend_paying_mutual_funds_category(@PathVariable(value="category") String category,
			HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	     	
			String period = request.getParameter("period");
			
			if(category == null || StringHelper.isEmpty(category)){category="Equity: Multi Cap";}
			if(period == null || StringHelper.isEmpty(period) || !period.matches("[0-9]+")){period="3";}
			
			category = category.trim();
			period = period.trim();
			
			String scheme_category = category.replaceAll("-", " ");
			
			request.setAttribute("category", category);
			request.setAttribute("scheme_category", scheme_category);
			request.setAttribute("period", period);
			
            String formattedUrl, result = "";
            
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("schemeCategories", mutualFundAPIResponse.getList());
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("category", category);
            hashMap.put("period", period);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getTopDividendPayingMutualFunds, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		TopDividendPayingMutualFundsApiResponse list = gson.fromJson(result, TopDividendPayingMutualFundsApiResponse.class);
	     	request.setAttribute("divided_annualized_returns_list", list.getList());
	     		     	
	     	Calendar cal = Calendar.getInstance();
			Date end_date = cal.getTime();
			request.setAttribute("end_date", end_date);
			
			formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getHomePageSIPNavDate, new HashMap<String, String>());
		 	result = HttpPost.SendHttpPost(formattedUrl);
		 	ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
		    request.setAttribute("nav_date", apiCommonResponse.getNav_date());
			
			request.setAttribute("page", "top-dividend-paying-mutual-funds");	
			request.setAttribute("menu", "mf-research");
			request.setAttribute("submenu", "Top Dividend Paying Mutual Funds");
			request.setAttribute("jsp", "../amfi/top-dividend-paying-mutual-funds.jsp");
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/mutual-funds-historical-dividends")
	public String historical_dividends(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	   		
			String scheme = "HDFC Equity Fund - Dividend Option";
			request.setAttribute("scheme", scheme);
			
			String formattedUrl, result = "";
	     	
			HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("scheme", scheme);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getMutualFundsHistoricalDividends, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		HistoricalDividendsResponse list = gson.fromJson(result, HistoricalDividendsResponse.class);
	 		List<DividendHistoryResponse> dividend_list = list.getList();
	 		
			//SchemeMapping schemeMapping = mutualFundOverviewDAO.getMutualFundSchemeMapping(scheme);
			request.setAttribute("schemeMapping", list.getSchemeMapping());
			
			//List<DividendHistoryResponse> dividend_list = mutualFundNavDAO.getSchemeDividendDetails(scheme);
			request.setAttribute("dividend_list", dividend_list);
			
			request.setAttribute("page", "historical-dividends");
			request.setAttribute("menu", "mf-research");
			request.setAttribute("jsp", "../amfi/historical-dividends.jsp");
			
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/mutual-funds-historical-dividends/{scheme:.+}")
	public String historical_dividends_scheme(@PathVariable(value="scheme") String scheme, HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	 
			if(scheme == null || StringHelper.isEmpty(scheme)){scheme = "HDFC Equity Fund - Dividend Option";}
			scheme = scheme.trim();
			request.setAttribute("scheme", scheme);
			
			scheme = scheme.replaceAll("'", "");
			
			String formattedUrl, result = "";
	     	
			HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("scheme", scheme);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getMutualFundsHistoricalDividends, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		HistoricalDividendsResponse list = gson.fromJson(result, HistoricalDividendsResponse.class);
	 		List<DividendHistoryResponse> dividend_list = list.getList();
	 		request.setAttribute("dividend_list", dividend_list);
	 		request.setAttribute("schemeMapping", list.getSchemeMapping());
			
			request.setAttribute("page", "mutual-funds-research");
			request.setAttribute("menu", "mf-research");
			request.setAttribute("submenu", "Historical Dividends");
			request.setAttribute("jsp", "../amfi/historical-dividends.jsp");
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/top-mutual-funds")
	public String topMutualFunds(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		try 
   		{
            String formattedUrl, result = "";
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLatestNavDate, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);
	     	request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	 		
    		request.setAttribute("page", "top-mutual-funds");
    		request.setAttribute("menu", "mf-research");
    		request.setAttribute("jsp", "../amfi/top-mutual-funds.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}    	
		return "layout/layout";
	}
	
	@RequestMapping(value="/getTopMutualFundsFull")
	public void getTopMutualFundsFull(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		PrintWriter writer = response.getWriter();
		response.setContentType("text/Html");
		Gson gson = new Gson();
		
		try 
   		{
            String category =  request.getParameter("category");
	 		String period = request.getParameter("period");
	 		String type = request.getParameter("type");
	 		String mode = request.getParameter("mode");
	 		String category_name = category;
	 		
	 		if(category == null){category= "";}
	 		if(category_name == null){category_name= "";}
	 		if(period == null){period= "5y";}
	 		if(type == null){type= "Open";}
	 		if(mode == null){mode= "Growth";}
	 		
	 		category = category.trim();
	 		category_name = category_name.trim();
	 		period = period.trim();
	 		type = type.trim();
	 		mode = mode.trim();
	 		
	 		List<String> category_list = new ArrayList<String>();
	 		List<Top10FundsByCategory> top10FundsByCategory = new  ArrayList<Top10FundsByCategory>();
			if(category.equalsIgnoreCase("All Equity"))
			{
				category_list.add("Equity: Large Cap");
				category_list.add("Equity: Mid Cap");
				category_list.add("Equity: Small Cap");
				category_list.add("Equity: Large and Mid Cap");
				category_list.add("Equity: Multi Cap");
				category_list.add("Equity: Focussed");
				for(String cat: category_list) {
					top10FundsByCategory.addAll(commonDao.getTop10FundsByCategory(period, cat, type, 1000, mode, category_list));
				}
				
			} else if(category.equalsIgnoreCase("All Debt"))
			{
				category_list.add("Debt: Banking and PSU");
				category_list.add("Debt: Corporate Bond");
				category_list.add("Debt: Credit Risk");
				category_list.add("Debt: Dynamic Bond");
				category_list.add("Debt: Low Duration");
				category_list.add("Debt: Medium Duration");
				category_list.add("Debt: Money Market");
				category_list.add("Debt: Ultra Short Duration");
				category_list.add("Debt: Short Duration");
				for(String cat: category_list) {
					top10FundsByCategory.addAll(commonDao.getTop10FundsByCategory(period, cat, type, 1000, mode, category_list));
				}
				
			} else if(category.equalsIgnoreCase("All Hybrid"))
			{
				category_list.add("Hybrid: Multi Asset Allocation");
				category_list.add("Hybrid: Aggressive");
				category_list.add("Hybrid: Dynamic Asset Allocation");
				category_list.add("Hybrid: Arbitrage");
				category_list.add("Hybrid: Equity Savings");
				category_list.add("Hybrid: Conservative");
				for(String cat: category_list) {
					top10FundsByCategory.addAll(commonDao.getTop10FundsByCategory(period, cat, type, 1000, mode, category_list));
				}
			} else if(category.equalsIgnoreCase("")) {
				category_list.add("Equity: Large Cap");
				category_list.add("Equity: Mid Cap");
				category_list.add("Equity: Small Cap");
				category_list.add("Equity: Large and Mid Cap");
				category_list.add("Equity: Multi Cap");
				category_list.add("Equity: Focussed");
				category_list.add("Equity: ELSS");
				category_list.add("Debt: Banking and PSU");
				category_list.add("Debt: Corporate Bond");
				category_list.add("Debt: Credit Risk");
				category_list.add("Debt: Dynamic Bond");
				category_list.add("Debt: Low Duration");
				category_list.add("Debt: Medium Duration");
				category_list.add("Debt: Money Market");
				category_list.add("Debt: Ultra Short Duration");
				category_list.add("Debt: Short Duration");
				category_list.add("Debt: Liquid");
				category_list.add("Hybrid: Multi Asset Allocation");
				category_list.add("Hybrid: Aggressive");
				category_list.add("Hybrid: Dynamic Asset Allocation");
				category_list.add("Hybrid: Arbitrage");
				category_list.add("Hybrid: Equity Savings");
				category_list.add("Hybrid: Conservative");
				category_list.add("Childrens Fund");
				for(String cat: category_list) {
					top10FundsByCategory.addAll(commonDao.getTop10FundsByCategory(period, cat, type, 1000, mode, category_list));
				}
			} else
			{
				category_list.add(category);
				for(String cat: category_list) {
					top10FundsByCategory.addAll(commonDao.getTop10FundsByCategory(period, cat, type, 1000, mode, category_list));
				}
			}
	 		
			if(top10FundsByCategory != null && top10FundsByCategory.size() > 0)
	 		{
	 			for (Top10FundsByCategory top10FundsByCategory2 : top10FundsByCategory) 
		 		{
		 			if(period.equalsIgnoreCase("6m")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_abs_6month());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_6month_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_6month_current_value());
	 				} else if(period.equalsIgnoreCase("1y")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_abs_1year());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_1year_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_1year_current_value());
	 				} else if(period.equalsIgnoreCase("3y")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_cmp_3year());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_3year_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_3year_current_value());
	 				} else if(period.equalsIgnoreCase("5y")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_cmp_5year());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_5year_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_5year_current_value());
	 				} else if(period.equalsIgnoreCase("10y")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_cmp_10year());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_10year_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_10year_current_value());
	 				} else if(period.equalsIgnoreCase("SI")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_cmp_inception());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_inception_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_inception_current_value());
	 				}
		 			if(top10FundsByCategory2.getDoubled_in().equalsIgnoreCase("") || top10FundsByCategory2.getDoubled_in().equalsIgnoreCase("0 Yr 0 Mn")) {
		 				top10FundsByCategory2.setDoubled_in("-");
		 			}		 			
				}
	 		}
			
			top10FundsByCategory = top10FundsByCategory.stream()
					  .sorted(Comparator.comparing(Top10FundsByCategory::getLumpsumToDisplay).reversed())
					  .collect(Collectors.toList());
			
			writer.print(gson.toJson(top10FundsByCategory));
		    writer.close();
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}	
	}
	
	@RequestMapping(value="/model-portfolio")
	public String model_portfolio(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Gson  gson = new Gson();
		
    	try 
   		{
    		String risk = request.getParameter("risk");
    		if(risk == null || StringHelper.isEmpty(risk)){risk = "Aggressive";}
    		risk = risk.trim();
    		request.setAttribute("risk", risk);
    		
    		List<String> amfi_code_list = new ArrayList<String>();
    		
    	//Equity	
    		//Flexicap
    		amfi_code_list.add("101922"); // Canara Robeco Flexicap Fund - Regular Plan - Growth Option
    		amfi_code_list.add("122640"); // Parag Parikh Flexi Cap Fund - Regular Plan - Growth
    		amfi_code_list.add("133836"); // PGIM India Flexi Cap Fund - Regular Plan - Growth Option
    		amfi_code_list.add("100668"); // UTI Flexi Cap Fund - Regular Plan - IDCW
    		
    		//Focused
    		amfi_code_list.add("102756"); // SBI Focused Equity Fund - Regular Plan -Growth
    		
    		//Large and Mid cap
    		amfi_code_list.add("112932"); // Mirae Asset Emerging Bluechip Fund - Regular Plan - Growth Option
    		amfi_code_list.add("103024"); // SBI Large & MIDCap Fund- Regular Plan -Growth
    		
    		//Large cap
    		amfi_code_list.add("106235"); // Nippon India Large Cap  Fund- Growth Plan -Growth Option
    		amfi_code_list.add("118069"); // L&T India Large Cap Fund - Regular Plan - Growth
    		
    		//Mid Cap
    		amfi_code_list.add("142109"); // Mahindra Manulife Mid Cap Unnati Yojana - Regular Plan - Growth
    		amfi_code_list.add("125305"); // PGIM India Midcap Opportunities Fund - Regular Plan - Growth Option
    		amfi_code_list.add("104908"); // Kotak Emerging Equity Scheme - Growth
    		
    		//Multi Cap
    		amfi_code_list.add("100631"); // Quant Active Fund-GROWTH OPTION - Regular Plan
    		amfi_code_list.add("101161"); // Nippon India Multi Cap Fund-Growth Plan-Growth Option
    		
    		//Value Oriented
    		amfi_code_list.add("105460"); // Invesco India Contra Fund - Growth  |  Equity: Contra          
    		amfi_code_list.add("103040"); // Kotak India EQ Contra Fund - Growth  |  Equity: Contra
    		amfi_code_list.add("102594"); // ICICI Prudential Value Discovery Fund - Growth  |  Equity: Value
    		
    		//Small Cap
    		amfi_code_list.add("113177"); // Nippon India Small Cap Fund - Growth Plan - Growth Option  
    		amfi_code_list.add("125494"); // SBI Small Cap Fund - Regular Plan - Growth
    		amfi_code_list.add("129647"); // Union Small Cap Fund - Regular Plan - Growth Option  
    		
    		//ELSS
    		amfi_code_list.add("111722"); // Canara Robeco Equity Tax Saver Fund - Regular Plan - Growth Option 
    		amfi_code_list.add("135784"); // Mirae Asset Tax Saver Fund-Regular Plan-Growth 
    		amfi_code_list.add("147482"); // Parag Parikh Tax Saver Fund- Regular Growth 
    		
    		//Pharma
    		amfi_code_list.add("145456"); // DSP Healthcare Fund - Regular Plan - Growth                                
    		                                                                               
    		//Thematic                                                                      
    		amfi_code_list.add("102751"); // Nippon India Consumption Fund-Growth Plan-Growth Option                                 	                     
    		amfi_code_list.add("150308"); // ICICI Prudential Housing Opportunities Fund - Growth                                 
    		amfi_code_list.add("149840"); // Kotak Manufacture in India Fund - Regular Plan Growth                                 
    		amfi_code_list.add("109445"); // ICICI Prudential Banking and Financial Services Fund -  Growth                                 
    		amfi_code_list.add("102397"); // UTI Transportation and Logistics Fund - Regular Plan - IDCW                     NOT SURE            
    		                                                                                
    		//Technology                                                                    
    		amfi_code_list.add("100363"); // ICICI Prudential Technology Fund - Growth                                 
    		amfi_code_list.add("135797"); // Tata Digital India Fund-Regular Plan-Growth                                 
    		                                                                                
    		//Infrastructure                                                                
    		amfi_code_list.add("106654"); // Invesco India Infrastructure Fund - Growth Option                                 
    		                                                                                
    	//HYBRID	                                                                        
    		//Dynamic Asset Allocation                                                      
    		amfi_code_list.add("126394"); // DSP Dynamic Asset Allocation Fund - Regular Plan - Growth                                 
    		amfi_code_list.add("104685"); // ICICI Prudential Balanced Advantage Fund - Growth                                 
    		amfi_code_list.add("112117"); // Edelweiss Balanced Advantage Fund - Regular Plan - Growth Option                                 
    		                                                                                
    		//Aggressive                                                                    
    		amfi_code_list.add("106166"); // Canara Robeco Equity Hybrid Fund - Regular Plan - Growth Option                                 
    		amfi_code_list.add("100356"); // ICICI Prudential Equity & Debt Fund - Growth                                 
    		amfi_code_list.add("134815"); // Mirae Asset Hybrid-Equity Fund -Regular Plan-Growth                                 
    		                                                                                
    		//Arbitrage                                                                     
    		amfi_code_list.add("130205"); // Edelweiss Arbitrage Fund- Regular Plan- Growth Option                                 
    		amfi_code_list.add("113345"); // Nippon India Arbitrage Fund - Growth Plan - Growth Option                                 
    		                                                                                
    		//Equity Savings                                                                
    		amfi_code_list.add("131372"); // Kotak Equity Savings Fund - Regular - Growth  
    		amfi_code_list.add("149674"); // Sundaram Equity Savings Fund (Formerly Known as Principal Equity Savings Fund) - Growth Option
    		
    		//Conservative Hybrid                                                               
    		amfi_code_list.add("148959"); // Parag Parikh Conservative Hybrid Fund - Regular Plan - Growth
    		amfi_code_list.add("100968"); // SBI Conservative Hybrid Fund - Regular Plan - Growth
    		                                                                                
    	//DEBT                                                                              
    		//Short Duration                                                                
    		amfi_code_list.add("112354"); // Axis Short Term Fund - Regular Plan - Growth Option                                 
    		amfi_code_list.add("113047"); // HDFC Short Term  Debt Fund - Growth Option                                 
    		amfi_code_list.add("101373"); // Kotak Bond Short Term Plan-(Growth)                                 
    		                                                                                
    		//Low Duration                                                                  
    		amfi_code_list.add("111753"); // Nippon India Low Duration Fund- Growth Plan - Growth Option                                 
    		amfi_code_list.add("133805"); // Kotak Low Duration Fund- Regular Plan-Growth Option                                 
    		                                                                                
    		//Medium Duration                                                               
    		amfi_code_list.add("148448"); // Bharat Bond FOF- April 2025- Regular Plan- Growth Option                                 
    		amfi_code_list.add("147850"); // Bharat Bond FOF - April 2023 - Regular Plan - Growth Option                                 
    		amfi_code_list.add("102741"); // ICICI Prudential Medium Term Bond Fund - Growth                                 
    		                                                                                
    		//Corporate Bond
    		amfi_code_list.add("113070"); // HDFC Corporate Bond Fund - Growth Option 
    		amfi_code_list.add("111987"); // ICICI Prudential Corporate Bond Fund - Growth 
    		amfi_code_list.add("133782"); // Kotak Corporate Bond Fund- Regular Plan-Growth Option 
    		amfi_code_list.add("103178"); // Aditya Birla Sun Life Corporate Bond Fund - Growth - Regular Plan 
    		
    		//Liquid
    		amfi_code_list.add("112210"); // Axis Liquid Fund - Regular Plan - Growth Option 
    		amfi_code_list.add("103340"); // ICICI Prudential Liquid Fund - Growth 
    		amfi_code_list.add("105280"); // SBI Liquid Fund - Regular Plan -Growth 
    		amfi_code_list.add("100047"); // Aditya Birla Sun Life Liquid Fund - Growth 
    		
    		//Banking & PSU
    		amfi_code_list.add("121280"); // IDFC-IDFC Banking & PSU Debt Fund - Regular Growth 
    		amfi_code_list.add("140283"); // Edelweiss Banking and PSU Debt Fund - Regular Plan - Growth Option 
    		
    		//Floater
    		amfi_code_list.add("102673"); // Nippon India Floating Rate Fund - Growth Plan-Growth Option 
    		amfi_code_list.add("106841"); // HDFC Floating Rate Debt Fund - Growth Option 
    		amfi_code_list.add("122644"); // Aditya Birla Sun Life Floating Rate Fund-Regular Plan-Growth 
    		
    		//Money Market
    		amfi_code_list.add("103048"); // Nippon India Money Market Fund-Growth Plan-Growth Option 
    		amfi_code_list.add("101976"); // Aditya Birla Sun Life Money Manager Fund - Growth 
    		
    		//Credit risk
    		amfi_code_list.add("128053"); // HDFC Credit Risk Debt Fund - Growth Option 
    		amfi_code_list.add("114239"); // ICICI Prudential Credit Risk Fund - Growth 
    		
    		//Gilt-with 10 year constant duration
    		amfi_code_list.add("101002"); // SBI Magnum Constant Maturity Fund - Regular Plan - Growth 
    		
    		//Dynamic Bond                                                                  
    		amfi_code_list.add("113077"); // UTI Dynamic Bond Fund - Regular Plan - Growth Option                                 
    		amfi_code_list.add("112096"); // ICICI Prudential All Seasons Bond Fund - Growth       
    		
    		//Fund of Funds-Domestic-Debt
    		amfi_code_list.add("102139"); // ICICI Prudential Income Optimizer Fund (FOF) - Growth 
    		                                                                                
    		
    		
			List<SchemePerformances> list = commonDao.getModelPortfolioNew(amfi_code_list);
			SchemePerformancesBenchmark benchmark_performance = commonDao.getBenchmarkPerformance();
			List<SchemePerformancesCategory> category_list = commonDao.getAllCategoryPerformance();
			List<String> equity_category_list = commonDao.getEquityCategories();
    		
			List<ModelPortfolioResponse> aggressive_list = new ArrayList<ModelPortfolioResponse>();
	 		List<ModelPortfolioResponse> moderately_aggressive_list = new ArrayList<ModelPortfolioResponse>();
	 		List<ModelPortfolioResponse> moderate_list = new ArrayList<ModelPortfolioResponse>();
	 		List<ModelPortfolioResponse> moderately_conservative_list = new ArrayList<ModelPortfolioResponse>();
	 		List<ModelPortfolioResponse> conservative_list = new ArrayList<ModelPortfolioResponse>();
	 		ModelPortfolioResponse model = null;
	 		
	 		for (SchemePerformances scheme : list) 
	 		{
	 			String scheme_code = scheme.getScheme_amfi_code();
	 			String category = scheme.getScheme_category();
	 			
	 			model = new ModelPortfolioResponse();
	 			model.setScheme_amfi(scheme.getScheme_amfi());
	 			model.setScheme_amfi_code(scheme_code);
	 			model.setScheme_category(category);
	 			model.setReturns_abs_1year(scheme.getReturns_abs_1year());
	 			model.setReturns_cmp_3year(scheme.getReturns_cmp_3year());
	 			model.setReturns_cmp_5year(scheme.getReturns_cmp_5year());
	 			model.setReturns_cmp_10year(scheme.getReturns_cmp_10year());
	 			
	 			if(equity_category_list.contains(category))
	 			{
	 				model.setBenchmark_name(benchmark_performance.getBenchmark_name());
	 				model.setBenchmark_returns_abs_1year(benchmark_performance.getReturns_abs_1year());
	 				model.setBenchmark_returns_cmp_3year(benchmark_performance.getReturns_cmp_3year());
	 				model.setBenchmark_returns_cmp_5year(benchmark_performance.getReturns_cmp_5year());
	 				model.setBenchmark_returns_cmp_10year(benchmark_performance.getReturns_cmp_10year());
	 			}
	 			for (SchemePerformancesCategory category_performance : category_list) 
		 		{
	 				String sector = category_performance.getSector();
	 				if(sector.equalsIgnoreCase(category))
	 				{
	 					model.setCategory_name(sector);
	 					model.setCategory_returns_abs_1year(category_performance.getReturns_abs_1year());
	 					model.setCategory_returns_cmp_3year(category_performance.getReturns_cmp_3year());
	 					model.setCategory_returns_cmp_5year(category_performance.getReturns_cmp_5year());
	 					model.setCategory_returns_cmp_10year(category_performance.getReturns_cmp_10year());
			 			break;
	 				}
		 		}
	 			
	 			if(scheme_code.equalsIgnoreCase("112932") || scheme_code.equalsIgnoreCase("142109") || scheme_code.equalsIgnoreCase("113177") || 
 				   scheme_code.equalsIgnoreCase("106166") || scheme_code.equalsIgnoreCase("100356"))
	 			{
	 				aggressive_list.add(model);
	 			}
	 			if(scheme_code.equalsIgnoreCase("112932") || scheme_code.equalsIgnoreCase("103024") || scheme_code.equalsIgnoreCase("106235") || 
	  				   scheme_code.equalsIgnoreCase("118069") || scheme_code.equalsIgnoreCase("106166"))
	 			{
	 				moderately_aggressive_list.add(model);
	 			}
	 			if(scheme_code.equalsIgnoreCase("106235") || scheme_code.equalsIgnoreCase("118069") || scheme_code.equalsIgnoreCase("106166") || 
	  				   scheme_code.equalsIgnoreCase("100356") || scheme_code.equalsIgnoreCase("131372"))
	 			{
	 				moderate_list.add(model);
	 			}
	 			if(scheme_code.equalsIgnoreCase("106166") || scheme_code.equalsIgnoreCase("100356") || scheme_code.equalsIgnoreCase("134815") || 
	  				   scheme_code.equalsIgnoreCase("131372") || scheme_code.equalsIgnoreCase("149674"))
	 			{
	 				moderately_conservative_list.add(model);
	 			}
	 			if(scheme_code.equalsIgnoreCase("113077") || scheme_code.equalsIgnoreCase("112096") || scheme_code.equalsIgnoreCase("102139") || 
	  				   scheme_code.equalsIgnoreCase("148959") || scheme_code.equalsIgnoreCase("100968"))
	 			{
	 				conservative_list.add(model);
	 			}
			}
	 		request.setAttribute("aggressive_list", aggressive_list);
	 		request.setAttribute("moderately_aggressive_list", moderately_aggressive_list);
	 		request.setAttribute("moderate_list", moderate_list);
	 		request.setAttribute("moderately_conservative_list", moderately_conservative_list);
	 		request.setAttribute("conservative_list", conservative_list);
	 		
	 		request.setAttribute("aggressive_list_json", gson.toJson(aggressive_list));
	 		request.setAttribute("moderately_aggressive_list_json", gson.toJson(moderately_aggressive_list));
	 		request.setAttribute("moderate_list_json", gson.toJson(moderate_list));
	 		request.setAttribute("moderately_conservative_list_json", gson.toJson(moderately_conservative_list));
	 		request.setAttribute("conservative_list_json", gson.toJson(conservative_list));
	     	
	     	request.setAttribute("page", "model-portfolio");
	     	request.setAttribute("jsp", "../amfi/model-portfolio.jsp");
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}
    	return "layout/layout";
	}
	
	@RequestMapping(value="/getSchemePerformanceReturns")
	public void getSchemePerformanceReturns(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
    	PrintWriter writer = response.getWriter();
		response.setContentType("text/Html");
		Gson gson = new Gson();

		try 
		{
            String period = request.getParameter("period");
            String category = request.getParameter("category");
            String type = request.getParameter("type");
            String maxno = request.getParameter("maxno");
            String mode = request.getParameter("mode");
            
            if(period == null || StringHelper.isEmpty(period)){period = "1y";}
            if(category == null || StringHelper.isEmpty(category)){category = "Equity: Multi Cap";}
            if(type == null || StringHelper.isEmpty(type)){type = "Open";}
            if(maxno == null || StringHelper.isEmpty(maxno)){maxno = "1000";};
            if(mode == null || StringHelper.isEmpty(mode)){mode = "Growth";}
            
            period = period.trim();
            category = category.trim();
            type = type.trim();
            maxno = maxno.trim();
            mode = mode.trim();
            
            String formattedUrl, result = "";
	     	
            HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("category", category);
            hashMap.put("period", period);
            hashMap.put("type", type);
            hashMap.put("maxno", maxno);
            hashMap.put("mode", mode);
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemePerformanceReturns, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundSchemeAPIResponse list = new Gson().fromJson(result, MutualFundSchemeAPIResponse.class);            
            List<SchemePerformances> schemePerformances = list.getList();
            		
    		writer.print(gson.toJson(schemePerformances));
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/getTopMutualFunds")
	public void getTopMutualFunds(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		PrintWriter writer = response.getWriter();
		response.setContentType("text/Html");
		Gson gson = new Gson();
		
		try 
   		{
            String category =  request.getParameter("category");
	 		String period = request.getParameter("period");
	 		String type = request.getParameter("type");
	 		String mode = request.getParameter("mode");
	 		String category_name = category;
	 		
	 		if(category == null){category= "";}
	 		if(category_name == null){category_name= "";}
	 		if(period == null){period= "5y";}
	 		if(type == null){type= "Open";}
	 		if(mode == null){mode= "Growth";}
	 		
	 		category = category.trim();
	 		category_name = category_name.trim();
	 		period = period.trim();
	 		type = type.trim();
	 		mode = mode.trim();
	 		
	 		List<String> category_list = new ArrayList<String>();
	 		List<Top10FundsByCategory> top10FundsByCategory = new  ArrayList<Top10FundsByCategory>();
			if(category.equalsIgnoreCase("All Equity"))
			{
				category_list.add("Equity: Large Cap");
				category_list.add("Equity: Mid Cap");
				category_list.add("Equity: Small Cap");
				category_list.add("Equity: Large and Mid Cap");
				category_list.add("Equity: Multi Cap");
				category_list.add("Equity: Focussed");
				for(String cat: category_list) {
					top10FundsByCategory.addAll(commonDao.getTop10FundsByCategory(period, cat, type, 1000, mode, category_list));
				}
				
			} else if(category.equalsIgnoreCase("All Debt"))
			{
				category_list.add("Debt: Banking and PSU");
				category_list.add("Debt: Corporate Bond");
				category_list.add("Debt: Credit Risk");
				category_list.add("Debt: Dynamic Bond");
				category_list.add("Debt: Low Duration");
				category_list.add("Debt: Medium Duration");
				category_list.add("Debt: Money Market");
				category_list.add("Debt: Ultra Short Duration");
				category_list.add("Debt: Short Duration");
				for(String cat: category_list) {
					top10FundsByCategory.addAll(commonDao.getTop10FundsByCategory(period, cat, type, 1000, mode, category_list));
				}
				
			} else if(category.equalsIgnoreCase("All Hybrid"))
			{
				category_list.add("Hybrid: Multi Asset Allocation");
				category_list.add("Hybrid: Aggressive");
				category_list.add("Hybrid: Dynamic Asset Allocation");
				category_list.add("Hybrid: Arbitrage");
				category_list.add("Hybrid: Equity Savings");
				category_list.add("Hybrid: Conservative");
				for(String cat: category_list) {
					top10FundsByCategory.addAll(commonDao.getTop10FundsByCategory(period, cat, type, 1000, mode, category_list));
				}
			} else if(category.equalsIgnoreCase("")) {
				category_list.add("Equity: Large Cap");
				category_list.add("Equity: Mid Cap");
				category_list.add("Equity: Small Cap");
				category_list.add("Equity: Large and Mid Cap");
				category_list.add("Equity: Multi Cap");
				category_list.add("Equity: Focussed");
				category_list.add("Equity: ELSS");
				category_list.add("Debt: Banking and PSU");
				category_list.add("Debt: Corporate Bond");
				category_list.add("Debt: Credit Risk");
				category_list.add("Debt: Dynamic Bond");
				category_list.add("Debt: Low Duration");
				category_list.add("Debt: Medium Duration");
				category_list.add("Debt: Money Market");
				category_list.add("Debt: Ultra Short Duration");
				category_list.add("Debt: Short Duration");
				category_list.add("Debt: Liquid");
				category_list.add("Hybrid: Multi Asset Allocation");
				category_list.add("Hybrid: Aggressive");
				category_list.add("Hybrid: Dynamic Asset Allocation");
				category_list.add("Hybrid: Arbitrage");
				category_list.add("Hybrid: Equity Savings");
				category_list.add("Hybrid: Conservative");
				category_list.add("Childrens Fund");
				for(String cat: category_list) {
					top10FundsByCategory.addAll(commonDao.getTop10FundsByCategory(period, cat, type, 1000, mode, category_list));
				}
			} else
			{
				category_list.add(category);
				for(String cat: category_list) {
					top10FundsByCategory.addAll(commonDao.getTop10FundsByCategory(period, cat, type, 1000, mode, category_list));
				}
			}
	 		
			if(top10FundsByCategory != null && top10FundsByCategory.size() > 0)
	 		{
	 			for (Top10FundsByCategory top10FundsByCategory2 : top10FundsByCategory) 
		 		{
		 			if(period.equalsIgnoreCase("6m")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_abs_6month());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_6month_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_6month_current_value());
	 				} else if(period.equalsIgnoreCase("1y")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_abs_1year());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_1year_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_1year_current_value());
	 				} else if(period.equalsIgnoreCase("3y")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_cmp_3year());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_3year_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_3year_current_value());
	 				} else if(period.equalsIgnoreCase("5y")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_cmp_5year());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_5year_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_5year_current_value());
	 				} else if(period.equalsIgnoreCase("10y")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_cmp_10year());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_10year_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_10year_current_value());
	 				} else if(period.equalsIgnoreCase("SI")) {
	 					top10FundsByCategory2.setReturnToDisplay(top10FundsByCategory2.getReturns_cmp_inception());
	 					top10FundsByCategory2.setLumpsumToDisplay(top10FundsByCategory2.getLumpsum_inception_current_value());
	 					top10FundsByCategory2.setSipToDisplay(top10FundsByCategory2.getSip_inception_current_value());
	 				}
		 			if(top10FundsByCategory2.getDoubled_in() == null || top10FundsByCategory2.getDoubled_in().equalsIgnoreCase("") || top10FundsByCategory2.getDoubled_in().equalsIgnoreCase("0 Yr 0 Mn")) {
		 				top10FundsByCategory2.setDoubled_in("-");
		 			}		 			
				}
	 		}
			
			top10FundsByCategory = top10FundsByCategory.stream()
					  .sorted(Comparator.comparing(Top10FundsByCategory::getLumpsumToDisplay).reversed())
					  .collect(Collectors.toList());
			
			writer.print(gson.toJson(top10FundsByCategory.stream().limit(5).collect(Collectors.toList())));
		    writer.close();
   		}
       	catch(Exception ex)
       	{
       		ex.printStackTrace();
       	}	
	}
}
