<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style>
tr.returns-calculator:nth-child(even){border-bottom:2px solid #b5b2ac !important; border-right:2px solid #b5b2ac !important; border-left:2px solid #b5b2ac !important;}
tr.returns-calculator:nth-child(odd) {border-top:2px solid #b5b2ac !important; border-right:2px solid #b5b2ac !important; border-left:2px solid #b5b2ac !important;}
.table-responsive {border: 0 !important;}

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

.mf-research .table thead tr{
	-webkit-box-shadow: none !important;
    -moz-box-shadow: none !important;
    box-shadow: none !important;
}

table.dataTable.no-footer {
   box-shadow: 0px 1px 10px 0px #dedede;
   border-bottom: 0;
}

table.dataTable thead th, table.dataTable thead td {
    padding: 10px 18px;
    border-bottom: 1px solid #dedede;
}

.input-group-addon {
    padding: 4px 12px;
    font-size: 14px;
    font-weight: 400;
    border-radius: 0px;
    color: #fff;
    background-color: #1b9ce3;
    border: 1px solid #1b9ce3;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
    position: relative;
    left: -38px;
}

</style>

<script>

function initializeTypeAhead()
{	
	$('.txt_fund').typeahead({
	    source: function (query, process) {
	        return $.ajax({
	            url: '/mutual-funds-research/autoSuggestAllMfSchemes',
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

function datePickerLoad()
{
	$('.datepicker').datepicker({
		format: 'dd-mm-yyyy',
		endDate: '-1d',
		autoclose:true,
		disableTouchKeyboard:true
	});
}

function getData()
{
	var schemes = new Array(); 
	var start_dates = new Array();
	var end_dates = new Array();

	for(var k=1;k<=5;k++)
	{
		if($("#txt_fund"+k).length != 0)
		{
			var fundname = $("#txt_fund"+k).val();
			if(fundname == "")
			{
				$("#adv-alert-msg").html("Please select the fund name "+ k);
		   	    $("#adv-alert").modal('show');
				return;
			}
			schemes.push(encodeURIComponent(fundname));
		}
	}
	
	for(var k=1;k<=5;k++)
	{
		if($("#txt_start_date_"+k).length != 0)
		{
			var startdate = $("#txt_start_date_"+k).val();
			if(startdate == "")
			{
				$("#adv-alert-msg").html("Please select the start date "+ k );
		   	    $("#adv-alert").modal('show');
				return;
			}
			var enddate = $("#txt_end_date_"+k).val();
			if(enddate == "")
			{
				$("#adv-alert-msg").html("Please select the end date "+ k );
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
			start_dates.push(startdate);
			end_dates.push(enddate);
		}
	}
	var category = $("#sel_schemeCategories").val();
	var amount = $("#txt_amount").val();
	if(amount == "" || amount <= 0)
	{
		$("#adv-alert-msg").html("Please enter valid amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	
	top.location = "/mutual-funds-research/mutual-fund-returns-comparison?category="+category+"&schemes="+schemes+"&startDates="+start_dates+"&endDates="+end_dates+"&amount="+amount;
}


$(document).ready(function(){
	
	initializeTypeAhead();
	datePickerLoad();
	
	var schemes = '${schemes}';
	if(schemes != "")
	{
		var fund_array = schemes.split(",");
		for(var k=0;k<fund_array.length;k++)
		{
			var fund_name = fund_array[k];
			
			if(k == 0)
			{
				$("#txt_fund1").val(fund_name);
			}
			if(k == 1)
			{
				addMoreFund();
				$("#txt_fund2").val(fund_name);
			}
			if(k == 2)
			{
				addMoreFund();
				$("#txt_fund3").val(fund_name);
			}
			if(k == 3)
			{
				addMoreFund();
				$("#txt_fund4").val(fund_name);
			}
			if(k == 4)
			{
				addMoreFund();
				$("#txt_fund5").val(fund_name);
			}
		}
	}
	
	var startDates = '${startDates}';
	var endDates = '${endDates}';
	if(startDates != "" && endDates != "")
	{
		var start_array = startDates.split(",");
		var end_array = endDates.split(",");
		
		for(var k=0;k<start_array.length;k++)
		{
			var start_date = start_array[k];
			var end_date = end_array[k];
			
			if(k == 0)
			{
				$("#txt_start_date_1").val(start_date);
				$("#txt_end_date_1").val(end_date);
				$("#txt_start_date_1").datepicker("update");
				$("#txt_end_date_1").datepicker("update");
			}
			if(k == 1)
			{
				addMoreDateRange();
				$("#txt_start_date_2").val(start_date);
				$("#txt_end_date_2").val(end_date);
				$("#txt_start_date_2").datepicker("update");
				$("#txt_end_date_2").datepicker("update");
			}
			if(k == 2)
			{
				addMoreDateRange();
				$("#txt_start_date_3").val(start_date);
				$("#txt_end_date_3").val(end_date);
				$("#txt_start_date_3").datepicker("update");
				$("#txt_end_date_3").datepicker("update");
			}
			if(k == 3)
			{
				addMoreDateRange();
				$("#txt_start_date_4").val(start_date);
				$("#txt_end_date_4").val(end_date);
				$("#txt_start_date_4").datepicker("update");
				$("#txt_end_date_4").datepicker("update");
			}
			if(k == 4)
			{
				addMoreDateRange();
				$("#txt_start_date_5").val(start_date);
				$("#txt_end_date_5").val(end_date);
				$("#txt_start_date_5").datepicker("update");
				$("#txt_end_date_5").datepicker("update");
			}
		}
	}
	
	$("#sel_schemeCategories").change(function(){
		$(".txt_fund").val("");
		$("#txt_fund1").focus();		
	});
	
	$("#final_result").dataTable({
		"bPaginate": false,
		"bFilter": false,
		"bInfo": false,
		"bSort": false
	});
	
});

function addMoreFund()
{
	var fundname1 = $("#txt_fund1").val();
	if(fundname1 == "")
	{
		$("#adv-alert-msg").html("Enter an value for Fund 1");
   	    $("#adv-alert").modal('show');
		return;
	}
	var fundname2 = $("#txt_fund2").val();
	if(fundname2 == "")
	{
		$("#adv-alert-msg").html("Enter an value for Fund 2");
   	    $("#adv-alert").modal('show');
		return;
	}
	var fundname3 = $("#txt_fund3").val();
	if(fundname3 == "")
	{
		$("#adv-alert-msg").html("Enter an value for Fund 3");
   	    $("#adv-alert").modal('show');
		return;
	}
	var fundname4 = $("#txt_fund4").val();
	if(fundname4 == "")
	{
		$("#adv-alert-msg").html("Enter an value for Fund 4");
   	    $("#adv-alert").modal('show');
		return;
	}
	var fundname5 = $("#txt_fund5").val();
	if(fundname5 == "")
	{
		$("#adv-alert-msg").html("Enter an value for Fund 5");
   	    $("#adv-alert").modal('show');
		return;
	}

    var count = 0;
	$(".fund").each(function(){
		count++;
	});
	count++;
	
	var fund_count = 5 - count;
 	$("#fund_count").html(fund_count);
 	
 	if(count == 5)
 	{
 		$("#more_funds_div").hide();
 	}else{
 		$("#more_funds_div").show();
 	}

	if(count == 2)
	{
		var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
		friends_html += '<label class="font-600">Fund '+ count +'</label>';
		friends_html += '<div class="input-group">';
		friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
        friends_html += '</div>';
		friends_html += '</div>';
		
		$("#div_txt_funds").append(friends_html);
	}
	if(count == 3)
	{
		if($("#div_fund_2").length == 0) 
		{
			count = count - 1;
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund name '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			if($("#div_fund_3").length != 0)
			{
				$( "#div_fund_3" ).before(friends_html);
			}else if($("#div_fund_4").length != 0)
			{
				$( "#div_fund_4" ).before(friends_html);
			}else if($("#div_fund_5").length != 0)
			{
				$( "#div_fund_5" ).before(friends_html);
			}else{
				$("#div_fund_1").append(friends_html);
			}
		}else if($("#div_fund_3").length == 0) 
		{
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			if($("#div_fund_4").length != 0)
			{
				$( "#div_fund_4" ).before(friends_html);
			}else if($("#div_fund_5").length != 0)
			{
				$( "#div_fund_5" ).before(friends_html);
			}else{
				$("#div_txt_funds").append(friends_html);
			}
		}else if($("#div_fund_4").length == 0) 
		{
			count = count + 1;
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			if($("#div_fund_5").length != 0)
			{
				$( "#div_fund_5" ).before(friends_html);
			}else{
				$("#div_txt_funds").append(friends_html);
			}
		}else
		{
			count = count + 2;
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			$("#div_txt_funds").append(friends_html);
		}
	}
	if(count == 4)
	{
		if($("#div_fund_2").length == 0) 
		{
			count = count - 2;
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			if($("#div_fund_3").length != 0)
			{
				$( "#div_fund_3" ).before(friends_html);
			}else if($("#div_fund_4").length != 0)
			{
				$( "#div_fund_4" ).before(friends_html);
			}else if($("#div_fund_5").length != 0)
			{
				$( "#div_fund_5" ).before(friends_html);
			}else{
				$("#div_txt_funds").append(friends_html);
			}
		}else if($("#div_fund_3").length == 0) 
		{
			count = count - 1;
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			if($("#div_fund_4").length != 0)
			{
				$( "#div_fund_4" ).before(friends_html);
			}else if($("#div_fund_5").length != 0)
			{
				$( "#div_fund_5" ).before(friends_html);
			}else{
				$("#div_txt_funds").append(friends_html);
			}
		}else if($("#div_fund_4").length == 0) 
		{
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			if($("#div_fund_5").length != 0)
			{
				$( "#div_fund_5" ).before(friends_html);
			}else{
				$("#div_txt_funds").append(friends_html);
			}
		}else
		{
			count = count + 1;
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			$("#div_txt_funds").append(friends_html);
		}
	}
	if(count == 5)
	{
		if($("#div_fund_2").length == 0) 
		{
			count = count - 3;
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			if($("#div_fund_3").length != 0)
			{
				$( "#div_fund_3" ).before(friends_html);
			}else if($("#div_fund_4").length != 0)
			{
				$( "#div_fund_4" ).before(friends_html);
			}else if($("#div_fund_5").length != 0)
			{
				$( "#div_fund_5" ).before(friends_html);
			}else{
				$("#div_txt_funds").append(friends_html);
			}
		}else if($("#div_fund_3").length == 0) 
		{
			count = count - 2;
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			if($("#div_fund_4").length != 0)
			{
				$( "#div_fund_4" ).before(friends_html);
			}else if($("#div_fund_5").length != 0)
			{
				$( "#div_fund_5" ).before(friends_html);
			}else{
				$("#div_txt_funds").append(friends_html);
			}
		}else if($("#div_fund_4").length == 0) 
		{
			count = count - 1;
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			if($("#div_fund_5").length != 0)
			{
				$( "#div_fund_5" ).before(friends_html);
			}else{
				$("#div_txt_funds").append(friends_html);
			}
		}else
		{
			var friends_html = '<div id="div_fund_' + count + '" class="form-group fund">';
			friends_html += '<label class="font-600">Fund '+ count +'</label>';
			friends_html += '<div class="input-group">';
			friends_html += '<input id="txt_fund' + count + '" type="text" class="txt_fund form-control">';
	        friends_html += '<span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(\'div_fund_' + count + '\')"><i class="fa fa-close"></i></span>';
	        friends_html += '</div>';
			friends_html += '</div>';
			
			$("#div_txt_funds").append(friends_html);
		}
	}
	initializeTypeAhead();
}

function removeMoreFund(id)
{
     $("#" + id).remove();
     if($("#final_result").is(":visible"))
   	 {
    	 getData();
   	 }
     
     var count = 0;
 	$(".fund").each(function(){
 		count++;
 	});
 	
 	var fund_count = 5 - count;
  	$("#fund_count").html(fund_count);
  	
  	if(count == 5)
  	{
  		$("#more_funds_div").hide();
  	}else{
  		$("#more_funds_div").show();
  	}
}

function addMoreDateRange()
{
    var count = 0;
	$(".date_select").each(function(){
		count++;
	});

	for(var k=1;k<=count;k++)
	{
		var start_date = $("#txt_start_date_"+k).val();
		if(start_date == "")
		{
			$("#adv-alert-msg").html("Please select the start date "+ k );
	   	    $("#adv-alert").modal('show');
			return;
		}
		var end_date = $("#txt_end_date_"+k).val();
		if(end_date == "")
		{
			$("#adv-alert-msg").html("Please select the end date "+ k );
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	
	count++;
	
	var date_count = 5 - count;
 	$("#date_count").html(date_count);
 	
 	if(count == 5)
 	{
 		$("#more_date_div").hide();
 	}else{
 		$("#more_date_div").show();
 	}
	
	if($("#date_2").length == 0) 
	{
		count = 2;
		
	}else if($("#date_3").length == 0) 
	{
		count = 3;
	}else if($("#date_4").length == 0) 
	{
		count = 4;
	}else
	{
		count = 5;
	}
	
	var html = '<div id="date_' + count + '" class="date_select form-group row">';
	html += '<div class="col-md-5 marginBottom10 datepicker-right"><label class="font-600">Start Date :</label>';
	html += '<input type="text" id="txt_start_date_' + count + '"  class="form-control datepicker" /></div>';
	html += '<div class="col-md-5 col-xs-10 marginBottom10 datepicker-left"><label class="font-600">End Date : </label>';
	html += '<input type="text" id="txt_end_date_' + count + '"  class="form-control datepicker" /></div>';
	html += '<div class="col-md-2 col-xs-2 marginBottom10" style="position:relative; top:32px;z-index:99;"><span style="cursor:pointer;margin-left:5px;" onclick="removeMoreDateRange(' + count +')"><i class="fa fa-times-circle fa-2x"></i></span></div>';
	html += '</div>';
	
	if(count == 2)
	{
		$("#date_1").after(html);
	}else if(count == 3)
	{
		$("#date_2").after(html);
	}else if(count == 4)
	{
		$("#date_3").after(html);
	}else 
	{
		$("#date_4").after(html);
	}
	datePickerLoad();
}
function removeMoreDateRange(id)
{
     $("#date_" + id).remove();
     if($("#final_result").is(":visible"))
   	 {
    	 getData();
   	 }
     
     var count = 0;
 	$(".date_select").each(function(){
 		count++;
 	});
 	
 	var date_count = 5 - count;
  	$("#date_count").html(date_count);
  	
  	if(count == 5)
  	{
  		$("#more_date_div").hide();
  	}else{
  		$("#more_date_div").show();
  	}
}

function saveResult() 
{	
	var category = $("#sel_schemeCategories").val();
	var amount = $("#txt_amount").val();
	var schemes = '${schemes}';
	var startDates = '${startDates}';
	var endDates = '${endDates}';
	var dates = "";
	
	if(startDates != "" && endDates != "")
	{
		var start_array = startDates.split(",");
		var end_array = endDates.split(",");
		
		for(var k=0;k<start_array.length;k++)
		{
			var start_date = start_array[k];
			var end_date = end_array[k];
			dates = dates + "("+start_date+" to "+end_date+") "; 
		}
	}

	var accountMap = '${accountMap}';
	var title = "Mutual Fund Point to Point Returns - Multiple Schemes & Periods -> Category = " + category + ", Schemes = " + schemes + ", Amount - " + amount  + ", Dates - " + dates;
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

function downloadXl()
{
	var schemes = new Array(); 
	var start_dates = new Array();
	var end_dates = new Array();

	for(var k=1;k<=5;k++)
	{
		if($("#txt_fund"+k).length != 0)
		{
			var fundname = $("#txt_fund"+k).val();
			if(fundname == "")
			{
				$("#adv-alert-msg").html("Please select the fund name "+ k);
		   	    $("#adv-alert").modal('show');
				return;
			}
			schemes.push(encodeURIComponent(fundname));
		}
	}
	
	for(var k=1;k<=5;k++)
	{
		if($("#txt_start_date_"+k).length != 0)
		{
			var startdate = $("#txt_start_date_"+k).val();
			if(startdate == "")
			{
				$("#adv-alert-msg").html("Please select the start date "+ k );
		   	    $("#adv-alert").modal('show');
				return;
			}
			var enddate = $("#txt_end_date_"+k).val();
			if(enddate == "")
			{
				$("#adv-alert-msg").html("Please select the end date "+ k );
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
			start_dates.push(startdate);
			end_dates.push(enddate);
		}
	}
	var category = $("#sel_schemeCategories").val();
	var amount = $("#txt_amount").val();
	if(amount == "" || amount <= 0)
	{
		$("#adv-alert-msg").html("Please enter valid amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	
	//top.location = "/mutual-funds-research/downloadMutualFundPointToPointReturnsXL?category="+category+"&schemes="+schemes+"&startDates="+start_dates+"&endDates="+end_dates+"&amount="+amount;
	
	
	var path = "/mutual-funds-research/downloadMutualFundPointToPointReturnsXL?category="+category+"&schemes="+schemes+"&startDates="+start_dates+"&endDates="+end_dates+"&amount="+amount;
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
	    	    	top.location =  "/mutual-funds-research/downloadMutualFundPointToPointReturnsXL?category="+category+"&schemes="+schemes+"&startDates="+start_dates+"&endDates="+end_dates+"&amount="+amount+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
	
	var schemes = new Array(); 
	var start_dates = new Array();
	var end_dates = new Array();

	for(var k=1;k<=5;k++)
	{
		if($("#txt_fund"+k).length != 0)
		{
			var fundname = $("#txt_fund"+k).val();
			if(fundname == "")
			{
				$("#adv-alert-msg").html("Please select the fund name "+ k);
		   	    $("#adv-alert").modal('show');
				return;
			}
			schemes.push(encodeURIComponent(fundname));
		}
	}
	
	for(var k=1;k<=5;k++)
	{
		if($("#txt_start_date_"+k).length != 0)
		{
			var startdate = $("#txt_start_date_"+k).val();
			if(startdate == "")
			{
				$("#adv-alert-msg").html("Please select the start date "+ k );
		   	    $("#adv-alert").modal('show');
				return;
			}
			var enddate = $("#txt_end_date_"+k).val();
			if(enddate == "")
			{
				$("#adv-alert-msg").html("Please select the end date "+ k );
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
			start_dates.push(startdate);
			end_dates.push(enddate);
		}
	}
	var category = $("#sel_schemeCategories").val();
	var amount = $("#txt_amount").val();
	if(amount == "" || amount <= 0)
	{
		$("#adv-alert-msg").html("Please enter valid amount");
   	    $("#adv-alert").modal('show');
		return;
	}
	downloadPath = "/mutual-funds-research/downloadMutualFundPointToPointReturnsXL?category="+category+"&schemes="+schemes+"&startDates="+start_dates+"&endDates="+end_dates+"&amount="+amount;
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
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Mutual Fund Point to Point Returns - Multiple Schemes &amp; Period</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
	                   	<div class="row">
	                		<div class="col-md-6 col-sm-6">
			        <div class="form-group">
			          <label class="font-600">Select Category</label>
			          <select id="sel_schemeCategories" class="form-control" data-width="100%">  
			             <option value="All">All</option>
			             <c:forEach var="categories" items="${schemeCategories}"> 
			                <c:choose>
			             	<c:when test="${category eq categories}">
			             		<option selected value="<c:out value="${categories}"/>"><c:out value="${categories}"/></option>
			             	</c:when>
			             	<c:otherwise>            	    
			             		<option value="<c:out value="${categories}"/>"><c:out value="${categories}"/></option>
			             	</c:otherwise>
			             	</c:choose>
			             </c:forEach>                             
			          </select>
			        </div>
		         </div>
		         
		         <div class="col-md-6 col-sm-6">
		          <div id="div_txt_funds">              
		          <div id="div_fund_1" class="form-group fund">
		          <label class="font-600 width-100">Fund 1</label>
		          <input id="txt_fund1" type="text" class="txt_fund form-control no-radius">
		          </div>       
		          </div>
		          
		          <div class="form-group" id="more_funds_div">
					<a href="javascript:void(0);" class="stepsAddmore" onclick="addMoreFund()"><i class="fa fa-plus-square marginRight10"></i> Add another fund (upto <span id="fund_count">4</span>)</a>
				  </div>
	                		</div>
	                	</div>
	                	
	                	<div class="row">
	                		<div class="col-md-6 col-sm-6">
				  <div class="form-group">
				    <label class="font-600">Invested Amount</label>
				    <input type="text" id="txt_amount" maxlength="8" class="form-control no-radius" value="${amount}" />
				  </div>
				</div>
		        
		        <div class="col-md-6 col-sm-6 margin-bottom10">
			        <div id="date_1" class="date_select form-group row">
						<div class="col-md-5 col-sm-5 marginBottom10 datepicker-right">
							<label class="font-600">Start Date :</label> 
							<input type="text" id="txt_start_date_1"  class="form-control datepicker" />
						</div>
						<div class="col-md-5 col-sm-5 marginBottom10 datepicker-left">
							<label class="font-600">End Date : </label> 
							<input type="text" id="txt_end_date_1"  class="form-control datepicker" />
						</div>
				    </div>
				    <div class="form-group" id="more_date_div">
						<a href="javascript:void(0);" class="stepsAddmore" onclick="addMoreDateRange()"><i class="fa fa-plus-square marginRight10"></i> Add another Date Range (upto <span id="date_count">4</span>)</a>
				  	</div>
		        </div>
	                	</div>
	                	
	                	<div class="row">
			   <div class="col-md-3 col-sm-3">
			      <div class="form-group">
			         <div class="marginTop15">
			            <a href="javascript:void(0)" class="btn btn-primary" style="width: 50%;" onclick="getData()">Submit</a>
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

		  <div class="col-md-12 col-sm-12 table-responsive mt-1">
	       <table class="table" id="final_result">
	       <thead>
	       <tr>
	       <th rowspan="2">Scheme Name</th>
	       <c:set var="date_count" value="0"></c:set>
	       <c:forEach items="${startDates}" var="startDate" varStatus="status">
	       <c:set var="date_count" value="${status.count}"></c:set>
	       <th class="text-center" colspan="2">${startDate} to 
	       <c:forEach items="${endDates}" var="endDate" begin="${status.index}" end="${status.index}">
	       ${endDate}
	       </c:forEach>
	       </th>
	       </c:forEach>
	       </tr>
		   <tr>
	       <c:set var="date_count" value="0"></c:set>
	       <c:forEach items="${startDates}" var="startDate" varStatus="status">
	       <c:set var="date_count" value="${status.count}"></c:set>
	       <th class="text-center">Growth Value</th>
	       <th class="text-center">Absolute Return (%)</th>
	       </c:forEach>
	       </tr>
	       </thead><tbody>
			<c:forEach items="${schemePerformances}" var="schemePerformances">
			
			<c:choose>
			<c:when test="${schemePerformances.category == ''}">
			<tr class="yellow_color">
			<td><c:out value="${schemePerformances.scheme}"></c:out></td>
			</c:when>
			<c:otherwise>
			<tr class="returns-calculator">
			<td><a href='/mutual-funds-research/<c:out value="${schemePerformances.scheme}"></c:out>' class="mutual-funds-anchor"><c:out value="${schemePerformances.scheme}"></c:out></a>
			</td>
			</c:otherwise>
			</c:choose>
			
			<c:if test="${date_size gt 0}">
			<c:choose>
			<c:when test="${schemePerformances.date1_current_value eq 0}">
			<td>-</td>
			<td>-</td>
			</c:when>
			<c:otherwise>
			<td class="text-center"><fmt:formatNumber type="number" maxFractionDigits="0" value="${schemePerformances.date1_current_value}" /></td>
			<td class="text-center"><fmt:formatNumber value="${((schemePerformances.date1_current_value - schemePerformances.current_cost) / schemePerformances.current_cost) * 100}" minFractionDigits="2" maxFractionDigits="2" /></td>
			</c:otherwise>
			</c:choose>
			</c:if>
			
			<c:if test="${date_size gt 1}">
			<c:choose>
			<c:when test="${schemePerformances.date2_current_value eq 0}">
			<td>-</td>
			<td>-</td>
			</c:when>
			<c:otherwise>
			<td class="text-center"><fmt:formatNumber type="number" maxFractionDigits="0" value="${schemePerformances.date2_current_value}" /></td>
			<td class="text-center"><fmt:formatNumber value="${((schemePerformances.date2_current_value - schemePerformances.current_cost) / schemePerformances.current_cost) * 100}" minFractionDigits="2" maxFractionDigits="2" /></td>
			</c:otherwise>
			</c:choose>
			</c:if>
			
			<c:if test="${date_size gt 2}">
			<c:choose>
			<c:when test="${schemePerformances.date3_current_value eq 0}">
			<td>-</td>
			<td>-</td>
			</c:when>
			<c:otherwise>
			<td class="text-center"><fmt:formatNumber type="number" maxFractionDigits="0" value="${schemePerformances.date3_current_value}" /></td>
			<td class="text-center"><fmt:formatNumber value="${((schemePerformances.date3_current_value - schemePerformances.current_cost) / schemePerformances.current_cost) * 100}" minFractionDigits="2" maxFractionDigits="2" /></td>
			</c:otherwise>
			</c:choose>
			</c:if>
			
			<c:if test="${date_size gt 3}">
			<c:choose>
			<c:when test="${schemePerformances.date4_current_value eq 0}">
			<td>-</td>
			<td>-</td>
			</c:when>
			<c:otherwise>
			<td class="text-center"><fmt:formatNumber type="number" maxFractionDigits="0" value="${schemePerformances.date4_current_value}" /></td>
			<td class="text-center"><fmt:formatNumber value="${((schemePerformances.date4_current_value - schemePerformances.current_cost) / schemePerformances.current_cost) * 100}" minFractionDigits="2" maxFractionDigits="2" /></td>
			</c:otherwise>
			</c:choose>
			</c:if>
			
			<c:if test="${date_size gt 4}">
			<c:choose>
			<c:when test="${schemePerformances.date5_current_value eq 0}">
			<td>-</td>
			<td>-</td>
			</c:when>
			<c:otherwise>
			<td class="text-center"><fmt:formatNumber type="number" maxFractionDigits="0" value="${schemePerformances.date5_current_value}" /></td>
			<td class="text-center"><fmt:formatNumber value="${((schemePerformances.date5_current_value - schemePerformances.current_cost) / schemePerformances.current_cost) * 100}" minFractionDigits="2" maxFractionDigits="2" /></td>
			</c:otherwise>
			</c:choose>
			</c:if>
			
			</tr>	
			
			</c:forEach>
		   </tbody>
		   </table>
		 </div>
      </div>
   </div>
   </div>
</section>