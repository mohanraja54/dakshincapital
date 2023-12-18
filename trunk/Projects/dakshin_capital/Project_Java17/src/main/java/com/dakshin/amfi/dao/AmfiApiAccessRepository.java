package com.dakshin.amfi.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dakshin.amfi.model.AmfiApiAccess;

public interface AmfiApiAccessRepository extends JpaRepository<AmfiApiAccess, Integer>, AmfiApiAccessRepositoryService{ 
	
	public List<AmfiApiAccess> findByCompany(String company);
}


