package com.dakshin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.math.NumberUtils;
import org.hibernate.internal.util.StringHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.owasp.esapi.ESAPI;

import com.dakshin.amfi.dao.AmfiApiAccessRepository;
import com.dakshin.amfi.model.DownloadCenter;
import com.dakshin.amfi.model.SchemePerformances;
import com.dakshin.amfi.response.MutualFundAPIResponse;
import com.dakshin.amfi.response.MutualFundSIPReturnsAPIResponse;
import com.dakshin.amfi.response.MutualFundSchemeAPIResponse;
import com.dakshin.amfi.response.TopPerformingLumpsumFundsResponse;
import com.dakshin.dao.BlogRepository;
import com.dakshin.dao.CommonDao;
import com.dakshin.dao.ContactFeedbackRepository;
import com.dakshin.dao.EmailSubscriptionRespository;
import com.dakshin.model.Blogs;
import com.dakshin.model.ContactFeedback;
import com.dakshin.model.Users;
import com.dakshin.response.CommonResponse;
import com.dakshin.utils.HttpPost;
import com.dakshin.utils.MfApiAccessor;
import com.dakshin.utils.MfApiUrls;
import com.dakshin.utils.ProjectUtils;
import com.dakshin.utils.SendEmailUtil;
import com.dakshin.utils.StatusCodesAndMessages;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.dakshin.utils.StatusMessage;

@Controller
public class HomeController {
	
	@Autowired
	BlogRepository blogRepository;
	
	@Autowired
	AmfiApiAccessRepository amfiApiAccessRepository;
	
	@Autowired
	EmailSubscriptionRespository emailSubscriptionRespository;
	
	@Autowired
	SendEmailUtil sendEmailUtil;
	
	@Autowired
	CommonDao commonDao;
	
	@Autowired
	ContactFeedbackRepository contactFeedbackRepository;

	@RequestMapping({"", "/", "/home"})
	public String welcome(HttpServletRequest request, HttpServletResponse response) throws Exception 
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
			
			String category = "Equity: Multi Cap";
	 		String period = "1y";
	 		String type = "Open";
	 		String mode = "Growth";
	 		
	 		String formattedUrl, result = "";
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getTopFundsBy3Yr, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundSchemeAPIResponse mutualFundSchemeAPIResponse = new Gson().fromJson(result, MutualFundSchemeAPIResponse.class);	 		
	 		request.setAttribute("schemePerformances_home",mutualFundSchemeAPIResponse.getList().stream().filter(sc -> sc.getScheme_category().equalsIgnoreCase("Equity: Multi Cap")).limit(5).collect(Collectors.toList()));
	 		
	 		List<SchemePerformances> remove_scheme_list = new ArrayList<SchemePerformances>();
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeDebtCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundAPIResponse mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	 		List<String> debt_fund_list = mutualFundAPIResponse.getList();
	 		
	 		HashMap<String, String> hashMap = new HashMap<String, String>();
	 		hashMap.put("period", "5");
	 		hashMap.put("category", category);
	 		hashMap.put("amount", "3000");
	 		hashMap.put("maxno","5");	 		
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSIPReturnsForCategoryPeriodAmount, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		Gson gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		MutualFundSIPReturnsAPIResponse mutualFundSIPReturnsAPIResponse = gson.fromJson(result, MutualFundSIPReturnsAPIResponse.class);		 		
	 			 
	 		request.setAttribute("sip_performance", mutualFundSIPReturnsAPIResponse.getList().subList(0, 5));
	 		
	 		hashMap = new HashMap<String, String>();
	 		hashMap.put("category", category);
	 		hashMap.put("period", "5");
	 		hashMap.put("amount", "10000");
	 		hashMap.put("maxno","5");
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getTopPerformingLumpsumFunds, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		gson = new GsonBuilder().setDateFormat("dd-MM-yyyy").create();
	 		TopPerformingLumpsumFundsResponse topPerformingLumpsumFundsResponse = gson.fromJson(result, TopPerformingLumpsumFundsResponse.class); 		
	 					
	 		request.setAttribute("lumpsumPerformances", topPerformingLumpsumFundsResponse.getList().subList(0, 5));	 
	 		
	 		hashMap = new HashMap<String, String>();
	 		hashMap.put("category", category);
	 		hashMap.put("period", period);
	 		hashMap.put("type", type);
	 		hashMap.put("mode",mode);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getSchemePerformanceReturns, hashMap);
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		MutualFundSchemeAPIResponse list = new Gson().fromJson(result, MutualFundSchemeAPIResponse.class);            
	 		List<SchemePerformances> schemePerformances = list.getList();
	 		
	 		for (SchemePerformances schemePerformances2 : schemePerformances) 
	 		{
	 			String scheme_category = schemePerformances2.getScheme_category();
	 			if(debt_fund_list.contains(scheme_category))
	 			{
	 				double one_year_return = schemePerformances2.getReturns_abs_1year();
	 				double ytd_return = schemePerformances2.getReturns_abs_ytd();
	 				if(one_year_return > 20 || ytd_return > 20)
	 				{
	 					remove_scheme_list.add(schemePerformances2);
	 				}
	 			}
	 		}
	 		schemePerformances.removeAll(remove_scheme_list);
	 		request.setAttribute("schemePerformances", schemePerformances);
	 		
	 		formattedUrl = MfApiAccessor.getFormattedUrl(amfiApiAccessRepository, MfApiUrls.getAllSchemeCategories, new HashMap<String, String>());
	 		result = HttpPost.SendHttpPost(formattedUrl);
	 		mutualFundAPIResponse = new Gson().fromJson(result, MutualFundAPIResponse.class);
	     	request.setAttribute("schemeCategories", mutualFundAPIResponse.getList());
	 		
	 		List<Blogs> blogsList = blogRepository.getLatestBlogs(3);
			request.setAttribute("blogsList", blogsList);
			
	 		request.setAttribute("category", category);
	 		request.setAttribute("period", period);
	 		request.setAttribute("type", type);
	 		request.setAttribute("mode", mode);
	 		
	     	request.setAttribute("page", "home");
	     	request.setAttribute("jsp", "../common/home.jsp");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping("/blog")
	public String blog(HttpServletRequest request, HttpServletResponse response) {
		
		String category = request.getParameter("category");
		if(category == null){category = "";}
		
		int blogsPageCount = blogRepository.getBlogsPageCount(category);
		request.setAttribute("blogsPageCount", blogsPageCount);
		
		String pageid = request.getParameter("pageid");
		if(pageid == null || pageid.isEmpty() || !NumberUtils.isCreatable(pageid)){pageid = "1";}
		request.setAttribute("pageid", pageid);
        int page_id = Integer.parseInt(pageid);
        
        List<String> categoryList = blogRepository.getBlogCatgeories();
	    request.setAttribute("categoryList", categoryList);

	    List<Blogs> blogsList = blogRepository.getAllBlogsByPageId("All", page_id - 1);
		request.setAttribute("blogsList", blogsList);
	    
	    List<Integer> paginator =  ProjectUtils.paginator(page_id, blogsPageCount);
	    int beginPaginatorId = paginator.get(0);  
        int endPaginatorId = paginator.get(1);
        request.setAttribute("beginPaginatorId", beginPaginatorId);
        request.setAttribute("endPaginatorId", endPaginatorId);
        
        request.setAttribute("page", "blog");
        request.setAttribute("jsp", "../common/blog.jsp");
	    
		return "layout/layout";
	}
	
	@RequestMapping(value="/blog/{titleOrcategory}")
	public String blogdetails(HttpServletRequest request, HttpServletResponse response,@PathVariable(value="titleOrcategory") String titleOrcategory) throws Exception 
	{
		try
		{	
			List<String> categoryList = blogRepository.getBlogCatgeories();
		    request.setAttribute("categoryList", categoryList);
		    String title = "";
			String category = "";
			
			String pageid = request.getParameter("pageid");
			if(pageid == null){pageid = "1";}
            int page_id = Integer.parseInt(pageid);
			
			if(categoryList.contains(titleOrcategory.replaceAll("-"," ")))
			{
				category = titleOrcategory;
			}
			else
			{
				title = titleOrcategory;
			}
			
			if(StringHelper.isNotEmpty(category))
			{
				category = category.replaceAll("-", " ");
				request.setAttribute("category", category);
				
				List<Blogs> blogsList = blogRepository.getAllBlogsByPageId(category,page_id - 1);
				request.setAttribute("blogsList", blogsList);
				
				request.setAttribute("page", "blog-category");
				request.setAttribute("jsp", "../common/blog.jsp");
			    
				return "layout/layout";
			}else
			{
				title = title.replaceAll("-", " ");
				request.setAttribute("title", title);
				
				Blogs blogs = blogRepository.getBlogsByTitle(title);
			    request.setAttribute("blogs", blogs); 
			    
			    List<Blogs> recommandBlogList = blogRepository.getRecommandBlogs(title);
			    request.setAttribute("recommandArticleList", recommandBlogList);
			    
			    List<Blogs> blogsList = blogRepository.getAllBlogsByPageId(category,page_id - 1);
				request.setAttribute("blogsList", blogsList);
			    
			    request.setAttribute("page", "blog-title");
			    request.setAttribute("jsp", "../common/blog-details.jsp");
			    
			    return "layout/layout";
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/subscribeForEmail")
	public void subscribeForEmail(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		CommonResponse commonResponse = new CommonResponse();
		
		try
		{
			String email = request.getParameter("email");
			String page = request.getParameter("page");
			if(email == null){email = "";}
			if(page == null){page = "Website - home";}
			email = email.trim();
			page = page.trim();
			
            String validationErrorMsg = "";
			
			if(validationErrorMsg.equalsIgnoreCase("")) {
				if(ESAPI.validator().isValidInput("email", request.getParameter("email"), "Email", 100, false) && validationErrorMsg.equalsIgnoreCase(""))
				{
					email = request.getParameter("email");
				}
				else
				{
					validationErrorMsg = "Please enter a valid email address";
				}
				if(email.length() <= 5) 
				{
					validationErrorMsg = "Please enter a valid email address";
				}
			}
			
			if(!validationErrorMsg.equalsIgnoreCase(""))
			{
				commonResponse.setStatus(StatusMessage.FailureCode);
				commonResponse.setStatus_msg(StatusMessage.FailureMessage);
				commonResponse.setMsg(validationErrorMsg);
				writer.print(gson.toJson(commonResponse));
    			writer.close();
    			return;
			}
			
			else 
			{
			int id = emailSubscriptionRespository.subscribeForEmail(email, page);
			
			if(id == 0)
			{
				commonResponse.setStatus(StatusCodesAndMessages.FailureCode);
				commonResponse.setStatus_msg(StatusCodesAndMessages.FailureMessage);
				commonResponse.setMsg("The email id is already subscribed with us");
        		writer.print(gson.toJson(commonResponse));
    			writer.close();
    			return;
			}
			sendEmailUtil.sendSubscriberEmail(email, request.getServletContext());
			sendEmailUtil.sendSubscriberConfirmationEmail(email, request.getServletContext());
			commonResponse.setStatus(StatusCodesAndMessages.SuccessCode);
			commonResponse.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
			commonResponse.setMsg("Email id added successfully");
    		writer.print(gson.toJson(commonResponse));
			writer.close();
		   }
		}
		catch(Exception ex)
		{
			commonResponse.setStatus(StatusCodesAndMessages.FailureCode);
			commonResponse.setStatus_msg(StatusCodesAndMessages.FailureMessage);
			commonResponse.setMsg(StatusCodesAndMessages.Error);
    		writer.print(gson.toJson(commonResponse));
			writer.close();
			ex.printStackTrace();
		}
	}
	
	@RequestMapping("/fd-rates")
	public String fdRates(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "ourproducts");
		request.setAttribute("jsp", "../common/fd-rates.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/contactus")
	public String contactus(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "contactus");
		request.setAttribute("jsp", "../common/contactus.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/mutual-funds")
	public String mutualFunds(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "ourproducts");
		request.setAttribute("subpage", "mutualfunds");
		request.setAttribute("jsp", "../products/mutual-funds.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/life-insurance")
	public String lifeInsurance(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "ourproducts");
		request.setAttribute("subpage", "lifeinsurance");
		request.setAttribute("jsp", "../products/life-insurance.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/general-insurance")
	public String generalInsurance(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "ourproducts");
		request.setAttribute("subpage", "generalinsurance");
		request.setAttribute("jsp", "../products/general-insurance.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/fixed-income")
	public String fixedIncome(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "ourproducts");
		request.setAttribute("subpage", "fixedincome");
		request.setAttribute("jsp", "../products/fixed-income.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/taxation")
	public String taxation(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "ourproducts");
		request.setAttribute("subpage", "taxation");
		request.setAttribute("jsp", "../products/taxation.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/finance-plan")
	public String financePlan(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "ourservices");
		request.setAttribute("subpage", "finplan");
		request.setAttribute("jsp", "../services/finplan.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/retire-plan")
	public String retirePlan(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "ourservices");
		request.setAttribute("subpage", "retireplan");
		request.setAttribute("jsp", "../services/retireplan.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/wedding-plan")
	public String wedplan(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "ourservices");
		request.setAttribute("subpage", "wedplan");
		request.setAttribute("jsp", "../services/wedding.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/wealth-plan")
	public String wealthplan(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "ourservices");
		request.setAttribute("subpage", "wealthplan");
		request.setAttribute("jsp", "../services/wealthplan.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/faq/mutual-funds")
	public String mutualFundsFaq(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "faq");
		request.setAttribute("subpage", "mutual-funds");
		request.setAttribute("jsp", "../faq/mutual-funds.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/faq/financial-planning")
	public String financialPlanningFaq(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "faq");
		request.setAttribute("subpage", "financial-planning");
		request.setAttribute("jsp", "../faq/financial-planning.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/faq/nri-corner")
	public String nriCornerFaq(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "faq");
		request.setAttribute("subpage", "nri-corner");
		request.setAttribute("jsp", "../faq/nri-corner.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/disclaimer") 
	public String disclaimer(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("jsp", "../common/disclaimer.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/careers")
	public String careers(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("jsp", "../common/careers.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/feedback")
	public String feedback(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("jsp", "../common/feedback.jsp");
		return "layout/layout";
	}
	
	@RequestMapping(value="/saveContactUs")
	public void saveContactUs(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		
		PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		CommonResponse commonResponse = new CommonResponse();
		
		try
		{	
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String subject = request.getParameter("subject");
			String message = request.getParameter("message");
			String support_email = request.getParameter("support_email");
			
			if(name == null){name = "";}
			if(email == null){email = "";}
			if(subject == null){subject = "";}
			if(message == null){message = "";}
			if(support_email == null){support_email = "";}
	
			
			name = name.trim();
			email = email.trim();
			subject = subject.trim();
			message = message.trim();
			support_email = support_email.trim();
			
			String validationErrorMsg = "";
			if (validationErrorMsg.equalsIgnoreCase("")) 
			{
				if (ESAPI.validator().isValidInput("name", request.getParameter("name"), "SafeString", 100, true)) 
				{
					name = request.getParameter("name");
				} 
				else 
				{
					validationErrorMsg = "Please enter a valid name";
				}
				if(name.length() <= 3) 
				{
					validationErrorMsg = "Please enter a valid name";
				}
			}
			
			if (validationErrorMsg.equalsIgnoreCase("")) 
			{
				if (ESAPI.validator().isValidInput("message", request.getParameter("message"), "SafeString", 100,true)) 
				{
					message = request.getParameter("message");
				} 
				else 
				{
					validationErrorMsg = "Please enter a valid message";
				}
				if(message.length() <= 10) 
				{
					validationErrorMsg = "Please enter your message";
				}
			}
			
			
			if (validationErrorMsg.equalsIgnoreCase("")) 
			{
				if (ESAPI.validator().isValidInput("email", request.getParameter("email"), "Email", 100, true)) 
				{
					email = request.getParameter("email");
				} 
				else 
				{
					validationErrorMsg = "Please enter a valid email";
				}
				if(email.length() <= 5) 
				{
					validationErrorMsg = "Please enter a valid email";
				}
			}
			
			
			if (validationErrorMsg.equalsIgnoreCase("")) 
			{
				if (ESAPI.validator().isValidInput("subject", request.getParameter("subject"), "SafeString", 100, true)) 
				{
					subject = request.getParameter("subject");
				} 
				else 
				{
					validationErrorMsg = "Please enter a valid subject";
				}
				if(subject.length() <= 10) 
				{
					validationErrorMsg = "Please enter a valid subject";
				}
			}
			
			
			if (validationErrorMsg.equalsIgnoreCase("")) 
			{
				if (ESAPI.validator().isValidInput("support_email", request.getParameter("support_email"), "Email", 100, true)) 
				{
					support_email = request.getParameter("support_email");
				} 
				else 
				{
					validationErrorMsg = "Please enter a valid email";
				}
				if(email.length() <= 5) 
				{
					validationErrorMsg = "Please enter a valid email";
				}
			}
			
			if(!validationErrorMsg.isEmpty())
			{
				commonResponse.setStatus(StatusMessage.FailureCode);
				commonResponse.setStatus_msg(StatusMessage.FailureMessage);
				commonResponse.setMsg(validationErrorMsg);
				writer.println(gson.toJson(commonResponse));
			}
			
			else 
			{
			ContactFeedback  savefeedback = new ContactFeedback();
			savefeedback.setName(name);
		    savefeedback.setEmail(email);
			savefeedback.setSubject(subject);
			savefeedback.setMessage(message);
			savefeedback.setMobile("");
			savefeedback.setClient_name("dakshin");
			contactFeedbackRepository.saveContactUs(savefeedback);
	      
			sendEmailUtil.sendContactDetails(name,email,subject,message,support_email);
			
			sendEmailUtil.sendUserContactConformation(name,email,support_email);
			
	        commonResponse.setStatus(StatusCodesAndMessages.SuccessCode);
	        commonResponse.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
	        commonResponse.setMsg("Contact details added successfully");
	 		writer.println(gson.toJson(commonResponse));
	 		writer.close();
			
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/saveFeedback")
	public void saveFeedback(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		
		PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		CommonResponse commonResponse = new CommonResponse();
		
		try
		{	
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String mobile = request.getParameter("mobile");
			String city = request.getParameter("city");
			String message = request.getParameter("message");
			String support_email = request.getParameter("support_email");
			
			if(name == null){name = "";}
			if(email == null){email = "";}
			if(mobile == null){mobile = "";}
			if(city == null){city = "";}
			if(message == null){message = "";}
			if(support_email == null){support_email = "";}
	
			
			name = name.trim();
			email = email.trim();
			mobile = mobile.trim();
			city = city.trim();
			message = message.trim();
			support_email = support_email.trim();
			
			sendEmailUtil.sendFeedbackDetails(name, email, mobile, city, message,support_email);
			
			sendEmailUtil.sendUserfeedbackconfirmation(name,email,support_email);
			
	        commonResponse.setStatus(StatusCodesAndMessages.SuccessCode);
	        commonResponse.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
	        commonResponse.setMsg("Contact details added successfully");
	 		writer.println(gson.toJson(commonResponse));
	 		writer.close();
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping(value="/sendCareersEmail")
	public void sendCareersEmail(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		
		PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		CommonResponse commonResponse = new CommonResponse();
		
		try
		{	
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String mobile = request.getParameter("mobile");
			String address = request.getParameter("address");
			String qualification = request.getParameter("qualification");
			String skills = request.getParameter("skills");
			String experience = request.getParameter("experience");
			String dob = request.getParameter("dob");
			String age = request.getParameter("age");
			String prev_emp = request.getParameter("prev_emp");
			
			if(name == null){name = "";}
			if(email == null){email = "";}
			if(mobile == null){mobile = "";}
			if(address == null){address = "";}
			if(qualification == null){qualification = "";}
			if(skills == null){skills = "";}
			if(experience == null){experience = "";}
			if(dob == null){dob = "";}
			if(age == null){age = "";}
			if(prev_emp == null){prev_emp = "";}	
			
			name = name.trim();
			email = email.trim();
			mobile = mobile.trim();
			address = address.trim();
			qualification = qualification.trim();
			skills = skills.trim();
			experience = experience.trim();
			dob = dob.trim();
			age = age.trim();
			prev_emp = prev_emp.trim();
			
			
			sendEmailUtil.sendCareerDetails(name, email, mobile, address, qualification, skills,
											experience, dob, age, prev_emp);
			
			sendEmailUtil.sendCareerConfirmation(name,email);
			
	        commonResponse.setStatus(StatusCodesAndMessages.SuccessCode);
	        commonResponse.setStatus_msg(StatusCodesAndMessages.SuccessMessage);
	        commonResponse.setMsg("Career details mail sent successfully");
	 		writer.println(gson.toJson(commonResponse));
	 		writer.close();
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	@RequestMapping("/aboutus")
	public String aboutus(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "aboutus");
		request.setAttribute("jsp", "../common/aboutus.jsp");
		return "layout/layout";
	}
	
	@RequestMapping("/privacy_policy")
	public String privacy_policy(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("page", "privacy_policy");
		request.setAttribute("jsp", "../common/privacy-policy.jsp");
		return "layout/layout";
	}
	
	@RequestMapping(value="/mutual-funds-research/factsheet")
	public String download_factsheet(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	   		
			List<String> amcList = commonDao.getAmcforFactsheet();
    		request.setAttribute("amcList", amcList);
			
			Map<String, String> breadCrumbsMap = new LinkedHashMap<String, String>();
			breadCrumbsMap.put("Home", "/");
			breadCrumbsMap.put("Mutual Funds Research", "/mutual-funds-research");
			breadCrumbsMap.put("Mutual Fund Fact Sheets", "");
			request.setAttribute("breadCrumbsMap", breadCrumbsMap);
			
			request.setAttribute("menu", "Performance");
	     	request.setAttribute("submenu", "Factsheet");
	     	
	     	request.setAttribute("headermenu", "mutual-funds");
	     	request.setAttribute("page", "factsheet");
	     	request.setAttribute("jsp", "../amfi/factsheet.jsp");
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/mutual-funds-research/factsheet/{amc}")
	public String getFactsheet(@PathVariable(value="amc") String amc,
			HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		return "forward:/mutual-funds-research/factsheet/" + amc + "/2015";
	}
	
	
	@RequestMapping(value="/mutual-funds-research/factsheet/{amc}/{year}")
	public String getFactsheetName(@PathVariable(value="amc") String amc, 
			@PathVariable(value="year") String year, 
			HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try 
		{	   		
    		if(amc == null || StringHelper.isEmpty(amc)){amc = "Axis-Mutual-Fund";}
			if(year == null || StringHelper.isEmpty(year) || !year.matches("[0-9]+")){year = "2018";}
			
			amc = amc.trim();
			year = year.trim();
			
			String amc_name = amc.replaceAll("-", " ");
			
			request.setAttribute("amc_name", amc_name);
			request.setAttribute("year", year);
			
			List<String> amcList = commonDao.getAmcforFactsheet();
    		request.setAttribute("amcList", amcList);
			
			List<String> year_list = commonDao.getFactsheetYearsByAmc(amc_name);
			request.setAttribute("year_list", year_list);
			
    		List<DownloadCenter> factsheet_list = commonDao.getFactsheetByAmcAndYear(amc_name, year);
    		request.setAttribute("factsheet_list", factsheet_list);
    		
    		Map<String, String> breadCrumbsMap = new LinkedHashMap<String, String>();
			breadCrumbsMap.put("Home", "/");
			breadCrumbsMap.put("Mutual Funds Research", "/mutual-funds-research");
			breadCrumbsMap.put("Mutual Fund Fact Sheets", "");
			request.setAttribute("breadCrumbsMap", breadCrumbsMap);
			
			request.setAttribute("menu", "Performance");
	     	request.setAttribute("submenu", "Factsheet");
	     	
	     	request.setAttribute("headermenu", "mutual-funds");
	     	request.setAttribute("page", "factsheet_amc");
	     	request.setAttribute("jsp", "../amfi/factsheet.jsp");
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
	
	@RequestMapping(value="/.well-known/pki-validation/godaddy.html")
	public String asdsadsadsada(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		try
		{	
	
		}
		catch(Exception ex)
		{
		ex.printStackTrace();
		}
	
		return "common/godaddy";
	}	
}
