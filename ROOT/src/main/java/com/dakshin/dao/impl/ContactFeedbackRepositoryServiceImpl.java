package com.dakshin.dao.impl;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.annotation.Transactional;

import com.dakshin.dao.ContactFeedbackRepositoryService;
import com.dakshin.model.ContactFeedback;

@Transactional
public class ContactFeedbackRepositoryServiceImpl implements ContactFeedbackRepositoryService {
	@Autowired
	@Qualifier("mfEntityManagerFactory")
	private EntityManager entityManager;
	
	public void saveContactUs(ContactFeedback  savefeedback)
	{
		try {
			entityManager.persist(savefeedback);
		}
		catch(Exception ex)
	    {
		   ex.printStackTrace();
	    }
	}
}
