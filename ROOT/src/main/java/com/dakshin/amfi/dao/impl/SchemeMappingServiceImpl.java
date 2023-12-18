package com.dakshin.amfi.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.dakshin.amfi.dao.SchemeMappingService;
import com.dakshin.amfi.model.SchemeMapping;

public class SchemeMappingServiceImpl  implements SchemeMappingService {

	@Autowired
	@Qualifier("amfiEntityManagerFactory")
	private EntityManager entityManager;
	
	public List<String> getDebtCategories() {
		List<String> list = null;
		try
		{
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<String> q = builder.createQuery(String.class);
			Root<SchemeMapping> root = q.from(SchemeMapping.class);
			
			q.select(root.get("scheme_advisorkhoj_category"))
						.distinct(true)
						.where(builder.equal(root.get("active"), true),
							   builder.equal(root.get("scheme_broad_category"), "Debt Schemes"))
						.orderBy(builder.asc(root.get("scheme_advisorkhoj_category")));
			
			list = entityManager.createQuery(q).getResultList();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return list;
	}
}
