<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<style>
.text_size{
	font-size:13px;
}
.robo2,.robo3,.robo4,.robo5{
	display:none;
}
.ques_2,.ques_3,.ques_4,.ques_5{
	display:none;
}
#save_goal_div,#recommended_div{
	display:none;
}
.table thead th, .table tbody td, .table tfoot td{
	font-size:0.8125rem !important;
}
.table thead tr th, .table tbody tr td, .table tfoot tr td{
	padding: 9px !important;
}
#step2,#step3,#step4,#step5,#step6,#step7
{
	display:none;
}
.check_all_btn{
	cursor:pointer;
	text-decoration: underline;
}
.irs-grid-text{
	color:#000;
	font-weight:bold;
}
.retirement_div, .other_goal_div{
	display:none;
}
.result_div{
	font-size:16px;
}
.txt_blue{
	color:#1D3F8A;
	font-weight:bold;
}
.listStyle {
	height: 15px;
	width: 15px;
	border: 1px solid #909090;
	border-radius: 50%;
	margin: 10%;
	cursor: pointer;
	transition: all .5s ease-in-out;
}
.activeli { 
	background: #002841;
}
.ageLabel{
	font-size: 4rem;
	font-weight: normal;
	margin-top: -10px;
	margin-left: -5px;
}
.innerDiv {
	margin: 10% 0px;
}
.textbox {
    font-size: 14px;
    text-align:center;
    width: 150px;
    padding: 5px;
    border: solid 1px #cccccc;
    -webkit-border-radius: 28;
    -moz-border-radius: 28;
    border-radius: 7px;
}
.tbl_results {
	width:100%;
	border: 1px solid #e3e3e3;	
}
.tbl_results th,td{
	padding:20px;
	font-size:16px;
}
.robo1, .robo3, .robo4, .robo5{
	margin: 0px auto;
	background-color:#fff;
	margin-bottom: 5%;
	margin-top: 2%;
	padding-top: 3%;
}
.roboInput {
	border: 0;
    border-bottom: 1px solid #4b4e53;
	border-radius: 0px;
	 -webkit-box-shadow: none !important;
    box-shadow: none !important;
    font-size: 14px;
	color: #038bbb;
	font-weight: 500;
}
.roboInput:focus {
  	border: 0;
    border-bottom: 2px solid #4b4e53;
    border-radius: 0px;
     -webkit-box-shadow: none !important;
    box-shadow: none !important;
}
.marginTopMinus30{
	margin-top:-10px;
}
.robo1 label{
	font-size:14px !important;
	font-weight: 500;	
	color: #777;
}
.robo2 label{
	font-size:14px;
	font-weight: 500;	
	color: #777;
}
.clear{
	clear:both;
}
.marginTop50{
	margin-top:50px;
}
.title-v1{
    text-align:center;
}
.width240{
	width:240px;
}
.robo2,.robo5 {
	display:none;
}
.ques2,.ques3,.ques4,.ques5,.ques6,.ques7,.ques8{
	display:none;
}
.question_head{
	font-size:14px;
	margin-bottom:30px;
	color:grey;
}
.question{
	margin-bottom:10px;
	font-size:14px;
	font-weight:bold;
}
.answer{
	border-top:1px solid #ddd;
	padding:18px;
}
.answer_last{
	border-top:1px solid #ddd;
	border-bottom:1px solid #ddd;
	padding:18px;
}

.btn-primary:focus, .btn-primary.focus {
    color: #fff !important;
}
.padding0{
	padding:0px;
}
.marginBottom50{
	margin-bottom:50px;
}
.marginBottom30{
	margin-bottom:30px;
}
.height100{
	height:100%;
}
.marginRight20{
	margin-right:20px;
}
.btn{
	cursor:pointer;
}
.marginTop30{
	margin-top:30px;
}
.padding100{
	padding:100px;
}
#tbl_portfolio_returns th{
	font-size: 12px;
    color:#000;
}

#tbl_portfolio_returns td{
	font-size: 12px;
    color:#000;
}
#tbl_portfolio_returns button {
	width: 100%;
	font-size: 14px;
	height: 30px;
	line-height: 15px;
}
#tbl_portfolio_returns input{
	font-size:12px;
	color:#000;
}
#tbl_portfolio_returns a{
    color:#1D3F8A;
}
.popup_table td, .popup_table th{
	font-size:11px;
}
.btn-own {
	background: none;
	color: #101010;
	border: 0px;
	padding:0px;
}
.font-size-16{
	font-size:16px;
}
b{
	font-weight:bold;
	color: #777;
}
.sweet-alert fieldset{
	margin:0px;
	padding:0px;
}
.outer_cover{	
	padding:20px;
}
.check_all_btn{
	cursor:pointer;
	text-decoration: underline;
}
.value 
{
	font-size: 20px;
	line-height: 20px;
	font-weight: 400;
	margin-bottom: 10px;
	color: #233e62;
}
.lamount {
	padding: 10px 40px;
	border: 1px solid #eee;
	margin: 10px;
	border-radius: 10px;
}
.lamount input {
	margin-top : 10px;
}
.bg-tf
{
	box-shadow: 0 3px 10px rgba(0,0,0,.16);
}
.plutus3 {
    background-color: #005e96;
    color: #fff;
}
.plutus2 {
    border: 3px solid #005e96;
    color: #172460;
}
</style>

<script>
var target_goal = "Emergency";
var goal_name = "Emergency";
var amount = 50000;
var age = 30;
var returns = 8;
var horizon = 1;
var risk = "Conservative";
var inflation = 5;
var sip_amount = 0;
var target_amount = "";
var remaining_goal_amount = 0;
var remaining_sip_amount = 0;
var goal_based_amount = 0;
var debt = 0;
var equity = 0;
var liquid_debt = 0;
var short_term_debt = 0;
var long_term_debt = 0;
var equity_balanced = 0;
var equity_largecap = 0;
var equity_midcap = 0;
var equity_diversified = 0;
var hybrid_debt = 0;
var investor_pan = "";
var ques_flag = 1;
var existing_portfolio_flag = true;
var existing_flag = false;
var login_customer_flag = false;
var userid = 0;

$(document).ready(function(){
	
	investor_pan = '${pan}';
	userid = '${userid}';
	
	var amt = '${amount}';
	if(amt != "")
	{
		amount = '${amount}';
		inflation = '${inflation}';
		age = '${age}';
		goal_name = '${goal_name}';
		
		login_customer_flag = true;

		$("#txt_amount").val(amount);
		$("#txt_inflation").val(inflation);
		$("#txt_current_age").val(age);
	    $("#txt_goal_name").val(goal_name);

	    checkResult();
	}

	$("#age_slider").slider({
		min: 18,
	    max: 99,
	    tooltip: "show",
	    step: 1,
	    value: age
	}).on("slideStop", function(slideEvt) {		
		$("#txt_current_age").val(slideEvt.value);
	});

	$("#amount_slider").slider({
		min: 1,
	    max: 10000000,
	    tooltip: "show",
	    step: 1000,
	    value: amount
	}).on("slideStop", function(slideEvt) {		
		$("#txt_amount").val(slideEvt.value);
	});

	$("#inflation_slider").slider({
		min: 1,
	    max: 20,
	    tooltip: "show",
	    step: 1,
	    value: inflation
	}).on("slideStop", function(slideEvt) {		
		$("#txt_inflation").val(slideEvt.value);
	});
	
	$('.check_all_btn').click(function() {
	    var value = $(this).html();
	    if(value == "Select All Schemes")
	    {
	    	$("input[name='save_goal']").prop('checked', true);
	        $(this).html('Unselect All Schemes');
	    }else
	    {
	    	$("input[name='save_goal']").prop('checked', false);
	        $(this).html('Select All Schemes');   
	    }
	});
	$(".ques_1").show();
});

function ageChange()
{
	var age = $('#txt_current_age').val();
	$( "#age_slider" ).slider("setValue",age);
}
function amountChange()
{
	var amount = $('#txt_amount').val();
	$( "#amount_slider" ).slider("setValue",amount);
}
function inflationChange()
{
	var inflation = $('#txt_inflation').val();
	$( "#inflation_slider" ).slider("setValue",inflation);
}

function goToStep1()
{
	$(".robo1").show();
	$(".robo2").hide();
	$(".robo3").hide();
	$(".robo4").hide();
	$(".robo5").hide();
}
function goToStep2()
{
	$(".robo1").hide();
	$(".robo2").hide();
	$(".robo3").show(); 
	$(".robo4").hide();
	$(".robo5").hide();
}
function goToStep3()
{
	$(".robo1").hide();
	$(".robo2").hide(); 
	$(".robo3").hide();
	$(".robo4").show();
	$(".robo5").hide();
}

function riskProfileChange()
{
	risk = $("#sel_risk").val();
	if(risk == "")
 	{	
    	$(".robo1").hide();
    	$(".robo3").hide();
    	$(".robo4").hide();
    	$(".robo5").hide();
    	$(".robo2").show();
    	$("#step7").hide();
    	$("#step1").show();
 	}
}
function calculateSIPAmount()
{
	var rate_of_return = 8; 
    
    //Calculate SIP Amount
    var wealth_amount = parseInt(amount) * 6;
	var years = parseInt(horizon);
	var price_increase_rate = parseFloat(inflation);
	rate_of_return = parseFloat(rate_of_return);
	
	var value1 = 1 + (price_increase_rate / 100);
	var value2 = Math.pow(value1, years);
	target_amount = Math.round(wealth_amount * value2);
	target_amount = Math.ceil(target_amount / 1000) * 1000;
	
	var famt = parseFloat(target_amount);
	var rate = parseFloat(rate_of_return);
	var period = years * 12;
	
	sip_amount = (rate / (12 * 100) * (famt)) / (Math.pow((1 + rate / (12 * 100)), period) - 1);
	sip_amount = Math.round(sip_amount);
	//alert("init sip_amount----->"+sip_amount);
	sip_amount = Math.ceil(sip_amount / 1000) * 1000;
	//alert("after sip_amount----->"+sip_amount);
	target_amount = Math.round(target_amount);

	$("#span_invest_today_cost").html(numbersWithComma(wealth_amount));
	$("#span_invest_future_cost").html(numbersWithComma(target_amount));
	$("#span_sch_future_cost").html(numbersWithComma(target_amount));
	$("#span_no_years").html(years);
	$("#span_sip_amt").html(numbersWithComma(sip_amount));
	$(".span_inflation").html(price_increase_rate);
	
	$("#txt_target_amount").html(numbersWithComma(wealth_amount));
	$("#txt_target_amount_inflation").html(numbersWithComma(target_amount));
	$("#txt_years").html(years);
	$("#txt_sip_amount").html(numbersWithComma(sip_amount));
	$(".span_inflation").html(price_increase_rate);
}
function checkResult()
{
	amount = $("#txt_amount").val();
	horizon = 1;
	inflation = $("#txt_inflation").val();
    risk = "Conservative";
    age = $("#txt_current_age").val();
    goal_name = $("#txt_goal_name").val();

    if(age == "" || isNaN(age) || parseInt(age) < 1 || parseInt(age) > 100)
 	{
 		swal({title:"",text:"Please enter valid age"});
		return;
 	}
 	
    if(amount == "" || isNaN(amount) || parseInt(amount) < 1)
 	{
 		swal({title:"",text:"Please enter valid target amount today's value"});
		return;
 	}

    if(inflation == "" || isNaN(inflation) || parseInt(inflation) < 1)
 	{
 		swal({title:"",text:"Please enter valid inflation"});
		return;
 	}
    if(goal_name == "")
 	{
 		swal({title:"",text:"Please enter the goal name"});
		return;
 	}
    
    $('html,body').animate({
        scrollTop: 0
    }, 700);
    
    calculateSIPAmount();
	$(".robo1").hide();
	$(".robo2").hide();
	$(".robo5").hide();
	$(".robo4").hide();
	$(".robo3").show();

	if(login_customer_flag == true){
		login_customer_flag = false;
		showFunds();

		$(".robo1").hide();
		$(".robo2").hide();
		$(".robo5").hide();
		$(".robo4").hide();
		$(".robo3").show();
		
	}
}
function showFunds()
{
	$('.existing_summary_div').hide();
	
	if(existing_portfolio_flag)
	{
		existing_portfolio_flag = false;
		
		$('#tbl_existing_portfolio_returns').html("");
		$('#existing_portfolio_div').hide();
		$('#existing_portfolio_spinner_div').show();
		
		var html = "";
		html += "<thead><tr>";
		html += "<th>Scheme Name</th>";
		html += "<th>Category</th>";
		html += "<th>Folio Number</th>";
		html += "<th>Balance Units</th>";
		html += "<th>Current Value</th>";
		html += "<th>Future Value</th>";
		html += "<th>Save Scheme</th>";
		html += "</tr></thead>";
		html += "<tbody>";
		
		var exist_count = 0;

		$.LoadingOverlay("show");
		
		$.ajaxSetup({async:true});
		$.post("/goal/getPortfolioDetails", function(data)
	    {
			$.LoadingOverlay("hide");
			
			var result = $.trim(data);
			if(result == null || result == "null")
			{
				html += "<tr><td colspan='6'>No existing Live Mutual Fund Schemes. Please click Next button and see the recommended schemes.</td></tr>";
				existing_flag = true;
			}else
			{
				var obj = jQuery.parseJSON(result);
				var scheme_array = $.makeArray(obj[0].investorSchemeWisePortfolioResponses);
				
				var folio_array = new Array();
				var scheme_code_array = new Array();
				
				var folio_list_str = $("#txt_folio_list").val();
				var scheme_code_list_str = $("#txt_scheme_code_list").val();
				
				if(folio_list_str != "")
				{
					folio_array = folio_list_str.split(",");
					scheme_code_array = scheme_code_list_str.split(",");
				}
		    	
				for (var i = 0; i < scheme_array.length ; i++)
			    {
					var scheme_name = scheme_array[i].scheme;
					var scheme_code = scheme_array[i].scheme_code;
					var category = scheme_array[i].scheme_advisorkhoj_category;
					var foliono = scheme_array[i].foliono;
					var totalUnits = scheme_array[i].totalUnits;
					var totalCurrentValue = scheme_array[i].totalCurrentValue;
					var sip_scheme = scheme_array[i].isSipScheme;
					var scheme_sip_amount = scheme_array[i].total_sip_amount;
					exist_count++;

					var rate_of_return = 8;
					if(risk == "Aggressive")
				    {
				        rate_of_return = 14;
				    }else if(risk == "Moderately Aggressive")
				    {
				        rate_of_return = 12.5;
				    }else if(risk == "Moderate")
				    {
				        rate_of_return = 11.5;
				    }else if(risk == "Moderately Conservative")
				    {
				        rate_of_return = 10;
				    }else
				    {
				        rate_of_return = 8;
				    }  
					rate_of_return = parseFloat(rate_of_return);
					var years = parseInt(horizon);
					
					//lumpsum future value
					var value1 = 1 + (rate_of_return / 100);
					var value2 = Math.pow(value1, years);
					
					//sip future value
					var sipMonth = years * 12;
				    var sip_value1 = (rate_of_return / 100) / 12;
				    var sip_value3 = 1 + sip_value1;
				    var sip_value4 = Math.pow((sip_value3), (sipMonth + 1));
				    var amount1 = (sip_value4 - 1);
				    var amount2 = amount1 / sip_value1;
					
					var wealth_amount = parseInt(totalCurrentValue);
					var future_value = wealth_amount * value2;
					future_value = Math.round(future_value);
					
					if(scheme_sip_amount != 0)
					{
						var sipAmount = parseInt(scheme_sip_amount);
						var final_amount = (sipAmount * amount2) - sipAmount;
					    final_amount = Math.round(final_amount);
					    future_value = future_value + final_amount;
					}
			    	
			    	html += "<tr>";
			    	if(sip_scheme == true || sip_scheme == "true")
			    	{
			    		html += '<td><span id="td_scheme_'+exist_count+'">'+scheme_name+'</span><br/><span class="sip_color">(SIP Amount Rs.<span id="span_scheme_sip_amount_'+exist_count+'">'+numbersWithComma(scheme_sip_amount.toFixed(0))+'</span>)</span><input type="hidden" value="'+scheme_code+'" id="td_scheme_code_'+exist_count+'"/></td>';
			    	}else
			    	{
			    		html += '<td><span id="td_scheme_'+exist_count+'">'+scheme_name+'</span><input type="hidden" value="'+scheme_code+'" id="td_scheme_code_'+exist_count+'"/></td>';
			    	}
			    	html += '<td>'+category+'</td>';
			    	html += '<td id="td_folio_'+exist_count+'">'+foliono+'</td>';
			    	html += '<td align="right">'+totalUnits+'</td>';
			    	html += '<td id="td_current_value_'+exist_count+'" align="right">'+numbersWithComma(totalCurrentValue.toFixed(0))+'</td>';
			    	html += '<td id="td_future_value_'+exist_count+'" align="right">'+numbersWithComma(future_value.toFixed(0))+'</td>';
			    	if(folio_array.length > 0)
			    	{
			    		if((jQuery.inArray(foliono, folio_array) !== -1) && (jQuery.inArray(scheme_code, scheme_code_array) !== -1))
			    		{
			    			html += '<td align="center">Already Mapped</td>';
			    		}else
			    		{
			    			html += '<td class="text-center"><input type="checkbox" name="save_goal_exist" value="'+exist_count+'" onchange="showSelectedValues()"></td>';
			    		}
			    	}else
			    	{
			    		html += '<td class="text-center"><input type="checkbox" name="save_goal_exist" value="'+exist_count+'" onchange="showSelectedValues()"></td>';
			    	}
			    	html += "</tr>";
			    }
			}

			html += "</tbody>"; 
			$('#tbl_existing_portfolio_returns').html(html);
			$('#existing_portfolio_spinner_div').hide();
			$('#existing_portfolio_div').show();

			calculateSIPAmount();
			$(".robo1").hide();
			$(".robo2").hide();
			$(".robo3").hide();
			$(".robo5").hide();
			$(".robo4").show();
			
			$('#recommended_div').hide();
			$('#save_goal_div').hide();
			
	    },'text');	
		
	}else
	{
		calculateSIPAmount();
		$(".robo1").hide();
		$(".robo2").hide();
		$(".robo3").hide();
		$(".robo5").hide();
		$(".robo4").show();
		
		$('#recommended_div').hide();
		$('#save_goal_div').hide();
	}
}
function showSummary()
{
	$('#txt_goal_amount').val(numbersWithComma(target_amount));
	$('#txt_goal_years').val(horizon);
	$('#txt_goal_sip_amount').val(numbersWithComma(sip_amount));
	
	if(existing_flag)
	{
		remaining_goal_amount = parseInt(target_amount);
		remaining_sip_amount = parseInt(sip_amount);
	}else
	{
		var scheme_array = new Array();
		var folio_array = new Array();
		var current_value_array = new Array();
		var sip_array = new Array();
		
		$("input[name='save_goal_exist']:checked").each(function()
		{
			var count = $(this).val();
			var scheme = $("#td_scheme_"+count).html();
			var folio_no = $("#td_folio_"+count).html();
			var current_value = $("#td_current_value_"+count).html();
			var scheme_sip = $("#span_scheme_sip_amount_"+count).html();
			
			if(scheme_sip == undefined || scheme_sip == "undefined" || scheme_sip == null || scheme_sip == "")
			{
				scheme_sip = "0";
			}
			current_value = current_value.replace(/,/g,'');
			scheme_sip = scheme_sip.replace(/,/g,'');
			
			scheme_array.push(scheme);
			folio_array.push(folio_no);
			current_value_array.push(current_value);
			sip_array.push(scheme_sip);
		});
		
		$('#existing_summary_inner_div tr.goal_ques').remove();
		
		var str = "";
		if(folio_array.length == 0)
		{
			remaining_goal_amount = parseInt(target_amount);
			remaining_sip_amount = parseInt(sip_amount);
			str += '<tr class="goal_ques"><td>Monthly SIP investment required</td><td><input type="text" id="txt_goal_sip_amount" value="'+numbersWithComma(sip_amount.toFixed(0))+'" class="form-control form-control-sm fundNamebg"></td></tr>';
			$('#existing_summary_inner_div').append(str);
		}else
		{
			var existing_total_amount = 0;
			var rate_of_return = 8;
			if(risk == "Aggressive")
		    {
		        rate_of_return = 14;
		    }else if(risk == "Moderately Aggressive")
		    {
		        rate_of_return = 12.5;
		    }else if(risk == "Moderate")
		    {
		        rate_of_return = 11.5;
		    }else if(risk == "Moderately Conservative")
		    {
		        rate_of_return = 10;
		    }else
		    {
		        rate_of_return = 8;
		    }  
			rate_of_return = parseFloat(rate_of_return);
			var years = parseInt(horizon);
			
			//lumpsum future value
			var value1 = 1 + (rate_of_return / 100);
			var value2 = Math.pow(value1, years);
			
			//sip future value
			var sipMonth = years * 12;
		    var sip_value1 = (rate_of_return / 100) / 12;
		    var sip_value3 = 1 + sip_value1;
		    var sip_value4 = Math.pow((sip_value3), (sipMonth + 1));
		    var amount1 = (sip_value4 - 1);
		    var amount2 = amount1 / sip_value1;
			
			for(var k=0;k<scheme_array.length;k++)
			{
				var scheme_name = scheme_array[k];
				var current_value = current_value_array[k];
				var sip_value = sip_array[k];
				
				var wealth_amount = parseInt(current_value);
				var future_value = wealth_amount * value2;
				future_value = Math.round(future_value);
				
				if(sip_value != 0)
				{
					var sipAmount = parseInt(sip_value);
					var final_amount = (sipAmount * amount2) - sipAmount;
				    final_amount = Math.round(final_amount);
				    future_value = future_value + final_amount;
				}
				existing_total_amount = existing_total_amount + future_value;
				
				str += '<tr class="goal_ques"><td>'+scheme_name+'<br/>(Future value)</td><td><input type="text" disabled="disabled" value="'+numbersWithComma(future_value.toFixed(0))+'" class="form-control form-control-sm fundNamebg" ></td></tr>';
			}
			
			var goal_amount = parseInt(target_amount);
			remaining_goal_amount = goal_amount - existing_total_amount;
			remaining_goal_amount = Math.round(remaining_goal_amount);
			
			if(remaining_goal_amount <= 1000)
			{
				remaining_goal_amount = 0;
				remaining_sip_amount = 0;
				
				str += "<tr class='goal_ques'><td colspan'2'>Your existing mutual fund investment is enough to achieve your goal. Please do not redeem the investments till goal period.</td></tr>";
			}else
			{
			    //Calculate Remaining SIP Amount
			    
			    var famt = parseFloat(remaining_goal_amount);
				var rate = parseFloat(rate_of_return);
				var period = years * 12;
				
				remaining_sip_amount = (rate / (12 * 100) * (famt)) / (Math.pow((1 + rate / (12 * 100)), period) - 1);
				remaining_sip_amount = Math.round(remaining_sip_amount);
				
				str += '<tr class="goal_ques"><td>Your Remaining targeted Amount</td><td><input type="text" id="txt_remain_goal_amount" disabled="disabled" value="'+numbersWithComma(remaining_goal_amount.toFixed(0))+'" class="form-control form-control-sm fundNamebg" ></td></tr>';
				str += '<tr class="goal_ques"><td>Monthly SIP investment required</td><td><input type="text" id="txt_goal_sip_amount" value="'+numbersWithComma(remaining_sip_amount.toFixed(0))+'" class="form-control form-control-sm fundNamebg" ></td></tr>';
			}		
			$('#existing_summary_inner_div').append(str);
		}
	}
	//$('#existing_summary_inner_div').show();
	
	if(remaining_goal_amount <= 0)
	{
		$('#recommended_div').hide();
		$('#save_goal_div').show();
	}else
	{
		$('#save_goal_div').hide();
		$('#recommended_div').show();
	}
	$('.existing_summary_div').show();
}
function calculateDebtAndEquity()
{
	if(existing_portfolio_flag)
	{
		remaining_goal_amount = target_amount;
		remaining_sip_amount = sip_amount;
		
		remaining_sip_amount = parseFloat(remaining_sip_amount);
		goal_based_amount = remaining_sip_amount;	
	}else
	{
		var get_goal_amount = $('#txt_remain_goal_amount').val();
		var get_sip_amount = $('#txt_goal_sip_amount').val();
		if(get_goal_amount == undefined || get_goal_amount == "undefined" || get_goal_amount == null || get_goal_amount == "")
		{
			get_goal_amount = remaining_goal_amount;
		}else
		{
			get_goal_amount = get_goal_amount.replace(/,/g,'');
			remaining_goal_amount = parseInt(get_goal_amount);
		}
		if(get_sip_amount == undefined || get_sip_amount == "undefined" || get_sip_amount == null || get_sip_amount == "")
		{
			get_sip_amount = remaining_sip_amount;
		}else
		{
			get_sip_amount = get_sip_amount.replace(/,/g,'');
			remaining_sip_amount = parseInt(get_sip_amount);
		}
		remaining_sip_amount = parseFloat(remaining_sip_amount);
		goal_based_amount = remaining_sip_amount;
	}
	$(".sip_amt").html(numbersWithComma(remaining_sip_amount));
	
	var new_risk = 1;
	if(risk == "Aggressive")
    {
        new_risk = 5;
    }else if(risk == "Moderately Aggressive")
    {
        new_risk = 4;
    }else if(risk == "Moderate")
    {
        new_risk = 3;
    }else if(risk == "Moderately Conservative")
    {
        new_risk = 2;
    }else
    {
        new_risk = 1;
    }
    
	var new_horizon = 1;
	if(horizon <= 1)
    {
		new_horizon = 1;
    }else if(horizon <= 3)
    {
		new_horizon = 2;
    }else if(horizon <= 7)
    {
    	new_horizon = 3;
    }else if(horizon <= 15)
    {
    	new_horizon = 4;
    }else{
    	new_horizon = 5;
    }
    
    new_horizon = parseInt(new_horizon);
    new_risk = parseInt(new_risk);    
	
	var angles = [0, 0, 0, 0, 0, 0, 0, 0];
    
  	//horizon 1
    if (new_horizon == 1 && new_risk == 1)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 100; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 1 && new_risk == 2)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 100; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 1 && new_risk == 3)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 100; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 1 && new_risk == 4)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 100; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 1 && new_risk == 5)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 100; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    
    //horizon 2
    if (new_horizon == 2 && new_risk == 1)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 70; // short term debt
        angles[2] = 30; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 2 && new_risk == 2)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 60; // short term debt
        angles[2] = 40; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 2 && new_risk == 3)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 50; // short term debt
        angles[2] = 50; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 2 && new_risk == 4)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 40; // short term debt
        angles[2] = 60; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 2 && new_risk == 5)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 30; // short term debt
        angles[2] = 70; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    
   //horizon 3
    if (new_horizon == 3 && new_risk == 1)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 20; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 40; // balanced fund equity oriented
        angles[4] = 10; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 30; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 3 && new_risk == 2)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 15; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 45; // balanced fund equity oriented
        angles[4] = 15; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 25; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 3 && new_risk == 3)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 10; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 50; // balanced fund equity oriented
        angles[4] = 25; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 15; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 3 && new_risk == 4)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 5; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 40; // balanced fund equity oriented
        angles[4] = 20; // largecap
        angles[5] = 0; // midcap
        angles[6] = 25; // thematic funds
        angles[7] = 10; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 3 && new_risk == 5)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 35; // balanced fund equity oriented
        angles[4] = 30; // largecap
        angles[5] = 0; // midcap
        angles[6] = 35; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    
    //horizon 4
    if (new_horizon == 4 && new_risk == 1)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 25; // balanced fund equity oriented
        angles[4] = 30; // largecap
        angles[5] = 0; // midcap
        angles[6] = 25; // thematic funds
        angles[7] = 20; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 4 && new_risk == 2)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 20; // balanced fund equity oriented
        angles[4] = 35; // largecap
        angles[5] = 5; // midcap
        angles[6] = 25; // thematic funds
        angles[7] = 15; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 4 && new_risk == 3)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 15; // balanced fund equity oriented
        angles[4] = 25; // largecap
        angles[5] = 20; // midcap
        angles[6] = 30; // thematic funds
        angles[7] = 10; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 4 && new_risk == 4)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 10; // balanced fund equity oriented
        angles[4] = 20; // largecap
        angles[5] = 35; // midcap
        angles[6] = 35; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 4 && new_risk == 5)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 10; // balanced fund equity oriented
        angles[4] = 15; // largecap
        angles[5] = 40; // midcap
        angles[6] = 35; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    
    
  	//horizon 5
    if (new_horizon == 5 && new_risk == 1)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 25; // balanced fund equity oriented
        angles[4] = 30; // largecap
        angles[5] = 0; // midcap
        angles[6] = 25; // thematic funds
        angles[7] = 20; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 5 && new_risk == 2)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 20; // balanced fund equity oriented
        angles[4] = 35; // largecap
        angles[5] = 5; // midcap
        angles[6] = 25; // thematic funds
        angles[7] = 15; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 5 && new_risk == 3)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 15; // balanced fund equity oriented
        angles[4] = 25; // largecap
        angles[5] = 20; // midcap
        angles[6] = 30; // thematic funds
        angles[7] = 10; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 5 && new_risk == 4)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 10; // balanced fund equity oriented
        angles[4] = 20; // largecap
        angles[5] = 35; // midcap
        angles[6] = 35; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 5 && new_risk == 5)
    {
    	angles[0] = 0; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 10; // balanced fund equity oriented
        angles[4] = 15; // largecap
        angles[5] = 40; // midcap
        angles[6] = 35; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    
    liquid_debt = parseFloat(angles[0]);
	short_term_debt = parseFloat(angles[1]);
	long_term_debt = parseFloat(angles[2]);
	equity_balanced = parseFloat(angles[3]);
	equity_largecap = parseFloat(angles[4]);
	equity_midcap = parseFloat(angles[5]);
	equity_diversified = parseFloat(angles[6]);
	hybrid_debt = parseFloat(angles[7]);
	
	var total = liquid_debt + short_term_debt + long_term_debt + equity_balanced + equity_largecap + equity_midcap + equity_diversified + hybrid_debt;
	var current_amount = parseInt(goal_based_amount);
	if(current_amount <= 25000)
	{
		var count = 0;		
		for(var k=0;k<angles.length;k++)
		{
			if(angles[k] > 0)
			{
				count++;	
			}
		}
		var check_count = 1;	
		if(current_amount <= 1000)
		{
			check_count = 1;
		}else if(current_amount <= 3000)
		{
			check_count = 2;
		}else if(current_amount <= 5000)
		{
			check_count = 3;
		}else if(current_amount <= 10000)
		{
			check_count = 4;
		}else if(current_amount <= 15000)
		{
			check_count = 5;
		}else if(current_amount <= 25000)
		{
			check_count = 6;
		}
		if(count > check_count)
		{
			var change_arr = [0, 0, 0, 0, 0, 0, 0, 0];
			change_arr[0] = equity_midcap;
			change_arr[1] = equity_diversified;
			change_arr[2] = equity_largecap;
			change_arr[3] = equity_balanced;
			change_arr[4] = hybrid_debt;
			change_arr[5] = long_term_debt;
			change_arr[6] = short_term_debt;
			change_arr[7] = liquid_debt;
			
			while(count > check_count)
			{
				for(var k=0;k<change_arr.length;k++)
				{
					var flag = false;
					if(change_arr[k] > 0)
					{
						for(var m=(k+1);m<change_arr.length;m++)
						{
							if(change_arr[m] > 0)
							{
								change_arr[m] = change_arr[m] + change_arr[k];
								change_arr[k] = 0;
								flag = true;
								break;
							}
						}
					}
					
					if(flag == true)
					{
						break;
					}
				}
				
				count = 0;	
				for(var k=0;k<change_arr.length;k++)
				{
					if(change_arr[k] > 0)
					{
						count++;	
					}
				}
			}
			
			equity_midcap = parseFloat(change_arr[0]);
			equity_diversified = parseFloat(change_arr[1]);
			equity_largecap = parseFloat(change_arr[2]);
			equity_balanced = parseFloat(change_arr[3]);
			hybrid_debt = parseFloat(change_arr[4]);
			long_term_debt = parseFloat(change_arr[5]);
			short_term_debt = parseFloat(change_arr[6]);
			liquid_debt = parseFloat(change_arr[7]);
		}
	}
	
	var total = liquid_debt + short_term_debt + long_term_debt + equity_balanced + equity_largecap + equity_midcap + equity_diversified + hybrid_debt;

	var change_arr = [0, 0, 0, 0, 0, 0, 0, 0];
	change_arr[0] = liquid_debt;
	change_arr[1] = short_term_debt;
	change_arr[2] = long_term_debt;
	change_arr[3] = hybrid_debt;
	change_arr[4] = equity_balanced;
	change_arr[5] = equity_largecap;
	change_arr[6] = equity_diversified;
	change_arr[7] = equity_midcap;
	var check_value = (500 / goal_based_amount) * 100;
	check_value = Math.ceil(check_value);
	
	for(var k=0;k<change_arr.length;k++)
	{
		var flag = false;
		if(change_arr[k] > 0 && change_arr[k] < check_value)
		{
			var val = check_value - change_arr[k];
			
			for(var m=(change_arr.length-1);m>k;m--)
			{
				if(change_arr[m] > 0)
				{
					if((change_arr[m] - val) > 0)
					{
						change_arr[m] = change_arr[m] - val;
						change_arr[k] = check_value;
						flag = true;
						break;
					}else
					{
						change_arr[k] = change_arr[k] + change_arr[m];
						val = check_value - change_arr[k];
						change_arr[m] = 0;
					}
				}
			}
		}
		
		if(flag == true)
		{
			break;
		}
	}
	
	liquid_debt = parseFloat(change_arr[0]);
	short_term_debt = parseFloat(change_arr[1]);
	long_term_debt = parseFloat(change_arr[2]);
	hybrid_debt = parseFloat(change_arr[3]);
	equity_balanced = parseFloat(change_arr[4]);
	equity_largecap = parseFloat(change_arr[5]);
	equity_diversified = parseFloat(change_arr[6]);
	equity_midcap = parseFloat(change_arr[7]);
	
	var total = liquid_debt + short_term_debt + long_term_debt + equity_balanced + equity_largecap + equity_midcap + equity_diversified + hybrid_debt;
	
	showRecommendedFunds();
}
function schemeChange(id, category)
{
	var html = '<table class="table">';
	html += "<thead><tr>";
	html += "<th>Scheme Name<input type='hidden' id='selected_scheme_id' value='"+id+"' /></th>";
	html += "<th>Category</th>";
	html += "<th>1 Year Return (%)</th>";
	html += "<th>3 Years Return (%)</th>";
	html += "<th>5 Years Return (%)</th>";
	html += "<th>10 Years Return (%)</th>";
	html += "<th>Inception Return (%)</th>";
	html += "<th width='50'>Select Scheme</th>";
	html += "</tr></thead>";
	html += "<tbody>";
	
	$.ajaxSetup({async:false});
	$.post("/goal/getFundRatingBasedSchemes", {category : category, max_count : 3}, function(data)
    {
		var schemePerformances = $.trim(data);
		var schemePerformances_obj = jQuery.parseJSON(schemePerformances);
		var schemePerformances_array = $.makeArray(schemePerformances_obj);
        count = schemePerformances_array.length;
    	
		for (var i = 0; i < schemePerformances_array.length ; i++)
	    {
			var scheme_name = schemePerformances_array[i].scheme_amfi;
			var scheme_code = schemePerformances_array[i].scheme_amfi_code;
			var scheme_category = schemePerformances_array[i].scheme_category;
			var returns_abs_1year = schemePerformances_array[i].returns_abs_1year;
			var returns_cmp_3year = schemePerformances_array[i].returns_cmp_3year;
			var returns_cmp_5year = schemePerformances_array[i].returns_cmp_5year;
			var returns_cmp_10year = schemePerformances_array[i].returns_cmp_10year;
			var returns_cmp_inception = schemePerformances_array[i].returns_cmp_inception;
			
			if(returns_abs_1year == 0)
			{
				returns_abs_1year = "-";
			}
			if(returns_cmp_3year == 0)
			{
				returns_cmp_3year = "-";
			}
			if(returns_cmp_5year == 0)
			{
				returns_cmp_5year = "-";
			}
			if(returns_cmp_10year == 0)
			{
				returns_cmp_10year = "-";
			}
			if(returns_cmp_inception == 0)
			{
				returns_cmp_inception = "-";
			}
			
			html += "<tr>";
	    	html += "<td><span id='selected_new_scheme_"+i+"'>" + scheme_name + "</span>";
	    	html += "<input type='hidden' id='selected_new_schemecode_"+i+"' value="+scheme_code+"></td>";
	    	html += "<td id='txt_category_new_"+i+"'>" + category + "</td>";
			html += "<td>" + returns_abs_1year + "</td>";
			html += "<td>" + returns_cmp_3year + "</td>";
			html += "<td>" + returns_cmp_5year + "</td>";
			html += "<td>" + returns_cmp_10year + "</td>";
			html += "<td>" + returns_cmp_inception + "</td>";
			html += '<td align="center"><input type="radio" name="select_scheme" value="'+i+'"></td>';
	    	html += "</tr>";
	    }
    },'text');	
	html += "</tbody>"; 
	html += "</table>"; 
	
	$(".popup_select_scheme").html(html);
	
	$("#scheme_name_change_model").modal('show');
}
function changeSchemeName()
{
	var id = $("#selected_scheme_id").val();
	var value = $("input[name='select_scheme']:checked").val();
	if(value != undefined)
	{
		var scheme = $("#selected_new_scheme_"+value).html();
		var scheme_code = $("#selected_new_schemecode_"+value).val();
		var sch_category = $("#txt_category_new_"+id).html();
		$("#span_scheme_"+id).html(scheme);
		$("#span_scheme_code_"+id).val(scheme_code);
	}
	$("#scheme_name_change_model").modal('hide');
}
function showRecommendedFunds()
{
	$('#tbl_portfolio_returns').html("");
	$('#portfolio_div').hide();
	$('#portfolio_spinner_div').show();
	
	remaining_sip_amount = parseFloat(remaining_sip_amount);
	goal_based_amount = remaining_sip_amount;
	
	liquid_debt = parseFloat(liquid_debt);
	short_term_debt = parseFloat(short_term_debt);
	long_term_debt = parseFloat(long_term_debt);
	hybrid_debt = parseFloat(hybrid_debt);
	equity_balanced = parseFloat(equity_balanced);
	equity_largecap = parseFloat(equity_largecap);
	equity_midcap = parseFloat(equity_midcap);
	equity_diversified = parseFloat(equity_diversified);
	
	var cat_rolling_array = new Array();
	if(liquid_debt > 0)
	{
		cat_rolling_array.push("Debt: Liquid");	
	}
	if(short_term_debt > 0)
	{
		cat_rolling_array.push("Debt: Short Duration");
	}
	if(long_term_debt > 0)
	{
		cat_rolling_array.push("Debt: Long Duration");	
	}
	if(hybrid_debt > 0)
	{
		cat_rolling_array.push("Hybrid: Conservative");	
	}
	if(equity_balanced > 0)
	{
		cat_rolling_array.push("Hybrid: Aggressive");	
	}
	if(equity_largecap > 0)
	{
		cat_rolling_array.push("Equity: Large Cap");	
	}
	if(equity_diversified > 0)
	{
		cat_rolling_array.push("Equity: Multi Cap");	
	}
	if(equity_midcap > 0)
	{
		cat_rolling_array.push("Equity: Mid Cap");	
	}
	//alert("cat_rolling_array------>"+cat_rolling_array.length);
	
	var loop_count = 0;
	var html = "";
	var total_percentage = 0;
	var total_amount = 0;
	var last_category_flag = false;
	
	html += "<thead><tr>";
	html += "<th>Scheme Name</th>";
	html += "<th>Category</th>";
	html += "<th class='text-right' width='150'>Allocation Amount</th>";
	html += "<th width='100'>Edit Amount</th>";
	html += "<th width='100'>Save Scheme</th>";
	html += "</tr></thead>";
	html += "<tbody>";
	
	for(k=0;k<cat_rolling_array.length;k++)
    {
		var category = cat_rolling_array[k];
		var count = 0;
		var max_count = 1;
		
		if(k == (cat_rolling_array.length - 1))
		{
			last_category_flag = true;
		}
		
		if(category == "Debt: Liquid")
		{
			if(liquid_debt <= 15)
			{
				max_count = 1;
			}else if(liquid_debt <= 40)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
		}
		if(category == "Debt: Short Duration")
		{
			if(short_term_debt <= 15)
			{
				max_count = 1;
			}else if(short_term_debt <= 40)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
		}
		if(category == "Debt: Long Duration")
		{
			if(long_term_debt <= 15)
			{
				max_count = 1;
			}else if(long_term_debt <= 40)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
		}
		if(category == "Hybrid: Conservative")
		{
			if(hybrid_debt <= 15)
			{
				max_count = 1;
			}else if(hybrid_debt <= 40)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
		}
		if(category == "Hybrid: Aggressive")
		{
			if(equity_balanced <= 15)
			{
				max_count = 1;
			}else if(equity_balanced <= 40)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
		}
		if(category == "Equity: Large Cap")
		{
			if(equity_largecap <= 15)
			{
				max_count = 1;
			}else if(equity_largecap <= 40)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
		}
		if(category == "Equity: Mid Cap")
		{
			if(equity_midcap <= 15)
			{
				max_count = 1;
			}else if(equity_midcap <= 40)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
		}
		if(category == "Equity: Multi Cap")
		{
			if(equity_diversified <= 15)
			{
				max_count = 1;
			}else if(equity_diversified <= 40)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
		}
		
		if(goal_based_amount <= 25000)
		{
			max_count = 1;
		}
		
		$.ajaxSetup({async:false});
		$.post("/goal/getFundRatingBasedSchemes", {category : category, max_count : max_count}, function(data)
	    {
			var schemePerformances = $.trim(data);
			var schemePerformances_obj = jQuery.parseJSON(schemePerformances);
			var schemePerformances_array = $.makeArray(schemePerformances_obj);
	        count = schemePerformances_array.length;
	        var scheme_flag = false;
	    	
			for (var i = 0; i < schemePerformances_array.length ; i++)
		    {
				var scheme_name = schemePerformances_array[i].scheme_amfi;
				var scheme_code = schemePerformances_array[i].scheme_amfi_code;
				var scheme_category = schemePerformances_array[i].scheme_category;
				loop_count++;
				
				if(i == (count - 1))
				{
					scheme_flag = true;
				}
		    	
		    	html += "<tr>";
		    	html += '<td class="td_scheme_'+loop_count+'"><span id="span_scheme_'+loop_count+'">' + scheme_name + '</span> | <a  style="font-size: 10px;color:blue;" href="javascript:;" onclick="schemeChange('+loop_count+', \''+category+'\')">Change Scheme</a>';
		    	html += '<input type="hidden" value="'+scheme_code+'" id="span_scheme_code_'+loop_count+'" />';
		    	html += '</td>';
		    	//if(i == 0)
		    	{
		    		html += "<td id='txt_category_"+loop_count+"'>" + category + "</td>";
		    		
		    		if(category == "Debt: Liquid")
			        {
		    			var value = liquid_debt / count;
	    				var value1 = goal_based_amount * (value / 100);
		    			if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
			    			value1 = Math.round(value1 / 500) * 500;
			    			value = (value1 / goal_based_amount) * 100;
			    			if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
		    			total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 text-right allocaton_amount' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(0)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Debt: Short Duration")
			        {
			        	var value = short_term_debt / count;
		    			var value1 = goal_based_amount * (value / 100);
		    			
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
			    			value1 = Math.round(value1 / 500) * 500;
			    			value = (value1 / goal_based_amount) * 100;
			    			if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}			    			
		    			}
			        	total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 text-right allocaton_amount' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(0)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Debt: Long Duration")
			        {
			        	var value = long_term_debt / count;
	    				var value1 = goal_based_amount * (value / 100);
	    				
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
			    			value1 = Math.round(value1 / 500) * 500;
			    			value = (value1 / goal_based_amount) * 100;
			    			if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
			        	total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 text-right allocaton_amount' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(0)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Hybrid: Conservative")
			        {
			        	var value = hybrid_debt / count;
	    				var value1 = goal_based_amount * (value / 100);
	    				
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
			    			value1 = Math.round(value1 / 500) * 500;
			    			value = (value1 / goal_based_amount) * 100;
			    			if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
		    			total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 text-right allocaton_amount' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(0)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Hybrid: Aggressive")
			        {
			        	var value = equity_balanced / count;
	    				var value1 = goal_based_amount * (value / 100);
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
			    			value1 = Math.round(value1 / 500) * 500;
			    			value = (value1 / goal_based_amount) * 100;
			    			if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
			        	total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
			        	
			        	html += "<td><input type='text' class='fc-2 text-right allocaton_amount' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(0)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Equity: Large Cap")
			        {
			        	var value = equity_largecap / count;
			        	var value1 = goal_based_amount * (value / 100);
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
			    			value1 = Math.round(value1 / 500) * 500;
			    			value = (value1 / goal_based_amount) * 100;
			    			if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
			        	total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 text-right allocaton_amount' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(0)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Equity: Multi Cap")
			        {
			        	var value = equity_diversified / count;
			        	var value1 = goal_based_amount * (value / 100);
			        	
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
			    			value1 = Math.round(value1 / 500) * 500;
			    			value = (value1 / goal_based_amount) * 100;
			    			if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
			        	total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
			        	
			        	html += "<td><input type='text' class='fc-2 text-right allocaton_amount' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(0)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Equity: Mid Cap")
			        {
			        	var value = equity_midcap / count;
			        	var value1 = goal_based_amount * (value / 100);
			        	
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
			    			value1 = Math.round(value1 / 500) * 500;
			    			value = (value1 / goal_based_amount) * 100;
			    			if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
			        	total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 text-right allocaton_amount' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(0)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }
		    	}
		    	html += '<td class="text-center"><button class="btn btn-primary" id="btn_'+loop_count+'" onclick="editScheme('+loop_count+')"> Edit </button></td>';
             	html += '<td class="text-center"><input type="checkbox" name="save_goal" value="'+loop_count+'"></td>';
		    	html += "</tr>";
		    }
			
	    },'text');	
    }
	
	html += "</tbody>"; 
	html += "<tfoot>"; 
	html += "<tr>";
	html += "<td></td>";
	html += "<td>Total</td>";
	html += "<td><input type='text' class='fc-2 text-right' id='allocation_amount_total' value='"+numbersWithComma(parseFloat(goal_based_amount).toFixed(0))+"' disabled='disabled'></td>";
	html += "<td></td>";
	html += "<td></td>";
	html += "</tfoot>"; 
	
	$('#tbl_portfolio_returns').html(html);
	$('#portfolio_spinner_div').hide();
	$(".growth").show();
	
	$(".robo1").hide();
	$(".robo2").hide();
	$(".robo3").hide();
	$(".robo4").hide();
	$(".robo5").show();

	var rate_of_return = 8;
	if(risk == "Aggressive")
    {
        rate_of_return = 14;
    }else if(risk == "Moderately Aggressive")
    {
        rate_of_return = 12.5;
    }else if(risk == "Moderate")
    {
        rate_of_return = 11.5;
    }else if(risk == "Moderately Conservative")
    {
        rate_of_return = 10;
    }else
    {
        rate_of_return = 8;
    }  
	rate_of_return = parseFloat(rate_of_return);
	var years = parseInt(horizon);
	var d = new Date();
	var current_year = d.getFullYear();
	var current_month = d.getMonth(); 
	var yearNameArr = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
	var yearArr = new Array();
	var mon = years * 12;
	var final_amount = 0;
	var value1 = (rate_of_return / 100) / 12;
	var value3 = 1 + value1;
	var principalArr = new Array();
	var balanceArr = new Array();
	
	for(var k=1;k<=mon;k++)
	{
		var value4 = Math.pow((value3), (k + 1));
	    var amount1 = (value4 - 1);
	    var amount2 = amount1 / value1;
	    final_amount = (goal_based_amount * amount2) - goal_based_amount;
	    final_amount = Math.round(final_amount);
	    var invest_amount = goal_based_amount * k;
	    var interest_total = final_amount - invest_amount;
	    yearArr.push(yearNameArr[current_month]+"-"+current_year);
		principalArr.push(invest_amount);
		balanceArr.push(final_amount);
	    current_month++;
		if(current_month >= 12)
		{
			current_month = 0;
			current_year = current_year + 1;
		}
	}
	
	var invested_amount = mon * goal_based_amount;
	invested_amount = Math.round(invested_amount);
	var growth = final_amount - invested_amount;
	growth = Math.round(growth);

	$("#spn_total_cost").html(numbersWithComma(invested_amount));
	$("#spn_months").html(mon);
	$("#spn_gain").html(numbersWithComma(growth));
	$("#spn_future_cost").html(numbersWithComma(invested_amount + growth));

	$('#portfolio_div').show();
	
	$("html, body").animate({ scrollTop: 170 }, "slow");
	
	initializeTypeAhead();	
}

function initializeTypeAhead()
{	
	$('input.number1').change(function() {
		$(this).val(function(index, value) {
			value = value.replace(/,/g,'');
			value = numbersWithComma(parseFloat(value).toFixed(2));
			if(value == "NaN"){
				value = 0;
			}
		    return value;
		});
	});
}
function changeAmount(count)
{
	var value = $("#txt_allocation_amount_"+count).html();
	if(value == "" || parseFloat(value) <= 0)
	{
		value = 0.0;
		$("#txt_allocation_amount_"+count).html(parseFloat(value).toFixed(2));
	}
	
	var total_amount = 0;
	$(".allocaton_amount" ).each(function( index ) {
		var value = $(this).val();
		value = value.replace(/,/g,'');
		if(value != "")
		{
			total_amount = parseFloat(total_amount) + parseFloat(value);
		}
	});
	
	$("#allocation_amount_total").val(parseFloat(total_amount).toFixed(2));	
}
function editScheme(count)
{
	var value = $("#btn_"+count).html();
	if(value == "Edit")
	{
		var flag = true;
		$(".btn-edit" ).each(function( index ) {
			var btn_text = $( this ).html();
			if(btn_text == "Save")
			{
				flag = false;
				alert("Please save the row already edited. Then click edit button.");
				return false;
			}
		});
		
		if(flag)
		{
			$("#txt_allocation_amount_"+count).attr('disabled',false);
			$("#btn_"+count).html("Save");
		}
	}else
	{
		$("#txt_allocation_amount_"+count).attr('disabled',true);
		$("#btn_"+count).html("Edit");
	}
}
function saveGoal(goal_type)
{
	var existing_folio_array = new Array();
	var existing_scheme_array = new Array();
	var existing_scheme_code_array = new Array();
	var existing_scheme_current_value_array = new Array();
	var existing_scheme_sip_array = new Array();
	var scheme_array = new Array();
	var category_array = new Array();
	var percentage_array = new Array();
	var amount_array = new Array();

	$("input[name='save_goal_exist']:checked").each(function()
	{
		var count = $(this).val();
		var scheme = $("#td_scheme_"+count).html();
		var scheme_code = $("#td_scheme_code_"+count).val();
		var folio_no = $("#td_folio_"+count).html();
		var current_value = $("#td_current_value_"+count).html();
		var scheme_sip = $("#span_scheme_sip_amount_"+count).html();
		
		if(scheme_sip == undefined || scheme_sip == "undefined" || scheme_sip == null || scheme_sip == "")
		{
			scheme_sip = "0";
		}
		current_value = current_value.replace(/,/g,'');
		scheme_sip = scheme_sip.replace(/,/g,'');
		
		existing_scheme_array.push(scheme);
		existing_scheme_code_array.push(scheme_code);
		existing_folio_array.push(folio_no);
		existing_scheme_current_value_array.push(current_value);
		existing_scheme_sip_array.push(scheme_sip);
	});

	$("input[name='save_goal']:checked").each(function()
	{
		var count = $(this).val();
		var scheme_name = $("#span_scheme_"+count).html();
	    var scheme_code = $("#span_scheme_code_"+count).val();
	    var category = $("#txt_category_"+count).html();
	    var allocation_percentage = 0;
	    var allocation_amount = $("#txt_allocation_amount_"+count).val();
	    
	    allocation_amount = allocation_amount.replace(/,/g,'');

	    //console.log("count-->"+count+"--scheme-->"+scheme_name+"--scheme_code-->"+scheme_code+"--category-->"+category+"--allocation_amount-->"+allocation_amount);
	      
	    scheme_array.push(scheme_name);
	    category_array.push(category);
	    percentage_array.push(allocation_percentage);
	    amount_array.push(allocation_amount);
	});
	
	if(existing_folio_array.length > 0)
	{
		sip_amount = remaining_sip_amount.toFixed(0);
	}
	
	if(goal_type == 2 && scheme_array.length == 0)
	{
		swal({title:"" , text:"Please select the scheme and save your goal."});
		return false;
	}
	
	var existing_folio_str = existing_folio_array.toString();
	var existing_scheme_str = existing_scheme_array.toString();
	var existing_scheme_code_str = existing_scheme_code_array.toString();
	var existing_scheme_current_value_str = existing_scheme_current_value_array.toString();
	var existing_scheme_sip_str = existing_scheme_sip_array.toString();
	var scheme_array_str = scheme_array.toString();
	var category_array_str = category_array.toString();
	var percentage_array_str = percentage_array.toString();
	var amount_array_str = amount_array.toString();
	
	$.ajaxSetup({async:false});
	$.post("/goal/saveGoal", {target_goal : "" + target_goal + "",goal_name : "" + goal_name + "",amount : "" + amount + "",
		horizon : "" + horizon + "",inflation : "" + inflation + "",risk : "" + risk + "",target_amount : "" + target_amount + "",sip_amount : "" + sip_amount + "",
		scheme_array : "" + scheme_array_str + "",category_array : "" + category_array_str + "",percentage_array : "" + percentage_array_str + "",
		amount_array : "" + amount_array_str + "",existing_folio : "" + existing_folio_str + "",existing_scheme : "" + existing_scheme_str + "",
		existing_scheme_code : "" + existing_scheme_code_str + "",existing_scheme_sip : "" + existing_scheme_sip_str + "",existing_scheme_current_value : "" + existing_scheme_current_value_str + ""}, function(data)
    {
		var result = $.trim(data);
  		var obj = jQuery.parseJSON(result);
   		if(obj.status == 400)
   		{  
          	swal({title:"",text:"" +obj.msg});
   			return false;
   		}
   		
		swal({title:"",text:"Your goal based investement plan successfully saved."},
		function(){
			top.location = "https://mfportfolio.dakshincapital.com/bse/bse-goal-based-sip-investment?userid="+userid+"&id="+obj.msg;
		});
		return;
		
    },'text');
}
function showLogin(goal_type)
{
	var existing_folio_array = new Array();
	var existing_scheme_array = new Array();
	var existing_scheme_code_array = new Array();
	var existing_scheme_current_value_array = new Array();
	var existing_scheme_sip_array = new Array();
	var scheme_array = new Array();
	var category_array = new Array();
	var percentage_array = new Array();
	var amount_array = new Array();

	$("input[name='save_goal_exist']:checked").each(function()
	{
		var count = $(this).val();
		var scheme = $("#td_scheme_"+count).html();
		var scheme_code = $("#td_scheme_code_"+count).val();
		var folio_no = $("#td_folio_"+count).html();
		var current_value = $("#td_current_value_"+count).html();
		var scheme_sip = $("#span_scheme_sip_amount_"+count).html();
		
		if(scheme_sip == undefined || scheme_sip == "undefined" || scheme_sip == null || scheme_sip == "")
		{
			scheme_sip = "0";
		}
		current_value = current_value.replace(/,/g,'');
		scheme_sip = scheme_sip.replace(/,/g,'');
		
		existing_scheme_array.push(scheme);
		existing_scheme_code_array.push(scheme_code);
		existing_folio_array.push(folio_no);
		existing_scheme_current_value_array.push(current_value);
		existing_scheme_sip_array.push(scheme_sip);
	});

	$("input[name='save_goal']:checked").each(function()
	{
		var count = $(this).val();
		var scheme_name = $("#span_scheme_"+count).html();
	    var scheme_code = $("#span_scheme_code_"+count).val();
	    var category = $("#txt_category_"+count).html();
	    var allocation_percentage = 0;
	    var allocation_amount = $("#txt_allocation_amount_"+count).val();
	    
	    allocation_amount = allocation_amount.replace(/,/g,'');

	    //console.log("count-->"+count+"--scheme-->"+scheme_name+"--scheme_code-->"+scheme_code+"--category-->"+category+"--allocation_amount-->"+allocation_amount);
	      
	    scheme_array.push(scheme_name);
	    category_array.push(category);
	    percentage_array.push(allocation_percentage);
	    amount_array.push(allocation_amount);
	});
	
	if(existing_folio_array.length > 0)
	{
		sip_amount = remaining_sip_amount.toFixed(0);
	}
	
	if(goal_type == 2 && scheme_array.length == 0)
	{
		swal({title:"" , text:"Please select the scheme and save your goal."});
		return false;
	}
	
	var existing_folio_str = existing_folio_array.toString();
	var existing_scheme_str = existing_scheme_array.toString();
	var existing_scheme_code_str = existing_scheme_code_array.toString();
	var existing_scheme_current_value_str = existing_scheme_current_value_array.toString();
	var existing_scheme_sip_str = existing_scheme_sip_array.toString();
	var scheme_array_str = scheme_array.toString();
	var category_array_str = category_array.toString();
	var percentage_array_str = percentage_array.toString();
	var amount_array_str = amount_array.toString();
	
	$.ajaxSetup({async:false});
	$.post("/goal/saveGoalWithOutLogin", {target_goal : "" + target_goal + "",goal_name : "" + goal_name + "",amount : "" + amount + "",
		horizon : "" + horizon + "",inflation : "" + inflation + "",risk : "" + risk + "",target_amount : "" + target_amount + "",sip_amount : "" + sip_amount + "",
		scheme_array : "" + scheme_array_str + "",category_array : "" + category_array_str + "",percentage_array : "" + percentage_array_str + "",
		amount_array : "" + amount_array_str + "",existing_folio : "" + existing_folio_str + "",existing_scheme : "" + existing_scheme_str + "",
		existing_scheme_code : "" + existing_scheme_code_str + "",existing_scheme_sip : "" + existing_scheme_sip_str + "",existing_scheme_current_value : "" + existing_scheme_current_value_str + ""}, function(data)
    {
		var result = $.trim(data);
  		var obj = jQuery.parseJSON(result);
   		if(obj.status == 400)
   		{  
          	swal({title:"",text:"" +obj.msg});
   			return false;
   		}
   		
   		top.location = "https://mfportfolio.dakshincapital.com?authcode="+$.trim(obj.msg);
		return;
		
    },'text');
}
function riskQuestionBack()
{
	if(ques_flag != 1)
	{
		ques_flag = ques_flag - 1;
		$('#slider').gotoSlide('slider_'+ques_flag);
	}else
	{
		redirect();
	}
}
function riskQuestionNext(ques_flag)
{
	var answer = $("input[type='radio'][name='q"+ ques_flag +"']:checked").val();
    
    if (answer == undefined) 
    {
    	swal({title:"",text:"Please answer the question"});
		return false;
    }
    return true;
}
function completeStep2()
{
	var answer1 = $("input[type='radio'][name='q1']:checked").val();
    var answer2 = $("input[type='radio'][name='q2']:checked").val();
    var answer3 = $("input[type='radio'][name='q3']:checked").val();
    var answer4 = $("input[type='radio'][name='q4']:checked").val();
    var answer5 = $("input[type='radio'][name='q5']:checked").val();
    var answer6 = $("input[type='radio'][name='q6']:checked").val();
    
    if (answer1 == undefined || answer2 == undefined || answer3 == undefined || answer4 == undefined || answer5 == undefined || answer6 == undefined /* || answer7 == undefined || answer8 == undefined */) 
    {
    	swal({title:"",text:"Please answer all the questions"});
		return;
    }
   
	$.ajaxSetup({async:false});
	$.post("/goal/getRiskProfile", {answer1 : answer1, answer2 : answer2, answer3 : answer3, answer4 : answer4, answer5 : answer5, answer6 : answer6}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
        risk = obj.risk_profile;
        $("#risk_result").html(risk.toUpperCase());
        var risk_str = "";
        swal({html:true,title:"",text:"As per our risk assessment, your risk tolerance is <br><b>"+risk+"</b>"});
        $(".robo0").show();
        $(".robo1").show();
 		$(".robo2").hide();
 		$("#sel_risk").val(risk);     
    },'text');	
}

function show_ques_div(i) {
	 
    switch (i) {
        case 1:
        	if(riskQuestionNext(1))
        	{
        		$("#step1").hide();
        		$("#step2").show();
        		$("#step3").hide();
        		$("#step4").hide();
        		$("#step5").hide();
        		$("#step6").hide();
        		$("#step7").hide(); 
        	}
            break;
        case 2:
        	if(riskQuestionNext(2))
        	{
        		$("#step1").hide();
        		$("#step2").hide();
        		$("#step3").show();                		
        		$("#step4").hide();
        		$("#step5").hide();
        		$("#step6").hide();
        		$("#step7").hide();
        	}
            break;
        case 3:
        	if(riskQuestionNext(3))
        	{
        		$("#step1").hide();
        		$("#step2").hide();
        		$("#step3").hide();
        		$("#step4").show();
        		$("#step5").hide();
        		$("#step6").hide();
        		$("#step7").hide();
        	}
            break;
        case 4:
        	if(riskQuestionNext(4))
        	{
        		$("#step1").hide();
        		$("#step2").hide();
        		$("#step3").hide();
        		$("#step4").hide();
        		$("#step5").show();                		
        		$("#step6").hide();
        		$("#step7").hide(); 
        	}

            break;
        case 5:
        	if(riskQuestionNext(5))
        	{
        		$("#step1").hide();
        		$("#step2").hide();
        		$("#step3").hide();
        		$("#step4").hide();
        		$("#step5").hide();
        		$("#step6").show();
        		$("#step7").hide(); 
					 
        	}
            break;
        case 6:
        	if(riskQuestionNext(6))
        	{
        		$("#step1").hide();
        		$("#step2").hide();
        		$("#step3").hide();
        		$("#step4").hide();
        		$("#step5").hide();
        		$("#step6").hide();
        		$("#step7").show(); 
			    completeStep2();
        	}
            break;
        
        default:
    }
   return true;

}
	 function hide_div(i) {
	 
           switch (i) {
               case 1:

                   break;
               case 2:
                   document.getElementById("step1").style.display = 'block';
                   document.getElementById("step2").style.display = 'none';
				 document.getElementById("step3").style.display = 'none';
				  document.getElementById("step4").style.display = 'none';
				   document.getElementById("step5").style.display = 'none';
				    document.getElementById("step6").style.display = 'none';
					 document.getElementById("step7").style.display = 'none';
            
                   break;
               case 3:
                  document.getElementById("step1").style.display = 'none';
                   document.getElementById("step2").style.display = 'block';
				 document.getElementById("step3").style.display = 'none';
				  document.getElementById("step4").style.display = 'none';
				   document.getElementById("step5").style.display = 'none';
				    document.getElementById("step6").style.display = 'none';
					 document.getElementById("step7").style.display = 'none';
                   break;
               case 4:
                   document.getElementById("step1").style.display = 'none';
                   document.getElementById("step2").style.display = 'none';
				 document.getElementById("step3").style.display = 'block';
				  document.getElementById("step4").style.display = 'none';
				   document.getElementById("step5").style.display = 'none';
				    document.getElementById("step6").style.display = 'none';
					 document.getElementById("step7").style.display = 'none';
                   break;
               case 5:
                  document.getElementById("step1").style.display = 'none';
                   document.getElementById("step2").style.display = 'none';
				 document.getElementById("step3").style.display = 'none';
				  document.getElementById("step4").style.display = 'block';
				   document.getElementById("step5").style.display = 'none';
				    document.getElementById("step6").style.display = 'none';
					 document.getElementById("step7").style.display = 'none';
                   break;
               case 6:
                 document.getElementById("step1").style.display = 'none';
                   document.getElementById("step2").style.display = 'none';
				 document.getElementById("step3").style.display = 'none';
				  document.getElementById("step4").style.display = 'none';
				   document.getElementById("step5").style.display = 'block';
				    document.getElementById("step6").style.display = 'none';
					 document.getElementById("step7").style.display = 'none';
                   break;
               case 7:
                 document.getElementById("step1").style.display = 'none';
                   document.getElementById("step2").style.display = 'none';
				 document.getElementById("step3").style.display = 'none';
				  document.getElementById("step4").style.display = 'none';
				   document.getElementById("step5").style.display = 'none';
				    document.getElementById("step6").style.display = 'block';
					 document.getElementById("step7").style.display = 'none';
                   break;
               

               default:
           }

          return true;
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
function showLoginModel(){
	$("#login_model").modal('show');
}
function checkLoginDetails()
{
	var mobile = $("#txt_login_id").val();
    var password =  $("#txt_login_pass").val();
    
    if(mobile == "" || mobile.length != 10)
    {
    	swal({title:"Invalid Mobile",text:"Enter your valid Mobile number"});
   	    return false;
    }
    if(password == "")
    {
    	swal({title:"",text:"Enter valid password"});
   	    return false;
    }
    if(password.length < 6 || password.length > 16)
    {
    	swal({title:"",text:"Password must have minimum of 6 characters and maximum 16 characters"});
   	    return false;
    }
    
    $.LoadingOverlay("show");
    
    $.ajaxSetup({async:true});
	$.post("/validateLogin", {mobile : ""+mobile+"", password : ""+password+""}, function(data)
    {
		$.LoadingOverlay("hide");
		
		var result = $.trim(data);
  		var obj = jQuery.parseJSON(result);
  		
   		if(obj.status == 400)
   		{
   			swal({title:"",text:obj.msg});
   			return false;
   		}

   		$("#login_model").modal('hide');

   		swal({title:"",text:"You are successfully logged in."},
		function(){
   			top.location = "/goal/emergency?amount="+amount+"&age="+age+"&inflation="+inflation+"&risk="+risk+"&goal_name="+goal_name;
		});
		return;
		          
    }, "text");
}
function showSelectedValues()
{
	var total_amt = 0;
	$("input[name='save_goal_exist']:checked").each(function()
	{
		var count = $(this).val();
		var future_value = $("#td_future_value_"+count).html();
		
		future_value = future_value.replace(/,/g,'');

		total_amt = total_amt + parseInt(future_value);
	});
	$("#span_scheme_cost").html(numbersWithComma(total_amt));

	if(total_amt > target_amount){
		swal({title:"",text:"Selected Scheme is enough to achieve this goal."});
		return;
	}
}
</script>

<div class="container-fluid">

<div class="row">
<div class="robo1 ques_1">  

<div class="row"> 
<div class="col-md-12 col-sm-12">
<div class="title-v1">
	<h1 class="goal_name text-center">Emergency Goal</h1>
</div>
</div>
</div>

<div class="row">   
<div class="col-md-12 col-sm-12" style="margin:0 auto; float:none; text-align:center;">
<div class="row pt-4">
<div class="col-md-12 form-inline">
<div class="row" style="width: 100%;margin:0px;">
<div class="col lamount" style="float:none;">
	<div class="text_size"><b>Your age is</b></div>
	<input type="text" value="30" id="txt_current_age" class="fc-2" onchange="ageChange()" maxlength="2" />
	<div id="age_slider" style="margin:0px;"></div>
</div>
<div class="col lamount" style="float:none;">
	<div class="text_size"><b>Average monthly expense</b></div>
	<input type="text" value="50000" id="txt_amount" class="fc-2" onchange="amountChange()" maxlength="12" />
	<div id="amount_slider" style="margin:0px;"></div>
</div>
<div class="col lamount" style="float:none;">
	<div class="text_size"><b>Assumed inflation</b></div>
	<input type="text" value="5" id="txt_inflation" class="fc-2" onchange="inflationChange()" maxlength="2" />
	<div id="inflation_slider" style="margin:0px;"></div>
</div>
<div class="col lamount" style="float:none;">
	<div class="text_size"><b>Goal name</b></div>
	<input type="text" value="" id="txt_goal_name" class="fc-2" maxlength="50" />
</div>
</div>
</div>
</div>

<div class="row">
<div class="col-md-12 text-center py-5">	
<button class="btn btn-primary hidden-xs" style="margin:0 auto; float: none;" onclick="checkResult()">Build My Emergency Goal</button>
</div>
</div>

</div> 
</div>
</div>
</div>
</div>

<div class="robo3">
<div class="row">
<div class="col-lg-2">
</div>
<div class="col-lg-8">
<div class="mission_body">
<div class="row">
<div class="col-lg-12">
<div style="display:inline-block;width:92%;">
<div class="text-center" style="padding-bottom:3%;">
<h3>Goal Summary</h3>
</div>
</div>
<div style="display:inline-block;">
<div class="text-right">
<a href="javascript:void(0)" onclick="goToStep1()">
<img src="/images/back_img.png" alt="" style="width:40px;" />
</a>
</div>
</div>
</div>
</div>
<div class="row">
	<div class="col-lg-6 col-sm-4 text-center mb-3">
		<div class="box bg-tf p-3">
			<h6><i class="fa fa-inr" aria-hidden="true"></i> <span id="span_invest_today_cost"></span></h6>
			<p>Your Targeted Amount<br>(in today's value)</p>
		</div>
	</div>
	<div class="col-lg-6 col-sm-4 text-center mb-3">
		<div class="box bg-tf p-3">
			<h6><i class="fa fa-inr" aria-hidden="true"></i> <span id="span_invest_future_cost"></span></h6>
			<p>Future value of your Emergency<br>(adjusting for <span class="span_inflation"></span>% inflation)</p>
		</div>
	</div>
	<div class="col-lg-6 col-sm-4 text-center mb-3">
		<div class="box bg-tf p-3">
			<h6><span id="span_no_years"></span></h6>
			<p>Number of Years<br>You Need To Save</p>
			<p></p>
		</div>
	</div>
	<div class="col-lg-6 col-sm-4 text-center mb-3">
		<div class="box bg-tf p-3">
			<h6><i class="fa fa-inr" aria-hidden="true"></i> <span id="span_sip_amt"></span></h6>
			<p>Monthly SIP Investment<br>Required</p>
			<p></p>
		</div>
	</div>
	<div class="col-lg-6 col-sm-4 text-center mb-3">
	<c:choose>
	<c:when test="${accountMap != null}">
		<a href="javascript:void(0)" onclick="showFunds()">
		<div class="box bg-tf p-3 plutus3">
			<p class="plutus_bold">Are you an existing client?</p>
			<p style="font-size:12px;line-height:15px;margin-top:10px;">If yes, please click here and map your existing investments to this goal</p>
		</div>
		</a>
	</c:when>
	<c:otherwise>
		<a href="javascript:void(0)" onclick="showLoginModel()">
		<div class="box bg-tf p-3 plutus3">
			<p class="plutus_bold">Are you an existing client?</p>
			<p style="font-size:12px;line-height:15px;margin-top:10px;">If yes, please click here and map your existing investments to this goal</p>
		</div>
		</a>
	</c:otherwise>
	</c:choose>
	</div>
	<div class="col-lg-6 col-sm-4 text-center mb-3">
		<a href="javascript:void(0)" onclick="calculateDebtAndEquity()">
		<div class="box bg-tf p-3 plutus2">
			<p class="plutus_bold">No, I do not have investments with you</p>
			<p style="font-size:12px;line-height:15px;margin-top:10px;">Take me to the plan without mapping any existing investments</p>
		</div>
		</a>
	</div>
</div>
</div>
</div>
<div class="col-lg-2">
</div>
</div>
</div>

<div class="container robo4">
<div class="row">
<div class="col-md-12">	  
<div class="row"> 
<div class="col-md-12">
<h1 class="text-center">Emergency Goal</h1>
<h2 class="text-center"><b style="font-weight: 400;"></b></h2>
</div>
</div>

</div>
<div class="col-lg-8 pt-4 offset-lg-2">

<div class="row">
	<div class="col-lg-6 col-sm-4 text-center mb-3">
		<div class="box bg-tf p-3">
			<h6><i class="fa fa-inr" aria-hidden="true"></i> <span id="span_sch_future_cost"></span></h6>
			<p>Future value of your Emergency<br>(adjusting for <span class="span_inflation"></span>% inflation)</p>
		</div>
	</div>
	<div class="col-lg-6 col-sm-4 text-center mb-3">
		<div class="box bg-tf p-3">
			<h6><i class="fa fa-inr" aria-hidden="true"></i> <span id="span_scheme_cost">0</span></h6>
			<p>Total Future Value<br>(Scheme Selected Value)</p>
		</div>
	</div>
</div>
	 
<div class="row existing_div">
<div class="col-lg-12">
<h4 class="textColor">Existing Portfolio</h4>
</div>
</div>

<div class="existing_portfolio_div">
	 
<div class="row existing_div" >
<div class="col-lg-12">
<div class="table-responsive">
<table class="table table-bordered body-color" id="tbl_existing_portfolio_returns" style="width:100%;margin-bottom: 10px;"></table>
</div>
<p>If you wish to link any of the above schemes with this goal, then please check the relevant box/es as given alongside the scheme name.</p>
</div>
</div>

<div class="row pt-3 existing_div">
<div class="col-lg-12 text-right">
<input type="hidden" value="${folio_list}" id="txt_folio_list" />
<input type="hidden" value="${scheme_code_list}" id="txt_scheme_code_list" />
<button class="btn btn-primary col-lg-border-custom col-lg-custom btn-radius border-orange" onclick="goToStep2()">Back</button>
<button class="btn btn-border col-lg-custom bg-RoboGoal btn-radius ml-2 border-blue" onclick="showSummary()">Next</button>
<hr>
</div>
</div>
	 
<div class="row pb-2 existing_summary_div">
<div class="col-lg-12">
<h4 class="textColor">Goal Summary</h4>
<table class="table" id="existing_summary_inner_div">
<tbody>
<tr>
<td class="border-top-0">Your targeted Amount (Inflation adjusted <span class="span_inflation">5</span>% per annum)</td>
<td class="border-top-0"> <input type="text" class="fc-2 fundNamebg" value="" id="txt_goal_amount" disabled="disabled"></td>
</tr>
<tr>
<td>Number of years you need to save </td>
<td><input type="text" class="fc-2 fundNamebg" value="" id="txt_goal_years" disabled="disabled"></td>
</tr>
<tr class="goal_ques">
<td>Monthly SIP investment required</td>
<td><input type="text" class="fc-2 fundNamebg" value=" " id="txt_goal_sip_amount"></td>
</tr>
</tbody>
</table>
</div>
</div>

</div>

<div class="row pb-5 pt-3" id="save_goal_div">
<div class="col-lg-12 text-center">
<button class="btn btn-primary col-lg-border-custom col-lg-custom btn-radius border-orange" onclick="goToStep2()">Back</button>
<c:choose>
<c:when test="${accountMap != null}">
	<button class="btn btn-border col-lg-custom bg-RoboGoal btn-radius ml-2 border-blue" style="width: auto;" onclick="saveGoal(1)">Save Your Goal</button>
</c:when>
<c:otherwise>
	<button class="btn btn-border col-lg-custom bg-RoboGoal btn-radius ml-2 border-blue" style="width: auto;" onclick="showLogin(1)">Save Your Goal</button>
</c:otherwise>
</c:choose>
</div>
</div>


<div class="row pb-5 pt-3" id="recommended_div">
<div class="col-lg-12 text-right">
<button class="btn btn-primary col-lg-border-custom col-lg-custom btn-radius border-orange" onclick="goToStep2()">Back</button>
<button class="btn btn-border bg-RoboGoal btn-radius ml-2 border-blue" onclick="calculateDebtAndEquity()">Achieve your Goal on SIP</button>
</div>
</div>

</div>
	 
</div>
</div>

<div class="container marginTop35 robo5">
<div class="row">
<div class="col-md-12">  
<div class="row"> 
<div class="col-md-12">
<h1 class="text-center">Emergency Goal</h1>
<h2 class="text-center"><b style="font-weight: 400;"></b></h2>
</div>
</div>
</div>
<div class="col-lg-12 pt-4">
<div class="row" style="border-bottom: 1px solid #ddd;margin: 0px;">
	<div class="col-md-3 col-sm-3 col-xs-12">
		<div class="list-group-item" style="border: none;text-align: center;">
	         <div class="head" style="padding-bottom: 20px;">
	             <span style="font-size: 16px; color: #233e62;">Total Investment</span>
	         </div>
	         <span class="value"><i class="fa fa-inr"></i>  <span id="spn_total_cost"></span> </span>
	     </div>
	</div>
	<div class="col-md-3 col-sm-3 col-xs-12">
		<div class="list-group-item" style="border: none;text-align: center;">
	         <div class="head" style="padding-bottom: 20px;">
	             <span style="font-size: 16px; color: #233e62;">Months</span>
	         </div>
	         <span class="value"><span id="spn_months"></span> </span>
	     </div>
	</div>
	<div class="col-md-3 col-sm-3 col-xs-12">
		<div class="list-group-item" style="border: none;text-align: center;">
	         <div class="head" style="padding-bottom: 20px;">
	             <span style="font-size: 16px; color: #233e62;">Total Growth</span>
	         </div>
	         <span class="value"><i class="fa fa-inr"></i>  <span id="spn_gain"></span> </span>
	     </div>
	</div>
	<div class="col-md-3 col-sm-3 col-xs-12">
		<div class="list-group-item" style="border: none;text-align: center;">
	         <div class="head" style="padding-bottom: 20px;">
	             <span style="font-size: 16px; color: #233e62;">Future Worth</span>
	         </div>
	         <span class="value"><i class="fa fa-inr"></i>  <span id="spn_future_cost"></span> </span>
	     </div>
	</div>
</div>
<div class="row" style="margin-top: 30px;">
<div class="col-lg-12">
       <div id="portfolio_div" class="portfolio_div">
          <div class="row" >
             <div class="col-lg-12">
                <div class="table-responsive mf-research">
                   <div class="row" style="margin: 0px;">
                    <div class="col-md-8 col-sm-8">
                   	 	<h3 style="text-decoration-line:underline;text-decoration-style: dotted;text-underline-offset: 5px;">Recommended Portfolio</h3>
                    </div>
                    <div class="col-md-4 col-sm-4 text-right">
  						<span class="check_all_btn font-size-14">Select All Schemes</span>
  					</div>
 					</div>
                   <table id="tbl_portfolio_returns" class="table" style="background-color:#fff;"></table>
                </div>
             </div>
          </div>
       </div>
    </div>
</div>
<div class="row pb-5 pt-3">
<div class="col-lg-12 text-right">
<c:choose>
<c:when test="${accountMap != null}">
	<button class="btn btn-primary col-lg-border-custom col-lg-custom" onclick="goToStep3()">Back</button>
	<button type="submit" class="btn btn-border col-lg-custom ml-2" onclick="saveGoal(2)">Save Your Goal</button>
</c:when>
<c:otherwise>
	<button class="btn btn-primary col-lg-border-custom col-lg-custom" onclick="goToStep2()">Back</button>
	<button type="submit" class="btn btn-border col-lg-custom ml-2" onclick="showLogin(2)">Save Your Goal</button>
</c:otherwise>
</c:choose>
</div>
</div>


</div>
</div>
</div>

<div id="login_model" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-dialog-centered" style="max-width:500px !important;">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">Login</div>
      <div class="modal-body">
      <div class="row" style="padding-bottom:20px;">
      <div class="col-md-4" style="float:left;">
      <label>Mobile Number:</label>
      </div>
      <div class="col-md-6" style="float:left;">
      <input type="text" value="" id="txt_login_id" />
      </div>
      </div>
      <div class="row">
      <div class="col-md-4" style="float:left;">
      <label>Password:</label>
      </div>
      <div class="col-md-6" style="float:left;">
      <input type="password" value="" id="txt_login_pass" />
      </div>
      </div>
      </div>
      <div class="modal-footer">
		<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
		<button class="btn btn-success" type="submit" onclick="checkLoginDetails()">Login</button>
	</div>
    </div>
  </div>
</div>
