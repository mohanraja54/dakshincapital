<jsp:include page="../layout/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
.emitotalamount{
	border-bottom: 1px dotted #DBDAD7;
    padding: 10px;
    text-align: center;
}
</style>

<script type="text/javascript">

var principal_amount = "";
var interest_rate = "";
var period = "";
var compound_interval = "";
var accountMap = "";
var maturity_amount = 0;

$(document).ready(function(){

	principal_amount = '${principal_amount}';
	interest_rate = '${interest_rate}';
	period = '${period}';
	compound_interval = '${compound_interval}';
	
	principal = parseInt(principal_amount);
	rate = parseFloat(interest_rate);
	period = parseInt(period);
	interval = parseInt(compound_interval);
	var result = "";
	if(interval == 1)
	{
		result = "Yearly";
	}else if(interval == 2)
	{
		result = "Half Yearly";
	}else if(interval == 3)
	{
		result = "Quarterly";
	}else
	{
		result = "Monthly";
	}
	
	$('#principal_amount').val(principal);
	$('#interest').val(rate);
	$('#term').val(period);
	$( "#compound_interval" ).val(result);
	
	accountMap = '${accountMap}';	
	
	$("#pricipal_slider").slider({
	    min: 100000,
	    max: 10000000,
        tooltip: "hide",
        step: 1,
        precision: 0,
        value: principal
	}).on("slideStop", function(slideEvt) {		
		$("#principal_amount").val(slideEvt.value.toFixed(0));
		calculateEMI();
	});
	
	$("#interest_slider").slider({
	    min: 5,
	    max: 20,
        tooltip: "hide",
        step: 0.1,
        precision: 1,
        value: rate
	}).on("slideStop", function(slideEvt) {
		$("#interest").val(slideEvt.value.toFixed(2));
		calculateEMI();
	});
	
	$("#term_slider").slider({
		min: 1,
        max: 30,
        tooltip: "hide",
        step: 1,
        precision: 0,
        value: period
	}).on("slideStop", function(slideEvt) {
		$("#term").val(slideEvt.value.toFixed(0));
		calculateEMI();
	});
	
	$("#compound_slider").slider({
		min: 1,
        max: 4,
        tooltip: "hide",
        step: 1,
        precision: 1,
        value: interval
	}).on("slideStop", function(slideEvt) {
		
		var value = slideEvt.value;
		var result = "";
		if(value == 1)
		{
			result = "Yearly";
		}else if(value == 2)
		{
			result = "Half Yearly";
		}else if(value == 3)
		{
			result = "Quarterly";
		}else
		{
			result = "Monthly";
		}
		$( "#compound_interval" ).val(result);
		calculateEMI();
	});
	
	calculateEMI();
	
});

function principalChange()
{
	var principal_amount = $('#principal_amount').val();
	$("#pricipal_slider").slider("setValue",principal_amount);
	calculateEMI();
}
function interestChange()
{
	var interest = $('#interest').val();
	$("#interest_slider").slider("setValue",interest);
	calculateEMI();
}
function termChange()
{
	var term = $('#term').val();
	$("#term_slider").slider("setValue",term);
	calculateEMI();
}
function numbersWithComma(x) 
{
	x = x.toString();
	var afterPoint = '';
	if(x.indexOf('.') > 0)
	   afterPoint = x.substring(x.indexOf('.'),x.length);
	x = Math.floor(x);
	x = x.toString();
	var lastThree = x.substring(x.length-3);
	var otherNumbers = x.substring(0,x.length-3);
	if(otherNumbers != '')
	    lastThree = ',' + lastThree;
	var res = otherNumbers.replace(/\B(?=(\d{2})+(?!\d))/g, ",") + lastThree + afterPoint;
	return res;
}

function calculateEMI()
{
	var principal = $('#principal_amount').val();
	var rate = $('#interest').val();
	var period = $('#term').val();
	var interval = $('#compound_interval').val();
	
	interval = $.trim(interval);

	var interval_value = 0;
	if(interval == "Yearly")
	{
		interval_value = 1;
	}
	else if(interval == "Half Yearly")
	{
		interval_value = 2;
	}
	else if(interval == "Quarterly")
	{
		interval_value = 4;
	}
	else if(interval == "Monthly")
	{
		interval_value = 12;
	}

	var principal_amount = 0;
	var interest_rate = 0;
	var years = 0;
	var compound_interval = 0;
	
	
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getCompoundingResult", {principal_amount : "" + principal + "",interest_rate : "" + rate + "",compound_interval : "" + interval + "",period : "" + period + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		
		principal_amount = obj.principal_amount;
		interest_rate = obj.interest_rate;
		years = obj.period;
		compound_interval = obj.compound_interval;
		maturity_amount = obj.maturity_amount;
		
    },'text');
	
	$('#res_principal').html(numbersWithComma(principal_amount));
	$('#res_interest_rate').html(interest_rate);
	$('#res_term').html(years);
	$('#res_total_amount').html(numbersWithComma(maturity_amount));
	
	renderChart(principal_amount, maturity_amount);
}

function saveResult() 
{	
	
	var principal = $('#principal_amount').val();
	var rate = $('#interest').val();
	var period = $('#term').val();
	var interval = $('#compound_interval').val();
	interval = $.trim(interval);
	var interval_value = 0;
	if(interval == "Yearly")
	{
		interval_value = 1;
	}
	else if(interval == "Half Yearly")
	{
		interval_value = 2;
	}
	else if(interval == "Quarterly")
	{
		interval_value = 3;
	}
	else if(interval == "Monthly")
	{
		interval_value = 4;
	}

	var title = "Compounding Calculator - "+(principal/100000)+" Lakhs @"+rate+"% after "+period+" yrs become "+(maturity_amount/100000)+" Lakhs";
	var url = "/tools-and-calculators/compounding-calculator?principal_amount="+principal+"&interest_rate="+rate+"&period="+period+"&compound_interval="+interval_value;	

	
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

function renderChart(amount,total_interest)
{
	amount = parseFloat(amount);
	total_interest = parseFloat(total_interest);
	
	$('#emipiechart').highcharts({
		 colors: ['#76b8f4', '#a4d035', '#FF8900', '#DDDF00', '#24CBE5', '#64E572', 
       '#FF9655', '#FFF263', '#6AF9C4'],
      chart: {
          plotBackgroundColor: null,
          plotBorderWidth: null,
          plotShadow: false
      },
      title: {
          text: ''
      },
      legend: {
          borderWidth: 1,
          borderRadius: 5,
      },
      credits: {
          enabled: false
      },
      tooltip: {
  	    pointFormat: '{point.percentage:.1f}%'
      },
      plotOptions: {
          pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                  enabled: false,
                  color: '#000000',
                  connectorColor: '#000000',
                  format: '<b>{point.name}</b>: {point.percentage:.1f} %'
              },
              showInLegend: true
          }
      },
      series: [{
          type: 'pie',
          data: [
              ['Principal Amount', amount],
              {
                  name: 'Interest Amount',
                  y: total_interest,
                  sliced: true,
                  selected: true
              }
          ]
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
	var principal = $('#principal_amount').val();
	var rate = $('#interest').val();
	var period = $('#term').val();
	var interval = $('#compound_interval').val();

	var res_principal = $( "#res_principal" ).html();
	var res_interest_rate = $( "#res_interest_rate" ).html();
	var res_term = $( "#res_term" ).html();
	var res_total_amount = $( "#res_total_amount" ).html();
	
	principal = numbersWithComma(principal);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?principal="+principal+"&rate="+rate+"&period="+period+"&interval="+interval;
		param += "&res_principal="+res_principal+"&res_interest_rate="+res_interest_rate+"&res_term="+res_term+"&res_total_amount="+res_total_amount+"&url="+calc_url;
		
		var url = '<c:url value="/downloadCompoundingCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post("/sendCompoundingCalcResult", {email : ""+email+"",principal : ""+principal+"",rate : ""+rate+"",
    		period : ""+period+"",interval : ""+interval+"",res_principal : ""+res_principal+"",res_interest_rate : ""+res_interest_rate+"",
    		res_term : ""+res_term+"",res_total_amount : ""+res_total_amount+"",url : ""+ calc_url +""}, function(data)
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
</script>

<!-- breadcrumb start -->
<!-- ================ -->
<div class="breadcrumb-container">
	<div class="container">
		<ol class="breadcrumb">
			<li><i class="fa fa-home pr-10"></i>&nbsp;<a class="link-dark" href="/">Home&nbsp;</a></li>
			<li><a class="link-dark" href="/tools-and-calculators/become-a-crorepati"> / Tools And Calculators&nbsp;/</a></li>
			<li class="active"> &nbsp;Compounding Calculator</li>
		</ol>
	</div>
</div>
<!-- breadcrumb end -->

<!-- main-container start -->
<!-- ================ -->
<section class="main-container marginTop35">

	<div class="container">
		<div class="row">
           
           <div class="col-md-3 marginBottom35">          
              <jsp:include page="../sidebar/calc-sidebar.jsp"></jsp:include>             
           </div>
           
           <div class="col-md-9 marginBottom35">
           		<h2 class="amfi-title bold">COMPOUNDING CALCULATOR</h2>
								<div class="row margin-top14">
			   	<div class="col-md-7"> 
			   	
			   	<div id="emi">
				<div class="inside_emi" style="margin:0px;">
				<div class="lamount">
					<div style="float:left;"><b>Principal Amount (Rs)</b></div>
					<input type="text" value="2500000" id="principal_amount" maxlength="8" onchange="principalChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="pricipal_slider" style="margin:0px;"></div>
				<div class="steps" id="loanamountsteps">	
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">1 Lakh</span></span><span style="left: 24.24%;" class="tick">|<br />
					<span class="marker">25 Lakhs</span></span><span style="left: 49.49%;" class="tick">|<br />
					<span class="marker">50 Lakhs</span></span><span style="left: 74.74%;" class="tick">|<br />
					<span class="marker">75 Lakhs</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">1 Crore</span></span>
				</div>
				</div>
				<div class="small_line" style="margin:0px;"></div>
				<div class="inside_emi" style="margin:0px;">
				<div class="sep lint"> 
					<div style="float:left;"><b>Interest Rate (% per annum)</b></div>
					<input type="text" value="12.5" id="interest" maxlength="5" onchange="interestChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="interest_slider" style="margin:0px;"></div>
				<div class="steps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">5</span></span><span style="left: 16.66%;" class="tick">|<br />
					<span class="marker">7.5</span></span><span style="left: 33.33%;" class="tick">|<br />
					<span class="marker">10</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">12.5</span></span><span style="left: 66.66%;" class="tick">|<br />
					<span class="marker">15</span></span><span style="left: 83.33%;" class="tick">|<br />
					<span class="marker">17.5</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">20</span></span>
				</div>
				</div>
				<div class="small_line" style="margin:0px;"></div>
				<div class="inside_emi" style="margin:0px;">
				<div class="sep lint"> 
					<div style="float:left;"><b>Period (in years)</b></div>
					<input type="text" value="20" id="term" maxlength="2" onchange="termChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="term_slider" style="margin:0px;"></div>
				<div class="steps" id="loantermsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">1</span></span><span style="left: 13.79%;" class="tick">|<br />
					<span class="marker">5</span></span><span style="left: 31.03%;" class="tick">|<br />
					<span class="marker">10</span></span><span style="left: 48.27%;" class="tick">|<br />
					<span class="marker">15</span></span><span style="left: 65.51%;" class="tick">|<br />
					<span class="marker">20</span></span><span style="left: 82.75%;" class="tick">|<br />
					<span class="marker">25</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">30</span></span>
				</div>
				</div>
				<div class="small_line" style="margin:0px;"></div>
				<div class="inside_emi" style="margin:0px;">
				    <div class="sep lint"> 
						<div style="float:left;"><b>Compound interval</b></div>
						<input type="text" value="Yearly" id="compound_interval" disabled />
					</div>
					<div style="clear:both;"></div>
					<div id="compound_slider" style="margin-bottom:0px;"></div>
					<div class="steps">
						<span style="left: 0%;" class="tick">|<br />
						<span class="marker">Yearly</span></span>
						<span style="left: 33%;" class="tick">|<br />
						<span class="marker" style="margin-left:-13px;">Half Yearly</span></span>
						<span style="left: 66%;" class="tick">|<br />
						<span class="marker" style="margin-left:-13px;">Quarterly</span></span>
						<span style="left: 100%;" class="tick">|<br />
						<span class="marker">Monthly</span></span>
					</div>
					</div>
				</div>
			    	
			   </div>
			   
			   	<div class="col-md-5">
			   	<div id="emipiechart"></div>
				<div id="emipaymentsummary">
					<div class="emitotalinterest">
						<h4>Principal Amount</h4>
						<p>Rs. <span id="res_principal"></span></p>
					</div>
					<div class="emitotalinterest">
						<h4>Interest Rate (% per annum)</h4>
						<p><span id="res_interest_rate"></span> %</p>
					</div>
					<div class="emitotalinterest">
						<h4>Period</h4>
						<p><span id="res_term"></span> Years</p>
					</div>
					<div class="emitotalamount">
						<h4>Total Maturity Amount</h4>
						<p>Rs. <span id="res_total_amount"></span></p>
					</div>
				</div>
			   	</div>
			   
			    <!-- <div class="col-md-12 text-right">
				  <a href="javascript:void(0)" id="calc_btn_submit" class="btn btn-warning ladda-button mutual-funds-submit-anchor marginTop20" onclick="saveResult()" data-style="expand-right" data-size="l"><span class="ladda-label">Save Result</span></a>
				</div> -->
				
				</div>
	       </div>

     </div>
	</div>
</section>
<!-- main-container end -->
<jsp:include page="../layout/footer.jsp"></jsp:include>