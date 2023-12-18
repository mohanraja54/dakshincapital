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
table.dataTable {
    border-bottom: 1px solid #dedede;
}
</style>

<script>
var swp_count = "";
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
		$("#sel_scheme").html(html);
		
    },'text');
}
function checkInitDate()
{
	var scheme_name = $("#sel_scheme").val();
	var init_start_date = $("#txt_init_amount_start_date").val();
	
	if(init_start_date == "")
 	{
 		$("#adv-alert-msg").html("Please select lumpsum amount investement date.");
   	    $("#adv-alert").modal('show');
		return;
 	}
	var schemeName = encodeURIComponent(scheme_name);
	var init_date_arr = init_start_date.split("-");
	var init_date_str = init_date_arr[2] + "-" + init_date_arr[1] + "-" + init_date_arr[0];
	var init_date = new Date(init_date_str);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(init_date < inception_date)
		{
			$("#adv-alert-msg").html(scheme_name+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a lumpsum amount investment date which is greater than or equal to scheme inception date.");
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

function checkSWPDate()
{
	var scheme_name = $("#sel_scheme").val();
	var from_date = $("#txt_from_date").val();
	if(from_date == "")
 	{
 		$("#adv-alert-msg").html("Please select SWP start date.");
   	    $("#adv-alert").modal('show');
		return;
 	}
	var schemeName = encodeURIComponent(scheme_name);
	var start_date_arr = from_date.split("-");
	var start_date_str = start_date_arr[2] + "-" + start_date_arr[1] + "-" + start_date_arr[0];
	var start_date = new Date(start_date_str);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(start_date < inception_date)
		{
			$("#adv-alert-msg").html(scheme_name+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a SWP start date which is greater than or equal to scheme inception date.");
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
    var scheme_name = $("#sel_scheme").val();
    var initial_amount = $("#txt_init_amount").val();
    var init_start_date = $("#txt_init_amount_start_date").val();
    var swp_date = $("#sel_swp_date").val();
    var withdrawal_amount = $("#txt_withdrawal_amount").val();    
    var period = $("#sel_period").val();
    var from_date = $("#txt_from_date").val();
    var to_date = $("#txt_to_date").val();
    
 	if(initial_amount == "" || withdrawal_amount == "" || init_start_date == "" || from_date == "" || to_date == "")
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
	if(isNaN(withdrawal_amount) || parseInt(withdrawal_amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid transfer amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(withdrawal_amount) < 500)
	{
		$("#adv-alert-msg").html("Withdrawal amount should be greater than 500");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(initial_amount) <= parseInt(withdrawal_amount))
	{
		$("#adv-alert-msg").html("Please enter the initial amount greater than transfer amount");
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
		$("#adv-alert-msg").html("Please select SWP start date less than intial amount start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(end_date <= start_date)
	{
		$("#adv-alert-msg").html("Please select valid start date and end date");
   	    $("#adv-alert").modal('show');
		return;
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
	
	var schemeName = encodeURIComponent(scheme_name);
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
			$("#adv-alert-msg").html(scheme_name+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a SWP start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
		if(init_date < inception_date && flag == false)
		{
			$("#adv-alert-msg").html(scheme_name+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a lumpsum amount investment date which is greater than or equal to scheme inception date.");
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
	scheme_name = encodeURIComponent(scheme_name);
	
 	top.location = "/mutual-funds-research/mutual-fund-swp-investment-calculator?amc="+amc+"&scheme_name="+scheme_name+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
}

$(document).ready(function(){
	
	$('.datepicker').datepicker({
		format: 'dd-mm-yyyy',
		endDate: '-1d',
		autoclose:true,
		disableTouchKeyboard:true
	}).on('changeDate', function(ev) {
		var ID = $(this).attr("id");
		if(ID == "txt_init_amount_start_date")
		{
			checkInitDate();
		}
		if(ID == "txt_from_date")
		{
			checkSWPDate();
		}
	});
	
	var amc = '${amc}';
	if(amc != '')
	{
		$("#sel_amc").val(amc);
	}
	
	var scheme_name = '${scheme_name}';
	if(scheme_name != '')
	{
		$("#sel_scheme").val(scheme_name);
	}
	
	var swp_date = '${swp_date}';
	if(swp_date != '')
	{
		$("#sel_swp_date").val(swp_date);
	}
});
function gotoTop()
{
	$('html,body').animate({
        scrollTop: 0
    }, 700);
}
function gotoLumpsumCalc()
{
	var scheme_name = $("#sel_scheme").val();
    var initial_amount = $("#txt_init_amount").val();
    var init_start_date = $("#txt_init_amount_start_date").val();
    var period = $("#sel_period").val();
    var from_date = $("#txt_from_date").val();
    var to_date = $("#txt_to_date").val();
    
 	if(initial_amount == "" || init_start_date == "" || from_date == "" || to_date == "")
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
		$("#adv-alert-msg").html("Please select SWP start date less than intial amount start date");
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
	
	scheme_name = encodeURIComponent(scheme_name);
	
 	top.location = "/mutual-funds-research/mutual-fund-lumpsum-returns-calculator?scheme="+scheme_name+"&amount="+initial_amount+"&startdate="+init_start_date+"&enddate="+to_date;
}
function gotoSIPCalc()
{
    var scheme_name = $("#sel_scheme").val();
    var initial_amount = $("#txt_init_amount").val();
    var init_start_date = $("#txt_init_amount_start_date").val();
    var swp_date = $("#sel_swp_date").val();
    var withdrawal_amount = $("#txt_withdrawal_amount").val();    
    var period = $("#sel_period").val();
    var from_date = $("#txt_from_date").val();
    var to_date = $("#txt_to_date").val();
    
 	if(initial_amount == "" || withdrawal_amount == "" || init_start_date == "" || from_date == "" || to_date == "")
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
	if(isNaN(withdrawal_amount) || parseInt(withdrawal_amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid transfer amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(withdrawal_amount) < 500)
	{
		$("#adv-alert-msg").html("Withdrawal amount should be greater than 500");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(initial_amount) <= parseInt(withdrawal_amount))
	{
		$("#adv-alert-msg").html("Please enter the initial amount greater than transfer amount");
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
		$("#adv-alert-msg").html("Please select SWP start date less than intial amount start date");
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

	scheme_name = encodeURIComponent(scheme_name);
	
 	top.location = "/mutual-funds-research/mutual-fund-sip-investment-calculator?category=All&fund="+scheme_name+"&amount="+withdrawal_amount+"&frequency="+period+"&startdate="+from_date+"&enddate="+to_date;
}

function downloadXl(){
	
	var amc = $("#sel_amc").val();
    var scheme_name = $("#sel_scheme").val();
    var initial_amount = $("#txt_init_amount").val();
    var init_start_date = $("#txt_init_amount_start_date").val();
    var swp_date = $("#sel_swp_date").val();
    var withdrawal_amount = $("#txt_withdrawal_amount").val();    
    var period = $("#sel_period").val();
    var from_date = $("#txt_from_date").val();
    var to_date = $("#txt_to_date").val();
    
 	if(initial_amount == "" || withdrawal_amount == "" || init_start_date == "" || from_date == "" || to_date == "")
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
	if(isNaN(withdrawal_amount) || parseInt(withdrawal_amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid transfer amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(withdrawal_amount) < 500)
	{
		$("#adv-alert-msg").html("Withdrawal amount should be greater than 500");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(initial_amount) <= parseInt(withdrawal_amount))
	{
		$("#adv-alert-msg").html("Please enter the initial amount greater than transfer amount");
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
		$("#adv-alert-msg").html("Please select SWP start date less than intial amount start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(end_date <= start_date)
	{
		$("#adv-alert-msg").html("Please select valid start date and end date");
   	    $("#adv-alert").modal('show');
		return;
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
	
	var schemeName = encodeURIComponent(scheme_name);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		//var inception_date =  new Date(schemes_array[0])
		
		var from = schemes_array[0].split("-");
		var inception_date = new Date(from[2], from[1] - 1, from[0]);
		
		if(startDate < inception_date)
		{
			$("#adv-alert-msg").html(scheme_name+" inception date is "+ moment(inception_date).format("DD-MM-YYYY") +". Please select a SWP start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
		if(init_date < inception_date && flag == false)
		{
			$("#adv-alert-msg").html(scheme_name+" inception date is "+ moment(inception_date).format("DD-MM-YYYY") +". Please select a lumpsum amount investment date which is greater than or equal to scheme inception date.");
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
	$.post("/mutual-funds-research/getSchemeCategory", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var category = $.trim(data);
		//alert("category--->"+category);
		
		if(category == "Equity: ELSS")
		{
			var init_date = new Date(init_date_str);
			var start_date = new Date(start_date_str);
			init_date.setFullYear(init_date.getFullYear() + 3);
			
			if(start_date < init_date)
			{
				$("#adv-alert-msg").html("ELSS schemes are locked-in for 3 years from the date of investment. SWP is not allowed during the lock-in period.");
		   	    $("#adv-alert").modal('show');
		   	 	flag = true;
				return false;
			}
		}
		
    },'text');
	
	if(flag)
	{
		return false;
	}
	
	amc = encodeURIComponent(amc);
	scheme_name = encodeURIComponent(scheme_name);

	//top.location = "/mutual-funds-research/mutualFundSwpInvestmentCalculator?amc="+amc+"&scheme_name="+scheme_name+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
	var path = "/mutual-funds-research/mutualFundSwpInvestmentCalculator?amc="+amc+"&scheme_name="+scheme_name+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
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
	    	    	top.location =  "/mutual-funds-research/mutualFundSwpInvestmentCalculator?amc="+amc+"&scheme_name="+scheme_name+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
	
	var amc = $("#sel_amc").val();
    var scheme_name = $("#sel_scheme").val();
    var initial_amount = $("#txt_init_amount").val();
    var init_start_date = $("#txt_init_amount_start_date").val();
    var swp_date = $("#sel_swp_date").val();
    var withdrawal_amount = $("#txt_withdrawal_amount").val();    
    var period = $("#sel_period").val();
    var from_date = $("#txt_from_date").val();
    var to_date = $("#txt_to_date").val();
    
 	if(initial_amount == "" || withdrawal_amount == "" || init_start_date == "" || from_date == "" || to_date == "")
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
	if(isNaN(withdrawal_amount) || parseInt(withdrawal_amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid transfer amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(withdrawal_amount) < 500)
	{
		$("#adv-alert-msg").html("Withdrawal amount should be greater than 500");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(parseInt(initial_amount) <= parseInt(withdrawal_amount))
	{
		$("#adv-alert-msg").html("Please enter the initial amount greater than transfer amount");
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
		$("#adv-alert-msg").html("Please select SWP start date less than intial amount start date");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(end_date <= start_date)
	{
		$("#adv-alert-msg").html("Please select valid start date and end date");
   	    $("#adv-alert").modal('show');
		return;
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
	
	var schemeName = encodeURIComponent(scheme_name);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		//var inception_date =  new Date(schemes_array[0])
		
		var from = schemes_array[0].split("-");
		var inception_date = new Date(from[2], from[1] - 1, from[0]);
		
		if(startDate < inception_date)
		{
			$("#adv-alert-msg").html(scheme_name+" inception date is "+ moment(inception_date).format("DD-MM-YYYY") +". Please select a SWP start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
		if(init_date < inception_date && flag == false)
		{
			$("#adv-alert-msg").html(scheme_name+" inception date is "+ moment(inception_date).format("DD-MM-YYYY") +". Please select a lumpsum amount investment date which is greater than or equal to scheme inception date.");
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
	$.post("/mutual-funds-research/getSchemeCategory", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var category = $.trim(data);
		//alert("category--->"+category);
		
		if(category == "Equity: ELSS")
		{
			var init_date = new Date(init_date_str);
			var start_date = new Date(start_date_str);
			init_date.setFullYear(init_date.getFullYear() + 3);
			
			if(start_date < init_date)
			{
				$("#adv-alert-msg").html("ELSS schemes are locked-in for 3 years from the date of investment. SWP is not allowed during the lock-in period.");
		   	    $("#adv-alert").modal('show');
		   	 	flag = true;
				return false;
			}
		}
		
    },'text');
	
	if(flag)
	{
		return false;
	}
	
	amc = encodeURIComponent(amc);
	scheme_name = encodeURIComponent(scheme_name);
	
	downloadPath = "/mutual-funds-research/mutualFundSwpInvestmentCalculator?amc="+amc+"&scheme_name="+scheme_name+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
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
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Mutual Fund SWP Return Calculator</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
                 <div class="row">
                	<div class="col-md-4 col-sm-4">
       	<div class="form-group">
         	<label class="font-600">Select AMC</label>
        <select id="sel_amc" class="form-control input-sm" onchange="changeAmcCompany()" data-width="100%">
        	<option value="All">All</option>
			<c:forEach items="${amcCompanies}" var="amc_name">
			<option value="<c:out value="${amc_name}"></c:out>"><c:out value="${amc_name}"></c:out></option>
			</c:forEach>
	    </select>
		</div>
	</div>
       
       <div class="col-md-4 col-sm-4">
       	<div class="form-group">
	    <label class="font-600">Select Scheme</label>
		<select id="sel_scheme" class="form-control input-sm" data-width="100%">
			<c:forEach items="${schemes}" var="scheme">
			<option value="<c:out value="${scheme}"></c:out>"><c:out value="${scheme}"></c:out></option>
			</c:forEach>
		</select>	
		</div>
       </div>
       
       <div class="col-md-4 col-sm-4">
          <div class="form-group">
            <label class="font-600">Lumpsum Amount</label>
            <input type="text" id="txt_init_amount" value="${initial_amount}" maxlength="8" class="form-control no-radius input-sm" />
          </div>
    </div>
                </div>
                
                <div class="row">
                	<div class="col-md-4 col-sm-4">
         <div class="form-group">
           <label class="font-600">Lumpsum Amount Investement Date</label>
           <input type="text" id="txt_init_amount_start_date" value="${init_start_date}" class="form-control datepicker no-radius input-sm" />
         </div>
       </div>
       
       <div class="col-md-4 col-sm-4">
         <div class="form-group">
           <label class="font-600">Withdrawal Amount :</label>
           <input type="text" id="txt_withdrawal_amount" value="${withdrawal_amount}" maxlength="6" class="form-control no-radius input-sm" />
         </div>
       </div>
       
       <div class="col-md-4 col-sm-4">
         <div class="form-group">
           <label class="font-600">Select SWP Date</label>
           <select id="sel_swp_date" class="form-control input-sm" data-width="100%">
			<c:forEach begin="1" end="31" step="1" varStatus="status">
			<option value="${status.count}">${status.count}</option>
			</c:forEach>
		</select>
         </div>
       </div>
                </div>
                
                <div class="row">
       <div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600">Select Period</label>
           <select id="sel_period" class="form-control input-sm" data-width="100%">
			<option value="Weekly" <c:if test="${period eq 'Weekly' }"><c:out value="selected" /></c:if>>Weekly</option>
			<option value="Fortnightly" <c:if test="${period eq 'Fortnightly' }"><c:out value="selected" /></c:if>>Fortnightly</option>
           	<option value="Monthly" <c:if test="${period eq 'Monthly' }"><c:out value="selected" /></c:if>>Monthly</option>
           	<option value="Quarterly" <c:if test="${period eq 'Quarterly' }"><c:out value="selected" /></c:if>>Quarterly</option>
		</select>
         </div>
       </div>
       
       <div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600">Select SWP Start Date</label>
           <input type="text" id="txt_from_date" value="${from_date}" class="form-control datepicker no-radius input-sm" />
         </div>
       </div>
       
       <div class="col-md-3 col-sm-3">
         <div class="form-group">
           <label class="font-600">Select SWP End Date</label>
           <input type="text" id="txt_to_date" value="${to_date}" class="form-control datepicker no-radius input-sm" />
         </div>
       </div>
       
       <div class="col-md-3 col-sm-3 sub">
         	<div class="form-group">
         	 <label class="no-bold"> &nbsp;&nbsp;&nbsp; </label>
			<a href="javascript:void(0)" class="btn btn-primary hidden-xs"  style="position: absolute;top: 35%;width: 45%;" onclick="getData()">Submit</a>
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
					<div class="col-md-12 col-sm-12 table-responsive mt-1">
					<h2 class="font-size-18 marginBottom10">Systematic Withdrawal Plan Calculator</h2>
					<table class="table dataTable">
					<thead class="theadBody"><tr>
					<th>Scheme</th>
					<th style="width:200px;">Withdrawal Period</th>
					<th>No of ${period} Installments</th>
					<th>Total Withdrawal Amount</th>
					<th>Current Value as on <br/> ${from_nav_date}</th>
					<th>Return (%)</th>
					</tr></thead><tbody>
					<tr>
					<td><a href='/mutual-funds-research/<c:out value="${scheme_name}"></c:out>' class="mutual-funds-anchor">${scheme_name}</a>
					</td>
					<td>${from_date} to ${to_date}</td>
					<td>${transfer_out_count}</td>
					<td><fmt:formatNumber value="${total_amount_transferred}" maxFractionDigits="0" /></td>
					<td><fmt:formatNumber value="${from_current_value}" maxFractionDigits="0" /></td>
					<td><fmt:formatNumber value="${from_returns}" maxFractionDigits="2" /></td>
					</tr>
					</tbody></table>
					</div>
			
			        <div id="transaction_details" class="marginTop20">
					<div class="col-md-12 col-sm-12 table-responsive mt-1">
					<h2 class='font-size-18 marginBottom10'>${scheme_name}</h2>
					<table class='table dataTable' id="swpTable">
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
         </div>
      </div>
   </div>
</section>