<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- breadcrumb start -->
<!-- ================ -->
<!-- <div class="breadcrumb-container">
	<div class="container">
		<ol class="breadcrumb">
			<li><i class="fa fa-home pr-10"></i>&nbsp;<a class="link-dark" href="/">Home&nbsp;</a></li>
			<li><a class="link-dark" href="/tools-and-calculators/become-a-crorepati"> / Tools And Calculators&nbsp;/</a></li>
			<li class="active"> &nbsp;Goal Setting Calculator</li>
		</ol>
	</div>
</div> -->
<!-- breadcrumb end -->

<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container-fluid pt-4 pb-4 pr-0 pr-lg-5 pl-0 calc-tool">
		<div class="row">
           
           <div class="col-md-3">          
              <jsp:include page="../sidebar/calc-sidebar.jsp"></jsp:include>             
           </div>
           
           <div class="col-md-9 marginBottom35">
           		<h2 class="amfi-title bold">Goal Setting Calculator</h2>
           		<div class="row margin-top14">
			   	<div class="col-md-7"> 
			   	
			   	<div id="emi" class="mt-2">
				<div class="inside_emi">
				<div class="lamount">
					<div class="txt"><b>What is the amount that you would like to spend on buying an item you dream - a big car or a foreign holiday or a house (Rs)</b></div>
					<input type="text" value="10000000" id="amount" maxlength="8" onchange="amountChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="amount_slider"></div>
				<div class="steps" id="loanamountsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">1 Lakh</span></span><span style="left: 24.24%;" class="tick">|<br />
					<span class="marker">25 Lakhs</span></span><span style="left: 49.49%;" class="tick">|<br />
					<span class="marker">50 Lakhs</span></span><span style="left: 74.74%;" class="tick">|<br />
					<span class="marker">75 Lakhs</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">1 Crore</span></span>
				</div>
				</div>
				<div class="inside_emi">
				<div class="sep lint">
					<div class="txt"><b>Afer how many years away would you need this amount?</b></div> 
					<input type="text" value="30" id="years" maxlength="3" onchange="yearsChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="years_slider"></div>
				<div class="steps" id="loantermsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">1</span></span><span style="left: 24.24%;" class="tick">|<br />
					<span class="marker">25</span></span><span style="left: 49.49%;" class="tick">|<br />
					<span class="marker">50</span></span><span style="left: 74.74%;" class="tick">|<br />
					<span class="marker">75</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">100</span></span>
				</div>
				</div>
				<div class="inside_emi">
				<div class="sep lint"> 
					<div class="txt"><b>The expected rate of inflation over the years (% per annum)</b></div> 
					<input type="text" value="8" id="inc_rate" maxlength="4" onchange="increaseRateChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="increase_rate_slider"></div>
				<div class="steps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">5</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">7.5</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">10</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">12.5</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">15</span></span>
				</div>
				</div>

				<div class="inside_emi">
				<div class="sep lint">
					<div class="txt"><b>What rate of return would you expect from your investment (% per annum)</b></div>  
					<input type="text" value="12" id="interest" maxlength="4" onchange="interestChange()" />
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
				
				<div class="inside_emi">
				<div class="sep lint">
					<div class="txt"><b>How much savings you have now? (Rs)</b></div>  
					<input type="text" value="0" id="savings_amount" maxlength="8" onchange="savingsAmountChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="savings_amount_slider" style="margin:0px;"></div>
				<div class="steps" id="loanamountsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">0</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">25 Lakhs</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">50 Lakhs</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">75 Lakhs</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">1 Crore</span></span>
				</div>
				</div>
				</div>
			    	
			   </div>
			   
			   	<div class="col-md-5">
			   	
			   	<div id="emipiechart" class="mt-2"></div>
				<div id="emipaymentsummary">
					<div id="emitotalinterest">
						<h4>Your targeted Dream Amount</h4>
						<h4>(Inflation adjusted)</h4>
						<p>Rs. <span id="res_dream_amount"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Growth of your Savings Amount</h4>
						<h4>(<span id="res_rate_return"></span>% per annum)</h4>
						<p>Rs. <span id="res_savings_amount"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Final Targeted Amount</h4>
						<h4>(Minus growth of your savings amount)</h4>
						<p>Rs. <span id="res_target_amount"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Number of years to achieve your goal </h4>
						<p><span id="res_years"></span> Years</p>
					</div>
					<div id="emitotalinterest">
						<h4>Monthly Savings required</h4>
						<p>Rs. <span id="res_monthly_amount"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Total Amount Invested in <span id="res_years_1"></span> years</h4>
						<p>Rs. <span id="res_invest_amount"></span></p>
					</div>
					<div id="emitotalamount">
						<h4>Total Growth Amount</h4>
						<p>Rs. <span id="res_earning_amount"></span></p>
					</div>
				</div>			
			   	</div>
				
				</div>
	       </div>

     </div>
	</div>
</section>
<!-- main-container end -->
<script type="text/javascript">

var years = "";
var dream_amount = "";
var inflation_rate = "";
var expected_return = "";
var savings_amount = "";
var accountMap = "";


$(document).ready(function(){

	years = '${years}';
	dream_amount = '${dream_amount}';
	inflation_rate = '${inflation_rate}';
	expected_return = '${expected_return}';
	savings_amount = '${savings_amount}';
	
	year = parseInt(years);
	dream_amount = parseInt(dream_amount);
	inflation = parseFloat(inflation_rate, 10);
	rate_of_return = parseFloat(expected_return, 10);
	savings_amount = parseInt(savings_amount);
	
	$('#years').val(year);
	$('#amount').val(dream_amount);
	$('#inc_rate').val(inflation);
	$('#interest').val(rate_of_return);
	$('#savings_amount').val(savings_amount);
	
	accountMap = '${accountMap}';	
	
	$("#amount_slider").slider({
	    min: 100000,
	    max: 10000000,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: dream_amount
	}).on("slideStop", function(slideEvt) {		
		$("#amount").val(slideEvt.value);
		monthlySavingsAmount();
	});
	
	$("#years_slider").slider({
	    min: 1,
	    max: 100,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: year
	}).on("slideStop", function(slideEvt) {
		$("#years").val(slideEvt.value);
		monthlySavingsAmount();
	});
	
	$("#increase_rate_slider").slider({
	    min: 5,
	    max: 15,
        tooltip: "show",
        step: 0.1,
        precision: 0,
        value: inflation
	}).on("slideStop", function(slideEvt) {
		$("#inc_rate").val(slideEvt.value);
		monthlySavingsAmount();
	});
	
	$("#interest_slider").slider({
		min: 5,
        max: 20,
        tooltip: "show",
        step: 0.1,
        precision: 1,
        value: rate_of_return
	}).on("slideStop", function(slideEvt) {
		$("#interest").val(slideEvt.value);
		monthlySavingsAmount();
	});
	
	$("#savings_amount_slider").slider({
	    min: 0,
	    max: 10000000,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: savings_amount
	}).on("slideStop", function(slideEvt) {
		$("#savings_amount").val(slideEvt.value);
		monthlySavingsAmount();
	});
	
	monthlySavingsAmount();
	
});

function amountChange()
{
	var amount = $('#amount').val();
	$( "#amount_slider" ).slider("setValue",amount);
	monthlySavingsAmount();
}
function yearsChange()
{
	var years = $('#years').val();
	$( "#years_slider" ).slider("setValue",years);
	monthlySavingsAmount();
}
function increaseRateChange()
{
	var increaseRate = $('#inc_rate').val();
	$( "#increase_rate_slider" ).slider("setValue",increaseRate);
	monthlySavingsAmount();
}
function interestChange()
{
	var interest = $('#interest').val();
	$( "#interest_slider" ).slider("setValue",interest);
	monthlySavingsAmount();
}
function savingsAmountChange()
{
	var savingsAmount = $('#savings_amount').val();
	$( "#savings_amount_slider" ).slider("setValue",savingsAmount);
	monthlySavingsAmount();
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

function monthlySavingsAmount()
{
	var year = $('#years').val();
	var dream_amount = $('#amount').val();
	var inflation = $('#inc_rate').val();
	var rate_of_return = $('#interest').val();
	var savings_amount = $('#savings_amount').val();

	
	year = parseInt(year);
	dream_amount = parseInt(dream_amount);
	inflation = parseFloat(inflation, 10);
	rate_of_return = parseFloat(rate_of_return, 10);
	savings_amount = parseInt(savings_amount);
	
	if(savings_amount >= dream_amount)
	{
		alert("Please enter the savings amount less then the dream amount");
		return;
	}

	var target_dream_amount = 0;
	var target_savings_amount = 0;
	var target_amount = 0;
	var monthly_savings = 0;
	var invested_amount = 0;
	var total_earnings = 0;

	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getGoalSettingCalcResult", {years : "" + year + "",dream_amount : "" + dream_amount + "",inflation_rate : "" + inflation + "",expected_return : "" + rate_of_return + "",savings_amount : "" + savings_amount + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		
		target_dream_amount = obj.target_dream_amount;
		target_savings_amount = obj.target_savings_amount;
		target_amount = obj.target_amount;
		monthly_savings = obj.monthly_savings;
		invested_amount = obj.invested_amount;
		total_earnings = obj.total_earnings;
		
    },'text');

	$('#res_dream_amount').html(numbersWithComma(target_dream_amount));
	$('#res_savings_amount').html(numbersWithComma(target_savings_amount));
	$('#res_target_amount').html(numbersWithComma(target_amount));
	$('#res_years').html(year);
	$('#res_years_1').html(year);
	$('#res_rate_return').html(rate_of_return);
	$('#res_monthly_amount').html(numbersWithComma(monthly_savings));
	$('#res_invest_amount').html(numbersWithComma(invested_amount));
	$('#res_earning_amount').html(numbersWithComma(total_earnings));
	renderChart(invested_amount, total_earnings);
}

function saveResult() 
{	
	var year = $('#years').val();
	var dream_amount = $('#amount').val();
	var inflation = $('#inc_rate').val();
	var rate_of_return = $('#interest').val();
	var savings_amount = $('#savings_amount').val();

	year = parseInt(year);
	dream_amount = parseInt(dream_amount);
	inflation = parseFloat(inflation, 10);
	rate_of_return = parseFloat(rate_of_return, 10);
	savings_amount = parseInt(savings_amount);
	
	var title = "Goal Setting Calculator - Goal of "+(dream_amount/100000)+" Lakhs after "+year+" yrs inflation "+inflation+"% and return "+rate_of_return+"%";
	var url = "/tools-and-calculators/goal-setting-calculator?dream_amount="+dream_amount+"&years="+year+"&inflation_rate="+inflation+"&expected_return="+rate_of_return+"&savings_amount="+savings_amount;	
	
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
		 colors: ['#005e96', '#ee1c25', '#FF8900', '#DDDF00', '#24CBE5', '#64E572', 
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
              ['Amount Invested', amount],
              {
                  name: 'Total Growth',
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
	var dream_amount = $('#amount').val();
	var dream_year = $('#years').val();
	var inflation = $('#inc_rate').val();
	var rate_of_return = $('#interest').val();
	var savings_amount = $('#savings_amount').val();
	
	var target_dream_amount = $('#res_dream_amount').html();
	var target_savings_amount = $('#res_savings_amount').html();
	var target_amount = $('#res_target_amount').html();
	var year = $('#res_years').html();
	var monthly_savings = $('#res_monthly_amount').html();
	var invest_amount = $('#res_invest_amount').html();
	var interest_total = $('#res_earning_amount').html();
	
	dream_amount = numbersWithComma(dream_amount);
	savings_amount = numbersWithComma(savings_amount);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?dream_amount="+dream_amount+"&dream_year="+dream_year+"&inflation="+inflation+"&rate_of_return="+rate_of_return+"&savings_amount="+savings_amount;
		param += "&target_dream_amount="+target_dream_amount+"&target_savings_amount="+target_savings_amount+"&target_amount="+target_amount+"&year="+year+"&monthly_savings="+monthly_savings+"&invest_amount="+invest_amount+"&interest_total="+interest_total+"&url="+calc_url;
		
		var url = '<c:url value="/downloadExpensePlannerCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post(curl + "sendExpenseGoalPlannerCalcResult", {email : ""+email+"",dream_amount : ""+dream_amount+"",dream_year : ""+dream_year+"",inflation : ""+inflation+"",
    		rate_of_return : ""+rate_of_return+"",savings_amount : ""+savings_amount+"",target_dream_amount : ""+target_dream_amount+"",
    		target_savings_amount : ""+target_savings_amount+"",target_amount : ""+target_amount+"",year : ""+year+"",
    		monthly_savings : ""+monthly_savings+"",invest_amount : ""+invest_amount+"",interest_total : ""+interest_total+"",url : ""+ calc_url +""}, function(data)
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
