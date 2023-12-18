<jsp:include page="../layout/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
.emitotalamount {
    padding: 10px;
    text-align: center;
}
</style>

<script type="text/javascript">

var current_cost = "";
var inflation_rate = "";
var no_years = "";
var accountMap = "";
var future_amount = 0;

$(document).ready(function(){

	current_cost = '${current_cost}';
	inflation_rate = '${inflation_rate}';
	no_years = '${no_years}';
	
	current_amount = parseInt(current_cost);
	inflation = parseFloat(inflation_rate,10);
	year = parseInt(no_years);
	
	$('#current_amount').val(current_amount);
	$('#inflation').val(inflation);
	$('#year').val(year);
	
	accountMap = '${accountMap}';	
	
	$("#current_amount_slider").slider({
	    min: 100000,
	    max: 10000000,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: current_amount
	}).on("slideStop", function(slideEvt) {		
		$("#current_amount").val(slideEvt.value);
		calculateFutureValue();
	});
	
	$("#inflation_slider").slider({
	    min: 0,
	    max: 20,
        tooltip: "show",
        step: 0.1,
        value: inflation,
        precision: 0.1,
	}).on("slideStop", function(slideEvt) {
		$("#inflation").val(slideEvt.value.toFixed(1));
		calculateFutureValue();
	});
	
	$("#year_slider").slider({
	    min: 0,
	    max: 30,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: year
	}).on("slideStop", function(slideEvt) {
		$("#year").val(slideEvt.value);
		calculateFutureValue();
	});
	
	calculateFutureValue();
	
});

function currentAmountChange()
{
	var current_amount = $('#current_amount').val();
	$("#current_amount_slider").slider("setValue",current_amount);
	calculateFutureValue();
}
function inflationChange()
{
	var inflation = $('#inflation').val();
	$("#inflation_slider").slider("setValue",inflation);
	calculateFutureValue();
}
function yearChange()
{
	var year = $('#year').val();
	$("#year_slider").slider("setValue",year);
	calculateFutureValue();
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
function calculateFutureValue()
{
	var current_amount = $('#current_amount').val();
	var inflation = $('#inflation').val();
	var year = $('#year').val();

	if(isNaN(year))
	{
		alert("Please enter valid value for years.");
		return;
	}
	
	current_amount = parseInt(current_amount);
	inflation = parseFloat(inflation,10);
	year = parseInt(year);


	
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getFutureValueCalcResult", {current_cost : "" + current_amount + "",inflation_rate : "" + inflation + "",no_years : "" + year + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		
		future_amount = obj.future_amount;
		
    },'text');
	
	$('#res_current_amount').html(numbersWithComma(current_amount));
	$('#res_inflation').html(inflation);
	$('#res_year').html(year);
	$('#res_future_amount').html(numbersWithComma(future_amount));
	renderChart(current_amount,future_amount);
}
function saveResult() 
{	
	var current_amount = $('#current_amount').val();
	var inflation = $('#inflation').val();
	var year = $('#year').val();

	current_amount = parseInt(current_amount);
	inflation = parseFloat(inflation,10);
	year = parseInt(year);

	var title = "Future Value Inflation Calculator - "+(current_amount/100000)+" Lakhs become "+(future_amount/100000)+" Lakhs @"+inflation+"% inflation after "+year+" yrs";
	var url = "/tools-and-calculators/future-value-inflation-calculator?current_cost="+current_amount+"&inflation_rate="+inflation+"&no_years="+year;	
	
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

function renderChart(current_amount,future_amount)
{
	current_amount = parseFloat(current_amount);
	future_amount = parseFloat(future_amount);
	
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
              ['Current Cost', current_amount],
              {
                  name: 'Future Cost',
                  y: future_amount,
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
	var current_amount = $('#current_amount').val();
	var inflation = $('#inflation').val();
	var year = $('#year').val();

	var res_current_amount = $( "#res_current_amount" ).html();
	var res_inflation = $( "#res_inflation" ).html();
	var res_year = $( "#res_year" ).html();
	var res_future_amount = $( "#res_future_amount" ).html();
	
	current_amount = numbersWithComma(current_amount);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?current_amount="+current_amount+"&inflation="+inflation+"&year="+year;
		param += "&res_current_amount="+res_current_amount+"&res_inflation="+res_inflation+"&res_year="+res_year+"&res_future_amount="+res_future_amount+"&url="+calc_url;
		
		var url = '<c:url value="/downloadFutureValueCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post("/sendFutureValueCalcResult", {email : ""+email+"",current_amount : ""+current_amount+"",inflation : ""+inflation+"",
    		year : ""+year+"",res_current_amount : ""+res_current_amount+"",res_inflation : ""+res_inflation+"",res_year : ""+res_year+"",
    		res_future_amount : ""+res_future_amount,url : ""+ calc_url +""}, function(data)
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
			<li class="active"> &nbsp;Future Value Calculator</li>
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
           <h2 class="amfi-title bold">FUTURE VALUE CALCULATOR</h2>
			<div class="row margin-top14">
			   	<div class="col-md-7"> 
			   	
			   	<div id="emi">
				<div class="inside_emi" style="margin:0px;">
				<div class="lamount">
					<div style="float:left;"><b>Current Cost (Rs)</b></div>
					<input type="text" value="2500000" id="current_amount" maxlength="8" onchange="currentAmountChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="current_amount_slider" style="margin:0px;"></div>
				<div class="steps" id="loanamountsteps">	
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">1 Lakh</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">25 Lakhs</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">50 Lakhs</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">75 Lakhs</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">1 Crore</span></span>
				</div>
				</div>
				<div class="small_line" style="margin:0px;"></div>
				<div class="inside_emi" style="margin:0px;">
				<div class="sep lint"> 
					<div style="float:left;"><b>Inflation (% per annum)</b></div>
					<input type="text" value="6" id="inflation" maxlength="4" onchange="inflationChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="inflation_slider" style="margin:0px;"></div>
				<div class="steps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">0</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">5</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">10</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">15</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">20</span></span>
				</div>
				</div>
				<div class="small_line" style="margin:0px;"></div>
				<div class="inside_emi" style="margin:0px;">
				<div class="sep lint"> 
					<div style="float:left;"><b>Number of Years</b></div>
					<input type="text" value="10" id="year" maxlength="2" onchange="yearChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="year_slider" style="margin:0px;"></div>
				<div class="steps" id="loantermsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">0</span></span><span style="left: 13.79%;" class="tick">|<br />
					<span class="marker">5</span></span><span style="left: 31.03%;" class="tick">|<br />
					<span class="marker">10</span></span><span style="left: 48.27%;" class="tick">|<br />
					<span class="marker">15</span></span><span style="left: 65.51%;" class="tick">|<br />
					<span class="marker">20</span></span><span style="left: 82.75%;" class="tick">|<br />
					<span class="marker">25</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">30</span></span>
				</div>
				</div>
				</div>
			    	
			   </div>
			   
			   	<div class="col-md-5">
				<div id="emipiechart"></div>
				<div id="emipaymentsummary">
					<div class="emitotalinterest">
						<h4>Current Cost</h4>
						<p>Rs. <span id="res_current_amount"></span></p>
					</div>
					<div class="emitotalinterest">
						<h4>Inflation (% per annum)</h4>
						<p><span id="res_inflation"></span> %</p>
					</div>
					<div class="emitotalinterest">
						<h4>Number of Years</h4>
						<p><span id="res_year"></span> Years</p>
					</div>
					<div class="emitotalamount">
						<h4>Future Cost</h4>
						<p>Rs. <span id="res_future_amount"></span></p>
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