package com.dakshin.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "blogs")
public class Blogs {
	
	private Integer id;
	private String title;
	private String blog_url;
	private String title_folder;
	private String category_name;	 
	private String author_name;
	private String content;
	private String short_content;
	private Date create_date;
	private String photo;
	private String photo_alt;
	private String disqus_url;	
	private Integer viewed_count;
	private String meta_title;
	private String meta_desc;
	private String client_name;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id")
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTitle_folder() {
		return title_folder;
	}
	public void setTitle_folder(String title_folder) {
		this.title_folder = title_folder;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getAuthor_name() {
		return author_name;
	}
	public void setAuthor_name(String author_name) {
		this.author_name = author_name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getDisqus_url() {
		return disqus_url;
	}
	public void setDisqus_url(String disqus_url) {
		this.disqus_url = disqus_url;
	}
	public Integer getViewed_count() {
		return viewed_count;
	}
	public void setViewed_count(Integer viewed_count) {
		this.viewed_count = viewed_count;
	}
	public String getShort_content() {
		return short_content;
	}
	public void setShort_content(String short_content) {
		this.short_content = short_content;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getMeta_title() {
		return meta_title;
	}
	public void setMeta_title(String meta_title) {
		this.meta_title = meta_title;
	}
	public String getMeta_desc() {
		return meta_desc;
	}
	public void setMeta_desc(String meta_desc) {
		this.meta_desc = meta_desc;
	}
	public String getBlog_url() {
		return blog_url;
	}
	public void setBlog_url(String blog_url) {
		this.blog_url = blog_url;
	}
	public String getPhoto_alt() {
		return photo_alt;
	}
	public void setPhoto_alt(String photo_alt) {
		this.photo_alt = photo_alt;
	}
	public String getClient_name() {
		return client_name;
	}
	public void setClient_name(String client_name) {
		this.client_name = client_name;
	}
}
