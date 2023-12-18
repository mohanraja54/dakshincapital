<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
#div_fund_2,#div_fund_3,#div_fund_4,#div_fund_5{
	display:none;
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
table.dataTable thead th, table.dataTable thead td {
    border-bottom: 1px solid #dedede;
}
table.dataTable{
	border-bottom: 1px solid #dedede;
}

table.dataTable.no-footer{
	border-bottom: 0 !important;
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

$(document).ready(function(){
	
	var type = '${type}';
	if(type == "lumpsum")
	{
		$("#period_div").hide();
	}else
	{
		$("#period_div").show();
	}
	
	initializeTypeAhead();
	
	$('.datepicker').datepicker({
		format: 'dd-mm-yyyy',
		endDate: '-1d',
		autoclose:true,
		disableTouchKeyboard:true
	});
	
	var fund = '${schemes}';
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
	
	showGraph();
	//showBarGraph();
	
	$('#tbl_scheme_returns1').dataTable({
		"searching": false,
        "ordering": false,
        "info":     false,
        "sDom": "lfrti",
        "columns": [
        	{ "width": "25%" },
            { "width": "15%" },
            { "width": "5%" },
            { "width": "5%" },
            { "width": "20%" },
            { "width": "5%" },
            { "width": "15%" },
            { "width": "5%" },
            { "width": "5%" },
            { "width": "5%" },
          ]
	});
	
	$("#save_img").on('click', function () {
		
		var fundname1 = $("#txt_fund1").val();
		var fundname2 = "";
		var fundname3 = "";
		var fundname4 = "";
		var fundname5 = "";
		var amount = $("#txt_amount").val();
		var startdate = $("#txt_start_date").val();
		var enddate = $("#txt_end_date").val();
		var frequency = $("#sel_frequency").val();
		var type = $("#sel_option").val();
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
		if(type == "0")
		{
			$("#adv-alert-msg").html("Please select option");
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
		
		var ele = document.getElementById("submit_btn");
	 	//var l = Ladda.create(ele);
	 	//l.start();
	 	
	 	var scheme_array = new Array();
		for(var k=0;k<fund_array.length;k++)
		{
			var scheme_name = fund_array[k];
			var schemeName = encodeURIComponent(scheme_name);
			scheme_array.push(schemeName);
		}
		
		//l.stop();
			
	     /*  html2canvas(document.querySelector("#lumpsum-gth-container")).then(canvas => { 
		getCanvas = canvas;     //or whatever you want to execute 
		var imgageData = getCanvas.toDataURL("image/png");
		img = imgageData.replace('data:image/png;base64,', '');
		$.ajaxSetup({async:false});
		$.post("/mutual-funds-research/base64toimage", {base64image : img, filename:"ppf-vs-elss"}, function(data){
			top.location = "/mutual-funds-research/downloadPpfvsElss?schemes="+scheme_array+"&amount="+amount+"&start_date="+startdate+"&end_date="+enddate+"&period="+frequency+"&type="+type;
		},'text');
	      }); */
	        
	    var path = "/mutual-funds-research/downloadPpfvsElss?schemes="+scheme_array+"&amount="+amount+"&start_date="+startdate+"&end_date="+enddate+"&period="+frequency+"&type="+type;
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
	   	    	     	html2canvas(document.querySelector("#lumpsum-gth-container")).then(canvas => { 
			   	 			getCanvas = canvas;     //or whatever you want to execute 
			   	 			var imgageData = getCanvas.toDataURL("image/png");
			   	 			img = imgageData.replace('data:image/png;base64,', '');
			   	 			$.ajaxSetup({async:false});
			   	 			$.post("/mutual-funds-research/base64toimage", {base64image : img, filename:"ppf-vs-elss"}, function(data){
			   	 				top.location = "/mutual-funds-research/downloadPpfvsElss?schemes="+scheme_array+"&amount="+amount+"&start_date="+startdate+"&end_date="+enddate+"&period="+frequency+"&type="+type+"&download=yes";
			   	 			},'text');
		   	         	});
	   	    	    }
	   	        }
	   	    }
	   	};
	   	xhr.send(null);     
	        
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
	            	category: "Equity: ELSS"
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
	var fundname1 = $("#txt_fund1").val();
	var fundname2 = $("#txt_fund2").val();
	var fundname3 = $("#txt_fund3").val();
	var fundname4 = $("#txt_fund4").val();
	var fundname5 = $("#txt_fund5").val();
	var amount = $("#txt_amount").val();
	var startdate = $("#txt_start_date").val();
	var enddate = $("#txt_end_date").val();
	var frequency = $("#sel_frequency").val();
	var type = $("#sel_option").val();
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
	if(type == "0")
	{
		$("#adv-alert-msg").html("Please select option");
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
	
	//$.LoadingOverlay("show");
	
	var scheme_array = new Array();
	for(var k=0;k<fund_array.length;k++)
	{
		var scheme_name = fund_array[k];
		var schemeName = encodeURIComponent(scheme_name);
		scheme_array.push(schemeName);
	}
	
	//$.LoadingOverlay("hide");
	
	top.location = "/mutual-funds-research/ppf-vs-elss?schemes="+scheme_array+"&amount="+amount+"&start_date="+startdate+"&end_date="+enddate+"&period="+frequency+"&type="+type;	
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

function gotoTop()
{
	$('html,body').animate({
        scrollTop: 0
    }, 700);
}
function showPeriod()
{
	var type = $("#sel_option").val();
	if(type == "0")
	{
		$("#adv-alert-msg").html("Please select option");
   	    $("#adv-alert").modal('show');
		return;
	}
	if(type == "lumpsum")
	{
		$("#period_div").hide();
	}else
	{
		$("#period_div").show();
	}
}
function showGraph()
{
	var fundname1 = $("#txt_fund1").val();
	var fundname2 = $("#txt_fund2").val();
	var fundname3 = $("#txt_fund3").val();
	var fundname4 = $("#txt_fund4").val();
	var fundname5 = $("#txt_fund5").val();
	var amount = $("#txt_amount").val();
	var startdate = $("#txt_start_date").val();
	var enddate = $("#txt_end_date").val();
	var frequency = $("#sel_frequency").val();
	var type = $("#sel_option").val();
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
	if(type == "0")
	{
		$("#adv-alert-msg").html("Please select option");
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
	
	$("#lumpsum-gth-container").hide();
	$("#lumpsum-gth-spinner").removeClass("hidden");
	
	var container_width = $("#lumpsum-gth-div").width();
	
	var lumpsumArray = new Array();
	var lumpsumNameArray = new Array();

	for(var k=0;k<fund_array.length;k++)
	{
		lumpsumArray.push(encodeURIComponent(fund_array[k]));
		lumpsumNameArray.push(fund_array[k]);
	}
	
	lumpsumArray.push(encodeURIComponent("PPF"));
	lumpsumNameArray.push("PPF");
	
	var colors = ['#005e96', '#ee1c25','#711200','#004301','#FF8900', '#DDDF00', '#FF9655', '#FFF263', '#6AF9C4'];
	
	var seriesOptions = [],
    seriesCounter = 0,
    names = lumpsumArray,
    
    // create the chart when all data is loaded
    createChart = function () {

    $('#lumpsum-gth-container').highcharts('StockChart', {
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
            	gridLineColor: "#eee",
            	gridLineWidth: 1,
            	lineColor: "#eee",
            	tickColor: "#eee"
            },
            yAxis: {
            	gridLineColor: "#eee",
            	gridLineWidth: 1,
            	lineColor: "#eee",
            	tickColor: "#eee"
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
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>',
                valueDecimals: 2,
                xDateFormat : '%b %d, %Y'
            },

            series: seriesOptions,
            chart: {
            	events: {
            	load: function(event) {
                    $("#lumpsum-gth-spinner").addClass("hidden");
                    $("#lumpsum-gth-container").show();
            	}
            	},
            	width : container_width,
           }
        });
    };  
    
    $.each(names, function (i, name) {
    $.getJSON('/mutual-funds-research/getPPFGraphData?scheme='+name+"&amount="+amount+"&startdate="+startdate+"&enddate="+enddate+"&frequency="+frequency+"&type="+type,  function (values) {
        seriesOptions[i] = {
            name: lumpsumNameArray[i],
            data: values,
            color: colors[i]
        };

        seriesCounter += 1;

        if (seriesCounter === names.length) {
            createChart();
        }
    });
    
    });
    
    Highcharts.setOptions({
    	global: {
    		useUTC: false
    	}
    });
}

function showBarGraph()
{
	var fundname1 = $("#txt_fund1").val();
	var fundname2 = $("#txt_fund2").val();
	var fundname3 = $("#txt_fund3").val();
	var fundname4 = $("#txt_fund4").val();
	var fundname5 = $("#txt_fund5").val();
	var amount = $("#txt_amount").val();
	var startdate = $("#txt_start_date").val();
	var enddate = $("#txt_end_date").val();
	var frequency = $("#sel_frequency").val();
	var type = $("#sel_option").val();
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
	if(type == "0")
	{
		$("#adv-alert-msg").html("Please select option");
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
	
	$("#sip-gth-container").hide();
	$("#sip-gth-spinner").removeClass("hidden");
	
	var container_width = $("#sip-gth-div").width();
	
	var lumpsumArray = new Array();
	var lumpsumNameArray = new Array();

	for(var k=0;k<fund_array.length;k++)
	{
		lumpsumArray.push(encodeURIComponent(fund_array[k]));
		lumpsumNameArray.push(fund_array[k]);
	}
	
	lumpsumArray.push(encodeURIComponent("PPF"));
	lumpsumNameArray.push("PPF");
	
	
	var year_array = new Array();
	var data_array = new Array();
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getPPFBarGraphData", {schemes : "" + lumpsumArray + "",amount : "" + amount + "",startdate : "" + startdate + "",enddate : "" + enddate + "",frequency : "" + frequency + "",type : "" + type + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var scheme_list = schemes_obj.scheme_list;
		var year_list = schemes_obj.year_list;
		var value_list = schemes_obj.value_list;
		var schemes_array = $.makeArray(scheme_list);
		year_array = $.makeArray(year_list);
		var value_master_array = $.makeArray(value_list);
		
		for(var k=0;k<schemes_array.length;k++)
		{
			var scheme = schemes_array[k];
			var value_obj = value_master_array[k];
			var value_array = $.makeArray(value_obj);
			var obj = {
				name: scheme,
			    data: value_array
			};
			
			data_array.push(obj);
		}
    },'text');
	
	var colors = ['#711200','#004301','#000000','#194d30','#8B0045','#804000','#000066','#00ff00','#0A9BF5','#999999','#3b0066'];
	
	$('#sip-gth-container').highcharts({
        chart: {
            type: 'column',
        	events: {
            	load: function(event) {
                    $("#sip-gth-spinner").addClass("hidden");
                    $("#sip-gth-container").show();
            	}
            	},
            	width : container_width,
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
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
        xAxis: {
            categories: year_array,
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Current Value (Rs.)'
            }
        },
        tooltip: {
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: data_array
    });
}

function openLogin(){
	
	var fundname1 = $("#txt_fund1").val();
	var fundname2 = "";
	var fundname3 = "";
	var fundname4 = "";
	var fundname5 = "";
	var amount = $("#txt_amount").val();
	var startdate = $("#txt_start_date").val();
	var enddate = $("#txt_end_date").val();
	var frequency = $("#sel_frequency").val();
	var type = $("#sel_option").val();
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
	if(type == "0")
	{
		$("#adv-alert-msg").html("Please select option");
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
	
	var ele = document.getElementById("submit_btn");
 	//var l = Ladda.create(ele);
 	//l.start();
 	
 	var scheme_array = new Array();
	for(var k=0;k<fund_array.length;k++)
	{
		var scheme_name = fund_array[k];
		var schemeName = encodeURIComponent(scheme_name);
		scheme_array.push(schemeName);
	}
	
	//l.stop();

	downloadPath = "/mutual-funds-research/downloadPpfvsElss?schemes="+scheme_array+"&amount="+amount+"&start_date="+startdate+"&end_date="+enddate+"&period="+frequency+"&type="+type;
	imageDownload = "yes";
	chartId = "#lumpsum-gth-container";
	filename = "ppf-vs-elss";

	$("#adv-login").modal("show");
}
</script>

<section class="main-container mf-research">

	<div class="container-fluid pr-0 pl-0">
	<div class="row ml-0 mr-0">
		<div class="col-md-3 bg-mfbar py-3">
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">PPF vs ELSS</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
        <div class="row">
		<div class="col-md-6 col-sm-6">
	          <div class="form-group">
	            <label class="font-600 block">Select Option</label>
	            <select id="sel_option" class="form-control input-sm" data-width="100%" onchange="showPeriod()">
					<option value="0">Select</option>
					<option value="lumpsum" <c:if test="${type eq 'lumpsum' }"><c:out value="selected" /></c:if>>Lumpsum</option>
	            	<option value="sip" <c:if test="${type eq 'sip' }"><c:out value="selected" /></c:if>>SIP</option>
				</select>
	          </div>
		</div>
        
        <div class="col-md-6 col-sm-6" id="div_fund_1">
        <div class="form-group fund">
        	<label class="font-600">Fund 1</label>
        	<input id="txt_fund1" type="text" class="txt_fund form-control no-radius input-sm">
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
		    <label class="font-600">Amount</label>
		    <input type="text" id="txt_amount" maxlength="8" class="form-control input-sm no-radius" value="${amount}" />
		  </div>
		</div>
		
			<div class="col-md-3 col-sm-3" id="period_div">
	          <div class="form-group">
	            <label class="font-600 block">Select Frequency</label>
	            <select id="sel_frequency" class="form-control input-sm" data-width="100%">
					<option value="0">Select</option>
	            	<option value="Monthly" <c:if test="${period eq 'Monthly' }"><c:out value="selected" /></c:if>>Monthly</option>
	            	<option value="Quarterly" <c:if test="${period eq 'Quarterly' }"><c:out value="selected" /></c:if>>Quarterly</option>
	            	<option value="halfyearly" <c:if test="${period eq 'halfyearly' }"><c:out value="selected" /></c:if>>Half-Yearly</option>
	            	<option value="yearly" <c:if test="${period eq 'yearly' }"><c:out value="selected" /></c:if>>Yearly</option>
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
        	
        	<div class="col-md-2 col-sm-2">
        	   <label class="text-white" style="visibility: hidden;">Submit For Result</label>
         	   <a href="javascript:void(0)" class="btn btn-primary" style="width: 80%;" onclick="getData()">Submit</a>	         	   
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
         		
		        <div id="final_result" class="margintop20">
		        
				<div class="col-md-12 col-sm-12 table-responsive mt-1">
				<table class="table" id="tbl_scheme_returns1">
				<thead class="theadBody"><tr>
				<th width="200">Scheme Name</th>
				<th style="width:10%;">Launch Date</th>
			    <th>AUM (Crore)</th>
			    <th>Expense Ratio (%)</th>
			    <th style="width:10%;">Start Date</th>
				<th>Amount Invested</th>
				<th style="width: 13%;">Scheme Current Value as on <br/> ${end_date}</th>
				<th>Scheme Returns (%)</th>
				<th>PPF Current Value</th>
				<th>PPF Returns (%)</th>
				</tr></thead><tbody>
				<c:forEach items="${list}" var="schemePerformance" varStatus="status">
				<tr>
				<td><a href='/mutual-funds-research/<c:out value="${schemePerformance.scheme}"></c:out>' class="mutual-funds-anchor"><c:out value="${schemePerformance.scheme}"></c:out></a>
				</td>
		    	<td><c:out value="${schemePerformance.inception_date}"></c:out></td>
		    	<td>
		    	<c:choose>
		    	<c:when test="${schemePerformance.net_assets eq 0}">
		    		-
		    	</c:when>
		    	<c:otherwise>
		    		<fmt:formatNumber type="number" maxFractionDigits="2" value="${schemePerformance.net_assets / 10}"/>
		    	</c:otherwise>
		    	</c:choose>
		    	</td>
		    	<td>
		    	<c:choose>
		    	<c:when test="${schemePerformance.expense_ratio eq 0}">
		    		-
		    	</c:when>
		    	<c:otherwise>
		    		<c:out value="${schemePerformance.expense_ratio}"/>
		    	</c:otherwise>
		    	</c:choose>
		    	</td>
		    	<td><c:out value="${schemePerformance.sip_start_date}"></c:out></td>
		    	<td><fmt:formatNumber value="${schemePerformance.current_cost}" maxFractionDigits="0" /></td>
		    	<td><fmt:formatNumber value="${schemePerformance.current_value}" maxFractionDigits="0" /></td>
		    	<td><c:out value="${schemePerformance.returns}"></c:out></td>
		    	<td><fmt:formatNumber value="${schemePerformance.ppf_current_value}" maxFractionDigits="0" /></td>
		    	<td><c:out value="${schemePerformance.ppf_returns}"></c:out></td>
		    	</tr>
		    	</c:forEach>
				</tbody></table>
				</div>
		       	</div>
		       	
		       	<div id="lumpsum-gth-div" class="col-md-12 marginTop15 padding0 adv-panel-border text-center panel panel-default mt-3">
		       		<div id="lumpsum-gth-container" style="height:350px;min-width: 250px;"></div>
		       	</div>
          </div>
       </div>
    </div>
</section>              