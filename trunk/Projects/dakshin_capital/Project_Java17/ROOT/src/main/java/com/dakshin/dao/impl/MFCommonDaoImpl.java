package com.dakshin.dao.impl;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dakshin.dao.MFCommonDao;
import com.dakshin.model.InvestorTransactionCams;
import com.dakshin.model.InvestorTransactionKarvy;
import com.dakshin.model.TransactionType;
import com.dakshin.model.Users;
import com.dakshin.model.UsersGoalSavedPlan;
import com.dakshin.response.InvestorPortfolioResponse;
import com.dakshin.response.InvestorSchemeWisePortfolioResponse;
import com.dakshin.response.RmInvestorResponse;
import com.dakshin.utils.CommonUtils;

@SuppressWarnings("unchecked")
@Component("mfcommonDao")
@Transactional
public class MFCommonDaoImpl implements MFCommonDao{

	@Autowired
	@Qualifier("mfEntityManagerFactory")
	private EntityManager entityManager;
	
	@Autowired
	@Qualifier("amfiEntityManagerFactory")
	private EntityManager amfiEntityManager;
	
	@SuppressWarnings("rawtypes")
	public InvestorPortfolioResponse getInvestorPortfolio(Integer user_id, String client_name) {
		InvestorPortfolioResponse investorPortfolioResponse = null;
		
		List<Object[]> camsSchemeList = null;
		List<Object[]> karvySchemeList = null;
		List<Object[]> schemeMappingList = null;
		Object[] schemeMapping = null;
		List<Object[]> latestNavList = null;
		Query query = null;
		
		InvestorSchemeWisePortfolioResponse investorSchemeWisePortfolioResponse = null;
		List<InvestorSchemeWisePortfolioResponse> investorSchemeWisePortfolioResponseList = null;

		List<InvestorTransactionCams> camsSchemeWiseInvestorTransactions = null;
		List<InvestorTransactionKarvy> karvySchemeWiseInvestorTransactions = null;

		DecimalFormat cost_dcf = new DecimalFormat("0.00");
		DecimalFormat unit_decimal = new DecimalFormat("0.0000");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");

		// CAMS Data Processing
		List<String> camsPositiveTransactionArrayList = new ArrayList<String>();
		List<String> camsNeutralTransactionArrayList = new ArrayList<String>();

		// Karvy Data Processing
		List<String> karvyPositiveTransactionArrayList = new ArrayList<String>();
		List<String> karvyNeutralTransactionArrayList = new ArrayList<String>();
		
		try 
		{
			investorPortfolioResponse = new InvestorPortfolioResponse();
			investorSchemeWisePortfolioResponseList = new ArrayList<InvestorSchemeWisePortfolioResponse>();
			
			System.out.println("user_id-->"+user_id);
			System.out.println("client_name-->"+client_name);

			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<TransactionType> q = builder.createQuery(TransactionType.class);
			Root<TransactionType> root = q.from(TransactionType.class);
			
			List<TransactionType> transaction_type_list = entityManager.createQuery(q.select(root)).getResultList();
			
			if (transaction_type_list != null && transaction_type_list.size() > 0) {
				for (TransactionType transactionType : transaction_type_list) {
					String registrar = transactionType.getRegistrar();
					String positive_transaction = transactionType.getPositive_transaction();
					String netural_transaction = transactionType.getNeutral_transaction();

					String[] positiveTransactionList = positive_transaction.split("[\\,]+");
					String[] neutralTransactionList = netural_transaction.split("[\\,]+");

					if (registrar.equalsIgnoreCase("cams")) {
						camsPositiveTransactionArrayList = Arrays.asList(positiveTransactionList);
						camsNeutralTransactionArrayList = Arrays.asList(neutralTransactionList);
					}
					if (registrar.equalsIgnoreCase("karvy")) {
						karvyPositiveTransactionArrayList = Arrays.asList(positiveTransactionList);
						karvyNeutralTransactionArrayList = Arrays.asList(neutralTransactionList);
					}
				}
			}
			
			query = entityManager.createQuery("select folio_no,prodcode from InvestorTransactionCams where user_id = :user_id and client_name = :client_name group by prodcode,folio_no order by scheme,traddate asc");
			query.setParameter("user_id", user_id);
			query.setParameter("client_name", client_name);
			camsSchemeList = query.getResultList();
			System.out.println("camsSchemeList-->"+camsSchemeList.size());
			
			query = entityManager.createQuery("from InvestorTransactionCams where user_id = :user_id and client_name = :client_name order by traddate asc, units desc");
			query.setParameter("user_id", user_id);
			query.setParameter("client_name", client_name);
			List<InvestorTransactionCams> investorTransactionCams = query.getResultList();
			System.out.println("investorTransactionCams-->"+investorTransactionCams.size());
			
			for (int s = 0; s < camsSchemeList.size(); s++) {
				
				//Start New Coding
				String folio_no = camsSchemeList.get(s)[0].toString();
				String code = camsSchemeList.get(s)[1].toString();
				camsSchemeWiseInvestorTransactions = investorTransactionCams.stream().filter(trxn -> (trxn.getFolio_no().equalsIgnoreCase(folio_no) && trxn.getProdcode().equalsIgnoreCase(code))).collect(Collectors.toList());
				//End New Coding

				investorSchemeWisePortfolioResponse = new InvestorSchemeWisePortfolioResponse();
				Date last_tran_date = null;
				Double last_tran_nav = 0.0;

				for (int i = 0; i < camsSchemeWiseInvestorTransactions.size(); i++) {
					String trxn_type_ = camsSchemeWiseInvestorTransactions.get(i).getTrxn_type_().trim();
					String scheme = camsSchemeWiseInvestorTransactions.get(i).getScheme().trim();
					String prodcode = camsSchemeWiseInvestorTransactions.get(i).getProdcode().trim();
					Date traddate = camsSchemeWiseInvestorTransactions.get(i).getTraddate();
					Double price = camsSchemeWiseInvestorTransactions.get(i).getPurprice();
					Double units = camsSchemeWiseInvestorTransactions.get(i).getUnits();
					Double amount = camsSchemeWiseInvestorTransactions.get(i).getAmount();
					last_tran_date = traddate;
					last_tran_nav = price;

					if (i == 0) {
						investorSchemeWisePortfolioResponse.setScheme(scheme);
						investorSchemeWisePortfolioResponse.setScheme_code(prodcode);
						investorSchemeWisePortfolioResponse.setFoliono(camsSchemeWiseInvestorTransactions.get(i).getFolio_no());
						investorSchemeWisePortfolioResponse.setAmc_code(camsSchemeWiseInvestorTransactions.get(i).getAmc_code());
						investorSchemeWisePortfolioResponse.setInvestmentStartNav(price);
						investorSchemeWisePortfolioResponse.setInvestmentStartDate(traddate);
						investorSchemeWisePortfolioResponse.setInvestmentStartValue(amount);
						investorSchemeWisePortfolioResponse.setPurchaseNav(price);
						investorSchemeWisePortfolioResponse.setScheme_registrar("cams");
					}

					if (camsPositiveTransactionArrayList.contains(trxn_type_)) {

						Double added_units = investorSchemeWisePortfolioResponse.getTotalUnits() + units;
						added_units = Double.parseDouble(unit_decimal.format(added_units));
						investorSchemeWisePortfolioResponse.setTotalUnits(added_units);

					} else if (camsNeutralTransactionArrayList.contains(trxn_type_)) {
						
					} else {
						Double added_units = investorSchemeWisePortfolioResponse.getTotalUnits() - units;
						added_units = Double.parseDouble(unit_decimal.format(added_units));
						investorSchemeWisePortfolioResponse.setTotalUnits(added_units);
					}
				}

				if (investorSchemeWisePortfolioResponse.getTotalUnits() <= 0) 
				{
					continue;
				}


				query = amfiEntityManager.createQuery("select scheme_company,scheme_advisorkhoj_category,scheme_broad_category,scheme_amfi_code,scheme_amfi from SchemeMapping where find_in_set(:scheme_cams_productcode, scheme_cams_productcode) <> 0");
				query.setParameter("scheme_cams_productcode", investorSchemeWisePortfolioResponse.getScheme_code());
				query.setMaxResults(1);
				schemeMappingList = query.getResultList();
				System.out.println("schemeMappingList-->"+schemeMappingList.size());
				
				if (schemeMappingList != null && schemeMappingList.size() > 0) 
				{
					schemeMapping = schemeMappingList.get(0);
					String scheme_company = schemeMapping[0].toString();
					String scheme_advisorkhoj_category = schemeMapping[1].toString();
					String scheme_amfi_code = schemeMapping[3].toString();
					String scheme_amfi = schemeMapping[4].toString();						
					
					investorSchemeWisePortfolioResponse.setScheme_company(scheme_company);
					investorSchemeWisePortfolioResponse.setScheme_advisorkhoj_category(scheme_advisorkhoj_category);
					investorSchemeWisePortfolioResponse.setScheme_amfi_code(scheme_amfi_code);
					investorSchemeWisePortfolioResponse.setScheme(scheme_amfi);

					query = amfiEntityManager.createQuery("select net_asset_value, nav_date from LatestNav where scheme_code = :scheme_code");
					query.setParameter("scheme_code", scheme_amfi_code);
					query.setMaxResults(1);
					latestNavList = query.getResultList();
					System.out.println("latestNavList-->"+latestNavList.size());
					if (latestNavList.size() > 0) {
						investorSchemeWisePortfolioResponse.setLatestNav(Double.parseDouble(latestNavList.get(0)[0].toString()));
						investorSchemeWisePortfolioResponse.setLatestNavDate(sdf1.parse(latestNavList.get(0)[1].toString()));
					} else 
					{
						Date nav_date = null;
						Double nav_value = 0.0;

						//query = amfiSession.createSQLQuery("select nav_date,net_asset_value from amfi_mf_nav where scheme_code = '" + scheme_amfi_code + "' order by nav_date desc");
						query = amfiEntityManager.createNativeQuery("select nav_date,net_asset_value from amfi_mf_nav where scheme_code = '" + scheme_amfi_code + "' order by nav_date desc");
						query.setMaxResults(1);
						List nav_list = query.getResultList();
						if(nav_list != null && nav_list.size() > 0)
						{
							for (Iterator It = nav_list.iterator(); It.hasNext();) 
							{
								Object[] row = (Object[]) It.next();
								nav_date = sdf1.parse(String.valueOf(row[0]));
								nav_value = Double.parseDouble(String.valueOf(row[1]));
							}
						}
						if (nav_date != null && nav_value != 0) 
						{
							investorSchemeWisePortfolioResponse.setLatestNav(nav_value);
							investorSchemeWisePortfolioResponse.setLatestNavDate(nav_date);
						} else 
						{
							investorSchemeWisePortfolioResponse.setLatestNav(last_tran_nav);
							investorSchemeWisePortfolioResponse.setLatestNavDate(last_tran_date);
						}
					}
				}else 
				{
					investorSchemeWisePortfolioResponse.setLatestNav(last_tran_nav);
					investorSchemeWisePortfolioResponse.setLatestNavDate(last_tran_date);
				}
				investorSchemeWisePortfolioResponse.setTotalCurrentValue(investorSchemeWisePortfolioResponse.getTotalUnits() * investorSchemeWisePortfolioResponse.getLatestNav());
				investorSchemeWisePortfolioResponseList.add(investorSchemeWisePortfolioResponse);
			}
			
			System.out.println("cams investorSchemeWisePortfolioResponseList-->"+investorSchemeWisePortfolioResponseList.size());
			
			query = entityManager.createQuery("select folio_number,fund,scheme_code FROM InvestorTransactionKarvy where user_id = :user_id and client_name = :client_name group by fund,scheme_code,folio_number order by fund_description,transaction_date asc");
			query.setParameter("user_id", user_id);
			query.setParameter("client_name", client_name);	
			karvySchemeList = query.getResultList();
			System.out.println("karvySchemeList-->"+karvySchemeList.size());
			
			//Start New Coding
			query = entityManager.createQuery("FROM InvestorTransactionKarvy where user_id = :user_id and client_name = :client_name order by transaction_date asc, units desc");
			query.setParameter("user_id", user_id);
			query.setParameter("client_name", client_name);	
			List<InvestorTransactionKarvy> investorTransactionKarvy = query.getResultList();
			System.out.println("Karvy Size = " + investorTransactionKarvy.size());

			for (int s = 0; s < karvySchemeList.size(); s++) {

				//Start New Coding
				String folio_number = karvySchemeList.get(s)[0].toString();
				String fund = karvySchemeList.get(s)[1].toString();
				String scheme_code = karvySchemeList.get(s)[2].toString();
				karvySchemeWiseInvestorTransactions = investorTransactionKarvy.stream().filter(trxn -> (trxn.getFolio_number().equalsIgnoreCase(folio_number) && trxn.getFund().equalsIgnoreCase(fund) && trxn.getScheme_code().equalsIgnoreCase(scheme_code))).collect(Collectors.toList());
				//End New Coding

				investorSchemeWisePortfolioResponse = new InvestorSchemeWisePortfolioResponse();
				Date last_tran_date = null;
				Double last_tran_nav = 0.0;

				for (int i = 0; i < karvySchemeWiseInvestorTransactions.size(); i++) {
					Date transaction_date = karvySchemeWiseInvestorTransactions.get(i).getTransaction_date();
					Double purchase_price = 0.0;
					if(karvySchemeWiseInvestorTransactions.get(i).getPrice() != null){
						purchase_price = karvySchemeWiseInvestorTransactions.get(i).getPrice();
					}
					Double units = 0.0;
					if(karvySchemeWiseInvestorTransactions.get(i).getUnits() != null){
						units = karvySchemeWiseInvestorTransactions.get(i).getUnits();
					}
					String transaction_description = karvySchemeWiseInvestorTransactions.get(i).getTransaction_description().trim();
					Double amount = karvySchemeWiseInvestorTransactions.get(i).getAmount();
					String fund_description = karvySchemeWiseInvestorTransactions.get(i).getFund_description().trim();
					last_tran_date = transaction_date;
					last_tran_nav = purchase_price;

					if (i == 0) {
						investorSchemeWisePortfolioResponse.setScheme(fund_description);
						investorSchemeWisePortfolioResponse.setScheme_code(karvySchemeWiseInvestorTransactions.get(i).getFund() + karvySchemeWiseInvestorTransactions.get(i).getScheme_code());
						investorSchemeWisePortfolioResponse.setFoliono(karvySchemeWiseInvestorTransactions.get(i).getFolio_number().trim());
						investorSchemeWisePortfolioResponse.setAmc_code(karvySchemeWiseInvestorTransactions.get(i).getFund());
						investorSchemeWisePortfolioResponse.setInvestmentStartNav(purchase_price);
						investorSchemeWisePortfolioResponse.setInvestmentStartDate(transaction_date);
						investorSchemeWisePortfolioResponse.setInvestmentStartValue(amount);
						investorSchemeWisePortfolioResponse.setPurchaseNav(purchase_price);
						investorSchemeWisePortfolioResponse.setScheme_registrar("karvy");
					}

					if (karvyPositiveTransactionArrayList.contains(transaction_description)) {
						
						Double current_units = investorSchemeWisePortfolioResponse.getTotalUnits() + units;
						current_units = Double.parseDouble(unit_decimal.format(current_units));
						investorSchemeWisePortfolioResponse.setTotalUnits(current_units);

					} else if (karvyNeutralTransactionArrayList.contains(transaction_description)) {
						if (transaction_description.equalsIgnoreCase("Consolidation Out")) {
							investorSchemeWisePortfolioResponse.setTotalUnits(0);
						}
					} else {
						Double current_units = investorSchemeWisePortfolioResponse.getTotalUnits() - units;
						current_units = Double.parseDouble(unit_decimal.format(current_units));
						investorSchemeWisePortfolioResponse.setTotalUnits(current_units);
					}
				}

				if (investorSchemeWisePortfolioResponse.getTotalUnits() <= 0) 
				{
					continue;
				}
				
				query = amfiEntityManager.createQuery("select scheme_company,scheme_advisorkhoj_category,scheme_broad_category,scheme_amfi_code,scheme_amfi from SchemeMapping where find_in_set(:scheme_karvy_productcode,scheme_karvy_productcode) <> 0");
				query.setParameter("scheme_karvy_productcode", investorSchemeWisePortfolioResponse.getScheme_code());
				query.setMaxResults(1);
				schemeMappingList = query.getResultList();
				if (schemeMappingList != null && schemeMappingList.size() > 0) {
					
					schemeMapping = schemeMappingList.get(0);
					String scheme_company = schemeMapping[0].toString();
					String scheme_advisorkhoj_category = schemeMapping[1].toString();
					String scheme_amfi_code = schemeMapping[3].toString();
					String scheme_amfi = schemeMapping[4].toString();	

					investorSchemeWisePortfolioResponse.setScheme_company(scheme_company);
					investorSchemeWisePortfolioResponse.setScheme_advisorkhoj_category(scheme_advisorkhoj_category);
					investorSchemeWisePortfolioResponse.setScheme_amfi_code(scheme_amfi_code);
					investorSchemeWisePortfolioResponse.setScheme(scheme_amfi);

					query = amfiEntityManager.createQuery("select net_asset_value, nav_date from LatestNav where scheme_code = :scheme_code");
					query.setParameter("scheme_code", scheme_amfi_code);
					query.setMaxResults(1);
					latestNavList = query.getResultList();
					if (latestNavList.size() > 0) {
						investorSchemeWisePortfolioResponse.setLatestNav(Double.parseDouble(latestNavList.get(0)[0].toString()));
						investorSchemeWisePortfolioResponse.setLatestNavDate(sdf1.parse(latestNavList.get(0)[1].toString()));
					} else {
						Date nav_date = null;
						Double nav_value = 0.0;

						query = amfiEntityManager.createNativeQuery("select nav_date,net_asset_value from amfi_mf_nav where scheme_code = '"+ scheme_amfi_code + "' order by nav_date desc");
						query.setMaxResults(1);
						List nav_list = query.getResultList();
						if(nav_list != null && nav_list.size() > 0)
						{
							for (Iterator It = nav_list.iterator(); It.hasNext();) 
							{
								Object[] row = (Object[]) It.next();
								nav_date = sdf1.parse(String.valueOf(row[0]));
								nav_value = Double.parseDouble(String.valueOf(row[1]));
							}
						}
						if (nav_date != null && nav_value != 0) 
						{
							investorSchemeWisePortfolioResponse.setLatestNav(nav_value);
							investorSchemeWisePortfolioResponse.setLatestNavDate(nav_date);
						} else 
						{
							investorSchemeWisePortfolioResponse.setLatestNav(last_tran_nav);
							investorSchemeWisePortfolioResponse.setLatestNavDate(last_tran_date);
						}
					}
				} else 
				{
					investorSchemeWisePortfolioResponse.setLatestNav(last_tran_nav);
					investorSchemeWisePortfolioResponse.setLatestNavDate(last_tran_date);
				}

				Double current_value = investorSchemeWisePortfolioResponse.getTotalUnits() * investorSchemeWisePortfolioResponse.getLatestNav();
				current_value = Double.parseDouble(cost_dcf.format(current_value));
				investorSchemeWisePortfolioResponse.setTotalCurrentValue(current_value);
				investorSchemeWisePortfolioResponseList.add(investorSchemeWisePortfolioResponse);
			}
			System.out.println("karvy investorSchemeWisePortfolioResponseList-->"+investorSchemeWisePortfolioResponseList.size());

			// System.out.println("------------------------------------------------------------------------------------------>");
			// System.out.println("All Karvy Schems Over Here
			// ------------------------------------------------------------------>");
			// System.out.println("------------------------------------------------------------------------------------------>");

			if (investorSchemeWisePortfolioResponseList.size() > 0) {
				Collections.sort(investorSchemeWisePortfolioResponseList,
						new Comparator<InvestorSchemeWisePortfolioResponse>() {
							@Override
							public int compare(final InvestorSchemeWisePortfolioResponse object1,
									final InvestorSchemeWisePortfolioResponse object2) {
								return object1.getScheme().compareTo(object2.getScheme());
							}
						});
			}
			
			System.out.println("investorSchemeWisePortfolioResponseList-->"+investorSchemeWisePortfolioResponseList.size());

			investorPortfolioResponse.setInvestorSchemeWisePortfolioResponses(investorSchemeWisePortfolioResponseList);
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return investorPortfolioResponse;
	}
	
	public List<RmInvestorResponse> getFHMappedInvestor(String userid, String client_name)
	{
		Query query = null;
		List<RmInvestorResponse> list = null;
		RmInvestorResponse rmInvestorResponse = null;
		
		try
		{
			list = new ArrayList<RmInvestorResponse>();
			query = entityManager.createNativeQuery("select distinct investor_id from UsersMapping where user_id = ? and client_name = ?");
			query.setParameter(1, userid);
			query.setParameter(2, client_name);
			List<String> name_list = query.getResultList();
			
			if(name_list.size() > 0 )
			{		
				List<Integer> id_list = new ArrayList<Integer>();
				for (String string : name_list) {
					id_list.add(Integer.parseInt(string));
				}
				query = entityManager.createNativeQuery("select * from Users where id in (?) and type_id in (1,3) and active=1 and client_name = ? order by name asc");
				query.setParameter(1, id_list);
				query.setParameter(2, client_name);
				List<Users> users_list = query.getResultList();
				
				if(users_list.size() > 0 )
				{
					for (Users user : users_list) 
					{
						rmInvestorResponse = new RmInvestorResponse();
						rmInvestorResponse.setId(String.valueOf(user.getId()));
						rmInvestorResponse.setName(user.getName());
						rmInvestorResponse.setMobile(user.getMobile());
						rmInvestorResponse.setEmail(user.getEmail());
						rmInvestorResponse.setCity(user.getCity());
						rmInvestorResponse.setPan(user.getPan());
						rmInvestorResponse.setClient_code(user.getBse_client_code());
						rmInvestorResponse.setDate_of_birth(user.getDate_of_birth());
						list.add(rmInvestorResponse);
					}
				}
			}	
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return list;
	}
	
	public Users getUserDetails(Integer id, String client_name) 
	{
		List<Users> list = null;
        Users user = null;
        
		try
		{
			Query query = entityManager.createQuery("from Users where id = :id and client_name = :client_name");
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
	
	public void saveGoalPlan(UsersGoalSavedPlan savePlan) 
	{
		try
		{
			entityManager.persist(savePlan);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	public List<UsersGoalSavedPlan> getGoalDetails(String user_id, String type) {
		List<UsersGoalSavedPlan> list = null;
		try
		{
			Query query = entityManager.createQuery("from UsersGoalSavedPlan where type = :type and user_id = :user_id and client_name = :client_name");
			query.setParameter("type", type);
			query.setParameter("user_id", user_id);
			query.setParameter("client_name", "dakshin");
			list = query.getResultList();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return list;
	}
}
