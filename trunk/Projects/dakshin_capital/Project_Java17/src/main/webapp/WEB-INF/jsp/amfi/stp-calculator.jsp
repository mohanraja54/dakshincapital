<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
table.dataTable{
	border-bottom: 1px solid #dedede;
}
.font-size-18{
	font-weight: 700;
}

</style>
<script>
var stp_count = "";
function changeAmcCompany()
{
    var amc = $("#sel_amc").val();
    
    $.ajaxSetup({async:true});
	$.post("/mutual-funds-research/getSchemeByAmc", {amc : "" + amc + ""}, function(data)
    {
		var scheme = $.trim(data);
		var scheme_obj = jQuery.parseJSON(scheme);
		var scheme_array = $.makeArray(scheme_obj);
		var html = "";
		for (var i = 0; i < scheme_array.length; i++)
	    {
			html += '<option value="' + scheme_array[i]+ '">' + scheme_array[i] + '</option>';
	    }
		$("#sel_from_scheme").html(html);
		
		$("#sel_to_scheme").html(html);
		
    },'text');
}
function checkLumpsumDate()
{
	var from_scheme = $("#sel_from_scheme").val();
    var to_scheme = $("#sel_to_scheme").val();
    var init_start_date = $("#txt_init_start_date").val();
    if(init_start_date == "")
 	{
 		$("#adv-alert-msg").html("Please select lumpsum amount investment date.");
   	    $("#adv-alert").modal('show');
		return;
 	}
    var fromSchemeName = encodeURIComponent(from_scheme);
    var toSchemeName = encodeURIComponent(to_scheme);
	var start_date_arr = init_start_date.split("-");
	var start_date_str = start_date_arr[2] + "-" + start_date_arr[1] + "-" + start_date_arr[0];
	var start_date = new Date(start_date_str);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + fromSchemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(start_date < inception_date)
		{
			$("#adv-alert-msg").html(from_scheme+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a lumpsum amount investement date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
	
	flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + toSchemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(start_date < inception_date)
		{
			$("#adv-alert-msg").html(to_scheme+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a lumpsum amount investement date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
}

function checkSTPDate()
{
	var from_scheme = $("#sel_from_scheme").val();
    var to_scheme = $("#sel_to_scheme").val();
    var from_date = $("#txt_from_date").val();
    if(from_date == "")
 	{
 		$("#adv-alert-msg").html("Please select STP start date.");
   	    $("#adv-alert").modal('show');
		return;
 	}
    var fromSchemeName = encodeURIComponent(from_scheme);
    var toSchemeName = encodeURIComponent(to_scheme);
	var start_date_arr = from_date.split("-");
	var start_date_str = start_date_arr[2] + "-" + start_date_arr[1] + "-" + start_date_arr[0];
	var start_date = new Date(start_date_str);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + fromSchemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(start_date < inception_date)
		{
			$("#adv-alert-msg").html(from_scheme+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a STP start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
	
	flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + toSchemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(start_date < inception_date)
		{
			$("#adv-alert-msg").html(to_scheme+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a STP start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
}
function getData()
{
	var amc = $("#sel_amc").val();
    var from_scheme = $("#sel_from_scheme").val();
    var to_scheme = $("#sel_to_scheme").val();
    var initial_amount = $("#txt_init_amount").val();
    var init_start_date = $("#txt_init_start_date").val();
    var stp_date = $("#sel_stp_date").val();
    var transfer_amount = $("#txt_transfer_amount").val();
    var period = $("#sel_period").val();
    var from_date = $("#txt_from_date").val();
    var to_date = $("#txt_to_date").val();  
    var lumpsum_option = $("#sel_lumpsum_option").val();
    var lumpsum_year = $("#sel_lumpsum_year").val();
		
 	if(initial_amount == "" || transfer_amount == "" || init_start_date == "" || from_date == "" || to_date == "")
 	{
 		$("#adv-alert-msg").html("All fields are mandatory");
   	    $("#adv-alert").modal('show');
		return;
 	}
	if(isNaN(initial_amount) || parseInt(initial_amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid initial amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(isNaN(transfer_amount) || parseInt(transfer_amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid transfer amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(transfer_amount) < 500)
	{
		$("#adv-alert-msg").html("Transfer amount should be greater than 500");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(initial_amount) <= parseInt(transfer_amount))
	{
		$("#adv-alert-msg").html("Please enter the initial amount greater than transfer amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(from_scheme == to_scheme)
	{
		$("#adv-alert-msg").html("Transfer from scheme and to scheme should not be same");
   	    $("#adv-alert").modal('show');
		return;
	}	 
	
	var init_date_arr = init_start_date.split("-");
	var init_date_str = init_date_arr[2] + "-" + init_date_arr[1] + "-" + init_date_arr[0];
	var start_date_arr = from_date.split("-");
	var start_date_str = start_date_arr[2] + "-" + start_date_arr[1] + "-" + start_date_arr[0];
	var end_date_arr = to_date.split("-");
	var end_date_str = end_date_arr[2] + "-" + end_date_arr[1] + "-" + end_date_arr[0];
	
	var init_date = new Date(init_date_str);
	var start_date = new Date(start_date_str);
	var startDate = new Date(start_date_str);
	var end_date = new Date(end_date_str);
	
	if(start_date < init_date)
	{
		$("#adv-alert-msg").html("Please select STP start date less than intial amount start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(end_date <= start_date)
	{
		$("#adv-alert-msg").html("Please select valid start date and end date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(period == "Daily")
	{
		start_date.setDate(start_date.getDate() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Weekly")
	{
		start_date.setDate(start_date.getDate() + 7);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Fortnightly")
	{
		start_date.setDate(start_date.getDate() + 15);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Monthly")
	{
		start_date.setMonth(start_date.getMonth() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Quarterly")
	{			
		start_date.setMonth(start_date.getMonth() + 3);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	
	var fromScheme = encodeURIComponent(from_scheme);
	var toScheme = encodeURIComponent(to_scheme);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + fromScheme + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var from_scheme_inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(startDate < from_scheme_inception_date)
		{
			$("#adv-alert-msg").html(from_scheme+" inception date is "+ from_scheme_inception_date.format("dd-mm-yyyy") +". Please select a STP start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
		if(init_date < from_scheme_inception_date && flag == false)
		{
			$("#adv-alert-msg").html(from_scheme+" inception date is "+ from_scheme_inception_date.format("dd-mm-yyyy") +". Please select a lumpsum amount investement date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + toScheme + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var to_scheme_inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(startDate < to_scheme_inception_date)
		{
			$("#adv-alert-msg").html(to_scheme+" inception date is "+ to_scheme_inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
	
	amc = encodeURIComponent(amc);
	from_scheme = encodeURIComponent(from_scheme);
	to_scheme = encodeURIComponent(to_scheme);
	
 	top.location = "/mutual-funds-research/mutual-fund-stp-investment-calculator?amc="+amc+"&from_scheme="+from_scheme+"&to_scheme="+to_scheme+"&intial_amount="+initial_amount+"&stp_date="+stp_date+"&transfer_amount="+transfer_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date+"&lumpsum_option="+lumpsum_option+"&lumpsum_year="+lumpsum_year;
}

$(document).ready(function(){	
	
	$('.datepicker').datepicker({
		format: 'dd-mm-yyyy',
		endDate: '-1d',
		autoclose:true,
		disableTouchKeyboard:true
	}).on('changeDate', function(ev) {
		var ID = $(this).attr("id");
		if(ID == "txt_init_start_date")
		{
			checkLumpsumDate();
		}
		if(ID == "txt_from_date")
		{
			checkSTPDate();
		}
	});
	
	var amc = '${amc}';
	if(amc != '')
	{
		$("#sel_amc").val(amc);
	}
	
	var from_scheme = '${from_scheme}';
	if(from_scheme != '')
	{
		$("#sel_from_scheme").val(from_scheme);
	}
	
	var to_scheme = '${to_scheme}';
	if(to_scheme != '')
	{
		$("#sel_to_scheme").val(to_scheme);
	}
	
	var stp_date = '${stp_date}';
	if(stp_date != '')
	{
		$("#sel_stp_date").val(stp_date);
	}
	lumpsumOptionChange();
	
});
function gotoTop()
{
	$('html,body').animate({
        scrollTop: 0
    }, 700);
}
function lumpsumOptionChange()
{
	var lumpsum_option = $("#sel_lumpsum_option").val();
	if(lumpsum_option == "LAEP")
	{
		$("#sel_lumpsum_year").attr('disabled', true);
		
	}else{
		$("#sel_lumpsum_year").attr('disabled', false);
	}
}

function downloadXl()
{
	var amc = $("#sel_amc").val();
    var from_scheme = $("#sel_from_scheme").val();
    var to_scheme = $("#sel_to_scheme").val();
    var initial_amount = $("#txt_init_amount").val();
    var init_start_date = $("#txt_init_start_date").val();
    var stp_date = $("#sel_stp_date").val();
    var transfer_amount = $("#txt_transfer_amount").val();
    var period = $("#sel_period").val();
    var from_date = $("#txt_from_date").val();
    var to_date = $("#txt_to_date").val();  
    var lumpsum_option = $("#sel_lumpsum_option").val();
    var lumpsum_year = $("#sel_lumpsum_year").val();
		
 	if(initial_amount == "" || transfer_amount == "" || init_start_date == "" || from_date == "" || to_date == "")
 	{
 		$("#adv-alert-msg").html("All fields are mandatory");
   	    $("#adv-alert").modal('show');
		return;
 	}
	if(isNaN(initial_amount) || parseInt(initial_amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid initial amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(isNaN(transfer_amount) || parseInt(transfer_amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid transfer amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(transfer_amount) < 500)
	{
		$("#adv-alert-msg").html("Transfer amount should be greater than 500");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(initial_amount) <= parseInt(transfer_amount))
	{
		$("#adv-alert-msg").html("Please enter the initial amount greater than transfer amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(from_scheme == to_scheme)
	{
		$("#adv-alert-msg").html("Transfer from scheme and to scheme should not be same");
   	    $("#adv-alert").modal('show');
		return;
	}	 
	
	var init_date_arr = init_start_date.split("-");
	var init_date_str = init_date_arr[2] + "-" + init_date_arr[1] + "-" + init_date_arr[0];
	var start_date_arr = from_date.split("-");
	var start_date_str = start_date_arr[2] + "-" + start_date_arr[1] + "-" + start_date_arr[0];
	var end_date_arr = to_date.split("-");
	var end_date_str = end_date_arr[2] + "-" + end_date_arr[1] + "-" + end_date_arr[0];
	
	var init_date = new Date(init_date_str);
	var start_date = new Date(start_date_str);
	var startDate = new Date(start_date_str);
	var end_date = new Date(end_date_str);
	
	if(start_date < init_date)
	{
		$("#adv-alert-msg").html("Please select STP start date less than intial amount start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(end_date <= start_date)
	{
		$("#adv-alert-msg").html("Please select valid start date and end date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(period == "Daily")
	{
		start_date.setDate(start_date.getDate() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Weekly")
	{
		start_date.setDate(start_date.getDate() + 7);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Fortnightly")
	{
		start_date.setDate(start_date.getDate() + 15);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Monthly")
	{
		start_date.setMonth(start_date.getMonth() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Quarterly")
	{			
		start_date.setMonth(start_date.getMonth() + 3);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	
	var fromScheme = encodeURIComponent(from_scheme);
	var toScheme = encodeURIComponent(to_scheme);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + fromScheme + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var from_scheme_inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(startDate < from_scheme_inception_date)
		{
			$("#adv-alert-msg").html(from_scheme+" inception date is "+ from_scheme_inception_date.format("dd-mm-yyyy") +". Please select a STP start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
		if(init_date < from_scheme_inception_date && flag == false)
		{
			$("#adv-alert-msg").html(from_scheme+" inception date is "+ from_scheme_inception_date.format("dd-mm-yyyy") +". Please select a lumpsum amount investement date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + toScheme + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var to_scheme_inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(startDate < to_scheme_inception_date)
		{
			$("#adv-alert-msg").html(to_scheme+" inception date is "+ to_scheme_inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
	
	amc = encodeURIComponent(amc);
	from_scheme = encodeURIComponent(from_scheme);
	to_scheme = encodeURIComponent(to_scheme);
	
	//top.location = "/mutual-funds-research/mutualFundStpInvestmentCalculator?amc="+amc+"&from_scheme="+from_scheme+"&to_scheme="+to_scheme+"&intial_amount="+initial_amount+"&stp_date="+stp_date+"&transfer_amount="+transfer_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date+"&lumpsum_option="+lumpsum_option+"&lumpsum_year="+lumpsum_year;

	var path = "/mutual-funds-research/mutualFundStpInvestmentCalculator?amc="+amc+"&from_scheme="+from_scheme+"&to_scheme="+to_scheme+"&intial_amount="+initial_amount+"&stp_date="+stp_date+"&transfer_amount="+transfer_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date+"&lumpsum_option="+lumpsum_option+"&lumpsum_year="+lumpsum_year;
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
	    	    	top.location =  "/mutual-funds-research/mutualFundStpInvestmentCalculator?amc="+amc+"&from_scheme="+from_scheme+"&to_scheme="+to_scheme+"&intial_amount="+initial_amount+"&stp_date="+stp_date+"&transfer_amount="+transfer_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date+"&lumpsum_option="+lumpsum_option+"&lumpsum_year="+lumpsum_year+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
	
	var amc = $("#sel_amc").val();
    var from_scheme = $("#sel_from_scheme").val();
    var to_scheme = $("#sel_to_scheme").val();
    var initial_amount = $("#txt_init_amount").val();
    var init_start_date = $("#txt_init_start_date").val();
    var stp_date = $("#sel_stp_date").val();
    var transfer_amount = $("#txt_transfer_amount").val();
    var period = $("#sel_period").val();
    var from_date = $("#txt_from_date").val();
    var to_date = $("#txt_to_date").val();  
    var lumpsum_option = $("#sel_lumpsum_option").val();
    var lumpsum_year = $("#sel_lumpsum_year").val();
		
 	if(initial_amount == "" || transfer_amount == "" || init_start_date == "" || from_date == "" || to_date == "")
 	{
 		$("#adv-alert-msg").html("All fields are mandatory");
   	    $("#adv-alert").modal('show');
		return;
 	}
	if(isNaN(initial_amount) || parseInt(initial_amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid initial amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(isNaN(transfer_amount) || parseInt(transfer_amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid transfer amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(transfer_amount) < 500)
	{
		$("#adv-alert-msg").html("Transfer amount should be greater than 500");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(initial_amount) <= parseInt(transfer_amount))
	{
		$("#adv-alert-msg").html("Please enter the initial amount greater than transfer amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(from_scheme == to_scheme)
	{
		$("#adv-alert-msg").html("Transfer from scheme and to scheme should not be same");
   	    $("#adv-alert").modal('show');
		return;
	}	 
	
	var init_date_arr = init_start_date.split("-");
	var init_date_str = init_date_arr[2] + "-" + init_date_arr[1] + "-" + init_date_arr[0];
	var start_date_arr = from_date.split("-");
	var start_date_str = start_date_arr[2] + "-" + start_date_arr[1] + "-" + start_date_arr[0];
	var end_date_arr = to_date.split("-");
	var end_date_str = end_date_arr[2] + "-" + end_date_arr[1] + "-" + end_date_arr[0];
	
	var init_date = new Date(init_date_str);
	var start_date = new Date(start_date_str);
	var startDate = new Date(start_date_str);
	var end_date = new Date(end_date_str);
	
	if(start_date < init_date)
	{
		$("#adv-alert-msg").html("Please select STP start date less than intial amount start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(end_date <= start_date)
	{
		$("#adv-alert-msg").html("Please select valid start date and end date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(period == "Daily")
	{
		start_date.setDate(start_date.getDate() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Weekly")
	{
		start_date.setDate(start_date.getDate() + 7);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Fortnightly")
	{
		start_date.setDate(start_date.getDate() + 15);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Monthly")
	{
		start_date.setMonth(start_date.getMonth() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(period == "Quarterly")
	{			
		start_date.setMonth(start_date.getMonth() + 3);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	
	var fromScheme = encodeURIComponent(from_scheme);
	var toScheme = encodeURIComponent(to_scheme);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + fromScheme + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var from_scheme_inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(startDate < from_scheme_inception_date)
		{
			$("#adv-alert-msg").html(from_scheme+" inception date is "+ from_scheme_inception_date.format("dd-mm-yyyy") +". Please select a STP start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
		if(init_date < from_scheme_inception_date && flag == false)
		{
			$("#adv-alert-msg").html(from_scheme+" inception date is "+ from_scheme_inception_date.format("dd-mm-yyyy") +". Please select a lumpsum amount investement date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + toScheme + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var to_scheme_inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(startDate < to_scheme_inception_date)
		{
			$("#adv-alert-msg").html(to_scheme+" inception date is "+ to_scheme_inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
	
	amc = encodeURIComponent(amc);
	from_scheme = encodeURIComponent(from_scheme);
	to_scheme = encodeURIComponent(to_scheme);

	downloadPath = "/mutual-funds-research/mutualFundStpInvestmentCalculator?amc="+amc+"&from_scheme="+from_scheme+"&to_scheme="+to_scheme+"&intial_amount="+initial_amount+"&stp_date="+stp_date+"&transfer_amount="+transfer_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date+"&lumpsum_option="+lumpsum_option+"&lumpsum_year="+lumpsum_year;
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
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Mutual Fund STP Return Calculator</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
       		<div class="row">
             			<div class="col-md-4 col-sm-4">
       	<div class="form-group">
         	<label class="font-600">Select AMC</label>
        <select id="sel_amc" class="form-control input-sm" onchange="changeAmcCompany()" data-width="100%">
			<c:forEach items="${amcCompanies}" var="amc_name">
			<option value="<c:out value="${amc_name}"></c:out>"><c:out value="${amc_name}"></c:out></option>
			</c:forEach>
	    </select>
		</div>
	</div>
       
       <div class="col-md-4 col-sm-4">
       	<div class="form-group">
	    <label class="font-600">Transfer From Scheme</label>
		<select id="sel_from_scheme" class="form-control input-sm" data-width="100%">
			<c:forEach items="${schemes}" var="scheme">
			<option value="<c:out value="${scheme}"></c:out>"><c:out value="${scheme}"></c:out></option>
			</c:forEach>
		</select>	
		</div>
       </div>
       
       <div class="col-md-4 col-sm-4">
       	<div class="form-group">
	    <label class="font-600">Transfer To Scheme</label>
		<select id="sel_to_scheme" class="form-control input-sm" data-width="100%">
			<c:forEach items="${schemes}" var="scheme">
			<option value="<c:out value="${scheme}"></c:out>"><c:out value="${scheme}"></c:out></option>
			</c:forEach>
		</select>	
		</div>
       </div>
             		</div>
             		
             		<div class="row">
             			<div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600 block">Select Initial Investment Option</label>
           <select id="sel_lumpsum_option" class="form-control input-sm" data-width="100%" onchange="lumpsumOptionChange()">
			<option value="LAEP" <c:if test="${lumpsum_option eq 'LAEP' }"><c:out value="selected" /></c:if>>One Time Investment</option>
			<option value="LAY" <c:if test="${lumpsum_option eq 'LAY' }"><c:out value="selected" /></c:if>>Yearly Investment</option>
			<option value="LAHY" <c:if test="${lumpsum_option eq 'LAHY' }"><c:out value="selected" /></c:if>>Half Yearly Investment</option>
           	<option value="LAQ" <c:if test="${lumpsum_option eq 'LAQ' }"><c:out value="selected" /></c:if>>Quarterly Investment</option>
		</select>
         </div>
       </div>
       
       <div class="col-md-3 col-sm-3 ">
         <div class="form-group">
           <label class="font-600 block">Select Tenure (Yrs)</label>
           <select id="sel_lumpsum_year" class="form-control input-sm" data-width="100%">
			<option value="1" <c:if test="${lumpsum_year eq '1' }"><c:out value="selected" /></c:if>>1</option>
			<option value="2" <c:if test="${lumpsum_year eq '2' }"><c:out value="selected" /></c:if>>2</option>
			<option value="3" <c:if test="${lumpsum_year eq '3' }"><c:out value="selected" /></c:if>>3</option>
           	<option value="4" <c:if test="${lumpsum_year eq '4' }"><c:out value="selected" /></c:if>>4</option>
           	<option value="5" <c:if test="${lumpsum_year eq '5' }"><c:out value="selected" /></c:if>>5</option>
			<option value="6" <c:if test="${lumpsum_year eq '6' }"><c:out value="selected" /></c:if>>6</option>
			<option value="7" <c:if test="${lumpsum_year eq '7' }"><c:out value="selected" /></c:if>>7</option>
           	<option value="8" <c:if test="${lumpsum_year eq '8' }"><c:out value="selected" /></c:if>>8</option>
           	<option value="9" <c:if test="${lumpsum_year eq '9' }"><c:out value="selected" /></c:if>>9</option>
			<option value="10" <c:if test="${lumpsum_year eq '10' }"><c:out value="selected" /></c:if>>10</option>
		</select>
         </div>
       </div>
      
      	<div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600">Initial Investment Amount</label>
           <input type="text" id="txt_init_amount" value="${initial_amount}" maxlength="8" class="form-control no-radius input-sm" />
         </div>
       </div>
       
       <div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600">Initial Investment Date</label>
           <input type="text" id="txt_init_start_date" value="${init_start_date}" class="form-control datepicker no-radius input-sm" />
         </div>
       </div>
             		</div>
             		
             		<div class="row">
             			<div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600">STP Transfer Amount</label>
           <input type="text" id="txt_transfer_amount" value="${transfer_amount}" maxlength="6" class="form-control no-radius input-sm" />
         </div>
       </div>
       
       <div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600 block">Select STP Day</label>
           <select id="sel_stp_date" class="form-control input-sm" data-width="100%">
			<c:forEach begin="1" end="31" step="1" varStatus="status">
			<option value="${status.count}">${status.count}</option>
			</c:forEach>
		</select>
         </div>
       </div>
       
      	<div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600 block">Select Frequency</label>
           <select id="sel_period" class="form-control input-sm" data-width="100%">
			<option value="Daily" <c:if test="${period eq 'Daily' }"><c:out value="selected" /></c:if>>Daily</option>
			<option value="Weekly" <c:if test="${period eq 'Weekly' }"><c:out value="selected" /></c:if>>Weekly</option>
			<option value="Fortnightly" <c:if test="${period eq 'Fortnightly' }"><c:out value="selected" /></c:if>>Fortnightly</option>
           	<option value="Monthly" <c:if test="${period eq 'Monthly' }"><c:out value="selected" /></c:if>>Monthly</option>
           	<option value="Quarterly" <c:if test="${period eq 'Quarterly' }"><c:out value="selected" /></c:if>>Quarterly</option>
		</select>
         </div>
       </div>
       
       <div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600">Select STP Start Date</label>
           <input type="text" id="txt_from_date" value="${from_date}" class="form-control datepicker no-radius input-sm" />
         </div>
       </div>
             		</div>
             		
             		<div class="row">
             			<div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600">Select STP End Date</label>
           <input type="text" id="txt_to_date" value="${to_date}" class="form-control datepicker no-radius input-sm" />
         </div>
       </div>
       
       <div class="col-md-2 col-sm-2">
       	   <a href="javascript:void(0)" class="btn btn-primary hidden-xs btn-xss" style="position: absolute;top: 35%;width: 70%;" onclick="getData()">Submit</a>	         	   
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
          
			<div class="col-md-12 col-sm-12 table-responsive mt-1">
			<h2 class="font-size-18 marginBottom10">STP - Transferor Scheme : <a href='/mutual-funds-research/<c:out value="${from_scheme}"></c:out>' class="mutual-funds-anchor">${from_scheme}</a></h2>
			<table class="table dataTable">
			<thead class="theadBody"><tr>
			<th>Total Initial Investment Amount</th>
			<th>${period} STP Amount (Rs.)</th>
			<th>STP Period</th>
			<th>No of Installments</th>
			<th>Total Amount Transferred</th>
			<th>Total No. Units Remaining</th>
			<th>Value as on ${from_current_value_date}</th>
			<th>Current Value as on ${from_final_nav_date}</th>
			<th>Profit</th>
			<th>Returns (%)</th>
			</tr></thead><tbody>
			<tr>
			<td><fmt:formatNumber value="${total_lumpsum_amount}" maxFractionDigits="0" /></td>
			<td>${transfer_amount}</td>
			<td style="width:100px;">${from_date}<br/> to <br/>${to_date}</td>
			<td>${installments}</td>
			<td><fmt:formatNumber value="${trans_amount}" maxFractionDigits="0" /></td>
			<td><fmt:formatNumber value="${from_remain_units}" maxFractionDigits="2" /></td>
			<td><fmt:formatNumber value="${from_current_value}" maxFractionDigits="0" /></td>
			<td><fmt:formatNumber value="${from_final_current_value}" maxFractionDigits="0" /></td>	
			<td><fmt:formatNumber value="${from_profit}" maxFractionDigits="0" /></td>
			<td><fmt:formatNumber value="${from_returns}" maxFractionDigits="2" /></td>	
			</tr>
			</tbody></table>
			</div>		
			
			<div class="col-md-12 col-sm-12 table-responsive mt-4">
			<h2 class="font-size-18 marginTop30 marginBottom10">STP - Transferee Scheme : <a href='/mutual-funds-research/<c:out value="${to_scheme}"></c:out>' class="mutual-funds-anchor">${to_scheme}</a></h2>
			<table class="table dataTable">
			<thead class="theadBody"><tr>
			<th>${period} STP Amount (Rs.)</th>
			<th>STP Period</th>
			<th>No of Installments</th>
			<th>Total Amount Invested</th>
			<th>Total No. Units Accumulated</th>
			<th>Value as on ${to_current_value_date}</th>
			<th>Current Value as on ${to_final_nav_date}</th>
			<th>Profit</th>
			<th>Returns (%)</th>
			</tr></thead><tbody>
			<tr>
			<td>${transfer_amount}</td>
			<td style="width:100px;">${from_date} to ${to_date}</td>
			<td>${installments}</td>
			<td><fmt:formatNumber value="${trans_amount}" maxFractionDigits="0" /></td>
			<td><fmt:formatNumber value="${to_remain_units}" maxFractionDigits="2" /></td>
			<td><fmt:formatNumber value="${to_current_value}" maxFractionDigits="0" /></td>
			<td><fmt:formatNumber value="${to_final_current_value}" maxFractionDigits="0" /></td>
			<td><fmt:formatNumber value="${to_profit}" maxFractionDigits="0" /></td>
			<td><fmt:formatNumber value="${to_returns}" maxFractionDigits="2" /></td>
			</tr>
			</tbody></table>
			</div>
			
			<div class="col-md-12 col-sm-12 table-responsive mt-4">
			<h2 class="font-size-18 marginTop30 marginBottom10">STP - Total Returns:</h2>
			<table class="table dataTable">
			<thead class="theadBody"><tr>
			<th>Total Investment Amount</th>
			<th>Total Current Value</th>
			<th>Total Profit</th>
			<th>Total Returns (%)</th>
			</tr></thead><tbody>
			<tr>
			<td><fmt:formatNumber value="${total_lumpsum_amount}" maxFractionDigits="0" /></td>
			<td><fmt:formatNumber value="${total_current_value}" maxFractionDigits="0" /></td>
			<td><fmt:formatNumber value="${total_profit}" maxFractionDigits="0" /></td>
			<td><fmt:formatNumber value="${total_returns}" maxFractionDigits="2" /></td>
			</tr>
			</tbody></table>
			</div>
	
	        <div>
			<div class="col-md-12 col-sm-12 table-responsive mt-4">
			<h2 class='font-size-18 marginBottom10' style="margin-top: 20px;">${from_scheme}</h2>
			<table class='table dataTable'>
			<tr class="theadBody">
			<th>Nav Date</th>
			<th>Nav</th>
			<th>Units</th>
			<th>Cumulative Units</th>
			<th>Cash Flow</th>
			<th>Net Amount</th>
			<th>Capital Gain/Loss</th>
			<th>No. of Days<br>(Invested)</th>
			<th>Current Value</th>
			</tr>
			<c:forEach items="${from_scheme_list}" var="scheme">
			<tr>
			<td><fmt:formatDate pattern="dd-MM-yyyy" value="${scheme.nav_date}" /></td>
	    	<td><c:out value="${scheme.nav}"></c:out></td>
	    	<td><fmt:formatNumber value="${scheme.units}" maxFractionDigits="4" /></td>
	    	<td><fmt:formatNumber value="${scheme.cumulative_units}" maxFractionDigits="4" /></td>
	    	<td><fmt:formatNumber value="${scheme.cash_flow}" maxFractionDigits="0" /></td>
	    	<td><fmt:formatNumber value="${scheme.amount}" maxFractionDigits="0" /></td>
	    	<td><fmt:formatNumber value="${scheme.capital_gain}" maxFractionDigits="2" /></td>
	    	<td><fmt:formatNumber value="${scheme.no_of_days}" maxFractionDigits="0" /></td>
	    	<td><fmt:formatNumber value="${scheme.current_value}" maxFractionDigits="0" /></td>
	    	</tr>
			</c:forEach>
			</table>
	       	</div>
	       </div>
	       
	       <div>
			<div class="col-md-12 col-sm-12 table-responsive mt-4">
			<h2 class='font-size-18 marginBottom10' style="margin-top: 20px;">${to_scheme}</h2>
			<table class='table dataTable'>
			<tr class="theadBody">
			<th>Nav Date</th>
			<th>Nav</th>
			<th>Units</th>
			<th>Cumulative Units</th>
			<th>Cash Flow</th>
			<th>Amount</th>
			<th>Current Value</th>
			</tr>
			<c:forEach items="${to_scheme_list}" var="scheme">
			<tr>
			<td><fmt:formatDate pattern="dd-MM-yyyy" value="${scheme.nav_date}" /></td>
	    	<td><c:out value="${scheme.nav}"></c:out></td>
	    	<td><fmt:formatNumber value="${scheme.units}" maxFractionDigits="4" /></td>
	    	<td><fmt:formatNumber value="${scheme.cumulative_units}" maxFractionDigits="4" /></td>
	    	<td><fmt:formatNumber value="${scheme.cash_flow}" maxFractionDigits="0" /></td>
	    	<td><fmt:formatNumber value="${scheme.amount}" maxFractionDigits="0" /></td>
	    	<td><fmt:formatNumber value="${scheme.current_value}" maxFractionDigits="0" /></td>
		    	
	    	</tr>
			</c:forEach>
			</table>
	       	</div>
	       </div>
          </div>
       </div>
   </div>
</section>