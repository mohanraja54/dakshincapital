<jsp:include page="../layout/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
#assetchart {
    border: 1px solid #ddd;
    float: left;
    height: 300px;
    overflow: hidden;
    width: 100%;
    margin-bottom: 20px;
    text-align: center;
}
</style>

<script type="text/javascript">

var current_age = "";
var retire_age = "";
var savings_interest_rate = "";
var income_tax_rate = "";
var inflation_rate = "";
var house_flat_value = "";
var home_loan_emi_value = "";
var new_car_value = "";
var eating_out_value = "";
var lifestyle_spending_value = "";
var holidays_value = "";
var transport_value = "";
var credit_card_interest_value = "";
var personal_loan_value = "";
var shopping_value = "";
var accountMap = "";
var total_savings_amount = 0;
var total_spending_amount = 0;

$(document).ready(function(){

	current_age = '${current_age}';
	retire_age = '${retire_age}';
	savings_interest_rate = '${savings_interest_rate}';
	income_tax_rate = '${income_tax_rate}';
	inflation_rate = '${inflation_rate}';
	house_flat_value = '${house_flat_value}';
	home_loan_emi_value = '${home_loan_emi_value}';
	new_car_value = '${new_car_value}';
	eating_out_value = '${eating_out_value}';
	lifestyle_spending_value = '${lifestyle_spending_value}';
	holidays_value = '${holidays_value}';
	transport_value = '${transport_value}';
	credit_card_interest_value = '${credit_card_interest_value}';
	personal_loan_value = '${personal_loan_value}';
	shopping_value = '${shopping_value}';
	accountMap = '${accountMap}';	
	
	var current_age = parseInt(current_age);
	var retire_age = parseInt(retire_age);
	var savings_interest_rate = parseFloat(savings_interest_rate,10);
	var income_tax_rate = parseFloat(income_tax_rate,10);
	var inflation_rate = parseFloat(inflation_rate,10);
	
	var purchase_house = parseInt(house_flat_value);
	var home_loan = parseInt(home_loan_emi_value);
	var buy_car = parseInt(new_car_value);
	var eating_out_less = parseInt(eating_out_value);
	var lifestyle_spend = parseInt(lifestyle_spending_value);
	var holidays = parseInt(holidays_value);
	var transport = parseInt(transport_value);
	var credit_card = parseInt(credit_card_interest_value);
	var personal_loan = parseInt(personal_loan_value);
	var shopping = parseInt(shopping_value);
	
	$( "#current_age_txt" ).val(current_age);
	$( "#retire_age_txt" ).val(retire_age);
	$( "#savings_interest_rate_txt" ).val(savings_interest_rate);
	$( "#income_tax_rate_txt" ).val(income_tax_rate);
	$( "#inflation_rate_txt" ).val(inflation_rate);
	
	$( "#purchase_house_txt" ).val(purchase_house);
	$( "#home_loan_txt" ).val(home_loan);
	$( "#buy_car_txt" ).val(buy_car);
	$( "#eating_out_less_txt" ).val(eating_out_less);
	$( "#lifestyle_spend_txt" ).val(lifestyle_spend);
	$( "#holidays_txt" ).val(holidays);
	$( "#transport_txt" ).val(transport);
	$( "#credit_card_txt" ).val(credit_card);
	$( "#personal_loan_txt" ).val(personal_loan);
	$( "#shopping_txt" ).val(shopping);
	
	calulateSpending();
});


function calulateSpending()
{
	var current_age = $( "#current_age_txt" ).val();
	var retire_age = $( "#retire_age_txt" ).val();
	var savings_interest_rate = $( "#savings_interest_rate_txt" ).val();
	var income_tax_rate = $( "#income_tax_rate_txt" ).val();
	var inflation_rate = $( "#inflation_rate_txt" ).val();
	
	var purchase_house = $( "#purchase_house_txt" ).val();
	var home_loan = $( "#home_loan_txt" ).val();
	var buy_car = $( "#buy_car_txt" ).val();
	var eating_out_less = $( "#eating_out_less_txt" ).val();
	var lifestyle_spend = $( "#lifestyle_spend_txt" ).val();
	var holidays = $( "#holidays_txt" ).val();
	var transport = $( "#transport_txt" ).val();
	var credit_card = $( "#credit_card_txt" ).val();
	var personal_loan = $( "#personal_loan_txt" ).val();
	var shopping = $( "#shopping_txt" ).val();

	
	current_age = $.trim(current_age);
	retire_age = $.trim(retire_age);
	savings_interest_rate = $.trim(savings_interest_rate);
	income_tax_rate = $.trim(income_tax_rate);
	inflation_rate = $.trim(inflation_rate);
	
	purchase_house = $.trim(purchase_house);
	home_loan = $.trim(home_loan);
	buy_car = $.trim(buy_car);
	eating_out_less = $.trim(eating_out_less);
	lifestyle_spend = $.trim(lifestyle_spend);
	holidays = $.trim(holidays);
	transport = $.trim(transport);
	credit_card = $.trim(credit_card);
	personal_loan = $.trim(personal_loan);
	shopping = $.trim(shopping);
	
	if(current_age == "" || !validateNumbersOnly(current_age) || current_age < 0)
	{
		alert("Please enter the valid current age");
		return false;
	}
	if(retire_age == "" || !validateNumbersOnly(retire_age) || retire_age < 0)
	{
		alert("Please enter the valid retire age");
		return false;
	}
	if(savings_interest_rate == "" || isNaN(savings_interest_rate) || savings_interest_rate < 0 || savings_interest_rate > 20)
	{
		alert("Please enter the savings interest rate less than 20");
		return false;
	}
	if(income_tax_rate == "" || isNaN(income_tax_rate) || income_tax_rate < 0 || income_tax_rate > 20)
	{
		alert("Please enter the income tax interest rate less than 20");
		return false;
	}
	if(inflation_rate == "" || isNaN(inflation_rate) || inflation_rate < 0 || inflation_rate > 15)
	{
		alert("Please enter the inflation rate less than 15");
		return false;
	}
	if(purchase_house == "")
	{
		purchase_house = 0;
	}else
	{
		if(!validateNumbersOnly(purchase_house) || purchase_house < 0)
		{
			alert("Please enter the valid amount for purchase of a house/flat");
			return false;
		}
	}
	if(home_loan == "")
	{
		home_loan = 0;
	}else
	{
		if(!validateNumbersOnly(home_loan) || home_loan < 0)
		{
			alert("Please enter the valid amount for reducing the Home Loan EMI");
			return false;
		}
	}
	if(buy_car == "")
	{
		buy_car = 0;
	}else
	{
		if(!validateNumbersOnly(buy_car) || buy_car < 0)
		{
			alert("Please enter the valid amount for buy a new car");
			return false;
		}
	}
	if(eating_out_less == "")
	{
		eating_out_less = 0;
	}else
	{
		if(!validateNumbersOnly(eating_out_less) || eating_out_less < 0)
		{
			alert("Please enter the valid amount for eating out less with family");
			return false;
		}
	}
	if(lifestyle_spend == "")
	{
		lifestyle_spend = 0;
	}else
	{
		if(!validateNumbersOnly(lifestyle_spend) || lifestyle_spend < 0)
		{
			alert("Please enter the valid amount for reduce lifestyle spending");
			return false;
		}
	}
	if(holidays == "")
	{
		holidays = 0;
	}else
	{
		if(!validateNumbersOnly(holidays) || holidays < 0)
		{
			alert("Please enter the valid amount for taking fewer holidays");
			return false;
		}
	}
	if(transport == "")
	{
		transport = 0;
	}else
	{
		if(!validateNumbersOnly(transport) || transport < 0)
		{
			alert("Please enter the valid amount for taking public transport");
			return false;
		}
	}
	if(credit_card == "")
	{
		credit_card = 0;
	}else
	{
		if(!validateNumbersOnly(credit_card) || credit_card < 0)
		{
			alert("Please enter the valid amount for reducing the credit card interest");
			return false;
		}
	}
	if(personal_loan == "")
	{
		personal_loan = 0;
	}else
	{
		if(!validateNumbersOnly(personal_loan) || personal_loan < 0)
		{
			alert("Please enter the valid amount for closing the personal loan");
			return false;
		}
	}
	if(shopping == "")
	{
		shopping = 0;
	}else
	{
		if(!validateNumbersOnly(shopping) || shopping < 0)
		{
			alert("Please enter the valid amount for doing less shopping");
			return false;
		}
	}
	current_age = parseInt(current_age);
	retire_age = parseInt(retire_age);
	savings_interest_rate = parseFloat(savings_interest_rate,10);
	income_tax_rate = parseFloat(income_tax_rate,10);
	inflation_rate = parseFloat(inflation_rate,10);
	
	purchase_house = parseInt(purchase_house);
	home_loan = parseInt(home_loan);
	buy_car = parseInt(buy_car);
	eating_out_less = parseInt(eating_out_less);
	lifestyle_spend = parseInt(lifestyle_spend);
	holidays = parseInt(holidays);
	transport = parseInt(transport);
	credit_card = parseInt(credit_card);
	personal_loan = parseInt(personal_loan);
	shopping = parseInt(shopping);
	
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getSpendingLessCalcResult", {current_age : "" + current_age + "",retire_age : "" + retire_age + "",savings_interest_rate : "" + savings_interest_rate + "",income_tax_rate : "" + income_tax_rate + "",inflation_rate : "" + inflation_rate + "",house_flat_value : "" + purchase_house + "",home_loan_emi_value : "" + home_loan + "",new_car_value : "" + buy_car + "",eating_out_value : "" + eating_out_less + "",lifestyle_spending_value : "" + lifestyle_spend + "",holidays_value : "" + holidays + "",transport_value : "" + transport + "",credit_card_interest_value : "" + credit_card + "",personal_loan_value : "" + personal_loan + "",shopping_value : "" + shopping + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		total_spending_amount = obj.savings_amount;
		age_diff = obj.years;
		total_savings_amount = obj.savings_maturity_amount;
    },'text');
	
	$( "#res_total_spending_amount" ).html(numbersWithComma(total_spending_amount));
	$( "#res_total_years" ).html(age_diff);
	$( "#res_total_savings_amount" ).html(numbersWithComma(total_savings_amount));
	
    renderChart(total_spending_amount,total_savings_amount);
}

function saveResult() 
{	
	var current_age = $( "#current_age_txt" ).val();
	var retire_age = $( "#retire_age_txt" ).val();
	var savings_interest_rate = $( "#savings_interest_rate_txt" ).val();
	var income_tax_rate = $( "#income_tax_rate_txt" ).val();
	var inflation_rate = $( "#inflation_rate_txt" ).val();
	
	var purchase_house = $( "#purchase_house_txt" ).val();
	var home_loan = $( "#home_loan_txt" ).val();
	var buy_car = $( "#buy_car_txt" ).val();
	var eating_out_less = $( "#eating_out_less_txt" ).val();
	var lifestyle_spend = $( "#lifestyle_spend_txt" ).val();
	var holidays = $( "#holidays_txt" ).val();
	var transport = $( "#transport_txt" ).val();
	var credit_card = $( "#credit_card_txt" ).val();
	var personal_loan = $( "#personal_loan_txt" ).val();
	var shopping = $( "#shopping_txt" ).val();
	
	var title = "Save Money by spending less - Can create wealth of "+(total_spending_amount/100000)+" Lakhs by saving "+(total_savings_amount/100000)+" Lakhs annual";
	var url = "/tools-and-calculators/save-more-by-spending-less-calculator?current_age="+current_age+"&retire_age="+retire_age+"&savings_interest_rate="+savings_interest_rate+"&income_tax_rate="+income_tax_rate+"&inflation_rate="+inflation_rate+"&house_flat_value="+purchase_house+"&home_loan_emi_value="+home_loan+"&new_car_value="+buy_car+"&eating_out_value="+eating_out_less+"&lifestyle_spending_value="+lifestyle_spend+"&holidays_value="+holidays+"&transport_value="+transport+"&credit_card_interest_value="+credit_card+"&personal_loan_value="+personal_loan+"&shopping_value="+shopping;		
	
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
	$('#assetchart').highcharts({
		 colors: ['#76b8f4', '#a4d035', '#FF8900', '#DDDF00', '#24CBE5', '#64E572', 
       '#FF9655', '#FFF263', '#6AF9C4'],
      chart: {
          plotBackgroundColor: null,
          plotBorderWidth: null,
          plotShadow: false
      },
      title: {
          text: 'Break-up of Total Future Value'
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
              ['Invested Amount', amount],
              {
                  name: 'Total Earnings',
                  y: total_interest,
                  sliced: true,
                  selected: true
              }
          ]
      }]
  });
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
	var current_age = $( "#current_age_txt" ).val();
	var retire_age = $( "#retire_age_txt" ).val();
	var savings_interest_rate = $( "#savings_interest_rate_txt" ).val();
	var income_tax_rate = $( "#income_tax_rate_txt" ).val();
	var inflation_rate = $( "#inflation_rate_txt" ).val();

	var purchase_house = $( "#purchase_house_txt" ).val();
	var home_loan = $( "#home_loan_txt" ).val();
	var buy_car = $( "#buy_car_txt" ).val();
	var eating_out_less = $( "#eating_out_less_txt" ).val();
	var lifestyle_spend = $( "#lifestyle_spend_txt" ).val();
	var holidays = $( "#holidays_txt" ).val();
	var transport = $( "#transport_txt" ).val();
	var credit_card = $( "#credit_card_txt" ).val();
	var personal_loan = $( "#personal_loan_txt" ).val();
	var shopping = $( "#shopping_txt" ).val();

	var res_total_spending_amount = $( "#res_total_spending_amount" ).html();
	var res_total_years = $( "#res_total_years" ).html();
	var res_total_savings_amount = $( "#res_total_savings_amount" ).html();
	
	purchase_house = numbersWithComma(purchase_house);
	home_loan = numbersWithComma(home_loan);
	buy_car = numbersWithComma(buy_car);
	eating_out_less = numbersWithComma(eating_out_less);
	lifestyle_spend = numbersWithComma(lifestyle_spend);
	holidays = numbersWithComma(holidays);
	transport = numbersWithComma(transport);
	credit_card = numbersWithComma(credit_card);
	personal_loan = numbersWithComma(personal_loan);
	shopping = numbersWithComma(shopping);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?current_age="+current_age+"&retire_age="+retire_age+"&savings_interest_rate="+savings_interest_rate+"&income_tax_rate="+income_tax_rate+"&inflation_rate="+inflation_rate;
		param += "&purchase_house="+purchase_house+"&home_loan="+home_loan+"&buy_car="+buy_car+"&eating_out_less="+eating_out_less+"&lifestyle_spend="+lifestyle_spend+"&holidays="+holidays;
		param += "&transport="+transport+"&credit_card="+credit_card+"&personal_loan="+personal_loan+"&shopping="+shopping+"&res_total_spending_amount="+res_total_spending_amount;
		param += "&res_total_years="+res_total_years+"&res_total_savings_amount="+res_total_savings_amount+"&url="+calc_url;
		
		var url = '<c:url value="/downloadSpendingLessCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post(curl + "sendSpendingLessCalcResult", {email : ""+txtemail+"",current_age : ""+current_age+"",retire_age : ""+retire_age+"",
    		savings_interest_rate : ""+savings_interest_rate+"",income_tax_rate : ""+income_tax_rate+"",inflation_rate : ""+inflation_rate+"",purchase_house : ""+purchase_house+"",
    		home_loan : ""+home_loan+"",buy_car : ""+buy_car+"",eating_out_less : ""+eating_out_less+"",lifestyle_spend : ""+lifestyle_spend+"",
    		holidays : ""+holidays+"",transport : ""+transport+"",credit_card : ""+credit_card+"",
    		personal_loan : ""+personal_loan+"",shopping : ""+shopping+"",res_total_spending_amount : ""+res_total_spending_amount+"",res_total_years : ""+res_total_years+"",
    		res_total_savings_amount : ""+res_total_savings_amount+"",url : ""+ calc_url +""}, function(data)
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
function validateNumbersOnly(number)
{    
	var re = /^[0-9]*$/;
    if(re.test(number))
    {
       return true;
	}
    else
    {
       return false;
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
			<li class="active"> &nbsp;Spending Less Calculator</li>
		</ol>
	</div>
</div>
<!-- breadcrumb end -->

<!-- main-container start -->
<!-- ================ -->
<section class="main-container marginTop35">

	<div class="container">
		<div class="row">
           
           <div class="col-md-3">          
              <jsp:include page="../sidebar/calc-sidebar.jsp"></jsp:include>             
           </div>
           
           <div class="col-md-9 marginBottom35">
           		<h2 class="amfi-title bold">SPENDING LESS CALCULATOR</h2>
           		<div class="row margin-top14">
			   	<div class="col-md-7"> 
			   	<div class="table-responsive" id="input_table">
			   	<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin:0px !important;">
			   	<thead>
			   	<tr>
			   	<th colspan="2">Personal Details</th>
			   	</tr>
			   	</thead>
			   	<tbody>
				<tr>
					<td width="53%">Your Current age (in years)</td>
					<td>
						<div class="form-group"> 
			            	<input id="current_age_txt" value="25" maxlength="2" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the first child name"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
					</td>
				</tr>
				<tr>
					<td>Age at which you want to retire (in years)</td>
					<td>
						<div class="form-group"> 
			            	<input id="retire_age_txt" value="60" maxlength="2" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the second child name"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
					</td>
				</tr>
				<tr>
					<td>Savings or interest rate of your current investments (% per annum)</td>
					<td>
						<div class="form-group"> 
			            	<input id="savings_interest_rate_txt" value="12" maxlength="4" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the first child age"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
					</td>
				</tr>
				<tr>
					<td>Income Tax rate (% per annum)</td>
					<td>
						<div class="form-group"> 
			            	<input id="income_tax_rate_txt" value="7" maxlength="4" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the second child age"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
					</td>
				</tr>
				<tr>
				    <td>Current Inflation rate (% per annum)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="inflation_rate_txt" value="5" maxlength="4" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter first child prof edu age"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				</tbody>
				</table>
				
				
				<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;">
			   	<thead>
			   	<tr>
			   	<th colspan="2">Spending Details</th>
			   	</tr>
			   	</thead>
			   	<tbody>
				<tr>
				    <td width="53%">Deferring purchase of a house / flat (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="purchase_house_txt" value="500000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter first child edu amount"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Reducing the Home Loan EMI (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="home_loan_txt" value="30000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter second child edu amount"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Waiting to buy a new car (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="buy_car_txt" value="300000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the inflation rate"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Eating out less with family (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="eating_out_less_txt" value="25000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the return rate"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Reduce lifestyle spending (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="lifestyle_spend_txt" value="25000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the savings amount"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Taking fewer holidays (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="holidays_txt" value="10000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the savings amount"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Taking public transport (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="transport_txt" value="10000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the savings amount"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Reducing the credit card interest (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="credit_card_txt" value="30000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the savings amount"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Closing the personal loan (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="personal_loan_txt" value="20000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the savings amount"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Doing less shopping (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="shopping_txt" value="10000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the savings amount"><span class="color-khojorange" style="padding-left:3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr id="submit_btn_row">
				    <td colspan="2"><div class="text_center"><a onclick="calulateSpending()" class="btn btn-info" href="javascript:void(0)">Submit</a></div></td>
				</tr>
				</tbody>
				</table>
				</div>
			   	</div>
			   	
			   	<div class="col-md-5">
			   
			   <div id="assetchart"></div>
				<div id="emipaymentsummary">
					<div id="emitotalinterest">
						<h4>By reducing your spending you will save this amount each year</h4>
						<p>Rs. <span id="res_total_spending_amount"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Number of Years</h4>
						<p><span id="res_total_years"></span> Years</p>
					</div>
					<div id="emitotalamount">
						<h4>If you invest this amount, you will accumulate this amount by the time you retire</h4>
						<p>Rs. <span id="res_total_savings_amount"></span></p>
					</div>
				</div>
			
			   	</div>
			   	
			   	<!-- <div class="col-md-12 text-center">
					<a href="javascript:void(0)" id="calc_btn_submit" class="btn btn-warning ladda-button mutual-funds-submit-anchor marginTop20" onclick="saveResult()" data-style="expand-right" data-size="l"><span class="ladda-label">Save Result</span></a>
				</div> -->
			   	
				</div>
	       </div>

     </div>
	</div>
</section>
<!-- main-container end -->
<jsp:include page="../layout/footer.jsp"></jsp:include>