package com.dakshin.controller;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFCreationHelper;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPalette;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.dhatim.fastexcel.Workbook;
import org.dhatim.fastexcel.Worksheet;
import org.hibernate.internal.util.StringHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dakshin.amfi.dao.AmfiApiAccessRepository;
import com.dakshin.amfi.model.DividendAnnualizedReturns;
import com.dakshin.amfi.model.SchemePerformances;
import com.dakshin.amfi.model.SchemePerformancesBenchmark;
import com.dakshin.amfi.model.SchemePerformancesCategory;
import com.dakshin.amfi.model.SchemePerformancesSip;
import com.dakshin.amfi.model.Top10FundsByCategory;
import com.dakshin.amfi.response.ApiCommonResponse;
import com.dakshin.amfi.response.FDvsDebtResponse;
import com.dakshin.amfi.response.FdVsDebtAPIResponse;
import com.dakshin.amfi.response.LiquidFundsVsSavingsBankResponse;
import com.dakshin.amfi.response.MutualFundAPIResponse;
import com.dakshin.amfi.response.MutualFundSIPReturnsAPIResponse;
import com.dakshin.amfi.response.MutualFundSchemeAPIResponse;
import com.dakshin.amfi.response.PPFvsELSSAPIResponse;
import com.dakshin.amfi.response.PointToPointResponse;
import com.dakshin.amfi.response.PointToPointReturnsCalculatorAPIResponse;
import com.dakshin.amfi.response.SIPCalcFinalResponse;
import com.dakshin.amfi.response.SIPCalcResponse;
import com.dakshin.amfi.response.SIPReturnsCalculatorAPIAnnualIncreaseResponse;
import com.dakshin.amfi.response.SIPReturnsCalculatorAPIResponse;
import com.dakshin.amfi.response.SIPSchemePerformanceResponse;
import com.dakshin.amfi.response.STPCalcResponse;
import com.dakshin.amfi.response.STPReturnsCalculatorAPIResponse;
import com.dakshin.amfi.response.SWPReturnsCalculatorAPIResponse;
import com.dakshin.amfi.response.SipYearlyEnhancementResponse;
import com.dakshin.amfi.response.TopDividendPayingMutualFundsApiResponse;
import com.dakshin.amfi.response.TopSWPFundsResponse;
import com.dakshin.amfi.response.TopSwpFundsApiResponse;
import com.dakshin.dao.CommonDao;
import com.dakshin.model.LogDownload;
import com.dakshin.utils.HttpPost;
import com.dakshin.utils.MfApiAccessor;
import com.dakshin.utils.MfApiUrls;
import com.dakshin.utils.UniqueIDProvider;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings({"deprecation","static-access" , "rawtypes"})
@Controller
@Scope("")
@RequestMapping("/mutual-funds-research")
public class DownloadMFExcelController 
{
	
	@Autowired
	AmfiApiAccessRepository amfiApiAccessRepository;
	
	@Autowired
	private Environment env;
	
	@Autowired
	private CommonDao commonDao;
	
	@RequestMapping(value="/downloadTopPerformingFundsXl")
	public void downloadTopPerformingFundsXl(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{		 
		HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
		if(accountMap != null)
	    {
			
			/*List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =  logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
			if(advisorkhojDownloadLogsList.size() > 10)
			{
				ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
				apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
				apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.FailureMessage);
				apiCommonResponse.setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day.");
				
				Gson gson = new Gson();
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				out.print(gson.toJson(apiCommonResponse));
				out.flush();
				return;
			}*/
			
	 		String category =  request.getParameter("category");
	 		String period = request.getParameter("period");
	 		String type = request.getParameter("type");
	 		String mode = request.getParameter("mode");
	 		String download = request.getParameter("download");
	 		String category_name = category;
	 		
	 		if(category == null){category= "Equity: Multi Cap";}
	 		if(category_name == null){category_name= "";}
	 		if(period == null){period= "1y";}
	 		if(type == null){type= "Open";}
	 		if(mode == null){mode= "Growth";}
	 		if(download == null){download= "";}
	 		
	 		category = category.trim();
	 		category_name = category_name.trim();
	 		period = period.trim();
	 		type = type.trim();
	 		mode = mode.trim();
	 		download = download.trim();

	 		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("period", period);
	 		hashMap.put("category", category);
	 		hashMap.put("type", type);
	 		hashMap.put("maxno","1000");
	 		hashMap.put("mode",mode);
	 		
	 		if(download.equalsIgnoreCase("yes"))
		 	{
		 
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
		 		
		 		response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", "attachment;filename=Top-Performing-Mutual-Funds-Trailing-returns.xlsx");
				
				
				Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
				Worksheet ws = wb.newWorksheet("Top Performing Mutual Funds (Trailing returns) Report");
				
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
										
				ws.width(0, 30);
				ws.width(1, 7);
				ws.width(2, 7);
				ws.width(3, 7);
				ws.width(4, 7);
				ws.width(5, 7);
				ws.width(6, 7);
				ws.width(7, 7);
				ws.width(8, 7);
				ws.width(9, 7);
				ws.width(10, 7);
				ws.width(11, 7);
				
						   
				ws.value(0, 0, "Top Performing Mutual Funds (Trailing returns)");
				ws.range(0, 0, 0, 8).merge();
				ws.range(0, 0, 0, 8).style().horizontalAlignment("center").set();
				ws.style(0, 0).bold().fontSize(11).set(); 
			
				ws.value(1, 0, "Data as on - " + apiCommonResponse.getNav_date());
				ws.range(1, 0, 1, 8).merge();
				ws.style(1, 0).bold().fontSize(9).set();
				
									
				if(period.equalsIgnoreCase("1y") || period.equalsIgnoreCase("3y") || period.equalsIgnoreCase("5y") || period.equalsIgnoreCase("10y") || period.equalsIgnoreCase("Since Inception")){
					
					ws.value(2, 0, "");
					ws.range(2, 0, 2, 2).style().bold().fontSize(9).horizontalAlignment("center").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").merge().set();
					
					ws.value(2, 3, "1 Year");
					ws.range(2, 3, 2, 4).style().bold().fontSize(9).horizontalAlignment("center").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").merge().set();
					
					ws.value(2, 5, "3 Years");
					ws.range(2, 5, 2, 6).style().bold().fontSize(9).horizontalAlignment("center").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").merge().set();
					
					ws.value(2, 7, "5 Years");
					ws.range(2, 7, 2, 8).style().bold().fontSize(9).horizontalAlignment("center").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").merge().set();
					
					ws.value(2, 9, "10 Years");
					ws.range(2, 9, 2, 11).style().bold().fontSize(9).horizontalAlignment("center").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").merge().set();
				}
				
				if(period.equalsIgnoreCase("1w") || period.equalsIgnoreCase("1m") || period.equalsIgnoreCase("3m") || period.equalsIgnoreCase("6m") || period.equalsIgnoreCase("ytd")){
					
					ws.value(2, 0, "");
					ws.range(2, 0, 2, 2).style().bold().fontSize(9).horizontalAlignment("center").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").merge().set();
					
					ws.value(2, 3, "1 Week");
					ws.range(2, 3, 2, 4).style().bold().fontSize(9).horizontalAlignment("center").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").merge().set();
					
					ws.value(2, 5, "1 Month");
					ws.range(2, 5, 2, 6).style().bold().fontSize(9).horizontalAlignment("center").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").merge().set();
					
					ws.value(2, 7, "3 Months");
					ws.range(2, 7, 2, 8).style().bold().fontSize(9).horizontalAlignment("center").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").merge().set();
					
					ws.value(2, 9, "6 Months");
					ws.range(2, 9, 2, 11).style().bold().fontSize(9).horizontalAlignment("center").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").merge().set();
				}
				
				
				int i = 3;
				int j = 0;
				for(j = 0; j <= 11; j++) {
					ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
				}
							
				int k = 0;
				
				ws.value(i, k++, "Scheme Name");
				if(category.equalsIgnoreCase("All Equity") || category.equalsIgnoreCase("All Debt") || category.equalsIgnoreCase("All Hybrid") || category.equalsIgnoreCase("Exchange Traded Funds"))
				{
					ws.value(i, k++, "Category");
				}	
			    ws.value(i, k++, "AUM (Crore)");
			    if(category.equalsIgnoreCase("All Equity") || category.equalsIgnoreCase("All Debt") || category.equalsIgnoreCase("All Hybrid") || category.equalsIgnoreCase("Exchange Traded Funds"))
			    {
			    	
			    }
			    else
			    {
			    	ws.value(i, k++, "Expense Ratio (%)");
			    }
			    		    
			    if(period.equalsIgnoreCase("1w") || period.equalsIgnoreCase("1m") || period.equalsIgnoreCase("3m") || period.equalsIgnoreCase("6m") || period.equalsIgnoreCase("ytd"))
			    {
			    	ws.value(i, k++, "Returns (%)");
			    	ws.value(i, k++, "Rank");
				    ws.value(i, k++, "Returns (%)");
				    ws.value(i, k++, "Rank");
				    ws.value(i, k++, "Returns (%)");
				    ws.value(i, k++, "Rank");
				    ws.value(i, k++, "Returns (%)");
				    ws.value(i, k++, "Rank");
				    ws.value(i++, k++, "YTD Ret (%)");
			    }	
			    if(period.equalsIgnoreCase("1y") || period.equalsIgnoreCase("3y") || period.equalsIgnoreCase("5y") || period.equalsIgnoreCase("10y") || period.equalsIgnoreCase("Since Inception"))
			    {
			    	ws.value(i, k++, "Returns (%)");
			    	ws.value(i, k++, "Rank");
				    ws.value(i, k++, "Returns (%)");
				    ws.value(i, k++, "Rank");
				    ws.value(i, k++, "Returns (%)");
				    ws.value(i, k++, "Rank");
				    ws.value(i, k++, "Returns (%)");
				    ws.value(i, k++, "Rank");
				    ws.value(i++, k++, "Since Launch Ret (%)");
			    }	
	
				for(SchemePerformances schemePerformances: mutualFundSchemeAPIResponse.getList())
				{
					k = 0;
					ws.value(i, k, schemePerformances.getScheme_amfi());
					ws.style(i, k++).fontSize(9).wrapText(true).set();
					
					if(category.equalsIgnoreCase("All Equity") || category.equalsIgnoreCase("All Debt") || category.equalsIgnoreCase("All Hybrid") || category.equalsIgnoreCase("Exchange Traded Funds"))
					{
						ws.value(i, k, schemePerformances.getScheme_category());
						ws.style(i, k++).fontSize(9).set();
					}
					
					ws.value(i, k, Double.parseDouble(String.valueOf(schemePerformances.getScheme_assets()/10)));
					ws.style(i, k++).fontSize(9).set();
					
					if(category.equalsIgnoreCase("All Equity") || category.equalsIgnoreCase("All Debt") || category.equalsIgnoreCase("All Hybrid") || category.equalsIgnoreCase("Exchange Traded Funds"))
				    {
				    	
				    }
				    else
				    {
				    	ws.value(i, k, schemePerformances.getTer());
						ws.style(i, k++).wrapText(true).fontSize(9).set();
				    }
					
					if(period.equalsIgnoreCase("1w") || period.equalsIgnoreCase("1m") || period.equalsIgnoreCase("3m") || period.equalsIgnoreCase("6m") || period.equalsIgnoreCase("ytd"))
				    {
						
						if(schemePerformances.getReturns_abs_7days() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_7days());
							ws.style(i, k++).fontSize(9).set();
						}
						
						if(schemePerformances.getReturns_abs_7days_rank() == null || schemePerformances.getReturns_abs_7days_rank() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_7days_rank()+"/"+schemePerformances.getReturns_abs_7days_totalrank());
							ws.style(i, k++).fontSize(9).horizontalAlignment("right").set();
						}
						
						if(schemePerformances.getReturns_abs_1month() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_1month());
							ws.style(i, k++).fontSize(9).set();
						}
						
						if(schemePerformances.getReturns_abs_6month_rank() == null || schemePerformances.getReturns_abs_1month_rank() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_1month_rank()+"/"+schemePerformances.getReturns_abs_1month_totalrank());
							ws.style(i, k++).fontSize(9).horizontalAlignment("right").set();
						}
						
						if(schemePerformances.getReturns_abs_3month() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_3month());
							ws.style(i, k++).fontSize(9).set();
						}
						
						if(schemePerformances.getReturns_abs_3month_rank() == null || schemePerformances.getReturns_abs_3month_rank() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_3month_rank()+"/"+schemePerformances.getReturns_abs_3month_totalrank());
							ws.style(i, k++).fontSize(9).horizontalAlignment("right").set();
						}
						
						if(schemePerformances.getReturns_abs_6month() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_6month());
							ws.style(i, k++).fontSize(9).set();
						}
						
						if(schemePerformances.getReturns_abs_6month_rank() == null || schemePerformances.getReturns_abs_6month_rank() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_6month_rank()+"/"+schemePerformances.getReturns_abs_6month_totalrank());
							ws.style(i, k++).fontSize(9).horizontalAlignment("right").set();
						}
						
						if(schemePerformances.getReturns_abs_ytd() == 0){
							ws.value(i, k, "-");
							ws.style(i++, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_ytd());
							ws.style(i++, k++).fontSize(9).set();
						}
				    }
					
					if(period.equalsIgnoreCase("1y") || period.equalsIgnoreCase("3y") || period.equalsIgnoreCase("5y") || period.equalsIgnoreCase("10y") || period.equalsIgnoreCase("Since Inception"))
				    {
						
						if(schemePerformances.getReturns_abs_1year() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_1year());
							ws.style(i, k++).fontSize(9).set();
						}
						
						if(schemePerformances.getReturns_abs_1year_rank() == null || schemePerformances.getReturns_abs_1year_rank() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_abs_1year_rank()+"/"+schemePerformances.getReturns_abs_1year_totalrank());
							ws.style(i, k++).fontSize(9).horizontalAlignment("right").set();
						}
						
						if(schemePerformances.getReturns_cmp_3year() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_cmp_3year());
							ws.style(i, k++).fontSize(9).set();
						}
	
						if(schemePerformances.getReturns_cmp_3year_rank() == null || schemePerformances.getReturns_cmp_3year_rank() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_cmp_3year_rank()+"/"+schemePerformances.getReturns_cmp_3year_totalrank());
							ws.style(i, k++).fontSize(9).horizontalAlignment("right").set();
						}
						
						if(schemePerformances.getReturns_cmp_5year() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_cmp_5year());
							ws.style(i, k++).fontSize(9).set();
						}
						
						if(schemePerformances.getReturns_cmp_5year_rank() == null || schemePerformances.getReturns_cmp_5year_rank() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_cmp_5year_rank()+"/"+schemePerformances.getReturns_cmp_5year_totalrank());
							ws.style(i, k++).fontSize(9).horizontalAlignment("right").set();
						}
						
						if(schemePerformances.getReturns_cmp_10year() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_cmp_10year());
							ws.style(i, k++).fontSize(9).set();
						}
						
						if(schemePerformances.getReturns_cmp_10year_rank() == null || schemePerformances.getReturns_cmp_10year_rank() == 0){
							ws.value(i, k, "-");
							ws.style(i, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_cmp_10year_rank()+"/"+schemePerformances.getReturns_cmp_10year_totalrank());
							ws.style(i, k++).fontSize(9).horizontalAlignment("right").set();
						}
						
						if(schemePerformances.getReturns_cmp_inception() == 0){
							ws.value(i, k, "-");
							ws.style(i++, k++).fontSize(9).set();
						}
						else{
							ws.value(i, k, schemePerformances.getReturns_cmp_inception());
							ws.style(i++, k++).fontSize(9).set();
						}
	
				    }
				}
				
				SchemePerformancesCategory category_returns = mutualFundSchemeAPIResponse.getCategory_returns();
				SchemePerformancesBenchmark benchmark_returns = mutualFundSchemeAPIResponse.getBenchmark_returns();
				
				if(category_returns != null)
				{								
					ws.value(i, 0, "Category Average");
					ws.style(i, 0).fontSize(9).bold().set();
					ws.value(i, 1, "-");
					ws.style(i, 1).fontSize(9).bold().set();
					ws.value(i, 2, "-");
					ws.style(i, 2).fontSize(9).bold().set();
					
					if(period.equalsIgnoreCase("1w") || period.equalsIgnoreCase("1m") || period.equalsIgnoreCase("3m") || period.equalsIgnoreCase("6m") || period.equalsIgnoreCase("ytd"))
				    {
						if(category_returns.getReturns_abs_7days() == 0){
							ws.value(i, 3, "-");
							ws.style(i, 3).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 3, category_returns.getReturns_abs_7days());
							ws.style(i, 3).bold().fontSize(9).set();
						}
						
						ws.value(i, 4, "-");
						ws.style(i, 4).bold().fontSize(9).set();
						
						if(category_returns.getReturns_abs_1month() == 0){
							ws.value(i, 5, "-");
							ws.style(i, 5).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 5, category_returns.getReturns_abs_1month());
							ws.style(i, 5).bold().fontSize(9).set();
						}
						
						ws.value(i, 6, "-");
						ws.style(i, 6).bold().fontSize(9).set();
						
						if(category_returns.getReturns_abs_3month() == 0){
							ws.value(i, 7, "-");
							ws.style(i, 7).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 7, category_returns.getReturns_abs_3month());
							ws.style(i, 7).bold().fontSize(9).set();
						}
						
						ws.value(i, 8, "-");
						ws.style(i, 8).bold().fontSize(9).set();
						
						if(category_returns.getReturns_abs_6month() == 0){
							ws.value(i, 9, "-");
							ws.style(i, 9).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 9, category_returns.getReturns_abs_6month());
							ws.style(i, 9).bold().fontSize(9).set();
						}
						
						ws.value(i, 10, "-");
						ws.style(i, 10).bold().fontSize(9).set();
						
						
						if(category_returns.getReturns_abs_ytd() == 0){
							ws.value(i, 11, "-");
							ws.style(i++, 11).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 11, category_returns.getReturns_abs_ytd());
							ws.style(i++, 11).bold().fontSize(9).set();
						}
				    }
					
					if(period.equalsIgnoreCase("1y") || period.equalsIgnoreCase("3y") || period.equalsIgnoreCase("5y") || period.equalsIgnoreCase("10y") || period.equalsIgnoreCase("Since Inception"))
				    {
						if(category_returns.getReturns_abs_1year() == 0){
							ws.value(i, 3, "-");
							ws.style(i, 3).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 3, category_returns.getReturns_abs_1year());
							ws.style(i, 3).bold().fontSize(9).set();
						}
						
						ws.value(i, 4, "-");
						ws.style(i, 4).bold().fontSize(9).set();
						
						if(category_returns.getReturns_cmp_3year() == 0){
							ws.value(i, 5, "-");
							ws.style(i, 5).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 5, category_returns.getReturns_cmp_3year());
							ws.style(i, 5).bold().fontSize(9).set();
						}
						
						ws.value(i, 6, "-");
						ws.style(i, 6).bold().fontSize(9).set();
						
						if(category_returns.getReturns_cmp_5year() == 0){
							ws.value(i, 7, "-");
							ws.style(i, 7).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 7, category_returns.getReturns_cmp_5year());
							ws.style(i, 7).bold().fontSize(9).set();
						}
						
						ws.value(i, 8, "-");
						ws.style(i, 8).bold().fontSize(9).set();
						
						if(category_returns.getReturns_cmp_10year() == 0){
							ws.value(i, 9, "-");
							ws.style(i, 9).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 9, category_returns.getReturns_cmp_10year());
							ws.style(i, 9).bold().fontSize(9).set();
						}
						
						ws.value(i, 10, "-");
						ws.style(i, 10).bold().fontSize(9).set();
						
						if(category_returns.getReturns_cmp_inception() == 0){
							ws.value(i, 11, "-");
							ws.style(i++, 1).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 11, category_returns.getReturns_cmp_inception());
							ws.style(i++, 11).bold().fontSize(9).set();
						}
	
				    }
					
				}
			
				if(benchmark_returns != null)
				{
					ws.value(i, 0, benchmark_returns.getBenchmark_name());
					ws.style(i, 0).bold().fontSize(9).set();
					ws.value(i, 1, "-");
					ws.style(i, 1).bold().fontSize(9).set();
					ws.value(i, 2, "-");
					ws.style(i, 2).bold().fontSize(9).set();
					
					if(period.equalsIgnoreCase("1w") || period.equalsIgnoreCase("1m") || period.equalsIgnoreCase("3m") || period.equalsIgnoreCase("6m") || period.equalsIgnoreCase("ytd"))
				    {
						
						if(benchmark_returns.getReturns_abs_7days() == 0){
							ws.value(i, 3, "-");
							ws.style(i, 3).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 3, benchmark_returns.getReturns_abs_7days());
							ws.style(i, 3).bold().fontSize(9).set();
						}
						
						ws.value(i, 4, "-");
						ws.style(i, 4).bold().fontSize(9).set();
						
						if(benchmark_returns.getReturns_abs_1month() == 0){
							ws.value(i, 5, "-");
							ws.style(i, 5).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 5, benchmark_returns.getReturns_abs_1month());
							ws.style(i, 5).bold().fontSize(9).set();
						}
						
						ws.value(i, 6, "-");
						ws.style(i, 6).bold().fontSize(9).set();
						
						if(benchmark_returns.getReturns_abs_3month() == 0){
							ws.value(i, 7, "-");
							ws.style(i, 7).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 7, benchmark_returns.getReturns_abs_3month());
							ws.style(i, 7).bold().fontSize(9).set();
						}
						
						ws.value(i, 8, "-");
						ws.style(i, 8).bold().fontSize(9).set();
						
						if(benchmark_returns.getReturns_abs_6month() == 0){
							ws.value(i, 9, "-");
							ws.style(i, 9).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 9, benchmark_returns.getReturns_abs_6month());
							ws.style(i, 9).bold().fontSize(9).set();
						}
						
						ws.value(i, 10, "-");
						ws.style(i, 10).bold().fontSize(9).set();
						
						if(benchmark_returns.getReturns_abs_ytd() == 0){
							ws.value(i, 11, "-");
							ws.style(i++, 11).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 11, benchmark_returns.getReturns_abs_ytd());
							ws.style(i++, 11).bold().fontSize(9).set();
						}
				    }
					
					if(period.equalsIgnoreCase("1y") || period.equalsIgnoreCase("3y") || period.equalsIgnoreCase("5y") || period.equalsIgnoreCase("10y") || period.equalsIgnoreCase("Since Inception"))
				    {
						if(benchmark_returns.getReturns_abs_1year() == 0){
							ws.value(i, 3, "-");
							ws.style(i, 3).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 3, benchmark_returns.getReturns_abs_1year());
							ws.style(i, 3).bold().fontSize(9).set();
						}
						
						ws.value(i, 4, "-");
						ws.style(i, 4).bold().fontSize(9).set();
						
						if(benchmark_returns.getReturns_cmp_3year() == 0){
							ws.value(i, 5, "-");
							ws.style(i, 5).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 5, benchmark_returns.getReturns_cmp_3year());
							ws.style(i, 5).bold().fontSize(9).set();
						}
						
						ws.value(i, 6, "-");
						ws.style(i, 6).bold().fontSize(9).set();
						
						if(benchmark_returns.getReturns_cmp_5year() == 0){
							ws.value(i, 7, "-");
							ws.style(i, 7).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 7, benchmark_returns.getReturns_cmp_5year());
							ws.style(i, 7).bold().fontSize(9).set();
						}
						
						ws.value(i, 8, "-");
						ws.style(i, 8).bold().fontSize(9).set();
						
						if(benchmark_returns.getReturns_cmp_10year() == 0){
							ws.value(i, 9, "-");
							ws.style(i, 9).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 9, benchmark_returns.getReturns_cmp_10year());
							ws.style(i, 9).bold().fontSize(9).set();
						}
						
						ws.value(i, 10, "-");
						ws.style(i, 10).bold().fontSize(9).set();
						
						if(benchmark_returns.getReturns_cmp_inception() == 0){
							ws.value(i, 11, "-");
							ws.style(i++, 11).bold().fontSize(9).set();
						}
						else{
							ws.value(i, 11, benchmark_returns.getReturns_cmp_inception());
							ws.style(i++, 11).bold().fontSize(9).set();
						}
				    }
				}
	
					String requestURL = "/mutual-funds-research/downloadTopPerformingFundsXl?category="+category+"&period="+period+"&type="+type+"&mode="+mode;
					LogDownload logDownload = new LogDownload();
					logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
					logDownload.setEmail(accountMap.get("email"));
					logDownload.setTitle("Top Performing Mutual Funds (Trailing returns)");
					logDownload.setRequest(requestURL);
					logDownload.setCreate_date(new Date());
					logDownload.setClient_name("dakshin");
					commonDao.saveDownloadLog(logDownload);
	
					wb.finish();
		 	}
	 		else
	 		{
	 			PrintWriter out = response.getWriter();
				response.setContentType("application/vnd.ms-excel");
				response.setCharacterEncoding("UTF-8");
	 		}
	    }
		/*else
		{
			ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
			apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.FailureMessage);
			apiCommonResponse.setMsg("Access Denied");
			
			Gson gson = new Gson();
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			out.print(gson.toJson(apiCommonResponse));
			out.flush();
		}*/
	}
	
	
	@RequestMapping(value="/downloadMutualFundsPerformanceComparisonXl")
	public void downloadMutualFundsPerformanceComparisonXl(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		
		HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
		if(accountMap != null)
		{
			
			/*
			 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
			 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
			 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
			 * apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.
			 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
			 * );
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
			 */
		
			String fund = request.getParameter("fund");
			String category = request.getParameter("category");
			String download = request.getParameter("download");
			
			if(fund == null || StringHelper.isEmpty(fund)){fund= "ICICI Prudential Value Discovery Fund - Growth";}
			if(category == null || StringHelper.isEmpty(category)){category= "Equity: Value";}
			if(download == null){download= "";}
			
			fund = fund.trim();
			category = category.trim();
			download = download.trim();
			String formattedUrl , result = "";
			MutualFundAPIResponse mfapiResponse = null;
			
			if(download.equalsIgnoreCase("yes"))
			{
			
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
		 		
		 		
		 		response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", "attachment;filename=Mutual-Funds-Performance-Comparison.xlsx");
				
				
				Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
				Worksheet ws = wb.newWorksheet("Mutual Funds Performance Comparison Report");
				
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
										
				ws.width(0, 30);
				ws.width(1, 12);
				ws.width(2, 12);
				ws.width(3, 12);
				ws.width(4, 12);
				ws.width(5, 12);
		
				ws.value(0, 0, "Mutual Funds Performance Comparison");
				ws.range(0, 0, 0, 6).merge();
				ws.range(0, 0, 0, 6).style().horizontalAlignment("center").set();
				ws.style(0, 0).bold().fontSize(11).set(); 
			
				ws.value(1, 0, "Data as on - " + apiCommonResponse.getNav_date());
				ws.range(1, 0, 1, 6).merge();
				ws.style(1, 0).bold().fontSize(9).set();
				
				ws.value(2, 0, "");
				ws.range(2, 0, 2, 6).merge();
				ws.range(2, 0, 2, 6).style().horizontalAlignment("left").set();
				ws.style(2, 0).bold().fontSize(11).set(); 
				
				ws.value(3, 0, "Summary");
				ws.range(3, 0, 3, 6).merge();
				ws.range(3, 0, 3, 6).style().horizontalAlignment("left").set();
				ws.style(3, 0).bold().fontSize(11).set(); 
									
				int i = 4;
				int j = 0;
				for(j = 0; j <= 4; j++) {
					ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
				}
				
				ws.value(i, 0, "Fund Name");
		        ws.value(i, 1, "Category");
			    ws.value(i, 2, "Launch Date");
			    ws.value(i, 3, "AUM (Crore)");
			    ws.value(i++, 4, "Expense Ratio (%)");
		
		 		for(SchemePerformances schemePerformances : mutualFundSchemeAPIResponse.getList())
		 		{
		 			ws.value(i, 0, schemePerformances.getScheme_amfi());
					ws.style(i, 0).fontSize(9).wrapText(true).set();
					
					ws.value(i, 1, schemePerformances.getScheme_category());
					ws.style(i, 1).fontSize(9).set();
					
					ws.value(i, 2, sdf.format(schemePerformances.getInception_date()));
					ws.style(i, 2).fontSize(9).set();
					
					ws.value(i, 3, Double.parseDouble(String.valueOf(schemePerformances.getScheme_assets()/10)));
					ws.style(i, 3).fontSize(9).set();
					
					ws.value(i, 4, schemePerformances.getTer());
					ws.style(i++, 4).fontSize(9).set();
		 		}
		 		
		 		ws.value(i, 0, "");
				ws.range(i, 0, i, 6).merge();
				ws.range(i, 0, i, 6).style().horizontalAlignment("left").set();
				ws.style(i++, 0).bold().fontSize(11).set(); 
		 		
		 		ws.value(i, 0, "Performance Comparison");
				ws.range(i, 0, i, 6).merge();
				ws.range(i, 0, i, 6).style().horizontalAlignment("left").set();
				ws.style(i++, 0).bold().fontSize(11).set();
				
				for(j = 0; j <= 5; j++) {
					ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				}
				
				ws.value(i, 0, "Fund Name");
		        ws.value(i, 1, "1-Year Ret (%)");
			    ws.value(i, 2, "3-Yrs Ret (%)");
			    ws.value(i, 3, "5-Yrs Ret (%)");
			    ws.value(i, 4, "10-Yrs Ret (%)");
			    ws.value(i++, 5, "Since Launch Ret (%)");
			    
			    for(SchemePerformances schemePerformances : mutualFundSchemeAPIResponse.getList())
		 		{
		 			ws.value(i, 0, schemePerformances.getScheme_amfi());
					ws.style(i, 0).fontSize(9).wrapText(true).set();
					
					if(schemePerformances.getReturns_abs_1year() == 0)
					{
						ws.value(i, 1, schemePerformances.getReturns_abs_1year());
						ws.style(i, 1).fontSize(9).set();
					}	
					else
					{
						ws.value(i, 1, schemePerformances.getReturns_abs_1year());
						ws.style(i, 1).fontSize(9).set();
					}
					
					if(schemePerformances.getReturns_cmp_3year() == 0)
					{
						ws.value(i, 2, schemePerformances.getReturns_cmp_3year());
						ws.style(i, 2).fontSize(9).set();
					}	
					else
					{
						ws.value(i, 2, schemePerformances.getReturns_cmp_3year());
						ws.style(i, 2).fontSize(9).set();
					}
					
					if(schemePerformances.getReturns_cmp_5year() == 0)
					{
						ws.value(i, 3, schemePerformances.getReturns_cmp_5year());
						ws.style(i, 3).fontSize(9).set();
					}	
					else
					{
						ws.value(i, 3, schemePerformances.getReturns_cmp_5year());
						ws.style(i, 3).fontSize(9).set();
					}
					
					if(schemePerformances.getReturns_cmp_10year() == 0)
					{
						ws.value(i, 4, schemePerformances.getReturns_cmp_10year());
						ws.style(i, 4).fontSize(9).set();
					}	
					else
					{
						ws.value(i, 4, schemePerformances.getReturns_cmp_10year());
						ws.style(i, 4).fontSize(9).set();
					}
					
					if(schemePerformances.getReturns_cmp_inception() == 0)
					{
						ws.value(i, 5, schemePerformances.getReturns_cmp_inception());
						ws.style(i++, 5).fontSize(9).set();
					}	
					else
					{
						ws.value(i, 5, schemePerformances.getReturns_cmp_inception());
						ws.style(i++, 5).fontSize(9).set();
					}
		 		}
			    
			    SchemePerformancesCategory category_returns = mutualFundSchemeAPIResponse.getCategory_returns();
			    SchemePerformancesBenchmark benchmark_returns = mutualFundSchemeAPIResponse.getBenchmark_returns();
				
				if(category_returns != null)
				{
					ws.value(i, 0, "Category Average");
					ws.style(i, 0).bold().fontSize(9).set();
					
					if(category_returns.getReturns_abs_1year() == 0)
					{
						ws.value(i, 1, "-");
						ws.style(i, 1).bold().fontSize(9).set();
					}	
					else
					{
						ws.value(i, 1, category_returns.getReturns_abs_1year());
						ws.style(i, 1).bold().fontSize(9).set();
					}	
					
					if(category_returns.getReturns_cmp_3year() == 0)
					{
						ws.value(i, 2, "-");
						ws.style(i, 2).bold().fontSize(9).set();
					}	
					else
					{
						ws.value(i, 2, category_returns.getReturns_cmp_3year());
						ws.style(i, 2).bold().fontSize(9).set();
					}
					
					if(category_returns.getReturns_cmp_5year() == 0)
					{
						ws.value(i, 3, "-");
						ws.style(i, 3).bold().fontSize(9).set();
					}	
					else
					{
						ws.value(i, 3, category_returns.getReturns_cmp_5year());
						ws.style(i, 3).bold().fontSize(9).set();
					}
					
					if(category_returns.getReturns_cmp_10year() == 0)
					{
						ws.value(i, 4, "-");
						ws.style(i, 4).bold().fontSize(9).set();
					}	
					else
					{
						ws.value(i, 4, category_returns.getReturns_cmp_10year());
						ws.style(i, 4).bold().fontSize(9).set();
					}
					
					if(category_returns.getReturns_cmp_inception() == 0)
					{
						ws.value(i, 5, "-");
						ws.style(i++, 5).bold().fontSize(9).set();
					}	
					else
					{
						ws.value(i, 5, category_returns.getReturns_cmp_inception());
						ws.style(i++, 5).bold().fontSize(9).set();
					}
					
					ws.value(i, 0, benchmark_returns.getBenchmark_name());
					ws.style(i, 0).bold().fontSize(9).set();
								
					
					if(benchmark_returns.getReturns_abs_1year() == 0){
						ws.value(i, 1, "-");
						ws.style(i, 1).bold().fontSize(9).set();
					}
					else{
						ws.value(i, 1, benchmark_returns.getReturns_abs_1year());
						ws.style(i, 1).bold().fontSize(9).set();
					}
					
					if(benchmark_returns.getReturns_cmp_3year() == 0){
						ws.value(i, 2, "-");
						ws.style(i, 2).bold().fontSize(9).set();
					}
					else{
						ws.value(i, 2, benchmark_returns.getReturns_cmp_3year());
						ws.style(i, 2).bold().fontSize(9).set();
					}
					
					if(benchmark_returns.getReturns_cmp_5year() == 0){
						ws.value(i, 3, "-");
						ws.style(i, 3).bold().fontSize(9).set();
					}
					else{
						ws.value(i, 3, benchmark_returns.getReturns_cmp_5year());
						ws.style(i, 3).bold().fontSize(9).set();
					}
					
					if(benchmark_returns.getReturns_cmp_10year() == 0){
						ws.value(i, 4, "-");
						ws.style(i, 4).bold().fontSize(9).set();
					}
					else{
						ws.value(i, 4, benchmark_returns.getReturns_cmp_10year());
						ws.style(i, 4).bold().fontSize(9).set();
					}
					
					if(benchmark_returns.getReturns_cmp_inception() == 0){
						ws.value(i, 5, "-");
						ws.style(i++, 5).bold().fontSize(9).set();
					}
					else{
						ws.value(i, 5, benchmark_returns.getReturns_cmp_inception());
						ws.style(i++, 5).bold().fontSize(9).set();
					}			
				}
				
				String requestURL = "/mutual-funds-research/downloadMutualFundsPerformanceComparisonXl?fund="+fund+"&category="+category;
				LogDownload logDownload = new LogDownload();
				logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
				logDownload.setEmail(accountMap.get("email"));
				logDownload.setTitle("Mutual Funds Performance Comparison");
				logDownload.setRequest(requestURL);
				logDownload.setCreate_date(new Date());
				logDownload.setClient_name("dakshin");
				commonDao.saveDownloadLog(logDownload);
				
				wb.finish();
			}
			else
			{
				PrintWriter out = response.getWriter();
				response.setContentType("application/vnd.ms-excel");
				response.setCharacterEncoding("UTF-8");
			}
		}
		/*
		 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
		 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
		 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
		 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
		 * 
		 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
		 * response.setContentType("application/json");
		 * response.setCharacterEncoding("UTF-8");
		 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
		 */
	}
	
	@RequestMapping(value="/downloadMutualFundPointToPointReturnsXL")
	public void downloadMutualFundPointToPointReturnsXL(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		
		
		HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
		if(accountMap != null)
		{
			
			/*
			 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
			 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
			 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
			 * apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.
			 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
			 * );
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
			 */
		
			String category = request.getParameter("category");
			String schemes = request.getParameter("schemes");
			String amount = request.getParameter("amount");
	        String startDates = request.getParameter("startDates");
	        String endDates = request.getParameter("endDates");
	        String download = request.getParameter("download");
	        
	        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	        Calendar cal1 = Calendar.getInstance();
	        cal1.add(Calendar.DATE, -1);
	        String end_date_str = sdf.format(cal1.getTime());
			cal1.add(Calendar.YEAR, -1);
			cal1.add(Calendar.MONTH, 1);
			String start_date_str = sdf.format(cal1.getTime());
			
	        
			if(category == null || StringHelper.isEmpty(category)){category = "Equity: Multi Cap";}
	        if(schemes == null || StringHelper.isEmpty(schemes)){schemes = "HDFC Equity Fund - Growth Option";}
	        if(amount == null || StringHelper.isEmpty(amount)){amount = "10000";}
	        if(startDates == null || StringHelper.isEmpty(startDates)){startDates = start_date_str;}
	        if(endDates == null || StringHelper.isEmpty(endDates)){endDates = end_date_str;}
	        if(download == null){download= "";}
	        
	        category = category.trim();
	        schemes = schemes.trim();
	        amount = amount.trim();
	        startDates = startDates.trim();
	        endDates = endDates.trim();
	        download = download.trim();
	        
	        if(download.equalsIgnoreCase("yes"))
			{
	        
		        request.setAttribute("category", category);
		        request.setAttribute("schemes", schemes);
		        request.setAttribute("amount", amount);
		        request.setAttribute("startDates", startDates);
		        request.setAttribute("endDates", endDates);
		        
				List<String> start_date_array = new ArrayList<String>(Arrays.asList(startDates.split(",")));
				List<String> end_date_array = new ArrayList<String>(Arrays.asList(endDates.split(",")));
				
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
		 		
		 		
		 		response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", "attachment;filename=Mutual-Fund-Point-to-Point-Returns.xlsx");
				
				
				Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
				Worksheet ws = wb.newWorksheet("Mutual Fund Point to Point Returns - Multiple Schemes & Period Report");
				
				ws.value(0, 0, "Mutual Fund Point to Point Returns - Multiple Schemes & Period");
				ws.range(0, 0, 0, 2).merge();
				ws.range(0, 0, 0, 2).style().horizontalAlignment("center").set();
				ws.style(0, 0).bold().fontSize(10).set(); 
				
				ws.value(1, 0, "Category: "+category);
				ws.range(1, 0, 1, 2).merge();
				ws.style(1, 0).bold().fontSize(9).set();
				
				ws.value(2, 0, "Invested Amount: "+amount);
				ws.range(2, 0, 2, 2).merge();
				ws.style(2, 0).bold().fontSize(9).set();
				
				ws.width(0, 30);
				for(int i = 1;i<=(start_date_array.size()*2);i++){
					if(i%2 == 0)
						ws.width(i, 15);
					else
						ws.width(i, 12);
				}
				
						
				ws.value(3, 0, "Scheme Name");
				ws.range(3, 0, 4, 0).merge();
				ws.range(3, 0, 4, 0).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				
				if(start_date_array.size() > 0)
				{
					ws.value(3, 1, start_date_array.get(0) + " to " +end_date_array.get(0));
					ws.range(3, 1, 3, 2).merge();
					ws.range(3, 1, 3, 2).style().fontSize(9).horizontalAlignment("center").bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
		
					ws.value(4, 1, "Growth Value");
					ws.range(4, 1, 4, 1).merge();
					ws.range(4, 1, 4, 1).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
		
					ws.value(4, 2, "Absolute Return (%)");
					ws.range(4, 2, 4, 2).merge();
					ws.range(4, 2, 4, 2).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				}
				
				if(start_date_array.size() > 1)
				{
					
					ws.value(3, 3, start_date_array.get(1) + " to " +end_date_array.get(1));
					ws.range(3, 3, 3, 4).merge();
					ws.range(3, 3, 3, 4).style().fontSize(9).horizontalAlignment("center").bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
		
					ws.value(4, 3, "Growth Value");
					ws.range(4, 3, 4, 3).merge();
					ws.range(4, 3, 4, 3).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
		
					ws.value(4, 4, "Absolute Return (%)");
					ws.range(4, 4, 4, 4).merge();
					ws.range(4, 4, 4, 4).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					
				}
				
				if(start_date_array.size() > 2)
				{
					ws.value(3, 5, start_date_array.get(2) + " to " +end_date_array.get(2));
					ws.range(3, 5, 3, 6).merge();
					ws.range(3, 5, 3, 6).style().fontSize(9).horizontalAlignment("center").bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
		
					ws.value(4, 5, "Growth Value");
					ws.range(4, 5, 4, 5).merge();
					ws.range(4, 5, 4, 5).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
		
					ws.value(4, 6, "Absolute Return (%)");
					ws.range(4, 6, 4, 6).merge();
					ws.range(4, 6, 4, 6).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				}
				
				if(start_date_array.size() > 3)
				{
					ws.value(3, 7, start_date_array.get(3) + " to " +end_date_array.get(3));
					ws.range(3, 7, 3, 8).merge();
					ws.range(3, 7, 3, 8).style().fontSize(9).horizontalAlignment("center").bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
		
					ws.value(4, 7, "Growth Value");
					ws.range(4, 7, 4, 7).merge();
					ws.range(4, 7, 4, 7).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
		
					ws.value(4, 8, "Absolute Return (%)");
					ws.range(4, 8, 4, 8).merge();
					ws.range(4, 8, 4, 8).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				}
				
				if(start_date_array.size() > 4)
				{
					ws.value(3, 9, start_date_array.get(4) + " to " +end_date_array.get(4));
					ws.range(3, 9, 3, 10).merge();
					ws.range(3, 9, 3, 10).style().fontSize(9).horizontalAlignment("center").bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
		
					ws.value(4, 9, "Growth Value");
					ws.range(4, 9, 4, 9).merge();
					ws.range(4, 9, 4, 9).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
		
					ws.value(4, 10, "Absolute Return (%)");
					ws.range(4, 10, 4, 10).merge();
					ws.range(4, 10, 4, 10).style().fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				}
				
				
				int i = 5;
				
				for(PointToPointResponse schemePerformances: list.getPointToPointResponseList())
				{
					
					if(schemePerformances.getCategory().equalsIgnoreCase(""))
					{
						ws.value(i, 0, schemePerformances.getScheme());
						ws.style(i, 0).fontSize(9).wrapText(true).set();
					}	
					else
					{
						ws.value(i, 0, schemePerformances.getScheme());
						ws.style(i, 0).fontSize(9).wrapText(true).set();
					}	
					
					if(start_date_array.size() > 0)
					{				
						if(schemePerformances.getDate1_current_value() == 0)
						{
							ws.value(i, 1, "");
							ws.style(i, 1).fontSize(9).wrapText(true).set();
							
							ws.value(i, 2, "");
							ws.style(i, 2).fontSize(9).wrapText(true).set();
						}	
						else
						{
							ws.value(i, 1, roundOffNumber(schemePerformances.getDate1_current_value()));
							ws.style(i, 1).fontSize(9).wrapText(true).set();
							
							ws.value(i, 2, twoDecimal(((schemePerformances.getDate1_current_value() - schemePerformances.getCurrent_cost()) / schemePerformances.getCurrent_cost()) * 100));
							ws.style(i, 2).fontSize(9).wrapText(true).set();
						}					
					 }	
					
					if(start_date_array.size() > 1)
					{
						if(schemePerformances.getDate2_current_value() == 0)
						{
							ws.value(i, 3, "");
							ws.style(i, 3).fontSize(9).wrapText(true).set();
							
							ws.value(i, 4, "");
							ws.style(i, 4).fontSize(9).wrapText(true).set();
						}	
						else
						{
							ws.value(i, 3, roundOffNumber(schemePerformances.getDate2_current_value()));
							ws.style(i, 3).fontSize(9).wrapText(true).set();
							
							ws.value(i, 4, twoDecimal(((schemePerformances.getDate2_current_value() - schemePerformances.getCurrent_cost()) / schemePerformances.getCurrent_cost()) * 100));
							ws.style(i, 4).fontSize(9).wrapText(true).set();
						}
					}	
					
					if(start_date_array.size() > 2)
					{
						if(schemePerformances.getDate3_current_value() == 0)
						{
							ws.value(i, 5, "");
							ws.style(i, 5).fontSize(9).wrapText(true).set();
							
							ws.value(i, 6, "");
							ws.style(i, 6).fontSize(9).wrapText(true).set();
						}	
						else
						{
							ws.value(i, 5, roundOffNumber(schemePerformances.getDate3_current_value()));
							ws.style(i, 5).fontSize(9).wrapText(true).set();
							
							ws.value(i, 6, twoDecimal(((schemePerformances.getDate3_current_value() - schemePerformances.getCurrent_cost()) / schemePerformances.getCurrent_cost()) * 100));
							ws.style(i, 6).fontSize(9).wrapText(true).set();
						}
					}
					
					if(start_date_array.size() > 3)
					{
						if(schemePerformances.getDate4_current_value() == 0)
						{
							ws.value(i, 7, "");
							ws.style(i, 7).fontSize(9).wrapText(true).set();
							
							ws.value(i, 8, "");
							ws.style(i, 8).fontSize(9).wrapText(true).set();
						}	
						else
						{
							ws.value(i, 7, roundOffNumber(schemePerformances.getDate4_current_value()));
							ws.style(i, 7).fontSize(9).wrapText(true).set();
							
							ws.value(i, 8, twoDecimal(((schemePerformances.getDate4_current_value() - schemePerformances.getCurrent_cost()) / schemePerformances.getCurrent_cost()) * 100));
							ws.style(i, 8).fontSize(9).wrapText(true).set();
						}
					}
					
					
					if(start_date_array.size() > 4)
					{
						if(schemePerformances.getDate5_current_value() == 0)
						{
							ws.value(i, 9, "");
							ws.style(i, 9).fontSize(9).wrapText(true).set();
							
							ws.value(i, 10, "");
							ws.style(i, 10).fontSize(9).wrapText(true).set();
						}	
						else
						{
							ws.value(i, 9, roundOffNumber(schemePerformances.getDate5_current_value()));
							ws.style(i, 9).fontSize(9).wrapText(true).set();
							
							ws.value(i, 10, twoDecimal(((schemePerformances.getDate5_current_value() - schemePerformances.getCurrent_cost()) / schemePerformances.getCurrent_cost()) * 100));
							ws.style(i, 10).fontSize(9).wrapText(true).set();
						}
					}	
					
					i++;
				}
				
				String requestURL = "/mutual-funds-research/downloadMutualFundPointToPointReturnsXL?category="+category+"&schemes="+schemes+"&startDates="+startDates+"&endDates="+endDates+"&amount="+amount;
				LogDownload logDownload = new LogDownload();
				logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
				logDownload.setEmail(accountMap.get("email"));
				logDownload.setTitle("Mutual Fund Point to Point Returns - Multiple Schemes & Period");
				logDownload.setRequest(requestURL);
				logDownload.setCreate_date(new Date());
				logDownload.setClient_name("dakshin");
				commonDao.saveDownloadLog(logDownload);
				
				wb.finish();
			}
			else
			{
				PrintWriter out = response.getWriter();
				response.setContentType("application/vnd.ms-excel");
				response.setCharacterEncoding("UTF-8");
			}
		}
		/*
		 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
		 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
		 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
		 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
		 * 
		 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
		 * response.setContentType("application/json");
		 * response.setCharacterEncoding("UTF-8");
		 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
		 */
	}
	
	@RequestMapping(value="/downloadMutualFundSIPCalculatorXl")
	public void downloadMutualFundSIPCalculatorXl(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		
		HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
		if(accountMap != null)
		{
			
			/*
			 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
			 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
			 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
			 * apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.
			 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
			 * );
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
			 */
		
			String category = request.getParameter("category");
	        String fund = request.getParameter("fund");
	        String amount = request.getParameter("amount");
	        String frequency = request.getParameter("frequency");
	        String start_date = request.getParameter("startdate");
	        String end_date = request.getParameter("enddate");
	        String download = request.getParameter("download");
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
			if(download == null){download= "";}
	        
	        category = category.trim();
	        category_name = category_name.trim();
	        fund = fund.trim();
	        amount = amount.trim();
	        frequency = frequency.trim();
	        start_date = start_date.trim();
	        end_date = end_date.trim(); 
			download = download.trim();
			
			if(download.equalsIgnoreCase("yes"))
			{
	        
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
		 		
		 		response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", "attachment;filename=Mutual-Fund-SIP-Calculator.xlsx");		
				
				Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
				Worksheet ws = wb.newWorksheet("Mutual Fund SIP Calculator Report");
				
				SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");
				
				ws.width(0, 20);
				ws.width(1, 10);
				ws.width(2, 10);
				ws.width(3, 10);
				ws.width(4, 10);
				ws.width(5, 10);
				ws.width(6, 10);
				ws.width(7, 10);
				ws.width(8, 10);
		
				ws.value(0, 0, "Mutual Fund SIP Calculator");
				ws.range(0, 0, 0, 8).merge();
				ws.range(0, 0, 0, 8).style().horizontalAlignment("center").set();
				ws.style(0, 0).bold().fontSize(11).set(); 		
				
				ws.value(1, 0, "Category: "+category);
				ws.range(1, 0, 1, 8).merge();
				ws.range(1, 0, 1, 8).style().horizontalAlignment("left").set();
				ws.style(1, 0).bold().fontSize(9).set(); 
				
				ws.value(2, 0, "Installment Amount: "+amount);
				ws.range(2, 0, 2, 8).merge();
				ws.range(2, 0, 2, 8).style().horizontalAlignment("left").set();
				ws.style(2, 0).bold().fontSize(9).set();
				
				ws.value(3, 0, "Frequency: "+frequency);
				ws.range(3, 0, 3, 8).merge();
				ws.range(3, 0, 3, 8).style().horizontalAlignment("left").set();
				ws.style(3, 0).bold().fontSize(9).set();
				
				ws.value(4, 0, "Start Date: "+start_date);
				ws.range(4, 0, 4, 8).merge();
				ws.range(4, 0, 4, 8).style().horizontalAlignment("left").set();
				ws.style(4, 0).bold().fontSize(9).set();
				
				ws.value(5, 0, "End Date: "+end_date);
				ws.range(5, 0, 5, 8).merge();
				ws.range(5, 0, 5, 8).style().horizontalAlignment("left").set();
				ws.style(5, 0).bold().fontSize(9).set();
				
				ws.value(6, 0, "Summary");
				ws.range(6, 0, 6, 8).merge();
				ws.range(6, 0, 6, 8).style().horizontalAlignment("left").set();
				ws.style(6, 0).bold().fontSize(11).set();
									
				int i = 7;
				int j = 0;
				for(j = 0; j <= 8; j++) {
					ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
				}
						
				ws.value(i, 0, "Fund Name");
				ws.style(i, 0).horizontalAlignment("left").wrapText(true).set();
		        ws.value(i, 1, "Launch Date");
		        ws.style(i, 1).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 2, "Nav Date");
			    ws.style(i, 2).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 3, "Nav");
			    ws.style(i, 3).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 4, "Units");
			    ws.style(i, 4).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 5, "No of Installments");
			    ws.style(i, 5).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 6, "Investment Amount");
			    ws.style(i, 6).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 7, "SIP value as on " +end_date);
			    ws.style(i, 7).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 8, "XIRR (%)");
			    ws.style(i++, 8).horizontalAlignment("center").wrapText(true).set();
			    
			    for(SIPCalcFinalResponse sip: sip_list.getList())
			    {
			    	ws.value(i, 0, sip.getScheme());
					ws.style(i, 0).fontSize(9).horizontalAlignment("left").wrapText(true).set();
					
					ws.value(i, 1, sdf1.format(sip.getInception_date()));
					ws.style(i, 1).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 2, sdf1.format(sip.getNav_date()));
					ws.style(i, 2).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 3, sip.getNav());
					ws.style(i, 3).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 4, twoDecimal(sip.getUnits()));
					ws.style(i, 4).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 5, sip.getNo_of_installment());
					ws.style(i, 5).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 6, sip.getInvested_amount());
					ws.style(i, 6).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 7, sip.getCurrent_value());
					ws.style(i, 7).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 8, sip.getReturns());
					ws.style(i++, 8).fontSize(9).horizontalAlignment("center").wrapText(true).set();
			    }
			    
			    ws.range(i, 0, i++, 4).merge();
			    
			    ws.value(i, 0, "Cash Flow");
				ws.range(i, 0, i, 4).merge();
				ws.range(i, 0, i++, 4).style().horizontalAlignment("left").bold().fontSize(11).set();
				
				for(SIPCalcFinalResponse sip: sip_list.getList())
			    {
					ws.value(i, 0, sip.getScheme());
					ws.range(i, 0, i, 4).merge();
					ws.range(i, 0, i++, 4).style().horizontalAlignment("center").bold().fontSize(11).set();
					
					ws.value(i, 0, "Nav Date");
					ws.style(i, 0).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					
					ws.value(i, 1, "Nav");
					ws.style(i, 1).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					
					ws.value(i, 2, "Cumulative Units");
					ws.style(i, 2).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					
					ws.value(i, 3, "Cumulative Invested Amount");
					ws.style(i, 3).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					
					ws.value(i, 4, "Market Value");
					ws.style(i++, 4).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					
					for(SIPCalcResponse scheme: sip.getSip_list())
					{
						ws.value(i, 0, sdf1.format(scheme.getNav_date()));
						ws.style(i, 0).fontSize(9).horizontalAlignment("center").wrapText(true).set();
						
						ws.value(i, 1, scheme.getNav());
						ws.style(i, 1).fontSize(9).horizontalAlignment("center").wrapText(true).set();
						
						ws.value(i, 2, twoDecimal(scheme.getCumulative_units()));
						ws.style(i, 2).fontSize(9).horizontalAlignment("center").wrapText(true).set();
						
						ws.value(i, 3, roundOffNumber(scheme.getCumulative_invested_amount()));
						ws.style(i, 3).fontSize(9).horizontalAlignment("center").wrapText(true).set();
						
						ws.value(i, 4, roundOffNumber(scheme.getCurrent_value()));
						ws.style(i++, 4).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					}	
			    }
				
				String requestURL = "/mutual-funds-research/downloadMutualFundSIPCalculatorXl?category="+category +"&fund="+fund+"&amount="+amount+"&frequency="+frequency+"&startdate="+start_date+"&enddate="+end_date;
				LogDownload logDownload = new LogDownload();
				logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
				logDownload.setEmail(accountMap.get("email"));
				logDownload.setTitle("Mutual Fund SIP Calculator");
				logDownload.setRequest(requestURL);
				logDownload.setCreate_date(new Date());
				logDownload.setClient_name("dakshin");
				commonDao.saveDownloadLog(logDownload);
				
				wb.finish();
			}
			else
			{
				PrintWriter out = response.getWriter();
				response.setContentType("application/vnd.ms-excel");
				response.setCharacterEncoding("UTF-8");
			}
		}
		/*
		 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
		 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
		 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
		 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
		 * 
		 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
		 * response.setContentType("application/json");
		 * response.setCharacterEncoding("UTF-8");
		 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
		 */
	}
	
	@RequestMapping(value="/downloadTopPerformingSystematicInvestmentPlanXl")
	public void downloadTopPerformingSystematicInvestmentPlanXl(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
		if(accountMap != null)
		{
			
			/*
			 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
			 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
			 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
			 * apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.
			 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
			 * );
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
			 */
		
			String category =  request.getParameter("category");
	 		String period = request.getParameter("period");
	 		String amount = request.getParameter("amount");
	 		String category_name = category;
	 		String download = request.getParameter("download");
	 		
	 		if(category == null || StringHelper.isEmpty(category)){category= "Equity: Multi Cap";}
	 		if(category_name == null){category_name= "";}
	 		if(period == null || StringHelper.isEmpty(period) || !period.matches("[0-9]+")){period= "1";}
	 		if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount= "3000";}
			if(download == null){download= "";}
	 		
	 		category = category.trim();
	 		category_name = category_name.trim();
	 		period = period.trim();
	 		amount = amount.trim();
			download = download.trim();
			
			if(download.equalsIgnoreCase("yes"))
			{
			
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
		     	
		     	response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", "attachment;filename=Top-Performing-Systematic-Investment-Plan.xlsx");
				
				
				Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
				Worksheet ws = wb.newWorksheet("Top Performing Systematic Investment Plan Report");
				
				SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");
				
				ws.width(0, 30);
				ws.width(1, 12);
				ws.width(2, 12);
				ws.width(3, 18);
				ws.width(4, 18);
				ws.width(5, 12);
				ws.width(6, 12);
		
				ws.value(0, 0, "Top Performing Systematic Investment Plan");
				ws.range(0, 0, 0, 6).merge();
				ws.range(0, 0, 0, 6).style().horizontalAlignment("center").set();
				ws.style(0, 0).bold().fontSize(11).set(); 
				
				ws.value(1, 0, "Data as on - " +apiCommonResponse.getNav_date());
				ws.range(1, 0, 1, 6).merge();
				ws.range(1, 0, 1, 6).style().horizontalAlignment("left").set();
				ws.style(1, 0).bold().fontSize(11).set(); 
									
				int i = 2;
				int j = 0;
				ws.width(0, 20);
				for(j = 0; j <= 6; j++) {
					ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					ws.width(j+1, 10);
				}
						
				ws.value(i, 0, "Scheme Name");
				ws.style(i, 0).horizontalAlignment("left").set();
		        ws.value(i, 1, "Launch Date");
		        ws.style(i, 1).horizontalAlignment("center").set();
			    ws.value(i, 2, "AUM (Crore)");
			    ws.style(i, 2).horizontalAlignment("center").set();
			    ws.value(i, 3, "Expense Ratio (%)");
			    ws.style(i, 3).horizontalAlignment("center").set();
			    ws.value(i, 4, "Invested Amount");
			    ws.style(i, 4).horizontalAlignment("center").set();
			    ws.value(i, 5, "Current Value");
			    ws.style(i, 5).horizontalAlignment("center").set();
			    ws.value(i, 6, "Return (%)");
			    ws.style(i++, 6).horizontalAlignment("center").set();
			    
			    for(SchemePerformancesSip schemePerformances: mutualFundAPIResponse.getList())
			    {
			    	ws.value(i, 0, schemePerformances.getScheme_name());
					ws.style(i, 0).fontSize(9).horizontalAlignment("left").wrapText(true).set();
					
					ws.value(i, 1, sdf1.format(schemePerformances.getInception_date()));
					ws.style(i, 1).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					if(schemePerformances.getScheme_assets() == 0)
					{
						ws.value(i, 2, "-");
						ws.style(i, 2).fontSize(9).horizontalAlignment("center").set();
					}	
					else
					{
						ws.value(i, 2, Double.parseDouble(String.valueOf(schemePerformances.getScheme_assets() / 10)));
						ws.style(i, 2).fontSize(9).horizontalAlignment("center").set();
					}	
					
					if(schemePerformances.getTer() == 0)
					{
						ws.value(i, 3, "-");
						ws.style(i, 3).fontSize(9).horizontalAlignment("center").set();
					}	
					else
					{
						ws.value(i, 3, schemePerformances.getTer());
						ws.style(i, 3).fontSize(9).horizontalAlignment("center").set();
					}	
					
					ws.value(i, 4, schemePerformances.getCurrent_cost());
					ws.style(i, 4).fontSize(9).horizontalAlignment("center").set();
					
					ws.value(i, 5, schemePerformances.getCurrent_value());
					ws.style(i, 5).fontSize(9).horizontalAlignment("center").set();
					
					ws.value(i, 6, schemePerformances.getReturns());
					ws.style(i++, 6).fontSize(9).horizontalAlignment("center").set();
			    }
			    
			    SchemePerformancesSip category_returns = mutualFundAPIResponse.getCategory_returns();
			    SchemePerformancesSip benchmark_returns = mutualFundAPIResponse.getBenchmark_returns();
			    
			    if(category_returns != null)
			    {
			    	ws.value(i, 0, "Category Average");
					ws.style(i, 0).fontSize(9).bold().horizontalAlignment("left").set();
					ws.value(i, 1, "-");
					ws.style(i, 1).fontSize(9).bold().horizontalAlignment("center").set();
					ws.value(i, 2, "-");
					ws.style(i, 2).fontSize(9).bold().horizontalAlignment("center").set();
					ws.value(i, 3, "-");
					ws.style(i, 3).fontSize(9).bold().horizontalAlignment("center").set();
					ws.value(i, 4, category_returns.getCurrent_cost());
					ws.style(i, 4).fontSize(9).bold().horizontalAlignment("center").set();
					ws.value(i, 5, category_returns.getCurrent_value());
					ws.style(i, 5).fontSize(9).bold().horizontalAlignment("center").set();
					ws.value(i, 6, category_returns.getReturns());
					ws.style(i++, 6).fontSize(9).bold().horizontalAlignment("center").set();
			    }	
			    
			    if(benchmark_returns != null)
			    {
			    	ws.value(i, 0, benchmark_returns.getScheme_name());
					ws.style(i, 0).fontSize(9).bold().horizontalAlignment("left").set();
					ws.value(i, 1, sdf1.format(benchmark_returns.getInception_date()));
					ws.style(i, 1).fontSize(9).bold().horizontalAlignment("center").set();
					ws.value(i, 2, "-");
					ws.style(i, 2).fontSize(9).bold().horizontalAlignment("center").set();
					ws.value(i, 3, "-");
					ws.style(i, 3).fontSize(9).bold().horizontalAlignment("center").set();
					ws.value(i, 4, benchmark_returns.getCurrent_cost());
					ws.style(i, 4).fontSize(9).bold().horizontalAlignment("center").set();
					ws.value(i, 5, benchmark_returns.getCurrent_value());
					ws.style(i, 5).fontSize(9).bold().horizontalAlignment("center").set();
					ws.value(i, 6, benchmark_returns.getReturns());
					ws.style(i++, 6).fontSize(9).bold().horizontalAlignment("center").set();
			    }
			    
			    String requestURL = "/mutual-funds-research/downloadTopPerformingSystematicInvestmentPlanXl?category=" +category+"&period="+period+"&amount="+amount;
				LogDownload logDownload = new LogDownload();
				logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
				logDownload.setEmail(accountMap.get("email"));
				logDownload.setTitle("Top Performing Systematic Investment Plan");
				logDownload.setRequest(requestURL);
				logDownload.setCreate_date(new Date());
				logDownload.setClient_name("dakshin");
				commonDao.saveDownloadLog(logDownload);
			    
			    wb.finish();
			}
			else
			{
				PrintWriter out = response.getWriter();
				response.setContentType("application/vnd.ms-excel");
				response.setCharacterEncoding("UTF-8");
			}
		}
		/*
		 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
		 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
		 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
		 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
		 * 
		 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
		 * response.setContentType("application/json");
		 * response.setCharacterEncoding("UTF-8");
		 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
		 */
	}
	
	@RequestMapping(value="/downloadTopPerformingSIPELSSFundsXl")
	public void downloadTopPerformingSIPELSSFundsXl(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		
		HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
		if(accountMap != null)
		{
			
			/*
			 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
			 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
			 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
			 * apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.
			 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
			 * );
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
			 */
		
			String category =  request.getParameter("category");
	 		String period = request.getParameter("period");
	 		String amount = request.getParameter("amount");
	 		String download = request.getParameter("download");
	 		
	 		if(category == null || StringHelper.isEmpty(category)){category= "Equity: ELSS";}
	 		if(period == null || StringHelper.isEmpty(period) || !period.matches("[0-9]+")){period= "1";}
	 		if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount= "3000";}
			if(download == null){download= "";}
	 		
	 		category = category.trim();
	 		period = period.trim();
	 		amount = amount.trim();
			download = download.trim();
			
			if(download.equalsIgnoreCase("yes"))
			{
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
		     	
		     	
		     	response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", "attachment;filename=Top-Performing-SIP-ELSS-Funds.xlsx");		
				
				Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
				Worksheet ws = wb.newWorksheet("Top Performing SIP ELSS Funds Report");
				
				SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");
				
				ws.width(0, 30);
				ws.width(1, 12);
				ws.width(2, 12);
				ws.width(3, 18);
				ws.width(4, 18);
				ws.width(5, 12);
				ws.width(6, 12);
		
				ws.value(0, 0, "Top Performing SIP ELSS Funds");
				ws.range(0, 0, 0, 6).merge();
				ws.range(0, 0, 0, 6).style().horizontalAlignment("center").set();
				ws.style(0, 0).bold().fontSize(11).set();  
				
				ws.value(1, 0, "Data as on - " +apiCommonResponse.getNav_date());
				ws.range(1, 0, 1, 6).merge();
				ws.range(1, 0, 1, 6).style().horizontalAlignment("left").set();
				ws.style(1, 0).bold().fontSize(11).set(); 
									
				int i = 2;
				int j = 0;
				ws.width(0, 20);
				for(j = 0; j <= 6; j++) {
					ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
					ws.width(j+1, 10);
				}
						
				ws.value(i, 0, "Scheme Name");
				ws.style(i, 0).horizontalAlignment("left").wrapText(true).set();
		        ws.value(i, 1, "Launch Date");
		        ws.style(i, 1).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 2, "AUM (Crore)");
			    ws.style(i, 2).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 3, "Expense Ratio (%)");
			    ws.style(i, 3).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 4, "Invested Amount");
			    ws.style(i, 4).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 5, "Current Value");
			    ws.style(i, 5).horizontalAlignment("center").wrapText(true).set();
			    ws.value(i, 6, "Return (%)");
			    ws.style(i++, 6).horizontalAlignment("center").wrapText(true).set();
			    
			    for(SchemePerformancesSip schemePerformances: mutualFundAPIResponse.getList())
			    {
			    	ws.value(i, 0, schemePerformances.getScheme_name());
					ws.style(i, 0).fontSize(9).horizontalAlignment("left").wrapText(true).set();
					
					ws.value(i, 1, sdf1.format(schemePerformances.getInception_date()));
					ws.style(i, 1).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					if(schemePerformances.getScheme_assets() == 0)
					{
						ws.value(i, 2, "-");
						ws.style(i, 2).fontSize(9).horizontalAlignment("center").set();
					}	
					else
					{
						ws.value(i, 2, Double.parseDouble(String.valueOf(schemePerformances.getScheme_assets() / 10)));
						ws.style(i, 2).fontSize(9).horizontalAlignment("center").set();
					}	
					
					if(schemePerformances.getTer() == 0)
					{
						ws.value(i, 3, "-");
						ws.style(i, 3).fontSize(9).horizontalAlignment("center").set();
					}	
					else
					{
						ws.value(i, 3, schemePerformances.getTer());
						ws.style(i, 3).fontSize(9).horizontalAlignment("center").set();
					}	
					
					ws.value(i, 4, schemePerformances.getCurrent_cost());
					ws.style(i, 4).fontSize(9).horizontalAlignment("center").set();
					
					ws.value(i, 5, schemePerformances.getCurrent_value());
					ws.style(i, 5).fontSize(9).horizontalAlignment("center").set();
					
					ws.value(i, 6, schemePerformances.getReturns());
					ws.style(i++, 6).fontSize(9).horizontalAlignment("center").set();
			    }	
			    
			    SchemePerformancesSip category_returns = mutualFundAPIResponse.getCategory_returns();
			    SchemePerformancesSip benchmark_returns = mutualFundAPIResponse.getBenchmark_returns();
			    
			    if(category_returns != null)
			    {
			    	ws.value(i, 0, "Category Average");
					ws.style(i, 0).bold().fontSize(9).horizontalAlignment("left").set();
					ws.value(i, 1, "-");
					ws.style(i, 1).bold().fontSize(9).horizontalAlignment("center").set();
					ws.value(i, 2, "-");
					ws.style(i, 2).bold().fontSize(9).horizontalAlignment("center").set();
					ws.value(i, 3, "-");
					ws.style(i, 3).bold().fontSize(9).horizontalAlignment("center").set();
					ws.value(i, 4, category_returns.getCurrent_cost());
					ws.style(i, 4).bold().fontSize(9).horizontalAlignment("center").set();
					ws.value(i, 5, category_returns.getCurrent_value());
					ws.style(i, 5).bold().fontSize(9).horizontalAlignment("center").set();
					ws.value(i, 6, category_returns.getReturns());
					ws.style(i++, 6).bold().fontSize(9).horizontalAlignment("center").set();
			    }	
			    
			    if(benchmark_returns != null)
			    {
			    	ws.value(i, 0, benchmark_returns.getScheme_name());
					ws.style(i, 0).bold().fontSize(9).horizontalAlignment("left").set();
					ws.value(i, 1, sdf1.format(benchmark_returns.getInception_date()));
					ws.style(i, 1).bold().fontSize(9).horizontalAlignment("center").set();
					ws.value(i, 2, "-");
					ws.style(i, 2).bold().fontSize(9).horizontalAlignment("center").set();
					ws.value(i, 3, "-");
					ws.style(i, 3).bold().fontSize(9).horizontalAlignment("center").set();
					ws.value(i, 4, benchmark_returns.getCurrent_cost());
					ws.style(i, 4).bold().fontSize(9).horizontalAlignment("center").set();
					ws.value(i, 5, benchmark_returns.getCurrent_value());
					ws.style(i, 5).bold().fontSize(9).horizontalAlignment("center").set();
					ws.value(i, 6, benchmark_returns.getReturns());
					ws.style(i++, 6).bold().fontSize(9).horizontalAlignment("center").set();
			    }
			    
			    String requestURL = "/mutual-funds-research/downloadTopPerformingSIPELSSFundsXl?period="+period+ "&amount="+amount;
				LogDownload logDownload = new LogDownload();
				logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
				logDownload.setEmail(accountMap.get("email"));
				logDownload.setTitle("Top Performing SIP ELSS Funds");
				logDownload.setRequest(requestURL);
				logDownload.setCreate_date(new Date());
				logDownload.setClient_name("dakshin");
				commonDao.saveDownloadLog(logDownload);
			    
			    wb.finish();
			}
			else
			{
				PrintWriter out = response.getWriter();
				response.setContentType("application/vnd.ms-excel");
				response.setCharacterEncoding("UTF-8");
			}
		}
		/*
		 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
		 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
		 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
		 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
		 * 
		 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
		 * response.setContentType("application/json");
		 * response.setCharacterEncoding("UTF-8");
		 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
		 */
	    
	}
	
	@RequestMapping(value="/mutualFundStpInvestmentCalculator")
	public void mutualFundStpInvestmentCalculator(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		String requestUrl = request.getRequestURL().toString();
		String queryString = request.getQueryString();
		
		try
		{
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
			if(accountMap != null)
			{
				
				/*
				 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
				 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
				 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
				 * apiCommonResponse = new ApiCommonResponse();
				 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
				 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
				 * FailureMessage); apiCommonResponse.
				 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
				 * );
				 * 
				 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
				 * response.setContentType("application/json");
				 * response.setCharacterEncoding("UTF-8");
				 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
				 */
			
			
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
		        String download = request.getParameter("download");
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
				if(download == null){download= "";}
	
		        
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
				download = download.trim();
				
				if(download.equalsIgnoreCase("yes"))
				{
		        
			        response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition", "attachment;filename=Mutual-Fund-STP-Calculator-Report.xlsx");
					
					// Create new Excel workbook and sheet
					Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
					Worksheet ws = wb.newWorksheet("Mutual Fund STP Calculator Report");
					
				/*	ws.value(0, 0, "advisorkhoj");
					ws.style(0, 0).bold().fontSize(9).set();
					ws.range(0, 0, 0, 9).merge();*/
					
					String name = "";
					if(!amc_name.equals("")){
						name = "Mutual Fund STP Calculator of "+amc_name;
					}else{
						name = "Mutual Fund STP Calculator";
					}
					
					ws.value(1, 0, name);
					ws.range(1, 0, 1, 9).merge();
					ws.style(1, 0).bold().fontSize(11).horizontalAlignment("center").set();
					
					String lumpsum_fullname = "";
					if(lumpsum_option.equals("LAEP")){
						lumpsum_fullname = "One Time Investment";
					}
					else if(lumpsum_option.equals("LAY")){
						lumpsum_fullname = "Yearly Investment";
					}
					else if(lumpsum_option.equals("LAHY")){
						lumpsum_fullname = "Half Yearly Investment";
					}
					else if(lumpsum_option.equals("LAQ")){
						lumpsum_fullname = "Quarterly Investment";
					}
					
					displayFiltervalue(ws, "AMC:", amc, "Transfer From Scheme:", from_scheme, 2);
					displayFiltervalue(ws, "Initial Investment Option:", lumpsum_fullname, "Transfer To Scheme:", to_scheme, 3);
					displayFiltervalue(ws, "Tenure (Yrs):", lumpsum_year, "Initial Investment Amount:", initial_amount, 4);
					displayFiltervalue(ws, "Initial Investment Date", init_start_date, "STP Transfer Amount:", transfer_amount, 5);
					displayFiltervalue(ws, "STP Day", stp_date, "Frequency:", period, 6);
					displayFiltervalue(ws, "STP Start Date", from_date, "STP End Date:", to_date, 7);
					
					String formattedUrl, result = "";
					HashMap<String, String> hashMap = new HashMap<String, String>();
					
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
			 		
			 		
			 		ws.value(8, 0, "");
					ws.style(8, 0).bold().fontSize(9).set();
					ws.range(8, 0, 8, 9).merge();
			 		
			 		ws.value(9, 0, "STP - Transferor Scheme : "+from_scheme);
					ws.style(9, 0).bold().fontSize(9).set();
					ws.range(9, 0, 9, 9).merge();
			 		
			 		int i = 10;
					int j = 0;
					
					for(j = 0; j < 10; j++) {
						ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
						ws.width(j, 12);
					}
			 		
			 		ws.value(i, 0, "Total Initial Investment Amount");
					ws.value(i, 1, period+"STP Amount (Rs.)");
					ws.value(i, 2, "STP Period");
					ws.value(i, 3, "No of Installments");
					ws.value(i, 4, "Total Amount Transferred");
					ws.value(i, 5, "Total No. Units Remaining");
					ws.value(i, 6, "Value as on\n"+list.getFrom_scheme_current_value_date());
					ws.value(i, 7, "Current Value as on\n"+ list.getFrom_scheme_end_value_date());
					ws.value(i, 8, "Profit");
					ws.value(i++, 9, "Returns (%)");
		
					ws.value(i, 0, list.getTotal_invested_amount());
					ws.style(i, 0).fontSize(9).set();
					ws.value(i, 1, Integer.parseInt(transfer_amount));
					ws.style(i, 1).fontSize(9).set();
					ws.value(i, 2, from_date+" to\n"+to_date);
					ws.style(i, 2).fontSize(9).wrapText(true).set();
					ws.value(i, 3, list.getTo_scheme_installment());
					ws.style(i, 3).fontSize(9).set();
					ws.value(i, 4, list.getTo_scheme_total_amount_invested());
					ws.style(i, 4).fontSize(9).set();
					ws.value(i, 5, convertDouble(list.getFrom_scheme_remaining_units()));
					ws.style(i, 5).fontSize(9).set();
					ws.value(i, 6, convertDouble(list.getFrom_scheme_current_value()));
					ws.style(i, 6).fontSize(9).set();
					ws.value(i, 7, convertDouble(list.getFrom_scheme_end_value()));
					ws.style(i, 7).fontSize(9).set();
					ws.value(i, 8, convertDouble(list.getFrom_scheme_profit()));
					ws.style(i, 8).fontSize(9).set();
					ws.value(i, 9, convertDouble(list.getFrom_scheme_returns()));
					ws.style(i++, 9).fontSize(9).set();
					
					
					ws.value(i, 0, "");
					ws.style(i, 0).bold().fontSize(9).set();
					ws.range(i, 0, i++, 9).merge();
					
					ws.value(i, 0, "STP - Transferee Scheme : "+to_scheme);
					ws.style(i, 0).bold().fontSize(9).set();
					ws.range(i, 0, i++, 9).merge();
					
					for(j = 0; j < 10; j++) {
						ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
						ws.width(j, 12);
					}
					
					ws.value(i, 0, period+" STP Amount (Rs.)");
					ws.value(i, 1, "STP Period");
					ws.value(i, 2, "No of Installments");
					ws.value(i, 3, "Total Amount Invested");
					ws.value(i, 4, "Total No. Units Accumulated");
					ws.value(i, 5, "Value as on\n"+list.getTo_scheme_current_value_date());
					ws.value(i, 6, "Current Value as on\n"+list.getTo_scheme_end_value_date());
					ws.value(i, 7, "Profit");
					ws.value(i++, 8, "Returns (%)");
					
					ws.value(i, 0, Integer.parseInt(transfer_amount));
					ws.style(i, 0).fontSize(9).set();
					ws.value(i, 1, from_date+" to\n"+to_date);
					ws.style(i, 1).fontSize(9).wrapText(true).set();
					ws.value(i, 2, list.getTo_scheme_installment());
					ws.style(i, 2).fontSize(9).set();
					ws.value(i, 3, list.getTo_scheme_total_amount_invested());
					ws.style(i, 3).fontSize(9).set();
					ws.value(i, 4, convertDouble(list.getTo_scheme_accumulated_units()));
					ws.style(i, 4).fontSize(9).set();
					ws.value(i, 5, convertDouble(list.getTo_scheme_current_value()));
					ws.style(i, 5).fontSize(9).set();
					ws.value(i, 6, convertDouble(list.getTo_scheme_end_value()));
					ws.style(i, 6).fontSize(9).set();
					ws.value(i, 7, convertDouble(list.getTo_scheme_profit()));
					ws.style(i, 7).fontSize(9).set();
					ws.value(i, 8, convertDouble(list.getTo_scheme_returns()));
					ws.style(i++, 8).fontSize(9).set();
					
					ws.value(i, 0, "");
					ws.style(i, 0).bold().fontSize(9).set();
					ws.range(i, 0, i++, 9).merge();
					
					ws.value(i, 0, "STP - Total Returns:");
					ws.style(i, 0).bold().fontSize(9).set();
					ws.range(i, 0, i++, 9).merge();
					
					for(j = 0; j < 4; j++) {
						ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
						ws.width(j, 12);
					}
					
					ws.value(i, 0, "Total Investment Amount");
					ws.value(i, 1, "Total Current Value");
					ws.value(i, 2, "Total Profit");
					ws.value(i++, 3, "Total Returns (%)");
					
					ws.value(i, 0, convertDouble(list.getTotal_invested_amount()));
					ws.style(i, 0).fontSize(9).set();
					ws.value(i, 1, convertDouble(list.getTotal_current_value()));
					ws.style(i, 1).fontSize(9).wrapText(true).set();
					ws.value(i, 2, convertDouble(list.getTotal_profit()));
					ws.style(i, 2).fontSize(9).set();
					ws.value(i, 3, convertDouble(list.getTotal_returns()));
					ws.style(i++, 3).fontSize(9).set();
					
					ws.value(i, 0, "");
					ws.style(i, 0).bold().fontSize(9).set();
					ws.range(i, 0, i++, 9).merge();
					
					ws.value(i, 0, from_scheme);
					ws.style(i, 0).bold().fontSize(9).set();
					ws.range(i, 0, i++, 9).merge();
					
					
					for(j = 0; j < 9; j++) {
						ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
						ws.width(j, 12);
					}
					
					ws.value(i, 0, "Nav Date");
					ws.value(i, 1, "Nav");
					ws.value(i, 2, "Units");
					ws.value(i, 3, "Cumulative Units");
					ws.value(i, 4, "Cash Flow");
					ws.value(i, 5, "Net Amount");
					ws.value(i, 6, "Capital Gain/Loss");
					ws.value(i, 7, "No. of Days (Invested)");
					ws.value(i++, 8, "Current Value");
					
					for(STPCalcResponse stpCalc: list.getFrom_scheme_list()){
						ws.value(i, 0, sdf.format(stpCalc.getNav_date()));
						ws.style(i, 0).fontSize(9).set();
						ws.value(i, 1, convertDouble(stpCalc.getNav()));
						ws.style(i, 1).fontSize(9).wrapText(true).set();
						ws.value(i, 2, convertDouble(stpCalc.getUnits()));
						ws.style(i, 2).fontSize(9).set();
						ws.value(i, 3, convertDouble(stpCalc.getCumulative_units()));
						ws.style(i, 3).fontSize(9).set();
						ws.value(i, 4, stpCalc.getCash_flow());
						ws.style(i, 4).fontSize(9).set();
						ws.value(i, 5, stpCalc.getAmount());
						ws.style(i, 5).fontSize(9).set();
						ws.value(i, 6, convertDouble(stpCalc.getCapital_gain()));
						ws.style(i, 6).fontSize(9).set();
						ws.value(i, 7, stpCalc.getNo_of_days());
						ws.style(i, 7).fontSize(9).set();
						ws.value(i, 8, convertDouble(stpCalc.getCurrent_value()));
						ws.style(i++, 8).fontSize(9).set();
					}
					
					
					ws.value(i, 0, "");
					ws.style(i, 0).bold().fontSize(9).set();
					ws.range(i, 0, i++, 9).merge();
					
					ws.value(i, 0, to_scheme);
					ws.style(i, 0).bold().fontSize(9).set();
					ws.range(i, 0, i++, 9).merge();
					
					
					for(j = 0; j < 7; j++) {
						ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
						ws.width(j, 12);
					}
					
					ws.value(i, 0, "Nav Date");
					ws.value(i, 1, "Nav");
					ws.value(i, 2, "Units");
					ws.value(i, 3, "Cumulative Units");
					ws.value(i, 4, "Cash Flow");
					ws.value(i, 5, "Amount");
					ws.value(i++, 6, "Current Value");
					
					for(STPCalcResponse stpCalc: list.getTo_scheme_list()){
						ws.value(i, 0, sdf.format(stpCalc.getNav_date()));
						ws.style(i, 0).fontSize(9).set();
						ws.value(i, 1, convertDouble(stpCalc.getNav()));
						ws.style(i, 1).fontSize(9).wrapText(true).set();
						ws.value(i, 2, convertDouble(stpCalc.getUnits()));
						ws.style(i, 2).fontSize(9).set();
						ws.value(i, 3, convertDouble(stpCalc.getCumulative_units()));
						ws.style(i, 3).fontSize(9).set();
						ws.value(i, 4, stpCalc.getCash_flow());
						ws.style(i, 4).fontSize(9).set();
						ws.value(i, 5, stpCalc.getAmount());
						ws.style(i, 5).fontSize(9).set();
						ws.value(i, 6, convertDouble(stpCalc.getCurrent_value()));
						ws.style(i++, 6).fontSize(9).set();
					}
		
					String requestURL = "/mutual-funds-research/mutualFundStpInvestmentCalculator?amc="+amc+"&from_scheme="+from_scheme+"&to_scheme="+to_scheme+"&intial_amount="+initial_amount+"&stp_date="+stp_date+"&transfer_amount="+transfer_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date+"&lumpsum_option="+lumpsum_option+"&lumpsum_year="+lumpsum_year;
					LogDownload logDownload = new LogDownload();
					logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
					logDownload.setEmail(accountMap.get("email"));
					logDownload.setTitle("Mutual Fund STP Calculator");
					logDownload.setRequest(requestURL);
					logDownload.setCreate_date(new Date());
					logDownload.setClient_name("dakshin");
					commonDao.saveDownloadLog(logDownload);
					
					wb.finish();
				}
				else
				{
					PrintWriter out = response.getWriter();
					response.setContentType("application/vnd.ms-excel");
					response.setCharacterEncoding("UTF-8");
				}
			}
			/*
			 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
			 */
		}
		catch(Exception ex)
		{
			System.err.println("Exception occured in ---->"+requestUrl + "?" + queryString);
			ex.printStackTrace();
		}
		
	}
	
	@RequestMapping(value="/topSwpFunds")
	public void topSwpFunds(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		String requestUrl = request.getRequestURL().toString();
		String queryString = request.getQueryString();
		try
		{
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
			if(accountMap != null)
			{
				
				/*
				 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
				 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
				 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
				 * apiCommonResponse = new ApiCommonResponse();
				 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
				 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
				 * FailureMessage); apiCommonResponse.
				 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
				 * );
				 * 
				 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
				 * response.setContentType("application/json");
				 * response.setCharacterEncoding("UTF-8");
				 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
				 */
			
				String amc = request.getParameter("amc");
	            String category = request.getParameter("category");
	            String initial_amount = request.getParameter("intial_amount");
	            String swp_date = request.getParameter("swp_date");
	            String withdrawal_amount = request.getParameter("withdrawal_amount");
	            String period = request.getParameter("period");
	            String from_date = request.getParameter("from_date");
	            String to_date = request.getParameter("to_date");
	            String init_start_date = request.getParameter("init_start_date");
	            String download = request.getParameter("download");
	            
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
	    		if(download == null){download= "";}
	            
	            amc = amc.trim();
	            category = category.trim();
	            initial_amount = initial_amount.trim();
	            swp_date = swp_date.trim();
	            withdrawal_amount = withdrawal_amount.trim();
	            period = period.trim();
	            from_date = from_date.trim();
	            to_date = to_date.trim();
	    		download = download.trim();
	    		
	    		if(download.equalsIgnoreCase("yes"))
	    		{
	            
		            response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition", "attachment;filename=Top-SWP-Funds-Report.xlsx");
						
					// Create new Excel workbook and sheet
					Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
					Worksheet ws = wb.newWorksheet("Top SWP Funds Report");
					
					/*ws.value(0, 0, "advisorkhoj");
					ws.style(0, 0).bold().fontSize(9).set();
					ws.range(0, 0, 0, 7).merge();*/
					
					
					ws.value(1, 0, "Top SWP Funds");
					ws.range(1, 0, 1, 7).merge();
					ws.style(1, 0).bold().fontSize(11).horizontalAlignment("center").set();
					
					displayFiltervalue(ws, "AMC: "+amc, "Category: "+category, "", "", 2);
					displayFiltervalue(ws, "Lumpsum Amount: "+initial_amount, "Withdrawal Amount: "+withdrawal_amount, "", "", 3);
					displayFiltervalue(ws, "SWP Date: "+swp_date, "Period: "+period, "",  "", 4);
					displayFiltervalue(ws, "SWP Start Date: "+from_date, "SWP End Date: "+to_date, "", "", 5);
		            
		            String formattedUrl, result = "";
		            
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
			     	//request.setAttribute("swp_funds_list", list.getList());
			 		
			 		ws.width(0, 35);
			 		ws.width(1, 10);
			 		ws.width(2, 10);
			 		ws.width(3, 12);
			 		ws.width(4, 10);
			 		ws.width(5, 10);
			 		ws.width(6, 10);
			 		ws.width(7, 10);
			 		
			 		int i = 6;
			 		int j = 0;
			 		for(j = 0; j < 8; j++) {
						ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
						
					}
					
					ws.value(i, 0, "Scheme Name");
					ws.value(i, 1, "Launch Date");
					ws.value(i, 2, "Lumpsum Amount");
					ws.value(i, 3, "Withdrawal Period");
					ws.value(i, 4, "No of "+period+"Installments");
					ws.value(i, 5, "Total Withdrawal Amount");
					ws.value(i, 6, "Current Value");
					ws.value(i++, 7, "Return (%)");
					
					for(TopSWPFundsResponse swpFund: list.getList()){
						ws.value(i, 0, swpFund.getScheme_name());
						ws.style(i, 0).fontSize(9).set();
						ws.value(i, 1, sdf.format(swpFund.getInception_date()));
						ws.style(i, 1).fontSize(9).wrapText(true).set();
						ws.value(i, 2, initial_amount);
						ws.style(i, 2).fontSize(9).set();
						ws.value(i, 3, sdf.format(swpFund.getStart_date())+"\t to\n"+sdf.format(swpFund.getEnd_date()));
						ws.style(i, 3).fontSize(9).wrapText(true).set();
						ws.value(i, 4, swpFund.getNo_of_installments());
						ws.style(i, 4).fontSize(9).set();
						ws.value(i, 5, swpFund.getTotal_withdrawal_amount());
						ws.style(i, 5).fontSize(9).set();
						ws.value(i, 6, swpFund.getCurrent_value());
						ws.style(i, 6).fontSize(9).set();
						ws.value(i, 7, swpFund.getReturns());
						ws.style(i++, 7).fontSize(9).set();
					}
					
					String requestURL = "/mutual-funds-research/topSwpFunds?amc="+amc+"&category="+category+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
					LogDownload logDownload = new LogDownload();
					logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
					logDownload.setEmail(accountMap.get("email"));
					logDownload.setTitle("Top SWP Funds");
					logDownload.setRequest(requestURL);
					logDownload.setCreate_date(new Date());
					logDownload.setClient_name("dakshin");
					commonDao.saveDownloadLog(logDownload);
					
					wb.finish();
	    		}
	    		else
	    		{
	    			PrintWriter out = response.getWriter();
	    			response.setContentType("application/vnd.ms-excel");
	    			response.setCharacterEncoding("UTF-8");
	    		}
	    	}
			/*
			 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
			 */
		}
		catch(Exception ex)
		{
			System.err.println("Exception occured in ---->"+requestUrl + "?" + queryString);
			ex.printStackTrace();
			
		}
	}
	
	@RequestMapping(value="/mutualFundSwpInvestmentCalculator")
	public void mutualFundSwpInvestmentCalculator(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		String requestUrl = request.getRequestURL().toString();
		String queryString = request.getQueryString();
		try
		{
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
			if(accountMap != null)
			{
				
				/*
				 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
				 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
				 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
				 * apiCommonResponse = new ApiCommonResponse();
				 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
				 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
				 * FailureMessage); apiCommonResponse.
				 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
				 * );
				 * 
				 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
				 * response.setContentType("application/json");
				 * response.setCharacterEncoding("UTF-8");
				 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
				 */
			
				String amc = request.getParameter("amc");
	            String scheme_name = request.getParameter("scheme_name");
	            String initial_amount = request.getParameter("intial_amount");
	            String swp_date = request.getParameter("swp_date");
	            String withdrawal_amount = request.getParameter("withdrawal_amount");
	            String period = request.getParameter("period");
	            String from_date = request.getParameter("from_date");
	            String to_date = request.getParameter("to_date");
	            String init_start_date = request.getParameter("init_start_date");
	            String download = request.getParameter("download");
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
	    		if(download == null){download= "";}
	            
	            amc = amc.trim();
	            scheme_name = scheme_name.trim();
	            scheme = scheme.trim();
	            initial_amount = initial_amount.trim();
	            swp_date = swp_date.trim();
	            withdrawal_amount = withdrawal_amount.trim();
	            period = period.trim();
	            from_date = from_date.trim();
	            to_date = to_date.trim();
	    		download = download.trim();
	    		
	    		if(download.equalsIgnoreCase("yes"))
	    		{
	            
		            response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition", "attachment;filename=Mutual-Fund-SWP-Calculator-Report.xlsx");
					
					// Create new Excel workbook and sheet
					Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
					Worksheet ws = wb.newWorksheet("Mutual Fund SWP Calculator Report");
					
					/*ws.value(0, 0, "advisorkhoj");
					ws.style(0, 0).bold().fontSize(9).set();
					ws.range(0, 0, 0, 6).merge();*/
					
					String name = "";
					if(!scheme.equals("")){
						name = "Mutual Fund SWP Calculator "+scheme;
					}else{
						name = "Mutual Fund SWP Calculator";
					}
					
					ws.value(1, 0, name);
					ws.range(1, 0, 1, 6).merge();
					ws.style(1, 0).bold().fontSize(11).horizontalAlignment("center").set();
					
					displayFiltervalue(ws, "AMC:", amc, "Scheme:", scheme_name, 2);
					displayFiltervalue(ws, "Lumpsum Amount:", initial_amount, "Lumpsum Amount Investement Date:", init_start_date, 3);
					displayFiltervalue(ws, "Withdrawal Amount", withdrawal_amount, "SWP Date:", swp_date, 4);
					displayFiltervalue(ws, "Period", period, "SWP Start Date:", to_date, 5);
					displayFiltervalue(ws, "SWP Start Date", from_date, "","", 6);
		            
		            String formattedUrl, result = "";
		            HashMap<String, String> hashMap = new HashMap<String, String>();
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
			 		
			 		ws.value(7, 0, "");
					ws.style(7, 0).bold().fontSize(9).set();
					ws.range(7, 0, 7, 9).merge();
					
					ws.value(8, 0, "Systematic Withdrawal Plan Calculator");
					ws.style(8, 0).bold().fontSize(9).set();
					ws.range(8, 0, 8, 9).merge();
			 		
			 		ws.width(0, 40);
			 		int i = 9;
			 		int j = 0;
			 		for(j = 0; j < 6; j++) {
						ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
						ws.width(j+1, 12);
					}
					
					ws.value(i, 0, "Scheme");
					ws.value(i, 1, "Withdrawal Period");
					ws.value(i, 2, "No of "+period+" Installments");
					ws.value(i, 3, "Total Withdrawal Amount");
					ws.value(i, 4, "Current Value as on "+list.getScheme_current_value_date());
					ws.value(i++, 5, "Return (%)");
					
					ws.value(i, 0, scheme_name);
					ws.style(i, 0).fontSize(9).set();
					ws.value(i, 1, from_date+"to\n"+to_date);
					ws.style(i, 1).fontSize(9).wrapText(true).set();
					ws.value(i, 2, list.getScheme_installment());
					ws.style(i, 2).fontSize(9).set();
					ws.value(i, 3, list.getScheme_total_withdrawal_amount());
					ws.style(i, 3).fontSize(9).wrapText(true).set();
					ws.value(i, 4, roundOffNumber(list.getScheme_current_value()));
					ws.style(i, 4).fontSize(9).set();
					ws.value(i, 5, list.getScheme_returns());
					ws.style(i++, 5).fontSize(9).set();
					
					//scheme details
					ws.value(i, 0, "");
					ws.style(i, 0).bold().fontSize(9).set();
					ws.range(i, 0, i++, 9).merge();
					
					ws.value(i, 0, scheme_name);
					ws.style(i, 0).bold().fontSize(9).set();
					ws.range(i, 0, i++, 9).merge();
					
					
					for(j = 0; j < 9; j++) {
						ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
						ws.width(j, 12);
					}
					
					ws.value(i, 0, "Nav Date");
					ws.value(i, 1, "Nav");
					ws.value(i, 2, "Units");
					ws.value(i, 3, "Cumulative Units");
					ws.value(i, 4, "Cash Flow");
					ws.value(i, 5, "Net Amount");
					ws.value(i, 6, "Capital Gain/Loss");
					ws.value(i, 7, "No. of Days (Invested)");
					ws.value(i++, 8, "Current Value");
					
					for(STPCalcResponse stpCalc: list.getScheme_list()){
						ws.value(i, 0, sdf.format(stpCalc.getNav_date()));
						ws.style(i, 0).fontSize(9).set();
						ws.value(i, 1, fourDecimal(stpCalc.getNav()));
						ws.style(i, 1).fontSize(9).wrapText(true).set();
						ws.value(i, 2, fourDecimal(stpCalc.getUnits()));
						ws.style(i, 2).fontSize(9).set();
						ws.value(i, 3, fourDecimal(stpCalc.getCumulative_units()));
						ws.style(i, 3).fontSize(9).set();
						ws.value(i, 4, stpCalc.getCash_flow());
						ws.style(i, 4).fontSize(9).set();
						ws.value(i, 5, stpCalc.getAmount());
						ws.style(i, 5).fontSize(9).set();
						ws.value(i, 6, convertDouble(stpCalc.getCapital_gain()));
						ws.style(i, 6).fontSize(9).set();
						ws.value(i, 7, stpCalc.getNo_of_days());
						ws.style(i, 7).fontSize(9).set();
						ws.value(i, 8, roundOffNumber(stpCalc.getCurrent_value()));
						ws.style(i++, 8).fontSize(9).set();
					}
					
					String requestURL = "/mutual-funds-research/mutualFundSwpInvestmentCalculator?amc="+amc+"&scheme_name="+scheme_name+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
					LogDownload logDownload = new LogDownload();
					logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
					logDownload.setEmail(accountMap.get("email"));
					logDownload.setTitle("Mutual Fund SWP Calculator - "+amc);
					logDownload.setRequest(requestURL);
					logDownload.setCreate_date(new Date());
					logDownload.setClient_name("dakshin");
					commonDao.saveDownloadLog(logDownload);
					
			 		wb.finish();
	    		}
	    		else
	    		{
	    			PrintWriter out = response.getWriter();
	    			response.setContentType("application/vnd.ms-excel");
	    			response.setCharacterEncoding("UTF-8");
	    		}
	    	}
			/*
			 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
			 */
		}
		catch(Exception ex)
		{
			System.err.println("Exception occured in ---->"+requestUrl + "?" + queryString);
			ex.printStackTrace();
			
		}
		
	}
	
	@RequestMapping(value="/downloadFixedDepositVsDebtFunds")
	public void downloadFixedDepositVsDebtFunds(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		String requestUrl = request.getRequestURL().toString();
		String queryString = request.getQueryString();
		try
		{
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
			if(accountMap != null)
			{
				
				/*
				 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
				 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
				 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
				 * apiCommonResponse = new ApiCommonResponse();
				 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
				 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
				 * FailureMessage); apiCommonResponse.
				 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
				 * );
				 * 
				 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
				 * response.setContentType("application/json");
				 * response.setCharacterEncoding("UTF-8");
				 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
				 */
			
				String amc = request.getParameter("amc");
	    		String category = request.getParameter("category");
	    		String amount = request.getParameter("amount");
	    		String start_date = request.getParameter("start_date");
	    		String end_date = request.getParameter("end_date");
	    		String tax_rate = request.getParameter("tax_rate");
	    		String scheme = request.getParameter("scheme");
	    		String download = request.getParameter("download");
	    		
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
	    		if(download == null){download= "";}
	            
	            amc = amc.trim();
	            category = category.trim();
	            scheme = scheme.trim();
	            amount = amount.trim();
	            start_date = start_date.trim();
	            end_date = end_date.trim();
	            tax_rate = tax_rate.trim();
	    		download = download.trim();
	    		
	    		if(download.equalsIgnoreCase("yes"))
	    		{
	            
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
			 		FDvsDebtResponse fDvsDebtResponse = list.getfDvsDebtResponse();
				    
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
		            
		            response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition", "attachment;filename=Debt-Funds-vs-Fixed-Deposit-Report.xlsx");
					
					// Create new Excel workbook and sheet
					Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
					Worksheet ws = wb.newWorksheet("Debt Funds vs Fixed Deposit");
					
					/*ws.value(0, 0, "advisorkhoj");
					ws.style(0, 0).bold().fontSize(9).set();
					ws.range(0, 0, 0, 5).merge();*/
					
					
					ws.value(1, 0, "Debt Funds / Hybrid Debt Funds vs Fixed Deposit");
					ws.range(1, 0, 1, 5).merge();
					ws.style(1, 0).bold().fontSize(11).horizontalAlignment("center").set();
					
					ws.value(2, 0, "scheme:- "+scheme);
					ws.range(2, 0, 2, 5).merge();
					ws.style(2, 0).bold().fontSize(9).horizontalAlignment("left").set();
					
					ws.value(3, 0, "Start Date:- "+start_date);
					ws.range(3, 0, 3, 5).merge();
					ws.style(3, 0).bold().fontSize(9).wrapText(true).horizontalAlignment("left").set();
					
					ws.value(4, 0, "End Date:- "+end_date);
					ws.range(4, 0, 4, 5).merge();
					ws.style(4, 0).bold().fontSize(9).horizontalAlignment("left").set();
					
					ws.value(5, 0, "Category:- "+category);
					ws.range(5, 0, 5, 5).merge();
					ws.style(5, 0).bold().fontSize(9).horizontalAlignment("left").set();
					
					ws.value(6, 0, "AMC:- "+amc);
					ws.range(6, 0, 6, 5).merge();
					ws.style(6, 0).bold().fontSize(9).horizontalAlignment("left").set();
					
					ws.value(7, 0, "Income Tax Rate:- "+tax_rate);
					ws.range(7, 0, 7, 5).merge();
					ws.style(7, 0).bold().fontSize(9).horizontalAlignment("left").set();
								
			 		int i = 8;
			 		ws.width(0, 25);
			 		ws.width(1, 10);
			 		ws.width(2, 10);
			 		ws.width(3, 10);
			 		ws.width(4, 10);
			 		ws.width(5, 10);
					
			 		if(!fDvsDebtResponse.equals("")){
			 			ws.value(i, 0, "Pre-Tax Return");
						ws.style(i, 0).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
						ws.value(i, 1, "Investment Amount");
						ws.style(i, 1).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
						ws.value(i, 2, "Redeemed / Maturity Amount");
						ws.style(i, 2).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
						ws.value(i, 3, "Total Interest / Profit Amount");
						ws.style(i, 3).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
						ws.value(i, 4, "Annual Interest / Return (%)");
						ws.style(i++, 4).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
						
						ws.value(i, 0, "Fixed Deposit");
						ws.style(i, 0).fontSize(9).wrapText(true).set();
						ws.value(i, 1, amount);
						ws.style(i, 1).fontSize(9).wrapText(true).set();
						ws.value(i, 2, roundOffNumber(fDvsDebtResponse.getFd_investment_value()));
						ws.style(i, 2).fontSize(9).wrapText(true).set();
						ws.value(i, 3, roundOffNumber((fDvsDebtResponse.getFd_investment_value() - Double.parseDouble(amount))));
						ws.style(i, 3).fontSize(9).wrapText(true).set();
						ws.value(i, 4, fDvsDebtResponse.getFd_annualized_return());
						ws.style(i++, 4).fontSize(9).wrapText(true).set();
						
						ws.value(i, 0, fDvsDebtResponse.getScheme());
						ws.style(i, 0).fontSize(9).wrapText(true).set();
						ws.value(i, 1, amount);
						ws.style(i, 1).fontSize(9).wrapText(true).set();
						ws.value(i, 2, roundOffNumber(fDvsDebtResponse.getScheme_investment_value()));
						ws.style(i, 2).fontSize(9).wrapText(true).set();
						ws.value(i, 3, roundOffNumber((fDvsDebtResponse.getScheme_investment_value() - Double.parseDouble(amount))));
						ws.style(i, 3).fontSize(9).wrapText(true).set();
						ws.value(i, 4, fDvsDebtResponse.getScheme_annualized_return());
						ws.style(i++, 4).fontSize(9).wrapText(true).set();
			 		}
			 		
					ws.value(i, 0, "");
					ws.range(i, 0, i++, 5).merge();
			 		
			 		ws.value(i, 0, "Post Tax Return");
					ws.style(i, 0).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					ws.value(i, 1, "Pre-tax Interest / Profit Amount");
					ws.style(i, 1).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					ws.value(i, 2, "Capital Gains Tax");
					ws.style(i, 2).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					ws.value(i, 3, "Indexed Amount");
					ws.style(i, 3).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					ws.value(i, 4, "Income / Capital Gains Tax");
					ws.style(i, 4).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					ws.value(i, 5, "Post Tax Interest / Profit Amount");
					ws.style(i++, 5).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					
					ws.value(i, 0, "Fixed Deposit");
					ws.style(i, 0).fontSize(9).wrapText(true).set();
					ws.value(i, 1, roundOffNumber(fDvsDebtResponse.getFd_investment_value() - Double.parseDouble(amount)));
					ws.style(i, 1).fontSize(9).wrapText(true).set();
					ws.value(i, 2, "Not Applicable");
					ws.style(i, 2).fontSize(9).wrapText(true).set();
					ws.value(i, 3, "Not Applicable");
					ws.style(i, 3).fontSize(9).wrapText(true).set();
					ws.value(i, 4, roundOffNumber(fDvsDebtResponse.getFd_income_tax()));
					ws.style(i, 4).fontSize(9).wrapText(true).set();
					ws.value(i, 5, roundOffNumber(fDvsDebtResponse.getPost_tax_fd_investment_value() - Double.parseDouble(amount)));
					ws.style(i++, 5).fontSize(9).wrapText(true).set();
					
					ws.value(i, 0, fDvsDebtResponse.getScheme());
					ws.style(i, 0).fontSize(9).wrapText(true).set();
					ws.value(i, 1, fDvsDebtResponse.getScheme_investment_value() - Double.parseDouble(amount));
					ws.style(i, 1).fontSize(9).wrapText(true).set();
					
					if(years > 3){
						ws.value(i, 2, "Long Term");
						ws.style(i, 2).fontSize(9).wrapText(true).set();
						ws.value(i, 3, roundOffNumber(fDvsDebtResponse.getScheme_indexed_cost_of_purchase()));
						ws.style(i, 3).fontSize(9).wrapText(true).set();
					}else{
						ws.value(i, 2, "Short Term");
						ws.style(i, 2).fontSize(9).wrapText(true).set();
						ws.value(i, 3, "Not Applicable");
						ws.style(i, 3).fontSize(9).wrapText(true).set();
					}
		
					ws.value(i, 4, roundOffNumber(fDvsDebtResponse.getScheme_income_tax()));
					ws.style(i, 4).fontSize(9).wrapText(true).set();
					ws.value(i, 5, roundOffNumber(fDvsDebtResponse.getPost_tax_scheme_investment_value() - Double.parseDouble(amount)));
					ws.style(i++, 5).fontSize(9).wrapText(true).set();
					
					/*ws.value(i, 0, "NAV Date");
					ws.style(i, 0).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					ws.value(i, 1, "NAV (Rs)");
					ws.style(i++, 1).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
					
					
					for(NavResponse navResponse: historicalNavAPIResponse.getList()){
						ws.value(i, 0, sdf.format(navResponse.getNav_date()));
						ws.style(i, 0).fontSize(9).wrapText(true).set();
						ws.value(i, 1, navResponse.getNet_asset_value());
						ws.style(i++, 1).fontSize(9).wrapText(true).set();
					}*/
					
					String requestURL = "/mutual-funds-research/downloadFixedDepositVsDebtFunds?scheme="+scheme+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&category="+category+"&amc="+amc;
					LogDownload logDownload = new LogDownload();
					logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
					logDownload.setEmail(accountMap.get("email"));
					logDownload.setTitle("Debt Funds / Hybrid Debt Funds vs Fixed Deposit");
					logDownload.setRequest(requestURL);
					logDownload.setCreate_date(new Date());
					logDownload.setClient_name("dakshin");
					commonDao.saveDownloadLog(logDownload);
					
					wb.finish();
	    		}
	    		else
	    		{
	    			PrintWriter out = response.getWriter();
	    			response.setContentType("application/vnd.ms-excel");
	    			response.setCharacterEncoding("UTF-8");
	    		}
	    	}
			/*
			 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
			 */
		}
		catch(Exception ex)
		{
			System.err.println("Exception occured in ---->"+requestUrl + "?" + queryString);
			ex.printStackTrace();
			
		}
	}
	
	@RequestMapping(value="/downloadLiquidFundsVsSavingsBankXl")
	public void downloadLiquidFundsVsSavingsBankXl(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		
		HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
		if(accountMap != null)
		{
			
			/*
			 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
			 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
			 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
			 * apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.
			 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
			 * );
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
			 */
		
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
			String download = request.getParameter("download");
			
			if(amc == null){amc = "ICICI Prudential Mutual Fund";}
			if(category == null){category = "Debt: Liquid";}
			if(scheme == null || StringHelper.isEmpty(scheme)){scheme = "ICICI Prudential Liquid Fund - Growth";}
			if(amount == null || StringHelper.isEmpty(amount) || !amount.matches("[0-9]+")){amount = "100000";}
			if(start_date == null || StringHelper.isEmpty(start_date)){start_date = start_date_str;}
			if(end_date == null || StringHelper.isEmpty(end_date)){end_date = end_date_str;}
	        if(tax_rate == null || StringHelper.isEmpty(tax_rate) || !tax_rate.matches("[0-9]+")){tax_rate = "30";}
	        if(savings_rate == null || StringHelper.isEmpty(savings_rate) || !savings_rate.matches("[0-9]+")){savings_rate = "4";}	
			if(download == null){download= "";}
	        
	        amc = amc.trim();
	        category = category.trim();
	        scheme = scheme.trim();
	        amount = amount.trim();
	        start_date = start_date.trim();
	        end_date = end_date.trim();
	        tax_rate = tax_rate.trim();
	        savings_rate = savings_rate.trim();
			download = download.trim();
			
			if(download.equalsIgnoreCase("yes"))
			{
	        
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
				
		     	response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", "attachment;filename=Liquid-Funds-vs-Savings-Bank.xlsx");
				
				
				Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
				Worksheet ws = wb.newWorksheet("Liquid Funds vs Savings Bank Report");
				
				ws.width(0, 30);
				ws.width(1, 10);
				ws.width(2, 10);
				ws.width(3, 10);
				ws.width(4, 10);
				ws.width(5, 10);
				ws.width(6, 10);
		
				ws.value(0, 0, "Liquid Funds vs Savings Bank");
				ws.range(0, 0, 0, 5).merge();
				ws.range(0, 0, 0, 5).style().horizontalAlignment("center").set();
				ws.style(0, 0).bold().fontSize(11).set(); 
				
				ws.value(1, 0, "Start Date: "+start_date);
				ws.range(1, 0, 1, 5).style().bold().fontSize(9).horizontalAlignment("left").merge().set();
				
				ws.value(2, 0, "End Date: "+end_date);
				ws.range(2, 0, 2, 5).style().bold().fontSize(9).horizontalAlignment("left").merge().set();
				
				ws.value(3, 0, "Category: "+category);
				ws.range(3, 0, 3, 5).style().bold().fontSize(9).horizontalAlignment("left").merge().set();
				
				ws.value(4, 0, "AMC: "+amc);
				ws.range(4, 0, 4, 5).style().bold().fontSize(9).horizontalAlignment("left").merge().set();
				
				ws.value(5, 0, "Income Tax Rate: "+tax_rate);
				ws.range(5, 0, 5, 5).style().bold().fontSize(9).horizontalAlignment("left").merge().set();
				
				ws.value(6, 0, "Savings Bank Interest Rate: "+savings_rate);
				ws.range(6, 0, 6, 5).style().bold().fontSize(9).horizontalAlignment("left").merge().set();
											
				int i = 7;
				int j = 0;
				for(j = 0; j <= 6; j++) {
					ws.style(i, j).bold().fontSize(9).wrapText(true).set();	
				}
								
				FDvsDebtResponse fDvsDebtResponse = schemePerformancesList.getfDvsDebtResponse();
				
				if(fDvsDebtResponse != null)
				{
					ws.value(i, 0, "Pre-Tax Return");
					ws.style(i, 0).horizontalAlignment("left").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
			        ws.value(i, 1, "Investment Amount");
			        ws.style(i, 1).horizontalAlignment("center").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				    ws.value(i, 2, "Redeemed / Maturity Amount");
				    ws.style(i, 2).horizontalAlignment("center").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				    ws.value(i, 3, "Total Interest / Profit Amount");
				    ws.style(i, 3).horizontalAlignment("center").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				    ws.value(i, 4, "Annual Interest / Return (%)");
				    ws.style(i++, 4).horizontalAlignment("center").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				    
				    
				    ws.value(i, 0, "Savings Bank Deposit");
					ws.style(i, 0).fontSize(9).horizontalAlignment("left").wrapText(true).set();
					
					ws.value(i, 1, amount);
					ws.style(i, 1).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 2, fDvsDebtResponse.getFd_investment_value());
					ws.style(i, 2).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 3, fDvsDebtResponse.getFd_investment_value() - Double.parseDouble(amount));
					ws.style(i, 3).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 4, fDvsDebtResponse.getFd_annualized_return());
					ws.style(i++, 4).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					
					ws.value(i, 0, fDvsDebtResponse.getScheme());
					ws.style(i, 0).fontSize(9).horizontalAlignment("left").wrapText(true).set();
					
					ws.value(i, 1, amount);
					ws.style(i, 1).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 2, fDvsDebtResponse.getScheme_investment_value());
					ws.style(i, 2).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 3, fDvsDebtResponse.getScheme_investment_value() - Double.parseDouble(amount));
					ws.style(i, 3).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 4, fDvsDebtResponse.getScheme_annualized_return());
					ws.style(i++, 4).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
				}	
		
				ws.value(i, 0, "");
				ws.style(i, 0).fontSize(9).horizontalAlignment("left").wrapText(true).set();
				
				ws.value(i, 1, "");
				ws.style(i, 1).fontSize(9).horizontalAlignment("left").wrapText(true).set();
				
				ws.value(i, 2, "");
				ws.style(i++, 2).fontSize(9).horizontalAlignment("left").wrapText(true).set();
				
				
				if(fDvsDebtResponse != null)
				{
					ws.value(i, 0, "Post Tax Return");
					ws.style(i, 0).horizontalAlignment("left").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
			        ws.value(i, 1, "Pre-tax Interest / Profit Amount");
			        ws.style(i, 1).horizontalAlignment("center").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				    ws.value(i, 2, "Capital Gains Tax");
				    ws.style(i, 2).horizontalAlignment("center").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				    ws.value(i, 3, "Indexed Amount");
				    ws.style(i, 3).horizontalAlignment("center").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				    ws.value(i, 4, "Income / Capital Gains Tax");
				    ws.style(i, 4).horizontalAlignment("center").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				    ws.value(i, 5, "Post Tax Interest / Profit Amount");
				    ws.style(i++, 5).horizontalAlignment("center").fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();
				    
				    ws.value(i, 0, "Savings Bank Deposit");
					ws.style(i, 0).fontSize(9).horizontalAlignment("left").wrapText(true).set();
					
					ws.value(i, 1, fDvsDebtResponse.getFd_investment_value() - Double.parseDouble(amount));
					ws.style(i, 1).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 2, "Not Applicable");
					ws.style(i, 2).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 3, "Not Applicable");
					ws.style(i, 3).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 4, "0");
					ws.style(i, 4).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 5, fDvsDebtResponse.getFd_investment_value() - Double.parseDouble(amount));
					ws.style(i++, 5).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					
					ws.value(i, 0, fDvsDebtResponse.getScheme());
					ws.style(i, 0).fontSize(9).horizontalAlignment("left").wrapText(true).set();
					
					ws.value(i, 1, fDvsDebtResponse.getScheme_investment_value() - Double.parseDouble(amount));
					ws.style(i, 1).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					if(years > 3)
					{
						ws.value(i, 2, "Long Term");
						ws.style(i, 2).fontSize(9).horizontalAlignment("center").wrapText(true).set();
						
						ws.value(i, 3, fDvsDebtResponse.getScheme_indexed_cost_of_purchase());
						ws.style(i, 3).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					}	
					else
					{
						ws.value(i, 2, "Short Term");
						ws.style(i, 2).fontSize(9).horizontalAlignment("center").wrapText(true).set();
						
						ws.value(i, 3, "Not Applicable");
						ws.style(i, 3).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					}	
					
					ws.value(i, 4, fDvsDebtResponse.getScheme_income_tax());
					ws.style(i, 4).fontSize(9).horizontalAlignment("center").wrapText(true).set();
					
					ws.value(i, 5, fDvsDebtResponse.getPost_tax_scheme_investment_value() - Double.parseDouble(amount));
					ws.style(i++, 5).fontSize(9).horizontalAlignment("center").wrapText(true).set();
				}
				
				String requestURL = "/mutual-funds-research/downloadLiquidFundsVsSavingsBankXl?scheme="+scheme+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&savings_rate="+savings_rate+"&category="+category+"&amc="+amc;
				LogDownload logDownload = new LogDownload();
				logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
				logDownload.setEmail(accountMap.get("email"));
				logDownload.setTitle("Liquid Funds vs Savings Bank");
				logDownload.setRequest(requestURL);
				logDownload.setCreate_date(new Date());
				logDownload.setClient_name("dakshin");
				commonDao.saveDownloadLog(logDownload);
				
				wb.finish();
			}
			else
			{
				PrintWriter out = response.getWriter();
				response.setContentType("application/vnd.ms-excel");
				response.setCharacterEncoding("UTF-8");
			}
		}
		/*
		 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
		 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
		 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
		 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
		 * 
		 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
		 * response.setContentType("application/json");
		 * response.setCharacterEncoding("UTF-8");
		 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
		 */
	}
	
	@RequestMapping(value="/topDividendPayingMutualFunds")
	public void topDividendPayingMutualFunds(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		String requestUrl = request.getRequestURL().toString();
		String queryString = request.getQueryString();
		try
		{
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
			if(accountMap != null)
			{
				
				/*
				 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
				 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
				 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
				 * apiCommonResponse = new ApiCommonResponse();
				 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
				 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
				 * FailureMessage); apiCommonResponse.
				 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
				 * );
				 * 
				 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
				 * response.setContentType("application/json");
				 * response.setCharacterEncoding("UTF-8");
				 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
				 */
			
				String category = request.getParameter("category");
				String period = request.getParameter("period");
				String download = request.getParameter("download");
				
				if(category == null || StringHelper.isEmpty(category)){category="Equity: Multi Cap";}
				if(period == null || StringHelper.isEmpty(period) || !period.matches("[0-9]+")){period="3";}
				if(download == null){download= "";}

				category = category.trim();
				period = period.trim();
				download = download.trim();
				
				if(download.equalsIgnoreCase("yes"))
				{
				
					String scheme_category = category.replaceAll("-", " ");
					
					request.setAttribute("category", category);
					request.setAttribute("scheme_category", scheme_category);
					request.setAttribute("period", period);
					
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
					
		            String formattedUrl, result = "";
		            
		            HashMap<String, String> hashMap = new HashMap<String, String>();
		            hashMap.put("category", category);
		            hashMap.put("period", period);
			     	
		            formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getTopDividendPayingMutualFunds, hashMap);
			 		result = HttpPost.SendHttpPost(formattedUrl);
			 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
			 		TopDividendPayingMutualFundsApiResponse list = gson.fromJson(result, TopDividendPayingMutualFundsApiResponse.class);
			 		
			 		Calendar cal = Calendar.getInstance();
					Date end_date = cal.getTime();
		            
		            response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition", "attachment;filename=Top-Dividend-Paying-Mutual-Funds-Report.xlsx");
					
					// Create new Excel workbook and sheet
					Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
					Worksheet ws = wb.newWorksheet("Top Dividend Paying Mutual Funds Report");
					
					/*ws.value(0, 0, "advisorkhoj");
					ws.style(0, 0).bold().fontSize(9).set();
					ws.range(0, 0, 0, 7).merge();*/
					
					
					ws.value(1, 0, "Top Dividend Paying Mutual Funds - "+category);
					ws.range(1, 0, 1, 7).merge();
					ws.style(1, 0).bold().fontSize(11).horizontalAlignment("center").set();
					
					displayFiltervalue(ws, "Category:", category, "", "", 2);
					displayFiltervalue(ws, "Period:", period+" Years", "", "", 3);
		            
			 		ws.width(0, 45);
			 		ws.width(1, 10);
			 		ws.width(2, 25);
			 		ws.width(3, 15);
			 		
			 		int i = 4;
			 		int j = 0;
			 		for(j = 0; j < 4; j++) {
						ws.style(i, j).wrapText(true).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").set();	
					}
					
					ws.value(i, 0, "Scheme Name");
					ws.value(i, 1, "Launch Date");
					ws.value(i, 2, "Trailing "+period+" year Annual Dividend Yield (Distribution yield)");
					ws.value(i++, 3, "Period Range");
		
					for(DividendAnnualizedReturns dividendReturns: list.getList()){
						ws.value(i, 0, dividendReturns.getScheme_name());
						ws.style(i, 0).fontSize(9).set();
						ws.value(i, 1, sdf.format(dividendReturns.getInception_date()));
						ws.style(i, 1).fontSize(9).wrapText(true).set();
						
						if(dividendReturns.getReturns() == 0){
							ws.value(i, 2, "");
							ws.style(i, 2).fontSize(9).set();
						}
						else{
							ws.value(i, 2, convertDouble((dividendReturns.getReturns() * 100))+"%");
							ws.style(i, 2).fontSize(9).set();
						}
						
						ws.value(i, 3, sdf.format(dividendReturns.getStart_date())+"\nTo "+sdf.format(end_date));
						ws.style(i++, 3).fontSize(9).wrapText(true).set();
					}
					
					String requestURL = "/mutual-funds-research/topDividendPayingMutualFunds?category="+category+"&period="+period;
					LogDownload logDownload = new LogDownload();
					logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
					logDownload.setEmail(accountMap.get("email"));
					logDownload.setTitle("Top Dividend Paying Mutual Funds");
					logDownload.setRequest(requestURL);
					logDownload.setCreate_date(new Date());
					logDownload.setClient_name("dakshin");
					commonDao.saveDownloadLog(logDownload);
					
					wb.finish();
				}
				else
				{
					PrintWriter out = response.getWriter();
					response.setContentType("application/vnd.ms-excel");
					response.setCharacterEncoding("UTF-8");
				}
			}
			/*
			 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
			 */
				
		}
		catch(Exception ex)
		{
			System.err.println("Exception occured in ---->"+requestUrl + "?" + queryString);
			ex.printStackTrace();
			
		}
	}
	
	@RequestMapping(value="/downloadAnnualIncrease")
	public void downloadAnnualIncrease(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		//SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		try 
		{
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
			if(accountMap != null)
			{
				
				/*
				 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
				 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
				 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
				 * apiCommonResponse = new ApiCommonResponse();
				 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
				 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
				 * FailureMessage); apiCommonResponse.
				 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
				 * );
				 * 
				 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
				 * response.setContentType("application/json");
				 * response.setCharacterEncoding("UTF-8");
				 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
				 */
				
				
				
				/*String scheme = "Aditya Birla Sun Life Frontline Equity Fund-Growth";
				String start_date = "01-01-2010";
				String end_date = sdf.format(new Date());
				String amount =  "5000";
				String frequency = "Monthly";
				String enhancementPercentage = "10";*/
				
				String scheme = request.getParameter("scheme");
				String start_date = request.getParameter("start_date");
				String end_date = request.getParameter("end_date");
				String amount =  request.getParameter("amount");
				String frequency = request.getParameter("frequency");
				String enhancementPercentage = request.getParameter("enhancement_percentage");
				String download = request.getParameter("download");
				String enhancementAmount = "500";
				
				if(download == null){download= "";}
				download = download.trim();
				
				if(download.equalsIgnoreCase("yes"))
				{
					
					int enhancement_amount = (Integer.parseInt(amount)/100) * Integer.parseInt(enhancementPercentage);
					
					/*request.setAttribute("scheme", scheme);
					request.setAttribute("start_date", start_date);
					request.setAttribute("end_date", end_date);
					request.setAttribute("amount", amount);
					request.setAttribute("frequency", frequency);
					request.setAttribute("enhancementPercentage", enhancementPercentage);
					request.setAttribute("enhancementAmount", enhancementAmount);*/
					
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
					/*if(list != null)
					{
						request.setAttribute("sipYearlyEnhancementResponse", list.getSipYearlyEnhancementResponse());
						request.setAttribute("sipNavResponseList", list.getSipNavResponseList());
					}*/
					
					// Create new Excel workbook and sheet
		           	HSSFWorkbook xlsWorkbook = new HSSFWorkbook();
				    HSSFSheet xlsSheet = xlsWorkbook.createSheet("PPF vs ELSS"); 
				    short rowIndex = 0;
				    
				    xlsSheet.setColumnWidth(0, 15);
				    
				    HSSFFont company_font = xlsWorkbook.createFont();
				    company_font.setFontHeightInPoints((short) 12);
				    company_font.setFontName("Arial");
				    company_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    company_font.setColor(HSSFColor.BLACK.index);
				    
				    HSSFFont heading_font = xlsWorkbook.createFont();
				    heading_font.setFontHeightInPoints((short) 20);
				    heading_font.setFontName("Calibri");
				    heading_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    heading_font.setColor(HSSFColor.RED.index);
				    
				    HSSFFont name_font = xlsWorkbook.createFont();
				    name_font.setFontHeightInPoints((short) 16);
				    name_font.setFontName("Calibri");
				    name_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    name_font.setColor(HSSFColor.RED.index);
				    
				    HSSFFont tiny_font = xlsWorkbook.createFont();
				    tiny_font.setFontHeightInPoints((short) 9);
				    tiny_font.setFontName("Arial");
				    
				    
				    HSSFFont tinysmall_font = xlsWorkbook.createFont();
				    tinysmall_font.setFontHeightInPoints((short) 9);
				    tinysmall_font.setFontName("Calibri");
				    
				    HSSFFont th_font = xlsWorkbook.createFont();
				    th_font.setFontHeightInPoints((short) 9);
				    th_font.setFontName("Calibri");
				    th_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    th_font.setColor(HSSFColor.WHITE.index);
				    
				    HSSFFont normal_font = xlsWorkbook.createFont();
				    normal_font.setFontHeightInPoints((short) 12);
				    normal_font.setFontName("Calibri");
				    
				    HSSFFont small_font = xlsWorkbook.createFont();
				    small_font.setFontHeightInPoints((short) 10);
				    small_font.setFontName("Calibri");
				    
				    HSSFFont blue_font = xlsWorkbook.createFont();
				    blue_font.setFontHeightInPoints((short) 12);
				    blue_font.setFontName("Calibri");
				    blue_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    blue_font.setColor(HSSFColor.LIGHT_BLUE.index);
				    
				    HSSFCellStyle th_style = xlsWorkbook.createCellStyle();
					HSSFPalette palette = xlsWorkbook.getCustomPalette();
					HSSFColor myColor = palette.findSimilarColor(214,216,250);
					short palIndex = myColor.getIndex();
					
					th_style.setFillForegroundColor(palIndex);  
					th_style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
					th_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
					th_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
					th_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
					th_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
					th_style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
					th_style.setWrapText(true);
					th_style.setFont(tiny_font);
					
					HSSFCellStyle th_style_1 = xlsWorkbook.createCellStyle();
					th_style_1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
					th_style_1.setWrapText(true);
					th_style_1.setFont(tiny_font);
				    
				    
				    HSSFCellStyle th_amount_style = xlsWorkbook.createCellStyle();
				    th_amount_style.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);
				    th_amount_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				    th_amount_style.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
				    th_amount_style.setFont(tinysmall_font);
				    
				    HSSFCellStyle th_cagr_style = xlsWorkbook.createCellStyle();
				    th_cagr_style.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);
				    th_cagr_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				    th_cagr_style.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
				    th_cagr_style.setFont(th_font);
				    
				    HSSFCellStyle th_style_right = xlsWorkbook.createCellStyle();
				    th_style_right.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
				    th_style_right.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);
				    th_style_right.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				    th_style_right.setFont(th_font);
				    
				    HSSFCellStyle footer_style = xlsWorkbook.createCellStyle();
				    footer_style.setAlignment(HSSFCellStyle.ALIGN_JUSTIFY);
				    footer_style.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
				    footer_style.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
				    footer_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				    footer_style.setFont(small_font);
				    
				    HSSFCellStyle td_style = xlsWorkbook.createCellStyle();
				    td_style.setWrapText(true);
				    td_style.setFont(tinysmall_font);
				    
				    
				    HSSFCellStyle td_style1 = xlsWorkbook.createCellStyle();
				    td_style1.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				    td_style1.setWrapText(true);
				    td_style1.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
				    td_style1.setFont(tinysmall_font);
				    
				    
				    HSSFCellStyle td_style_right = xlsWorkbook.createCellStyle();
				    td_style_right.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				    td_style_right.setWrapText(true);
				    td_style_right.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
				    td_style_right.setFont(tinysmall_font);
				    
				    HSSFCellStyle td_amount_style = xlsWorkbook.createCellStyle();
				    td_amount_style.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
				    td_amount_style.setFont(normal_font);
				    
				    HSSFCellStyle td_cagr_style = xlsWorkbook.createCellStyle();
				    td_cagr_style.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
				    td_cagr_style.setFont(normal_font);
				    
				    HSSFCellStyle blue_style = xlsWorkbook.createCellStyle();
				    blue_style.setFont(blue_font);
				    
				    HSSFRow row = xlsSheet.createRow(rowIndex++);
					HSSFCell cell = row.createCell(0);
					HSSFCellStyle style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(company_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 5));
					cell.setCellValue("SIP with Annual Increase of "+scheme);
					
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 5));
					cell.setCellValue("Installment Amount:- "+amount);
					
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 5));
					cell.setCellValue("Frequency:- "+frequency);
				
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 5));
					cell.setCellValue("Start Date:- "+start_date);
					
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 5));
					cell.setCellValue("End Date:- "+end_date);
					
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 5));
					cell.setCellValue("Yearly Enhancement(%):- "+enhancementPercentage);
					
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(th_style_1);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 5));
					cell.setCellValue("Note - "+enhancementPercentage+"% yearly enhancement is Rs "+enhancement_amount);
					
					row = xlsSheet.createRow(rowIndex++);
					row.setHeight((short)500);
		
				    cell = row.createCell(0);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(0);
				    xlsSheet.setColumnWidth(0, 16000);
				    cell.setCellValue("Scheme");
				    
				    cell = row.createCell(1);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(1);
				    xlsSheet.setColumnWidth(1, 3000);
				    cell.setCellValue("SIP Investment Cost");
				    
				    cell = row.createCell(2);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(2);
				    xlsSheet.setColumnWidth(2, 3000);
				    cell.setCellValue("SIP Value as on "+end_date);
				    
				    cell = row.createCell(3);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(3);
				    xlsSheet.setColumnWidth(3, 3000);
				    cell.setCellValue("Growth Amount");
				    
				    cell = row.createCell(4);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(4);
				    xlsSheet.setColumnWidth(4, 3000);
				    cell.setCellValue("Enhanced Growth Amount");
				    
				    cell = row.createCell(5);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(5);
				    xlsSheet.setColumnWidth(5, 3000);
				    cell.setCellValue("Enhanced Growth (%)");
				    
				    
				    HSSFCellStyle left_style = xlsWorkbook.createCellStyle();
				    left_style.setWrapText(true);
				    left_style.setFont(tinysmall_font);
				    left_style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
					
				  //request.setAttribute("rollingReturnsSummaryList", list.getRollingReturnsTable());
				    for (SipYearlyEnhancementResponse sipResponse : list.getSipYearlyEnhancementResponse()) 
					{
				    	
			    		row = xlsSheet.createRow(rowIndex++);
						cell = row.createCell(0);
					    cell.setCellStyle(left_style);
					    xlsSheet.autoSizeColumn(0);
					    xlsSheet.setColumnWidth(0, 16000);
					    cell.setCellValue(sipResponse.getScheme());
					    
					    cell = row.createCell(1);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(1);
					    xlsSheet.setColumnWidth(1, 3000);
					    cell.setCellValue(Double.parseDouble(sipResponse.getInvestmentAmount()));
					    
					    cell = row.createCell(2);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(2);
					    xlsSheet.setColumnWidth(2, 3000);
					    cell.setCellValue(Double.parseDouble(sipResponse.getInvestmentValue()));
					    
					    cell = row.createCell(3);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(3);
					    xlsSheet.setColumnWidth(3, 3000);
					    cell.setCellValue(Double.parseDouble(sipResponse.getSipGrowth()));
					    
					    
					    if(!sipResponse.getEnhancementGrowthPercent().equals("-")){
					    	 cell = row.createCell(4);
							 cell.setCellStyle(td_style);
							 xlsSheet.autoSizeColumn(4);
							 xlsSheet.setColumnWidth(4, 3000);
							 cell.setCellValue(Double.parseDouble(sipResponse.getEnhancementGrowth()));
					    }else{
					    	 cell = row.createCell(4);
							 cell.setCellStyle(td_style);
							 xlsSheet.autoSizeColumn(4);
							 xlsSheet.setColumnWidth(4, 3000);
							 cell.setCellValue("-");
					    }
					    
					   
					    
					    
					    if(!sipResponse.getEnhancementGrowthPercent().equals("-")){
					    	cell = row.createCell(5);
						    cell.setCellStyle(td_style);
						    xlsSheet.autoSizeColumn(5);
						    xlsSheet.setColumnWidth(5, 3000);
						    cell.setCellValue(Double.parseDouble(sipResponse.getEnhancementGrowthPercent()));
					    }
					    else{
					    	cell = row.createCell(5);
						    cell.setCellStyle(td_style);
						    xlsSheet.autoSizeColumn(5);
						    xlsSheet.setColumnWidth(5, 3000);
						    cell.setCellValue("-");
					    }
					    
					}
				    
				    row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				    style.setFont(company_font);
					cell.setCellStyle(style);
					cell.setCellValue("");
				    
					String files = (String) request.getSession().getAttribute("mfimagefile");
					// Generate Chart
					String chart = env.getProperty("excelPhotoDir") + File.separator + files+".jpg";
					row = xlsSheet.createRow(rowIndex++);
				    cell = row.createCell(0);
				    style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tinysmall_font);
					cell.setCellStyle(style);
					InputStream is = new FileInputStream(chart);
					byte[] bytes = IOUtils.toByteArray(is);
					int pictureIdx = xlsWorkbook.addPicture(bytes, xlsWorkbook.PICTURE_TYPE_JPEG);
					is.close();
					HSSFCreationHelper helper = xlsWorkbook.getCreationHelper(); 
					Drawing drawing = xlsSheet.createDrawingPatriarch();
					HSSFClientAnchor anchor = helper.createClientAnchor();
					anchor.setCol1(0);
					anchor.setRow1((rowIndex-1));
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 5));
					Picture pict = drawing.createPicture(anchor, pictureIdx);
					pict.resize(0.85);
					
					String requestURL = "/mutual-funds-research/downloadAnnualIncrease?scheme="+scheme+"&amount="+amount+"&frequency="+frequency+"&start_date="+start_date+"&end_date="+end_date+"&enhancement_percentage="+enhancementPercentage;
					LogDownload logDownload = new LogDownload();
					logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
					logDownload.setEmail(accountMap.get("email"));
					logDownload.setTitle("SIP with Annual Increase");
					logDownload.setRequest(requestURL);
					logDownload.setCreate_date(new Date());
					logDownload.setClient_name("dakshin");
					commonDao.saveDownloadLog(logDownload);
				  
				    // Write to disk
				    String FILE = request.getRealPath("") + File.separator+File.separator+"sip-with-annual-increase.xls";
					OutputStream file = new FileOutputStream(FILE);
				    xlsWorkbook.write(file);
				    file.close();
		            
					File f = new File(FILE);
					FileInputStream fin = new FileInputStream(f);
					ServletOutputStream outStream = response.getOutputStream();
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition", "sip-with-annual-increase.xls");
					byte[] buffer = new byte[1024];
					int n = 0;
					while ((n = fin.read(buffer)) != -1) 
					{
						outStream.write(buffer, 0, n);
					}
					outStream.flush();
					fin.close();
					outStream.close();
				}
				else
				{
					PrintWriter out = response.getWriter();
					response.setContentType("application/vnd.ms-excel");
					response.setCharacterEncoding("UTF-8");
				}
			}
			/*
			 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
			 */
			
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	
	}
	
	@RequestMapping(value="/base64toimage")
	public void base64toimage(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	

			String base64image = request.getParameter("base64image"); 
			String filename = request.getParameter("filename");
			
			request.getSession().setAttribute("mfimagefile", filename+"_"+System.currentTimeMillis());
			
			String path = env.getProperty("excelPhotoDir");
			
			String files = (String) request.getSession().getAttribute("mfimagefile");
			
			byte[] decodedImg = Base64.getDecoder().decode(base64image.getBytes(StandardCharsets.UTF_8));
			Path destinationFile = Paths.get(path, files+".jpg");
			Files.write(destinationFile, decodedImg);
			
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/downloadPpfvsElss")
	public void downloadPpfvsElss(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
			if(accountMap != null)
			{
				
				/*
				 * List<AdvisorkhojDownloadLog> advisorkhojDownloadLogsList =
				 * logDao.getDownloadLog(Integer.parseInt(accountMap.get("userid")));
				 * if(advisorkhojDownloadLogsList.size() > 10) { ApiCommonResponse
				 * apiCommonResponse = new ApiCommonResponse();
				 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
				 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
				 * FailureMessage); apiCommonResponse.
				 * setMsg("You have exceeded the maximum allowed download limit per day. We allow only 10 downloads per day."
				 * );
				 * 
				 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
				 * response.setContentType("application/json");
				 * response.setCharacterEncoding("UTF-8");
				 * out.print(gson.toJson(apiCommonResponse)); out.flush(); return; }
				 */
			
				String schemes = request.getParameter("schemes");
				String start_date = request.getParameter("start_date");
				String end_date = request.getParameter("end_date");
				String period = request.getParameter("period");
				String amount = request.getParameter("amount");
				String type = request.getParameter("type");
				String download = request.getParameter("download");
				
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
				if(download == null){download= "";}
				
				schemes = schemes.trim();
				start_date = start_date.trim();
				end_date = end_date.trim();
				period = period.trim();
				amount = amount.trim();
				type = type.trim();
				download = download.trim();
				
				if(download.equalsIgnoreCase("yes"))
				{
				
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
			 		//request.setAttribute("list", list.getList());
					
					// Create new Excel workbook and sheet
		           	HSSFWorkbook xlsWorkbook = new HSSFWorkbook();
				    HSSFSheet xlsSheet = xlsWorkbook.createSheet("PPF vs ELSS");
				    short rowIndex = 0;
				    
				    xlsSheet.setColumnWidth(0, 15);
				    
				    HSSFFont company_font = xlsWorkbook.createFont();
				    company_font.setFontHeightInPoints((short) 12);
				    company_font.setFontName("Arial");
				    company_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    company_font.setColor(HSSFColor.BLACK.index);
				    
				    HSSFFont heading_font = xlsWorkbook.createFont();
				    heading_font.setFontHeightInPoints((short) 20);
				    heading_font.setFontName("Calibri");
				    heading_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    heading_font.setColor(HSSFColor.RED.index);
				    
				    HSSFFont name_font = xlsWorkbook.createFont();
				    name_font.setFontHeightInPoints((short) 16);
				    name_font.setFontName("Calibri");
				    name_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    name_font.setColor(HSSFColor.RED.index);
				    
				    HSSFFont tiny_font = xlsWorkbook.createFont();
				    tiny_font.setFontHeightInPoints((short) 9);
				    tiny_font.setFontName("Arial");
				    tiny_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    
				    HSSFFont tinysmall_font = xlsWorkbook.createFont();
				    tinysmall_font.setFontHeightInPoints((short) 9);
				    tinysmall_font.setFontName("Calibri");
				    
				    HSSFFont th_font = xlsWorkbook.createFont();
				    th_font.setFontHeightInPoints((short) 9);
				    th_font.setFontName("Calibri");
				    th_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    th_font.setColor(HSSFColor.WHITE.index);
				    
				    HSSFFont normal_font = xlsWorkbook.createFont();
				    normal_font.setFontHeightInPoints((short) 12);
				    normal_font.setFontName("Calibri");
				    
				    HSSFFont small_font = xlsWorkbook.createFont();
				    small_font.setFontHeightInPoints((short) 10);
				    small_font.setFontName("Calibri");
				    
				    HSSFFont blue_font = xlsWorkbook.createFont();
				    blue_font.setFontHeightInPoints((short) 12);
				    blue_font.setFontName("Calibri");
				    blue_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				    blue_font.setColor(HSSFColor.LIGHT_BLUE.index);
				    
				    HSSFCellStyle th_style = xlsWorkbook.createCellStyle();
					HSSFPalette palette = xlsWorkbook.getCustomPalette();
					HSSFColor myColor = palette.findSimilarColor(214,216,250);
					short palIndex = myColor.getIndex();
					
					th_style.setFillForegroundColor(palIndex);  
					th_style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
					th_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
					th_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
					th_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
					th_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
					th_style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
					th_style.setWrapText(true);
					th_style.setFont(tiny_font);
				    
				    
				    HSSFCellStyle th_amount_style = xlsWorkbook.createCellStyle();
				    th_amount_style.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);
				    th_amount_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				    th_amount_style.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
				    th_amount_style.setFont(tinysmall_font);
				    
				    HSSFCellStyle th_cagr_style = xlsWorkbook.createCellStyle();
				    th_cagr_style.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);
				    th_cagr_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				    th_cagr_style.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
				    th_cagr_style.setFont(th_font);
				    
				    HSSFCellStyle th_style_right = xlsWorkbook.createCellStyle();
				    th_style_right.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
				    th_style_right.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);
				    th_style_right.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				    th_style_right.setFont(th_font);
				    
				    HSSFCellStyle footer_style = xlsWorkbook.createCellStyle();
				    footer_style.setAlignment(HSSFCellStyle.ALIGN_JUSTIFY);
				    footer_style.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
				    footer_style.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
				    footer_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				    footer_style.setFont(small_font);
				    
				    HSSFCellStyle td_style = xlsWorkbook.createCellStyle();
				    td_style.setWrapText(true);
				    td_style.setFont(tinysmall_font);
				    
				    HSSFCellStyle td_style_right = xlsWorkbook.createCellStyle();
				    td_style_right.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				    td_style_right.setWrapText(true);
				    td_style_right.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
				    td_style_right.setFont(tinysmall_font);
				    
				    HSSFCellStyle td_amount_style = xlsWorkbook.createCellStyle();
				    td_amount_style.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
				    td_amount_style.setFont(normal_font);
				    
				    HSSFCellStyle td_cagr_style = xlsWorkbook.createCellStyle();
				    td_cagr_style.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
				    td_cagr_style.setFont(normal_font);
				    
				    HSSFCellStyle blue_style = xlsWorkbook.createCellStyle();
				    blue_style.setFont(blue_font);
				    
				    HSSFRow row = xlsSheet.createRow(rowIndex++);
					HSSFCell cell = row.createCell(0);
					HSSFCellStyle style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(company_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 10));
					cell.setCellValue("");
					
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				    style.setFont(company_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 10));
					cell.setCellValue("Mutual Fund Category Monitor");			
					
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 10));
					cell.setCellValue("Option:- "+type);
					
					if(type.equals("sip")){
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 10));
					cell.setCellValue("Frequency:- "+period);
					
					}
					
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 10));
					cell.setCellValue("Amount:- "+amount);
					
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 10));
					cell.setCellValue("Start Date:- "+start_date);
					
					row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tiny_font);
					cell.setCellStyle(style);
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 10));
					cell.setCellValue("End Date:- "+end_date);
					
					
					row = xlsSheet.createRow(rowIndex++);
					row.setHeight((short)500);
					
				    cell = row.createCell(0);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(0);
				    xlsSheet.setColumnWidth(0, 8000);
				    cell.setCellValue("Scheme Name");
				    
				    cell = row.createCell(1);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(1);
				    xlsSheet.setColumnWidth(1, 2500);
				    cell.setCellValue("Launch Date");
				    
				    cell = row.createCell(2);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(2);
				    xlsSheet.setColumnWidth(2, 2500);
				    cell.setCellValue("AUM (Crore)");
				    
				    cell = row.createCell(3);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(3);
				    xlsSheet.setColumnWidth(3, 2500);
				    cell.setCellValue("Expense Ratio (%)");
				    
				    cell = row.createCell(4);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(4);
				    xlsSheet.setColumnWidth(4, 2500);
				    cell.setCellValue("Start Date");
				    
				    cell = row.createCell(5);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(5);
				    xlsSheet.setColumnWidth(5, 2500);
				    cell.setCellValue("Amount Invested");
				    
				    cell = row.createCell(6);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(6);
				    xlsSheet.setColumnWidth(6, 2500);
				    cell.setCellValue("Scheme Current Value as on "+end_date);
				    
				    cell = row.createCell(7);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(7);
				    xlsSheet.setColumnWidth(7, 3500);
				    cell.setCellValue("Scheme Returns (%)");
				    
				    cell = row.createCell(8);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(8);
				    xlsSheet.setColumnWidth(8, 3500);
				    cell.setCellValue("PPF Current Value (%)");
				    
				    cell = row.createCell(9);
				    cell.setCellStyle(th_style);
				    xlsSheet.autoSizeColumn(9);
				    xlsSheet.setColumnWidth(9, 3500);
				    cell.setCellValue("PPF Returns (%)");
					
				  //request.setAttribute("rollingReturnsSummaryList", list.getRollingReturnsTable());
				    for (SIPSchemePerformanceResponse categoryReponse : list.getList()) 
					{
				    	
				    	row = xlsSheet.createRow(rowIndex++);
						cell = row.createCell(0);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(0);
					    xlsSheet.setColumnWidth(0, 8000);
					    cell.setCellValue(categoryReponse.getScheme());
					    
					    cell = row.createCell(1);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(1);
					    xlsSheet.setColumnWidth(1, 2500);
					    cell.setCellValue(categoryReponse.getInception_date());
					    
					    cell = row.createCell(2);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(2);
					    xlsSheet.setColumnWidth(2, 2500);
					    cell.setCellValue(categoryReponse.getNet_assets() == 0 ? 0.0 : convertDouble((categoryReponse.getNet_assets()/10)));
					    
					    cell = row.createCell(3);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(3);
					    xlsSheet.setColumnWidth(3, 2500);
					    cell.setCellValue(categoryReponse.getExpense_ratio() == 0 ? 0.0 : convertDouble(categoryReponse.getExpense_ratio()));
					    
					    cell = row.createCell(4);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(4);
					    xlsSheet.setColumnWidth(4, 2500);
					    cell.setCellValue(categoryReponse.getSip_start_date());
					    
					    cell = row.createCell(5);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(5);
					    xlsSheet.setColumnWidth(5, 2500);
					    cell.setCellValue(categoryReponse.getCurrent_cost());
					    
					    cell = row.createCell(6);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(6);
					    xlsSheet.setColumnWidth(6, 2500);
					    cell.setCellValue(categoryReponse.getCurrent_value());
					    
					    cell = row.createCell(7);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(7);
					    xlsSheet.setColumnWidth(7, 2500);
					    cell.setCellValue(categoryReponse.getReturns());
					    
				    	cell = row.createCell(8);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(8);
					    xlsSheet.setColumnWidth(8, 2500);
					    cell.setCellValue(categoryReponse.getPpf_current_value());
				
					    cell = row.createCell(9);
					    cell.setCellStyle(td_style);
					    xlsSheet.autoSizeColumn(9);
					    xlsSheet.setColumnWidth(9, 2500);
					    cell.setCellValue(categoryReponse.getPpf_returns());
					    		    	
					}
				    
				    row = xlsSheet.createRow(rowIndex++);
					cell = row.createCell(0);
					style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				    style.setFont(company_font);
					cell.setCellStyle(style);
					cell.setCellValue("");
				    
					String files = (String) request.getSession().getAttribute("mfimagefile");
					// Generate Chart
					String chart = env.getProperty("excelPhotoDir") + File.separator + files+".jpg";
					row = xlsSheet.createRow(rowIndex++);
				    cell = row.createCell(0);
				    style = xlsWorkbook.createCellStyle();
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
				    style.setFont(tinysmall_font);
					cell.setCellStyle(style);
					InputStream is = new FileInputStream(chart);
					byte[] bytes = IOUtils.toByteArray(is);
					int pictureIdx = xlsWorkbook.addPicture(bytes, xlsWorkbook.PICTURE_TYPE_JPEG);
					is.close();
					HSSFCreationHelper helper = xlsWorkbook.getCreationHelper(); 
					Drawing drawing = xlsSheet.createDrawingPatriarch();
					HSSFClientAnchor anchor = helper.createClientAnchor();
					anchor.setCol1(0);
					anchor.setRow1((rowIndex-1));
					xlsSheet.addMergedRegion(new Region((rowIndex-1), (short)0, (rowIndex-1), (short) 14));
					Picture pict = drawing.createPicture(anchor, pictureIdx);
					pict.resize(0.95);
					
					String requestURL = "/mutual-funds-research/downloadPpfvsElss?schemes="+schemes+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&period="+period+"&type="+type;
					LogDownload logDownload = new LogDownload();
					logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
					logDownload.setEmail(accountMap.get("email"));
					logDownload.setTitle("PPF vs ELSS");
					logDownload.setRequest(requestURL);
					logDownload.setCreate_date(new Date());
					logDownload.setClient_name("dakshin");
					commonDao.saveDownloadLog(logDownload);
				  
				    // Write to disk
				    String FILE = request.getRealPath("") + File.separator+File.separator+"ppf-vs-elss.xls";
					OutputStream file = new FileOutputStream(FILE);
				    xlsWorkbook.write(file);
				    file.close();
		            
					File f = new File(FILE);
					FileInputStream fin = new FileInputStream(f);
					ServletOutputStream outStream = response.getOutputStream();
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition", "ppf-vs-elss.xls");
					byte[] buffer = new byte[1024];
					int n = 0;
					while ((n = fin.read(buffer)) != -1) 
					{
						outStream.write(buffer, 0, n);
					}
					outStream.flush();
					fin.close();
					outStream.close();
				}
				else
				{
					PrintWriter out = response.getWriter();
					response.setContentType("application/vnd.ms-excel");
					response.setCharacterEncoding("UTF-8");
				}
			}
			/*
			 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
			 */
			
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	
	}
	
	@RequestMapping(value="/base64toimage2")
	public void base64toimage2(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	

			String base64image = request.getParameter("base64image"); 
			String filename = request.getParameter("filename");
			
			request.getSession().setAttribute("mfimagefile1", filename+"_"+System.currentTimeMillis());
			
			String path = env.getProperty("excelPhotoDir");
			
			String files = (String) request.getSession().getAttribute("mfimagefile1");
			
			byte[] decodedImg = Base64.getDecoder().decode(base64image.getBytes(StandardCharsets.UTF_8));
			Path destinationFile = Paths.get(path, files+".jpg");
			Files.write(destinationFile, decodedImg);
			
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	
	@RequestMapping(value="/topmutualfunds2020")
	public void topmutualfunds2020(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		String requestUrl = request.getRequestURL().toString();
		String queryString = request.getQueryString();
		try
		{
			
			HashMap<String, String> accountMap = (HashMap<String, String>) request.getSession().getAttribute("accountMap");
			if(accountMap != null)
			{
				
				String category =  request.getParameter("category");
				System.out.println("category"+category);
		 		String period = request.getParameter("period");
		 		String type = request.getParameter("type");
		 		String mode = request.getParameter("mode");
		 		String download = request.getParameter("download");
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
				
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	    		
	    		if(download.equalsIgnoreCase("yes"))
	    		{
	            
		            response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition", "attachment;filename=Top-SWP-Funds-Report.xlsx");
						
					// Create new Excel workbook and sheet
					Workbook wb = new Workbook(response.getOutputStream(), "MyApplication", "1.0");
					Worksheet ws = wb.newWorksheet("Top SWP Funds Report");
					
					ws.value(0, 0, "Top Mutual Funds - 2020");
					ws.range(0, 0, 0, 4).merge();
					ws.range(0, 0, 0, 4).style().horizontalAlignment("center").set();
					ws.style(0, 0).bold().fontSize(11).set(); 
				
					String cat="";
					if(category.equalsIgnoreCase("")) {
						cat = "ALL";
					}
					else {
						cat = category;
					}
					
					ws.value(1, 0, "Category: " + cat);
					ws.range(1, 0, 1, 4).merge();
					ws.style(1, 0).bold().fontSize(9).set();
					
					ws.value(2, 0, "Period: " + period);
					ws.range(2, 0, 2, 4).merge();
					ws.range(2, 0, 2, 4).style().horizontalAlignment("left").set();
					ws.style(2, 0).bold().fontSize(11).set(); 
			 		
			 		ws.width(0, 35);
			 		ws.width(1, 10);
			 		ws.width(2, 10);
			 		ws.width(3, 12);
			 		ws.width(4, 10);
			 		
			 		int i = 3;
			 		int j = 0;
			 		for(j = 0; j < 5; j++) {
						ws.style(i, j).fontSize(9).bold().verticalAlignment("bottom").borderStyle("thin").borderColor("222323").fillColor("D6D8FA").wrapText(true).set();	
						
					}
					
					ws.value(i, 0, "Scheme Name");
					ws.value(i, 1, "Inception Date");
					ws.value(i, 2, "Return in (%)");
					ws.value(i, 3, "Rs. 1L Grew to  (One-Time)");
					ws.value(i++, 4, "Rs. 5000 Grew to (SIP)");
					
					for(Top10FundsByCategory top10: top10FundsByCategory){
						
						Double returnToDisplay = top10.getReturnToDisplay() == 0 ? 0.0 :  top10.getReturnToDisplay();
						
						ws.value(i, 0, top10.getScheme_amfi());
						ws.style(i, 0).fontSize(9).set();
						ws.value(i, 1, sdf.format(top10.getInception_date()));
						ws.style(i, 1).fontSize(9).wrapText(true).set();
						ws.value(i, 2, returnToDisplay);
						ws.style(i, 2).fontSize(9).set();
						ws.value(i, 3, top10.getLumpsumToDisplay());
						ws.style(i, 3).fontSize(9).wrapText(true).set();
						ws.value(i, 4, top10.getSipToDisplay());
						ws.style(i++, 4).fontSize(9).set();
					}
					
					/*
					 * String requestURL =
					 * "/mutual-funds-research/topSwpFunds?amc="+amc+"&category="+category+
					 * "&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+
					 * withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+
					 * to_date+"&init_start_date="+init_start_date;
					 */
					String requestURL = "";
					LogDownload logDownload = new LogDownload();
					logDownload.setUser_id(Integer.parseInt(accountMap.get("userid")));
					logDownload.setEmail(accountMap.get("email"));
					logDownload.setTitle("Top Mutual Funds - 2020");
					logDownload.setRequest(requestURL);
					logDownload.setCreate_date(new Date());
					logDownload.setClient_name("dakshin");
					commonDao.saveDownloadLog(logDownload);
					
					wb.finish();
	    		}
	    		else
	    		{
	    			PrintWriter out = response.getWriter();
	    			response.setContentType("application/vnd.ms-excel");
	    			response.setCharacterEncoding("UTF-8");
	    		}
	    	}
			/*
			 * else { ApiCommonResponse apiCommonResponse = new ApiCommonResponse();
			 * apiCommonResponse.setStatus(AdvisorkhojStatusCodesAndMessages.FailureCode);
			 * apiCommonResponse.setStatus_msg(AdvisorkhojStatusCodesAndMessages.
			 * FailureMessage); apiCommonResponse.setMsg("Access Denied");
			 * 
			 * Gson gson = new Gson(); PrintWriter out = response.getWriter();
			 * response.setContentType("application/json");
			 * response.setCharacterEncoding("UTF-8");
			 * out.print(gson.toJson(apiCommonResponse)); out.flush(); }
			 */
		}
		catch(Exception ex)
		{
			System.err.println("Exception occured in ---->"+requestUrl + "?" + queryString);
			ex.printStackTrace();
			
		}
	}
	
	public void displayFiltervalue(Worksheet ws, String name, String value, String name1, String value2, int index){
		ws.value(index, 0, name);
		ws.range(index, 0, index, 1).merge();
		ws.range(index, 0, index, 1).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
		
		
		ws.value(index, 2, value);
		ws.range(index, 2, index, 4).merge();
		ws.range(index, 2, index, 4).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 5, name1);
		ws.range(index, 5, index, 6).merge();
		ws.range(index, 5, index, 6).style().bold().wrapText(false).bold().fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 7, value2);
		ws.range(index, 7, index, 9).merge();
		ws.range(index, 7, index, 9).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
	}
	
	public void displayFiltervalue(Worksheet ws, String name, int value, String name1, int value2, int index){
		ws.value(index, 0, name);
		ws.range(index, 0, index, 1).merge();
		ws.range(index, 0, index, 1).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 2, value);
		ws.range(index, 2, index, 4).merge();
		ws.range(index, 2, index, 4).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 5, name1);
		ws.range(index, 5, index, 6).merge();
		ws.range(index, 5, index, 6).style().bold().wrapText(false).bold().fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 7, value2);
		ws.range(index, 7, index, 9).merge();
		ws.range(index, 7, index, 9).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
	}
	
	public void displayFiltervalue(Worksheet ws, String name, String value, String name1, int value2, int index){
		ws.value(index, 0, name);
		ws.range(index, 0, index, 1).merge();
		ws.range(index, 0, index, 1).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 2, value);
		ws.range(index, 2, index, 4).merge();
		ws.range(index, 2, index, 4).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 5, name1);
		ws.range(index, 5, index, 6).merge();
		ws.range(index, 5, index, 6).style().bold().wrapText(false).bold().fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 7, value2);
		ws.range(index, 7, index, 9).merge();
		ws.range(index, 7, index, 9).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
	}
	
	public void displayFiltervalue(Worksheet ws, String name, int value, String name1, String value2, int index){
		ws.value(index, 0, name);
		ws.range(index, 0, index, 1).merge();
		ws.range(index, 0, index, 1).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 2, value);
		ws.range(index, 2, index, 4).merge();
		ws.range(index, 2, index, 4).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 5, name1);
		ws.range(index, 5, index, 6).merge();
		ws.range(index, 5, index, 6).style().bold().wrapText(false).bold().fontSize(9).horizontalAlignment("left").set();
		
		ws.value(index, 7, value2);
		ws.range(index, 7, index, 9).merge();
		ws.range(index, 7, index, 9).style().bold().wrapText(false).fontSize(9).horizontalAlignment("left").set();
	}
	
	public Double twoDecimal(Double input){
		BigDecimal bd = new BigDecimal(input).setScale(2, RoundingMode.HALF_UP);
        double amount = bd.doubleValue();
        return amount;
	}
	
	public Long roundOffNumber(Double input){
		return Math.round(input);
	}
	
	public Double fourDecimal(Double input){
		BigDecimal bd = new BigDecimal(input).setScale(4, RoundingMode.HALF_UP);
        double amount = bd.doubleValue();
        return amount;
	}
	
	public Double convertDouble(double data){
		BigDecimal convertDouble = new BigDecimal(data);
		convertDouble = convertDouble.setScale(2, BigDecimal.ROUND_HALF_EVEN);
		return convertDouble.doubleValue();
	}
	
}
