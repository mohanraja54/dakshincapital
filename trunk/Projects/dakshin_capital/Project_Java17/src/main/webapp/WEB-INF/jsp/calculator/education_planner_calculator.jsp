<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style type="text/css">
#result{
	display:none;
}
.result_btn{
	display:none;
}
.marginRight5 {
    margin-right: 5px !important;
}
.float-left {
    float: left;
}
</style>


<!-- breadcrumb start -->
<!-- ================ -->
<!-- <div class="breadcrumb-container">
	<div class="container">
		<ol class="breadcrumb">
			<li><i class="fa fa-home pr-10"></i>&nbsp;<a class="link-dark" href="/">Home&nbsp;</a></li>
			<li><a class="link-dark" href="/tools-and-calculators/become-a-crorepati"> / Tools And Calculators&nbsp;/</a></li>
			<li class="active"> &nbsp;Children Education</li>
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
           		<h2 class="amfi-title bold">Children Education</h2>
								<div class="row margin-top14">
				   	<div class="col-md-12"> 
				   	<div class="table-responsive" id="input_table">
				   	<table class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;">
				   	<tbody>
					<tr>
						<td>Enter your first child name</td>
						<td>
							<div class="form-group"> 
				            	<input id="childName1" maxlength="45" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the first child name"><span class="color-khojorange"> *</span>
				          	</div>
						</td>
					</tr>
					<tr>
						<td>Enter your second child name</td>
						<td>
							<div class="form-group"> 
				            	<input id="childName2" maxlength="45" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the second child name"><span class="color-khojorange"> *</span>
				          	</div>
						</td>
					</tr>
					<tr>
						<td>Enter your first child current age (in years)</td>
						<td>
							<div class="form-group"> 
				            	<input id="childAge1" maxlength="2" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the first child age"><span class="color-khojorange"> *</span>
				          	</div>
						</td>
					</tr>
					<tr>
						<td>Enter your second child current age (in years)</td>
						<td>
							<div class="form-group"> 
				            	<input id="childAge2" maxlength="2" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the second child age"><span class="color-khojorange"> *</span>
				          	</div>
						</td>
					</tr>
					<tr>
					    <td>Enter the age at which your first child would be ready for professional education (in years)</td>
					    <td>
					    	<div class="form-group"> 
				            	<input id="profEduAge1" maxlength="2" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter first child prof edu age"><span class="color-khojorange"> *</span>
				          	</div>
					    </td>
					</tr>
					<tr>
					    <td>Enter the age at which your second child would be ready for professional education (in years)</td>
					    <td>
					    	<div class="form-group"> 
				            	<input id="profEduAge2" maxlength="2" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter second child prof edu age"><span class="color-khojorange"> *</span>
				          	</div>
					    </td>
					</tr>
					<tr>
					    <td width="70%">Enter the amount you would need at today's cost to fulfil your first child educational needs (Rs)</td>
					    <td>
					    	<div class="form-group"> 
				            	<input id="eduAmount1" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter first child edu amount"><span class="color-khojorange"> *</span>
				          	</div>
					    </td>
					</tr>
					<tr>
					    <td>Enter the amount you would need at today's cost to fulfil your second child educational needs (Rs)</td>
					    <td>
					    	<div class="form-group"> 
				            	<input id="eduAmount2" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter second child edu amount"><span class="color-khojorange"> *</span>
				          	</div>
					    </td>
					</tr>
					<tr>
					    <td>The expected rate of inflation over the years (% per annum)</td>
					    <td>
					    	<div class="form-group"> 
				            	<input id="priceIncRate" maxlength="4" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the inflation rate"><span class="color-khojorange"> *</span>
				          	</div>
					    </td>
					</tr>
					<tr>
					    <td>What rate of return would you expect your investment? (% per annum)</td>
					    <td>
					    	<div class="form-group"> 
				            	<input id="rateOfReturn" maxlength="4" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the return rate"><span class="color-khojorange"> *</span>
				          	</div>
					    </td>
					</tr>
					<tr>
					    <td>How much savings you have now? (Rs)</td>
					    <td>
					    	<div class="form-group"> 
				            	<input id="investAmount" maxlength="7" type="text" class="float-left form-control no-radius marginRight5" style="width:95%;" placeholder="Enter the savings amount"><span class="color-khojorange"> *</span>
				          	</div>
					    </td>
					</tr>
					<tr id="submit_btn_row">
					    <td colspan="2"><div class="text_center"><a onclick="calculateEduAmount()" class="btn btn-info" href="javascript:void(0)">Submit</a></div></td>
					</tr>
					</tbody>
					</table>
					</div>
					
					<div class="table-responsive" id="result">
					<table id="result-table-1" class="table table-striped table-bordered table-hover" cellspacing="0" width="100%" style="margin-top:0px !important;">
				   	<thead>
				   	<tr>
					  <th colspan="4"><div class="text-center">Result</div></th>
					</tr>
					<tr>
					  <th width="35%">Education Planner</th>
					  <th width="22%">Cost of <span id="child_1_name"></span>'s education</th>
					  <th width="22%">Cost of <span id="child_2_name"></span>'s education</th>
					  <th width="21%">Total cost for both</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					  <td width="35%">Amount at today's prices</td>
					  <td width="22%">Rs. <span id="child_1_amount"></span></td>
					  <td width="22%">Rs. <span id="child_2_amount"></span></td>
					  <td width="21%">Rs. <span id="child_total_amount"></span></td>
					</tr>
					<tr>
					  <td width="35%">Your child will take up professional education in</td>
					  <td width="22%"><span id="child_1_year"></span> year(s)</td>
					  <td width="22%"><span id="child_2_year"></span> year(s)</td>
					  <td width="21%"> - </td>
					</tr>
					<tr>
					  <td width="35%">Expected rate of return from investments (% per annum)</td>
					  <td width="22%"><span id="expect_interest_rate_1"></span> %</td>
					  <td width="22%"><span id="expect_interest_rate_2"></span> %</td>
					  <td width="21%"> - </td>
					</tr>
					<tr>
					  <td width="35%">Future cost of education (Inflation adjusted)</td>
					  <td width="22%">Rs. <span id="child_1_increase_amount"></span></td>
					  <td width="22%">Rs. <span id="child_2_increase_amount"></span></td>
					  <td width="21%">Rs. <span id="child_total_increase_amount"></span></td>
					</tr>
					<tr>
					  <td width="35%">Your current savings amount</td>
					  <td width="22%">Rs. <span id="child_1_invest_amount"></span></td>
					  <td width="22%">Rs. <span id="child_2_invest_amount"></span></td>
					  <td width="21%">Rs. <span id="child_total_invest_amount"></span></td>
					</tr>
					<tr>
					  <td width="35%">Monthly Savings required</td>
					  <td width="22%">Rs. <span id="child_1_monthly_amount"></span></td>
					  <td width="22%">Rs. <span id="child_2_monthly_amount"></span></td>
					  <td width="21%">Rs. <span id="child_total_monthly_amount"></span></td>
					</tr>
					</tbody>
					</table>
					</div>
					
					<!-- <div class="col-md-12 text-center result_btn">
					<a href="javascript:void(0)" id="calc_btn_submit" class="btn btn-warning ladda-button mutual-funds-submit-anchor marginTop20" onclick="saveResult()" data-style="expand-right" data-size="l"><span class="ladda-label">Save Result</span></a>
					</div> -->
				
				    	
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

	var childName1 = '${childName1}';
	var childName2 = '${childName2}';
	var childAge1 = '${childAge1}';
	var childAge2 = '${childAge2}';
	var profEduAge1 = '${profEduAge1}';
	var profEduAge2 = '${profEduAge2}';
	var eduAmount1 = '${eduAmount1}';
	var eduAmount2 = '${eduAmount2}';
	var priceIncRate = '${priceIncRate}';
	var rateOfReturn = '${rateOfReturn}';
	var investAmount = '${investAmount}';
	accountMap = '${accountMap}';	
	
	$('#childName1').val(childName1);
    $('#childName2').val(childName2);
    $('#childAge1').val(childAge1);
    $('#childAge2').val(childAge2);
    $('#profEduAge1').val(profEduAge1);
    $('#profEduAge2').val(profEduAge2);
    $('#eduAmount1').val(eduAmount1);
    $('#eduAmount2').val(eduAmount2);
    $('#priceIncRate').val(priceIncRate);
    $('#rateOfReturn').val(rateOfReturn);
    $('#investAmount').val(investAmount);
    
    calculateEduAmount();
	
});

function calculateEduAmount() 
{
    var childName1 = $('#childName1').val();
    var childName2 = $('#childName2').val();
    var childAge1 = $('#childAge1').val();
    var childAge2 = $('#childAge2').val();
    var profEduAge1 = $('#profEduAge1').val();
    var profEduAge2 = $('#profEduAge2').val();
    var eduAmount1 = $('#eduAmount1').val();
    var eduAmount2 = $('#eduAmount2').val();
    var priceIncRate = $('#priceIncRate').val();
    var rateOfReturn = $('#rateOfReturn').val();
    var investAmount = $('#investAmount').val();
    
    childName1 = $.trim(childName1);
    childName2 = $.trim(childName2);
    childAge1 = $.trim(childAge1);
    childAge2 = $.trim(childAge2);
    profEduAge1 = $.trim(profEduAge1);
    profEduAge2 = $.trim(profEduAge2);
    eduAmount1 = $.trim(eduAmount1);
    eduAmount2 = $.trim(eduAmount2);
    priceIncRate = $.trim(priceIncRate);
    rateOfReturn = $.trim(rateOfReturn);
    investAmount = $.trim(investAmount);
    
   	if(childName1 == "")
    {
    	alert("Please enter valid child name1");
    	return false;
    }
   	if(childAge1 == "" || childAge1 < 0)
    {
    	alert("Please enter valid child current Age1");
    	return false;
    }
    if(profEduAge1 == "" || profEduAge1 < 0)
    {
    	alert("Please enter valid child professional education Age1");
    	return false;
    }
   	if(eduAmount1 == "" || eduAmount1 < 0)
    {
    	alert("Please enter valid child need education amount1");
    	return false;
    }
    if(childName2 != "")
    {
    	if(childAge2 == "" || childAge2 < 0)
        {
        	alert("Please enter valid child current Age2");
        	return false;
        }
    	if(profEduAge2 == "" || profEduAge2 < 0)
        {
    		alert("Please enter valid professional education Age2");
        	return false;
        }
    	if(eduAmount2 == "" || eduAmount2 < 0)
        {
    		alert("Please enter valid child need education amount2");
        	return false;
        }
    }
    if(priceIncRate == "" || priceIncRate < 5 || priceIncRate > 15)
    {
    	alert("Please enter price increase rate between 5  to 15");
    	return false;
    }
    if(rateOfReturn == "" || priceIncRate < 5 || priceIncRate > 20)
    {
    	alert("Please enter rate of return between 5  to 20");
    	return false;
    }
    if(investAmount == "" || investAmount < 0)
    {
    	alert("Please enter valid current investment amount");
    	return false;
    }
    
    var child_count = 0;
    if(childName1 != "")
    {
    	child_count++;
    }
    if(childName2 != "")
    {
    	child_count++;
    }
    
    if(childAge2 == "")
    {
    	childAge2 = 0;
    }
	if(profEduAge2 == "")
    {
		profEduAge2 = 0;
    }
	if(eduAmount2 == "")
    {
		eduAmount2 = 0;
    }
        
    childAge1 = parseInt(childAge1);
    childAge2 = parseInt(childAge2);
    profEduAge1 = parseInt(profEduAge1);
    profEduAge2 = parseInt(profEduAge2);
    eduAmount1 = parseInt(eduAmount1);
    eduAmount2 = parseInt(eduAmount2);
    priceIncRate = parseFloat(priceIncRate, 10);
    rateOfReturn = parseFloat(rateOfReturn, 10);
    investAmount = parseInt(investAmount);
    
	var total_education_amount = "";
	var child1_prof_education_age = "";
	var child2_prof_education_age = "";
	var child1_inflation_adjust_education_amount = "";
	var child2_inflation_adjust_education_amount = "";
	var toal_inflation_adjust_education_amount = "";
	var child1_savings_amount = "";
	var child2_savings_amount = "";
	var total_savings_amount = "";
	var child1_monthly_savings = "";
	var child2_monthly_savings = "";
	var total_monthly_savings = "";
    
	$.ajaxSetup({async:false});
	$.post("/tools-and-calculators/getEducationPlannerResult", {child1_name : "" + childName1 + "",child2_name : "" + childName2 + "",child1_current_age : "" + childAge1 + "",child2_current_age : "" + childAge2 + "",child1_education_age : "" + profEduAge1 + "",child2_education_age : "" + profEduAge2 + "",child1_education_amount : "" + eduAmount1 + "",child2_education_amount : "" + eduAmount2 + "",inflation_rate : "" + priceIncRate + "",expected_return : "" + rateOfReturn + "",savings_amount : "" + investAmount + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		
		if(obj.status == 400)
		{
			alert(obj.msg);
			return false;
		}
		
		total_education_amount = obj.total_education_amount;
		child1_prof_education_age = obj.child1_prof_education_age;
		child2_prof_education_age = obj.child2_prof_education_age;
		child1_inflation_adjust_education_amount = obj.child1_inflation_adjust_education_amount;
		child2_inflation_adjust_education_amount = obj.child2_inflation_adjust_education_amount;
		toal_inflation_adjust_education_amount = obj.toal_inflation_adjust_education_amount;
		child1_savings_amount = obj.child1_savings_amount;
		child2_savings_amount = obj.child2_savings_amount;
		total_savings_amount = obj.total_savings_amount;
		child1_monthly_savings = obj.child1_monthly_savings;
		child2_monthly_savings = obj.child2_monthly_savings;
		total_monthly_savings = obj.total_monthly_savings;
		
    },'text');
	
	$('#child_1_name').html(childName1);
	$('#child_1_amount').html(numbersWithComma(eduAmount1));
	$('#child_total_amount').html(numbersWithComma(total_education_amount));
	$('#child_1_year').html(child1_prof_education_age);
	$('#expect_interest_rate_1').html(rateOfReturn);
	$('#child_1_increase_amount').html(numbersWithComma(child1_inflation_adjust_education_amount));
	$('#child_total_increase_amount').html(numbersWithComma(toal_inflation_adjust_education_amount));
	$('#child_1_invest_amount').html(numbersWithComma(child1_savings_amount));
	$('#child_total_invest_amount').html(numbersWithComma(total_savings_amount));
	$('#child_1_monthly_amount').html(numbersWithComma(child1_monthly_savings));
	$('#child_total_monthly_amount').html(numbersWithComma(total_monthly_savings));
	
	if (childName2 != "") 
	{
		$('#child_2_name').html(childName2);
		$('#child_2_amount').html(numbersWithComma(eduAmount2));
		$('#child_2_year').html(child2_prof_education_age);
		$('#expect_interest_rate_2').html(rateOfReturn);
		$('#child_2_increase_amount').html(numbersWithComma(child2_inflation_adjust_education_amount));
		$('#child_2_invest_amount').html(numbersWithComma(child2_savings_amount));
		$('#child_2_monthly_amount').html(numbersWithComma(child2_monthly_savings));
	}else{
		$('#child_2_name').html("-");
		$('#child_2_amount').html("-");
		$('#child_2_year').html(0);
		$('#expect_interest_rate_2').html("-");
		$('#child_2_increase_amount').html("-");
		$('#child_2_invest_amount').html("-");
		$('#child_2_monthly_amount').html("-");
	}
	
    $('#result').show();
    $(".result_btn").show();
}
function saveResult() 
{	
	var childName1 = $('#childName1').val();
    var childName2 = $('#childName2').val();
    var childAge1 = $('#childAge1').val();
    var childAge2 = $('#childAge2').val();
    var profEduAge1 = $('#profEduAge1').val();
    var profEduAge2 = $('#profEduAge2').val();
    var eduAmount1 = $('#eduAmount1').val();
    var eduAmount2 = $('#eduAmount2').val();
    var priceIncRate = $('#priceIncRate').val();
    var rateOfReturn = $('#rateOfReturn').val();
    var investAmount = $('#investAmount').val();
	
	var title = "Child Education Planner - Plan education of 2 children";
	var url = "/tools-and-calculators/children-education-planner?childName1="+childName1+"&childName2="+childName2+"&childAge1="+childAge1+"&childAge2="+childAge2+"&profEduAge1="+profEduAge1+"&profEduAge2="+profEduAge2+"&eduAmount1="+eduAmount1+"&eduAmount2="+eduAmount2+"&priceIncRate="+priceIncRate+"&rateOfReturn="+rateOfReturn+"&investAmount="+investAmount;
	
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
	var childName1 = $('#childName1').val();
    var childName2 = $('#childName2').val();
    var childAge1 = $('#childAge1').val();
    var childAge2 = $('#childAge2').val();
    var profEduAge1 = $('#profEduAge1').val();
    var profEduAge2 = $('#profEduAge2').val();
    var eduAmount1 = $('#eduAmount1').val();
    var eduAmount2 = $('#eduAmount2').val();
    var priceIncRate = $('#priceIncRate').val();
    var rateOfReturn = $('#rateOfReturn').val();
    var investAmount = $('#investAmount').val();
    
    if($('#result').css('display') == 'none')
    { 
    	alert("Please fill all the fields");
    	return;
    }
	
	var child_total_amount = $("#child_total_amount").html();
	var child_1_year = $("#child_1_year").html();
	var child_1_increase_amount = $("#child_1_increase_amount").html();
	var child_total_increase_amount = $("#child_total_increase_amount").html();
	var child_1_invest_amount = $("#child_1_invest_amount").html();
	var child_total_invest_amount = $("#child_total_invest_amount" ).html();
	var child_1_monthly_amount = $("#child_1_monthly_amount").html();
	var child_total_monthly_amount = $("#child_total_monthly_amount").html();
	var child_2_year = $("#child_2_year").html();
	var child_2_increase_amount = $("#child_2_increase_amount").html();
	var child_2_invest_amount = $("#child_2_invest_amount").html();
	var child_2_monthly_amount = $("#child_2_monthly_amount").html();
	
	eduAmount1 = numbersWithComma(eduAmount1);
	eduAmount2 = numbersWithComma(eduAmount2);
	investAmount = numbersWithComma(investAmount);
	var calc_url = window.location.href;
	
	if(download_text == "download")
	{
		var param = "?childName1="+childName1+"&childName2="+childName2+"&childAge1="+childAge1+"&childAge2="+childAge2+"&profEduAge1="+profEduAge1+"&profEduAge2="+profEduAge2;
		param += "&eduAmount1="+eduAmount1+"&eduAmount2="+eduAmount2+"&priceIncRate="+priceIncRate+"&rateOfReturn="+rateOfReturn+"&investAmount="+investAmount;
		param += "&child_total_amount="+child_total_amount+"&child_1_year="+child_1_year+"&child_1_increase_amount="+child_1_increase_amount+"&child_total_increase_amount="+child_total_increase_amount;
		param += "&child_1_invest_amount="+child_1_invest_amount+"&child_total_invest_amount="+child_total_invest_amount+"&child_1_monthly_amount="+child_1_monthly_amount;
		param += "&child_total_monthly_amount="+child_total_monthly_amount+"&child_2_year="+child_2_year+"&child_2_increase_amount="+child_2_increase_amount;
		param += "&child_2_invest_amount="+child_2_invest_amount+"&child_2_monthly_amount="+child_2_monthly_amount+"&url="+calc_url;
		
		var url = '<c:url value="/downloadEducationPlannerCalcResult" />'+param;
		window.location = url;
		
		$('#send_email_model').modal('hide');
        setTimeout(function(){
        	 $("#adv-alert-msg").html("Thanks for download.");
        	 $("#adv-alert").modal('show');
    	},1000);
	}else{
		
		$.ajaxSetup({async:true});
    	$.post(curl + "sendEducationPlannerCalcResult", {email : ""+email+"",childName1 : ""+childName1+"",childName2 : ""+childName2+"",childAge1 : ""+childAge1+"",
    		childAge2 : ""+childAge2+"",profEduAge1 : ""+profEduAge1+"",profEduAge2 : ""+profEduAge2+"",eduAmount1 : ""+eduAmount1+"",eduAmount2 : ""+eduAmount2+"",
    		priceIncRate : ""+priceIncRate+"",rateOfReturn : ""+rateOfReturn+"",investAmount : ""+investAmount+"",child_total_amount : ""+child_total_amount+"",
    		child_1_year : ""+child_1_year+"",child_1_increase_amount : ""+child_1_increase_amount+"",child_total_increase_amount : ""+child_total_increase_amount+"",
    		child_1_invest_amount : ""+child_1_invest_amount+"",child_total_invest_amount : ""+child_total_invest_amount+"",child_1_monthly_amount : ""+child_1_monthly_amount+"",
    		child_total_monthly_amount : ""+child_total_monthly_amount+"",child_2_year : ""+child_2_year+"",child_2_increase_amount : ""+child_2_increase_amount+"",
    		child_2_invest_amount : ""+child_2_invest_amount+"",child_2_monthly_amount : ""+child_2_monthly_amount+"",url : ""+ calc_url +""}, function(data)
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
