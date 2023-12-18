package com.dakshin.dao.impl;

import java.util.Date;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.annotation.Transactional;

import com.dakshin.dao.LogEmailRepositoryService;
import com.dakshin.model.LogEmail;

@Transactional
public class LogEmailRepositoryServiceImpl implements LogEmailRepositoryService {

	@Autowired
	@Qualifier("mfEntityManagerFactory")
	private EntityManager entityManager;
	
	@Override
	public void saveEmailLog(String to_email, String cc_email, String bcc_email, String subject, String content) {
		try 
		{
			Date today = new Date();
			LogEmail emailLog = new LogEmail();
			emailLog.setSend_date(today);
			emailLog.setTo_email(to_email);
			emailLog.setCc_email(cc_email);
			emailLog.setBcc_email(bcc_email);
			emailLog.setSubject(subject);
			emailLog.setContent(content);
			emailLog.setClient_name("dakshin");
			entityManager.persist(emailLog);
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
}
