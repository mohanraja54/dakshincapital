<jsp:include page="../layout/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">

var sip_amount = "";
var interest_rate = "";
var period = "";
var sip_stepup_value = "";
var accountMap = "";

$(document).ready(function(){

	sip_amount = '${sip_amount}';
	interest_rate = '${interest_rate}';
	period = '${period}';
	sip_stepup_value = '${sip_stepup_value}';
	
	sipAmount = parseInt(sip_amount);
	rateofReturn = parseFloat(interest_rate);
	sipMonth = parseInt(period);
	sipstepup = parseInt(sip_stepup_value);
	
	$('#sipamount').val(sipAmount);
	$('#sipinterest').val(rateofReturn);
	$('#sipmonth').val(sipMonth);
	$('#sipstepup').val(sipstepup);
	
	accountMap = '${accountMap}';	
	
	$("#amount_slider").slider({
        min: 0,
        max: 100000,
        tooltip: "hide",
        step: 1,
        precision: 0,
        value: sipAmount
	}).on("slideStop", function(slideEvt) {
		$("#sipamount").val(slideEvt.value);
		calculateSIP();
	});
	
	$("#month_slider").slider({
        min: 0,
        max: 450,
        tooltip: "hide",
        step: 1,
        precision: 0,
        value: sipMonth
	}).on("slideStop", function(slideEvt) {
		$("#sipmonth").val(slideEvt.value);
		calculateSIP();
	});
	
	$("#interest_slider").slider({
        min: 5,
        max: 20,
        tooltip: "hide",
        step: 0.1,
        precision: 1,
        value: rateofReturn
	}).on("slideStop", function(slideEvt) {
		var value = slideEvt.value;
		value = Math.round(value * 100) / 100;
		$( "#sipinterest" ).val(value);
		calculateSIP();
	});
	
	$("#stepup_slider").slider({
        min: 0,
        max: 60,
        tooltip: "hide",
        step: 1,
        precision: 0,
        value: sipstepup
	}).on("slideStop", function(slideEvt) {
		var value = slideEvt.value;
		value = Math.round(value * 100) / 100;
		$( "#sipstepup" ).val(value);
		calculateSIP();
	});

	calculateSIP();
	
});

function amountChange()
{
	var amount = $('#sipamount').val();
	$( "#amount_slider" ).slider("setValue",amount);
	calculateSIP();
}
function interestChange()
{
	var interest = $('#sipinterest').val();
	$( "#interest_slider" ).slider("setValue",interest);
	calculateSIP();
}
function stepUpChange()
{
	var stepup = $('#sipstepup').val();
	$( "#stepup_slider" ).slider("setValue",stepup);
	calculateSIP();
}
function monthChange()
{
	var month = $('#sipmonth').val();
	$( "#month_slider" ).slider("setValue", month);
	calculateSIP();
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
/* var sipAmount = 0;
var rateofReturn = 0;
var sipMonth = 0;
var sipstepup = 0; */

function calculateSIP()
{
	var sipAmount = $('#sipamount').val();
	var rateofReturn = $('#sipinterest').val();
	var sipMonth = $('#sipmonth').val();
	var sipstepup = $('#sipstepup').val();
	
	sipAmount = parseInt(sipAmount);
	sipMonth = parseInt(sipMonth);
	rateofReturn = parseFloat(rateofReturn,10);
	sipstepup = parseFloat(sipstepup,10);

	var invested_amount = 0;
	var growth_value = 0;
	var maturity_amount = 0;
	var stepup_invested_amount = 0;
	var stepup_growth_value = 0;
	var stepup_maturity_amount = 0;
	var html = "";
    html += '<table class="adv-table table table-striped table-bordered"><thead><tr><th>Year</th><th>SIP Amount / Month</th><th>Invested Amount / Year</th><th>Total Invested Amount</th></tr></thead><tbody>';
	
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getSIPCalcStepUpResult", {sip_amount : "" + sipAmount + "",interest_rate : "" + rateofReturn + "",period : "" + sipMonth + "",sip_stepup_value : "" + sipstepup + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		
		invested_amount = obj.invested_amount;
		growth_value = obj.growth_value;
		maturity_amount = obj.maturity_amount;
		stepup_invested_amount = obj.stepup_invested_amount;
		stepup_growth_value = obj.stepup_growth_value;
		stepup_maturity_amount = obj.stepup_maturity_amount;
		var list = obj.list;
		var array = $.makeArray(list);
		
		for(var k=0;k<array.length;k++)
		{
			var year = array[k].year;
			var sip_amount_per_month = array[k].sip_amount_per_month;
			var invested_amount_per_year = array[k].invested_amount_per_year;
			var total_invested_amount = array[k].total_invested_amount;
			
			html += '<tr><td>'+year+'</td><td>'+numbersWithComma(sip_amount_per_month)+'</td><td>'+numbersWithComma(invested_amount_per_year)+'</td><td>'+numbersWithComma(total_invested_amount)+'</td></tr>';
		}
		
    },'text');
	
	html += '</tbody></table>';
	
    $('#res_amount_invest').html(numbersWithComma(invested_amount));
    $('#res_total_interest').html(numbersWithComma(growth_value));
	$('#res_total_amount').html(numbersWithComma(maturity_amount));
	
	$('#res_amount_invest_stepup').html(numbersWithComma(stepup_invested_amount));
    $('#res_total_interest_stepup').html(numbersWithComma(stepup_growth_value));
	$('#res_total_amount_stepup').html(numbersWithComma(stepup_maturity_amount));
	
	$('#summary_div').html(html);
	
 	renderChart(invested_amount, growth_value); 

}

function saveResult() 
{	
	
	var sipAmount = $('#sipamount').val();
	var rateofReturn = $('#sipinterest').val();
	var sipMonth = $('#sipmonth').val();
	var sipstepup = $('#sipstepup').val();
	
	sipAmount = parseInt(sipAmount);
	sipMonth = parseInt(sipMonth);
	rateofReturn = parseFloat(rateofReturn,10);
	sipstepup = parseFloat(sipstepup,10);
	
	var title = "SIP Step UP Calculator - "+sipAmount+" mly for "+sipMonth+" months @"+rateofReturn+"% return and "+sipstepup+"% annual increase";
	var url = "/tools-and-calculators/mutual-fund-sip-calculator-step-up?sip_amount="+sipAmount+"&interest_rate="+rateofReturn+"&period="+sipMonth+"&sip_stepup_value="+sipstepup;		
	
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
      tooltip: {
  	    pointFormat: '{point.percentage:.1f}%'
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
              ['Total SIP Amount Invested', amount],
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
	var sipamount = $('#sipamount').val();
	var sipinterest = $('#sipinterest').val();
	var sipmonth = $('#sipmonth').val();
	
	var invest_amount = $('#res_amount_invest').html();
	var interest_total = $('#res_total_interest').html();
	var final_amount = $('#res_total_amount').html();
	
	sipamount = numbersWithComma(sipamount);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?sipamount="+sipamount+"&sipinterest="+sipinterest+"&sipmonth="+sipmonth;
		param += "&invest_amount="+invest_amount+"&interest_total="+interest_total+"&final_amount="+final_amount+"&url="+calc_url;
		
		var url = '<c:url value="/downloadSIPCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post("/sendSIPCalcResult", {email : ""+email+"",sipamount : ""+sipamount+"",sipinterest : ""+sipinterest+"",sipmonth : ""+sipmonth+"",
    		invest_amount : ""+invest_amount+"",interest_total : ""+interest_total+"",final_amount : ""+final_amount+"",url : ""+ calc_url +""}, function(data)
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
			<li class="active"> &nbsp;Mutual Fund Sip Calculator Step Up</li>
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
           		<h2 class="amfi-title bold">MUTUAL FUND SIP CALCULATOR STEP UP</h2>
				<div class="row margin-top14">
			   	<div class="col-md-7"> 
			   	
			   	<div id="emi">
				<div class="inside_emi" style="margin:0px;">
				<div class="lamount">
					<div style="float:left;"><b>How much you can invest through monthly SIP? (Rs)</b></div>
					<input type="text" value="25000" id="sipamount" maxlength="6" onchange="amountChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="amount_slider" style="margin:0px;"></div>
				<div class="steps" id="loanamountsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">0</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">25k</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">50k</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">75k</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">1 Lakh</span></span>
				</div>
				</div>
				<div class="small_line" style="margin:0px;"></div>
				<div class="inside_emi" style="margin:0px;">
				<div class="sep lint"> 
					<div style="float:left;"><b>How many months will you continue the SIP?</b></div>
					<input type="text" value="120" id="sipmonth" maxlength="3" onchange="monthChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="month_slider" style="margin:0px;"></div>
				<div class="steps" id="loantermsteps">
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">0</span></span><span style="left: 16.66%;" class="tick">|<br />
					<span class="marker">75</span></span><span style="left: 33.33%;" class="tick">|<br />
					<span class="marker">150</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">225</span></span><span style="left: 66.66%;" class="tick">|<br />
					<span class="marker">300</span></span><span style="left: 83.33%;" class="tick">|<br />
					<span class="marker">375</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">450</span></span>
				</div>
				</div>
				<div class="small_line" style="margin:0px;"></div>
				<div class="inside_emi" style="margin:0px;">
				<div class="sep lint"> 
					<div style="float:left;"><b>What rate of return do you expect? (% per annum)</b></div>
					<input type="text" value="12.5" id="sipinterest" maxlength="4" onchange="interestChange()" />
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
					<div style="float:left;"><b>How much percentage step up monthly SIP? (% per annum)</b></div>
					<input type="text" value="10" id="sipstepup" maxlength="2" onchange="stepUpChange()" />
				</div>
				<div style="clear:both;"></div>
				<div id="stepup_slider" style="margin:0px;"></div>
				<div class="steps">		
					<span style="left: 0%;" class="tick">|<br />
					<span class="marker">0</span></span><span style="left: 25%;" class="tick">|<br />
					<span class="marker">15</span></span><span style="left: 50%;" class="tick">|<br />
					<span class="marker">30</span></span><span style="left: 75%;" class="tick">|<br />
					<span class="marker">45</span></span><span style="left: 100%;" class="tick">|<br />
					<span class="marker">60</span></span>
					
				</div>
				</div>
				
				</div>
				
			   </div>
			   
			   	<div class="col-md-5">
			   
			   	<div id="emipiechart"></div>
				<div id="emipaymentsummary">
					<div id="emitotalinterest">
						<h4>Total SIP Amount Invested with out step up</h4>
						<p>Rs. <span id="res_amount_invest"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Total Growth with out step up</h4>
						<p>Rs. <span id="res_total_interest"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Total Future Value<br />(Your SIP Investment Amount + Growth) with out step up</h4>
						<p>Rs. <span id="res_total_amount"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Total SIP Amount Invested with step up</h4>
						<p>Rs. <span id="res_amount_invest_stepup"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Total Growth with step up</h4>
						<p>Rs. <span id="res_total_interest_stepup"></span></p>
					</div>
					<div id="emitotalamount">
						<h4>Total Future Value<br />(Your SIP Investment Amount + Growth) with step up</h4>
						<p>Rs. <span id="res_total_amount_stepup"></span></p>
					</div>
				</div>
			   	</div>
			   
			   <!-- <div class="col-md-12 text-right">
				  <a href="javascript:void(0)" id="calc_btn_submit" class="btn btn-warning ladda-button mutual-funds-submit-anchor marginTop20" onclick="saveResult()" data-style="expand-right" data-size="l"><span class="ladda-label">Save Result</span></a>
				</div> -->
			   
				</div>
				
				<div class="row">
			   	<div class="col-md-12 marginTop15">  
					<h4>SIP Calculator Step Up Amount Invested Summary</h4>
					<div class="table-responsive marginTop15" id="summary_div">
					</div>
			   	</div>
			   	</div>
			   	
			   	<div class="row padding-top40">
			   	<div class="col-md-12">  
			   	
			   		<div class="entry-content">
					<h2 class="entry-title margin-bottom20">What is SIP (Systematic Investment Plan)?</h2>
					<p>A SIP is a vehicle offered by Mutual Funds which help investors invest regularly through a step by step approach to investing. It works just like recurring deposits with the bank or post office where you put in a small amount every month. The only difference is that in case of Mutual Funds it is invested in the market. The minimum amount to be invested can be as small as  100 and the frequency of investment is usually monthly or quarterly.</p>
					<h2 class="entry-title margin-bottom20">Benefits of SIP</h2>
					<p>Inculcates Savings Habit - It inculcates a habit of investing as you commit a fixed amount and invest it systematically every month or quarter. </p>
					<p>Flexibility - Starting a SIP or closing the same is very easy and there is no penalty for foreclosure.</p>
					<p>Wide choice - you get a wide choice of Mutual Fund schemes and also asset management companies</p>
					<p>Convenient - You need not go to the AMC office or deposit a cheque every month. All you have to do is sign an auto debt / ECS form and the amount will be deducted from your bank account on the date chosen for SIP</p>
					<p>Low investment amount - You can start a SIP in India with as low as Rs.100 per month</p>
					<p>Diversification - Starting a SIP in an equity mutual fund allows you to take advantage of investing in equities and diversify your risk across companies, sectors and markets etc. Further diversification of the risk can be done by investing on various dates in a month</p>
					<p>Helps achieve your goals - SIPs help you achieve your future financial goals, like - Retirement, Children higher education, Marriage of your children and so on. You can actually set a target amount based on your goal and achieve the same over a period of time by investing a small amount every month. You can also decide the amount of SIP based on your financial goal.  </p>
					<p>Free Insurance - There are some schemes / AMCs who offer insurance cover upto as high as 100 times of your SIP amount without charging anything extra for this. </p>
					<p>Tax Savings - By opting for s SIP in an ELSS scheme you can save taxes too under section 80C. This way not only you save tax in a disciplined manner, you also benefit by rupee cost averaging. However, there will be a lock-in period of 3 years for ELSS schemes for each of your investments.</p>
					<p>Helps in compounding - By <a href="<c:url value='/articles/Wealth-Creation/Why-you-should-start-investing-early'/>" target="_blank">starting early</a> and saving regularly for a longer period of time helps you getting the benefit of <a href="http://www.advisorkhoj.com/articles/Personal-Finance/How-Compound-interest-works" target="_blank">compounding return</a>. </p>
					<p>Rupee cost averaging - A simple approach to long term investing is discipline and commitment to invest a fixed sum for a fixed period and sticking to this schedule regardless of the market conditions. Rupee cost averaging, as this practice is called, in a way ensures that you automatically buy more units when the NAV is low and fewer units when the NAV is high. Let us understand this from a real example of a SIP done in HDFC Top 200 Fund (Growth) for 12 months for Rs. 1000 a month -</p>
					<div style="margin:20px auto;text-align:center;"><img src="/resources/images/common/SIP-Table-1.png" alt="SIP Table" title="SIP Table" style="width:100%;" /></div>
					<p>(Example - SIP of Rs. 1000/- in HDFC Top 200 fund (growth) on 2nd of every month from 2nd Jan13 to 2nd Dec13 and the total investment value is Rs. 13,079.69 as on 1st Jan14)</p>
					<p>From the above example you can see that every month the investor is getting different number of units as the NAVs are different, but the average price is only Rs. 265.72 due to rupee cost averaging. </p>
					<p>Now, let us examine what would have happened had the investor put in 12,000 as lumpsum on 2nd Jan13 instead of doing a SIP of Rs.1000 per month? Lets us see the results below -</p>
					<div style="margin:20px auto;text-align:center;"><img src="/resources/images/common/SIP-Table-2.png" alt="SIP Table" title="SIP Table" style="width:100%;" /></div>
					<p>You can clearly see that the investor is gaining more by opting for the SIP route and the return for him works out to 17.0800 (XIRR). </p>
					</div>
			   		
			   	</div>
			   	</div>
	       </div>

     </div>
	</div>
</section>
<!-- main-container end -->
<jsp:include page="../layout/footer.jsp"></jsp:include>