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
			<li class="active"> &nbsp;Public Provident Fund (PPF) Calculator</li>
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
           <h2 class="amfi-title bold">Public Provident Fund (PPF) Calculator</h2>
			<div class="row margin-top14">
			   	<div class="col-md-12"> 
			   	<div class="table-responsive mt-2" id="input_table">
			   	<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;">
			   	<tbody>
				<tr>
					<td width="50%">
					    Choose an option for PPF Investments
					</td>
					<td width="30%">
						<div class="form-group">
			            <select style="width:96%;height:38px;" id="ddlInvestmentType" onchange="changeText()" class="no-radius">              
			            <option value="1">Fixed Investment</option>
					    <option value="2">Variable Investment</option>
			            </select>
			            <span class="color-khojorange"> *</span>
			          	</div> 
					</td>
				</tr>
				<tr>
					<td width="50%">In which year did you open your PPF account?</td>
					<td width="30%">
						<div class="form-group"> 
			            	<input style="width:96%;height:38px;" id="txtYear" maxlength="4" type="text" class="float-left form-control no-radius width220 marginRight5" placeholder="Enter the year eg 2014"><span class="color-khojorange" style="padding-left: 3px;"> *</span>
			          	</div>
					</td>
				</tr>
				<tr id="ppf_year_row">
				    <td width="50%">Enter investment amount (Rs)</td>
				    <td width="30%">
				    	<div class="form-group"> 
			            	<input style="width:96%;height:38px;" id="txtInvestAmount" maxlength="6" type="text" class="float-left form-control no-radius width220 marginRight5" placeholder="Enter the amount"><span class="color-khojorange" style="padding-left: 3px;"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr id="submit_btn_row">
				    <td colspan="2"><div class="text_center"><a onclick="calculateFinalAmount()" class="btn btn-info" href="javascript:void(0)">Submit</a></div></td>
				</tr>
				</tbody>
				</table>
				</div>
				<div class="table-responsive" id="step3"></div>
				<div class="table-responsive" id="result"></div>
				<!-- <div class="col-md-12 text-center marginBottom40 result_btn">
				<a href="javascript:void(0)" id="calc_btn_submit" class="btn btn-warning ladda-button mutual-funds-submit-anchor marginTop20" onclick="saveResult()" data-style="expand-right" data-size="l"><span class="ladda-label">Save Result</span></a>
				</div> -->
				<div id="emibarchart" style="display:none;"></div>
			    	
			   	</div>
				</div>
	       </div>

     </div>
	</div>
</section>
<!-- main-container end -->
<script type="text/javascript">
var investment_type = 1;
var year = 2010;
var investment_amount = 2000;
var accountMap = "";

$(document).ready(function(){
	investment_type = '${investment_type}';
	year = '${start_year}';
	investment_amount = '${amount}';
	accountMap = '${accountMap}';	
	
	investment_type = parseInt(investment_type);
	year = parseInt(year);
	
	$("#ddlInvestmentType").val(investment_type);
	//$("#ddlInvestmentType").selectpicker("refresh");
		
	if(investment_type == 1)
	{
		$("#txtYear").val("");
		$("#txtInvestAmount").val("");
		$("#ppf_year_row").show();
		$("#result").html("");
		$(".result_btn").hide();
		$("#submit_btn_row").show();
		$("#step3").html("");
		$("#txtYear").attr("disabled", false);
		$("#emibarchart").hide();
		$("#txtYear").val(year);
		investment_amount = parseInt(investment_amount);
		$("#txtInvestAmount").val(investment_amount);
		
		calculateInvestment(investment_amount, 0);
	}else
	{
		$("#txtYear").val("");
		$("#txtInvestAmount").val("");
		$("#ppf_year_row").hide();
		$("#result").html("");
		$(".result_btn").hide();
		$("#submit_btn_row").show();
		$("#step3").html("");
		$("#txtYear").attr("disabled", false);
		$("#emibarchart").hide();
		$("#txtYear").val(year);
		
		var amt_array = investment_amount.split(",");
		var nn = 0;
		var years = year;
		years = parseInt(years);
		$("#submit_btn_row").hide();
		$("#txtYear").attr("disabled","disabled");
		var str="";	
		str+='<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;"><thead><tr><th colspan="3"><div class="text_center">Please enter the amount in each year.</div></th></tr></thead><tbody><tr>';
		var k=0;
		var Yr=new Array();
		Yr[0]=Number(years);
		var current_year = new Date().getFullYear();
		
		for(var y=0;y<16;y++)
		{
			if(Number(Yr[y]+1) > Number(current_year))
			{
				break;
			}
			Yr[y+1]=Number(Yr[y]+1);
		}
		
		for(var i=1;i<6;i++)
		{
			if((Number(Yr[k]) > Number(current_year)) || Yr[k] == undefined)
			{
				continue;
			}
			str+="<tr>";
			for(var j=0;j<3;j++)
			{
				if((Number(Yr[k]) > Number(current_year)) || Yr[k] == undefined)
				{
					str+='<td></td>';
				}else
				{
					var id='txtY'+k;
					str+='<td><div class="form-group"><span class="float-left width50 marginTop10" id=spnY'+k+'>'+Yr[k]+'</span><input id="'+id+'" value="'+amt_array[nn]+'" maxlength="6" type="text" class="float-left form-control no-radius marginRight5" style="width:180px;" placeholder="Enter the amount"><span class="color-khojorange"> *</span></div></td>';
					nn++;
				}
				k=k+1;
			}
			str+="</tr>";
		}
		str+='<tr><td colspan="3"><div class="text_center"><a onclick="calculateInvestment(500,1)" class="btn btn-info" href="javascript:void(0)">Submit</a></div></td></tr>';
		str+="</tbody></table>";
		$("#step3").html(str);
		
		calculateInvestment(500, 1);
	}
	
});

function changeText()
{
	var investmentType = $("#ddlInvestmentType option:selected").val();
	if(parseInt(investmentType) == 1)
	{
		$("#txtYear").val("");
		$("#txtInvestAmount").val("");
		$("#ppf_year_row").show();
		$("#result").html("");
		$(".result_btn").hide();
		$("#submit_btn_row").show();
		$("#step3").html("");
		$("#txtYear").attr("disabled", false);
		$("#emibarchart").hide();
	}else
	{
		$("#txtYear").val("");
		$("#txtInvestAmount").val("");
		$("#ppf_year_row").hide();
		$("#result").html("");
		$(".result_btn").hide();
		$("#submit_btn_row").show();
		$("#step3").html("");
		$("#txtYear").attr("disabled", false);
		$("#emibarchart").hide();
	}
}
function calculateFinalAmount()
{
	var investmentType = $("#ddlInvestmentType option:selected").val();
	if(parseInt(investmentType) == 1)
	{
		var years = $("#txtYear").val();
		var investAmount = $("#txtInvestAmount").val();
		
		if(years == "" || isNaN(years))
		{
			alert("PPF open year cannot be blank or enter valid number format");
			return;
		}
		if(years.length!=4)
		{
			alert("Please enter correct year");
			return false;
		}
		years = parseInt(years);
		if(years < 1980 || years > 2014)
		{
			alert("Please enter year between 1980 to 2014");
			return false;
		}		
		if(investAmount == "" || isNaN(investAmount))
		{
			alert("Investment amount cannot be blank or enter valid number format");
			return;
		}
		investAmount = parseInt(investAmount);
		if(investAmount > 150000 || investAmount < 500)
		{
			alert("Investment amount should be greater than 500 and not exceed 1,50,000");
			return;
		}
		if(investAmount > 70000 && years < 2011)
		{
			alert("You should not enter more than 70000 limit before 2011");
			return false;
		}
		calculateInvestment(investAmount, 0);
	}else
	{
		var years = $("#txtYear").val();
		
		if(years == "" || isNaN(years))
		{
			alert("PPF open year cannot be blank or valid number format");
			return;
		}
		if(years.length!=4)
		{
			alert("Please enter correct year format");
			return false;
		}
		years = parseInt(years);
		if(years < 1980 || years > 2014)
		{
			alert("Please enter year between 1980 to 2014");
			return false;
		}
		
		$("#submit_btn_row").hide();
		$("#txtYear").attr("disabled","disabled");
		var str="";	
		str+='<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;"><thead><tr><th colspan="3"><div class="text_center">Please enter the amount in each year.</div></th></tr></thead><tbody><tr>';
		var k=0;
		var Yr=new Array();
		Yr[0]=Number(years);
		var current_year = new Date().getFullYear();
		
		for(var y=0;y<16;y++)
		{
			if(Number(Yr[y]+1) > Number(current_year))
			{
				break;
			}
			Yr[y+1]=Number(Yr[y]+1);
		}
		
		for(var i=1;i<6;i++)
		{
			if((Number(Yr[k]) > Number(current_year)) || Yr[k] == undefined)
			{
				continue;
			}
			str+="<tr>";
			for(var j=0;j<3;j++)
			{
				if((Number(Yr[k]) > Number(current_year)) || Yr[k] == undefined)
				{
					str+='<td></td>';
				}else
				{
					var id='txtY'+k;
					str+='<td><div class="form-group"><span class="float-left width50 marginTop10" id=spnY'+k+'>'+Yr[k]+'</span><input id="'+id+'" maxlength="6" type="text" class="float-left form-control no-radius marginRight5" style="width:180px;" placeholder="Enter the amount"><span class="color-khojorange"> *</span></div></td>';
				}
				k=k+1;
			}
			str+="</tr>";
		}
		str+='<tr><td colspan="3"><div class="text_center"><a onclick="calculateInvestment(500,1)" class="btn btn-info" href="javascript:void(0)">Submit</a></div></td></tr>';
		str+="</tbody></table>";
		$("#step3").html(str);
	}
}
function numberForamt(num,decimalNum,bolLeadingZero,bolParens,bolCommas)
{
	if(isNaN(parseInt(num)))
	return num;
	var tmpNum=num;
	var iSign=num<0?-1:1;
	tmpNum*=Math.pow(10,decimalNum);
	tmpNum=Math.round(Math.abs(tmpNum))
	tmpNum/=Math.pow(10,decimalNum);
	tmpNum*=iSign;
	var tmpNumStr=new String(tmpNum);
	if(!bolLeadingZero&&num<1&&num>-1&&num!=0)
	if(num>0)
	tmpNumStr=tmpNumStr.substring(1,tmpNumStr.length);
	else
	tmpNumStr="-"+tmpNumStr.substring(2,tmpNumStr.length);
	if(bolCommas&&(num>=1000||num<=-1000))
	{
		var iStart=tmpNumStr.indexOf(".");if(iStart<0)
		iStart=tmpNumStr.length;iStart-=3;
		while(iStart>=1)
		{
			tmpNumStr=tmpNumStr.substring(0,iStart)+","+tmpNumStr.substring(iStart,tmpNumStr.length)
			iStart-=3;
		}
	}
	if(bolParens&&num<0)
	tmpNumStr="("+tmpNumStr.substring(1,tmpNumStr.length)+")";return tmpNumStr;
}
function calculateInvestment(investAmount,value)
{
	var amount_array = new Array();
	if(value == 1)
	{
		var IAmt = new Array();
		var Year = new Array();
		for(var a=0;a<15;a++)
		{
			if($('#txtY'+a).length == 0)
			{
				break;
			}
			var amt = $('#txtY'+a).val();
			var amt_year = $('#spnY'+a).html();
			if(amt == "" || isNaN(amt))
			{
				alert("Investment Amount for the year "+amt_year+" cannot be left blank or enter valid number format");
				return;
			}
			amt = parseInt(amt);
			amt_year = parseInt(amt_year);
			if(amt > 150000 || amt < 500)
			{
				alert("The investment amount for the year "+amt_year+" should be greater than 500 and not exceed 1,50,000");
				return;
			}
			if(amt > 70000 && amt_year < 2011)
			{
				alert("The investment amount for the year "+amt_year+" should be less than 70,000");
				return;
			}
			IAmt[a] = amt;
			Year[a] = amt_year;
			amount_array.push(amt);
		}
	}else
	{
		amount_array.push(investAmount);
	}
	var str = "";
	str+='<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;"><thead><tr><th colspan="9"><div class="text_center">Result</div></th></tr><tr><th>Year</th><th>Interest Rate (%)</th><th>Opening Balance (Rs.)</th><th>Annual Investment (Rs.)</th><th>Total Investment (Rs.)</th><th>Interest (Rs.)</th><th>Closing Balance (Rs.)</th><th>Premature Withdrawal Limit (Rs.)</th><th>Loan Possible (Rs.)</th></tr></thead><tbody>';
	
	var years = $("#txtYear").val();
	var current_year = new Date().getFullYear();
	var year_array = new Array();
	var invested_amount_array = new Array();
	var interest_array = new Array();
	var cbal_array = new Array();	
	
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getPPFCalcResult", {ppf_type : "" + value + "",ppf_start_year : "" + years + "",amount_array : "" + amount_array + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		
		var list = obj.list;
		var array = $.makeArray(list);
		
		for(var k=0;k<array.length;k++)
		{
			var year = array[k].year;
			var interest_rate = array[k].interest_rate;
			var opening_balance = array[k].opening_balance;
			var investment_amount = array[k].investment_amount;
			var total_investment_amount = array[k].total_investment_amount;
			var interest = array[k].interest;
			var closeing_balance = array[k].closeing_balance;
			var withdrawal = array[k].withdrawal;
			var loan_value = array[k].loan_value;
			
			if(Number(year) > Number(current_year))
			{
				continue;
			}
			
			year_array.push(year);
			invested_amount_array.push(Number(total_investment_amount.toFixed(0)));
			interest_array.push(Number(interest.toFixed(0)));
			cbal_array.push(Number(closeing_balance.toFixed(0)));	
			
			str+="<tr>";
			if(loan_value == 0)
			{
				loan_value = "--";
			}
			if(withdrawal == 0)
			{
				withdrawal = "--";
			}
			str+="<td>"+year+"</td>";
			str+="<td>"+interest_rate.toFixed(2)+"</td>";
			str+="<td>"+numberForamt(opening_balance,0,true,true,-1)+"</td>";
			str+="<td>"+numberForamt(investment_amount,0,true,true,-1)+"</td>";
			str+="<td>"+numberForamt(total_investment_amount,0,true,true,-1)+"</td>";
			str+="<td>"+numberForamt(interest,0,true,true,-1)+"</td>";
			str+="<td>"+numberForamt(closeing_balance,0,true,true,-1)+"</td>";
			str+="<td>"+numberForamt(withdrawal,0,true,true,-1)+"</td>";
			str+="<td>"+numberForamt(loan_value,0,true,true,-1)+"</td>";
			str+="</tr>";
		}
		
		
    },'text');
	
	str+="</tbody></table>";
	$("#result").html(str);
	$(".result_btn").show();
	
	renderBarChart(year_array,invested_amount_array,interest_array,cbal_array);
}
function saveResult() 
{	
	var investmentType = $("#ddlInvestmentType option:selected").val();
	var years = $("#txtYear").val();
	var amount_array = new Array();
	
	if(investmentType == 1)
	{
		var investAmount = $("#txtInvestAmount").val();
		amount_array.push(investAmount);
	}else
	{
		var IAmt = new Array();
		var Year = new Array();
		for(var a=0;a<15;a++)
		{
			if($('#txtY'+a).length == 0)
			{
				break;
			}
			var amt = $('#txtY'+a).val();
			var amt_year = $('#spnY'+a).html();
			
			amt = parseInt(amt);
			amt_year = parseInt(amt_year);
			
			IAmt[a] = amt;
			Year[a] = amt_year;
			amount_array.push(amt);
		}
	}
	
	var title = "PPF Calculator - Fixed and variable investments";
	var url = "/tools-and-calculators/provident-fund-calculator?investment_type="+investmentType+"&start_year="+years+"&amount="+amount_array;
	
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
function renderBarChart(yearArr,principalArr,interestArr,balanceArr)
{	
	$("#emibarchart").show();
	$('#emibarchart').highcharts({
        chart: {
            zoomType: 'xy',
            spacingTop: 40
        },
        title: {
            text: 'PPF Growth Chart',
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
                text: 'Closing Balance'
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
                text: 'Total Investment'
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
            name: 'Total Investment',
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
            name: 'Closing Balance',
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
</script>
