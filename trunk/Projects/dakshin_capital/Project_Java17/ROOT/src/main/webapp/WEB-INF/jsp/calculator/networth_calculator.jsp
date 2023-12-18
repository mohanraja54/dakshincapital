<jsp:include page="../layout/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style type="text/css">
#assetchart {
    border: 1px solid #DDDDDD;
    float: left;
    height: 547px;
    overflow: hidden;
    width: 100%;
    margin-bottom:20px;
    text-align:center;
}
#emipaymentsummary {
    border: 1px solid #DDDDDD;
    float: left;
    width: 100%;
}
#emitotalinterest {
    border-bottom: 1px dotted #DBDAD7;
    padding: 10px;
    text-align: center;
}
#emitotalamount {
    padding: 10px;
    text-align: center;
}
#emipaymentsummary h4 {
    color: #888888;
    font-size:14px;
    margin-bottom:10px;
    font-family: 'proxima_nova_rgregular';
}
#emipaymentsummary p {
    font-size: 18px;
    font-weight: bold;
    margin:0px;
    font-family:arial;
}
.centerPageH1{
	margin-bottom:20px;
}
.slider {
    margin-top: 20px;
}
.download_calc{
	padding:10px;
	text-align:center;
}
.marginRight5 {
    margin-right: 5px !important;
}
.float-left {
    float: left;
}
</style>

<script type="text/javascript">

var shares_equity_value = "";
var fixed_income_value = "";
var cash_value = "";
var property_value = "";
var gold_value = "";
var other_assets_value = "";
var home_loan_value = "";
var personal_other_loan_value = "";
var income_tax_value = "";
var outstanding_bill_value = "";
var credit_card_due_value = "";
var other_liabilities_value = "";
var accountMap = "";

$(document).ready(function(){

	shares_equity_value = '${shares_equity_value}';
	fixed_income_value = '${fixed_income_value}';
	cash_value = '${cash_value}';
	property_value = '${property_value}';
	gold_value = '${gold_value}';
	other_assets_value = '${other_assets_value}';
	home_loan_value = '${home_loan_value}';
	personal_other_loan_value = '${personal_other_loan_value}';
	income_tax_value = '${income_tax_value}';
	outstanding_bill_value = '${outstanding_bill_value}';
	credit_card_due_value = '${credit_card_due_value}';
	other_liabilities_value = '${other_liabilities_value}';
	accountMap = '${accountMap}';	
	
	shares_assets = parseInt(shares_equity_value);
	fixed_income_assets = parseInt(fixed_income_value);
	cash_bank_assets = parseInt(cash_value);
	property_assets = parseInt(property_value);
	gold_assets = parseInt(gold_value);
	others_assets = parseInt(other_assets_value);	
	home_loan = parseInt(home_loan_value);
	personal_loan = parseInt(personal_other_loan_value);
	income_tax = parseInt(income_tax_value);
	outstanding_bills = parseInt(outstanding_bill_value);
	credit_card = parseInt(credit_card_due_value);
	other_liabilities = parseInt(other_liabilities_value);
	
	$( "#shares_assets_txt" ).val(shares_assets);
	$( "#fixed_income_assets_txt" ).val(fixed_income_assets);
	$( "#cash_bank_assets_txt" ).val(cash_bank_assets);
	$( "#property_assets_txt" ).val(property_assets);
	$( "#gold_assets_txt" ).val(gold_assets);
	$( "#others_assets_txt" ).val(others_assets);
	$( "#home_loan_txt" ).val(home_loan);
	$( "#personal_loan_txt" ).val(personal_loan);
	$( "#income_tax_txt" ).val(income_tax);
	$( "#outstanding_bills_txt" ).val(outstanding_bills);
	$( "#credit_card_txt" ).val(credit_card);
	$( "#other_liabilities_txt" ).val(other_liabilities);
	
	calulate_assets();
});

var shares_assets = "";
var fixed_income_assets = "";
var cash_bank_assets = "";
var property_assets = "";
var gold_assets = "";
var others_assets = "";
var home_loan = "";
var personal_loan = "";
var income_tax = "";
var outstanding_bills = "";
var credit_card = "";
var other_liabilities = "";
var total_assets = "";
var total_liabillities = "";
var total_networth = "";

function calulate_assets()
{
	shares_assets = $( "#shares_assets_txt" ).val();
	fixed_income_assets = $( "#fixed_income_assets_txt" ).val();
	cash_bank_assets = $( "#cash_bank_assets_txt" ).val();
	property_assets = $( "#property_assets_txt" ).val();
	gold_assets = $( "#gold_assets_txt" ).val();
	others_assets = $( "#others_assets_txt" ).val();
	home_loan = $( "#home_loan_txt" ).val();
	personal_loan = $( "#personal_loan_txt" ).val();
	income_tax = $( "#income_tax_txt" ).val();
	outstanding_bills = $( "#outstanding_bills_txt" ).val();
	credit_card = $( "#credit_card_txt" ).val();
	other_liabilities = $( "#other_liabilities_txt" ).val();
	
	shares_assets = $.trim(shares_assets);
	fixed_income_assets = $.trim(fixed_income_assets);
	cash_bank_assets = $.trim(cash_bank_assets);
	property_assets = $.trim(property_assets);
	gold_assets = $.trim(gold_assets);
	others_assets = $.trim(others_assets);
	
	home_loan = $.trim(home_loan);
	personal_loan = $.trim(personal_loan);
	income_tax = $.trim(income_tax);
	outstanding_bills = $.trim(outstanding_bills);
	credit_card = $.trim(credit_card);
	other_liabilities = $.trim(other_liabilities);
	
	if(shares_assets == "" || !validateNumbersOnly(shares_assets) || shares_assets < 0)
	{
		alert("Please enter the correct value of Shares & Equity Mutual Funds assets");
		return false;
	}
	if(fixed_income_assets == "" || !validateNumbersOnly(fixed_income_assets) || fixed_income_assets < 0)
	{
		alert("Please enter the correct value of Fixed Income assets");
		return false;
	}
	if(cash_bank_assets == "" || !validateNumbersOnly(cash_bank_assets) || cash_bank_assets < 0)
	{
		alert("Please enter the correct value of Cash and Bank Accounts assets");
		return false;
	}
	if(property_assets == "" || !validateNumbersOnly(property_assets) || property_assets < 0)
	{
		alert("Please enter the correct value of Property assets");
		return false;
	}
	if(gold_assets == "" || !validateNumbersOnly(gold_assets) || gold_assets < 0)
	{
		alert("Please enter the correct value of Gold and Jewelleries assets");
		return false;
	}
	if(others_assets == "" || !validateNumbersOnly(others_assets) || others_assets < 0)
	{
		alert("Please enter the correct value of Others assets");
		return false;
	}
	if(home_loan == "" || !validateNumbersOnly(home_loan) || home_loan < 0)
	{
		alert("Please enter the correct value of Home Loan");
		return false;
	}
	if(personal_loan == "" || !validateNumbersOnly(personal_loan) || personal_loan < 0)
	{
		alert("Please enter the correct value of Personal & other Loans");
		return false;
	}
	if(income_tax == "" || !validateNumbersOnly(income_tax) || income_tax < 0)
	{
		alert("Please enter the correct value of Income Tax owed");
		return false;
	}
	if(outstanding_bills == "" || !validateNumbersOnly(outstanding_bills) || outstanding_bills < 0)
	{
		alert("Please enter the correct value of Outstanding bills / payments");
		return false;
	}
	if(credit_card == "" || !validateNumbersOnly(credit_card) || credit_card < 0)
	{
		alert("Please enter the correct value of Credit Card dues");
		return false;
	}
	if(other_liabilities == "" || !validateNumbersOnly(other_liabilities) || other_liabilities < 0)
	{
		alert("Please enter the correct value of Other liabilities");
		return false;
	}
	
	shares_assets = parseInt(shares_assets);
	fixed_income_assets = parseInt(fixed_income_assets);
	cash_bank_assets = parseInt(cash_bank_assets);
	property_assets = parseInt(property_assets);
	gold_assets = parseInt(gold_assets);
	others_assets = parseInt(others_assets);
	
	home_loan = parseInt(home_loan);
	personal_loan = parseInt(personal_loan);
	income_tax = parseInt(income_tax);
	outstanding_bills = parseInt(outstanding_bills);
	credit_card = parseInt(credit_card);
	other_liabilities = parseInt(other_liabilities);
	
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getNetworthCalcResult", {shares_equity_value : "" + shares_assets + "",fixed_income_value : "" + fixed_income_assets + "",cash_value : "" + cash_bank_assets + "",property_value : "" + property_assets + "",gold_value : "" + gold_assets + "",property_value : "" + property_assets + "",other_assets_value : "" + others_assets + "",home_loan_value : "" + home_loan + "",personal_other_loan_value : "" + personal_loan + "",income_tax_value : "" + income_tax + "",outstanding_bill_value : "" + outstanding_bills + "",credit_card_due_value : "" + credit_card + "",other_liabilities_value : "" + other_liabilities + ""}, function(data)
    {
		
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		
		total_assets = obj.total_assets;
		total_liabillities = obj.total_liabillities;
		total_networth = obj.total_networth;

    },'text');
	
	$( "#res_total_assets" ).html(numbersWithComma(total_assets));
	$( "#res_total_liabilities" ).html(numbersWithComma(total_liabillities));
	$( "#res_total_networth" ).html(numbersWithComma(total_networth));
	
    renderChart();
}

function saveResult() 
{	
	shares_assets = $( "#shares_assets_txt" ).val();
	fixed_income_assets = $( "#fixed_income_assets_txt" ).val();
	cash_bank_assets = $( "#cash_bank_assets_txt" ).val();
	property_assets = $( "#property_assets_txt" ).val();
	gold_assets = $( "#gold_assets_txt" ).val();
	others_assets = $( "#others_assets_txt" ).val();
	home_loan = $( "#home_loan_txt" ).val();
	personal_loan = $( "#personal_loan_txt" ).val();
	income_tax = $( "#income_tax_txt" ).val();
	outstanding_bills = $( "#outstanding_bills_txt" ).val();
	credit_card = $( "#credit_card_txt" ).val();
	other_liabilities = $( "#other_liabilities_txt" ).val();
	
	shares_assets = parseInt(shares_assets);
	fixed_income_assets = parseInt(fixed_income_assets);
	cash_bank_assets = parseInt(cash_bank_assets);
	property_assets = parseInt(property_assets);
	gold_assets = parseInt(gold_assets);
	others_assets = parseInt(others_assets);
	
	home_loan = parseInt(home_loan);
	personal_loan = parseInt(personal_loan);
	income_tax = parseInt(income_tax);
	outstanding_bills = parseInt(outstanding_bills);
	credit_card = parseInt(credit_card);
	other_liabilities = parseInt(other_liabilities);
	
	var title = "Networth Calculator - Total Assets "+(total_assets/100000)+" Lakh and Liabilities "+(total_liabillities/100000)+" Lakhs networth "+(total_networth/100000)+" Lakhs";
	var url = "/tools-and-calculators/networth-calculator?shares_equity_value="+shares_assets+"&fixed_income_value="+fixed_income_assets+"&cash_value="+cash_bank_assets+"&property_value="+property_assets+"&gold_value="+gold_assets+"&other_assets_value="+others_assets+"&home_loan_value="+home_loan+"&personal_other_loan_value="+personal_loan+"&income_tax_value="+income_tax+"&outstanding_bill_value="+outstanding_bills+"&credit_card_due_value="+credit_card+"&other_liabilities_value="+other_liabilities;	
	
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

function renderChart()
{
	$('#assetchart').highcharts({
	    chart: {
	        type: 'pie',
	        marginTop:0,
	        marginBottom:0
	    },
	    title: {
	        text: 'Networth',
	        style: {
                color: '#000000',
                fontWeight: 'bold',
                fontSize:'16px'
            }
	    },
	    legend: {
            borderWidth: 1,
            borderRadius: 5,
        },
        credits: {
            enabled: false
        },
	    yAxis: {
	        title: {
	            text: '{chart_pie_yAxis}'
	        }
	    },
	    plotOptions: {
	        pie: {
	            shadow: false,
	            center: ['50%', '50%']
	        }
	    },
	    legend: {
	    	layout: 'horizontal',
            align: 'center',
            verticalAlign: 'bottom',
            floating: true,
            backgroundColor: '#FFFFFF',
			y:10
	    },
	    tooltip: {
	        formatter: function () {
	            return '<b>' + this.point.name + '</b>: Rs. ' + this.y;
	        }
	    },
	    series: [{
	        name: 'Financial Assets',
	        data: [{
	        	name: 'Shares & Equity Mutual Funds',
	            y: shares_assets,
	            parentId: 'first',
	            color: '#0078ff',
	            legendIndex: 7
	        }, {
	        	name: 'Fixed Income Assets',
	            y: fixed_income_assets,
	            parentId: 'first',
	            color: '#510084',
	            legendIndex: 2
	        }, {
	        	name: 'Cash and Bank Accounts',
	            y: cash_bank_assets,
	            parentId: 'first',
	            color: '#00ccff',
	            legendIndex: 3
	        }, {
	        	name: 'Property',
	            y: property_assets,
	            parentId: 'first',
	            color: '#0500a0',
	            legendIndex: 4
	        },{
	        	name: 'Gold and Jewelleries',
	            y: gold_assets,
	            parentId: 'first',
	            color: '#9923ff',
	            legendIndex: 5
	        },{
	        	name: 'Others',
	        	parentId: 'first',
	            color: '#9923bc',
	            y: others_assets,
	            legendIndex: 6
	        },{
	        	name: 'Home Loan',
	        	parentId: 'second',
	            color: '#ff000c',
	            y: home_loan,
	            legendIndex: 8
	        },{
	        	name: 'Personal & other Loans',
	        	parentId: 'second',
	            color: '#ff0084',
	            y: personal_loan,
	            legendIndex: 9
	        },{
	        	name: 'Income Tax owed',
	        	parentId: 'second',
	            color: '#ff23bc',
	            y: income_tax,
	            legendIndex: 10
	        },{
	        	name: 'Outstanding bills/ payments',
	        	parentId: 'second',
	            color: '#ce4c0e',
	            y: outstanding_bills,
	            legendIndex: 11
	        },{
	        	name: 'Credit Card dues',
	        	parentId: 'second',
	            color: '#ff0089',
	            y: credit_card,
	            legendIndex: 12
	        },{
	        	name: 'Other liabilities',
	        	parentId: 'second',
	            color: '#7d0700',
	            y: other_liabilities,
	            legendIndex: 13
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
	        	name: 'Financial Assets',
	            id: 'first',
	            color: '#76b8f4',
	            y: total_assets,
	            legendIndex: 0
	        },{
	        	name: 'Liabilities',
	            id: 'second',
	            color: '#e15656',
	            y: total_liabillities,
	            legendIndex: 1
	        }],
	        size: '80%',
	        innerSize: '60%',
	        dataLabels: {
	        	enabled: false
	        }
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
	var shares_assets = $( "#shares_assets_txt" ).val();
	var fixed_income_assets = $( "#fixed_income_assets_txt" ).val();
	var cash_bank_assets = $( "#cash_bank_assets_txt" ).val();
	var property_assets = $( "#property_assets_txt" ).val();
	var gold_assets = $( "#gold_assets_txt" ).val();
	var others_assets = $( "#others_assets_txt" ).val();
	var home_loan = $( "#home_loan_txt" ).val();
	var personal_loan = $( "#personal_loan_txt" ).val();
	var income_tax = $( "#income_tax_txt" ).val();
	var outstanding_bills = $( "#outstanding_bills_txt" ).val();
	var credit_card = $( "#credit_card_txt" ).val();
	var other_liabilities = $( "#other_liabilities_txt" ).val();

	var total_assets = $( "#res_total_assets" ).html();
	var total_liabillities = $( "#res_total_liabilities" ).html();
	var total_networth = $( "#res_total_networth" ).html();
	
	shares_assets = numbersWithComma(shares_assets);
	fixed_income_assets = numbersWithComma(fixed_income_assets);
	cash_bank_assets = numbersWithComma(cash_bank_assets);
	property_assets = numbersWithComma(property_assets);
	gold_assets = numbersWithComma(gold_assets);
	others_assets = numbersWithComma(others_assets);
	home_loan = numbersWithComma(home_loan);
	personal_loan = numbersWithComma(personal_loan);
	income_tax = numbersWithComma(income_tax);
	outstanding_bills = numbersWithComma(outstanding_bills);
	credit_card = numbersWithComma(credit_card);
	other_liabilities = numbersWithComma(other_liabilities);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?shares_assets="+shares_assets+"&fixed_income_assets="+fixed_income_assets+"&cash_bank_assets="+cash_bank_assets+"&property_assets="+property_assets+"&gold_assets="+gold_assets;
		param += "&others_assets="+others_assets+"&home_loan="+home_loan+"&personal_loan="+personal_loan+"&income_tax="+income_tax+"&outstanding_bills="+outstanding_bills+"&credit_card="+credit_card+"&other_liabilities="+other_liabilities;
		param += "&total_assets="+total_assets+"&total_liabillities="+total_liabillities+"&total_networth="+total_networth+"&url="+calc_url;
		
		var url = '<c:url value="/downloadNetworthCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post("/sendNetworthCalcResult", {email : ""+email+"",shares_assets : ""+shares_assets+"",fixed_income_assets : ""+fixed_income_assets+"",
    		cash_bank_assets : ""+cash_bank_assets+"",property_assets : ""+property_assets+"",gold_assets : ""+gold_assets+"",others_assets : ""+others_assets+"",
    		home_loan : ""+home_loan+"",personal_loan : ""+personal_loan+"",income_tax : ""+income_tax+"",outstanding_bills : ""+outstanding_bills+"",
    		credit_card : ""+credit_card+"",other_liabilities : ""+other_liabilities+"",total_assets : ""+total_assets+"",
    		total_liabillities : ""+total_liabillities+"",total_networth : ""+total_networth+"",url : ""+ calc_url +""}, function(data)
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
			<li class="active"> &nbsp;Networth Calculator</li>
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
           		<h2 class="amfi-title bold">NETWORTH CALCULATOR</h2>
           						<div class="row margin-top14">
				
			   	<div class="col-md-7"> 
			   	<div class="table-responsive" id="input_table">
			   	<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin:0px !important;">
			   	<thead>
			   	<tr>
			   	<th colspan="2">Financial Assets</th>
			   	</tr>
			   	</thead>
			   	<tbody>
				<tr>
					<td width="53%">Shares & Equity Mutual Funds (Rs.)</td>
					<td>
						<div class="form-group"> 
			            	<input id="shares_assets_txt" value="500000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter the first child name"><span class="color-khojorange"> *</span>
			          	</div>
					</td>
				</tr>
				<tr>
					<td>Fixed Income Assets (Rs.)<p style="font-size:12px;margin: 0;">(Fixed deposits, Bonds, debt funds, PPF etc.)</p></td>
					<td>
						<div class="form-group"> 
			            	<input id="fixed_income_assets_txt" value="200000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter the second child name"><span class="color-khojorange"> *</span>
			          	</div>
					</td>
				</tr>
				<tr>
					<td>Cash and Bank Accounts (Rs.)<p style="font-size:12px;margin: 0;">(Savings accounts, Cash in hand, liquid funds, etc.)</p></td>
					<td>
						<div class="form-group"> 
			            	<input id="cash_bank_assets_txt" value="300000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter the first child age"><span class="color-khojorange"> *</span>
			          	</div>
					</td>
				</tr>
				<tr>
					<td>Property (Rs.)</td>
					<td>
						<div class="form-group"> 
			            	<input id="property_assets_txt" value="200000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter the second child age"><span class="color-khojorange"> *</span>
			          	</div>
					</td>
				</tr>
				<tr>
				    <td>Gold and Jewelleries (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="gold_assets_txt" value="200000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter first child prof edu age"><span class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Others (if any) (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="others_assets_txt" value="200000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter second child prof edu age"><span class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				</tbody>
				</table>
				
				
				<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;">
			   	<thead>
			   	<tr>
			   	<th colspan="2">Liabilities</th>
			   	</tr>
			   	</thead>
			   	<tbody>
				<tr>
				    <td width="53%">Home Loan (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="home_loan_txt" value="50000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter first child edu amount"><span class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Personal & other Loans (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="personal_loan_txt" value="250000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter second child edu amount"><span class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Income Tax owed (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="income_tax_txt" value="200000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter the inflation rate"><span class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Outstanding bills / payments (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="outstanding_bills_txt" value="500000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter the return rate"><span class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Credit Card dues (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="credit_card_txt" value="200000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter the savings amount"><span class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr>
				    <td>Other liabilities (if any) (Rs.)</td>
				    <td>
				    	<div class="form-group"> 
			            	<input id="other_liabilities_txt" value="20000" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:155px"  placeholder="Enter the savings amount"><span class="color-khojorange"> *</span>
			          	</div>
				    </td>
				</tr>
				<tr id="submit_btn_row">
				    <td colspan="2"><div class="text_center"><a onclick="calulate_assets()" class="btn btn-info" href="javascript:void(0)">Submit</a></div></td>
				</tr>
				</tbody>
				</table>
				</div>
			   	</div>
			   	
			   	<div class="col-md-5">
			   
			   	<div id="assetchart"></div>
				<div id="emipaymentsummary">
					<div id="emitotalinterest">
						<h4>Total Assets</h4>
						<p>Rs. <span id="res_total_assets"></span></p>
					</div>
					<div id="emitotalinterest">
						<h4>Total Liabilities</h4>
						<p>Rs. <span id="res_total_liabilities"></span></p>
					</div>
					<div id="emitotalamount">
						<h4>Your Networth</h4>
						<p>Rs. <span id="res_total_networth"></span></p>
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