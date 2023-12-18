<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
#tbl_scheme_returns thead th {
	padding: 2px 10px !important;
	border-bottom: 1px solid #ddd !important;
}
table.dataTable tfoot th, table.dataTable tfoot td {
    border-top: 1px solid #ddd;
}
table.dataTable tbody th, table.dataTable tbody td {
    padding: 10px 10px;
}
.dataTables_wrapper .dataTables_paginate .paginate_button.current,
.dataTables_wrapper .dataTables_paginate .paginate_button.current:hover{
	background: #005e96 !important;
    color: #fff !important;
    border: 0;
    border: 1px solid #005e96 !important;
    border-radius: 0px;
}

.dataTables_wrapper .dataTables_paginate .paginate_button:hover{
	background: #f2f2f2 !important;
    color: #000 !important;
}
.dataTables_wrapper .dataTables_paginate {
    padding-top: 1em;
}
table.dataTable {
    border-bottom: 1px solid #dedede;
}
</style>
<script>
$(document).ready(function(){
	
	$('.datepicker').datepicker({
		format: 'dd-mm-yyyy',
		startDate: '01/01/2000',
		endDate: '-1d',
		autoclose:true,
		disableTouchKeyboard:true
	});
	
	var years = '${years}';
	var end_date = '${end_date}';
    var arr = end_date.split("-");
    var end_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
    var endDate =  new Date(end_date_str);
    var march_date =  new Date("2019-03-31");
    if(endDate > march_date && years > 3)
	{
		$(".color_red").html("* The CPI index for current FY not available. Therefore, Indexation calculated based on the last available CPI index");
	}else
	{
		$(".color_red").html("");
	}
    
    
    var period = '${top_period}';

	var period_sort = 3;
	if(period == "1y" || period == "1w")
	{
		period_sort = 3;
	}
	if(period == "2y" || period == "1m")
	{
		period_sort = 4;
	}
	if(period == "3y" || period == "3m")
	{
		period_sort = 5;
	}
	if(period == "5y" || period == "6m")
	{
		period_sort = 6;
	}
	if(period == "10y" || period == "ytd")
	{
		period_sort = 7;
	}
	if(period == "Since Inception")
	{
		period_sort = 8;
	}
	
	$('#tbl_scheme_returns').dataTable({
		"pageLength": 10,
        "bPaginate": true,
        "bFilter": true,
        "bInfo": true,
        "bSort": true,
        "aoColumnDefs": [
                         { 'bSortable': false, 'aTargets': [ 1,2 ] }
                      ],
        "columns": [
			        	{ "width": "55%" },
			            { "width": "13%" },
			            { "width": "8%" },
			            { "width": "8%" },
			            { "width": "8%" },
			            { "width": "8%" },
			            { "width": "8%" },
			            { "width": "8%" },
			            { "width": "8%" }
                  ]
    }).fnSort([period_sort,'desc']);
	
	$('#sip-submit').click(function(e){
	 	e.preventDefault();
	 	
	 	var amount = $("#txt_fd_amount").val();
	 	var start_date = $("#txt_start_date").val();
	 	var end_date = $("#txt_end_date").val();
	 	var amc = 	$("#sel_amc").val();
	    var category = 	$("#sel_category").val();
	 	var fund = $("#sel_scheme").val();
	 	var tax_rate = $("#sel_tax_rate").val();

	 	if(amount == null || amount == "" || isNaN(amount) || parseFloat(amount)<=0)
	    {
	 		$("#adv-alert-msg").html("Please enter the valid deposit amount");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	if(start_date == null || start_date == "")
	    {
	 		$("#adv-alert-msg").html("Please select start date");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	if(end_date == null || end_date == "")
	    {
	 		$("#adv-alert-msg").html("Please select end date");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	if(amc == null || amc == "")
	 	{
	 		$("#adv-alert-msg").html("Please select AMC");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	 	}
	 	if(category == null || category == "")
	 	{
	 		$("#adv-alert-msg").html("Please select category");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	 	}
	 	if(fund == null || fund == "")
	 	{
	 		$("#adv-alert-msg").html("Please select scheme name");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	 	}
	 	if(tax_rate == null || tax_rate == "" || isNaN(tax_rate) || parseFloat(tax_rate)<=0)
	    {
	 		$("#adv-alert-msg").html("Please select income tax rate");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	var arr = start_date.split("-");
	    var start_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
	    var startDate =  new Date(start_date_str);
	    var arr = end_date.split("-");
	    var end_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
	    var endDate =  new Date(end_date_str);
	    var flag = false;
	    var scheme_inception_date_str = "";
	    var today = new Date();
	    today.setDate(today.getDate() - 1);
	    
	    if(endDate > today)
		{
			$("#adv-alert-msg").html("Please select the end date less than today.");
	   	    $("#adv-alert").modal('show');
			return;
		}
	    
	    var schemeName = encodeURIComponent(fund);
		var flag = false;
		
		$.ajaxSetup({async:false});
		$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
	    {
			var schemes = $.trim(data);
			var schemes_obj = jQuery.parseJSON(schemes);
			var schemes_array = $.makeArray(schemes_obj);
			var from = schemes_array[0].split("-");
			var inception_date = new Date(from[2], from[1] - 1, from[0]);
			if(startDate < inception_date)
			{
				$("#adv-alert-msg").html(fund+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
		   	    $("#adv-alert").modal('show');
		   	 	flag = true;
				return false;
			}
	    },'text');
		
		if(flag)
		{
			return false;
		}
	 	
		document.location =  "/mutual-funds-research/fixed-deposit-vs-debt-funds/"+schemeName+"?amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&category="+category+"&amc="+amc;
	 	
	 	return false;
	});

});
function categoryChange()
{
	var amc = 	$("#sel_amc").val();
    var category = 	$("#sel_category").val();
    var start_date = $("#txt_start_date").val();
    
    if(amc == null || amc == "")
 	{
 		$("#adv-alert-msg").html("Please select AMC");
   	    $("#adv-alert").modal('show');
   	    return false;
 	}
 	if(category == null || category == "")
 	{
 		$("#adv-alert-msg").html("Please select category");
   	    $("#adv-alert").modal('show');
   	    return false;
 	}
 	if(start_date == null || start_date == "")
    {
 		$("#adv-alert-msg").html("Please select start date");
   	    $("#adv-alert").modal('show');
   	    return false;
    }
    
    $.ajaxSetup({async:true});
	$.post("/mutual-funds-research/getSchemeByAmcAndCategoryAndDate", {amc : "" + amc + "",category : "" + category + "", start_date : "" + start_date + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var html = "";
		for (var i = 0; i < schemes_array.length; i++)
	    {
			html += '<option value="' + schemes_array[i]+ '">' + schemes_array[i] + '</option>';
	    }
		$("#sel_scheme").html(html);
		
    },'text');
}
function getData()
{
	var category = $.trim($("#sel_schemeCategories").val());
	var period = $.trim($("#sel_period").val());
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemePerformanceReturns", {category : category, period : period, type : "Open", maxno : 1000}, function(data)
    {
		var schemePerformances = $.trim(data);
		var schemePerformances_obj = jQuery.parseJSON(schemePerformances);
		var schemePerformances_array = $.makeArray(schemePerformances_obj);
        var html = "";
        
        html += "<thead><tr>";
    	html += "<th>Scheme Name</th>";
    	html += "<th>Launch Date</th>";
    	html += "<th>Expense Ratio (%)</th>";
    	
    	if(period == '1w' || period == '1m' || period == '3m' || period == '6m' || period == 'ytd')
    	{
    		html += "<th>1-Week Ret (%)</th>";
        	html += "<th>1-Month Ret (%)</th>";
        	html += "<th>3-Months Ret (%)</th>";
        	html += "<th>6-Months Ret (%)</th>";
        	html += "<th>YTD Ret (%)</th>";
        	html += "<th>1-Year Ret (%)</th>";
    	}
    	if(period == '1y' || period == '2y' || period == '3y' || period == '5y' || period == '10y' || period == 'Since Inception')
    	{
    		html += "<th>1-Year Ret (%)</th>";
        	html += "<th>2-Yrs Ret (%)</th>";
        	html += "<th>3-Yrs Ret (%)</th>";
        	html += "<th>5-Yrs Ret (%)</th>";
        	html += "<th>10-Yrs Ret (%)</th>";
        	html += "<th>Since Launch Ret (%)</th>";
    	}
    	html += "</tr></thead>";
    	html += "<tbody>";
		for (var i = 0; i < schemePerformances_array.length ; i++)
	    {
			var scheme_name = schemePerformances_array[i].scheme_amfi;
			var ytd_returns = schemePerformances_array[i].returns_abs_ytd;
			var one_week_returns = schemePerformances_array[i].returns_abs_7days;	 
	    	var one_month_returns = schemePerformances_array[i].returns_abs_1month;	    	
	    	var three_month_returns = schemePerformances_array[i].returns_abs_3month;  	
	    	var six_month_returns = schemePerformances_array[i].returns_abs_6month;	    	
	    	var one_year_returns = schemePerformances_array[i].returns_abs_1year;
	    	var two_year_returns = schemePerformances_array[i].returns_cmp_2year;
	    	var three_year_returns = schemePerformances_array[i].returns_cmp_3year;
	    	var five_year_returns = schemePerformances_array[i].returns_cmp_5year;
	    	var ten_year_returns = schemePerformances_array[i].returns_cmp_10year;
	    	var inception_returns = schemePerformances_array[i].returns_cmp_inception;
	    	var inception_date = new Date(schemePerformances_array[i].inception_date);
	    	var ter = schemePerformances_array[i].ter;

			one_week_returns = one_week_returns.toFixed(2);
	    	one_month_returns = one_month_returns.toFixed(2);
	    	three_month_returns = three_month_returns.toFixed(2);
	    	six_month_returns = six_month_returns.toFixed(2);
	    	ytd_returns = ytd_returns.toFixed(2);
	    	one_year_returns = one_year_returns.toFixed(2);
	    	two_year_returns = two_year_returns.toFixed(2);
	    	three_year_returns = three_year_returns.toFixed(2);
	    	five_year_returns = five_year_returns.toFixed(2);
	    	ten_year_returns = ten_year_returns.toFixed(2);
	    	inception_returns = inception_returns.toFixed(2);
            
			if(one_week_returns == 0)
    		{
	    		one_week_returns = "-";
    		}
	    	if(one_month_returns == 0)
    		{
	    		one_month_returns = "-";
    		}
	    	if(three_month_returns == 0)
    		{
	    		three_month_returns = "-";
    		}
	    	if(six_month_returns == 0)
    		{
	    		six_month_returns = "-";
    		}
	    	if(ytd_returns == 0)
    		{
	    		ytd_returns = "-";
    		}
	    	if(one_year_returns == 0)
    		{
	    		one_year_returns = "-";
    		}
	    	if(two_year_returns == 0)
    		{
	    		two_year_returns = "-";
    		}
	    	if(three_year_returns == 0)
    		{
	    		three_year_returns = "-";
    		}
	    	if(five_year_returns == 0)
    		{
	    		five_year_returns = "-";
    		}
	    	if(ten_year_returns == 0)
    		{
	    		ten_year_returns = "-";
    		}
	    	if(inception_returns == 0)
    		{
	    		inception_returns = "-";
    		}
	    	
	    	html += "<tr>";
	    	html += "<td class='fund_hover'><a href='/mutual-funds-research/" + scheme_name + "'>" + scheme_name + "</a></td>";
	    	html += "<td>" +  inception_date.format("dd-mm-yyyy");+ "</td>";
	    	html += "<td>" + ter.toFixed(2) + "</td>";
	    	if(period == '1w' || period == '1m' || period == '3m' || period == '6m' || period == 'ytd')
	    	{
	    		html += "<td>" + one_week_returns + "</td>";
		    	html += "<td>" + one_month_returns + "</td>";
	    		html += "<td>" + three_month_returns + "</td>";
		    	html += "<td>" + six_month_returns + "</td>";
		    	html += "<td>" + ytd_returns + "</td>";
		    	html += "<td>" + one_year_returns + "</td>";
	    	}
	    	if(period == '1y' || period == '2y' || period == '3y' || period == '5y' || period == '10y' || period == 'Since Inception')
	    	{
	    		html += "<td>" + one_year_returns + "</td>";
		    	html += "<td>" + two_year_returns + "</td>";
	    		html += "<td>" + three_year_returns + "</td>";
		    	html += "<td>" + five_year_returns + "</td>";
		    	html += "<td>" + ten_year_returns + "</td>";
		    	html += "<td>" + ten_year_returns + "</td>";
	    	}
	    	html += "</tr>";
	    }
		html += "</tbody>"; 
		$('#tbl_scheme_returns').DataTable().destroy();
		$('#tbl_scheme_returns').empty();
    	$('#tbl_scheme_returns').html(html);

    	var period_sort = 3;
    	if(period == "1y" || period == "1w")
    	{
    		period_sort = 3;
    	}
    	if(period == "2y" || period == "1m")
    	{
    		period_sort = 4;
    	}
    	if(period == "3y" || period == "3m")
    	{
    		period_sort = 5;
    	}
    	if(period == "5y" || period == "6m")
    	{
    		period_sort = 6;
    	}
    	if(period == "10y" || period == "ytd")
    	{
    		period_sort = 7;
    	}
    	if(period == "Since Inception")
    	{
    		period_sort = 8;
    	}
    	
    	$('#tbl_scheme_returns').dataTable({
    		"pageLength": 25,
            "bPaginate": true,
            "bFilter": true,
            "bInfo": true,
            "bSort": true,
            "aoColumnDefs": [
                             { 'bSortable': false, 'aTargets': [ 1,2 ] }
                          ],
            "columns": [
		            	{ "width": "55%" },
		                { "width": "13%" },
		                { "width": "8%" },
		                { "width": "8%" },
		                { "width": "8%" },
		                { "width": "8%" },
		                { "width": "8%" },
		                { "width": "8%" },
		                { "width": "8%" }
                      ]
        }).fnSort([period_sort,'desc']);
    	
    },'text');
}


function downloadXl(){
	
	var amount = $("#txt_fd_amount").val();
 	var start_date = $("#txt_start_date").val();
 	var end_date = $("#txt_end_date").val();
 	var amc = 	$("#sel_amc").val();
    var category = 	$("#sel_category").val();
 	var fund = $("#sel_scheme").val();
 	var tax_rate = $("#sel_tax_rate").val();

 	if(amount == null || amount == "" || isNaN(amount) || parseFloat(amount)<=0)
    {
 		$("#adv-alert-msg").html("Please enter the valid deposit amount");
   	    $("#adv-alert").modal('show');
   	    return false;
    }
 	if(start_date == null || start_date == "")
    {
 		$("#adv-alert-msg").html("Please select start date");
   	    $("#adv-alert").modal('show');
   	    return false;
    }
 	if(end_date == null || end_date == "")
    {
 		$("#adv-alert-msg").html("Please select end date");
   	    $("#adv-alert").modal('show');
   	    return false;
    }
 	if(amc == null || amc == "")
 	{
 		$("#adv-alert-msg").html("Please select AMC");
   	    $("#adv-alert").modal('show');
   	    return false;
 	}
 	if(category == null || category == "")
 	{
 		$("#adv-alert-msg").html("Please select category");
   	    $("#adv-alert").modal('show');
   	    return false;
 	}
 	if(fund == null || fund == "")
 	{
 		$("#adv-alert-msg").html("Please select scheme name");
   	    $("#adv-alert").modal('show');
   	    return false;
 	}
 	if(tax_rate == null || tax_rate == "" || isNaN(tax_rate) || parseFloat(tax_rate)<=0)
    {
 		$("#adv-alert-msg").html("Please select income tax rate");
   	    $("#adv-alert").modal('show');
   	    return false;
    }
 	var arr = start_date.split("-");
    var start_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
    var startDate =  new Date(start_date_str);
    var arr = end_date.split("-");
    var end_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
    var endDate =  new Date(end_date_str);
    var flag = false;
    var scheme_inception_date_str = "";
    var today = new Date();
    today.setDate(today.getDate() - 1);
    
    if(endDate > today)
	{
		$("#adv-alert-msg").html("please select the end date less than today.");
   	    $("#adv-alert").modal('show');
		return;
	}
    
    var schemeName = encodeURIComponent(fund);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var inception_date =  new Date(schemes_array[0]);
		if(startDate < inception_date)
		{
			$("#adv-alert-msg").html(fund+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
 	
	//document.location =  "/mutual-funds-research/fixed-deposit-vs-debt-funds/"+schemeName+"?amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&category="+category+"&amc="+amc;
	//document.location =  "/mutual-funds-research/downloadFixedDepositVsDebtFunds?scheme="+schemeName+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&category="+category+"&amc="+amc;
    
    var path = "/mutual-funds-research/downloadFixedDepositVsDebtFunds?scheme="+schemeName+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&category="+category+"&amc="+amc;
	var xhr = new XMLHttpRequest();
	xhr.open('GET', path, true);
	xhr.responseType = 'text';
	xhr.onload = function () {
	    if (xhr.readyState === xhr.DONE) {
	        if (xhr.status === 200) {
	        	
	        	var contentType = xhr.getResponseHeader("Content-Type");
	        	if(contentType == "application/json;charset=ISO-8859-1"){
	        		var data = JSON.parse(xhr.response);
	        		alert(data.msg);
	    	    }
	    	    else{
	    	    	top.location =  "/mutual-funds-research/downloadFixedDepositVsDebtFunds?scheme="+schemeName+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&category="+category+"&amc="+amc+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
		var amount = $("#txt_fd_amount").val();
	 	var start_date = $("#txt_start_date").val();
	 	var end_date = $("#txt_end_date").val();
	 	var amc = 	$("#sel_amc").val();
	    var category = 	$("#sel_category").val();
	 	var fund = $("#sel_scheme").val();
	 	var tax_rate = $("#sel_tax_rate").val();

	 	if(amount == null || amount == "" || isNaN(amount) || parseFloat(amount)<=0)
	    {
	 		$("#adv-alert-msg").html("Please enter the valid deposit amount");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	if(start_date == null || start_date == "")
	    {
	 		$("#adv-alert-msg").html("Please select start date");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	if(end_date == null || end_date == "")
	    {
	 		$("#adv-alert-msg").html("Please select end date");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	if(amc == null || amc == "")
	 	{
	 		$("#adv-alert-msg").html("Please select AMC");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	 	}
	 	if(category == null || category == "")
	 	{
	 		$("#adv-alert-msg").html("Please select category");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	 	}
	 	if(fund == null || fund == "")
	 	{
	 		$("#adv-alert-msg").html("Please select scheme name");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	 	}
	 	if(tax_rate == null || tax_rate == "" || isNaN(tax_rate) || parseFloat(tax_rate)<=0)
	    {
	 		$("#adv-alert-msg").html("Please select income tax rate");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	var arr = start_date.split("-");
	    var start_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
	    var startDate =  new Date(start_date_str);
	    var arr = end_date.split("-");
	    var end_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
	    var endDate =  new Date(end_date_str);
	    var flag = false;
	    var scheme_inception_date_str = "";
	    var today = new Date();
	    today.setDate(today.getDate() - 1);
	    
	    if(endDate > today)
		{
			$("#adv-alert-msg").html("please select the end date less than today.");
	   	    $("#adv-alert").modal('show');
			return;
		}
	    
	    var schemeName = encodeURIComponent(fund);
		var flag = false;
		
		$.ajaxSetup({async:false});
		$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
	    {
			var schemes = $.trim(data);
			var schemes_obj = jQuery.parseJSON(schemes);
			var schemes_array = $.makeArray(schemes_obj);
			var inception_date =  new Date(schemes_array[0]);
			if(startDate < inception_date)
			{
				$("#adv-alert-msg").html(fund+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
		   	    $("#adv-alert").modal('show');
		   	 	flag = true;
				return false;
			}
	    },'text');
		
		if(flag)
		{
			return false;
		}

		downloadPath = "/mutual-funds-research/downloadFixedDepositVsDebtFunds?scheme="+schemeName+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&category="+category+"&amc="+amc;
		imageDownload = "no";
		chartId = "";
		filename = "";
	$("#adv-login").modal("show");
}
</script>

<section class="main-container mf-research">

	<div class="container-fluid pr-0 pl-0">
	<div class="row ml-0 mr-0">
		<div class="col-md-3 bg-mfbar py-3">
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Fixed Deposit vs Debt Funds</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
                    <div class="row">
                 	<div class="col-md-12 col-sm-12">
		           
           <div class="marginBottom10 headContent">Fixed Deposit</div>
           
           <div class="row">
           <div class="col-md-4 col-sm-4">
	          <div class="form-group">
	            <label class="font-600">Deposit Amount</label>
	            <input type="text" id="txt_fd_amount" value="${amount}" class="form-control no-radius input-sm" />
	          </div>
	        </div>
	        
	        <div class="col-md-4 col-sm-4">
	          <div class="form-group">
	            <label class="font-600">Start Date</label>
	            <input type="text" id="txt_start_date" value="${start_date}" class="form-control datepicker no-radius input-sm" />
	          </div>
	        </div>

	        <div class="col-md-4 col-sm-4">
	          <div class="form-group">
	            <label class="font-600">Start Date</label>
	            <input type="text" id="txt_end_date" value="${end_date}" class="form-control datepicker no-radius input-sm" />
	          </div>
	        </div>
	        </div>
	        
	        
	        <div class="row headRow">
			<div class="col-md-4 col-sm-4">
	            <div class="form-group">
				<label class="font-600">Select Category</label>
                <select id="sel_category" class="form-control input-sm" onchange="categoryChange()">
                <c:forEach var="cat" items="${schemeCategories}" varStatus="status">
                <c:if test="${cat ne 'Debt: Liquid' && cat ne 'Debt: Ultra Short Duration'}">
                <c:choose>
                <c:when test="${cat eq category}">
                <option selected="selected" value="${cat}">${cat}</option>
                </c:when>
                <c:otherwise>
                <option value="${cat}">${cat}</option>
                </c:otherwise>
                </c:choose>
                </c:if>
                </c:forEach>
                </select>
	            </div>
	            <label class="no-bold" style="font-weight: 700;font-size: 12px;color: #000;">To see Top performing debt funds by category and period, please scroll down</label>
            </div>
	        
	        <div class="col-md-4 col-sm-4">
	            <div class="form-group">
				<label class="font-600">Select AMC</label>
                <select id="sel_amc" class="form-control input-sm" onchange="categoryChange()">
                <c:forEach var="company" items="${amcCompanies}" varStatus="status">
                <c:choose>
                <c:when test="${company eq amc}">
                <option selected="selected" value="${company}">${company}</option>
                </c:when>
                <c:otherwise>
                <option value="${company}">${company}</option>
                </c:otherwise>
                </c:choose>
                </c:forEach>
                </select>
	            </div>
            </div>
            
            <div class="col-md-4 col-sm-4">
	            <div class="form-group">
				<label class="font-600">Select Scheme</label>
                <select id="sel_scheme" class="form-control input-sm">
                <c:forEach var="scheme" items="${schemes}" varStatus="status">
                <c:choose>
                <c:when test="${scheme eq scheme_name}">
                <option selected="selected" value="${scheme}">${scheme}</option>
                </c:when>
                <c:otherwise>
                <option value="${scheme}">${scheme}</option>
                </c:otherwise>
                </c:choose>
                </c:forEach>
                </select>
	            </div>
            </div>
            </div>
	        
	        <div class="row headRow marginTop10 marginBottom10">
	        <div class="col-md-3 col-sm-3">
	          <div class="form-group">
	            <label class="font-600">Income Tax Rate</label>
	            <select id="sel_tax_rate" class="form-control input-sm" data-width="100%">
	             <option <c:if test="${tax_rate eq '10' }"><c:out value="selected=\'selected\'" /></c:if> value="10">10</option>
	             <option <c:if test="${tax_rate eq '20' }"><c:out value="selected=\'selected\'" /></c:if> value="20">20</option>
	             <option <c:if test="${tax_rate eq '30' }"><c:out value="selected=\'selected\'" /></c:if> value="30">30</option>
	            </select>
	          </div>
	        </div>
	        
	       <div class="col-md-3 col-sm-3 sub">
	          	<div class="form-group">
	          	<label class="no-bold"> &nbsp;&nbsp;&nbsp; </label>
					<div class="marginTop15">
						<a href="javascript:void(0)" class="btn btn-primary hidden-xs"  style="position: absolute;top: 35%;width: 45%;" id="sip-submit">Submit</a>
					</div>
				</div>
	        </div>
	        </div>
          </div>
                 </div>
		</div>
	</div>
	</div>

   <div class="container-fluid pt-3 pb-3 pr-3 pl-0 calc-tool">
      <div class="row">
         <div class="col-md-3 order-sm-2 order-lg-1 order-2">
            <jsp:include page="../sidebar/mf-sidebar.jsp"></jsp:include>
         </div>
         <div class="col-md-9 order-sm-1 order-lg-2 order-1">
         	 <!-- Download Excel -->
	       	<div class="row" style="margin-left: 0px;margin-right: 0px;margin-bottom: 10px;">
		  		<div class="col-md-6 col-sm-6 col-xs-6 padding-0">	
		  			<span style="font-weight: 700;font-size: 13px;">Data as on - ${nav_date}</span>
	        	</div>
	        	<div class="col-md-6 col-sm-6 col-xs-6 pull-right download_anchor  padding-0">
		        <c:choose>
				  	<c:when test="${empty accountMap.userid}">
				  		<a onClick="openLogin();" style="cursor:pointer;float:right;color:white;text-decoration:none;" class="btn btn-sm btn-success">Download Result</a>					  	
				  	</c:when>
				  	<c:otherwise>
			  			<a onClick="downloadXl();" style="cursor:pointer;float:right;color:white;text-decoration:none;" class="btn btn-sm btn-success">Download Result</a>	
			  	    </c:otherwise>
			  	</c:choose>
		        </div>
	     	</div>
            <div class="col-md-12 col-sm-12 mt-1 table-responsive">
                     <c:if test="${not empty fDvsDebtResponse}">
				      <div class="row tabRow">
				      <div class="col-md-12 col-sm-12 table-responsive mt-1">
				      <table class="table dataTable">
					        <thead class="theadBody">
					            <tr class="bg-color">
					            <th>Pre-Tax Return</th>
					            <th>Investment Amount</th>
					            <th>Redeemed / Maturity Amount</th>
					            <th>Total Interest / Profit Amount</th>
					            <th>Annual Interest / Return (%)</th>
					            </tr>
					        </thead>
					        <tbody>
					        	<tr>
						            <td>Fixed Deposit</td>
						            <td><fmt:formatNumber value="${amount}" maxFractionDigits="0" /></td>      
						            <td><fmt:formatNumber value="${fDvsDebtResponse.fd_investment_value}" maxFractionDigits="0" /></td>
						            <td><fmt:formatNumber value="${fDvsDebtResponse.fd_investment_value - amount}" maxFractionDigits="0" /></td>
						            <td><c:out value="${fDvsDebtResponse.fd_annualized_return}"/></td>
						            </tr>	 
						            <tr>
						            <td><a href='/mutual-funds-research/<c:out value="${fDvsDebtResponse.scheme}"></c:out>' class="mutual-funds-anchor">
						            <c:out value="${fDvsDebtResponse.scheme}"/></a>
						            </td>
						            <td><fmt:formatNumber value="${amount}" maxFractionDigits="0" /></td>  
						           	<td><fmt:formatNumber value="${fDvsDebtResponse.scheme_investment_value}" maxFractionDigits="0" /></td>
						           	<td><fmt:formatNumber value="${fDvsDebtResponse.scheme_investment_value - amount}" maxFractionDigits="0" /></td>
						           	<td><c:out value="${fDvsDebtResponse.scheme_annualized_return}"/></td>
						            </tr>
					                     
					        </tbody>
				       </table>      
				      </div>
				      
				      <div class="col-md-12 col-sm-12 table-responsive mt-4">
				      <table class="table dataTable">
					        <thead class="theadBody">
					            <tr class="bg-color">
					            <th>Post Tax Return</th>
					            <th>Pre-tax Interest / Profit Amount</th>
					            <th>Capital Gains Tax</th>
					            <th>Indexed Amount</th>
					            <th>Income / Capital Gains Tax</th>
					            <th>Post Tax Interest / Profit Amount</th>
					            </tr>
					        </thead>
					        <tbody>
					        	<tr>
					            <td>Fixed Deposit</td>
					            <td><fmt:formatNumber value="${fDvsDebtResponse.fd_investment_value - amount}" maxFractionDigits="0" /></td>
					            <td>Not Applicable</td>
					            <td>Not Applicable</td>
					            <td><fmt:formatNumber value="${fDvsDebtResponse.fd_income_tax}" maxFractionDigits="0" /></td>
					            <td><fmt:formatNumber value="${fDvsDebtResponse.post_tax_fd_investment_value - amount}" maxFractionDigits="0" /></td>
					            </tr>	 
					            <tr>
					            <td><a href='/mutual-funds-research/<c:out value="${fDvsDebtResponse.scheme}"></c:out>' class="mutual-funds-anchor">
					            <c:out value="${fDvsDebtResponse.scheme}"/></a></td>
					            <td><fmt:formatNumber value="${fDvsDebtResponse.scheme_investment_value - amount}" maxFractionDigits="0" /></td>
					            <c:choose>
					            <c:when test="${years > 3}">
					            <td>Long Term</td>
					            <td><fmt:formatNumber value="${fDvsDebtResponse.scheme_indexed_cost_of_purchase}" maxFractionDigits="0" /></td>
					            </c:when>
					            <c:otherwise>
					            <td>Short Term</td>
					            <td>Not Applicable</td>
					            </c:otherwise>
					            </c:choose>
					            <td><fmt:formatNumber value="${fDvsDebtResponse.scheme_income_tax}" maxFractionDigits="0" /></td>
					           	<td><fmt:formatNumber value="${fDvsDebtResponse.post_tax_scheme_investment_value - amount}" maxFractionDigits="0" /></td>
					            </tr>
					                     
					        </tbody>
				       </table>      
				       
				        <div class="row tabRow mt-2">
				      <div class="col-md-12 col-sm-12 marginBottom20">
				      <p style="text-align:justify;font-size:12px;"><b>Note: The Fixed deposit interest rate is based on historical State Bank of India Fixed deposit rates for different deposit terms. Short Term if term is less than 3 years. Long Term if term is more than three Years.</b></p>
				      </div>
				      </div>
				      </div>
				      
				     
				      
				      </div>
				      </c:if>
            </div>
         </div>
      </div>
   </div>
</section>					   