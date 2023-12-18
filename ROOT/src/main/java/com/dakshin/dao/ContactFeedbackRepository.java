package com.dakshin.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dakshin.model.ContactFeedback;

public interface ContactFeedbackRepository extends JpaRepository<ContactFeedback, Integer>, ContactFeedbackRepositoryService{

}
