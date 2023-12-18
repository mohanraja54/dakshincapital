<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style type="text/css">
#assetchart {
    float: left;
    height: 553px !important;
    overflow: hidden;
    width: 100% !important;
    text-align:center !important;
    webkit-box-shadow: 0px 2px 12px 1px rgba(237,234,237,1);
    -moz-box-shadow: 0px 2px 12px 1px rgba(237,234,237,1);
    box-shadow: 0px 2px 12px 1px rgba(237,234,237,1);
}
#res_asset_allocation{
	margin-bottom:0px !important;
}
.asset_age {
    background: none repeat scroll 0 0 #FCFCFC;
    border: 1px solid #DBDAD7;
    font-size: 14px;
    height: 30px;
    margin: 0 0 10px;
    color: #f59c1a;
    font-weight: bold;
    text-align: center;
    border-radius: 5px;
}
</style>


<!-- breadcrumb start -->
<!-- ================ -->
<!-- <div class="breadcrumb-container">
	<div class="container">
		<ol class="breadcrumb">
			<li><i class="fa fa-home pr-10"></i>&nbsp;<a class="link-dark" href="/">Home&nbsp;</a></li>
			<li><a class="link-dark" href="/tools-and-calculators/become-a-crorepati"> / Tools And Calculators&nbsp;/</a></li>
			<li class="active"> &nbsp;Asset Allocation</li>
		</ol>
	</div>
</div> -->
<!-- breadcrumb end -->

<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container-fluid pt-4 pb-4 pr-0 pr-lg-5 pl-0 calc-tool">
		<div class="row">
           
           <div class="col-md-3 marginBottom35">          
              <jsp:include page="../sidebar/calc-sidebar.jsp"></jsp:include>             
           </div>
           
           <div class="col-md-9 marginBottom35">
           	<h2 class="amfi-title bold">Asset Allocation</h2>
				<div class="row margin-top14">
				   	<div class="col-md-7"> 
				   	
				   	<div id="emi" class="mt-2">
					<div class="inside_emi">
				    <div class="lamount">
						<div style="float:left;"><b>Your current Age (Years)</b></div>
						<div class="res_box"><span id="asset_age">46-60 yrs</span></div>
					</div>
					<div style="clear:both;"></div>
					<div id="slider_age" style="margin-bottom:0px;"></div>
					<div class="steps" id="loanamountsteps">	
						<span style="left: 0%;" class="tick">|<br />
						<span class="marker">21-30 yrs</span></span><span style="left: 33.34%;" class="tick">|<br />
						<span class="marker">31-45 yrs</span></span><span style="left: 66.68%;" class="tick">|<br />
						<span class="marker">46-60 yrs</span></span><span style="left: 100%;" class="tick">|<br />
						<span class="marker">> 60 yrs</span></span>
					</div>
					</div>
					<div class="inside_emi">
					<div class="sep lint"> 
						<div style="float:left;"><b>How much risk you can take?</b></div>
						<div class="res_box"><span id="asset_risk">Medium</span></div>
					</div>
					<div style="clear:both;"></div>
					<div id="slider_risk" style="margin-bottom:0px;"></div>
					<div class="steps">
						<span style="left: 0%;" class="tick">|<br />
						<span class="marker">Very Low</span></span><span style="left: 25%;" class="tick">|<br />
						<span class="marker">Low</span></span><span style="left: 50%;" class="tick">|<br />
						<span class="marker">Medium</span></span><span style="left: 75%;" class="tick">|<br />
						<span class="marker">High</span></span><span style="left: 100%;" class="tick">|<br />
						<span class="marker">Very High</span></span>
					</div>
					</div>
					<div class="inside_emi">
					<div class="sep lint"> 
						<div style="float:left;"><b>Your investment Horizon (Years)</b></div>
						<div class="res_box"><span id="asset_horizon">2-5 yrs</span></div>
					</div>
					<div style="clear:both;"></div>
					<div id="slider_horizon" style="margin-bottom:0px;"></div>
					<div class="steps" id="loantermsteps">
						<span style="left: 0%;" class="tick">|<br />
						<span class="marker">< 2 yrs</span></span><span style="left: 33.34%;" class="tick">|<br />
						<span class="marker">2-5 yrs</span></span><span style="left: 66.68%;" class="tick">|<br />
						<span class="marker">5-10 yrs</span></span><span style="left: 100%;" class="tick">|<br />
						<span class="marker">> 10 yrs</span></span>
					</div>
					</div>

					<div class="inside_emi" >
				    <div class="sep lint"> 
						<div style="float:left;"><b>Do you know that mid & small caps generate better return in logn term</b></div>
						<div class="res_box" style="width:180px;height: 30px;"><span id="asset_caps">No, I prefer big companies</span></div>
					</div>
					<div style="clear:both;"></div>
					<div id="slider_caps" style="margin-bottom:0px;"></div>
					<div class="steps">
						<span style="left: 0%;" class="tick">|<br />
						<span class="marker">Yes</span></span><span style="left: 50%;" class="tick">|<br />
						<span class="marker" style="margin-left:-13px;">No, I prefer big companies</span></span><span style="left: 100%;" class="tick">|<br />
						<span class="marker">Not sure</span></span>
					</div>
					</div>
					<div style="height:30px"></div>
					</div>
					
					<!-- <div class="col-md-12 text-center">
					<a href="javascript:void(0)" id="calc_btn_submit" class="btn btn-warning ladda-button mutual-funds-submit-anchor marginTop20" onclick="saveResult()" data-style="expand-right" data-size="l"><span class="ladda-label">Save Result</span></a>
					</div> -->
				    	
				   </div>
				   
				   	<div class="col-md-5">
				
					<div id="assetchart" class="mt-2 mb-2"></div>
					<div id="emipaymentsummary">
						<div id="res_asset_allocation" class="text-center p-2"></div>
					</div>
				   	</div>
				</div>
	       </div>

     </div>
	</div>
</section>
<!-- main-container end -->
<script type="text/javascript">

var debt = 0;
var equity = 0;
var age = 3;
var risk = 3;
var horizon = 2;
var believe = 2;
var accountMap = "";

var async = async || [];
$(document).ready(function(){
	
	age = '${age}';
	risk = '${risk}';
	horizon = '${horizon}';
	believe = '${believe}';
	accountMap = '${accountMap}';	
	
	age = parseInt(age);
	risk = parseInt(risk);
	horizon = parseInt(horizon);
	believe = parseFloat(believe);
	
	var res = "";
	if(age == 1)
	{
		res = "21-30 yrs";
	}else if(age == 2)
	{
		res = "31-45 yrs";
	}else if(age == 3)
	{
		res = "46-60 yrs";
	}else
	{
		res = "> 60 yrs";
	}
	$( "#asset_age" ).html(res);
	
	var res = "";
	if(risk == 1)
	{
		res = "Very Low";
	}else if(risk == 2)
	{
		res = "Low";
	}else if(risk == 3)
	{
		res = "Medium";
	}else if(risk == 4)
	{
		res = "High";
	}else
	{
		res = "Very High";
	}
	$( "#asset_risk" ).html(res);
	
	var res = "";
	if(horizon == 1)
	{
		res = "< 2 yrs";
	}else if(horizon == 2)
	{
		res = "2-5 yrs";
	}else if(horizon == 3)
	{
		res = "5-10 yrs";
	}
	else
	{
		res = "> 10 yrs";
	}
	$( "#asset_horizon" ).html(res);
	
	var res = "";
	if(believe == 1)
	{
		res = "Yes";
	}else if(believe == 2)
	{
		res = "No, I prefer big companies";
	}else
	{
		res = "Not sure";
	}
	$( "#asset_caps" ).html(res);

	$("#slider_age").slider({
	    min: 1,
	    max: 4,
        tooltip: "hide",
        step: 1,
        precision: 0,
        value: age
	}).on("slideStop", function(slideEvt) {	
		
		age = slideEvt.value;
		var res = "";
		if(age == 1)
		{
			res = "21-30 yrs";
		}else if(age == 2)
		{
			res = "31-45 yrs";
		}else if(age == 3)
		{
			res = "46-60 yrs";
		}else
		{
			res = "> 60 yrs";
		}
		$( "#asset_age" ).html(res);
		calculateAssetValue();
		
	});
	
	$("#slider_risk").slider({
	    min: 1,
	    max: 5,
        tooltip: "hide",
        step: 1,
        precision: 0,
        value: risk
	}).on("slideStop", function(slideEvt) {

		risk = slideEvt.value;
		var res = "";
		if(risk == 1)
		{
			res = "Very Low";
		}else if(risk == 2)
		{
			res = "Low";
		}else if(risk == 3)
		{
			res = "Medium";
		}else if(risk == 4)
		{
			res = "High";
		}else
		{
			res = "Very High";
		}
		$( "#asset_risk" ).html(res);
		calculateAssetValue();
		
	});
	
	$("#slider_horizon").slider({
		min: 1,
        max: 4,
        tooltip: "hide",
        step: 1,
        precision: 0,
        value: horizon
	}).on("slideStop", function(slideEvt) {

		horizon = slideEvt.value;
		var res = "";
		if(horizon == 1)
		{
			res = "< 2 yrs";
		}else if(horizon == 2)
		{
			res = "2-5 yrs";
		}else if(horizon == 3)
		{
			res = "5-10 yrs";
		}
		else
		{
			res = "> 10 yrs";
		}
		$( "#asset_horizon" ).html(res);
		calculateAssetValue();
		
	});
	
	$("#slider_caps").slider({
		min: 1,
        max: 3,
        tooltip: "hide",
        step: 1,
        precision: 0,
        value: believe
	}).on("slideStop", function(slideEvt) {

		believe = slideEvt.value;
		var res = "";
		if(believe == 1)
		{
			res = "Yes";
		}else if(believe == 2)
		{
			res = "No, I prefer big companies";
		}else
		{
			res = "Not sure";
		}
		$( "#asset_caps" ).html(res);
		calculateAssetValue();
		
	});
	
	calculateAssetValue();
});

function calculateAssetValue()
{	
	var debt = 0;
	var equity = 0;
	var fmp_debt_value = 0;
	var long_term_fixed_value = 0;
	var cash_liquid_value = 0;
	var mid_small_cap_value = 0;
	var large_cap_value = 0;
	
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getAssetAllocationResult", {current_age : "" + age + "",risk_profile : "" + risk + "",investment_horizon : "" + horizon + "",do_you_know : "" + believe + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		
		debt = obj.debt;
		equity = obj.equity;
		fmp_debt_value = obj.fmp_debt_value;
		long_term_fixed_value = obj.long_term_fixed_value;
		cash_liquid_value = obj.cash_liquid_value;
		mid_small_cap_value = obj.mid_small_cap_value;
		large_cap_value = obj.large_cap_value;
		
    },'text');

    renderChart(debt, equity, fmp_debt_value, long_term_fixed_value, cash_liquid_value, mid_small_cap_value, large_cap_value);
}

function saveResult() 
{	
	var age_res = "";
	if(age == 1)
	{
		age_res = "21-30 yrs";
	}else if(age == 2)
	{
		age_res = "31-45 yrs";
	}else if(age == 3)
	{
		age_res = "46-60 yrs";
	}else
	{
		age_res = "> 60 yrs";
	}
	
	var risk_res = "";
	if(risk == 1)
	{
		risk_res = "Very Low";
	}else if(risk == 2)
	{
		risk_res = "Low";
	}else if(risk == 3)
	{
		risk_res = "Medium";
	}else if(risk == 4)
	{
		risk_res = "High";
	}else
	{
		risk_res = "Very High";
	}
	
	var horizon_res = "";
	if(horizon == 1)
	{
		horizon_res = "< 2 yrs";
	}else if(horizon == 2)
	{
		horizon_res = "2-5 yrs";
	}else if(horizon == 3)
	{
		horizon_res = "5-10 yrs";
	}
	else
	{
		horizon_res = "> 10 yrs";
	}
	
	var title = "Asset Allocation Tool - "+age_res+" can take "+risk_res+" risk and "+horizon_res+" horizon";
	var url = "/tools-and-calculators/asset-allocation?age="+age+"&risk="+risk+"&horizon="+horizon+"&believe="+believe;
	
	if(accountMap == undefined || accountMap == null || accountMap == "" || accountMap == "null")
	{
		advisorkhoj_result_title = title;
		advisorkhoj_result_url = url;
		
		$("#adv-contact-advisor-signin-signup").modal("show");
		
	}else
	{
		saveUserResult("Calculator",title, url);
	}
}

function renderChart(debt, equity, fmp_debt_value, long_term_fixed_value, cash_liquid_value, mid_small_cap_value, large_cap_value)
{
	$('#res_asset_allocation').html("Based on your profile it is suggested to invest " + debt + " % in Debt and " + equity + " % in Equity");
	
	$('#assetchart').highcharts({
	    chart: {
	        type: 'pie',
	        marginTop:100,
	        marginBottom:0
	    },
	    title: {
	        text: '',
	        align:'left',
	        style: {
                color: '#000000',
                fontWeight: 'bold',
                fontSize:'16px'
            }
	    },
	    credits: {
	          enabled: false
	    },
	    yAxis: {
	        title: {
	            text: '{chart_pie_yAxis}'
	        }
	    },
	    plotOptions: {
	        pie: {
	            shadow: false,
	            center: ['50%', '50%']
	        }
	    },
	    legend: {
	        layout: 'vertical',
	        floating: true,
	        align: 'right',
	        verticalAlign: 'top',
	        symbolPadding: 5,
	        symbolWidth: 10,
	        x:10,
	        y:-10,
	        borderWidth: 1,
	       	borderRadius: 5,
	    },
	    tooltip: {
	        formatter: function () {
	            return '<b>' + this.point.name + '</b>: ' + this.y + ' %';
	        }
	    },
	    series: [{
	        name: 'Debt',
	        data: [{
	        	name: 'FMPs and Debt Funds',
	            y: fmp_debt_value,
	            parentId: 'first',
	            color: '#ee1c25',
	            legendIndex: 1
	        }, {
	        	name: 'Long Term Fixed Income',
	            y: long_term_fixed_value,
	            parentId: 'first',
	            color: '#005e96',
	            legendIndex: 2
	        }, {
	        	name: 'Cash/Bank FD/Liquid',
	            y: cash_liquid_value,
	            parentId: 'first',
	            color: '#ffa200',
	            legendIndex: 3
	        }, {
	        	name: 'Mid-Cap/Small-Cap',
	            y: mid_small_cap_value,
	            parentId: 'second',
	            color: '#e8ce1d',
	            legendIndex: 5
	        },{
	        	name: 'Large-Caps',
	            y: large_cap_value,
	            parentId: 'second',
	            color: '#ff8487',
	            legendIndex: 6
	        }],
	        showInLegend: false,
	        size: '60%',
	        dataLabels: {
	        	enabled: false
	        },
	        showInLegend: true
	    }, {
	        showInLegend: true,
	        name: 'Equity',
	        data: [{
	        	name: 'Debt',
	            id: 'first',
	            color: '#76b8f4',
	            y: debt,
	            legendIndex: 0
	        }, {
	        	name: 'Equity',
	            id: 'second',
	            color: '#e15656',
	            y: equity,
	            legendIndex: 4
	        }],
	        size: '80%',
	        innerSize: '60%',
	        dataLabels: {
	        	enabled: false
	        }
	    }]
	});
}
var download_text = "";
function downloadResult()
{
	download_text = "download";
	$("#send_email_model").modal('show');
}
function emailResult()
{
	download_text = "email";
	$("#send_email_model").modal('show');
}
function init_download(email)
{
	var asset_age = $('#asset_age').html();
	var asset_risk = $('#asset_risk').html();
	var asset_horizon = $('#asset_horizon').html();
	var asset_caps = $('#asset_caps').html();
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?asset_age="+asset_age+"&asset_risk="+asset_risk+"&asset_horizon="+asset_horizon+"&asset_caps="+asset_caps+"&debt="+debt+"&equity="+equity+"&url="+calc_url;
		
		var url = '<c:url value="/downloadAssetAllocationCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post("/sendAssetAllocationCalcResult", {email : ""+email+"",asset_age : ""+asset_age+"",asset_risk : ""+asset_risk+"",asset_horizon : ""+asset_horizon+"",
    		asset_caps : ""+asset_caps+"",debt : ""+debt+"",equity : ""+equity+"",url : ""+ calc_url +""}, function(data)
        {
    			var result1 = $.trim(data);
           		var obj = jQuery.parseJSON(result1);
           		if(obj.status == 400)
           		{
           			$("#adv-alert-msg").html(obj.msg);
                  	    $("#adv-alert").modal('show');
           			return false;
           		}
           		$('#send_email_model').modal('hide');
                   setTimeout(function(){
                   	 $("#adv-alert-msg").html("Thanks. We sent an email to your mail id");
                   	 $("#adv-alert").modal('show');
       	    	},1000);
                   
        }, "text");
	}
}
var async = async || [];
async.push(["ready",function (){	
    $(".send_email_form").find("input").jqBootstrapValidation(
    {
		preventSubmit: true,
		submitSuccess: function($form, event) {
		    event.preventDefault();
		    
		    var radio_value = $("input[type='radio'][name='inves_calc']:checked").val();
			if(radio_value == undefined)
			{
				$("#adv-alert-msg").html("Please choose Are you an Investor or Advisor?");
			    $("#adv-alert").modal('show');
		   	 	return false;
			}
		    var email = $("#send_email_id").val();
		    if(email == "")
		    {
		   		 $("#adv-alert-msg").html("Please enter email address!");
	        	 $("#adv-alert").modal('show');
		   		 return false;
		    }
		    if(!validateEmail(email))
		    {
		    	$("#adv-alert-msg").html("Please enter valid email address!");
	        	$("#adv-alert").modal('show');
		   	 	return false;
		    }
		    
		    var flag = false;
		    
		    $.ajaxSetup({async:false});
		    $.post("/verifyEmail", {email : "" + email + ""}, function(data)
	   	    {
	   			var result = $.trim(data);
	   	        if(result == "false")
	   	        {
	   	        	flag = true;
	   	        	$("#adv-alert-msg").html("Please enter valid email address!");
		        	$("#adv-alert").modal('show');
	   	       	 	return false;
	   	        }
	   	    }, "text");
		    
		    if(flag == true)
	    	{
		    	return false;
	    	}
		   	
		    var page = "Asset Allocation Calculator - "+download_text;
		    
		    $.ajaxSetup({async:false});
			$.post("/subscribeForEmail", {email : "" + email + "", user_type : "" + radio_value + "", page : "" + page + "" }, function(data)
		    {
		    }, "text");
		    
		    init_download(email);
		}
    });
}]);
</script>
