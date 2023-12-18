package com.dakshin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.internal.util.StringHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dakshin.amfi.dao.AmfiApiAccessRepository;
import com.dakshin.amfi.model.SchemeMapping;
import com.dakshin.amfi.model.SchemeRollingReturns;
import com.dakshin.amfi.response.ApiCommonResponse;
import com.dakshin.amfi.response.LumpsumReturnsAPIResponse;
import com.dakshin.amfi.response.RollingReturnsMultipleSchemesAPIResponse;
import com.dakshin.amfi.response.SchemeInfoApiResponse;
import com.dakshin.amfi.response.SchemePortfolioAnalysisApiResponse;
import com.dakshin.amfi.response.SchemePortfolioAnalysisResponse;
import com.dakshin.amfi.response.SchemePortfolioResponse;
import com.dakshin.amfi.response.SchemeSipLumpsumReturnsApiResponse;
import com.dakshin.response.CommonResponse;
import com.dakshin.response.PortfolioAnalysisResponse;
import com.dakshin.utils.CommonUtils;
import com.dakshin.utils.HttpPost;
import com.dakshin.utils.MfApiAccessor;
import com.dakshin.utils.MfApiUrls;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping(value="/mutual-funds-research")
public class MutualFundSchemeOverviewController 
{

	@Autowired
	AmfiApiAccessRepository amfiApiAccessRepository;
	
	@RequestMapping(value="/{scheme:.+}")
   	public String locateoffice(@PathVariable(value="scheme") String scheme,HttpServletRequest request, HttpServletResponse response) 
   	{
		String scheme_amfi_code = null;
		
		try
		{			
			if(scheme == null || StringHelper.isEmpty(scheme)){scheme = "HDFC Top 100 Fund - Growth Option";}
            scheme = scheme.replaceAll("&amp;", "&");
            scheme = scheme.replaceAll("'", "");
            scheme = scheme.trim();          
            String formattedUrl, result = "";
            
            HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("scheme", scheme);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemeInfo, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	 
	 		SchemeInfoApiResponse schemeInfoApiResponse = new Gson().fromJson(result, SchemeInfoApiResponse.class); 		
	 		
	 		SchemeMapping schemeMapping = schemeInfoApiResponse.getSchemeMapping();
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLatestNavDate, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class);	 		
	 		request.setAttribute("nav_date", apiCommonResponse.getNav_date());
	 		request.setAttribute("schemePerformances", schemeInfoApiResponse.getSchemePerformances());	
	 		if(schemeMapping != null)
	 		{
	 			
	 			scheme_amfi_code = schemeMapping.getScheme_amfi_code();
	 			request.setAttribute("scheme_amfi_code", scheme_amfi_code);
	 			
	    		
	    		hashMap = new HashMap<String, String>();
		 		hashMap.put("scheme_amfi_common", schemeMapping.getScheme_amfi_common());
		 		
		 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemeMarketCapDistribution, hashMap);
		 		result = HttpPost.SendHttpPost(formattedUrl);
		 		SchemePortfolioResponse schemePortfolioResponse = new Gson().fromJson(result, SchemePortfolioResponse.class); 
		 		request.setAttribute("stocksMapList", schemePortfolioResponse.getStocksMap());
		 		
	    		
	 			hashMap = new HashMap<String, String>();
		 		hashMap.put("scheme_code", scheme_amfi_code);
		 		
		 		List<Date> dateMap = new ArrayList<Date>();
		 		
		 		Calendar cal2 = Calendar.getInstance();
		 		cal2.setTime(schemeInfoApiResponse.getScheme_sip_start_date());
		 		cal2.add(Calendar.MONTH, -1);
		 		Date schemeStartDate = cal2.getTime();
		 		dateMap.add(schemeStartDate);
		 		
				if(schemeInfoApiResponse.getScheme_sip_end_date() != null) {
					dateMap.add(schemeInfoApiResponse.getScheme_sip_end_date());
				}
		 		request.setAttribute("dateMap", dateMap);
		 		
		 		request.setAttribute("fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse", schemeInfoApiResponse.getFundPerformanceOverviewAgainstBenchmarkAndCategoryResponse());

		 		hashMap = new HashMap<String, String>();
		 		hashMap.put("scheme_amfi_common", schemeMapping.getScheme_amfi_common());
		 		
		 		if(schemeMapping.getDividend_scheme())
		 		{
		 			request.setAttribute("dividend_list", schemeInfoApiResponse.getDividend_list());
		 		}
		 		Calendar cal = Calendar.getInstance();
		 		cal.add(Calendar.YEAR, -5);
		 		Date rolling_returns_start_date = cal.getTime();
		 		request.setAttribute("rolling_returns_start_date", rolling_returns_start_date);
		 		
		 		request.setAttribute("scheme_benchmark", schemeInfoApiResponse.getScheme_benchmark());
		 		
		 		request.setAttribute("peerComparisonResponse", schemeInfoApiResponse.getPeerComparisonResponse());
		 		
		 		request.setAttribute("schemeMapping", schemeMapping);
		 		
		 		hashMap = new HashMap<String, String>();
		 		
	 		}
	 		else
	 		{
	 			return "forward:/mutual-funds-research";
	 		}
	 		
	 		request.setAttribute("scheme", scheme);
	 		
			
	     	request.setAttribute("page", "scheme-overview");
	     	request.setAttribute("jsp", "../amfi/scheme-overview.jsp");
	     	
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
		return "layout/layout";
   	}
	
	@RequestMapping(value="/getSIPReturnsTable")
	public void getSIPReturnsTable(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
    	PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
	
		try 
		{	
    		String fund = request.getParameter("scheme_amfi_name");
    		String amount = request.getParameter("amount");
    		String frequency = request.getParameter("frequency");
    		String startDate = request.getParameter("startDate");
    		String endDate = request.getParameter("endDate");

    		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -1);
			cal1.add(Calendar.MONTH, 1);
			String start_date_str = sdf.format(cal1.getTime());
    		
    		if(fund == null || StringHelper.isEmpty(fund)){fund= "HDFC Equity Fund - Growth Option";}
	 		if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount= "3000";}
	 		if(frequency == null || StringHelper.isEmpty(frequency)){frequency= "Monthly";}
	 		if(startDate == null || StringHelper.isEmpty(startDate) || !startDate.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){startDate = start_date_str;}
	 		if(endDate == null || StringHelper.isEmpty(endDate) || !endDate.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){endDate = end_date_str;}
	 		
	 		fund = fund.trim();
	 		amount = amount.trim();
	 		frequency = frequency.trim();
	 		startDate = startDate.trim();
	 		endDate = endDate.trim();
    		
    		String scheme_amfi_name = fund;
            scheme_amfi_name = scheme_amfi_name.replaceAll("&amp;", "&");
			
            HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("scheme_name", fund);
	 		hashMap.put("frequency", frequency);
	 		hashMap.put("startDate", startDate);
	 		hashMap.put("amount",amount);
	 		hashMap.put("endDate",endDate);
	 		
	 		String formattedUrl, result = "";
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemeSipReturns, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	
	 		SchemeSipLumpsumReturnsApiResponse mutualFundSchemeAPIResponse = new Gson().fromJson(result, SchemeSipLumpsumReturnsApiResponse.class); 		
	 		request.setAttribute("schemePerformances", mutualFundSchemeAPIResponse.getSipSchemePerformanceResponse());
	 		
			writer.print(gson.toJson(mutualFundSchemeAPIResponse.getSipSchemePerformanceResponse()));
		    writer.close();
		} 
		catch (Exception ex) 
		{
		    writer.close();
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/getSIPReturnsForFundOverview")
	public void getSIPReturnsForFundOverview(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		
		try 
		{
			String fund = request.getParameter("scheme_amfi_name");
    		String amount = request.getParameter("amount");
    		String frequency = request.getParameter("frequency");
    		String startDate = request.getParameter("startDate");
    		String endDate = request.getParameter("endDate");
    		
    		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -1);
			cal1.add(Calendar.MONTH, 1);
			String start_date_str = sdf.format(cal1.getTime());
    		
    		if(fund == null || StringHelper.isEmpty(fund)){fund= "HDFC Equity Fund - Growth Option||false";}
	 		if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount= "3000";}
	 		if(frequency == null || StringHelper.isEmpty(frequency)){frequency= "Monthly";}
	 		if(startDate == null || StringHelper.isEmpty(startDate) || !startDate.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){startDate= start_date_str;}
	 		if(endDate == null || StringHelper.isEmpty(endDate) || !endDate.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){endDate= end_date_str;}
	 		
	 		fund = fund.trim();
	 		amount = amount.trim();
	 		frequency = frequency.trim();
	 		startDate = startDate.trim();
	 		endDate = endDate.trim();
	 		
	 		fund = URLDecoder.decode(fund, "UTF-8");
	 		
    		String scheme_amfi_name = null;
            String parameters[] = null;
            //Boolean isOnlyAmountInvested = false;
			parameters = fund.split("[\\||]+");			
			
			scheme_amfi_name = parameters[0];
			//isOnlyAmountInvested = Boolean.parseBoolean(parameters[1]);	
			
			HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("scheme_name", scheme_amfi_name);
	 		hashMap.put("amount", amount);
	 		hashMap.put("frequency", frequency);
	 		hashMap.put("startDate",startDate);
	 		hashMap.put("endDate",endDate);
	 		
	 		String formattedUrl, result = "";
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSIPReturnsForFundOverview, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		
	 		//String result = mutualFundOverviewDAO.getSIPReturnsGraph(scheme_amfi_name, frequency, sip_amount, startDate, endDate);
    		if(StringHelper.isEmpty(result))
    		{
    			result = "null";
    		}
    		writer.print(result);
		    writer.close();
		} 
		catch (Exception ex) 
		{
		    writer.close();
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/getPortfolioAnalysis")
	public void getPortfolioAnalysis(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
    	PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		Gson gson = null;
		try 
		{	
			gson = new Gson();
			
    		String scheme_amfi = request.getParameter("scheme_amfi");  
    		PortfolioAnalysisResponse analysisResponse = new PortfolioAnalysisResponse();
    		
 			//SchemeAssets schemeAssets = mutualFundOverviewDAO.getSchemeAsset(scheme_amfi_code);
 			//analysisResponse.setSchemeAssets(schemeAssets);
    		
    		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("scheme_name", scheme_amfi);
	 		 		
	 		String formattedUrl, result = "";
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getPortfolioAnalysis, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	
	 		gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		SchemePortfolioAnalysisApiResponse mutualFundSchemeAPIResponse = gson.fromJson(result, SchemePortfolioAnalysisApiResponse.class); 		
	 		//SchemePortfolioAnalysisResponse schemePortfolioAnalysisResponse = mutualFundOverviewDAO.getPortfolioAnalysisReportForFundOverview(scheme_amfi_code);
	 		SchemePortfolioAnalysisResponse schemePortfolioAnalysisResponse = mutualFundSchemeAPIResponse.getSchemePortfolioAnalysisResponse();
	 		if(schemePortfolioAnalysisResponse.getSectorAllocationMap() != null)
	 			schemePortfolioAnalysisResponse.setSectorAllocationMap((HashMap<String, Double>) CommonUtils.sortByValuesDescending(schemePortfolioAnalysisResponse.getSectorAllocationMap()));
	 		analysisResponse.setSchemePortfolioAnalysisResponse(schemePortfolioAnalysisResponse);
	 		
    		
    		writer.print(gson.toJson(analysisResponse));
		    writer.close();
		    return;
		} 
		catch (Exception ex) 
		{
		    writer.close();
			ex.printStackTrace();
		}
	}

	@RequestMapping(value="/getLumpSumReturnsTable")
	public void getLumpSumReturnsAndSipReturnsTable(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
    	PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		
		try 
		{	
			String scheme_amfi_name = request.getParameter("scheme_amfi_name");
    		String lumpSumAmount = request.getParameter("amount");
    		String startDate = request.getParameter("startDate");
    		
    		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
			cal1.add(Calendar.YEAR, -1);
			cal1.add(Calendar.MONTH, 1);
			String start_date_str = sdf.format(cal1.getTime());
    		
    		if(scheme_amfi_name == null || StringHelper.isEmpty(scheme_amfi_name)){scheme_amfi_name= "HDFC Equity Fund - Growth Option";}
	 		if(lumpSumAmount == null || StringHelper.isEmpty(lumpSumAmount) || !lumpSumAmount.matches("[0-9]+")){lumpSumAmount= "3000";}
	 		if(startDate == null || StringHelper.isEmpty(startDate) || !startDate.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){startDate = start_date_str;}
	 		
	 		scheme_amfi_name = scheme_amfi_name.trim();
	 		lumpSumAmount = lumpSumAmount.trim();
	 		startDate = startDate.trim();
    		
    		scheme_amfi_name = scheme_amfi_name.replaceAll("&amp;", "&");
    		
    		HashMap<String, String> hashMap = new HashMap<String, String>();
    		String formattedUrl, result = "";
    		
            hashMap.put("scheme", scheme_amfi_name);
            hashMap.put("amount", lumpSumAmount);
            hashMap.put("start_date", startDate);
            
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLumpSumReturns, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		LumpsumReturnsAPIResponse list = new Gson().fromJson(result, LumpsumReturnsAPIResponse.class);
	 		
    		//SIPSchemePerformanceResponse result = mutualFundOverviewDAO.getLumpsumReturns(scheme_amfi_name,Double.parseDouble(lumpSumAmount),startDate);
    		writer.print(gson.toJson(list.getSipSchemePerformanceResponse()));
		    writer.close();
		} 
		catch (Exception ex) 
		{
		    writer.close();
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/getLumpSumReturnsForFundOverview")
	public void getLumpSumReturnsForFundOverview(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
    	PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		
		try 
		{	
			String scheme_amfi_name = request.getParameter("scheme_amfi_name");
    		String lumpSumAmount = request.getParameter("amount");
    		String startDate = request.getParameter("startDate");
    		
    		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
			cal1.add(Calendar.YEAR, -1);
			cal1.add(Calendar.MONTH, 1);
			String start_date_str = sdf.format(cal1.getTime());
    		
    		if(scheme_amfi_name == null || StringHelper.isEmpty(scheme_amfi_name)){scheme_amfi_name= "HDFC Equity Fund - Growth Option";}
	 		if(lumpSumAmount == null || StringHelper.isEmpty(lumpSumAmount) || !lumpSumAmount.matches("[0-9]+")){lumpSumAmount= "3000";}
	 		if(startDate == null || StringHelper.isEmpty(startDate) || !startDate.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){startDate = start_date_str;}
	 		
	 		scheme_amfi_name = scheme_amfi_name.trim();
	 		lumpSumAmount = lumpSumAmount.trim();
	 		startDate = startDate.trim();
    		
	 		scheme_amfi_name = URLDecoder.decode(scheme_amfi_name, "UTF-8");
    		
	 		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("scheme_name", scheme_amfi_name);
	 		hashMap.put("amount", lumpSumAmount);
	 		hashMap.put("startDate", startDate);
	 		
	 		String formattedUrl, result = "";
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getLumpSumReturnsForFundOverview, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		//String mutualFundSchemeAPIResponse = new Gson().fromJson(result, String.class); 		
	 		
    		//String result = mutualFundOverviewDAO.getLumpSumReturnsForFundOverview(scheme_amfi_name, Double.parseDouble(lumpSumAmount), startDate);
    		writer.print(result);
		    writer.close();
		    return;
		} 
		catch (Exception ex) 
		{
		    writer.close();
			ex.printStackTrace();
		}
	}

	@RequestMapping(value="/getRollingReturns")
	public void getRollingReturns(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		
		try 
		{
			String category = request.getParameter("category");
			String schemes = request.getParameter("schemes");
			String start_date = request.getParameter("start_date");
			String period = request.getParameter("period");
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Calendar cal1 = Calendar.getInstance();
            cal1.add(Calendar.DATE, -1);
			cal1.add(Calendar.YEAR, -5);
			cal1.add(Calendar.MONTH, 1);
			String start_date_str = sdf.format(cal1.getTime());
			
			if(category == null || StringHelper.isEmpty(category)){category="Equity: Multi Cap";}
			if(schemes == null || StringHelper.isEmpty(schemes)){schemes="Aditya Birla Sun Life Equity Fund - Growth - Regular Plan";}
			if(start_date == null || StringHelper.isEmpty(start_date) || !start_date.matches("([0-9]{2})-([0-9]{2})-([0-9]{4})")){start_date=start_date_str;}
			if(period == null || StringHelper.isEmpty(period)){period="3 Year";}
			
			category = category.trim();
			schemes = schemes.trim();
			start_date = start_date.trim();
			period = period.trim();
			
			schemes = URLDecoder.decode(schemes, "UTF-8");
			
            String formattedUrl, result = "";
	     	
	     	HashMap<String, String> hashMap = new HashMap<String, String>();
            hashMap.put("category", category);
            hashMap.put("schemes", schemes);
            hashMap.put("isin", "");
            hashMap.put("start_date", start_date);
            hashMap.put("period", period + " Year");
	     	
            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getRollingReturnsMultipleSchemes, hashMap);
            System.out.println("FormatURl->"+formattedUrl);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		
	 		System.out.println("Rolling Returns"+ result);
	 		
	 		gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		RollingReturnsMultipleSchemesAPIResponse list = gson.fromJson(result, RollingReturnsMultipleSchemesAPIResponse.class);
			List<List<SchemeRollingReturns>> rollingReturnsList = list.getList();
			
			gson = new Gson();
			writer.print(gson.toJson(rollingReturnsList));
		    writer.close();
		    return;
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}

	@RequestMapping(value="/getCompleteNavReportForFundOverview")
	public void getCompleteNavReportForFundOverview(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
    	PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		
		try 
		{	
			String scheme_amfi_name = request.getParameter("scheme_amfi_name");   		
    		scheme_amfi_name = URLDecoder.decode(scheme_amfi_name, "UTF-8");
    		
    		//getNavMovementGraph
    		
    		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("scheme_amfi_name",scheme_amfi_name);
	 		
	 		String formattedUrl, result = "";
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getNavMovementGraph, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		CommonResponse commonAPIResponse = new Gson().fromJson(result, CommonResponse.class); 		
	 		
    		//String result = mutualFundOverviewDAO.getCompleteNavReportForFundOverview(scheme_amfi_name);
    		writer.print(commonAPIResponse.getMsg());
		    writer.close();
		    return;
		} 
		catch (Exception ex) 
		{
		    writer.close();
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/isValidFundName", method= RequestMethod.POST)
	public void isValidFundName(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
    	PrintWriter writer = response.getWriter();
		response.setContentType("text/Html");
		Gson gson = new Gson();
        String fund = null;
		try 
		{
            fund = request.getParameter("fund");
            if(fund == null || StringHelper.isEmpty(fund))
            {
        		writer.print(gson.toJson(false));
    		    writer.close();
    		    return;
            }
            fund = fund.trim();
            fund = URLDecoder.decode(fund, "UTF-8");
            
	 		String formattedUrl, result = "";
	 		
	 		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("scheme", fund);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.isValidFundName, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);	 		
	 		ApiCommonResponse apiCommonResponse = new Gson().fromJson(result, ApiCommonResponse.class); 
	 		boolean value = apiCommonResponse.isValidScheme();
            
    		writer.print(gson.toJson(value));
		    writer.close();
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}	
}
