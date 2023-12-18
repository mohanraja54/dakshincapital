<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
#performance_div .form-control, #performance_div label, #performance_div .multiselect {
    font-size: 11px;
}
#enhancement_select_div .bootstrap-select .btn-default {
    background-color: #ffc04c;
}
.bg-color{
    background-color: #ffedcc !important;
}
.btn {
    border-bottom: 1px solid #ccc !important;
   
}
.btn-default {
    color: #333;
    background-color: #fff;
    border-color: #ccc;
}
#tbl_scheme_returns tfoot tr td{
	background-color: #ffd;
	font-weight: 500;
}
.margintop20
{
margin-top:20px;
}
.margintop30
{
margin-top:30px;
}
.marginbottom20
{
margin-bottom:20px;
}
.button-color {	
    padding: 7px 19px;  
    background-color: #FF6633;
    height:35px;
}
.button-color:hover {	 
    background-color: #FF6633;
}

.breadcrumb {   
    background: none;
}
.breadcrumb > .active
{
	color: #f7931d;
}
.clear{
	clear:both;
}
.font-size-18
{
font-size:18px;
}
.marginTop0
{
	margin-top: 0;
}
.bold
{
	font-weight:bold;
}
.sub .form-group .btn
{   
height: 30px;   
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
</style>


<script>
$(document).ready(function(){
	
	$('#mf_fund_txt').typeahead({
	    source: function (query, process) {
	        return $.ajax({
	            url: '/mutual-funds-research/autoSuggestAllMfSchemes',
	            type: 'post',
	            data: { 
	            	query: query,
	            	category: "All"
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
	
	$('#div_results .collapse').on('show.bs.collapse', function () {

		$(this).prev().find(".fa-plus-circle").removeClass("fa-plus-circle").addClass("fa-minus-circle");
	});

	$('#div_results .collapse').on('hide.bs.collapse', function () {

		$(this).prev().find(".fa-minus-circle").removeClass("fa-minus-circle").addClass("fa-plus-circle");
	});
	
	getGraph();
	
$("#save_img").on('click', function () {
		
		var scheme = $("#mf_fund_txt").val();
	    var amount = $("#txt_sip_amount").val();
	    var frequency = $("#sel_frequency").val();
	    var startdate = $("#txt_start_date").val();
	    var enddate = $("#txt_end_date").val();
	    var enhancement_percentage = $("#sel_enhancement").val();
	    
	 	if(scheme == "" || amount == "" || startdate == "" || enddate == "")
	 	{
	 		$("#adv-alert-msg").html("All fields are mandatory");
	   	    $("#adv-alert").modal('show');
			return;
	 	}
		if(isNaN(amount) || parseInt(amount) < 1)
		{
			$("#adv-alert-msg").html("Please enter the valid amount");
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
		if(frequency == "0")
		{
			$("#adv-alert-msg").html("Please select frequency");
	   	    $("#adv-alert").modal('show');
			return;
		}
		if(frequency == "Daily")
		{
			start_date.setDate(start_date.getDate() + 1);
			if(end_date <= start_date)
			{
				$("#adv-alert-msg").html("Please select valid start date and end date");
		   	    $("#adv-alert").modal('show');
				return;
			}
		}
		if(frequency == "Weekly")
		{
			start_date.setDate(start_date.getDate() + 7);
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
	 	if(scheme == null || scheme == "")
	    {
	 		$("#adv-alert-msg").html("Please select schemes");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }	
	 	var schemeName = encodeURIComponent(scheme);
		var flag = false;
		
		$.ajaxSetup({async:false});
		$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
	    {
			var schemes = $.trim(data);
			var schemes_obj = jQuery.parseJSON(schemes);
			var schemes_array = $.makeArray(schemes_obj);
			var inception_date =  new Date(schemes_array[0]);
			if(start_date < inception_date)
			{
				$("#adv-alert-msg").html(scheme+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
		   	    $("#adv-alert").modal('show');
		   	 	flag = true;
				return false;
			}
	    },'text');
		
		if(flag)
		{
			return false;
		}
		
        /* html2canvas(document.querySelector("#sip-gth-container")).then(canvas => {
			getCanvas = canvas;     //or whatever you want to execute 
			var imgageData = getCanvas.toDataURL("image/png");
			img = imgageData.replace('data:image/png;base64,', '');
			$.ajaxSetup({async:false});
			$.post("/mutual-funds-research/base64toimage", {base64image : img, filename:"annual-increase"}, function(data){
				top.location = "/mutual-funds-research/downloadAnnualIncrease?scheme="+encodeURIComponent(scheme)+"&amount="+amount+"&frequency="+frequency+"&start_date="+startdate+"&end_date="+enddate+"&enhancement_percentage="+enhancement_percentage;
			},'text');
        }); */
        
        
        var path = "/mutual-funds-research/downloadAnnualIncrease?scheme="+encodeURIComponent(scheme)+"&amount="+amount+"&frequency="+frequency+"&start_date="+startdate+"&end_date="+enddate+"&enhancement_percentage="+enhancement_percentage;
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
    	    	    	//top.location =  "/mutual-funds-research/downloadAnnualIncrease?scheme="+encodeURIComponent(scheme)+"&amount="+amount+"&frequency="+frequency+"&start_date="+startdate+"&end_date="+enddate+"&enhancement_percentage="+enhancement_percentage+"&download=yes";
    	    	    	
    	    	    	html2canvas(document.querySelector("#sip-gth-container")).then(canvas => {
    	    				getCanvas = canvas;     //or whatever you want to execute 
    	    				var imgageData = getCanvas.toDataURL("image/png");
    	    				img = imgageData.replace('data:image/png;base64,', '');
    	    				$.ajaxSetup({async:false});
    	    				$.post("/mutual-funds-research/base64toimage", {base64image : img, filename:"annual-increase"}, function(data){
    	    					top.location = "/mutual-funds-research/downloadAnnualIncrease?scheme="+encodeURIComponent(scheme)+"&amount="+amount+"&frequency="+frequency+"&start_date="+startdate+"&end_date="+enddate+"&enhancement_percentage="+enhancement_percentage+"&download=yes";
    	    				},'text');
    	    	        });
    	    	    }
    	        }
    	    }
    	};
    	xhr.send(null);
        
   });
	
});
function checkStartDate()
{
    var scheme_name = $("#mf_fund_txt").val();
    var from_date = $("#txt_start_date").val();
	
	if(scheme_name == null || scheme_name == "")
    {
 		$("#adv-alert-msg").html("Please select scheme");
   	    $("#adv-alert").modal('show');
   	    return false;
    }
	if(from_date == "")
 	{
 		$("#adv-alert-msg").html("Please select start date.");
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
		var inception_date =  new Date(schemes_array[0]);
		if(start_date < inception_date)
		{
			$("#adv-alert-msg").html(scheme_name+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
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
    var scheme = $("#mf_fund_txt").val();
    var amount = $("#txt_sip_amount").val();
    var frequency = $("#sel_frequency").val();
    var startdate = $("#txt_start_date").val();
    var enddate = $("#txt_end_date").val();
    var enhancement_percentage = $("#sel_enhancement").val();
    
 	if(scheme == "" || amount == "" || startdate == "" || enddate == "")
 	{
 		$("#adv-alert-msg").html("All fields are mandatory");
   	    $("#adv-alert").modal('show');
		return;
 	}
	if(isNaN(amount) || parseInt(amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid amount");
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
	if(frequency == "0")
	{
		$("#adv-alert-msg").html("Please select frequency");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(frequency == "Daily")
	{
		start_date.setDate(start_date.getDate() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(frequency == "Weekly")
	{
		start_date.setDate(start_date.getDate() + 7);
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
 	if(scheme == null || scheme == "")
    {
 		$("#adv-alert-msg").html("Please select schemes");
   	    $("#adv-alert").modal('show');
   	    return false;
    }	
 	var schemeName = encodeURIComponent(scheme);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var inception_date =  new Date(schemes_array[0]);
		if(start_date < inception_date)
		{
			$("#adv-alert-msg").html(scheme+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
 	document.location = "/mutual-funds-research/sip-with-annual-increase/" + encodeURIComponent(scheme) + "?amount="+amount+"&frequency="+frequency+"&start_date="+startdate+"&end_date="+enddate+"&enhancement_percentage="+enhancement_percentage
}

function getGraph()
{
	var scheme = $("#mf_fund_txt").val();
    var amount = $("#txt_sip_amount").val();
    var frequency = $("#sel_frequency").val();
    var startdate = $("#txt_start_date").val();
    var enddate = $("#txt_end_date").val();
    var enhancement_percentage = $("#sel_enhancement").val();
	
    var fundArray = new Array();
    fundArray.push(scheme + "||false");
    fundArray.push(scheme + "||true");
    
    var fundArrayName = new Array();
    fundArrayName.push(scheme);
    fundArrayName.push(scheme + " with "+enhancement_percentage+"% Enhancement yearly");
    
    $("#div_results").show();
 	
 	var container_width = $("#sip-gth-div").width();
    
	var seriesOptions = [],
    seriesCounter = 0,
    names = fundArray,
    // create the chart when all data is loaded
    createChart = function () {

        $('#sip-gth-container').highcharts('StockChart', {
        	colors: ['#005e96','#005e96','#FF8900', '#DDDF00', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4'],
        	rangeSelector : {
	            enabled: false
	        },
	        navigator: {
	            enabled: false
	        },
	        credits: {
	        	enabled : false,
                text: "Advisorkhoj.com",
                href: "https://www.advisorkhoj.com/",
                style: {
                	cursor: 'pointer',
                	color: '#0000ff',
                	fontSize: '10px'
                }
	        },
	        scrollbar : {
                enabled : false
            },
            xAxis: {
            	gridLineColor: "#666",
            	gridLineWidth: 1,
            	lineColor: "#666",
            	tickColor: "#666"
            },
            yAxis: {
            	gridLineColor: "#666",
            	gridLineWidth: 1,
            	lineColor: "#666",
            	tickColor: "#666"
            },
            title: {
                text: 'SIP with ' + enhancement_percentage + '% Yearly Enhancement',
                style: {
                    font: 'bold 12px Helvetica Neue, Helvetica, Arial, sans-serif',
                }
            },            
            plotOptions: {
            	series: {
                    connectNulls: true,
                    dataGrouping: {
                        enabled: false
                    }
                }
            },
            legend: {
             	 enabled: true,
             	itemStyle: {
              	  font: 'normal 12px Helvetica Neue, Helvetica, Arial, sans-serif',
                 }
           },
            tooltip: {
                headerFormat: '<small>{point.key}</small><br>',
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>',
                valueDecimals: 2,
                xDateFormat : '%b %d, %Y'
            },

            series: seriesOptions,
            chart: {
            	width : container_width,
            	events: {
            	load: function(event) {
            		$("#sip-gth-spinner").addClass("hidden");
                    $("#sip-gth-container").show();
            	}
            	}
            	}
        });
    };

$.each(names, function (i, name) {

    $.getJSON('/mutual-funds-research/getSipEnhancementGraph?scheme=' + encodeURIComponent(fundArray[i]) + "&amount="+amount+"&frequency="+frequency+"&start_date="+startdate+"&end_date="+enddate+"&enhancement_percentage="+enhancement_percentage,    function (data) {

        seriesOptions[i] = {
            name: fundArrayName[i],
            data: data,
            type: 'area'
        };

        // As we're loading the data asynchronously, we don't know what order it will arrive. So
        // we keep a counter and create the chart when all the data is loaded.
        seriesCounter += 1;

        if (seriesCounter === names.length) {
            createChart();
        }
    });
});
}



function openLogin(){
	
	var scheme = $("#mf_fund_txt").val();
    var amount = $("#txt_sip_amount").val();
    var frequency = $("#sel_frequency").val();
    var startdate = $("#txt_start_date").val();
    var enddate = $("#txt_end_date").val();
    var enhancement_percentage = $("#sel_enhancement").val();
    
 	if(scheme == "" || amount == "" || startdate == "" || enddate == "")
 	{
 		$("#adv-alert-msg").html("All fields are mandatory");
   	    $("#adv-alert").modal('show');
		return;
 	}
	if(isNaN(amount) || parseInt(amount) < 1)
	{
		$("#adv-alert-msg").html("Please enter the valid amount");
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
	if(frequency == "0")
	{
		$("#adv-alert-msg").html("Please select frequency");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(frequency == "Daily")
	{
		start_date.setDate(start_date.getDate() + 1);
		if(end_date <= start_date)
		{
			$("#adv-alert-msg").html("Please select valid start date and end date");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if(frequency == "Weekly")
	{
		start_date.setDate(start_date.getDate() + 7);
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
 	if(scheme == null || scheme == "")
    {
 		$("#adv-alert-msg").html("Please select schemes");
   	    $("#adv-alert").modal('show');
   	    return false;
    }	
 	var schemeName = encodeURIComponent(scheme);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var inception_date =  new Date(schemes_array[0]);
		if(start_date < inception_date)
		{
			$("#adv-alert-msg").html(scheme+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
	   	    $("#adv-alert").modal('show');
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}
    
	downloadPath = "/mutual-funds-research/downloadAnnualIncrease?scheme="+encodeURIComponent(scheme)+"&amount="+amount+"&frequency="+frequency+"&start_date="+startdate+"&end_date="+enddate+"&enhancement_percentage="+enhancement_percentage;
	imageDownload = "yes";
	chartId = "#sip-gth-container";
	filename = "annual-increase";
	$("#adv-login").modal("show");
}
</script>

<section class="main-container mf-research">

	<div class="container-fluid pr-0 pl-0">
	<div class="row ml-0 mr-0">
		<div class="col-md-3 bg-mfbar py-3">
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">SIP with Annual Increase</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
              	<div class="row">
              		 <div class="col-md-6 col-sm-5">
          <div class="form-group">
          <label class="font-600">Type Any Scheme Name</label>
          <input id="mf_fund_txt" type="text" class="form-control no-radius input-sm" value="${scheme}" placeholder="Type Fund Name and Click Submit">
          </div>
      	  </div>

         <div class="col-md-3 col-sm-3">
          <div class="form-group">
            <label class="font-600">Installment Amount</label>
            <input type="text" id="txt_sip_amount" value="${amount}" maxlength="5" class="form-control no-radius input-sm" />
          </div>
      </div>
       
         <div class="col-md-3 col-sm-3">
        <div class="form-group">
            <label class="font-600 block">Select Frequency</label>
            <select id="sel_frequency" class="form-control input-sm" data-width="100%">
				<option value="0">Select</option>
				<option value="Fortnightly" <c:if test="${frequency eq 'Fortnightly' }"><c:out value="selected" /></c:if>>Fortnightly</option>
            	<option value="Monthly" <c:if test="${frequency eq 'Monthly' }"><c:out value="selected" /></c:if>>Monthly</option>
            	<option value="Quarterly" <c:if test="${frequency eq 'Quarterly' }"><c:out value="selected" /></c:if>>Quarterly</option>
			</select>
          </div>
       </div>
                    </div>
                    
                    <div class="row">
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
       
       <div class="col-md-3 col-sm-3">
         <div class="form-group" id="enhancement_select_div">
           <label class="font-600 block">Select Yearly Enhancement(%)</label>
           <select id="sel_enhancement" class="form-control input-sm" data-width="100%">
			<option value="5" <c:if test="${enhancementPercentage eq '5' }"><c:out value="selected" /></c:if>>5</option>
			<option value="10" <c:if test="${enhancementPercentage eq '10' }"><c:out value="selected" /></c:if>>10</option>
			<option value="15" <c:if test="${enhancementPercentage eq '15' }"><c:out value="selected" /></c:if>>15</option>
			<option value="20" <c:if test="${enhancementPercentage eq '20' }"><c:out value="selected" /></c:if>>20</option>
			<option value="25" <c:if test="${enhancementPercentage eq '25' }"><c:out value="selected" /></c:if>>25</option>
			<option value="50" <c:if test="${enhancementPercentage eq '50' }"><c:out value="selected" /></c:if>>50</option>
			<option value="75" <c:if test="${enhancementPercentage eq '75' }"><c:out value="selected" /></c:if>>75</option>
			<option value="100" <c:if test="${enhancementPercentage eq '100' }"><c:out value="selected" /></c:if>>100</option>
		</select>
         </div>
       </div>
       
       <div class="col-md-2 col-sm-2">
       	   <a href="javascript:void(0)" class="btn btn-primary hidden-xs btn-xss" style="position: absolute;top: 35%;width:70%;" onclick="getData()">Submit</a>	         	   
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
			  			<a id="save_img" style="cursor:pointer;float:right;color:white;text-decoration:none;" class="btn btn-sm btn-success">Download Result</a>	
			  	    </c:otherwise>
			  	</c:choose>
		        </div>
	     	</div>
				
         	<div id="sip-gth-div" class="col-xs-12 col-md-12 col-sm-12 marginTop15 padding0 adv-panel-border panel panel-default text-center">
		  		<div id="sip-gth-container" style="height:400px;min-width: 250px;"></div>
		  	</div>
                      
		      <div class="col-xs-12 col-sm-12 col-md-12" style="color:#000;">
				<strong>Note - </strong>${enhancementPercentage}% yearly enhancement is Rs ${enhancementAmount}
			   </div>
			  <div id="div_results" class="col-md-12 col-sm-12 col-xs-12 table-responsive"> 
		         <table class="adv-table table dataTable">
				  <thead><tr>
				  <th>Scheme</th>
				  <th class="text-right">SIP Investment Cost</th>
				  <th class="text-right">SIP Value as on ${end_date}</th>
				  <th class="text-right">Growth Amount</th>
				  <th class="text-right">Enhanced Growth Amount</th>
				  <th class="text-right">Enhanced Growth (%)</th>
				  <th class="text-center">Cash Flow</th>
				  </tr></thead><tbody>
			     <c:forEach items="${sipYearlyEnhancementResponse}" var="sipYearlyEnhancement" varStatus="status">
			     
			      <c:set var="ep" value="00.00"></c:set>
			      <c:if test="${sipYearlyEnhancement.enhancementPercentage != '.00'}">
			      <fmt:parseNumber var="ep" integerOnly="true" type="number" value="${sipYearlyEnhancement.enhancementPercentage}" />
			      </c:if>
			      
			      
			      <c:choose>	       
			       <c:when test="${enhancementPercentage eq ep}">
				      <tr>
				       <td class="bg-color"><a class="mutual-funds-anchor" href="/mutual-funds-research/${scheme}">${scheme} with ${sipYearlyEnhancement.enhancementPercentage}% yearly enhancement </a></td>
				       <td class="bg-color text-right">${sipYearlyEnhancement.investmentAmount}</td>
				       <td class="bg-color text-right">${sipYearlyEnhancement.investmentValue}</td>
				       <td class="bg-color text-right">${sipYearlyEnhancement.sipGrowth}</td>
				       <td class="bg-color text-right">${sipYearlyEnhancement.enhancementGrowth}</td>
				       <td class="bg-color text-right">${sipYearlyEnhancement.enhancementGrowthPercent}<c:if test="${sipYearlyEnhancement.enhancementGrowthPercent != '-'}">%</c:if></td>
				       <td class="bg-color text-center" data-toggle="collapse" data-target="#category-accordion${status.index}" style="cursor:pointer;"><a href="javascript:void();"><i class="fa fa-lg fa-plus-circle" aria-hidden="true"></i></a></td>
				      </tr>
			       </c:when>
			       <c:otherwise>
			          <tr>
			           <%-- <td>${enhancementPercentage} - ${ep}</td> --%>
				       <td><a class="mutual-funds-anchor" href="/mutual-funds-research/${scheme}">${scheme} with ${sipYearlyEnhancement.enhancementPercentage}% yearly enhancement</a></td>
				       <td class="text-right">${sipYearlyEnhancement.investmentAmount}</td>
				       <td class="text-right">${sipYearlyEnhancement.investmentValue}</td>
				       <td class="text-right">${sipYearlyEnhancement.sipGrowth}</td>
				       <td class="text-right">${sipYearlyEnhancement.enhancementGrowth}</td>
				       <td class="text-right">${sipYearlyEnhancement.enhancementGrowthPercent}<c:if test="${sipYearlyEnhancement.enhancementGrowthPercent != '-'}">%</c:if></td>
				       <td class="text-center" data-toggle="collapse" data-target="#category-accordion${status.index}" style="cursor:pointer;"><a href="javascript:void();"><i class="fa fa-lg fa-plus-circle" aria-hidden="true"></i></a></td>
				      </tr>
			       </c:otherwise>
			      </c:choose>	
			      
			    <tr id="category-accordion${status.index}" class="collapse accordion-body">									    
				<td colspan="7">
				<div class="table-responsive">
				<table class="table table-striped table-bordered table-hover font-12">
				<thead>
				<tr>
				<th class="text-center">Nav Date</th>
				<th class="text-right">Nav</th>	
				<th class="text-right">Cumulative Units</th>
				<th class="text-right">Cumulative Invested Amount</th>		       
				<th class="text-right">Market Value</th>                   
				</tr>
				</thead>
				<tbody> 										            
				<c:forEach var="sipNavResponse" items="${sipNavResponseList[status.index]}">
				<tr> 
				<td class="text-center"><fmt:formatDate pattern="dd-MM-yyyy" value="${sipNavResponse.nav_date}" /></td>
				<td class="text-right"><fmt:formatNumber value="${sipNavResponse.net_asset_value}" maxFractionDigits="4" /></td>
				<td class="text-right"><fmt:formatNumber value="${sipNavResponse.cumulative_units}" maxFractionDigits="2" /></td>
				<td class="text-right"><fmt:formatNumber value="${sipNavResponse.amount}" maxFractionDigits="0" /></td>
				<td class="text-right"><fmt:formatNumber value="${sipNavResponse.current_value}" maxFractionDigits="0" /></td>
				</tr>
				</c:forEach>										        
				</tbody>
				</table>
				</div>
				</td>										    						
				</tr>
			      
			     </c:forEach>
			     </tbody>
			     </table>
			   </div>
      </div>
   </div>
</div>
</section>