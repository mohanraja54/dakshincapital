package com.dakshin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.internal.util.StringHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dakshin.dao.CommonDao;
import com.dakshin.model.Users;
import com.dakshin.response.CommonResponse;
import com.dakshin.utils.StatusMessage;
import com.google.gson.Gson;

@Controller
public class LoginController {
	
	@Autowired
	CommonDao commonDao;
	
	@RequestMapping(value="/validateLogin")
	public void validateLogin(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		CommonResponse commonResponse = new CommonResponse();
		Gson gson = new Gson();
		
		try
		{
			String mobile = request.getParameter("mobile");
			String password = request.getParameter("password");
			String downloadPath = request.getParameter("downloadPath");
			String imageDownload = request.getParameter("imageDownload");
    		String chartId = request.getParameter("chartId");
    		String filename = request.getParameter("filename");
    		String overlap = request.getParameter("overlap");
    		String authcode = request.getParameter("authcode");
			
			if(mobile == null){mobile = "";};
			if(password == null){password = "";};
			
			System.out.println("mobile--->"+mobile);
			System.out.println("password--->"+password);
			
			mobile = mobile.trim();
			password = password.trim();
			
			if(StringHelper.isEmpty(mobile) || StringHelper.isEmpty(password))
			{
				commonResponse.setStatus(StatusMessage.FailureCode);
        		commonResponse.setStatus_msg(StatusMessage.FailureMessage);
        		commonResponse.setMsg("Please enter valid Mobile and Password");
        		writer.print(gson.toJson(commonResponse));
    			writer.close();
    			return;
			}
			
			Users user = commonDao.getUserDetailsByMobile(mobile, password);
			System.out.println("user--->"+user);
	        if(user != null)
	        { 
	        	Integer id = user.getId();
	        	String firstname = user.getName();
	        	Integer type = user.getType_id();
	        	String email = user.getEmail();
	        	String pan = user.getPan();
	        	String city =  user.getCity();
	        	Integer active = user.getActive();
	        	String client_code = user.getBse_client_code();
	        	
	        	if(active == 0)
	        	{
	    			commonResponse.setStatus(StatusMessage.FailureCode);
	        		commonResponse.setStatus_msg(StatusMessage.FailureMessage);
	        		commonResponse.setMsg("Your account has been deactivated.");
	        		writer.print(gson.toJson(commonResponse));
	    			writer.close();
	    			return;
	        	}
	        	
	        	HashMap<String, String> accountMap =  new HashMap<String, String>();
	        	accountMap.put("userid",String.valueOf(id));
	        	accountMap.put("firstname", firstname );
	        	accountMap.put("mobile", mobile );
	        	accountMap.put("email", email );
	        	accountMap.put("usertypeid", String.valueOf(type));
	        	accountMap.put("pan", pan );
	        	accountMap.put("city", city);
	        	accountMap.put("client_code", client_code);
	        	accountMap.put("bse_customer", user.getBse_customer().toString());
        		request.getSession().setAttribute("accountMap", accountMap);
        		
        		if(StringHelper.isNotEmpty(downloadPath))
        		{
        			HashMap<String, String> advisorResourcesMap =  (HashMap<String, String>) request.getSession().getAttribute("advisorResourcesMap");
        			if(advisorResourcesMap == null){advisorResourcesMap =  new HashMap<String, String>();}
        			advisorResourcesMap.put("downloadPath", downloadPath);
        			request.getSession().setAttribute("advisorResourcesMap", advisorResourcesMap);
        			
        		   	request.getSession().setAttribute("downloadPath", downloadPath);
    	        	request.getSession().setAttribute("imageDownload", imageDownload);
            		request.getSession().setAttribute("chartId", chartId);
            		request.getSession().setAttribute("filename", filename);      
            		request.getSession().setAttribute("overlap", overlap);
            		
        			commonResponse.setStatus(StatusMessage.SuccessCode);
        			commonResponse.setStatus_msg(StatusMessage.SuccessMessage);
        			commonResponse.setMsg("reload");
            		writer.print(gson.toJson(commonResponse));
        			writer.close();
        			return;
        		}
        		
        		commonResponse.setStatus(StatusMessage.SuccessCode);
    			commonResponse.setStatus_msg(StatusMessage.SuccessMessage);
    			commonResponse.setMsg(String.valueOf(id));
        		writer.print(gson.toJson(commonResponse));
    			writer.close();
    			return;
	        }
	        
	        Users users = commonDao.checkIfMobileAlreadyExist(mobile);
    		if(users == null)
    		{
    			commonResponse.setStatus(StatusMessage.FailureCode);
        		commonResponse.setStatus_msg(StatusMessage.FailureMessage);
        		commonResponse.setMsg("Your mobile number not registered with us.");
        		writer.print(gson.toJson(commonResponse));
    			writer.close();
    			return;
    		}
    		else
    		{
    			commonResponse.setStatus(StatusMessage.FailureCode);
        		commonResponse.setStatus_msg(StatusMessage.FailureMessage);
        		commonResponse.setMsg("You have entered a wrong password");
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
	
	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		try
		{	
			request.getSession().invalidate();
			request.getSession().removeAttribute("accountMap");
			request.getSession().removeAttribute("downloadPath");
			request.getSession().removeAttribute("imageDownload");
			request.getSession().removeAttribute("chartId");
			request.getSession().removeAttribute("filename");
			request.getSession().removeAttribute("overlap");
			
			request.setAttribute("page", "home");
	     	request.setAttribute("jsp", "../common/home.jsp");
			return "forward:/";
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return "layout/layout";
	}
}
