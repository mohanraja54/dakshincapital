<jsp:include page="../layout/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var principal = 0;
var rate = 0;
var period = 0;
var loan_tenure_type = "";
var emi = 0;
var emi1 = 0;
var accountMap = "";

$(document).ready(function(){
	
	principal = '${loan_amount}';
	rate = '${interest_rate}';
	period = '${loan_tenure}';
	loan_tenure_type = '${loan_tenure_type}';	
	accountMap = '${accountMap}';	

	principal = parseInt(principal);
	rate = parseFloat(rate);
	period = parseFloat(period);
	loan_tenure_type = loan_tenure_type;	
	
	$('#loanamount').val(principal);
	$('#loaninterest').val(rate);
	$("input[name=term][value="+loan_tenure_type+"]").attr('checked', true);
	$('#loanterm').val(period);	
	if(loan_tenure_type == "month")
	{
		period = period / 12;
	}
	
	
	$("#pricipal_slider").slider({
        min: 100000,
        max: 10000000,
        tooltip: "hide",
        step: 1,
        value: principal
	}).on("slideStop", function(slideEvt) {
		$("#loanamount").val(slideEvt.value);
		calculateEMI();
	});
	
	$("#interest_slider").slider({
        min: 5,
        max: 20,
        tooltip: "hide",
        step: 0.1,
        value: rate
	}).on("slideStop", function(slideEvt) {
		var value = slideEvt.value;
		$("#loaninterest").val(value.toFixed(1));
		calculateEMI();
	});
	
	$("#month_slider").slider({
        min: 1,
        max: 30,
        tooltip: "hide",
        step: 0.5,
        value: period
	}).on("slideStop", function(slideEvt) {
		var term = slideEvt.value;
		var val = $('input:radio[name=term]:checked').val();
		if(val == "month")
		{
			term = term * 12;
		}
		$( "#loanterm" ).val(term);
		calculateEMI();
	});
	
	calculateEMI();
	
});

function loanAmountChange()
{
	var loanAmount = $('#loanamount').val();
	$("#pricipal_slider").slider("setValue",loanAmount);
	calculateEMI();
}
function loanInterestChange()
{
	var loanInterest = $('#loaninterest').val();
	$("#interest_slider").slider("setValue", loanInterest);
	calculateEMI();
}
function loanTermChange()
{
	var loanTerm = $('#loanterm').val();
	var val = $('input:radio[name=term]:checked').val();
	if(val == "month")
	{
		loanTerm = loanTerm / 12;
	}
	$("#month_slider").slider("setValue",loanTerm);
	calculateEMI();
}
function termChange()
{
	var period = $('#loanterm').val();
	var val = $('input:radio[name=term]:checked').val();
	if(val == "year")
	{
		period = period / 12;
	}else{
		period = period * 12;
	}
	$('#loanterm').val(period);
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
var principal = 0;
var rate = 0;
var period = 0;
var emi = 0;
var emi1 = 0;

function calculateEMI()
{
	principal = $('#loanamount').val();
	rate = $('#loaninterest').val();
	period = $('#loanterm').val();
	var val = $('input:radio[name=term]:checked').val();	
	
	principal = parseInt(principal);
	rate = parseFloat(rate,10);
	period = parseFloat(period,10);
	
	var monthly_emi = 0;
	var total_interest = 0;
	var invested_amount = 0;
	var total_amount = 0;

	$.ajaxSetup({async:false});
		$.post("/tools-and-calculators/getEMICalcResult", {loan_amount : "" + principal + "",interest_rate : "" + rate + "",loan_tenure_type : "" + val + "",loan_tenure : "" + period + ""}, function(data)
	    {
			var result = $.trim(data);
			var obj = jQuery.parseJSON(result);
			
			if(obj.status == 400)
			{
				alert(obj.msg);
				return false;
			}
			
			monthly_emi = obj.emi;
			total_interest = obj.total_interest;
			invested_amount = obj.invested_amount;
			total_amount = obj.total_amount;
			
	    },'text');
	
	emi = monthly_emi;
	emi1 = monthly_emi;
	
	if(val == "year")
	{
		period = period * 12;
	}
	
	$('#res_emi').html(numbersWithComma(emi));
	$('#res_total_interest').html(numbersWithComma(total_interest));
	$('#res_total_amount').html(numbersWithComma(total_amount));
	renderChart(principal,total_interest);
	
	var d = new Date();
	var current_year = d.getFullYear(); 
	var current_month = d.getMonth(); 
	barChartValuesPrepare(current_year,current_month);
}

function saveResult() 
{	
	
	principal = $('#loanamount').val();
	rate = $('#loaninterest').val();
	period = $('#loanterm').val();
	loan_tenure_type = $('input:radio[name=term]:checked').val();

	principal = parseInt(principal);
	rate = parseFloat(rate,10);
	period = parseFloat(period,10);
	
	var title = "Personal Loan Calculator - "+(principal/100000)+" Lakhs loan for "+period+" yrs with "+rate+"% interest ";
	var url = "/tools-and-calculators/personal-loan-emi-calculator?loan_amount="+principal+"&interest_rate="+rate+"&loan_tenure="+period+"&loan_tenure_type="+loan_tenure_type;	
	
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

function barChartValuesPrepare(current_year,current_month)
{
	var str = "";
	var years = (Math.round(period / 12))+1;
	var bal_month = 0;
	var rate_month = (rate / 100) / 12;
	var pr_month = 0;
	var inter_month = 0;
	var pr_year = 0;
	var inter_year = 0;
	var tot_year = 0;
	var bal_year = 0;
	var pr_year_end = 0;
	var inter_year_end = 0;
	var yearNameArr = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
	var yearArr = new Array();
	var principalArr = new Array();
	var interestArr = new Array();
	var balanceArr = new Array();

	str += '<table id="emi_returns" class="table table-striped table-bordered table-hover" cellspacing="0" width="100%"><thead><tr><th>&nbsp;</th><th>Year</th><th>Principal (A)</th><th>Interest (B)</th><th>Total Payment (A + B)</th><th>Balance</th></tr></thead><tbody>';
	
	for(var k=1;k<=years;k++)
	{
		var str1 = '<table id="emi_returns_inside" class="table table-striped table-bordered table-hover" cellspacing="0" width="100%"><tbody>';
		if(k==1)
		{
			for(var m=current_month;m<12;m++)
			{
				inter_month = rate_month * (principal - pr_year);
				inter_month = Math.round(inter_month);
				pr_month = emi - inter_month;
				pr_month = Math.round(pr_month);
				pr_year = pr_year + pr_month;
				inter_year = inter_year + inter_month;
				bal_month = principal - pr_year;
				bal_month = Math.round(bal_month);
				if(bal_month<0)
				{
					bal_month = 0;
				}
				var pr_month_str = numbersWithComma(pr_month);
				var inter_month_str = numbersWithComma(inter_month);
				var emi1_str = numbersWithComma(emi1);
				var bal_month_str = numbersWithComma(bal_month);
				str1 += '<tr><td>&nbsp;</td><td>'+yearNameArr[m]+'</td><td>Rs. '+pr_month_str+'</td><td>Rs. '+inter_month_str+'</td><td>Rs. '+emi1_str+'</td><td>Rs. '+bal_month_str+'</td></tr>';
			}
		}else if(k==years)
		{
			for(var m=0;m<current_month;m++)
			{
				inter_month = rate_month * (principal - pr_year);
				inter_month = Math.round(inter_month);
				pr_month = emi - inter_month;
				pr_month = Math.round(pr_month);
				pr_year = pr_year + pr_month;
				inter_year = inter_year + inter_month;
				bal_month = principal - pr_year;
				bal_month = Math.round(bal_month);
				if(bal_month<0)
				{
					bal_month = 0;
				}
				var pr_month_str = numbersWithComma(pr_month);
				var inter_month_str = numbersWithComma(inter_month);
				var emi1_str = numbersWithComma(emi1);
				var bal_month_str = numbersWithComma(bal_month);
				str1 += '<tr><td>&nbsp;</td><td>'+yearNameArr[m]+'</td><td>Rs. '+pr_month_str+'</td><td>Rs.  '+inter_month_str+'</td><td>Rs. '+emi1_str+'</td><td>Rs.  '+bal_month_str+'</td></tr>';
			}
		}else
		{
			for(var m=0;m<12;m++)
			{
				inter_month = rate_month * (principal - pr_year);
				inter_month = Math.round(inter_month);
				pr_month = emi - inter_month;
				pr_month = Math.round(pr_month);
				pr_year = pr_year + pr_month;
				inter_year = inter_year + inter_month;
				bal_month = principal - pr_year;
				bal_month = Math.round(bal_month);
				if(bal_month<0)
				{
					bal_month = 0;
				}
				var pr_month_str = numbersWithComma(pr_month);
				var inter_month_str = numbersWithComma(inter_month);
				var emi1_str = numbersWithComma(emi1);
				var bal_month_str = numbersWithComma(bal_month);
				str1 += '<tr><td>&nbsp;</td><td>'+yearNameArr[m]+'</td><td>Rs. '+pr_month_str+'</td><td>Rs. '+inter_month_str+'</td><td>Rs. '+emi1_str+'</td><td>Rs.  '+bal_month_str+'</td></tr>';
			}
		}
		str1 += '</tbody></table>';
		bal_year = principal - pr_year;
		var pr_year1 = pr_year - pr_year_end;
		inter_year = inter_year - inter_year_end;
		tot_year = pr_year1 + inter_year;
		if(bal_year<0)
		{
			bal_year = 0;
		}
		yearArr.push(current_year);
		principalArr.push(pr_year1);
		interestArr.push(inter_year);
		balanceArr.push(bal_year);
		
		var pr_year1_str = numbersWithComma(pr_year1);
		var inter_year_str = numbersWithComma(inter_year);
		var tot_year_str = numbersWithComma(tot_year);
		var bal_year_str = numbersWithComma(bal_year);
		str += '<tr><td class="toggle" onclick="toggleOpen(this)"><span class="hide">'+current_year+'</span></td><td>'+current_year+'</td><td>Rs.  '+pr_year1_str+'</td><td>Rs. '+inter_year_str+'</td><td>Rs. '+tot_year_str+'</td><td>Rs. '+bal_year_str+'</td></tr>';
		str += '<tr id="month_'+current_year+'"><td colspan="6" class="monthyearwrapper"><div style="display:none;">'+str1+'</div></td></tr>';
		current_year = current_year + 1;
		pr_year_end = pr_year;
		inter_year_end = inter_year;
	}
	str += '</tbody></table>';
	
	renderBarChart(yearArr,principalArr,interestArr,balanceArr);
	$('#emipaymenttable').html(str);
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
function tabChange(val)
{
	if(val == 1)
	{
		document.location = "/tools-and-calculators/home-loan-emi-calculator";
	}else if(val == 2)
	{
		//document.location = "/tools-and-calculators/personal-loan-emi-calculator";
	}else if(val == 3)
	{
		document.location = "/tools-and-calculators/car-loan-emi-calculator";
	}else
	{
		document.location = "/tools-and-calculators/education-loan-emi-calculator";
	}
}
function renderBarChart(yearArr,principalArr,interestArr,balanceArr)
{
	$('#emibarchart').highcharts({
        chart: {
            zoomType: 'xy',
            spacingTop: 40
        },
        title: {
            text: 'Equated Monthly Installment (EMI) Chart',
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
                text: 'Year',
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
                text: 'Balance'
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
                text: 'EMI Payment / Year'
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
			x:0
        },
		plotOptions: {
            column: {
                stacking: 'normal'
            }
        },
        series: [{
            name: 'Principal',
            color: '#76b8f4',
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
            name: 'Interest',
            color: '#a4d035',
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
            name: 'Balance',
            color: '#ff8a00',
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
function toggleOpen(parm)
{
	var res = $(parm).hasClass("toggle");
	var year = $(parm).find("span").html();
	if(res)
	{
		$(parm).removeClass("toggle");
		$(parm).addClass("toggle-open");
		$('#month_'+year+' div').show();
	}else{
		$(parm).removeClass("toggle-open");
		$(parm).addClass("toggle");
		$('#month_'+year+' div').hide();
	}
}

$(document).ready(function(){
	
    $('#datepicker').datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        disableTouchKeyboard:true,
        dateFormat: 'MM yy',
        onClose: function(dateText, inst) { 
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year, month, 1));
            initiateChart(year,month);
        },
        /* beforeShow: function() {
        	if ((selDate = $(this).val()).length > 0)
        	{
        		iYear = selDate.substring(selDate.length - 4, selDate.length);
        		iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5),
        		$(this).datepicker('option', 'monthNames'));
        		$(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
        		$(this).datepicker('setDate', new Date(iYear, iMonth, 1));
        	}
        } */
    });
    
   	var monthNames = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
	var currentYear = new Date().getFullYear();
	var currentMonth = new Date().getMonth();
	var stk = monthNames[currentMonth] + " " + currentYear;
	$( "#datepicker" ).val(stk);
	
});

function initiateChart(year,month)
{
	year = parseInt(year);
	month = parseInt(month);
	barChartValuesPrepare(year,month);
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
	var loanamount = $("#loanamount").val();
	var interest = $("#loaninterest").val();
	var period = $("#loanterm").val();
	var emi = $("#res_emi").html();
	var totalinterest = $("#res_total_interest").html();
	var totalamount = $("#res_total_amount").html();
	var val = $('input:radio[name=term]:checked').val();
	if(val == "month")
	{
		period = period / 12;
	}
	loanamount = numbersWithComma(loanamount);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var url = '<c:url value="/downloadEmiCalcResult" />?loanamount='+loanamount+"&interest="+interest+"&period="+period+"&emi="+emi+"&totalinterest="+totalinterest+"&totalamount="+totalamount+"&url="+calc_url;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
		$.post("/sendEmiCalcResult", {email : ""+email+"",loanamount : ""+loanamount+"",interest : ""+interest+"",period : ""+period+"",emi : ""+emi+"",totalinterest : ""+totalinterest+"",totalamount : ""+totalamount+"",url : ""+ calc_url +""}, function(data)
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
			<li class="active"> &nbsp;EMI Calculator</li>
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
           <h2 class="amfi-title bold">EMI CALCULATOR</h2>
			<div class="row margin-top14">
			   	<div class="col-md-7"> 
			   	
			   	
			   	
			   	<div role="tabpanel">
				  <!-- Nav tabs -->
				  <ul class="nav nav-tabs" role="tablist" id="myTab">
				    <li id="li-home" role="presentation" class="active li-emi nav-item"><a class="nav-link" href="javascript:void(0)" aria-controls="tab-1" role="tab" data-toggle="tab" onclick="tabChange(1)">Home Loan</a></li>
				    <li id="li-personal" role="presentation" class="li-emi nav-item"><a class="nav-link active" href="javascript:void(0)" aria-controls="tab-1" role="tab" data-toggle="tab" onclick="tabChange(2)">Personal Loan</a></li>
				    <li id="li-car" role="presentation" class="li-emi nav-item"><a class="nav-link" href="javascript:void(0)" aria-controls="tab-1" role="tab" data-toggle="tab" onclick="tabChange(3)">Car Loan</a></li>
				    <li id="li-education" role="presentation" class="li-emi nav-item"><a class="nav-link" href="javascript:void(0)" aria-controls="tab-1" role="tab" data-toggle="tab" onclick="tabChange(4)">Education Loan</a></li>
				  </ul>
				  <!-- Tab panes -->
				  <div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="tab-1">
				    	<div id="emi">
						<div class="inside_emi" style="margin:0px;">
						<div class="lamount">
							<div style="float:left;" id="loanamount_label"><b>Personal Loan Amount (Rs)</b></div>
							<input type="text" value="2500000" id="loanamount" maxlength="8" onchange="loanAmountChange()" />
						</div>
						<div style="clear:both;"></div>
						<div id="pricipal_slider" style="margin:0px;width:100%;">
						</div>
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
							<input type="text" value="12.5" id="loaninterest" maxlength="4" onchange="loanInterestChange()" />
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
							<div style="float:left;"><b>Loan Tenure</b></div>
							<div id="tenurechoice">
								<input type="radio" name="term" value="year" id="loanyears" onchange="termChange()" checked><label><strong>Years</strong></label>
								<input type="radio" name="term" value="month" id="loanmonths" onchange="termChange()" ><label><strong>Months</strong></label>
							</div>
							<input type="text" value="20" id="loanterm" maxlength="4" onchange="loanTermChange()" />
						</div>
						<div style="clear:both;"></div>
						<div id="month_slider" style="margin:0px;"></div>
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
						</div>
				    </div>
				  </div>
				</div> 
			
			   </div>
			   
			   <div class="col-md-5">
			   
				<div id="emipiechart"></div>
				<div id="emipaymentsummary">
					<div id="emitotalinterest">
						<h4>Monthly Payment (EMI)</h4>
						<p>Rs. <span id="res_emi"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Total Interest Payable</h4>
						<p>Rs. <span id="res_total_interest"></span></p>
					</div>
					<div id="emitotalamount">
						<h4>Total Payment (Principal + Interest)</h4>
						<p>Rs. <span id="res_total_amount"></span></p>
					</div>
				</div>
			   	</div>
			   	
			   <!-- 	<div class="col-md-12 text-right">
				  <a href="javascript:void(0)" id="calc_btn_submit" class="btn btn-warning ladda-button mutual-funds-submit-anchor marginTop20" onclick="saveResult()" data-style="expand-right" data-size="l"><span class="ladda-label">Save Result</span></a>
				</div> -->
			   
				</div>
				
								<div class="row">
			   	<div class="col-md-12">  
					<div class="chart_calendar">
					<span>Schedule showing EMI payments starting from</span>
					<input type="text" id="datepicker">
					</div>
			   	</div>
			   	</div>
			   	
			   	<div class="row">
			   	<div class="col-md-12">  
					<div id="emibarchart"></div>
			   	</div>
			   	</div>
			   	
			   	<div class="row">
			   	<div class="col-md-12">  
			   		<div class="table-responsive" id="emipaymenttable">
					</div>
			   	</div>
			   	</div>
			   	
			   	<div class="row">
			   	<div class="col-md-12">  
					<div class="entry-content">
					<h2 class="entry-title">What is EMI?</h2>
					<p>Equated Monthly Installment &ndash; EMI for short &ndash; is the amount payable every month to the bank or any other financial institution 
					until the loan amount is fully paid off. It consists of the interest on loan as well as part of the principal amount to be repaid. 
					The sum of principal amount and interest is divided by the tenure, i.e., number of months, in which the loan has to be repaid. 
					This amount has to be repaid monthly. The interest component of the EMI would be larger in the initial months and gradually reduce when 
					compared to the principal amount. The exact percentage allocated towards payment of the principal depends on the interest rate. 
					Even though your monthly EMI payment won't change, the proportion of principal and interest components will change with time.&nbsp;With each 
					successive payment, you'll pay more towards the principal and less in interest.</p>
					<p>Here's the formula to calculate EMI:</p>
					<p><img class="img-responsive" src="/resources/images/common/emiformula.png" alt="EMI Formula" title="EMI Formula"></p>
					<p>where</p><p><strong>E</strong> is EMI</p><p><strong>P</strong> is Principal Loan Amount</p>
					<p><strong>r</strong> is rate of interest calculated on monthly basis. (i.e., r = Rate of Annual interest/12/100. If rate of interest is 10.5% per annum, 
					then r = 10.5/12/100=0.00875)</p><p><strong>n</strong> is loan term / tenure / duration in number of months</p>
					<p>For example, if you borrow 
					RS. 10,00,000 from the bank at 10.5% annual interest for a period of 10 years (i.e., 120 months), then EMI = 
					RS. 10,00,000 *&nbsp;0.00875 * (1 + 0.00875)<sup>120</sup> / ((1 + 0.00875)<sup>120</sup> &ndash; 1) = 
					RS. 13,493. i.e., you will have to pay 
					RS. 13,493 for 120 months to repay the entire loan amount. The total amount payable will be 
					RS. 13,493 * 120 = RS. 16,19,220 that includes 
					RS. 6,19,220 as interest toward the loan.</p>
					<p>Computing EMI for different combinations of principal loan amount, interest rates and loan 
					term using the above EMI formula
					by hand is time consuming, complex and error prone. Our EMI calculator automates this calculation for you and gives you the result in a split 
					second along with visual charts displaying payment schedule and the break-up of total payment.</p>
					<h2 class="entry-title">How to use EMI calculator?</h2>
					<p style="text-align: left;">With colourful charts and instant results, our EMI calculator is easy to use, intuitive to understand and is quick to 
					perform. You can calculate EMI for home loan, car loan, personal loan, education loan or any other fully amortizing loan using this calculator.</p>
					<p>Enter the following information in the EMI calculator:</p>
					<ul style="list-style:disc inside none;">
					<li>Principal loan amount you wish to avail (rupees)</li><br />
					<li>Loan term (months or years)</li><br />
					<li>Rate of interest (percentage)</li><br />
					<li>EMI in advance OR EMI in arrears (for car loan only)</li>
					</ul>
					<p>Use the slider to adjust the values in the EMI calculator form. If you need to enter more precise values, you can type the values directly 
					in the relevant boxes provided above. As soon as the values are changed using the slider (or hit the 'tab' key after entering the values directly 
					in the input fields), EMI calculator will re-calculate your monthly payment (EMI) amount.</p><p>A pie chart depicting the break-up of total 
					payment (i.e., total principal vs. total interest payable) is also displayed. It displays the percentage of total interest versus principal amount 
					in the sum total of all payments made against the loan. The payment schedule table showing payments made every month / year&nbsp;for the entire loan 
					duration is displayed along with a chart showing interest and principal components paid each year. A portion of each payment is for the interest while 
					the remaining amount is applied towards the principal balance. During initial loan period, a large portion of each payment is devoted to interest. With 
					passage of time, larger portions pay down the principal. The payment schedule also shows the intermediate outstanding balance for each year which will 
					be carried over to the next year.</p>
					<h2 class="entry-title">Floating Rate EMI Calculation</h2><p>We suggest that you calculate floating / variable rate EMI by taking into 
					consideration two opposite scenarios, i.e., optimistic (deflationary) and pessimistic (inflationary) scenario. Loan amount and loan tenure, two 
					components required to calculate the EMI are under your control; i.e., you are going to decide how much loan you have to borrow and how long your 
					loan tenure should be. But interest rate is decided by the banks &amp; HFCs based on rates and policies set by 
					RBI. As a borrower, you should consider the two extreme 
					possibilities of increase and decrease in the rate of interest and calculate how much would be your EMI under these two conditions. 
					Such calculation will help you decide how much EMI is affordable, how long your loan tenure should be and how much you should borrow.</p><p>
					<strong>Optimistic (deflationary) scenario</strong>: Assume that the rate of interest comes down by 1% &ndash; 3% from the present rate. Consider 
					this situation and calculate your EMI. In this situation, your EMI will come down or you may opt to shorten the loan tenure. Ex: If you avail home 
					loan to purchase a house as an investment, then optimistic scenario enables you to compare this with other investment opportunities.</p>
					<p><strong>Pessimistic (inflationary) scenario</strong>: In the same way, assume that the rate of interest is hiked by 1% &ndash; 3%. Is it possible 
					for you to continue to pay the EMI without much struggle? Even a 2% increase in rate of interest can result in significant rise in your monthly payment 
					for the entire loan tenure.</p><p>Such calculation helps you to plan for such future possibilities. When you take a loan, you are making a financial 
					commitment for next few months, years or decades. So consider the best as well as worst cases... and be ready for both. In short, hope for the best but 
					be prepared for the worst!</p>
					</div>
			   	</div>
			   	</div>
	       </div>

     </div>
	</div>
</section>
<!-- main-container end -->
<jsp:include page="../layout/footer.jsp"></jsp:include>