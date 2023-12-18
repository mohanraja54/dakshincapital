package com.dakshin.dao;

public interface LogEmailRepositoryService {
	void saveEmailLog(String to_email, String cc_email, String bcc_email, String subject, String content);
}
