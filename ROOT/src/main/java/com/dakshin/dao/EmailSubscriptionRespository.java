package com.dakshin.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dakshin.model.EmailSubscription;

public interface EmailSubscriptionRespository extends JpaRepository<EmailSubscription, Integer>, EmailSubscriptionRespositoryService {

}
