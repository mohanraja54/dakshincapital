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
			<li class="active"> &nbsp;Retirement Planning</li>
		</ol>
	</div>
</div> -->
<!-- breadcrumb end -->

<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container-fluid pt-4 pb-4 pr-0 pr-lg-5 pl-0">
		<div class="row">
           
           <div class="col-md-3">          
              <jsp:include page="../sidebar/calc-sidebar.jsp"></jsp:include>             
           </div>
           
           <div class="col-md-9 marginBottom35">
			<h2 class="amfi-title bold">Retirement Planning Calculator</h2>
			<div class="row margin-top14">
			   	<div class="col-md-7"> 
			   	
			   	<div id="emi" class="mt-2">
				<div class="inside_emi">
				<div class="lamount">
					<div style="float:left;"><b>Amount you want to have for your retirement (Rs)</b></div>
					<input type="text" value="20000000" id="amount" maxlength="9" onchange="amountChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="amount_slider" style="margin:0px;"></div>
				<div class="steps" id="loanamountsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">50 Lakh</span></span><span style="left: 16.1%;" class="tick">|<br />
					<span class="marker">2 Crore</span></span><span style="left: 36.49%;" class="tick">|<br />
					<span class="marker">4 Crore</span></span><span style="left: 57.64%;" class="tick">|<br />
					<span class="marker">6 Crore</span></span><span style="left: 79.64%;" class="tick">|<br />
					<span class="marker">8 Crore</span></span><span style="left: 100%;" class="tick">|<br />		
					<span class="marker">10 Crore</span></span>
				</div>
				</div>
				<div class="inside_emi">
				<div class="sep lint"> 
					<label for="loanterm"></label>
					<div style="float:left;"><b>Your age today (in years)</b></div>
					<input type="text" value="25" id="current_age" maxlength="3" onchange="currentAgeChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="current_age_slider" style="margin:0px;"></div>
				<div class="steps" id="loantermsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">10</span></span><span style="left: 16.66%;" class="tick">|<br />
					<span class="marker">25</span></span><span style="left: 44.44%;" class="tick">|<br />
					<span class="marker">50</span></span><span style="left: 72.22%;" class="tick">|<br />
					<span class="marker">75</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">100</span></span>
				</div>
				</div>
				<div class="inside_emi">
				<div class="sep lint"> 
					<div style="float:left;"><b>Age you plan to retire (in years)</b></div>
					<input type="text" value="75" id="retire_age" maxlength="3" onchange="retireAgeChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="retire_age_slider" style="margin:0px;"></div>
				<div class="steps" id="loantermsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">10</span></span><span style="left: 16.66%;" class="tick">|<br />
					<span class="marker">25</span></span><span style="left: 44.44%;" class="tick">|<br />
					<span class="marker">50</span></span><span style="left: 72.22%;" class="tick">|<br />
					<span class="marker">75</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">100</span></span>
				</div>
				</div>
				<div class="inside_emi">
				<div class="sep lint"> 
					<div style="float:left;"><b>The expected rate of inflation over the years (% per annum)</b></div>
					<input type="text" value="7.5" id="inc_rate" maxlength="4" onchange="increaseRateChange()" />
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
					<div style="float:left;"><b>The expected rate of return on your investments (% per annum)</b></div>
					<input type="text" value="12.5" id="interest" maxlength="4" onchange="interestChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="interest_slider"></div>
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
				<div class="lamount">
					<div style="float:left;"><b>Your Current savings (Rs)</b></div>
					<input type="text" value="5000000" id="savings_amount" maxlength="9" onchange="savingsAmountChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="savings_amount_slider" style="margin:0px;"></div>
				<div class="steps" id="loanamountsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">50 Lakh</span></span><span style="left: 16.1%;" class="tick">|<br />
					<span class="marker">2 Crore</span></span><span style="left: 36.49%;" class="tick">|<br />
					<span class="marker">4 Crore</span></span><span style="left: 57.64%;" class="tick">|<br />
					<span class="marker">6 Crore</span></span><span style="left: 79.64%;" class="tick">|<br />
					<span class="marker">8 Crore</span></span><span style="left: 100%;" class="tick">|<br />		
					<span class="marker">10 Crore</span></span>
				</div>
				</div>
				</div>
				
			   </div>
			   
			   	<div class="col-md-5">
			   	<div id="emipiechart" class="mt-2"></div>
				<div id="emipaymentsummary">
					<div id="emitotalinterest">
						<h4>Retirement Amount</h4>
						<h4>(Inflation adjusted)</h4>
						<p>Rs. <span id="res_retire_amount"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Growth of your Savings Amount</h4>
						<h4>(<span id="res_rate_return"></span>% per annum)</h4>
						<p>Rs. <span id="res_current_savings"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Final Targeted Amount</h4>
						<h4>(Minus growth of your savings amount)</h4>
						<p>Rs. <span id="res_target_amount"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Number of years you need to save</h4>
						<p><span id="res_years"></span> Years</p>
					</div>
					<div id="emitotalinterest">
						<h4>Monthly Savings required</h4>
						<p>Rs. <span id="res_monthly_savings"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Total Amount Invested in <span id="res_years_1"></span> years</h4>
						<p>Rs. <span id="res_amount_invest"></span></p>
					</div>
					<div id="emitotalamount">
						<h4>Total Growth Amount</h4>
						<p>Rs. <span id="res_total_earnings"></span></p>
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
<script type="text/javascript">

var current_age = "";
var retirement_age = "";
var wealth_amount = "";
var inflation_rate = "";
var expected_return = "";
var savings_amount = "";
var accountMap = "";
    
$(document).ready(function(){
	
	current_age = '${current_age}';
	retirement_age = '${retirement_age}';
	wealth_amount = '${wealth_amount}';
	inflation_rate = '${inflation_rate}';
	expected_return = '${expected_return}';
	savings_amount = '${savings_amount}';
	
	currentAge = parseInt(current_age);
	retireAge = parseInt(retirement_age);
	retireAmount = parseInt(wealth_amount);
	savingsAmount = parseInt(savings_amount);
	rate = parseFloat(expected_return);
	inflation = parseFloat(inflation_rate);
	
	$('#current_age').val(currentAge);
	$('#retire_age').val(retireAge);
	$('#amount').val(retireAmount);
	$('#savings_amount').val(savingsAmount);
	$('#interest').val(rate);
	$('#inc_rate').val(inflation);

	accountMap = '${accountMap}';	
	
	$("#amount_slider").slider({
	    min: 5000000,
	    max: 100000000,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: retireAmount
	}).on("slideStop", function(slideEvt) {		
		$("#amount").val(slideEvt.value);
		calculateWealthy();
	});
	
	$("#current_age_slider").slider({
	    min: 10,
	    max: 100,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: currentAge
	}).on("slideStop", function(slideEvt) {
		$("#current_age").val(slideEvt.value);
		calculateWealthy();
	});
	
	$("#retire_age_slider").slider({
		min: 10,
        max: 100,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: retireAge
	}).on("slideStop", function(slideEvt) {
		$("#retire_age").val(slideEvt.value);
		calculateWealthy();
	});
	
	$("#increase_rate_slider").slider({
		min: 5,
        max: 15,
        tooltip: "show",
        step: 0.1,
        precision: 1,
        value: inflation
	}).on("slideStop", function(slideEvt) {
		$("#inc_rate").val(slideEvt.value);
		calculateWealthy();
	});
	
	$("#interest_slider").slider({
		min: 5,
        max: 20,
        tooltip: "show",
        step: 0.1,
        precision: 1,
        value: rate
	}).on("slideStop", function(slideEvt) {
		$("#interest").val(slideEvt.value);
		calculateWealthy();
	});
	
	$("#savings_amount_slider").slider({
		min: 5000000,
	    max: 100000000,
        tooltip: "hide",
        step: 1,
        precision: 0,
        value: savingsAmount
	}).on("slideStop", function(slideEvt) {
		$("#savings_amount").val(slideEvt.value);
		calculateWealthy();
	});
	
	calculateWealthy();
	
});

function amountChange()
{
	var amount = $('#amount').val();
	$( "#amount_slider" ).slider("setValue",amount);
	calculateWealthy();
}
function currentAgeChange()
{
	var currentAge = $('#current_age').val();
	$( "#current_age_slider" ).slider("setValue",currentAge);
	calculateWealthy();
}
function retireAgeChange()
{
	var retireAge = $('#retire_age').val();
	$( "#retire_age_slider" ).slider("setValue",retireAge);
	calculateWealthy();
}
function increaseRateChange()
{
	var increaseRate = $('#inc_rate').val();
	$( "#increase_rate_slider" ).slider("setValue",increaseRate);
	calculateWealthy();
}
function interestChange()
{
	var interest = $('#interest').val();
	$( "#interest_slider" ).slider("setValue",interest);
	calculateWealthy();
}
function savingsAmountChange()
{
	var savingsAmount = $('#savings_amount').val();
	$( "#savings_amount_slider" ).slider("setValue",savingsAmount);
	calculateWealthy();
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

 function calculateWealthy()
{	
	
	var currentAge = parseInt($('#current_age').val());
	var retireAge = parseInt($('#retire_age').val());
	var retireAmount = parseInt($('#amount').val());
	var savingsAmount = parseInt($('#savings_amount').val());
	var rate = parseFloat($('#interest').val());
	var inflation = parseFloat($('#inc_rate').val());
	
	currentAge = parseInt(currentAge);
	retireAge = parseInt(retireAge);
	retireAmount = parseInt(retireAmount);
	savingsAmount = parseInt(savingsAmount);
	rate = parseFloat(rate,10);
	inflation = parseFloat(inflation,10);
	
	if(retireAge <= currentAge)
	{
		alert("Please enter the retirement age not less then the current age");
		return;
	}
	if(savingsAmount >= retireAmount)
	{
		alert("Please enter the savings amount less then the retirement amount");
		return;
	}
	
	var target_wealth = 0;
	var target_savings = 0;
	var target_amount = 0;
	var years = 0;
	var monthly_savings = 0;
	var invested_amount = 0;
	var total_earnings = 0;
	
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getCrorepatiResult", {current_age : "" + currentAge + "",retirement_age : "" + retireAge + "",wealth_amount : "" + retireAmount + "",inflation_rate : "" + inflation + "",expected_return : "" + rate + "",savings_amount : "" + savingsAmount + ""}, function(data)
    {
		
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		
		target_wealth = obj.target_wealth;
		target_savings = obj.target_savings;
		target_amount = obj.target_amount;
		years = obj.years;
		monthly_savings = obj.monthly_savings;
		invested_amount = obj.invested_amount;
		total_earnings = obj.total_earnings;
		
    },'text');	
	
	$('#res_retire_amount').html(numbersWithComma(target_wealth));
	$('#res_current_savings').html(numbersWithComma(target_savings));
	$('#res_target_amount').html(numbersWithComma(target_amount));
	$('#res_years').html(years);
	$('#res_years_1').html(years);
	$('#res_rate_return').html(rate);
	$('#res_monthly_savings').html(monthly_savings);
	$('#res_amount_invest').html(numbersWithComma(invested_amount));
	$('#res_total_earnings').html(numbersWithComma(total_earnings));
	renderChart(invested_amount, total_earnings);
}
 
 function saveResult() 
 {	
 	
	var currentAge = parseInt($('#current_age').val());
	var retireAge = parseInt($('#retire_age').val());
	var retireAmount = parseInt($('#amount').val());
	var savingsAmount = parseInt($('#savings_amount').val());
	var rate = parseFloat($('#interest').val());
	var inflation = parseFloat($('#inc_rate').val());
	
	currentAge = parseInt(currentAge);
	retireAge = parseInt(retireAge);
	retireAmount = parseInt(retireAmount);
	savingsAmount = parseInt(savingsAmount);
	rate = parseFloat(rate,10);
	inflation = parseFloat(inflation,10);
 	
 	var title = "Retirement Calculator - "+(retireAmount/100000)+" Lakhs at age "+retireAge+" with "+inflation+"% inflation and "+rate+"% return";
 	var url = "/tools-and-calculators/retirement-planning-calculator?wealth_amount="+retireAmount+"&current_age="+currentAge+"&retirement_age="+retireAge+"&inflation_rate="+inflation+"&expected_return="+rate+"&savings_amount="+savingsAmount;
 	
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
		 colors: ['#ee1c25', '#005e96', '#FF8900', '#DDDF00', '#24CBE5', '#64E572', 
       '#FF9655', '#FFF263', '#6AF9C4'],
      chart: {
          plotBackgroundColor: null,
          plotBorderWidth: null,
          plotShadow: false
      },
      title: {
          text: 'Break-up of Total Payment'
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
	var current_age = $('#current_age').val();
	var retire_age = $('#retire_age').val();
	var amount = $('#amount').val();
	var savings_amount = $('#savings_amount').val();
	var interest = $('#interest').val();
	var inc_rate = $('#inc_rate').val();
	
	var retire_target = $('#res_retire_amount').html();
	var current_savings_target = $('#res_current_savings').html();
	var target_amount = $('#res_target_amount').html();
	var years = $('#res_years').html();
	var required_monthly_target = $('#res_monthly_savings').html();
	var invest_amount = $('#res_amount_invest').html();
	var interest_total = $('#res_total_earnings').html();
	
	amount = numbersWithComma(amount);
	savings_amount = numbersWithComma(savings_amount);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?current_age="+current_age+"&retire_age="+retire_age+"&amount="+amount+"&savings_amount="+savings_amount+"&interest="+interest+"&inc_rate="+inc_rate;
		param += "&retire_target="+retire_target+"&current_savings_target="+current_savings_target+"&target_amount="+target_amount+"&years="+years+"&required_monthly_target="+required_monthly_target+"&invest_amount="+invest_amount+"&interest_total="+interest_total+"&url="+calc_url;
		
		var url = '<c:url value="/downloadRetirementPlanningCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post("/sendRetirementPlanningCalcResult", {email : ""+email+"",current_age : ""+current_age+"",retire_age : ""+retire_age+"",amount : ""+amount+"",
    		savings_amount : ""+savings_amount+"",interest : ""+interest+"",
    		inc_rate : ""+inc_rate+"",retire_target : ""+retire_target+"",current_savings_target : ""+current_savings_target+"",
    		target_amount : ""+target_amount+"",years : ""+years+"",required_monthly_target : ""+required_monthly_target+"",invest_amount : ""+invest_amount+"",
    		interest_total : ""+interest_total+"",url : ""+ calc_url +""}, function(data)
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
		   	
		    var page = "Retirement Calculator - "+download_text;
		    
		    $.ajaxSetup({async:false});
			$.post("/subscribeForEmail", {email : "" + email + "", user_type : "" + radio_value + "", page : "" + page + "" }, function(data)
		    {
		    }, "text");
		    
		    init_download(email);
		}
    });
}]);
</script>
