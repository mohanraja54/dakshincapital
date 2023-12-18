package com.dakshin.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.internal.util.StringHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.annotation.Transactional;

import com.dakshin.dao.BlogRepositoryService;
import com.dakshin.model.Blogs;


@Transactional
public class BlogRepositoryServiceImpl implements BlogRepositoryService{

	@Autowired
	@Qualifier("mfEntityManagerFactory")
	private EntityManager entityManager;
	
	@Override
	public int getBlogsPageCount(String category) 
	{
		
		List<Blogs> blogList = null;
		int noOfPages = 1;
		try
		{
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Blogs> q = builder.createQuery(Blogs.class);
			Root<Blogs> root = q.from(Blogs.class);
			
			if(category.equalsIgnoreCase("all") || category == null || category.equalsIgnoreCase("")){
				q.select(root).where(builder.equal(root.get("client_name"), "dakshin")).orderBy(builder.desc(root.get("id")));
			}
			else{
				q.select(root).where(builder.like(root.get("category_name"), "%"+category+"%"),builder.equal(root.get("client_name"), "dakshin")).orderBy(builder.desc(root.get("id")));
			}
			
			blogList = entityManager.createQuery(q).getResultList();
			
			if(blogList.size() > 0)
			{
				noOfPages = ((blogList.size())/3);
				double reminder = (((double)blogList.size())%3);
				if(reminder > 0)
				{
					noOfPages = noOfPages + 1;
				}
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
		return noOfPages;
	}
	
	@Override
	public List<String> getBlogCatgeories()
	{
		List<String> BlogCategory = null;
		try
		{
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<String> q = builder.createQuery(String.class);
			Root<Blogs> root = q.from(Blogs.class);
			q.select(root.get("category_name")).where(builder.equal(root.get("client_name"), "dakshin")).orderBy(builder.asc(root.get("category_name"))).distinct(true);
			BlogCategory = entityManager.createQuery(q).getResultList();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return BlogCategory;
	}
	
	@Override
	public List<Blogs> getAllBlogsByPageId(String category_name,Integer pageId)
	{
		List<Blogs> blogsList = null;
		try {
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Blogs> q = builder.createQuery(Blogs.class);
			Root<Blogs> root = q.from(Blogs.class);
			
			if(StringHelper.isNotEmpty(category_name) && !category_name.equalsIgnoreCase("All"))
			{
				q.select(root).where(builder.equal(root.get("category_name"), category_name),
						builder.equal(root.get("client_name"),"dakshin")).orderBy(builder.desc(root.get("id")));
			}
			else {
				q.select(root).where(builder.equal(root.get("client_name"), "dakshin")).orderBy(builder.desc(root.get("id")));
			}
			
			blogsList = entityManager.createQuery(q).setFirstResult(pageId*3).setMaxResults(3).getResultList();			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return blogsList;
	}
	
	@Override
	public Blogs getBlogsByTitle(String title) 
	{
		Blogs blogs = null;
		try 
		{
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Blogs> q = builder.createQuery(Blogs.class);
			Root<Blogs> root = q.from(Blogs.class);
			q.select(root).where(builder.like(root.get("title"), title+"%"),builder.equal(root.get("client_name"), "dakshin"));
			
			List<Blogs> blogsList = entityManager.createQuery(q).getResultList();
			if(blogsList != null && blogsList.size() > 0)
			{
				blogs = blogsList.get(0);
				int viewed_count = blogs.getViewed_count();
				blogs.setViewed_count(viewed_count+1);
				entityManager.persist(blogs);
			}
		}
		catch(Exception ex)
		{
			//entityManager.getTransaction().rollback();
			ex.printStackTrace();
		}
		return blogs;
	}
	
	@Override
	public List<Blogs> getRecommandBlogs(String title)
	{
		List<Blogs> articleList = null;
		try {
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Blogs> q = builder.createQuery(Blogs.class);
			Root<Blogs> root = q.from(Blogs.class);
			
			if(StringHelper.isNotEmpty(title) && !title.equalsIgnoreCase("All")){
				q.select(root).where(builder.notEqual(root.get("title"), title),builder.equal(root.get("client_name"), "dakshin")).orderBy(builder.desc(root.get("id")));
				
			}
			else{
				q.select(root).where(builder.equal(root.get("client_name"), "dakshin")).orderBy(builder.desc(root.get("id")));
			}
			
			articleList = entityManager.createQuery(q).setMaxResults(10).getResultList();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return articleList;
	}
	
	@Override
	public List<Blogs> getLatestBlogs(int maxResults)
	{
		List<Blogs> blogsList = null;
		try {
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Blogs> q = builder.createQuery(Blogs.class);
			Root<Blogs> root = q.from(Blogs.class);
			q.select(root).where(builder.equal(root.get("client_name"), "dakshin")).orderBy(builder.desc(root.get("id")));
			blogsList = entityManager.createQuery(q).setMaxResults(maxResults).getResultList();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return blogsList;
	}
}
