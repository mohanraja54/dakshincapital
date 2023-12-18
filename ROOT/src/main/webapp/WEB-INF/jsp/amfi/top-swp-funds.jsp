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
table.dataTable.no-footer {
    border-bottom: 1px solid #dedede;
}
</style>

<script>
function getData()
{
	var amc = $("#sel_amc").val();
    var category = $("#sel_schemeCategories").val();
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
	
	if(category == "Equity: ELSS")
	{
		var init_date = new Date(init_date_str);
		var start_date = new Date(start_date_str);
		init_date.setFullYear(init_date.getFullYear() + 3);
		
		if(start_date < init_date)
		{
			$("#adv-alert-msg").html("ELSS schemes are locked-in for 3 years from the date of investment. SWP is not allowed during the lock-in period.");
	   	    $("#adv-alert").modal('show');
			return false;
		}
	}
	
	amc = encodeURIComponent(amc);
	
 	top.location = "/mutual-funds-research/top-swp-funds?amc="+amc+"&category="+category+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
}

$(document).ready(function(){
	
	$('.datepicker').datepicker({
		format: 'dd-mm-yyyy',
		endDate: '-1d',
		autoclose:true,
		disableTouchKeyboard:true
	});
	
	var amc = '${amc}';
	if(amc != '')
	{
		$("#sel_amc").val(amc);
		//$("#sel_amc").selectpicker("refresh");
	}
	
	var swp_date = '${swp_date}';
	if(swp_date != '')
	{
		$("#sel_swp_date").val(swp_date);
		//$("#sel_swp_date").selectpicker("refresh");
	}
	
	$("#final_result").dataTable({
		"bPaginate": false,
		"bFilter": false,
		"bInfo": false,
		"bSort": false,
		"initComplete": function(settings, json) {
            <c:if test="${fn:contains(header['User-Agent'],'Mobile')}">
            var table = settings.oInstance.api();
            setTimeout(function(){
         	  table.rows(':not(.parent)').nodes().to$().find('td:first-child').trigger('click');
            }, 1000);
            </c:if>
        }
	});
	
	$('#tbl_scheme_returns').on( 'draw.dt', function (e, settings) {
		<c:if test="${fn:contains(header['User-Agent'],'Mobile')}">
		var table = settings.oInstance.api();
		 setTimeout(function(){
		    table.rows(':not(.parent)').nodes().to$().find('td:first-child').trigger('click');
		 }, 1000);
		</c:if>
	});
	
	
});

function gotoTop()
{
	$('html,body').animate({
        scrollTop: 0
    }, 700);
}

function saveResult() 
{	
	var amc = $("#sel_amc").val();
    var category = $("#sel_schemeCategories").val();
    var initial_amount = $("#txt_init_amount").val();
    var init_start_date = $("#txt_init_amount_start_date").val();
    var swp_date = $("#sel_swp_date").val();
    var withdrawal_amount = $("#txt_withdrawal_amount").val();    
    var period = $("#sel_period").val();
    var from_date = $("#txt_from_date").val();
    var to_date = $("#txt_to_date").val();
    
	var accountMap = '${accountMap}';
	var title = "Top SWP Funds -> Amc = " + amc + ", Category = " + category + ", Lumpsum Amount = " + initial_amount + ", Lumpsum Investment Date = " + init_start_date + ", Frequency = " + period + ", SWP Start Date = " + from_date + ", Withdrawal Amount = " + withdrawal_amount + ", SWP Date = " + swp_date + ", SWP End Date = " + to_date ;
	var url = window.location;
	
	if(accountMap == undefined || accountMap == null || accountMap == "" || accountMap == "null")
	{
		advisorkhoj_result_title = title;
		advisorkhoj_result_url = window.location.href;
		
		$("#adv-contact-advisor-signin-signup").modal("show");
	}
	else
	{
		saveUserResult("MF Tools",title, url);
	}
}

function downloadExcel(){
	
	var amc = $("#sel_amc").val();
    var category = $("#sel_schemeCategories").val();
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
	
	if(category == "Equity: ELSS")
	{
		var init_date = new Date(init_date_str);
		var start_date = new Date(start_date_str);
		init_date.setFullYear(init_date.getFullYear() + 3);
		
		if(start_date < init_date)
		{
			$("#adv-alert-msg").html("ELSS schemes are locked-in for 3 years from the date of investment. SWP is not allowed during the lock-in period.");
	   	    $("#adv-alert").modal('show');
			return false;
		}
	}
	
	amc = encodeURIComponent(amc);
	
	//top.location = "/mutual-funds-research/topSwpFunds?amc="+amc+"&category="+category+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;

	var path = "/mutual-funds-research/topSwpFunds?amc="+amc+"&category="+category+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
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
	    	    	top.location =  "/mutual-funds-research/topSwpFunds?amc="+amc+"&category="+category+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
	
	var amc = $("#sel_amc").val();
    var category = $("#sel_schemeCategories").val();
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
	
	if(category == "Equity: ELSS")
	{
		var init_date = new Date(init_date_str);
		var start_date = new Date(start_date_str);
		init_date.setFullYear(init_date.getFullYear() + 3);
		
		if(start_date < init_date)
		{
			$("#adv-alert-msg").html("ELSS schemes are locked-in for 3 years from the date of investment. SWP is not allowed during the lock-in period.");
	   	    $("#adv-alert").modal('show');
			return false;
		}
	}
	
	amc = encodeURIComponent(amc);

	downloadPath = "/mutual-funds-research/topSwpFunds?amc="+amc+"&category="+category+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
	imageDownload = "no";
	chartId = "";
	filename = "";
	
	$("#adv-login").modal("show");
}

function downloadXl(){
	
	var amc = $("#sel_amc").val();
    var category = $("#sel_schemeCategories").val();
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
	
	if(category == "Equity: ELSS")
	{
		var init_date = new Date(init_date_str);
		var start_date = new Date(start_date_str);
		init_date.setFullYear(init_date.getFullYear() + 3);
		
		if(start_date < init_date)
		{
			$("#adv-alert-msg").html("ELSS schemes are locked-in for 3 years from the date of investment. SWP is not allowed during the lock-in period.");
	   	    $("#adv-alert").modal('show');
			return false;
		}
	}
	
	amc = encodeURIComponent(amc);
	
	//top.location = "/mutual-funds-research/topSwpFunds?amc="+amc+"&category="+category+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;

	var path = "/mutual-funds-research/topSwpFunds?amc="+amc+"&category="+category+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
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
	    	    	top.location =  "/mutual-funds-research/topSwpFunds?amc="+amc+"&category="+category+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
	
	var amc = $("#sel_amc").val();
    var category = $("#sel_schemeCategories").val();
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
	
	if(category == "Equity: ELSS")
	{
		var init_date = new Date(init_date_str);
		var start_date = new Date(start_date_str);
		init_date.setFullYear(init_date.getFullYear() + 3);
		
		if(start_date < init_date)
		{
			$("#adv-alert-msg").html("ELSS schemes are locked-in for 3 years from the date of investment. SWP is not allowed during the lock-in period.");
	   	    $("#adv-alert").modal('show');
			return false;
		}
	}
	
	amc = encodeURIComponent(amc);

	downloadPath = "/mutual-funds-research/topSwpFunds?amc="+amc+"&category="+category+"&intial_amount="+initial_amount+"&swp_date="+swp_date+"&withdrawal_amount="+withdrawal_amount+"&period="+period+"&from_date="+from_date+"&to_date="+to_date+"&init_start_date="+init_start_date;
	imageDownload = "no";
	chartId = "";
	filename = "";
	
	$("#adv-login").modal("show");
}

</script>
</script>

<section class="main-container mf-research">

	<div class="container-fluid pr-0 pl-0">
	<div class="row ml-0 mr-0">
		<div class="col-md-3 bg-mfbar py-3">
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Top SWP Funds</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
                 <div class="row">
                 	<div class="col-md-4 col-sm-4">
        	<div class="form-group">
          	<label class="font-600">Select AMC</label>
	        <select id="sel_amc" class="form-control" data-width="100%">
	        	<option value="All">All</option>
				<c:forEach items="${amcCompanies}" var="amc_name">
				<option value="<c:out value="${amc_name}"></c:out>"><c:out value="${amc_name}"></c:out></option>
				</c:forEach>
		    </select>
			</div>
		</div>
        
        <div class="col-md-4 col-sm-4">
        <div class="form-group">
          <label class="font-600">Select Category</label>
          <select id="sel_schemeCategories" class="form-control" data-width="100%">  
             <c:forEach var="categories" items="${schemeCategories}"> 
                <c:choose>
                <c:when test="${categories eq category}">
                  <option selected="selected" value="<c:out value="${categories}"></c:out>"><c:out value="${categories}"></c:out></option>
                </c:when>
                <c:otherwise>
                  <c:if test="${categories != 'Fixed Maturity Plans' && categories != 'Gold Funds'}">
                  <option value="<c:out value="${categories}"></c:out>"><c:out value="${categories}"></c:out></option>
                  </c:if>
                </c:otherwise>
               </c:choose>
             </c:forEach>                             
          </select>
        </div>
        </div>
        
        <div class="col-md-4 col-sm-4">
	          <div class="form-group">
	            <label class="font-600">Lumpsum Amount</label>
	            <input type="text" id="txt_init_amount" value="${initial_amount}" maxlength="8" class="form-control no-radius" />
	          </div>
	    </div>
                 </div>
                 
                  <div class="row">
        	<div class="col-md-4 col-sm-4">
	          <div class="form-group">
	            <label class="font-600">Lumpsum Amount Investement Date</label>
	            <input type="text" id="txt_init_amount_start_date" value="${init_start_date}" class="form-control datepicker no-radius" />
	          </div>
	        </div>
	        
	        <div class="col-md-4 col-sm-4">
	          <div class="form-group">
	            <label class="font-600">Withdrawal Amount :</label>
	            <input type="text" id="txt_withdrawal_amount" value="${withdrawal_amount}" maxlength="6" class="form-control no-radius" />
	          </div>
	        </div>
	        
	        <div class="col-md-4 col-sm-4">
	          <div class="form-group">
	            <label class="font-600">Select SWP Date</label>
	            <select id="sel_swp_date" class="form-control" data-width="100%">
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
	            <select id="sel_period" class="form-control" data-width="100%">
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
	            <input type="text" id="txt_from_date" value="${from_date}" class="form-control datepicker no-radius" />
	          </div>
	        </div>
	        
	        <div class="col-md-3 col-sm-3">
	          <div class="form-group">
	            <label class="font-600">Select SWP End Date</label>
	            <input type="text" id="txt_to_date" value="${to_date}" class="form-control margin-bottom10 datepicker no-radius" />
	          </div>
	        </div>
	        
	        <div class="col-md-3 col-sm-3">
	          	<div class="form-group">
	          	<label class="bold block hidden-xs">&nbsp;</label>
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
	       	<div class="row" style="margin-bottom: 10px;">
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
		    <div class="row">
					<div class="col-md-12 col-sm-12 table-responsive mt-2">
			        <table class="table dataTable" id="final_result">
					<thead><tr>
					<th style="width:200px;">Scheme Name</th>
					<th style="width:100px;">Launch Date</th>
					<th>Lumpsum Amount</th>
					<th style="width:200px;">Withdrawal Period</th>
					<th>No of ${period} Installments</th>
					<th>Total Withdrawal Amount</th>
					<th>Current Value</th>
					<th>Return (%)</th>
					<th>Cash Flow</th>
					</tr></thead><tbody>
					<c:forEach var="swp_funds" items="${swp_funds_list}">
					<tr>
					<td><a href='/mutual-funds-research/<c:out value="${swp_funds.scheme_name}"></c:out>' class="mutual-funds-anchor">${swp_funds.scheme_name}</a>
					</td>
					<td class="nowrap"><fmt:formatDate pattern="dd-MM-yyyy" value="${swp_funds.inception_date}" /></td>
					<td><fmt:formatNumber value="${initial_amount}" maxFractionDigits="0" /></td>
					<td class="nowrap"><fmt:formatDate pattern="dd-MM-yyyy" value="${swp_funds.start_date}" /> to <fmt:formatDate pattern="dd-MM-yyyy" value="${swp_funds.end_date}" /></td>
					<td>${swp_funds.no_of_installments}</td>
					<td><fmt:formatNumber value="${swp_funds.total_withdrawal_amount}" maxFractionDigits="0" /></td>
					<td><fmt:formatNumber value="${swp_funds.current_value}" maxFractionDigits="0" /></td>
					<td><fmt:formatNumber value="${swp_funds.returns}" maxFractionDigits="2" /></td>
					<td><a href='/mutual-funds-research/mutual-fund-swp-investment-calculator?amc=${amc}&scheme_name=${swp_funds.scheme_name}&intial_amount=${initial_amount}&swp_date=${swp_date}&withdrawal_amount=${withdrawal_amount}&period=${period}&from_date=${from_date}&to_date=${to_date}&init_start_date=${init_start_date}'><i class="fa fa-plus-circle fa-lg " aria-hidden="true"></i></a></td>
					</tr>
					</c:forEach>
					</tbody>
					</table>
					</div>	      
			</div>
         </div>
      </div>
   </div>
</section>