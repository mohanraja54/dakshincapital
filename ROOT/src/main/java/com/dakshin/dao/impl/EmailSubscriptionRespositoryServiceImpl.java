package com.dakshin.dao.impl;

import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.annotation.Transactional;

import com.dakshin.dao.EmailSubscriptionRespositoryService;
import com.dakshin.model.EmailSubscription;

@Transactional
public class EmailSubscriptionRespositoryServiceImpl implements EmailSubscriptionRespositoryService {

	@Autowired
	@Qualifier("mfEntityManagerFactory")
	private EntityManager entityManager;
	
	public int subscribeForEmail(String email, String source) {
		int status = 0;
		try {
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<EmailSubscription> q = builder.createQuery(EmailSubscription.class);
			Root<EmailSubscription> root = q.from(EmailSubscription.class);
			q.select(root).where(builder.equal(root.get("email"), email), builder.equal(root.get("client_name"), "dakshin"));
			
			if(entityManager.createQuery(q).getResultList().size() > 0) {
				status = 0;
			}
			else {
				EmailSubscription emailSubscription = new EmailSubscription();
				emailSubscription.setEmail(email);
				emailSubscription.setCreated_date(new Date());
				emailSubscription.setSource(source);
				emailSubscription.setClient_name("dakshin");
				entityManager.persist(emailSubscription);
				status = emailSubscription.getId();
			}
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return status;
	}
}
