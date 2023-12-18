package com.dakshin.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Repository;

import com.cribbstechnologies.clients.mandrill.exception.RequestFailedException;
import com.cribbstechnologies.clients.mandrill.model.MandrillAttachment;
import com.cribbstechnologies.clients.mandrill.model.MandrillHtmlMessage;
import com.cribbstechnologies.clients.mandrill.model.MandrillMessageRequest;
import com.cribbstechnologies.clients.mandrill.model.MandrillRecipient;
import com.cribbstechnologies.clients.mandrill.model.response.message.SendMessageResponse;
import com.cribbstechnologies.clients.mandrill.request.MandrillMessagesRequest;
import com.cribbstechnologies.clients.mandrill.request.MandrillRESTRequest;
import com.cribbstechnologies.clients.mandrill.util.MandrillConfiguration;
import com.dakshin.dao.LogEmailRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itextpdf.text.pdf.codec.Base64;
import freemarker.template.SimpleHash;

@SuppressWarnings("deprecation")
@Repository
public class SendEmailUtil 
{
	@Autowired
	ServletContext servletContext;
		
	@Autowired
	HttpServletRequest httpServletRequest;
	
	@Autowired
	LogEmailRepository logEmailRepository;
	
	@Autowired
    private Environment env;
	
	
	@SuppressWarnings("unused")
	@Async
	public void sendMail(MailMessage mailMessage)
	{
		try {
			
			MandrillRESTRequest request = new MandrillRESTRequest();
			MandrillConfiguration config = new MandrillConfiguration();
			MandrillMessagesRequest messagesRequest = new MandrillMessagesRequest();
			ObjectMapper mapper = new ObjectMapper();
			
			HttpClient client = new DefaultHttpClient();
			request.setHttpClient(client);
			
			config.setApiKey("29p0v41a9IZr1PyR65__iw");
			config.setApiVersion("1.0");
			config.setBaseURL("https://mandrillapp.com/api");
			
			request.setConfig(config);
			request.setObjectMapper(mapper);
			messagesRequest.setRequest(request);
			
			MandrillMessageRequest mmr = new MandrillMessageRequest();
			MandrillHtmlMessage message = new MandrillHtmlMessage();
			Map<String, String> headers = new HashMap<String, String>();
			
			message.setFrom_email(mailMessage.getFrom());
			message.setFrom_name(mailMessage.getSenderName());
			message.setHeaders(headers);
			message.setHtml(mailMessage.getMessage());
			message.setSubject(mailMessage.getSubject());
			
			int recipient_size = mailMessage.getToList().size() + mailMessage.getCcList().size() + mailMessage.getBccList().size();
			MandrillRecipient[] recipients = new MandrillRecipient[recipient_size];
			int i = 0;
			
			// add To recipients
			List<String> toRecip = mailMessage.getToList();
			if (toRecip.size() > 0)
			{
				for (String email : toRecip) 
				{
					recipients[i++] = new MandrillRecipient("", email, "to");
				}
			}
			
			// add CC recipients
			List<String> ccRecip = mailMessage.getCcList();
			if (ccRecip.size() > 0)
			{
				for (String email : ccRecip) 
				{
					recipients[i++] = new MandrillRecipient("", email, "cc");
				}
			}
			
			// add CC recipients
			List<String> bccRecip = mailMessage.getBccList();
			if (bccRecip.size() > 0)
			{
				for (String email : bccRecip) 
				{
					recipients[i++] = new MandrillRecipient("", email, "bcc");
				}
			}
						
			message.setTo(recipients);
			message.setTrack_clicks(true);
			message.setTrack_opens(true);
			
			// Add Attachments
			List<String> attachments_arr = mailMessage.getAttachmentFiles();
			if (attachments_arr.size() > 0)
			{
				List<MandrillAttachment> messageContentList = new ArrayList<MandrillAttachment>();
				for (String fileName : attachments_arr) 
				{					
					File file = new File(fileName);
					String name = file.getName();
					String type = httpServletRequest.getServletContext().getMimeType(name);
				    String content = Base64.encodeFromFile(file.getPath());
					
				    MandrillAttachment messageContent = new MandrillAttachment(type, name, content);
				    messageContentList.add(messageContent);
				}
				message.setAttachments(messageContentList);
			}		
			mmr.setMessage(message);
			SendMessageResponse response = messagesRequest.sendMessage(mmr);
			
			String toList = "";
			for(int k = 0; k < toRecip.size(); k++)
			{
				if(k == (toRecip.size()-1))
				{
					toList += toRecip.get(k);
				}else{
					toList += toRecip.get(k) + ",";
				}
			}
			
			String ccList = "";
			for(int k = 0; k < ccRecip.size(); k++)
			{
				if(k == (ccRecip.size()-1))
				{
					ccList += ccRecip.get(k);
				}else{
					ccList += ccRecip.get(k) + ",";
				}
			}
			
			String bccList = "";
			for(int k = 0; k < bccRecip.size(); k++)
			{
				if(k == (bccRecip.size()-1))
				{
					bccList += bccRecip.get(k);
				}else{
					bccList += bccRecip.get(k) + ",";
				}
			}
			
			logEmailRepository.saveEmailLog(toList, ccList, bccList, mailMessage.getSubject(), mailMessage.getMessage());
			
		} catch (RequestFailedException e) {
			e.printStackTrace();
		}
	}
	
	public void sendSubscriberEmail(String email, ServletContext context) throws Exception 
    {	    	
		try 
		{
			String subject = "Dakshin Capital Email Subscription";
			
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("email", email);
			
			String message = FTLHelper.getMailBody(simpleHash, "subscribe.ftl", context);
			MailMessage mailMessage = new MailMessage(subject, message);
			
			mailMessage.setSenderName(env.getProperty("support_name"));
			mailMessage.setFrom(env.getProperty("support_email"));
			
			List<String> toAddress = new ArrayList<String>();
			String to = env.getProperty("admin_email");
			toAddress.add(to);
			mailMessage.setToList(toAddress);
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{			
			ex.printStackTrace();
		}
	}
	
	public void sendSubscriberConfirmationEmail(String email, ServletContext context) throws Exception 
    {	    	
		try 
		{
			String subject = "Dakshin Capital Email Subscription Confirmation";
			
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("email", email);
			
			String message = FTLHelper.getMailBody(simpleHash, "welcomeuser.ftl", context);
			MailMessage mailMessage = new MailMessage(subject, message);
			
			mailMessage.setSenderName(env.getProperty("support_name"));
			mailMessage.setFrom(env.getProperty("support_email"));
			
			List<String> toAddress = new ArrayList<String>();
			toAddress.add(email);
			mailMessage.setToList(toAddress);
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{			
			ex.printStackTrace();
		}
	}
	
	public void sendContactDetails(String name,String email,String subject,String message,String support_email) throws Exception 
	{
		try 
		{
			String subject1 = "Dakshin Capital - Contact Us";
			
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("name", name);
			simpleHash.put("email", email);
			simpleHash.put("subject", subject);
			simpleHash.put("message", message);
			
			String message1 = FTLHelper.getMailBody(simpleHash, "contactdetails.ftl", servletContext);
			MailMessage mailMessage = new MailMessage(subject1, message1);
		
			mailMessage.setSenderName(env.getProperty("support_name"));
			mailMessage.setFrom(env.getProperty("support_email"));
			
			List<String> toAddress = new ArrayList<String>();
			toAddress.add(env.getProperty("admin_email"));
			mailMessage.setToList(toAddress);
			
			/*List<String> bccAddress = new ArrayList<String>();
			toAddress.add(properties.getSupport_email());
			mailMessage.setBccList(bccAddress);*/ 
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	public void sendFeedbackDetails(String name,String email, String mobile,
			String city, String message,String support_email) throws Exception 
	{
		try 
		{
			String subject1 = "Dakshin Capital - Feedback";
			
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("name", name);
			simpleHash.put("email", email);
			simpleHash.put("mobile", mobile);
			simpleHash.put("city", city);
			simpleHash.put("message", message);
			
			String message1 = FTLHelper.getMailBody(simpleHash, "feedbackdetails.ftl", servletContext);
			MailMessage mailMessage = new MailMessage(subject1, message1);
		
			mailMessage.setSenderName(env.getProperty("support_name"));
			mailMessage.setFrom(env.getProperty("support_email"));
			
			List<String> toAddress = new ArrayList<String>();
			toAddress.add(env.getProperty("admin_email"));
			mailMessage.setToList(toAddress);
			
			/*List<String> bccAddress = new ArrayList<String>();
			toAddress.add(properties.getSupport_email());
			mailMessage.setBccList(bccAddress);*/ 
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	public void sendCareerDetails(String name,String email,String mobile,String address,String qualification,
						String skills,String experience,String dob,String age,String prev_emp) throws Exception 
	{
		try 
		{
			String subject1 = "Dakshin Capital - Career Application";
			
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("name", name);
			simpleHash.put("address", address);
			simpleHash.put("mobile", mobile);
			simpleHash.put("email", email);
			simpleHash.put("qualification", qualification);
			simpleHash.put("skills", skills);
			simpleHash.put("experience", experience);
			simpleHash.put("dob", dob);
			simpleHash.put("age", age);
			simpleHash.put("prev_emp", prev_emp);
			
			
			String message1 = FTLHelper.getMailBody(simpleHash, "careersdetails.ftl", servletContext);
			MailMessage mailMessage = new MailMessage(subject1, message1);
		
			mailMessage.setSenderName(env.getProperty("support_name"));
			mailMessage.setFrom(env.getProperty("support_email"));
			
			List<String> toAddress = new ArrayList<String>();
			toAddress.add(env.getProperty("admin_email"));
			mailMessage.setToList(toAddress);
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	public void sendUserfeedbackconfirmation(String name,String email,String support_email) throws Exception 
	{
		try 
		{
			String subject2 = "Dakshin Capital - Feedback Confirmation";
			
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("name", name);
			simpleHash.put("email", email);
			
			String message2 = FTLHelper.getMailBody(simpleHash, "feedbackconfirmation.ftl", servletContext);
			MailMessage mailMessage = new MailMessage(subject2, message2);
		
			mailMessage.setSenderName(env.getProperty("support_name"));
			mailMessage.setFrom(env.getProperty("support_email"));
			
			List<String> toAddress = new ArrayList<String>();
			toAddress.add(email);
			mailMessage.setToList(toAddress);
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	public void sendUserContactConformation(String name,String email,String support_email) throws Exception 
	{
		try 
		{
			String subject2 = "Dakshin Capital - Contact Confirmation";
			
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("name", name);
			simpleHash.put("email", email);
			
			String message2 = FTLHelper.getMailBody(simpleHash, "userdetails.ftl", servletContext);
			MailMessage mailMessage = new MailMessage(subject2, message2);
		
			mailMessage.setSenderName(env.getProperty("support_name"));
			mailMessage.setFrom(env.getProperty("support_email"));
			
			List<String> toAddress = new ArrayList<String>();
			toAddress.add(email);
			mailMessage.setToList(toAddress);
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	public void sendCareerConfirmation(String name,String email) throws Exception 
	{
		try 
		{
			String subject2 = "Dakshin Capital - Careers";
			
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("name", name);
			simpleHash.put("email", email);
			
			String message2 = FTLHelper.getMailBody(simpleHash, "careersconfirmation.ftl", servletContext);
			MailMessage mailMessage = new MailMessage(subject2, message2);
		
			mailMessage.setSenderName(env.getProperty("support_name"));
			mailMessage.setFrom(env.getProperty("support_email"));
			
			List<String> toAddress = new ArrayList<String>();
			toAddress.add(email);
			mailMessage.setToList(toAddress);
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	public void sendVerificationCode(String name, String email, String v_code) throws Exception 
	{
		try 
		{
			String subject = "Dakshin - Verification Code";
			
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("name", name);
			simpleHash.put("v_code", v_code);
			
			String message = FTLHelper.getMailBody(simpleHash, "verificationCode.ftl", servletContext);
			MailMessage mailMessage = new MailMessage(subject, message);
		
			mailMessage.setSenderName(env.getProperty("mail_support_name"));
			mailMessage.setFrom(env.getProperty("mail_support_email"));
			
			List<String> toAddress = new ArrayList<String>();
			toAddress.add(email);
			mailMessage.setToList(toAddress);
			
			List<String> bccAddress = new ArrayList<String>();
			bccAddress.add(env.getProperty("admin_email"));
			mailMessage.setBccList(bccAddress);
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}

	public void sendWelcomeMailForUser(String name, String email, String mobile, String password, String pan) throws Exception 
	{
		try 
		{
			String subject = "Dakshin - New User Details";
			
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("name", name);
			simpleHash.put("mobile", mobile);
			simpleHash.put("email", email);
			simpleHash.put("pan", pan);
			simpleHash.put("password", password);
			
			String message = FTLHelper.getMailBody(simpleHash, "newuserdetails.ftl", servletContext);
			MailMessage mailMessage = new MailMessage(subject, message);
			
			mailMessage.setSenderName(env.getProperty("mail_support_name"));
			mailMessage.setFrom(env.getProperty("mail_support_email"));
			
			List<String> toAddress = new ArrayList<String>();
			toAddress.add(env.getProperty("admin_email"));
			mailMessage.setToList(toAddress);
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}

	public void sendWelcomeMailForSignupUser(String name, String email, String pan, String password) throws Exception 
	{
		try 
		{
			SimpleHash simpleHash = new SimpleHash();
			simpleHash.put("name", name);
			simpleHash.put("login", pan);
			simpleHash.put("password", password);
			
			String mail_support_name = env.getProperty("mail_support_name");
			String mail_support_email = env.getProperty("mail_support_email");
			String subject = "Dakshin - Login Credentials";
			
			String message = FTLHelper.getMailBody(simpleHash, "userlogincredentials.ftl", servletContext);
			MailMessage mailMessage = new MailMessage(subject, message);
		
			mailMessage.setSenderName(mail_support_name);
			mailMessage.setFrom(mail_support_email);
			
			List<String> toAddress = new ArrayList<String>();
			toAddress.add(email);
			mailMessage.setToList(toAddress);
			
			List<String> bccAddress = new ArrayList<String>();
			bccAddress.add(env.getProperty("admin_email"));
			mailMessage.setBccList(bccAddress);
			
			sendMail(mailMessage);
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}	
}

