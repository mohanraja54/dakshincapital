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
			<li class="active"> &nbsp;Composite Financial Goal Planner Calculator</li>
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
           <h2 class="amfi-title bold">Composite Financial Goal Planner Calculator</h2>
			<div class="row margin-top14">
			   	<div class="col-md-7"> 
			   	
			   	<div id="emi" class="mt-2">
				<div class="inside_emi">
				<div class="lamount">
					<div class="txt"><b>What is the amount you would need to fulfil your child educational need at today's cost (Rs)</b></div>
					<input type="text" value="2500000" id="edu_amount" maxlength="8" onchange="eduAmountChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="edu_amount_slider" style="margin:0px;"></div>
				<div class="steps" id="loanamountsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">1 Lakh</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">25 Lakhs</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">50 Lakhs</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">75 Lakhs</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">1 Crore</span></span>
				</div>
				</div>

				<div class="inside_emi">
				<div class="sep lint"> 
					<div class="txt"><b>What is the amount you would need to consider yourself wealthy at today's cost (Rs)</b></div>
					<input type="text" value="5000000" id="wel_amount" maxlength="8" onchange="welAmountChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="wel_amount_slider" style="margin:0px;"></div>
				<div class="steps" id="loantermsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">1 Lakh</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">25 Lakhs</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">50 Lakhs</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">75 Lakhs</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">1 Crore</span></span>
				</div>
				</div>

				<div class="inside_emi">
				<div class="sep lint"> 
					<div class="txt"><b>What is the amount you would need to spend on buying an item you dream - a big car or a foreign holiday or a house (Rs)</b></div>
					<input type="text" value="1500000" id="expense_amount" maxlength="8" onchange="expenseAmountChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="expense_amount_slider" style="margin:0px;"></div>
				<div class="steps" id="loantermsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">1 Lakh</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">25 Lakhs</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">50 Lakhs</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">75 Lakhs</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">1 Crore</span></span>
				</div>
				</div>

				<div class="inside_emi">
				<div class="sep lint"> 
					<div class="txt"><b>What is your current age? (in years)</b></div>
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
					<div class="txt"><b>What age you plan to acquiring wealth? (in years)</b></div>
					<input type="text" value="60" id="wealth_age" maxlength="3" onchange="wealthAgeChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="wealth_age_slider" style="margin:0px;"></div>
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
					<div class="txt"><b>What is your child current age? (in years)</b></div>
					<input type="text" value="5" id="child_age" maxlength="3" onchange="childAgeChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="child_age_slider" style="margin:0px;"></div>
				<div class="steps" id="loantermsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">0</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">25</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">50</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">75</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">100</span></span>
				</div>
				</div>

				<div class="inside_emi">
				<div class="sep lint"> 
					<div class="txt"><b>What age your child would be ready for professional education? (in years)</b></div>
					<input type="text" value="25" id="child_edu_age" maxlength="3" onchange="childEduAgeChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="child_edu_age_slider" style="margin:0px;"></div>
				<div class="steps" id="loantermsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">0</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">25</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">50</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">75</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">100</span></span>
				</div>
				</div>

				<div class="inside_emi">
				<div class="sep lint"> 
					<div class="txt"><b>Afer how many years away would you need the amount to spend on buying an item you dream (Rs)</b></div>
					<input type="text" value="30" id="expense_year" maxlength="3" onchange="expenseYearChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="expense_year_slider" style="margin:0px;"></div>
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
					<input type="text" value="7.5" id="inc_rate" maxlength="4" onchange="increaseRateChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="increase_rate_slider" style="margin:0px;"></div>
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
					<div class="txt"><b>What rate of return would you expect your investment? (% per annum)</b></div>
					<input type="text" value="12.5" id="interest" maxlength="4" onchange="interestChange()" />
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
				<div class="lamount">
					<div class="txt"><b>How much savings you have now? (Rs)</b></div>
					<input type="text" value="500000" id="savings_amount" maxlength="8" onchange="savingsAmountChange()" />
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
			   	
			   	<div id="compositechart" class="mt-2"></div>

				<div id="ad-1"></div>
			
			   	</div>
			   	
			   <!-- 	<div class="col-md-12 text-right">
				  <a href="javascript:void(0)" id="calc_btn_submit" class="btn btn-warning ladda-button mutual-funds-submit-anchor marginTop20" onclick="saveResult()" data-style="expand-right" data-size="l"><span class="ladda-label">Save Result</span></a>
				</div> -->
				
			   	<div class="col-md-12 text-right">
				</div>
				
				</div>
				
				<div class="row">
			   	<div class="col-md-12">  
			   	<div id="result_plan" class="table-responsive marginTop20">
			   	<table id="result-table-1" class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;">
			   	<thead>
			   	<tr>
				  <th colspan="5"><div class="text-center">Result</div></th>
				</tr>
				<tr>
				  <th width="28%">Composite Planner</th>
				  <th width="18%">Education</th>
				  <th width="18%">Wealth</th>
				  <th width="18%">Expense</th>
				  <th width="18%">Total</th>
				</tr>
				</thead>
				<tbody>
				<tr>
				  <td width="28%"><p>Amount at today's prices</p></td>
				  <td width="18%">Rs. <span id="txtResEduAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResWelAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResDreAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResTotalAmt"></span></td>
				</tr>
				<tr>
				  <td width="28%">Number of years to achieve your goals</td>
				  <td width="18%"><span id="txtResEduYear"></span> year(s)</td>
				  <td width="18%"><span id="txtResWelYear"></span> year(s)</td>
				  <td width="18%"><span id="txtResDreYear"></span> year(s)</td>
				  <td width="18%"><b>-</b></td>
				</tr>
				<tr>
				  <td width="28%">Expected rate of return from investments (% per annum)</td>
				  <td width="18%"><span id="txtResRate1"></span> %</td>
				  <td width="18%"><span id="txtResRate2"></span> %</td>
				  <td width="18%"><span id="txtResRate3"></span> %</td>
				  <td width="18%"><b>-</b></td>
				</tr>
				<tr>
				  <td width="28%">Personal goal target (Inflation adjusted)</td>
				  <td width="18%">Rs. <span id="txtResIncEduAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResIncWelAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResIncDreAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResIncTotalAmt"></span></td>
				</tr>
				<tr>
				  <td width="28%">Your current savings amount</td>
				  <td width="18%">Rs. <span id="txtResInvestEduAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResInvestWelAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResInvestDreAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResInvestTotalAmt"></span></td>
				</tr>
				<tr>
				  <td width="28%">Monthly Savings required</td>
				  <td width="18%">Rs. <span id="txtResMonEduAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResMonWelAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResMonDreAmt"></span></td>
				  <td width="18%">Rs. <span id="txtResMonTotalAmt"></span></td>
				</tr>
				</tbody>
				</table>
				</div>
				</div>
				</div>
	       </div>

     </div>
	</div>
</section>
<!-- main-container end -->
<script type="text/javascript">

var child_current_age = "";
var child_education_age = "";
var education_amount = "";
var current_age = "";
var wealth_age = "";
var wealth_amount = "";
var expense_amount = "";
var expense_year = "";
var inflation_rate = "";
var expected_return = "";
var savings_amount = "";
var accountMap = "";

$(document).ready(function(){

	child_current_age = '${child_current_age}';
	child_education_age = '${child_education_age}';
	education_amount = '${education_amount}';
	current_age = '${current_age}';
	wealth_age = '${wealth_age}';
	wealth_amount = '${wealth_amount}';
	expense_amount = '${expense_amount}';
	expense_year = '${expense_year}';
	inflation_rate = '${inflation_rate}';
	expected_return = '${expected_return}';
	savings_amount = '${savings_amount}';
	
	childAge = parseInt(child_current_age);
	childEducationAge = parseInt(child_education_age);
	educationAmount = parseInt(education_amount);
	currentAge = parseInt(current_age);
	retireAge = parseInt(wealth_age);
	wealthyAmount = parseInt(wealth_amount);
	dreamExpenseYear = parseInt(expense_year);
	dreamAmount = parseInt(expense_amount);
	increaseRate = parseFloat(inflation_rate,10);
	rateOfReturn = parseFloat(expected_return,10);
	investmentAmount = parseInt(savings_amount);
	
	$('#child_age').val(childAge);
	$('#child_edu_age').val(childEducationAge);
	$('#edu_amount').val(educationAmount);
	$('#current_age').val(currentAge);
	$('#wealth_age').val(retireAge);
	$('#wel_amount').val(wealthyAmount);
	$('#expense_year').val(dreamExpenseYear);
	$('#expense_amount').val(dreamAmount);
	$('#inc_rate').val(increaseRate);
	$('#interest').val(rateOfReturn);
	$('#savings_amount').val(investmentAmount);
	
	accountMap = '${accountMap}';	
	
	$("#edu_amount_slider").slider({
	    min: 100000,
	    max: 10000000,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: educationAmount
	}).on("slideStop", function(slideEvt) {		
		$("#edu_amount").val(slideEvt.value);
		calculateFinalResult();
	});
	
	$("#wel_amount_slider").slider({
	    min: 100000,
	    max: 10000000,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: wealthyAmount
	}).on("slideStop", function(slideEvt) {
		$("#wel_amount").val(slideEvt.value);
		calculateFinalResult();
	});
	
	$("#expense_amount_slider").slider({
	    min: 100000,
	    max: 10000000,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: dreamAmount
	}).on("slideStop", function(slideEvt) {
		$("#expense_amount").val(slideEvt.value);
		calculateFinalResult();
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
		calculateFinalResult();
	});
	
	$("#wealth_age_slider").slider({
		min: 10,
        max: 100,
        tooltip: "show",
        step: 1,
        precision: 1,
        value: retireAge
	}).on("slideStop", function(slideEvt) {
		$("#wealth_age").val(slideEvt.value);
		calculateFinalResult();
	});
	
	$("#child_age_slider").slider({
	    min: 0,
	    max: 100,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: childAge
	}).on("slideStop", function(slideEvt) {
		$("#child_age").val(slideEvt.value);
		calculateFinalResult();
	});
	
	$("#child_edu_age_slider").slider({
		min: 0,
        max: 100,
        tooltip: "show",
        step: 1,
        precision: 1,
        value: childEducationAge
	}).on("slideStop", function(slideEvt) {
		$("#child_edu_age").val(slideEvt.value);
		calculateFinalResult();
	});
	
	$("#expense_year_slider").slider({
		min: 1,
        max: 100,
        tooltip: "show",
        step: 1,
        precision: 1,
        value: dreamExpenseYear
	}).on("slideStop", function(slideEvt) {
		$("#expense_year").val(slideEvt.value);
		calculateFinalResult();
	});
	
	$("#increase_rate_slider").slider({
		min: 5,
        max: 15,
        tooltip: "show",
        step: 0.1,
        precision: 1,
        value: increaseRate
	}).on("slideStop", function(slideEvt) {
		$("#inc_rate").val(slideEvt.value);
		calculateFinalResult();
	});
	
	$("#interest_slider").slider({
		min: 5,
        max: 20,
        tooltip: "show",
        step: 0.1,
        precision: 1,
        value: rateOfReturn
	}).on("slideStop", function(slideEvt) {
		$("#interest").val(slideEvt.value);
		calculateFinalResult();
	});
	
	$("#savings_amount_slider").slider({
	    min: 0,
	    max: 10000000,
        tooltip: "show",
        step: 1,
        precision: 0,
        value: investmentAmount
	}).on("slideStop", function(slideEvt) {
		$("#savings_amount").val(slideEvt.value);
		calculateFinalResult();
	});
	
	calculateFinalResult();
	
});

function eduAmountChange()
{
	var educationAmount = $('#edu_amount').val();
	$( "#edu_amount_slider" ).slider("setValue",educationAmount);
	calculateFinalResult();
}
function welAmountChange()
{
	var wealthAmount = $('#wel_amount').val();
	$( "#wel_amount_slider" ).slider("setValue",wealthAmount);
	calculateFinalResult();
}
function expenseAmountChange()
{
	var expenseAmount = $('#expense_amount').val();
	$( "#expense_amount_slider" ).slider("setValue",expenseAmount);
	calculateFinalResult();
}
function currentAgeChange()
{
	var currentAge = $('#current_age').val();
	$( "#current_age_slider" ).slider("setValue",currentAge);
	calculateFinalResult();
}
function wealthAgeChange()
{
	var wealthAge = $('#wealth_age').val();
	$( "#wealth_age_slider" ).slider("setValue",wealthAge);
	calculateFinalResult();
}
function childAgeChange()
{
	var childAge = $('#child_age').val();
	$( "#child_age_slider" ).slider("setValue",childAge);
	calculateFinalResult();
}
function childEduAgeChange()
{
	var childEducationAge = $('#child_edu_age').val();
	$( "#child_edu_age_slider" ).slider("setValue",childEducationAge);
	calculateFinalResult();
}
function expenseYearChange()
{
	var expenseYear = $('#expense_year').val();
	$( "#expense_year_slider" ).slider("setValue",expenseYear);
	calculateFinalResult();
}
function increaseRateChange()
{
	var increaseRate = $('#inc_rate').val();
	$( "#increase_rate_slider" ).slider("setValue",increaseRate);
	calculateFinalResult();
}
function interestChange()
{
	var interest = $('#interest').val();
	$( "#interest_slider" ).slider("setValue",interest);
	calculateFinalResult();
}
function savingsAmountChange()
{
	var savingsAmount = $('#savings_amount').val();
	$( "#savings_amount_slider" ).slider("setValue",savingsAmount);
	calculateFinalResult();
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

function calculateFinalResult() 
{	

	var childAge = $('#child_age').val();
	var childEducationAge = $('#child_edu_age').val();
	var education_amount = $('#edu_amount').val();
	var currentAge = $('#current_age').val();
	var retireAge = $('#wealth_age').val();
	var wealthy_amount = $('#wel_amount').val();
	var dreamExpenseYear = $('#expense_year').val();
	var dream_amount = $('#expense_amount').val();
	var increaseRate = $('#inc_rate').val();
	var rateOfReturn = $('#interest').val();
	var investment_amount = $('#savings_amount').val();
	
	childAge = parseInt(childAge);
	childEducationAge = parseInt(childEducationAge);
	educationAmount = parseInt(education_amount);
	currentAge = parseInt(currentAge);
	retireAge = parseInt(retireAge);
	wealthyAmount = parseInt(wealthy_amount);
	dreamExpenseYear = parseInt(dreamExpenseYear);
	dreamAmount = parseInt(dream_amount);
	increaseRate = parseFloat(increaseRate,10);
	rateOfReturn = parseFloat(rateOfReturn,10);
	investmentAmount = parseInt(investmentAmount);
	
	if(retireAge<=currentAge)
	{
		advisorkhoj_alert("Please enter the wealth age not less then the current age");
		return;
	}
	if(childEducationAge<=childAge)
	{
		advisorkhoj_alert("Please enter the child education age not less then the child current age");
		return;
	}
	var total_amt = educationAmount + wealthyAmount + dreamAmount;
	if(investmentAmount>=total_amt)
	{
		advisorkhoj_alert("Please enter the savings amount less then the wealth,education and dream amount");
		return;
	}
	
	var educationAmount = 0;
	var wealthyAmount = 0;
	var dreamAmount = 0;
	var totalCurrentPrice = 0;
	var eduAgeDiff = 0;
	var welAgeDiff = 0;
	var DreAgeDiff = 0;
	var eduSavingsTarget = 0;
	var welSavingsTarget = 0;
	var dreSavingsTarget = 0;
	var totalPriceInc = 0;
	var currentAmountEdu = 0;
	var currentAmountWel = 0;
	var currentAmountDir = 0;
	var investmentAmount = 0;
	var monthlySavingsEdu = 0;
	var monthlySavingsWel = 0;
	var monthlySavingsDre = 0;
	var totalMonthlySavings = 0;

	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getCompositeFinancialGoalPlannerResult", {child_current_age : "" + childAge + "",child_education_age : "" + childEducationAge + "",education_amount : "" + education_amount + "",current_age : "" + currentAge + "",wealth_age : "" + retireAge + "",wealth_amount : "" + wealthy_amount + "",expense_amount : "" + dream_amount + "",expense_year : "" + dreamExpenseYear + "",inflation_rate : "" + increaseRate + "",expected_return : "" + rateOfReturn + "",savings_amount : "" + investment_amount + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		
		educationAmount = obj.education_amount;
		wealthyAmount = obj.wealth_amount;
		dreamAmount = obj.expense_amount;
		totalCurrentPrice = obj.total_current_value;
		eduAgeDiff = obj.final_education_year;
		welAgeDiff = obj.final_wealth_year;
		DreAgeDiff = obj.final_expense_year;
		eduSavingsTarget = obj.education_target;
		welSavingsTarget = obj.wealth_target;
		dreSavingsTarget = obj.expense_target;
		totalPriceInc = obj.total_inflation_adjust_value;
		currentAmountEdu = obj.education_savings_amount;
		currentAmountWel = obj.wealth_savings_amount;
		currentAmountDir = obj.expense_savings_amount;
		investmentAmount = obj.total_savings_amount;
		monthlySavingsEdu = obj.education_monthly_savings;
		monthlySavingsWel = obj.wealth_monthly_savings;
		monthlySavingsDre = obj.expense_monthly_savings;
		totalMonthlySavings = obj.total_monthly_savings;
	
    },'text');
	
	$('#txtResEduAmt').html(numbersWithComma(educationAmount));
	$('#txtResWelAmt').html(numbersWithComma(wealthyAmount));
	$('#txtResDreAmt').html(numbersWithComma(dreamAmount));
	$('#txtResTotalAmt').html(numbersWithComma(totalCurrentPrice));
	
	$('#txtResEduYear').html(eduAgeDiff);
	$('#txtResWelYear').html(welAgeDiff);
	$('#txtResDreYear').html(DreAgeDiff);
	rateOfReturn = parseFloat(rateOfReturn).toFixed(2);
	$('#txtResRate1').html(rateOfReturn);
	$('#txtResRate2').html(rateOfReturn);
	$('#txtResRate3').html(rateOfReturn);
	
	$('#txtResIncEduAmt').html(numbersWithComma(eduSavingsTarget));
	$('#txtResIncWelAmt').html(numbersWithComma(welSavingsTarget));
	$('#txtResIncDreAmt').html(numbersWithComma(dreSavingsTarget));
	$('#txtResIncTotalAmt').html(numbersWithComma(totalPriceInc));
	
	$('#txtResInvestEduAmt').html(numbersWithComma(currentAmountEdu));
	$('#txtResInvestWelAmt').html(numbersWithComma(currentAmountWel));
	$('#txtResInvestDreAmt').html(numbersWithComma(currentAmountDir));
	$('#txtResInvestTotalAmt').html(numbersWithComma(investmentAmount));
	
	$('#txtResMonEduAmt').html(numbersWithComma(Math.round(monthlySavingsEdu)));
	$('#txtResMonWelAmt').html(numbersWithComma(Math.round(monthlySavingsWel)));
	$('#txtResMonDreAmt').html(numbersWithComma(Math.round(monthlySavingsDre)));
	$('#txtResMonTotalAmt').html(numbersWithComma(totalMonthlySavings));
	
	var edu_invest_amount = (eduAgeDiff * 12) * Math.round(monthlySavingsEdu);
	var edu_interest_total = eduSavingsTarget - edu_invest_amount;
	var wel_invest_amount = (welAgeDiff * 12) * Math.round(monthlySavingsWel);
	var wel_interest_total = welSavingsTarget - wel_invest_amount;
	var dre_invest_amount = (DreAgeDiff * 12) * Math.round(monthlySavingsDre);
	var dre_interest_total = dreSavingsTarget - dre_invest_amount;
	
	renderChart(eduSavingsTarget,welSavingsTarget,dreSavingsTarget,edu_invest_amount,edu_interest_total,wel_invest_amount,wel_interest_total,dre_invest_amount,dre_interest_total);

} 

function saveResult() 
{		
	var childAge = $('#child_age').val();
	var childEducationAge = $('#child_edu_age').val();
	var education_amount = $('#edu_amount').val();
	var currentAge = $('#current_age').val();
	var retireAge = $('#wealth_age').val();
	var wealthy_amount = $('#wel_amount').val();
	var dreamExpenseYear = $('#expense_year').val();
	var dream_amount = $('#expense_amount').val();
	var increaseRate = $('#inc_rate').val();
	var rateOfReturn = $('#interest').val();
	var investment_amount = $('#savings_amount').val();
	
	childAge = parseInt(childAge);
	childEducationAge = parseInt(childEducationAge);
	educationAmount = parseInt(education_amount);
	currentAge = parseInt(currentAge);
	retireAge = parseInt(retireAge);
	wealthyAmount = parseInt(wealthy_amount);
	dreamExpenseYear = parseInt(dreamExpenseYear);
	dreamAmount = parseInt(dream_amount);
	increaseRate = parseFloat(increaseRate,10);
	rateOfReturn = parseFloat(rateOfReturn,10);
	investmentAmount = parseInt(investment_amount);

	var title = "Composite Goal Planner - Current age "+currentAge+" and plan to acquire wealth at age"+retireAge;
	var url = "/tools-and-calculators/composite-financial-goal-planner-calculator?child_current_age="+childAge+"&child_education_age="+childEducationAge+"&education_amount="+educationAmount+"&current_age="+currentAge+"&wealth_age="+retireAge+"&wealth_amount="+wealthy_amount+"&expense_amount="+dreamAmount+"&expense_year="+dreamExpenseYear+"&inflation_rate="+increaseRate+"&expected_return="+rateOfReturn+"&savings_amount="+investmentAmount;	
	
	
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

function renderChart(eduSavingsTarget,welSavingsTarget,dreSavingsTarget,edu_invest_amount,edu_interest_total,wel_invest_amount,wel_interest_total,dre_invest_amount,dre_interest_total)
{	
	$('#compositechart').highcharts({
	    chart: {
	        type: 'pie',
	        height:400,
	        marginTop:0
	    },
	    title: {
	        text: 'Composite Goal Planner',
	        margin:0
	    },
	    legend: {
	          borderWidth: 1,
	          borderRadius: 5,
	      },
	      credits: {
	          enabled: false
	      },
	    plotOptions: {
	        pie: {
	            shadow: false,
	            center: ['50%', '50%']
	        }
	    },
	    tooltip: {
	        formatter: function () {
	            return '<b>' + this.point.name + '</b>: Rs. ' + this.y + '';
	        }
	    },
	    series: [{
	        data: [{
	        	name: 'Education Invested Amount',
	            y: edu_invest_amount,
	            parentId: 'first',
	            color: '#0078ff',
	            legendIndex: 1
	        }, {
	        	name: 'Education Interest',
	            y: edu_interest_total,
	            parentId: 'first',
	            color: '#510084',
	            legendIndex: 2
	        }, {
	        	name: 'Wealth Invested Amount',
	            y: wel_invest_amount,
	            parentId: 'second',
	            color: '#F0272F',
	            legendIndex: 5
	        }, {
	        	name: 'Wealth Interest',
	            y: wel_interest_total,
	            parentId: 'second',
	            color: '#DD5825',
	            legendIndex: 6
	        },{
	        	name: 'Expense Invested Amount',
	            y: dre_invest_amount,
	            parentId: 'third',
	            color: '#0CD42B',
	            legendIndex: 7
	        },{
	        	name: 'Expense Interest',
	            y: dre_interest_total,
	            parentId: 'third',
	            color: '#64E572',
	            legendIndex: 8
	        }],
	        showInLegend: false,
	        size: '60%',
	        dataLabels: {
	        	enabled: false
	        },
	        showInLegend: false
	    }, {
	        showInLegend: true,
	        data: [{
	        	name: 'Education',
	            id: 'first',
	            color: '#005e96',
	            y: eduSavingsTarget,
	            legendIndex: 0
	        }, {
	        	name: 'Wealth',
	            id: 'second',
	            color: '#ee1c25',
	            y: welSavingsTarget,
	            legendIndex: 3
	        },{
	        	name: 'Expense',
	            id: 'third',
	            color: '#ffa200',
	            y: dreSavingsTarget,
	            legendIndex: 6
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
	var childAge = $('#child_age').val();
	var childEducationAge = $('#child_edu_age').val();
	var educationAmount = $('#edu_amount').val();
	var currentAge = $('#current_age').val();
	var retireAge = $('#wealth_age').val();
	var wealthyAmount = $('#wel_amount').val();
	var dreamExpenseYear = $('#expense_year').val();
	var dreamAmount = $('#expense_amount').val();
	var increaseRate = $('#inc_rate').val();
	var rateOfReturn = $('#interest').val();
	var investmentAmount = $('#savings_amount').val();
	
	var txtResTotalAmt = $("#txtResTotalAmt").html();
	var txtResEduYear = $("#txtResEduYear").html();
	var txtResWelYear = $("#txtResWelYear").html();
	var txtResDreYear = $("#txtResDreYear" ).html();
	
	var txtResIncEduAmt = $("#txtResIncEduAmt").html();
	var txtResIncWelAmt = $("#txtResIncWelAmt").html();
	var txtResIncDreAmt = $("#txtResIncDreAmt").html();
	var txtResIncTotalAmt = $("#txtResIncTotalAmt").html();
	
	var txtResInvestEduAmt = $("#txtResInvestEduAmt").html();
	var txtResInvestWelAmt = $("#txtResInvestWelAmt").html();
	var txtResInvestDreAmt = $("#txtResInvestDreAmt").html();
	var txtResInvestTotalAmt = $("#txtResInvestTotalAmt").html();
	
	var txtResMonEduAmt = $("#txtResMonEduAmt").html();
	var txtResMonWelAmt = $("#txtResMonWelAmt").html();
	var txtResMonDreAmt = $("#txtResMonDreAmt").html();
	var txtResMonTotalAmt = $("#txtResMonTotalAmt").html();
	
	educationAmount = numbersWithComma(educationAmount);
	wealthyAmount = numbersWithComma(wealthyAmount);
	dreamAmount = numbersWithComma(dreamAmount);
	investmentAmount = numbersWithComma(investmentAmount);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?childAge="+childAge+"&childEducationAge="+childEducationAge+"&educationAmount="+educationAmount+"&currentAge="+currentAge+"&retireAge="+retireAge;
		param += "&wealthyAmount="+wealthyAmount+"&dreamExpenseYear="+dreamExpenseYear+"&dreamAmount="+dreamAmount+"&increaseRate="+increaseRate+"&rateOfReturn="+rateOfReturn;
		param += "&investmentAmount="+investmentAmount+"&txtResTotalAmt="+txtResTotalAmt+"&txtResEduYear="+txtResEduYear+"&txtResWelYear="+txtResWelYear;
		param += "&txtResDreYear="+txtResDreYear+"&txtResIncEduAmt="+txtResIncEduAmt+"&txtResIncWelAmt="+txtResIncWelAmt;
		param += "&txtResIncDreAmt="+txtResIncDreAmt+"&txtResIncTotalAmt="+txtResIncTotalAmt+"&txtResInvestEduAmt="+txtResInvestEduAmt;
		param += "&txtResInvestWelAmt="+txtResInvestWelAmt+"&txtResInvestDreAmt="+txtResInvestDreAmt;
		param += "&txtResInvestTotalAmt="+txtResInvestTotalAmt+"&txtResMonEduAmt="+txtResMonEduAmt+"&txtResMonWelAmt="+txtResMonWelAmt+"&txtResMonDreAmt="+txtResMonDreAmt;
		param += "&txtResMonTotalAmt="+txtResMonTotalAmt+"&url="+calc_url;
		
		var url = '<c:url value="/downloadCompositeGoalPlannerCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post("/sendCompositeGoalPlannerCalcResult", {email : ""+email+"",childAge : ""+childAge+"",childEducationAge : ""+childEducationAge+"",educationAmount : ""+educationAmount+"",
    		currentAge : ""+currentAge+"",retireAge : ""+retireAge+"",wealthyAmount : ""+wealthyAmount+"",dreamExpenseYear : ""+dreamExpenseYear+"",dreamAmount : ""+dreamAmount+"",
    		increaseRate : ""+increaseRate+"",rateOfReturn : ""+rateOfReturn+"",investmentAmount : ""+investmentAmount+"",txtResTotalAmt : ""+txtResTotalAmt+"",
    		txtResEduYear : ""+txtResEduYear+"",txtResWelYear : ""+txtResWelYear+"",txtResIncDreAmt : ""+txtResIncDreAmt+"",
    		txtResIncTotalAmt : ""+txtResIncTotalAmt+"",txtResInvestEduAmt : ""+txtResInvestEduAmt+"",txtResInvestWelAmt : ""+txtResInvestWelAmt+"",
    		txtResInvestDreAmt : ""+txtResInvestDreAmt+"",txtResInvestTotalAmt : ""+txtResInvestTotalAmt+"",txtResMonEduAmt : ""+txtResMonEduAmt+"",
    		txtResMonWelAmt : ""+txtResMonWelAmt+"",txtResMonDreAmt : ""+txtResMonDreAmt+"",txtResMonTotalAmt : ""+txtResMonTotalAmt+"",url : ""+ calc_url +""}, function(data)
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
