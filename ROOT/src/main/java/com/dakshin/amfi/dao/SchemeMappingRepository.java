package com.dakshin.amfi.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dakshin.amfi.model.SchemeMapping;

public interface SchemeMappingRepository extends JpaRepository<SchemeMapping, Integer>, SchemeMappingService { 


}
