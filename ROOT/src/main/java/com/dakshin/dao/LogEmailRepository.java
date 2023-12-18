package com.dakshin.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dakshin.model.LogEmail;;

public interface LogEmailRepository extends JpaRepository<LogEmail, Integer>, LogEmailRepositoryService {

}
