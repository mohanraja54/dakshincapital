<jsp:include page="../layout/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var current_tab_value = 1;

var annual_income_expense = "";
var expected_increase_income_expense = "";
var loan_amount = "";
var accountMap = "";
var insurance_cover = 0;

$(document).ready(function(){

	annual_income_expense = '${annual_income_expense}';
	expected_increase_income_expense = '${expected_increase_income_expense}';
	loan_amount = '${loan_amount}';
	
	amount = parseInt(annual_income_expense);
	rate = parseFloat(expected_increase_income_expense,10);
	loan_amount = parseInt(loan_amount);
	
	$('#amount').val(amount);
	$('#rate').val(rate);
	$('#loan_amount').val(loan_amount);
	
	accountMap = '${accountMap}';
	
	$("#amount_slider").slider({
	    min: 100000,
	    max: 10000000,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: amount
	}).on("slideStop", function(slideEvt) {
		$("#amount").val(slideEvt.value);
		calculateValue();
	});
	
	$("#rate_slider").slider({
	    min: 0,
	    max: 30,
        tooltip: "show",
        step: 0.1,
        precision: 1,
        value: rate
	}).on("slideStop", function(slideEvt) {
		$("#rate").val(slideEvt.value);
		calculateValue();
	});
	
	$("#loan_amount_slider").slider({
	    min: 0,
	    max: 10000000,
        tooltip: "show",
        step: 1,
        precision: 1,
        value: loan_amount
	}).on("slideStop", function(slideEvt) {
		$( "#loan_amount" ).val(slideEvt.value);
		calculateValue();
	});

	calculateValue();
	
});

function amountChange()
{
	var amount = $('#amount').val();
	$( "#amount_slider" ).slider("setValue",amount);
	calculateValue();
}
function rateChange()
{
	var rate = $('#rate').val();
	$( "#rate_slider" ).slider("setValue",rate);
	calculateValue();
}
function loanAmountChange()
{
	var loan_amount = $('#loan_amount').val();
	$( "#loan_amount_slider" ).slider("setValue",loan_amount);
	calculateValue();
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
function calculateValue()
{
	var amount = $('#amount').val();
	var rate = $('#rate').val();
	var loan_amount = $('#loan_amount').val();
	
	amount = parseInt(amount);
	rate = parseFloat(rate,10);
	loan_amount = parseInt(loan_amount);
	
	var future_income = 0;
	
	
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getHumanLifeValueCalcResult", {annual_income_expense : "" + amount + "",expected_increase_income_expense : "" + rate + "",loan_amount : "" + loan_amount + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		future_income = obj.cumulative_income_expense;
		insurance_cover = obj.life_cover_value;
    },'text');
	
	$('#res_amount').html(numbersWithComma(amount));
	$('#res_rate').html(numbersWithComma(rate));
	$('#res_loan_amount').html(numbersWithComma(loan_amount));
	$('#res_future_amount').html(numbersWithComma(future_income));
	$('#res_insurance_cover').html(numbersWithComma(insurance_cover));	
}

function saveResult() 
{	
	
	var amount = $('#amount').val();
	var rate = $('#rate').val();
	var loan_amount = $('#loan_amount').val();
	
	amount = parseInt(amount);
	rate = parseFloat(rate,10);
	loan_amount = parseInt(loan_amount);
	
	var title = "Human Life Value Calcultor - Ideal life cover is "+(insurance_cover/1000000)+" Crores if current income is "+(amount/100000)+" Lakhs";
	var url = "/tools-and-calculators/human-life-value-calculator?annual_income_expense="+amount+"&expected_increase_income_expense="+rate+"&loan_amount="+loan_amount;	
	
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

function tabChange(val)
{
	current_tab_value = val;
	if(val == 1)
	{
		$("#amount_div b").text("Your Current Annual Income (Rs)");
		$("#rate_div b").text("Expected increase in income (% per annum)");
		$("#res_amount_txt").text("Your Current Annual Income");
		$("#res_rate_txt").text("Expected increase in income (% per annum)");
		$("#res_future_amount_txt").text("cumulative income that you will have to take care in next 10 years");
	}else
	{
		$("#amount_div b").text("Your Current Annual Expenses (Rs)");
		$("#rate_div b").text("Expected increase in expense (% per annum)");
		$("#res_amount_txt").text("Your Current Annual Expenses");
		$("#res_rate_txt").text("Expected increase in expense (% per annum)");
		$("#res_future_amount_txt").text("cumulative expense that you will have to take care in next 10 years");
	}	
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
	var amount = $('#amount').val();
	var rate = $('#rate').val();
	var loan_amount = $('#loan_amount').val();

	var res_amount = $( "#res_amount" ).html();
	var res_rate = $( "#res_rate" ).html();
	var res_loan_amount = $( "#res_loan_amount" ).html();
	var res_future_amount = $( "#res_future_amount" ).html();
	var res_insurance_cover = $( "#res_insurance_cover" ).html();
	
	amount = numbersWithComma(amount);
	loan_amount = numbersWithComma(loan_amount);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?amount="+amount+"&rate="+rate+"&loan_amount="+loan_amount+"&current_tab_value="+current_tab_value;
		param += "&res_amount="+res_amount+"&res_rate="+res_rate+"&res_loan_amount="+res_loan_amount+"&res_future_amount="+res_future_amount+"&res_insurance_cover="+res_insurance_cover+"&url="+calc_url;
		
		var url = '<c:url value="/downloadHumanLifeValueCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post(curl + "sendHumanLifeValueCalcResult", {email : ""+email+"",amount : ""+amount+"",rate : ""+rate+"",loan_amount : ""+loan_amount+"",
    		res_amount : ""+res_amount+"",res_rate : ""+res_rate+"",res_loan_amount : ""+res_loan_amount+"",res_future_amount : ""+res_future_amount+"",
    		res_insurance_cover : ""+res_insurance_cover+"",current_tab_value : ""+current_tab_value+"",url : ""+ calc_url +""}, function(data)
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
			<li class="active"> &nbsp;Human Life Value Calculator</li>
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
           		<h2 class="amfi-title bold">HUMAN LIFE VALUE CALCULATOR</h2>
				<div class="row margin-top14">
			   	<div class="col-md-7"> 
			   	
			   	<div role="tabpanel">
				  <!-- Nav tabs -->
				  <ul class="nav nav-tabs" role="tablist" id="myTab">
				    <li role="presentation" class="nav-item"><a class="nav-link active" href="#tab-1" aria-controls="tab-1" role="tab" data-toggle="tab" onclick="tabChange(1)">Income Method</a></li>
				    <li role="presentation" class="nav-item"><a class="nav-link" href="#tab-1" aria-controls="tab-1" role="tab" data-toggle="tab" onclick="tabChange(2)">Expense Method</a></li>
				  </ul>
				  <!-- Tab panes -->
				  <div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="tab-1">
				    
				    <div id="emi">
					<div class="inside_emi" style="margin:0px;">
					<div class="lamount">
						<div style="float:left;" id="amount_div"><b>Your Current Annual Income (Rs)</b></div>
						<input type="text" value="2500000" id="amount" maxlength="8" onchange="amountChange()" />
					</div>
					<div style="clear:both;"></div>
					<div id="amount_slider" style="margin:0px;"></div>
					<div class="steps" id="loanamountsteps">	
						<span style="left:0%;" class="tick">|<br />
						<span class="marker">1 Lakh</span></span><span style="left:24.24%;" class="tick">|<br />
						<span class="marker">25 Lakhs</span></span><span style="left:49.49%;" class="tick">|<br />
						<span class="marker">50 Lakhs</span></span><span style="left:74.74%;" class="tick">|<br />
						<span class="marker">75 Lakhs</span></span><span style="left:100%;" class="tick">|<br />
						<span class="marker">1 Crore</span></span>
					</div>
					</div>
					
					<div class="small_line" style="margin:0px;"></div>
					<div class="inside_emi" style="margin:0px;">
					<div class="sep lint"> 
						<div style="float:left;" id="rate_div"><b>Expected increase in income (% per annum)</b></div>
						<input type="text" value="10" id="rate" maxlength="4" onchange="rateChange()">
					</div>
					<div style="clear:both;"></div>
					<div id="rate_slider" style="margin:0px;"></div>
					<div class="steps">
						<span style="left: 0%;" class="tick">|<br />
						<span class="marker">0</span></span><span style="left: 16.66%;" class="tick">|<br />
						<span class="marker">5</span></span><span style="left: 33.33%;" class="tick">|<br />
						<span class="marker">10</span></span><span style="left: 50%;" class="tick">|<br />
						<span class="marker">15</span></span><span style="left: 66.66%;" class="tick">|<br />
						<span class="marker">20</span></span><span style="left: 83.33%;" class="tick">|<br />
						<span class="marker">25</span></span><span style="left: 100%;" class="tick">|<br />
						<span class="marker">30</span></span>
					</div>
					</div>
					
					<div class="small_line" style="margin:0px;"></div>
					<div class="inside_emi" style="margin:0px;">
					<div class="sep lint"> 
						<div style="float:left;"><b>Outstanding loan amount  (Rs)</b></div>
						<input type="text" value="0" id="loan_amount" maxlength="8" onchange="loanAmountChange()">
					</div>
					<div style="clear:both;"></div>
					<div id="loan_amount_slider" style="margin:0px;"></div>
					<div class="steps" id="loantermsteps">
						<span style="left:0%;" class="tick">|<br />
						<span class="marker">0</span></span><span style="left:25%;" class="tick">|<br />
						<span class="marker">25 Lakhs</span></span><span style="left:50%;" class="tick">|<br />
						<span class="marker">50 Lakhs</span></span><span style="left:75%;" class="tick">|<br />
						<span class="marker">75 Lakhs</span></span><span style="left:100%;" class="tick">|<br />
						<span class="marker">1 Crore</span></span>
					</div>
					</div>
					
					</div>
				    
				    </div>
				  </div>
				</div> 
			
			   </div>
			   
			   <div class="col-md-5">
			   
			   <div id="emipaymentsummary" style="margin-top:38px;">
				<div id="emitotalinterest">
					<h4 id="res_amount_txt">Your Current Annual Income</h4>
					<p>Rs. <span id="res_amount"></span></p>
				</div>
				<div id="emitotalinterest">
					<h4 id="res_rate_txt">Expected increase in income (% per annum)</h4>
					<p><span id="res_rate"></span> %</p>
				</div>
				<div id="emitotalinterest">
					<h4>Outstanding loan amount</h4>
					<p>Rs. <span id="res_loan_amount"></span></p>
				</div>
				<div id="emitotalinterest">
					<h4 id="res_future_amount_txt">cumulative income that you will have to take care in next 10 years</h4>
					<p>Rs. <span id="res_future_amount"></span></p>
				</div>
				<div id="emitotalamount">
					<h4>Your ideal life cover</h4>
					<p>Rs. <span id="res_insurance_cover"></span></p>
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