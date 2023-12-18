package com.dakshin.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dakshin.model.Blogs;


public interface BlogRepository extends JpaRepository<Blogs, Integer>, BlogRepositoryService { 
	
}
