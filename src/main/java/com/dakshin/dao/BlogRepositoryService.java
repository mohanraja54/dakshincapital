package com.dakshin.dao;

import java.util.List;

import com.dakshin.model.Blogs;

public interface BlogRepositoryService { 
	int getBlogsPageCount(String category_name);
	List<String> getBlogCatgeories();
	List<Blogs> getAllBlogsByPageId(String category,Integer id);
	Blogs getBlogsByTitle(String title);
	List<Blogs> getRecommandBlogs(String title);
	List<Blogs> getLatestBlogs(int maxResults); 
}
