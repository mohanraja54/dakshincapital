package com.dakshin.utils;

//http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
public class StatusMessage 
{
	 public static Integer SuccessCode = 200;
	 public static String SuccessMessage = "Success";
	 
	 public static Integer FailureCode = 400;
	 public static String FailureMessage = "Failure";
	public static String Exception = "Exception";
	 
	 public static String Error = "Error";
	 
	 /*** Transaction Types ***/
	 
	 public static String FreshPurchase = "Fresh Purchase";
	 public static String FreshPurchaseSystematic = "Fresh Purchase Systematic";
	 public static String AdditionalPurchase = "Additional Purchase";
	 public static String AdditionalPurchaseSystematic = "Additional Purchase Systematic";
	 public static String SwitchIn = "Switch In";
	 public static String DividendPayout = "Dividend Payout";
	 
	 public static String PartialSwitchOut = "Partial Switch Out";
	 public static String FullSwitchOut = "Full Switch Out";
	 public static String PartialRedemption = "Partial Redemption";
	 public static String FullRedemption = "Full Redemption";
}
