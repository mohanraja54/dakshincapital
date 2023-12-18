package com.dakshin.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dakshin.amfi.model.DownloadCenter;
import com.dakshin.amfi.model.SchemePerformances;
import com.dakshin.amfi.model.SchemePerformancesBenchmark;
import com.dakshin.amfi.model.SchemePerformancesCategory;
import com.dakshin.amfi.model.Top10FundsByCategory;
import com.dakshin.dao.CommonDao;
import com.dakshin.model.LogDownload;
import com.dakshin.model.ModelPortfolioSchemes;
import com.dakshin.model.Users;
import com.dakshin.utils.PasswordHelper;

@Component("commonDao")
@Transactional
@SuppressWarnings("unchecked")
public class CommonDaoImpl implements CommonDao
{
	@Autowired
	@Qualifier("mfEntityManagerFactory")
	private EntityManager mfEntityManager;
	
	@Autowired
	@Qualifier("amfiEntityManagerFactory")
	private EntityManager amfiEntityManager;
	
	public Users checkIfMobileAlreadyExist(String mobile)
	{
		Users user = null;
		
		try
		{
			Query query = mfEntityManager.createQuery("from Users where mobile = :mobile and client_name = :client_name");
			query.setParameter("mobile", mobile);
			query.setParameter("client_name", "dakshin");
			List<Users> usersList = query.getResultList();
			
			if(usersList != null && usersList.size() > 0)
			{
				user = usersList.get(0);
			}			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return user;
	}
	
	public Users getUserDetails(Integer id, String client_name) 
	{
		List<Users> list = null;
        Users user = null;
        
		try
		{
			Query query = mfEntityManager.createQuery("from Users where id = :id and client_name = :client_name");
			query.setParameter("id", id);
			query.setParameter("client_name", client_name);
			list = query.getResultList();
			
			if(list != null && list.size() > 0)
			{
				user = list.get(0);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return user;
	}
	
	public Users getUserDetailsByMobile(String mobile, String password) 
	{
		List<Users> list = null;
        Users user = null;
        
		try
		{
			Query query = mfEntityManager.createQuery("from Users where client_name=:client_name and mobile = :mobile");
			query.setParameter("mobile", mobile);
			query.setParameter("client_name", "dakshin");
			list = query.getResultList();
			if(list != null && list.size() > 0)
			{
				if(list.size() > 1)
				{
					boolean flag = false;
					for (Users users : list) 
					{
						int type_id = users.getType_id();
						if(type_id == 3)
						{
							if(PasswordHelper.checkPassword(password, users.getUser_password()))
							{
								user = users;
								flag = true;
								break;
							}
						}
					}	
					
					if(flag)
					{
						
					}else
					{
						user = null;
					}
				}else
				{
					user = list.get(0);
					if(PasswordHelper.checkPassword(password,user.getUser_password()))
					{
					}
					else
					{
						user = null;
					}
				}
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return user;
	}
	
	public void saveUser(Users user)
	{
		try
		{
			mfEntityManager.persist(user);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	public boolean saveDownloadLog(LogDownload logDownload)
	{

		try 
		{
			mfEntityManager.persist(logDownload);
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return true;
	}
	
	public Users validateLogin(String mobile_pan, String password, String client_name)
	{
		Users users = null;
        
		try
		{
			Query query = mfEntityManager.createQuery("from Users where client_name = :client_name and (mobile = :mobile or pan = :pan)");
			query.setParameter("client_name", client_name);
			query.setParameter("mobile", mobile_pan);
			query.setParameter("pan", mobile_pan);
			List<Users> list = query.getResultList();
			if(list.size() > 0)
			{
				if(list.size() > 1)
				{
					boolean flag = false;
					for (Users users2 : list) 
					{
						int type_id = users2.getType_id();
						if(type_id == 3)
						{
							flag = true;
							users = users2;
							if(PasswordHelper.checkPassword(password, users.getUser_password()))
							{
								
							}
							else
							{
								users = null;
							}
							break;
						}
					}
					
					if(!flag)
					{
						users = list.get(0);
						if(PasswordHelper.checkPassword(password, users.getUser_password()))
						{
							
						}
						else
						{
							users = null;
						}
					}
				}else
				{
					users = list.get(0);
					if(PasswordHelper.checkPassword(password, users.getUser_password()))
					{
						
					}
					else
					{
						users = null;
					}
				}
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return users;
	}
	
	public List<Top10FundsByCategory> getTop10FundsByCategory(String period, String category, String type, int maxno, String mode, List<String> category_list) 
	{
		List<Top10FundsByCategory> top10FundsByCategory = null;
		try
		{
				String sql = "from Top10FundsByCategory where scheme_category = :scheme_category";
				
				sql += " and scheme_amfi not like '%Direct%' and scheme_amfi not like '%Institutiona%' and scheme_amfi not like '%bonus%'";
				
				if(period.equalsIgnoreCase("3m"))
				{
					sql += " and returns_abs_3month!=0 group by scheme_amfi order by returns_abs_3month desc";
				}
				else if(period.equalsIgnoreCase("6m"))
				{
					sql += " and returns_abs_6month!=0 group by scheme_amfi order by returns_abs_6month desc";
				}
				else if(period.equalsIgnoreCase("1y"))
				{
					sql += " and returns_abs_1year!=0 group by scheme_amfi order by returns_abs_1year desc";
				}
				else if(period.equalsIgnoreCase("3y"))
				{
					sql += " and returns_cmp_3year!=0 group by scheme_amfi order by returns_cmp_3year desc";
				}
				else if(period.equalsIgnoreCase("5y"))
				{
					sql += " and returns_cmp_5year!=0 group by scheme_amfi order by returns_cmp_5year desc";
				}
				else if(period.equalsIgnoreCase("10y"))
				{
					sql += " and returns_cmp_10year!=0 group by scheme_amfi order by returns_cmp_10year desc";
				}
				else
				{
					sql += " and returns_cmp_inception!=0 group by scheme_amfi order by returns_cmp_inception desc";
				}
				
				Query query = amfiEntityManager.createQuery(sql);
				query.setParameter("scheme_category", category);
				query.setMaxResults(10);
				
				top10FundsByCategory = query.getResultList();
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return top10FundsByCategory;
	}
	
	public List<SchemePerformances> getModelPortfolioNew(List<String> amfi_code_list) 
	{
		Query query = null;
		List<SchemePerformances> list = null;
		
		try
		{
			query = amfiEntityManager.createQuery("from SchemePerformances where scheme_amfi_code in (:scheme_amfi_code) order by scheme_category,scheme_amfi asc");
			query.setParameter("scheme_amfi_code", amfi_code_list);
			list = query.getResultList();		
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return list;
	}
	
	public SchemePerformancesBenchmark getBenchmarkPerformance() 
	{
		Query query = null;
		List<SchemePerformancesBenchmark> list = null;
		SchemePerformancesBenchmark benchmark = null;
		
		try
		{
			query = amfiEntityManager.createQuery("from SchemePerformancesBenchmark where citicode = :citicode");
			query.setParameter("citicode", "NIFTY50");
			list = query.getResultList();
			if(list != null && list.size() > 0)
			{
				benchmark = list.get(0);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return benchmark;
	}
	
	public List<SchemePerformancesCategory> getAllCategoryPerformance() 
	{
		Query query = null;
		List<SchemePerformancesCategory> list = null;
		
		try
		{
			query = amfiEntityManager.createQuery("from SchemePerformancesCategory order by sector asc");
			list = query.getResultList();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return list;
	}
	
	public List<String> getEquityCategories()
	{
		List<String> list = null;
		
		try
		{
			Query query = amfiEntityManager.createQuery("select distinct scheme_advisorkhoj_category from SchemeMapping where scheme_broad_category = :scheme_broad_category");
			query.setParameter("scheme_broad_category", "Equity Schemes");
			list = query.getResultList();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return list;
	}
	
	public List<String> getAmcforFactsheet() 
	{
		List<String> list = null;
		
		try
		{
			CriteriaBuilder builder = amfiEntityManager.getCriteriaBuilder();
			CriteriaQuery<String> q = builder.createQuery(String.class);
			Root<DownloadCenter> root = q.from(DownloadCenter.class);
			q.select(root.get("company")).distinct(true).where(
					builder.equal(root.get("category_order_id"), 5), 
					builder.equal(root.get("active"), 1),
					builder.notEqual(root.get("company"), ""));
			q.orderBy(builder.asc(root.get("company")));
			
			list = amfiEntityManager.createQuery(q).getResultList();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return list;
	}
	
	public List<DownloadCenter> getFactsheetByAmcAndYear(String amc, String year) 
	{
		List<DownloadCenter> list = null;
		try
		{
			
			CriteriaBuilder builder = amfiEntityManager.getCriteriaBuilder();
			CriteriaQuery<DownloadCenter> q = builder.createQuery(DownloadCenter.class);
			Root<DownloadCenter> root = q.from(DownloadCenter.class);
			q.select(root).where(builder.equal(root.get("company"), amc) , 
								 builder.equal(root.get("subcategory"), year) ,
								 builder.equal(root.get("category_order_id"), 5) ,
								 builder.equal(root.get("active"), 1));
			
			q.orderBy(builder.desc(root.get("download_name_order_id")));
			list = amfiEntityManager.createQuery(q).getResultList();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return list;
	}
	
	public List<String> getFactsheetYearsByAmc(String amc) 
	{
		List<String> list = null;
		
		try
		{
			CriteriaBuilder builder = amfiEntityManager.getCriteriaBuilder();
			CriteriaQuery<String> q = builder.createQuery(String.class);
			Root<DownloadCenter> root = q.from(DownloadCenter.class);
			q.select(root.get("subcategory")).distinct(true).where(builder.equal(root.get("company"), amc), 
																   builder.equal(root.get("category_order_id"), 5),builder.equal(root.get("active"), 1));
			q.orderBy(builder.desc(root.get("subcategory")));
			
			list = amfiEntityManager.createQuery(q).getResultList();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return list;
	}
}
