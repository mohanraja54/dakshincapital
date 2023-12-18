package com.dakshin.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.dakshin.amfi.model.DownloadCenter;
import com.dakshin.amfi.model.SchemePerformances;
import com.dakshin.amfi.model.SchemePerformancesBenchmark;
import com.dakshin.amfi.model.SchemePerformancesCategory;
import com.dakshin.amfi.model.Top10FundsByCategory;
import com.dakshin.model.LogDownload;
import com.dakshin.model.ModelPortfolioSchemes;
import com.dakshin.model.Users;



@Component("dao")
@Transactional
public interface CommonDao {
	
	public Users checkIfMobileAlreadyExist(String mobile);

	public void saveUser(Users obj);

	public Users validateLogin(String mobile, String password, String client_name);
	
	public List<Top10FundsByCategory> getTop10FundsByCategory(String period, String category, String type, int maxno, String mode, List<String> category_list);

	public List<SchemePerformances> getModelPortfolioNew(List<String> amfi_code_list);

	public SchemePerformancesBenchmark getBenchmarkPerformance();

	public List<SchemePerformancesCategory> getAllCategoryPerformance();

	public List<String> getEquityCategories();
	
	public Users getUserDetails(Integer id, String client_name);
	
	public Users getUserDetailsByMobile(String mobile, String password);
	
	public boolean saveDownloadLog(LogDownload logDownload);
	
	public List<String> getAmcforFactsheet();
	
	public List<DownloadCenter> getFactsheetByAmcAndYear(String amc, String year);
	
	public List<String> getFactsheetYearsByAmc(String amc);
}
