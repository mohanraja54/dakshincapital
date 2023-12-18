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
			<li class="active"> &nbsp;Systematic Investment Plan Calculator</li>
		</ol>
	</div>
</div> -->
<!-- breadcrumb end -->

<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container-fluid pt-4 pb-4 pr-0 pr-lg-4 pl-0">
		<div class="row">
           
           <div class="col-md-3">          
              <jsp:include page="../sidebar/calc-sidebar.jsp"></jsp:include>             
           </div>
           
           <div class="col-md-9 marginBottom35">
           		<h2 class="amfi-title bold">Systematic Investment Plans Calculator</h2>
				<div class="row margin-top14">
					<div class="col-md-7 col-lg-7 col-sm-12">
						<div id="emi" class="mt-2">
							<div class="inside_emi">
								<div class="lamount">
									<div style="float:left;"><b>How much you can invest through monthly SIP? (Rs)</b></div>
									<input type="text" value="25000" id="sipamount" maxlength="6" onchange="amountChange()" />
								</div>
								
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
							
							<div class="inside_emi">
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
							
							<div class="inside_emi">
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
						</div>
					</div>
					
					<div class="col-md-5 col-lg-5 col-sm-12">
   					   	<div id="emipiechart" class="mt-2"></div>
						<div id="emipaymentsummary">
							<div id="emitotalinterest">
								<h4>Total SIP Amount Invested</h4>
								<p>Rs. <span id="res_amount_invest"></span></p>
							</div>
							<div id="emitotalinterest">
								<h4>Total Growth</h4>
								<p>Rs. <span id="res_total_interest"></span></p>
							</div>
							<div id="emitotalamount">
								<h4>Total Future Value<br />(Your SIP Investment Amount + Growth)</h4>
								<p>Rs. <span id="res_total_amount"></span></p>
							</div>
						</div>
				   	</div>
				  </div>
				   	<div class="row">
				   	<div class="col-md-12">  
						<div class="chart_calendar">
						<span>Schedule showing SIP Investments starting from</span>
						<input type="text" id="datepicker" style="padding-left: 10px;">
						</div>
				   	</div>
			   	</div>
			   	
			   	<div class="row">
				   	<div class="col-md-12">  
						<div id="emibarchart"></div>
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
							<div style="margin:20px auto;text-align:center;"><img src="/resources/images/common/SIP-Table-1.png" alt="SIP Table" title="SIP Table" /></div>
							<p>(Example - SIP of Rs. 1000/- in HDFC Top 200 fund (growth) on 2nd of every month from 2nd Jan13 to 2nd Dec13 and the total investment value is Rs. 13,079.69 as on 1st Jan14)</p>
							<p>From the above example you can see that every month the investor is getting different number of units as the NAVs are different, but the average price is only Rs. 265.72 due to rupee cost averaging. </p>
							<p>Now, let us examine what would have happened had the investor put in 12,000 as lumpsum on 2nd Jan13 instead of doing a SIP of Rs.1000 per month? Lets us see the results below -</p>
							<div style="margin:20px auto;text-align:center;"><img src="/resources/images/common/SIP-Table-2.png" alt="SIP Table" title="SIP Table" /></div>
							<p>You can clearly see that the investor is gaining more by opting for the SIP route and the return for him works out to 17.0800 (XIRR). </p>
						</div>
				   		
				   	</div>
				</div>
	       </div>

     </div>
	</div>
</section>
<!-- main-container end -->
<script type="text/javascript">

var sip_amount = "";
var interest_rate = "";
var period = "";
var accountMap = "";

$(document).ready(function(){
	
	sip_amount = '${sip_amount}';
	interest_rate = '${interest_rate}';
	period = '${period}';
	
	sipAmount = parseInt(sip_amount);
	rateofReturn = parseFloat(interest_rate);
	sipMonth = parseInt(period);
	
	$('#sipamount').val(sipAmount);
	$('#sipinterest').val(rateofReturn);
	$('#sipmonth').val(sipMonth);
	
	accountMap = '${accountMap}';	
	
	$("#amount_slider").slider({
        min: 0,
        max: 100000,
        tooltip: "show",
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
        tooltip: "show",
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
        tooltip: "show",
        step: 0.1,
        precision: 1,
        value: rateofReturn
	}).on("slideStop", function(slideEvt) {
		var term = slideEvt.value;
		var val = $('input:radio[name=term]:checked').val();
		if(val == "month")
		{
			term = term * 12;
		}
		$( "#sipinterest" ).val(term);
		calculateSIP();
	});

	calculateSIP();
	
	$('#datepicker').datepicker({
        changeYear: true,
        showButtonPanel: true,
        disableTouchKeyboard:true,
        dateFormat: 'yy',
        onClose: function(dateText, inst) { 
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year));
            initiateChart(year, 0);
        }
    });
    
    $("#datepicker").focus(function () {
        $(".ui-datepicker-month").hide();
    });
    
	var currentYear = new Date().getFullYear();
	$( "#datepicker" ).val(currentYear);
});


var download_text = "";
function downloadResult()
{
	download_text = "download";
	$("#send_email_model").modal('show');
}

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

function calculateSIP()
{
	var sipAmount = $('#sipamount').val();
	var rateofReturn = $('#sipinterest').val();
	var sipMonth = $('#sipmonth').val();
	
	sipAmount = parseInt(sipAmount);
	sipMonth = parseInt(sipMonth);
	rateofReturn = parseFloat(rateofReturn,10);
	
	var invested_amount = 0;
	var growth_value = 0;
	var maturity_amount = 0;
	
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getSIPCalcResult", {sip_amount : "" + sipAmount + "",interest_rate : "" + rateofReturn + "",period : "" + sipMonth + ""}, function(data)
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
		
    },'text');
	
    $('#res_amount_invest').html(numbersWithComma(invested_amount));
    $('#res_total_interest').html(numbersWithComma(growth_value));
	$('#res_total_amount').html(numbersWithComma(maturity_amount));
	renderChart(invested_amount, growth_value);
	
	var d = new Date();
	var current_year = d.getFullYear(); 
	var current_month = d.getMonth();
	barChartValuesPrepare(current_year,current_month,sipAmount);
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

function renderBarChart(yearArr,principalArr,interestArr,balanceArr)
{
	$('#emibarchart').highcharts({
        chart: {
            zoomType: 'xy',
            spacingTop: 40
        },
        title: {
            text: 'Systematic Investment Plan (SIP) Growth Chart',
            align: 'center',
            y: -30,
            style: {
				fontSize: '13px',
				fontWeight: 600
            }
        },
        legend: {
            borderWidth: 1,
            borderRadius: 5,
        },
        credits: {
            enabled: false
        },
        xAxis: [{
        	 title: {
                 text: 'Year'
             },
            categories: yearArr,
			tickColor: 'black',
	        tickLength: 5,
	        tickWidth: 1,
	        tickPosition: 'outside',
	        lineWidth:1,
	      	lineColor:'black'
        }],
        yAxis: [{ // Primary yAxis
            title: {
                text: 'Total SIP Value'
            },
			 labels: {
                //format: '$ {value}'
            },
			min: 0,
		   	tickColor: 'black',
	        tickLength: 5,
	        tickWidth: 1,
	        tickPosition: 'outside',
	        lineWidth:1,
	      	lineColor:'black'
        }, { // Secondary yAxis
            title: {
                text: 'SIP Investment'
            },
            labels: {
                //format: '$ {value}'
            },
            opposite: true,
			min: 0,
			tickColor: 'black',
	        tickLength: 5,
	        tickWidth: 1,
	        tickPosition: 'outside',
	        lineWidth:1,
	      	lineColor:'black'
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'horizontal',
            align: 'right',
            verticalAlign: 'top',
            floating: true,
            backgroundColor: '#FFFFFF',
			x:0,
			itemStyle: {
		        color: '#000000',
		        fontWeight: 'bold',
		        fontSize: '12px'
		    }
        },
		plotOptions: {
            column: {
                stacking: 'normal'
            }
        },
        series: [{
            name: 'SIP Investment',
            color: '#005e96',
            type: 'column',
            yAxis: 1,
            data: principalArr,
            tooltip: {
                valuePrefix: 'Rs. '
            },
			index:1,
        	legendIndex:0

        },
		{
            name: 'Growth',
            color: '#ee1c25',
            type: 'column',
            yAxis: 1,
            data: interestArr,
            tooltip: {
                valuePrefix: 'Rs. '
            },
			index:0,
        	legendIndex:1

        }, 
		{
            name: 'Total SIP Value',
            color: '#ffa200',
            type: 'spline',
            data: balanceArr,
            tooltip: {
                valuePrefix: 'Rs. '
            },
			index:2,
        	legendIndex:2
        }]
    });
}

function saveResult() 
{	
	
	var sipAmount = $('#sipamount').val();
	var rateofReturn = $('#sipinterest').val();
	var sipMonth = $('#sipmonth').val();
	
	sipAmount = parseInt(sipAmount);
	sipMonth = parseInt(sipMonth);
	rateofReturn = parseFloat(rateofReturn,10);
	
	var title = "SIP Calculator - "+sipAmount+" mly for "+sipMonth+" months @"+rateofReturn+"% return";
	var url = "/tools-and-calculators/systematic-investment-plan-calculator?sip_amount="+sipAmount+"&interest_rate="+rateofReturn+"&period="+sipMonth;	
	
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


function barChartValuesPrepare(current_year, current_month, sipamounts)
{
	var years = sipMonth / 12;
	var mon = 12;
	var yearArr = new Array();
	var principalArr = new Array();
	var interestArr = new Array();
	var balanceArr = new Array();

	for(var k=1;k<=years;k++)
	{
		var value1 = (rateofReturn / 100) / 12;
	    var value3 = 1 + value1;
		var value4 = Math.pow((value3), (mon + 1));
	    var amount1 = (value4 - 1);
	    var amount2 = amount1 / value1;
	    var final_amount = (sipamounts * amount2) - sipamounts;
	    final_amount = Math.round(final_amount);
	    var invest_amount = sipamounts * mon;
	    var interest_total = final_amount - invest_amount;
	    yearArr.push(current_year);
		principalArr.push(invest_amount);
		interestArr.push(interest_total);
		balanceArr.push(final_amount);
		current_year = current_year + 1;
		mon = mon + 12;
	}
	renderBarChart(yearArr,principalArr,interestArr,balanceArr);
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
		   	
		    var page = "SIP Calculator - "+download_text;
		    
		    $.ajaxSetup({async:false});
			$.post("/subscribeForEmail", {email : "" + email + "", user_type : "" + radio_value + "", page : "" + page + "" }, function(data)
		    {
		    }, "text");
		    
		    init_download(email);
		}
    });
}]);

</script>