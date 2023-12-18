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
			<li class="active"> &nbsp;Employees Provident Fund (EPF) Calculator</li>
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
           		<h2 class="amfi-title bold">Employees Provident Fund (EPF) Calculator</h2>
								<div class="row margin-top14">
			   	<div class="col-md-12"> 
			   	<div class="table-responsive mt-2" id="input_table">
			   	<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;">
			   	<tbody>
				<tr>
					<td width="50%">
					    Your Current Age (in years)
					</td>
					<td width="30%">
						<div class="form-group"> 
			            	<input style="width:96%;" id="txtAge" maxlength="2" type="text" class="float-left form-control no-radius width220 marginRight5" placeholder="Enter the age"><span style="padding-left:3px;" class="color-khojorange"> *</span>
			          	</div>
					</td>
				</tr>
				<tr id="ppf_year_row">
					<td width="50%">
					    Your Retirement Age (in years)
					</td>
					<td width="30%">
						<div class="form-group"> 
			            	<input style="width:96%;" id="txtRage" maxlength="2" type="text" class="float-left form-control no-radius width220 marginRight5" placeholder="Enter the age"><span style="padding-left:3px;" class="color-khojorange"> *</span>
			          	</div>
					</td>
				</tr>
				<tr>
				    <td width="50%">
				        <span id="spnInvestText">Your Current EPF Balance (Rs.)</span>
				    </td>
				    <td width="30%">
				    	<div class="form-group"> 
			            	<input style="width:96%;" id="txtEPF" maxlength="7" type="text" class="float-left form-control no-radius width220 marginRight5" placeholder="Enter the amount"><span style="padding-left:3px;" class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td width="50%">
				        <span id="spnInvestText">Your Employee Contribution per month (Rs.)</span>
				    </td>
				    <td width="30%">
				    	<div class="form-group"> 
			            	<input style="width:96%;" id="txtEmpC" maxlength="6" type="text" class="float-left form-control no-radius width220 marginRight5" placeholder="Enter the amount"><span style="padding-left:3px;" class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td width="50%">
				        <span id="spnInvestText">Your Employer Contribution per month (Rs.)</span>
				    </td>
				    <td width="30%">
				    	<div class="form-group"> 
			            	<input style="width:96%;" id="txtEmprC" maxlength="6" type="text" class="float-left form-control no-radius width220 marginRight5" placeholder="Enter the amount"><span style="padding-left:3px;" class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td width="50%">
				        <span id="spnInvestText">Your Growth Rate in EPF Contribution (% per annum)</span>
				    </td>
				    <td width="30%">
				    	<div class="form-group"> 
			            	<input style="width:96%;" id="txtGrthRate" maxlength="4" type="text" class="float-left form-control no-radius width220 marginRight5" placeholder="Enter the growth rate"><span style="padding-left:3px;" class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td width="50%">
				        <span id="spnInvestText">Your Rate of Interest (% per annum)</span>
				    </td>
				    <td width="30%">
				    	<div class="form-group"> 
			            	<input style="width:96%;" id="txtRate" maxlength="4" type="text" class="float-left form-control no-radius width220 marginRight5" placeholder="Enter the rate of interest"><span style="padding-left:3px;" class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td width="50%">
				        <span id="spnInvestText">Your Current Pension Fund Balance (Rs.)</span>
				    </td>
				    <td width="30%">
				    	<div class="form-group"> 
			            	<input style="width:96%;" id="txtCPF" maxlength="7" type="text" class="float-left form-control no-radius width220 marginRight5" placeholder="Enter the amount"><span style="padding-left:3px;" class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr id="submit_btn_row">
				    <td colspan="2"><div class="text_center"><a onclick="calcEPF()" class="btn btn-info" href="javascript:void(0)">Submit</a></div></td>
				</tr>
				</tbody>
				</table>
				</div>
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
var accountMap = "";

$(document).ready(function(){
	
	var age = '${age}';
	var RetAge = '${RetAge}';
	var EPF = '${EPF}';
	var EmpC = '${EmpC}';
	var EmprC = '${EmprC}';
	var GrthRate = '${GrthRate}';
	var Rate = '${Rate}';
	var CPF = '${CPF}';
	accountMap = '${accountMap}';	
	
    $('#txtAge').val(age);
    $('#txtRage').val(RetAge);
    $('#txtEPF').val(EPF);
    $('#txtEmpC').val(EmpC);
    $('#txtEmprC').val(EmprC);
    $('#txtGrthRate').val(GrthRate);
    $('#txtRate').val(Rate);
    $('#txtCPF').val(CPF);
    
    calcEPF();
	
});

function calcEPF() 
{
    var age = $('#txtAge').val();
    var RetAge = $('#txtRage').val();
    var EPF = $('#txtEPF').val();
    var EmpC = $('#txtEmpC').val();
    var EmprC = $('#txtEmprC').val();
    var GrthRate = $('#txtGrthRate').val();
    var Rate = $('#txtRate').val();
    var CPF = $('#txtCPF').val();
    
    if(age == "" || isNaN(age))
	{
		alert("Current age cannot be blank or enter valid number format");
		return;
	}
    if(RetAge == "" || isNaN(RetAge))
	{
		alert("Retirement age cannot be blank or enter valid number format");
		return;
	}
    if(EPF == "" || isNaN(EPF))
	{
    	EPF = 0;
	}
    if(EmpC == "" || isNaN(EmpC))
	{
    	alert("Employee contribution per month cannot be blank or enter valid number format");
		return;
	}
    if(EmprC == "" || isNaN(EmprC))
	{
    	alert("Employer contribution per month cannot be blank or enter valid number format");
		return;
	}
   	if(GrthRate == "" || isNaN(GrthRate))
	{
   		GrthRate = 0;
	}
    if(Rate == "" || isNaN(Rate))
	{
    	alert("Rate of interest cannot be blank or enter valid number format");
		return;
	}
    if(CPF == "" || isNaN(CPF))
	{
    	CPF = 0;
	}
	age = Math.round(parseInt(age));
    RetAge = Math.round(parseInt(RetAge));
    EPF = parseFloat(EPF).toFixed(4);
    EmpC = parseFloat(EmpC).toFixed(4);
    EmprC = parseFloat(EmprC).toFixed(4);
    GrthRate = parseFloat(GrthRate).toFixed(4);
    Rate = parseFloat(Rate).toFixed(4);
    CPF = parseFloat(CPF).toFixed(4);

	var current_age = "";
	var opening_epf_balance = "";
	var employee_contribution = "";
	var employer_contribution = "";
	var closing_epf_balance = "";
	var pension_fund_value = "";
	var ageArr = new Array();
    var balanceArr = new Array();   
	var tabl = '<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;"><thead><tr><th colspan="9"><div class="text_center">Result</div></th></tr><tr><th>Age</th><th>Opening EPF Balance</th><th>Employee Contribution (p.m.)</th><th>Employer Contribution (p.m.)</th><th>Closing EPF Balance</th><th>Diverted to Pension Fund (Rs. 541 p.m.)</th></tr></thead><tbody>';

    $.ajaxSetup({async:false});
   	$.post("/tools-and-calculators/getEPFCalcResult", {current_age : "" + age + "",retirement_age : "" + RetAge + "",epf_balance : "" + EPF + "",employee_contibution : "" + EmpC + "",employer_contibution : "" + EmprC + "",epf_growth_rate : "" + GrthRate + "",interest_rate : "" + Rate + "",pension_fund_balance : "" + CPF + ""}, function(data)
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
			current_age = array[k].age;
			opening_epf_balance = array[k].opening_epf_balance;
			employee_contribution = array[k].employee_contribution;
			employer_contribution = array[k].employer_contribution;
			closing_epf_balance = array[k].closing_epf_balance;
			pension_fund_value = array[k].pension_fund_value;
			
			tabl = tabl + "<tr><td>" + current_age + "</td><td>" + numberForamt(opening_epf_balance,0,true,true,-1) + "</td>";
			tabl = tabl + "<td>" + numberForamt(employee_contribution,0,true,true,-1) + "</td>";
			tabl = tabl + "<td>" + numberForamt(employer_contribution,0,true,true,-1) + "</td>";
	        tabl = tabl + "<td>" + numberForamt(closing_epf_balance,0,true,true,-1) + "</td>";
	        tabl = tabl + "<td>" + numberForamt(pension_fund_value,0,true,true,-1) +"</td></tr>";
	        
	        ageArr.push(current_age);
	        balanceArr.push(Number(closing_epf_balance.toFixed(0)));
		}
   		
       },'text');
   	
   	tabl = tabl + "</tbody></table>";
    $('#result').html(tabl);   	
    $(".result_btn").show();
    renderBarChart(ageArr,balanceArr);
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
function saveResult() 
{	
	var age = $('#txtAge').val();
    var RetAge = $('#txtRage').val();
    var EPF = $('#txtEPF').val();
    var EmpC = $('#txtEmpC').val();
    var EmprC = $('#txtEmprC').val();
    var GrthRate = $('#txtGrthRate').val();
    var Rate = $('#txtRate').val();
    var CPF = $('#txtCPF').val();
	
	var title = "EPF Calculator";
	var url = "/tools-and-calculators/employees-provident-fund-calculator?age="+age+"&RetAge="+RetAge+"&EPF="+EPF+"&EmpC="+EmpC+"&EmprC="+EmprC+"&GrthRate="+GrthRate+"&Rate="+Rate+"&CPF="+CPF;
	
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
function renderBarChart(ageArr,balanceArr)
{	
	$("#emibarchart").show();
	$('#emibarchart').highcharts({
        chart: {
            zoomType: 'xy',
            spacingTop: 60
        },
        title: {
            text: 'EPF Growth Chart',
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
                 text: 'Age'
             },
            categories: ageArr,
			tickColor: 'black',
	        tickLength: 5,
	        tickWidth: 1,
	        tickPosition: 'outside',
	        lineWidth:1,
	      	lineColor:'black'
        }],
        yAxis: [{ // Primary yAxis
            title: {
                text: 'Closing EPF Balance'
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
                text: 'Closing EPF Balance'
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
        tooltip: {
        	formatter:function(){
        		var amount_comma = this.y;
        		var amount_comma_separated = amount_comma.toLocaleString();        		
                return 'Age:'+ this.key +'<br>Closing EPF Balance: Rs. '+amount_comma_separated;
                }
        },
        series: [{
            name: 'Closing EPF Balance',
            color: '#005e96',
            type: 'column',
            yAxis: 1,
            data: balanceArr,            
			index:1,
        	legendIndex:0

        },		
		]
    });	 
}
</script>
