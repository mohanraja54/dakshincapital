// **********************************************************
// *
// * Advisor Khoj
// *
// * (C) Copyright 2000-2012
// *
// * eQuadriga Software Private Limited
// * 95, Bharathidasan Salai, Cantonment
// * Trichy - 60001
// * Tamilnadu, India
// *
// * Tel.: +91 431 2418398
// * Fax: +91 431 2418698
// *
// * All rights reserved.
// *
// * www.equadriga.com
// *
// *
// **********************************************************
package com.dakshin.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public class MailMessage {

	private List<String> attachmentFiles = new ArrayList<String>(0);

	private List<String> ccList = new ArrayList<String>(0);

	private List<String> bccList = new ArrayList<String>(0);

	private HashMap<String, String> bccListWithName = new HashMap<String, String>(0);

	private HashMap<String, String> ccListWithName = new HashMap<String, String>(0);

	private String from = "";

	private String message = "";

	private String senderName = "";

	private String subject = "";

	private List<String> toList = new ArrayList<String>(0);

	private HashMap<String, String> toListWithName = new HashMap<String, String>(0);

	private String replyTo = "";

	public MailMessage() {
		
	}
	public MailMessage(String subject, String message) {
		this.subject = subject;
		this.message = message;
	}
	public MailMessage(String from, String to, String subject, String message) {
		this.from = from;
		toList.add(to);
		this.subject = subject;
		this.message = message;
	}
	public List<String> getAttachmentFiles() {
		return attachmentFiles;
	}
	public List<String> getBccList() {
		return bccList;
	}
	public HashMap<String, String> getBccListWithName() {
		return bccListWithName;
	}
	public List<String> getCcList() {
		return ccList;
	}
	public HashMap<String, String> getCcListWithName() {
		return ccListWithName;
	}
	public String getFrom() {
		return from;
	}
	public String getMessage() {
		return message;
	}
	public String getSenderName() {
		return senderName;
	}
	public String getSubject() {
		return subject;
	}
	public List<String> getToList() {
		return toList;
	}
	public HashMap<String, String> getToListWithName() {
		return toListWithName;
	}
	public void setAttachmentFiles(List<String> attachmentFiles) {
		this.attachmentFiles = attachmentFiles;
	}
	public void setBccList(List<String> bccList) {
		this.bccList = bccList;
	}
	public void setBccListWithName(HashMap<String, String> bccListWithName) {
		this.bccListWithName = bccListWithName;
	}
	public void setCcList(List<String> ccList) {
		this.ccList = ccList;
	}
	public void setCcListWithName(HashMap<String, String> ccListWithName) {
		this.ccListWithName = ccListWithName;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getReplyTo() {
		return replyTo;
	}
	public void setReplyTo(String replyTo) {
		this.replyTo = replyTo;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public void setToList(List<String> toList) {
		this.toList = toList;
	}
	public void setToListWithName(HashMap<String, String> toListWithName) {
		this.toListWithName = toListWithName;
	}
}
