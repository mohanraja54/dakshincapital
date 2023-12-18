package com.dakshin.dao;

public interface EmailSubscriptionRespositoryService {
	int subscribeForEmail(String email, String source);
}
