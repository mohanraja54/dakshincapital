<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
#div_fund_2,#div_fund_3,#div_fund_4,#div_fund_5{
	display:none;
}
.panel-body .btn-custom {
    border-radius: 3px;
    padding: 5px 10px;
    text-transform: none;
	letter-spacing: 0;
    margin: 0;
    display: inline-block;
    font-weight: normal;
	text-align: center;
	vertical-align: middle;
	touch-action: manipulation;
	cursor: pointer;
	border: 1px solid transparent;
	white-space: nowrap;
	-moz-user-select: none;
}
.cash_flow_table td, .cash_flow_table th {
    padding: 5px;
    vertical-align: top;
    border-top: 1px solid #dee2e6;
    text-align: center;
}

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

table.dataTable.no-footer{
    border-bottom: 1px solid #dedede;
}
</style>

<script>
function getStartAndEndDate()
{
	if($("#chk_date").is(":checked"))
	{
		var fundname1 = $("#txt_fund1").val();
		var fundname2 = $("#txt_fund2").val();
		var fundname3 = $("#txt_fund3").val();
		var fundname4 = $("#txt_fund4").val();
		var fundname5 = $("#txt_fund5").val();
		var fund_array = new Array();
		
		if(fundname1 == "")
		{
			$("#adv-alert-msg").html("Please select the fund 1");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fund_array.push(fundname1);
		}
		if(fundname2 != "")
		{
			fund_array.push(fundname2);
		}
		if(fundname3 != "")
		{
			fund_array.push(fundname3);
		}
		if(fundname4 != "")
		{
			fund_array.push(fundname4);
		}
		if(fundname5 != "")
		{
			fund_array.push(fundname5);
		}
		var dates_array = new Array();
		for(var k=0;k<fund_array.length;k++)
		{
			var scheme_name = fund_array[k];
			var schemeName = encodeURIComponent(scheme_name);
			
			$.ajaxSetup({async:false});
			$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
		    {
				var schemes = $.trim(data);
				var schemes_obj = jQuery.parseJSON(schemes);
				var schemes_array = $.makeArray(schemes_obj);
				var from = schemes_array[0].split("-");
				var startdate = new Date(from[2], from[1] - 1, from[0]);
				dates_array.push(startdate);
		    },'text');
		}
		dates_array.sort(date_sort_asc);
		var inception_date =  dates_array[0];
		$("#txt_start_date").val(inception_date.format("dd-mm-yyyy"));
	}
}
var date_sort_asc = function (date1, date2) 
{
	if (date1 > date2) return 1;
  	if (date1 < date2) return -1;
  	return 0;
};
function checkStartDate()
{
	var fundname1 = $("#txt_fund1").val();
	var fundname2 = $("#txt_fund2").val();
	var fundname3 = $("#txt_fund3").val();
	var fundname4 = $("#txt_fund4").val();
	var fundname5 = $("#txt_fund5").val();
	var startdate = $("#txt_start_date").val();
	var fund_array = new Array();
	
	if(fundname1 == "")
	{
		$("#adv-alert-msg").html("Please select the fund 1");
   	    $("#adv-alert").modal('show');
		return;
	}else{
		fund_array.push(fundname1);
	}
	if(fundname2 != "")
	{
		fund_array.push(fundname2);
	}
	if(fundname3 != "")
	{
		fund_array.push(fundname3);
	}
	if(fundname4 != "")
	{
		fund_array.push(fundname4);
	}
	if(fundname5 != "")
	{
		fund_array.push(fundname5);
	}
	if(startdate == "")
	{
		$("#adv-alert-msg").html("Please select the start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	var start_date_arr = startdate.split("-");
	var start_date_str = start_date_arr[2] + "-" + start_date_arr[1] + "-" + start_date_arr[0];
	var start_date = new Date(start_date_str);
	for(var k=0;k<fund_array.length;k++)
	{
		var scheme_name = fund_array[k];
		var schemeName = encodeURIComponent(scheme_name);
		var flag = false;
		
		$.ajaxSetup({async:false});
		$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
	    {
			var schemes = $.trim(data);
			var schemes_obj = jQuery.parseJSON(schemes);
			var schemes_array = $.makeArray(schemes_obj);
			var from = schemes_array[0].split("-");
			var scheme_inception_date = new Date(from[2], from[1] - 1, from[0]);
			if(start_date < scheme_inception_date)
			{
				$("#adv-alert-msg").html(scheme_name+" inception date is "+ scheme_inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
		   	    $("#adv-alert").modal('show');
		   	 	flag = true;
				return false;
			}
	    },'text');
		
		if(flag)
		{
			return false;
			break;
		}
	}
}
function gotoTop()
{
	$('html,body').animate({
        scrollTop: 0
    }, 700);
}

function gotoSIPEnhancement()
{
	var fundname = $("#txt_fund1").val();
	var amount = $("#txt_amount").val();
	var startdate = $("#txt_start_date").val();
	var enddate = $("#txt_end_date").val();
	var frequency = $("#sel_frequency").val();
	
	if(fundname == "")
	{
		$("#adv-alert-msg").html("Please select the fund 1");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(amount == "" || isNaN(amount) || parseInt(amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(startdate == "")
	{
		$("#adv-alert-msg").html("Please select the start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(enddate == "")
	{
		$("#adv-alert-msg").html("Please select the end date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(frequency == "0")
	{
		$("#adv-alert-msg").html("Please select the frequency");
   	    $("#adv-alert").modal('show');
		return;
	}
	
	top.location = "/mutual-funds-research/sip-with-annual-increase/"+fundname+"?amount="+amount+"&frequency="+frequency+"&start_date="+startdate+"&end_date="+enddate+"&enhancement_percentage=10";
}

$(document).ready(function(){
	
	initializeTypeAhead();
	
	$('.datepicker').datepicker({
		format: 'dd-mm-yyyy',
		endDate: '-1d',
		autoclose:true,
		disableTouchKeyboard:true
	}).on('changeDate', function(ev) {
		var ID = $(this).attr("id");
		if(ID == "txt_start_date")
		{
			checkStartDate();
		}
	});
	
	var fund = '${fund}';
	if(fund != "")
	{
		var fund_array = fund.split(",");
		for(var k=0;k<fund_array.length;k++)
		{
			var fund_name = fund_array[k];			
			if(k == 0)
			{
				$("#txt_fund1").val(fund_name);
			}
			if(k == 1)
			{
				$("#more_funds_div_1").hide();
				$("#div_fund_2").show();
				$("#txt_fund2").val(fund_name);
			}
			if(k == 2)
			{
				$("#more_funds_div_2").hide();
				$("#div_fund_3").show();
				$("#txt_fund3").val(fund_name);
			}
			if(k == 3)
			{
				$("#more_funds_div_3").hide();
				$("#div_fund_4").show();
				$("#txt_fund4").val(fund_name);
			}
			if(k == 4)
			{
				$("#more_funds_div_4").hide();
				$("#div_fund_5").show();
				$("#txt_fund5").val(fund_name);
			}
		}
	}
	
	$("#cash_flow_0").show();
	
	$('#tbl_scheme_returns').dataTable({
		"searching": false,
        "ordering": false,
        "info":     false,
        "paging":   false,
        "sDom": "lfrti",
        "columns": [
            { "width": "30%" },
            { "width": "15%" },
            { "width": "20%" },
            { "width": "3%" },
            { "width": "3%" },
            { "width": "3%" },
            { "width": "3%" },
            { "width": "15%" },
            { "width": "3%" },
          ]
	});
	
	$("#tbl_scheme_returns1").dataTable({
		"searching": false,
        "ordering": false,
        "info":     false,
        "paging":   false,
        "sDom": "lfrti",
        "columns": [
            { "width": "30%" },
            { "width": "15%" },
            { "width": "20%" },
            { "width": "3%" },
            { "width": "3%" },
            { "width": "3%" },
            { "width": "3%" },
            { "width": "15%" },
            { "width": "3%" },
          ]
	});
});

function initializeTypeAhead()
{	
	$('.txt_fund').typeahead({
	    source: function (query, process) {
	        return $.ajax({
	            url: './autoSuggestAllMfSchemes',
	            type: 'post',
	            data: { 
	            	query: query,
	            	category: $("#sel_schemeCategories").val()
	            },
	            dataType: 'json',
	            success: function (result) {
	                return process(result);
	            }
	        });
	    },
	    items:10,
	    matcher: function(item) {
	        return true;
	    }
	});
}

function getData()
{
	var category = $("#sel_schemeCategories").val();
 	var fundname1 = $("#txt_fund1").val();
	var fundname2 = $("#txt_fund2").val();
	var fundname3 = $("#txt_fund3").val();
	var fundname4 = $("#txt_fund4").val();
	var fundname5 = $("#txt_fund5").val();
	var amount = $("#txt_amount").val();
	var startdate = $("#txt_start_date").val();
	var enddate = $("#txt_end_date").val();
	var frequency = $("#sel_frequency").val();
	var fund_array = new Array();
	
	if(fundname1 == "")
	{
		$("#adv-alert-msg").html("Please select the fund 1");
   	    $("#adv-alert").modal('show');
		return;
	}else{
		fund_array.push(fundname1);
	}
	if(fundname2 != "")
	{
		fund_array.push(fundname2);
	}
	if(fundname3 != "")
	{
		fund_array.push(fundname3);
	}
	if(fundname4 != "")
	{
		fund_array.push(fundname4);
	}
	if(fundname5 != "")
	{
		fund_array.push(fundname5);
	}
	if(amount == "" || isNaN(amount) || parseInt(amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(startdate == "")
	{
		$("#adv-alert-msg").html("Please select the start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(enddate == "")
	{
		$("#adv-alert-msg").html("Please select the end date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(frequency == "0")
	{
		$("#adv-alert-msg").html("Please select the frequency");
   	    $("#adv-alert").modal('show');
		return;
	}
	var start_date_arr = startdate.split("-");
	var start_date_str = start_date_arr[2] + "-" + start_date_arr[1] + "-" + start_date_arr[0];
	var end_date_arr = enddate.split("-");
	var end_date_str = end_date_arr[2] + "-" + end_date_arr[1] + "-" + end_date_arr[0];
	
	var start_date = new Date(start_date_str);
	var end_date = new Date(end_date_str);
	
	if(end_date <= start_date)
	{
		$("#adv-alert-msg").html("Please select valid start date and end date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(frequency == "Monthly")
	{
		start_date.setMonth(start_date.getMonth() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(frequency == "Fortnightly")
	{
		start_date.setDate(start_date.getDate() + 15);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(frequency == "Quarterly")
	{
		start_date.setMonth(start_date.getMonth() + 3);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	
	for(var k=0;k<fund_array.length;k++)
	{
		var scheme_name = fund_array[k];
		var schemeName = encodeURIComponent(scheme_name);
		var flag = false;
		
		$.ajaxSetup({async:false});
		$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
	    {
			var schemes = $.trim(data);
			var schemes_obj = jQuery.parseJSON(schemes);
			var schemes_array = $.makeArray(schemes_obj);
			var from = schemes_array[0].split("-");
			var scheme_inception_date = new Date(from[2], from[1] - 1, from[0]);
			if(start_date < scheme_inception_date)
			{
				$("#adv-alert-msg").html(scheme_name+" inception date is "+ scheme_inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
		   	    $("#adv-alert").modal('show');
		   	 	flag = true;
				return false;
			}
	    },'text');
		
		if(flag)
		{
			return false;
			break;
		}
	}
	
	var scheme_array = new Array();
	for(var k=0;k<fund_array.length;k++)
	{
		var scheme_name = fund_array[k];
		scheme_name = encodeURIComponent(scheme_name);
		scheme_array.push(scheme_name);
	}
	top.location = "/mutual-funds-research/mutual-fund-sip-investment-calculator?category="+category+"&fund="+scheme_array+"&amount="+amount+"&frequency="+frequency+"&startdate="+startdate+"&enddate="+enddate;	
}

function addMoreFund(count)
{
	var fundname1 = $("#txt_fund1").val();
	if(fundname1 == "")
	{
		$("#adv-alert-msg").html("Enter an value for Fund 1");
   	    $("#adv-alert").modal('show');
		return;
	}
	if($("#div_fund_2").is(':visible'))
	{
		var fundname2 = $("#txt_fund2").val();
		if(fundname2 == "")
		{
			$("#adv-alert-msg").html("Enter an value for Fund 2");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if($("#div_fund_3").is(':visible'))
	{
		var fundname3 = $("#txt_fund3").val();
		if(fundname3 == "")
		{
			$("#adv-alert-msg").html("Enter an value for Fund 3");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if($("#div_fund_4").is(':visible'))
	{
		var fundname4 = $("#txt_fund4").val();
		if(fundname4 == "")
		{
			$("#adv-alert-msg").html("Enter an value for Fund 4");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if($("#div_fund_5").is(':visible'))
	{
		var fundname5 = $("#txt_fund5").val();
		if(fundname5 == "")
		{
			$("#adv-alert-msg").html("Enter an value for Fund 5");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	
	if(count == 1)
	{
		$("#more_funds_div_1").hide();
		$("#div_fund_2").show();
	}else if(count == 2)
	{
		$("#more_funds_div_2").hide();
		$("#div_fund_3").show();
	}else if(count == 3)
	{
		$("#more_funds_div_3").hide();
		$("#div_fund_4").show();
	}else if(count == 4)
	{
		$("#more_funds_div_4").hide();
		$("#div_fund_5").show();
	}
}

function removeMoreFund(count)
{
	if(count == 2)
	{
		$("#more_funds_div_1").show();
		$("#div_fund_2").hide();
		$("#txt_fund2").val("");
	}else if(count == 3)
	{
		$("#more_funds_div_2").show();
		$("#div_fund_3").hide();
		$("#txt_fund3").val("");
	}else if(count == 4)
	{
		$("#more_funds_div_3").show();
		$("#div_fund_4").hide();
		$("#txt_fund4").val("");
	}else if(count == 5)
	{
		$("#more_funds_div_4").show();
		$("#div_fund_5").hide();
		$("#txt_fund5").val("");
	}
	
     if($("#transaction_details").is(":visible"))
   	 {
    	 getData();
   	 }
}
function removeFunds(scheme)
{
	
}
var prev_index = 0;
function showCashFlow(index)
{
	$("#cash_flow_"+prev_index).hide();
	$("#cash_flow_"+index).show();
	prev_index = index;
}


function downloadXl()
{
	var category = $("#sel_schemeCategories").val();
 	var fundname1 = $("#txt_fund1").val();
	var fundname2 = "";
	var fundname3 = "";
	var fundname4 = "";
	var fundname5 = "";
	var amount = $("#txt_amount").val();
	var startdate = $("#txt_start_date").val();
	var enddate = $("#txt_end_date").val();
	var frequency = $("#sel_frequency").val();
	var fund_array = new Array();
	
	if(fundname1 == "")
	{
		$("#adv-alert-msg").html("Please select the fund 1");
   	    $("#adv-alert").modal('show');
		return;
	}else{
		fund_array.push(fundname1);
	}
	if($("#txt_fund2").val().length != 0)
	{
		fundname2 = $("#txt_fund2").val();
		if(fundname2 == "")
		{
			$("#adv-alert-msg").html("Please select the fund 2");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fund_array.push(fundname2);
		}
	}
	if($("#txt_fund3").val().length != 0)
	{
		fundname3 = $("#txt_fund3").val();
		if(fundname3 == "")
		{
			$("#adv-alert-msg").html("Please select the fund 3");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fund_array.push(fundname3);
		}
	}
	if($("#txt_fund4").val().length != 0)
	{
		fundname4 = $("#txt_fund4").val();
		if(fundname4 == "")
		{
			$("#adv-alert-msg").html("Please select the fund 4");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fund_array.push(fundname4);
		}
	}
	if($("#txt_fund5").val().length != 0)
	{
		fundname5 = $("#txt_fund5").val();
		if(fundname5 == "")
		{
			$("#adv-alert-msg").html("Please select the fund 5");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fund_array.push(fundname5);
		}
	}
	if(amount == "" || isNaN(amount) || parseInt(amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(startdate == "")
	{
		$("#adv-alert-msg").html("Please select the start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(enddate == "")
	{
		$("#adv-alert-msg").html("Please select the end date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(frequency == "0")
	{
		$("#adv-alert-msg").html("Please select the frequency");
   	    $("#adv-alert").modal('show');
		return;
	}
	var start_date_arr = startdate.split("-");
	var start_date_str = start_date_arr[2] + "-" + start_date_arr[1] + "-" + start_date_arr[0];
	var end_date_arr = enddate.split("-");
	var end_date_str = end_date_arr[2] + "-" + end_date_arr[1] + "-" + end_date_arr[0];
	
	var start_date = new Date(start_date_str);
	var end_date = new Date(end_date_str);
	
	if(end_date <= start_date)
	{
		$("#adv-alert-msg").html("Please select valid start date and end date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(frequency == "Monthly")
	{
		start_date.setMonth(start_date.getMonth() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(frequency == "Fortnightly")
	{
		start_date.setDate(start_date.getDate() + 15);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(frequency == "Quarterly")
	{
		start_date.setMonth(start_date.getMonth() + 3);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	
	var scheme_array = new Array();
	for(var k=0;k<fund_array.length;k++)
	{
		var scheme_name = fund_array[k];
		scheme_name = encodeURIComponent(scheme_name);
		scheme_array.push(scheme_name);
	}
	//top.location = "/mutual-funds-research/downloadMutualFundSIPCalculatorXl?category="+category+"&fund="+scheme_array+"&amount="+amount+"&frequency="+frequency+"&startdate="+startdate+"&enddate="+enddate;
	
	var path = "/mutual-funds-research/downloadMutualFundSIPCalculatorXl?category="+category+"&fund="+scheme_array+"&amount="+amount+"&frequency="+frequency+"&startdate="+startdate+"&enddate="+enddate;
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
	        		//console.log(xhr.response);
	 	            //console.log(xhr.responseText);
	    	    }
	    	    else{
	    	    	top.location =  "/mutual-funds-research/downloadMutualFundSIPCalculatorXl?category="+category+"&fund="+scheme_array+"&amount="+amount+"&frequency="+frequency+"&startdate="+startdate+"&enddate="+enddate+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}


function openLogin(){
	
	var category = $("#sel_schemeCategories").val();
 	var fundname1 = $("#txt_fund1").val();
	var fundname2 = "";
	var fundname3 = "";
	var fundname4 = "";
	var fundname5 = "";
	var amount = $("#txt_amount").val();
	var startdate = $("#txt_start_date").val();
	var enddate = $("#txt_end_date").val();
	var frequency = $("#sel_frequency").val();
	var fund_array = new Array();
	
	if(fundname1 == "")
	{
		$("#adv-alert-msg").html("Please select the fund 1");
   	    $("#adv-alert").modal('show');
		return;
	}else{
		fund_array.push(fundname1);
	}
	if($("#txt_fund2").val().length != 0)
	{
		fundname2 = $("#txt_fund2").val();
		if(fundname2 == "")
		{
			$("#adv-alert-msg").html("Please select the fund 2");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fund_array.push(fundname2);
		}
	}
	if($("#txt_fund3").val().length != 0)
	{
		fundname3 = $("#txt_fund3").val();
		if(fundname3 == "")
		{
			$("#adv-alert-msg").html("Please select the fund 3");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fund_array.push(fundname3);
		}
	}
	if($("#txt_fund4").val().length != 0)
	{
		fundname4 = $("#txt_fund4").val();
		if(fundname4 == "")
		{
			$("#adv-alert-msg").html("Please select the fund 4");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fund_array.push(fundname4);
		}
	}
	if($("#txt_fund5").val().length != 0)
	{
		fundname5 = $("#txt_fund5").val();
		if(fundname5 == "")
		{
			$("#adv-alert-msg").html("Please select the fund 5");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fund_array.push(fundname5);
		}
	}
	if(amount == "" || isNaN(amount) || parseInt(amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(startdate == "")
	{
		$("#adv-alert-msg").html("Please select the start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(enddate == "")
	{
		$("#adv-alert-msg").html("Please select the end date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(frequency == "0")
	{
		$("#adv-alert-msg").html("Please select the frequency");
   	    $("#adv-alert").modal('show');
		return;
	}
	var start_date_arr = startdate.split("-");
	var start_date_str = start_date_arr[2] + "-" + start_date_arr[1] + "-" + start_date_arr[0];
	var end_date_arr = enddate.split("-");
	var end_date_str = end_date_arr[2] + "-" + end_date_arr[1] + "-" + end_date_arr[0];
	
	var start_date = new Date(start_date_str);
	var end_date = new Date(end_date_str);
	
	if(end_date <= start_date)
	{
		$("#adv-alert-msg").html("Please select valid start date and end date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(frequency == "Monthly")
	{
		start_date.setMonth(start_date.getMonth() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(frequency == "Fortnightly")
	{
		start_date.setDate(start_date.getDate() + 15);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(frequency == "Quarterly")
	{
		start_date.setMonth(start_date.getMonth() + 3);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	
	var scheme_array = new Array();
	for(var k=0;k<fund_array.length;k++)
	{
		var scheme_name = fund_array[k];
		scheme_name = encodeURIComponent(scheme_name);
		scheme_array.push(scheme_name);
	}
	downloadPath = "/mutual-funds-research/downloadMutualFundSIPCalculatorXl?category="+category+"&fund="+scheme_array+"&amount="+amount+"&frequency="+frequency+"&startdate="+startdate+"&enddate="+enddate;
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
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Mutual Fund SIP Return Calculator</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
          <div class="row">
		   <div class="col-md-6 col-sm-6">
		      <div class="form-group">
		         <label class="font-600">Select Category</label>
		         <select id="sel_schemeCategories" class="form-control input-sm" data-width="100%">
		            <option value="All">All</option>
		            <c:forEach var="categories" items="${schemeCategories}">
		               <c:choose>
		                  <c:when test="${category eq categories}">
		                     <option selected value="<c:out value="${categories}"/>">
		                     	<c:out value="${categories}"/>
		                     </option>
		                  </c:when>
		                  <c:otherwise>
		                     <c:if test="${categories != 'Fixed Maturity Plans' && categories != 'Gold Funds'}">
		                        <option value="<c:out value="${categories}"/>">
		                        	<c:out value="${categories}"/>
		                        </option>
		                     </c:if>
		                  </c:otherwise>
		               </c:choose>
		            </c:forEach>
		         </select>
		      </div>
		   </div>
		   <div class="col-md-6 col-sm-6" id="div_fund_1">
		      <div class="form-group fund">
		         <label class="font-600">Fund 1</label>
		         <input id="txt_fund1" type="text" data-provide="typeahead" class="txt_fund form-control no-radius input-sm">
		      </div>
		      <div class="form-group" id="more_funds_div_1">
		         <a href="javascript:void(0);" class="stepsAddmore" onclick="addMoreFund(1)"><i class="fa fa-plus-square marginRight10"></i> Add another fund (upto 4)</a>
		      </div>
		   </div>
		</div>
		<div class="row">
		   <div class="col-md-6 col-sm-6" id="div_fund_2">
		      <div class="form-group fund">
		         <label class="font-600">Fund 2</label>
		         <div class="input-group">
		            <input id="txt_fund2" type="text" class="txt_fund form-control input-sm">
		            <span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(2)"><i class="fa fa-close"></i></span>
		         </div>
		      </div>
		      <div class="form-group" id="more_funds_div_2">
		         <a href="javascript:void(0);" class="stepsAddmore" onclick="addMoreFund(2)"><i class="fa fa-plus-square marginRight10"></i> Add another fund (upto 3)</a>
		      </div>
		   </div>
		   <div class="col-md-6 col-sm-6" id="div_fund_3">
		      <div class="form-group fund">
		         <label class="font-600">Fund 3</label>
		         <div class="input-group">
		            <input id="txt_fund3" type="text" class="txt_fund form-control input-sm">
		            <span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(3)"><i class="fa fa-close"></i></span>
		         </div>
		      </div>
		      <div class="form-group" id="more_funds_div_3">
		         <a href="javascript:void(0);" class="stepsAddmore" onclick="addMoreFund(3)"><i class="fa fa-plus-square marginRight10"></i> Add another fund (upto 2)</a>
		      </div>
		   </div>
		</div>
		<div class="row">
		   <div class="col-md-6 col-sm-6" id="div_fund_4">
		      <div class="form-group fund">
		         <label class="font-600">Fund 4</label>
		         <div class="input-group">
		            <input id="txt_fund4" type="text" class="txt_fund form-control input-sm">
		            <span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(4)"><i class="fa fa-close"></i></span>
		         </div>
		      </div>
		      <div class="form-group" id="more_funds_div_4">
		         <a href="javascript:void(0);" class="stepsAddmore" onclick="addMoreFund(4)"><i class="fa fa-plus-square marginRight10"></i> Add another fund (upto 1)</a>
		      </div>
		   </div>
		   <div class="col-md-6 col-sm-6" id="div_fund_5">
		      <div class="form-group fund">
		         <label class="font-600">Fund 5</label>
		         <div class="input-group">
		            <input id="txt_fund5" type="text" class="txt_fund form-control input-sm">
		            <span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(5)"><i class="fa fa-close"></i></span>
		         </div>
		      </div>
		   </div>
		</div>
		<div class="row">
		   <div class="col-md-3 col-sm-3">
		      <div class="form-group">
		         <label class="font-600">Installment Amount</label>
		         <input type="text" id="txt_amount" maxlength="5" class="form-control no-radius input-sm" value="${amount}" />
		      </div>
		   </div>
		   <div class="col-md-3 col-sm-3">
		      <div class="form-group">
		         <label class="font-600 block">Select Frequency</label>
		         <select id="sel_frequency" class="form-control input-sm" data-width="100%">
		            <option value="0">Select</option>
		            <option value="Fortnightly" 
		            <c:if test="${frequency eq 'Fortnightly' }">
		               <c:out value="selected" />
		            </c:if>
		            >Fortnightly</option>
		            <option value="Monthly" 
		            <c:if test="${frequency eq 'Monthly' }">
		               <c:out value="selected" />
		            </c:if>
		            >Monthly</option>
		            <option value="Quarterly" 
		            <c:if test="${frequency eq 'Quarterly' }">
		               <c:out value="selected" />
		            </c:if>
		            >Quarterly</option>
		         </select>
		      </div>
		   </div>
		   <div class="col-md-3 col-sm-3">
		      <div class="form-group">
		         <label class="font-600">Select Start Date</label>
		         <input type="text" id="txt_start_date" value="${start_date}" class="form-control datepicker no-radius input-sm" />
		      </div>
		   </div>
		   <div class="col-md-3 col-sm-3">
		      <div class="form-group">
		         <label class="font-600">Select End Date</label>
		         <input type="text" id="txt_end_date" value="${end_date}" class="form-control datepicker no-radius input-sm" />
		      </div>
		   </div>
		</div>
		<div class="row">
		   <div class="col-md-2 col-sm-2 sub">
		      <div class="form-group">
		         <label class="no-bold"> &nbsp;&nbsp;&nbsp; </label>
		         <div class="marginTop15">
		            <a href="javascript:void(0)" class="btn btn-primary hidden-xs" onclick="getData()" style="width: 80%;">Submit</a>
		         </div>
		      </div>
		   </div>
		   <div class="col-md-4 col-sm-4">
		      <div class="form-group">
		         <div class="checkbox bold-smaller">
		            <label><input id="chk_date" type="checkbox" value="" onchange="getStartAndEndDate()"> Prefill start date with inception date</label>
		         </div>
		      </div>
		   </div>
		   <div class="col-md-6 col-sm-6 font-size-12">To see SIP Returns with Yearly Enhancements scroll down to bottom of the Cash Flow table.</div>
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
	     		
				<div class="col-md-12 col-sm-12 table-responsive mt-1">
				      <table class="table" id="tbl_scheme_returns">
				         <thead class="theadBody">
				            <tr>
				               <th width="200">Fund Name</th>
				               <th class="text-left">Launch Date</th>
				               <th class="text-left">Nav Date</th>
				               <th class="text-center">Nav</th>
				               <th class="text-center">Units</th>
				               <th class="text-center">No of<br/>Installments</th>
				               <th class="text-center">Investment<br/>Amount</th>
				               <th class="text-center">SIP value as on<br/>${end_date}</th>
				               <th class="text-center">XIRR<br/>(%)</th>
				               <!-- <th class="text-center">Action</th> -->
				            </tr>
				         </thead>
				         <tbody>
				            <c:forEach items="${sip_list}" var="sip" varStatus="status">
				               <tr>
				                  <td class="text-left">
				                     <a href='/mutual-funds-research/<c:out value="${sip.scheme}"></c:out>' class="mutual-funds-anchor">
				                        <c:out value="${sip.scheme}"></c:out>
				                     </a>
				                  </td>
				                  <td>
				                     <fmt:formatDate pattern="dd-MM-yyyy" value="${sip.inception_date}" />
				                  </td>
				                  <td>
				                     <fmt:formatDate pattern="dd-MM-yyyy" value="${sip.nav_date}" />
				                  </td>
				                  <td>
				                     <c:out value="${sip.nav}"></c:out>
				                  </td>
				                  <td>
				                     <fmt:formatNumber value="${sip.units}" maxFractionDigits="2" />
				                  </td>
				                  <td class="text-center">
				                     <c:out value="${sip.no_of_installment}"></c:out>
				                  </td>
				                  <td class="text-center">
				                     <fmt:formatNumber value="${sip.invested_amount}" maxFractionDigits="0" />
				                  </td>
				                  <td class="text-center">
				                     <fmt:formatNumber value="${sip.current_value}" maxFractionDigits="0" />
				                  </td>
				                  <td>
				                     <c:out value="${sip.returns}"></c:out>
				                  </td>
				                  <%-- <td><span style="cursor:pointer;" onclick="removeFunds('${nav_list.scheme_name}')"><i class="fa fa-times-circle fa-2x"></i></span></td> --%>
				               </tr>
				            </c:forEach>
				         </tbody>
				      </table>
				</div>
				<div id="transaction_details" class="marginTop20 col-md-12 col-sm-12 table-responsive mt-4">
				   <h2 class='font-size-18 marginBottom10'>Cash Flow</h2>
				   <c:forEach items="${sip_list}" var="scheme_details" varStatus="status">
				      <div class='table-responsive' id="cash_flow_${status.index}" style="display:none;border: 2px solid #ddd;">
				         <table class="table dataTable" id="tbl_scheme_returns1">
				            <tr>
				               <th colspan="7">
				                  <h6 class="height10 font-size-12 bold text-center" style="color:#24A3D8;"><a href="/mutual-funds-research/${scheme_details.scheme}">${scheme_details.scheme}</a></h6>
				               </th>
				            </tr>
				            <tr>
				               <td class="font-600 color-grey" style="font-weight:bold;">Nav Date</td>
				               <td class="font-600 color-grey" style="font-weight:bold;">Nav</td>
				               <td class="font-600 color-grey" style="font-weight:bold;">Cumulative Units</td>
				               <td class="font-600 color-grey" style="font-weight:bold;">Cumulative Invested Amount</td>
				               <td class="font-600 color-grey" style="font-weight:bold;">Market Value</td>
				            </tr>
				            <c:forEach items="${scheme_details.sip_list}" var="scheme">
				               <tr>
				                  <td>
				                     <fmt:formatDate pattern="dd-MM-yyyy" value="${scheme.nav_date}" />
				                  </td>
				                  <td>
				                     <c:out value="${scheme.nav}"></c:out>
				                  </td>
				                  <td>
				                     <fmt:formatNumber value="${scheme.cumulative_units}" maxFractionDigits="2" />
				                  </td>
				                  <td>
				                     <fmt:formatNumber value="${scheme.cumulative_invested_amount}" maxFractionDigits="0" />
				                  </td>
				                  <td>
				                     <fmt:formatNumber value="${scheme.current_value}" maxFractionDigits="0" />
				                  </td>
				               </tr>
				            </c:forEach>
				         </table>
				      </div>
				   </c:forEach>
				</div>
         </div>
      </div>
   </div>
</section>