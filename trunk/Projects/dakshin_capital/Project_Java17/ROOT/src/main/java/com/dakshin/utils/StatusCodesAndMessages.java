package com.dakshin.utils;

public class StatusCodesAndMessages {

	public static Integer SuccessCode = 200;
	 
	public static String SuccessMessage = "Success";
	 
	public static Integer FailureCode = 400;
	 
	public static String FailureMessage = "Failure";
	
	public static String Error = "Error";
	
	public static String Exception = "Exception";
	
	public static Integer SessionExpiredCode = 401;
	 public static String SessionExpiredMessage = "The session has expired";
	
	public static Integer IncorrectOldPasswordCode = 410;
	public static String IncorrectOldPasswordMessage = "The old password entered is incorrect";
	 
	public static Integer InvalidPasswordCode = 411;
	public static String InvalidPasswordMessage = "The password entered is invalid.<br/>The password must contain<br/>1.Minimum of 6 char and maximum of 12 char<br>2.Password must not contain tags like < > etc";
	
}
