<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.robo2,.robo3,.portfolio_div,.overview_div,.historical_returns_div,.projected_returns_div{
	display:none;
}
.asset_allocation_div{
	display:none;
}
.slidecontainer {
    width: 100%;
}
.rangeslider__handle {
    border: 2px solid #3fc5f0 !important;
    background: #fff;
}
.rangeslider__fill {
    background: #3fc5f0 !important;
}
.slider:hover {
    opacity: 1;
}
.btnCol.active {
    background-color: #1b0e3d !important;
    border-color: #ffffff !important;
}
.slider::-webkit-slider-thumb {
    -webkit-appearance: none;
    appearance: none;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: #4CAF50;
    cursor: pointer;
}
.slider::-moz-range-thumb {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: #4CAF50;
    cursor: pointer;
}
.qtyminus{
	cursor:pointer;
}
.form-control:disabled, .form-control[readonly]{
	background-color:#fff;
}
.width100{
	width:150px;
}
.robo1 , .robo4, .robo5{
	margin: 0px auto;
	background-color:#fff;
	margin-bottom: 5%;
	margin-top: 2%;
	padding-top: 3%;
}
.robo3 .{
    padding: .50rem .5rem !important;
}
.pt-5, .py-5 {
    padding-top: 1rem !important;
}	
.plutusSipTopBox p{
	font-size:0.8125rem !important;
}
.fundNamebg p{
	font-size:0.8125rem !important;
	margin-bottom:0.8125rem !important;
}
.chartFontStyle p{
	font-size:0.8125rem !important;
}
.sipRoboOffsetAlign .offset-lg-1 {
    margin-left: 0 !important;
}
.cardProtbg{
	font-size:0.8125rem !important;
}
.cardProtbg p{
	margin-bottom:0.8125rem !important;
}
.sipRoboAlignMargin .offset-lg-1 {
    margin-left: 0 !important;
}
.fundNamebg h4 {
    font-size: 1.2rem !important;
}
.offset-md-3 {
    margin-left: 0 !important;
}
.table thead th, .table tbody td, .table tfoot td{
	font-size:0.8125rem !important;
}
.table thead tr th, .table tbody tr td, .table tfoot tr td{
	padding: 9px !important;
}
p.chart_para{
	margin-bottom:5px !important;
}
#step2,#step3,#step4,#step5,#step6,#step7
{
	display:none;
}
.check_all_btn{
	cursor:pointer;
	text-decoration: underline;
}
.form-control-2 {
	padding: 0px 10px;
	margin: 0px;
	height: 40px;
	width: 100px;
	font-size:12px;
}
.btn-back {
	border: 2px solid #a23a5f;
	margin-top: -4%;
	margin-left: 10px;
	border-radius: 90px;
	height: 50px;
	width: 10%;
}
.allocaton_amount {
	float: right;
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
.textInputRadius {
	width: 100px;
} 

</style>

<script type="text/javascript">

var age = 0;
var risk = "";
var horizon = 1;
var amount = 0;
var slider_age = 0;
var slider_horizon = 1;
var choosen_year = 3;
var slider_risk = "";
var slider_amount = 0;
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
var btn_state = 3;
var portfolio_flag = false;
var historical_flag = false;
var projected_flag = false;
var investor_pan = "";
var ques_flag = 1;

$(document).ready(function()
{
	investor_pan = '${pan}';

	$("#age_slider").slider({
		min: 18,
	    max: 99,
	    tooltip: "show",
	    step: 1,
	    value: 18
	}).on("slideStop", function(slideEvt) {		
		$("#txt_age").val(slideEvt.value);
	});

	$("#amount_slider").slider({
		min: 100000,
	    max: 10000000,
	    tooltip: "show",
	    step: 100000,
	    value: 1000000
	}).on("slideStop", function(slideEvt) {		
		$("#txt_amount").val(slideEvt.value);
	});

	$("#year_slider").slider({
		min: 1,
	    max: 20,
	    tooltip: "show",
	    step: 1,
	    value: 5
	}).on("slideStop", function(slideEvt) {		
		$("#txt_period").val(slideEvt.value);
	});

	
	$('input.number').change(function() {
		$(this).val(function(index, value) {
			value = value.replace(/,/g,'');
		    return numbersWithComma(value);
		});
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
});

function ageChange()
{
	var age = $('#txt_age').val();
	$( "#age_slider" ).slider("setValue",age);
}

function amountChange()
{
	var amount = $('#txt_amount').val();
	$( "#amount_slider" ).slider("setValue",amount);
}

function yearChange()
{
	var years = $('#txt_period').val();
	$( "#year_slider" ).slider("setValue",years);
}

function show_div(i)
{
	switch (i)
	{
		case 2:
			document.getElementById("DivF2").style.display = 'block';
			document.getElementById("DivF3").style.display = 'none';
			document.getElementById("DivF4").style.display = 'none';
			document.getElementById("DivF5").style.display = 'none';
			document.getElementById("DivF6").style.display = 'none';
			btn_state = 3;
			$(".header_btn button").removeClass("active");
		    $("#btn_head2").addClass("active");
		    renderPieChart();
			break;
		case 3:
			document.getElementById("DivF2").style.display = 'none';
			document.getElementById("DivF3").style.display = 'block';
			document.getElementById("DivF4").style.display = 'none';
			document.getElementById("DivF5").style.display = 'none';
			document.getElementById("DivF6").style.display = 'none';
			btn_state = 1;
			$(".header_btn button").removeClass("active");
		    $("#btn_head3").addClass("active");
		    donutChart();
			break;
		case 4:
			document.getElementById("DivF2").style.display = 'none';
			document.getElementById("DivF3").style.display = 'none';
			document.getElementById("DivF4").style.display = 'block';
			document.getElementById("DivF5").style.display = 'none';
			document.getElementById("DivF6").style.display = 'none';
			btn_state = 5;
			
			if(!projected_flag)
			{
				completeStep5();
				projected_flag = true;
			}
			$(".header_btn button").removeClass("active");
		    $("#btn_head4").addClass("active");
			break;
		case 5:
			document.getElementById("DivF2").style.display = 'none';
			document.getElementById("DivF3").style.display = 'none';
			document.getElementById("DivF4").style.display = 'none';
			document.getElementById("DivF5").style.display = 'block';
			document.getElementById("DivF6").style.display = 'none';
			btn_state = 4;
			
			if(!historical_flag)
			{
				completeStep6();
				historical_flag = true;
			}
			$(".header_btn button").removeClass("active");
		    $("#btn_head5").addClass("active");
			break;
		case 6:
			document.getElementById("DivF2").style.display = 'none';
			document.getElementById("DivF3").style.display = 'none';
			document.getElementById("DivF4").style.display = 'none';
			document.getElementById("DivF5").style.display = 'none';
			document.getElementById("DivF6").style.display = 'block';
			btn_state = 2;
			
			if(!portfolio_flag)
			{
				completeStep4();
				portfolio_flag = true;
			}
			$(".header_btn button").removeClass("active");
		    $("#btn_head6").addClass("active");
			break;	
		default:			
			
	}
	return true;
}
function riskProfileChange()
{
	risk = $("#sel_risk").val();
	if(risk == "")
 	{
		$(".robo1").hide();
		$(".robo2").show();
		$("#step1").show();
		$("#step7").hide();
 	}
}
function checkSliderValues()
{
	slider_horizon = $('#txt_time_horizon_slider').val();
	amount = $('#txt_amount_slider').val();
	slider_risk = $("#txt_risk_slider").val();
	
	amount = amount.replace(/,/g,'');
	
	if(parseInt(amount) < 5000)
 	{
		swal({title:"", text: "Lumpsum minimum investment amount Rs.5000. Please change the slider value."});
      	return;
 	}
	
	if(slider_risk == 0)
    {
		risk = "Conservative";
    }
    if(slider_risk == 1)
    {
    	risk = "Moderately Conservative";
    }
    if(slider_risk == 2)
    {
    	risk = "Moderate";
    }
    if(slider_risk == 3)
    {
    	risk = "Moderately Aggressive";
    }
    if(slider_risk == 4)
    {
    	risk = "Aggressive";
    }
    
    if(slider_horizon == 0)
    {
    	horizon = "Between 0-1 year";
    	choosen_year= 1;
    }
    if(slider_horizon == 1)
    {
    	horizon = "Between 1-3 years";
    	choosen_year= 3;
    }
    if(slider_horizon == 2)
    {
    	horizon = "Between 4-7 years";
    	choosen_year= 7;
    }
    if(slider_horizon == 3)
    {
    	horizon = "Between 8-15 years";
    	choosen_year= 15;
    }
    if(slider_horizon == 4)
    {
    	horizon = "16 years and above";
    	choosen_year= 20;
    }
    
    slider_amount = amount;
    
    calculateDebtAndEquity();
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
function completeStep1()
{
	age = $("#txt_age").val();
	amount = $("#txt_amount").val();
	horizon = $("#sel_period").val();
    risk = $("#sel_risk").val();
    
    amount = amount.replace(/,/g,'');
    
    if(age == "" || isNaN(age))
 	{
 		swal({title:"", text: "Please enter your valid age"});
   	    return;
 	}
    if(parseInt(age) < 18)
 	{
    	swal({title:"", text: "Please enter your valid age"});
   	    return;
 	}
    if(amount == "" || isNaN(amount) || parseInt(amount) < 1)
 	{
    	swal({title:"", text: "Please enter your valid investment amount"});
	 	return;
 	}
    if(parseInt(amount) < 5000)
 	{
    	swal({title:"", text: "Lumpsum minimum investment amount Rs.5000"});
   	    return;
 	}
    if(horizon == "")
 	{
    	swal({title:"", text: "Please select your time horizon"});
   	    return;
 	}
    if(risk == "")
 	{
    	swal({title:"", text: "Please select your risk tolerance"});
   	    return;
 	}
    if(risk == "Check Risk Profile")
 	{
    	$(".robo1").hide();
		$(".robo2").show();
 		return;
 	}
    
    if(risk == "Aggressive")
    {
    	slider_risk = 4;
    }else if(risk == "Moderately Aggressive")
    {
    	slider_risk = 3;
    }else if(risk == "Moderate")
    {
    	slider_risk = 2;
    }else if(risk == "Moderately Conservative")
    {
    	slider_risk = 1;
    }else
    {
    	slider_risk = 0;
    }
    
    if(horizon == "Between 0-1 year")
    {
    	slider_horizon = 0;
    	choosen_year= 1;
    }else if(horizon == "Between 1-3 years")
    {
    	slider_horizon = 1;
    	choosen_year= 3;
    }else if(horizon == "Between 4-7 years")
    {
    	slider_horizon = 2;
    	choosen_year= 7;
    }else if(horizon == "Between 8-15 years")
    {
    	slider_horizon = 3;
    	choosen_year= 15;
    }else{
    	slider_horizon = 4;
    	choosen_year= 20;
    }
    slider_age = age;
    slider_amount = amount;
    
    $('.span_lumpsum_amount').html(numbersWithComma(amount));
	$('.span_year').html(choosen_year);
    
	$(".robo1").hide();
	$(".robo3").show();
	$("#DivF2").show();
	
	$('html,body').animate({
        scrollTop: 0
    }, 700);
    
    initiateSliders();
    calculateDebtAndEquity();
}
function initiateSliders()
{    
    slider_amount = parseInt(slider_amount);
    slider_horizon = parseInt(slider_horizon);
    slider_risk = parseInt(slider_risk);
    
    if(risk == "Aggressive")
    {
    	slider_risk = 4;
    }else if(risk == "Moderately Aggressive")
    {
    	slider_risk = 3;
    }else if(risk == "Moderate")
    {
    	slider_risk = 2;
    }else if(risk == "Moderately Conservative")
    {
    	slider_risk = 1;
    }else
    {
    	slider_risk = 0;
    }
    
    if(horizon == "Between 0-1 year")
    {
    	slider_horizon = 0;
    	choosen_year= 1;
    }else if(horizon == "Between 1-3 years")
    {
    	slider_horizon = 1;
    	choosen_year= 3;
    }else if(horizon == "Between 4-7 years")
    {
    	slider_horizon = 2;
    	choosen_year= 7;
    }else if(horizon == "Between 8-15 years")
    {
    	slider_horizon = 3;
    	choosen_year= 15;
    }else
    {
    	slider_horizon = 4;
    	choosen_year= 20;
    }
    
    $("#txt_risk_slider").val(slider_risk);
    $('#txt_time_horizon_slider').val(slider_horizon);
    $('#txt_amount_slider').val(slider_amount);
    
	var $document = $(document);
    
    //Time Horizon Slider Initiate
    var timeslider = $("input[type=range][name='txt_time_horizon_slider']");
    var timeoutput = document.querySelectorAll("output.time_horizon_slider_output")[0];
  	
    // set initial output value
      var txt = "";
      var slider_time = timeslider[0].value;
      if(slider_time == 0)
      {
      	txt = "Between 0-1 year";
      }
      if(slider_time == 1)
      {
      	txt = "Between 1-3 years";
      }
      if(slider_time == 2)
      {
      	txt = "Between 4-7 years";
      }
      if(slider_time == 3)
      {
      	txt = "Between 8-15 years";
      }
      if(slider_time == 4)
      {
      	txt = "16 years and above";
      }
    timeoutput.textContent = txt;
    
    // update output value
    $document.on('input', 'input[type="range"][name="txt_time_horizon_slider"]', function(e) {
  	  
    	var txt = "";
  	    var slider_time = e.currentTarget.value;
  	  if(slider_time == 0)
      {
      	txt = "Between 0-1 year";
      }
      if(slider_time == 1)
      {
      	txt = "Between 1-3 years";
      }
      if(slider_time == 2)
      {
      	txt = "Between 4-7 years";
      }
      if(slider_time == 3)
      {
      	txt = "Between 8-15 years";
      }
      if(slider_time == 4)
      {
      	txt = "16 years and above";
      }
  	  timeoutput.textContent = txt;
      
    });
    
    //Initialize
    timeslider.rangeslider({
      polyfill: false
    });  
    
    //Risk Profile Slider Initiate
    var riskslider = $("input[type=range][name='txt_risk_slider']");
    var riskoutput = document.querySelectorAll("output.risk_slider_output")[0];
  	
    // set initial output value
   	  var txt = "";
      var slider_risk = riskslider[0].value;
      if(slider_risk == 0)
      {
      	txt = "Conservative";
      }
      if(slider_risk == 1)
      {
      	txt = "Moderately Conservative";
      }
      if(slider_risk == 2)
      {
      	txt = "Moderate";
      }
      if(slider_risk == 3)
      {
      	txt = "Moderately Aggressive";
      }
      if(slider_risk == 4)
      {
      	txt = "Aggressive";
      }
      riskoutput.textContent = txt;
    
    // update output value
    $document.on('input', 'input[type="range"][name="txt_risk_slider"]', function(e) {
  	  
  	    var txt = "";
  	    var slider_risk = e.currentTarget.value;
  	    if(slider_risk == 0)
  	    {
  	    	txt = "Conservative";
  	    }
  	    if(slider_risk == 1)
  	    {
  	    	txt = "Moderately Conservative";
  	    }
  	    if(slider_risk == 2)
  	    {
  	    	txt = "Moderate";
  	    }
  	    if(slider_risk == 3)
  	    {
  	    	txt = "Moderately Aggressive";
  	    }
  	    if(slider_risk == 4)
  	    {
  	    	txt = "Aggressive";
  	    }
  	  riskoutput.textContent = txt;
      
    });
    
    //Initialize
    riskslider.rangeslider({
      polyfill: false
    });
    
    //Amount Slider Initiate
    var amountslider = $("input[type=range][name='txt_amount_slider']");
    var amountoutput = document.querySelectorAll("input.amount_slider_output")[0];
  	
    // set initial output value
    amountoutput.value = numbersWithComma(amountslider[0].value);
    
    // update output value
    $document.on('input', 'input[type="range"][name="txt_amount_slider"]', function(e) {
  	  
  	  amountoutput.value = numbersWithComma(e.currentTarget.value);
      
    });
    
    $( "input.amount_slider_output" ).change(function() {
    	  
    	var textbox_value = $("input.amount_slider_output").val();
    	textbox_value = textbox_value.replace(/,/g,'');
    	amountslider[0].value = textbox_value;
    	amountslider.rangeslider('update', true);
    	checkSliderValues();
    	
	});
    
    // Initialize
    amountslider.rangeslider({
      polyfill: false
    });
}
function goToStep1()
{
	$(".robo1").show();
	$(".robo2").hide();
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
    	swal({title:"", text: "Please answer the question"});
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
    /* var answer7 = $("input[type='radio'][name='q7']:checked").val();
	var answer8 = $("input[type='radio'][name='q8']:checked").val(); */
	
    
    if (answer1 == undefined || answer2 == undefined || answer3 == undefined || answer4 == undefined || answer5 == undefined || answer6 == undefined /* || answer7 == undefined || answer8 == undefined */) 
    {
    	swal({title:"", text: "Please answer all the questions"});
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
        if(risk == "Aggressive")
        {
        	risk_str = "You're a go-getter who knows your limitations but are completely aware of them. Your gung-ho attitude keeps you on the lookout for the next big way to make money.";
        }
        if(risk == "Moderately Aggressive")
        {
        	risk_str = "You're a go-getter who knows your limitations but are completely aware of them. Your gung-ho attitude keeps you on the lookout for the next big way to make money.";
        }
        if(risk == "Moderate")
        {
        	risk_str = "You're a fence-sitter who knows your limitations and plays safe while taking investment decisions. Your balanced attitude keeps you on the conscious about the risks you want to take to make money.";
        }
        if(risk == "Moderately Conservative")
        {
        	risk_str = "You're risk-shy who knows your limitations and plays extremely safe while taking investment decisions. Your conservative attitude keeps you on the conscious about the risks you take.";
        }
        if(risk == "Conservative")
        {
        	risk_str = "You're risk-shy who knows your limitations and plays extremely safe while taking investment decisions. Your conservative attitude keeps you on the conscious about the risks you take.";
        }
        $("#risk_result_para").html(risk_str);
        
 		$(".robo1").show();
 		$(".robo2").hide();
 		$("#sel_risk").val(risk);    
        swal({html:true,title:"",text:"As per our risk assessment, your risk tolerance is <br><b>"+risk+"</b>"}); 
        /* if(risk == "Conservative")
        {
        	showGraph(10);
        }
        if(risk == "Moderately Conservative")
        {
        	showGraph(30);
        }
        if(risk == "Moderate")
        {
        	showGraph(50);
        }
        if(risk == "Moderately Aggressive")
        {
        	showGraph(70);
        }
        if(risk == "Aggressive")
        {
        	showGraph(90);
        } */
        
    },'text');	
    
    /* swal({html:true,title:"",text:"As per our risk assessment, your risk tolerance is <br><b>"+risk+"</b>"},function(){
    	redirect();
    }); */
}
function contactUs()
{
	document.location.href = "/contactus";
}

        function show_ques_div(i) {
		 
            switch (i) {
                case 1:
                	if(riskQuestionNext(1))
                	{
                		document.getElementById("step1").style.display = 'none';
                        document.getElementById("step2").style.display = 'block';
    					 document.getElementById("step3").style.display = 'none';
    					  document.getElementById("step4").style.display = 'none';
    					   document.getElementById("step5").style.display = 'none';
    					    document.getElementById("step6").style.display = 'none';
    						 document.getElementById("step7").style.display = 'none';
                	}
                    break;
                case 2:
                	if(riskQuestionNext(2))
                	{
                		document.getElementById("step1").style.display = 'none';
                        document.getElementById("step2").style.display = 'none';
    					 document.getElementById("step3").style.display = 'block';
    					  document.getElementById("step4").style.display = 'none';
    					   document.getElementById("step5").style.display = 'none';
    					    document.getElementById("step6").style.display = 'none';
    						 document.getElementById("step7").style.display = 'none';
                	}
                    break;
                case 3:
                	if(riskQuestionNext(3))
                	{
                		document.getElementById("step1").style.display = 'none';
                        document.getElementById("step2").style.display = 'none';
    					 document.getElementById("step3").style.display = 'none';
    					  document.getElementById("step4").style.display = 'block';
    					   document.getElementById("step5").style.display = 'none';
    					    document.getElementById("step6").style.display = 'none';
    						 document.getElementById("step7").style.display = 'none';
                	}
                    break;
                case 4:
                	if(riskQuestionNext(4))
                	{
                		document.getElementById("step1").style.display = 'none';
                        document.getElementById("step2").style.display = 'none';
    					 document.getElementById("step3").style.display = 'none';
    					  document.getElementById("step4").style.display = 'none';
    					   document.getElementById("step5").style.display = 'block';
    					    document.getElementById("step6").style.display = 'none';
    						 document.getElementById("step7").style.display = 'none';
                	}
	 
                    break;
                case 5:
                	if(riskQuestionNext(5))
                	{
                		document.getElementById("step1").style.display = 'none';
                        document.getElementById("step2").style.display = 'none';
    					 document.getElementById("step3").style.display = 'none';
    					  document.getElementById("step4").style.display = 'none';
    					   document.getElementById("step5").style.display = 'none';
    					    document.getElementById("step6").style.display = 'block';
    						 document.getElementById("step7").style.display = 'none';
    						 
                	}
                    break;
                case 6:
                	if(riskQuestionNext(6))
                	{
                		document.getElementById("step1").style.display = 'none';
                        document.getElementById("step2").style.display = 'none';
    					 document.getElementById("step3").style.display = 'none';
    					  document.getElementById("step4").style.display = 'none';
    					   document.getElementById("step5").style.display = 'none';
    					    document.getElementById("step6").style.display = 'none';
    						 document.getElementById("step7").style.display = 'block';
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
function showGraph(risk_value)
{
    var gradient1 = {
            type: 'linearGradient',
            x0: 0,
            y0: 0.5,
            x1: 1,
            y1: 0.5,
            colorStops: [{ offset: 0, color: '#C5F80B' },
                         { offset: 1, color: '#6B8901'}]
        };

        var gradient2 = {
            type: 'linearGradient',
            x0: 0.5,
            y0: 0,
            x1: 0.5,
            y1: 1,
            colorStops: [{ offset: 0, color: '#FF3366' },
                         { offset: 1, color: '#B2183E'}]
        };

        var anchorGradient = {
            type: 'radialGradient',
            x0: 0.35,
            y0: 0.35,
            r0: 0.0,
            x1: 0.35,
            y1: 0.35,
            r1: 1,
            colorStops: [{ offset: 0, color: '#4F6169' },
                         { offset: 1, color: '#252E32'}]
        };

        $('#jqRadialGauge').jqRadialGauge({
            background: '#dcf1f6',
			
            border: {
                lineWidth: 6,
                strokeStyle: '#76786A',
                padding: 16
            },
            shadows: {
                enabled: true
            },
            anchor: {
                visible: true,
                fillStyle: anchorGradient,
                radius: 0.10
            },
            tooltips: {
                disabled: false,
                highlighting: true
            },
            animation: {
                duration: 1
            },
            scales: [
                     {
                         minimum: 0,
                         maximum: 100,
                         startAngle: 180,
                         endAngle: 360,
                         majorTickMarks: {
                             length: 12,
                             lineWidth: 2,
                             interval: 10,
                             offset: 0.84
                         },
                         minorTickMarks: {
                             visible: true,
                             length: 8,
                             lineWidth: 2,
                             interval: 2,
                             offset: 0.84
                         },
                         labels: {
                             orientation: 'horizontal',
                             interval: 10,
                             offset: 1.00
                         },
                         needles: [
                                    {
                                        value: risk_value,
                                        type: 'pointer',
                                        outerOffset: 0.8,
                                        mediumOffset: 0.7,
                                        width: 10,
                                        fillStyle: '#252E32'
                                    }
                                  ],
                         ranges: [
                                    {
                                        outerOffset: 0.82,
                                        innerStartOffset: 0.76,
                                        innerEndOffset: 0.68,
                                        startValue: 40,
                                        endValue: 80,
                                        fillStyle: gradient1
                                    },
                                    {
                                        outerOffset: 0.82,
                                        innerStartOffset: 0.68,
                                        innerEndOffset: 0.60,
                                        startValue: 80,
                                        endValue: 100,
                                        fillStyle: gradient2
                                    }
                                 ]
                     }
                    ]
        });

        $('#jqRadialGauge').bind('tooltipFormat', function (e, data) {

            var tooltip = '<b>Element: ' + data.elementType + '</b> ' + '<br />';

            switch (data.elementType) {

                case 'needle':
                    tooltip += 'Value: ' + data.value;
                    break;
                case 'range':
                    tooltip += 'Start Value: ' + data.startValue + '<br/>End Value: ' + data.endValue;
            }

            return tooltip;
        });
}
function calculateDebtAndEquity()
{
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
	if(horizon == "Between 0-1 year")
    {
		new_horizon = 1;
    }else if(horizon == "Between 1-3 years")
    {
		new_horizon = 2;
    }else if(horizon == "Between 4-7 years")
    {
    	new_horizon = 3;
    }else if(horizon == "Between 8-15 years")
    {
    	new_horizon = 4;
    }else{
    	new_horizon = 5;
    }
	
	$('.span_lumpsum_amount').html(numbersWithComma(amount));
	$('.span_year').html(choosen_year);
    
    new_horizon = parseInt(new_horizon);
    new_risk = parseInt(new_risk);
    
    if(new_horizon == 1 && new_risk == 1)
    {
    	$('#portfolio_para1').html("The portfolio will aim to conserve capital and beat inflation");
        $('#portfolio_para2').html("This asset allocation is designed to hold 100% debt and other highly liquid investments");
    }
    if(new_horizon == 1 && new_risk == 2)
    {
    	$('#portfolio_para1').html("The portfolio will aim to enhance income and maintain high level of liquidity");
        $('#portfolio_para2').html("This asset allocation is designed to hold 100% debt and other highly liquid investments");
    }
    if(new_horizon == 1 && new_risk == 3)
    {
    	$('#portfolio_para1').html("The portfolio will aim to enhance income along with some capital appreciation and maintain a moderate level of liquidity");
        $('#portfolio_para2').html("This asset allocation is designed to hold 100% debt and other highly liquid investments");
    }
    if(new_horizon == 1 && new_risk == 4)
    {
    	$('#portfolio_para1').html("The portfolio will aim to achieve moderate capital appreciation along with an income stream.");
        $('#portfolio_para2').html("This asset allocation is designed to hold 100% debt and other highly liquid investments");
    }
    if(new_horizon == 1 && new_risk == 5)
    {
    	$('#portfolio_para1').html("The portfolio will aim to achieve moderate capital appreciation along with an income stream.");
        $('#portfolio_para2').html("This asset allocation is designed to hold 100% debt and other highly liquid investments");
    }
    
    if(new_horizon == 2 && new_risk == 1)
    {
    	$('#portfolio_para1').html("The portfolio will aim to generate returns along with income flow");
        $('#portfolio_para2').html("This asset allocation is designed to hold 100% debt and other highly liquid investments");
    }
    if(new_horizon == 2 && new_risk == 2)
    {
    	$('#portfolio_para1').html("The portfolio will aim for capital appreciation along with moderate income flows");
    	$('#portfolio_para2').html("This asset allocation is designed to hold upto 95% debt instruments and upto 5% in equity and related instruments");
    }
    if(new_horizon == 2 && new_risk == 3)
    {
    	$('#portfolio_para1').html("The portfolio will aim for capital appreciation along with moderate income flows");
    	$('#portfolio_para2').html("This asset allocation is designed to hold upto 90% debt instruments and upto 10% in equity and related instruments");
    }
    if(new_horizon == 2 && new_risk == 4)
    {
    	$('#portfolio_para1').html("The portfolio will aim for capital appreciation along with restricted income flows");
    	$('#portfolio_para2').html("This asset allocation is designed to hold upto 85% debt instruments and upto 15% in equity and related instruments");
    }
    if(new_horizon == 2 && new_risk == 5)
    {
    	$('#portfolio_para1').html("The portfolio will aim to predominately generate capital gains");
    	$('#portfolio_para2').html("This asset allocation is designed to hold upto 80% debt instruments and upto 20% in equity and related instruments");
    }
    
    if(new_horizon == 3 && new_risk == 1)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation with restricted income flows");
        $('#portfolio_para2').html("This asset allocation is designed to hold upto 45% debt instuments and upto 55% in equity instuments across different market and risk capitalisation");
    }
    if(new_horizon == 3 && new_risk == 2)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation with restricted income flows");
        $('#portfolio_para2').html("This asset allocation is designed to hold upto 50% debt instuments and upto 50% in equity instuments across different market and risk capitalisation");
    }
    if(new_horizon == 3 && new_risk == 3)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through investments in high growth sectors");
        $('#portfolio_para2').html("This asset allocation is designed to hold about 35% debt instruments and upto 65% in equity related instruments along with selective sectoral allocations");
    }
    if(new_horizon == 3 && new_risk == 4)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through investments in high growth sectors");
        $('#portfolio_para2').html("This asset allocation is designed to hold about 25% debt instruments and upto 75% in equity related instruments. The debt holdings are for tactical use only");
    }
    if(new_horizon == 3 && new_risk == 5)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through investments in high growth sectors");
        $('#portfolio_para2').html("This asset allocation is designed to hold about 10% debt instruments and upto 90% in equity related instruments. The debt holdings are for tactical use only");
    }
    
    if(new_horizon == 4 && new_risk == 1)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through value investing strategies");
        $('#portfolio_para2').html("This asset allocation is designed to hold upto 25% debt instuments and upto 75% in equity instuments across different market and risk capitalisation");
    }
    if(new_horizon == 4 && new_risk == 2)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through value investing strategies");
        $('#portfolio_para2').html("This asset allocation is designed to hold upto 15% debt instuments and upto 85% in equity instuments across different market and risk capitalisation");
    }
    if(new_horizon == 4 && new_risk == 3)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through high growth instruments across capitalisations");
        $('#portfolio_para2').html("This asset allocation is designed to hold upto 10% debt instuments and upto 90% in equity instuments across different market and risk capitalisation");
    }
    if(new_horizon == 4 && new_risk == 4)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through high growth instruments across capitalisations");
        $('#portfolio_para2').html("This asset allocation is designed to hold about 5% debt instruments and upto 95% in equity related instruments. The debt holdings are for tactical use only");
    }
    if(new_horizon == 4 && new_risk == 5)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through high growth instruments across capitalisations");
        $('#portfolio_para2').html("This asset allocation is designed to hold about 5% debt instruments and upto 95% in equity related instruments. The debt holdings are for tactical use only");
    }
    
    if(new_horizon == 5 && new_risk == 1)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through value investing strategies");
        $('#portfolio_para2').html("This asset allocation is designed to hold upto 25% debt instuments and upto 75% in equity instuments across different market and risk capitalisation");
    }
    if(new_horizon == 5 && new_risk == 2)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through value investing strategies");
        $('#portfolio_para2').html("This asset allocation is designed to hold upto 15% debt instuments and upto 85% in equity instuments across different market and risk capitalisation");
    }
    if(new_horizon == 5 && new_risk == 3)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through high growth instruments across capitalisations");
        $('#portfolio_para2').html("This asset allocation is designed to hold upto 10% debt instuments and upto 90% in equity instuments across different market and risk capitalisation");
    }
    if(new_horizon == 5 && new_risk == 4)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through high growth instruments across capitalisations");
        $('#portfolio_para2').html("This asset allocation is designed to hold about 5% debt instruments and upto 95% in equity related instruments. The debt holdings are for tactical use only");
    }
    if(new_horizon == 5 && new_risk == 5)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation through high growth instruments across capitalisations");
        $('#portfolio_para2').html("This asset allocation is designed to hold about 5% debt instruments and upto 95% in equity related instruments. The debt holdings are for tactical use only");
    }
    
    var angles = [0, 0, 0, 0, 0, 0, 0, 0];
    
    //horizon 1
    if (new_horizon == 1 && new_risk == 1)
    {
    	angles[0] = 70; // Liquid funds
        angles[1] = 30; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 1 && new_risk == 2)
    {
    	angles[0] = 60; // Liquid funds
        angles[1] = 40; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 1 && new_risk == 3)
    {
    	angles[0] = 40; // Liquid funds
        angles[1] = 60; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 1 && new_risk == 4)
    {
    	angles[0] = 30; // Liquid funds
        angles[1] = 70; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 1 && new_risk == 5)
    {
    	angles[0] = 20; // Liquid funds
        angles[1] = 80; // short term debt
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
    	angles[0] = 25; // Liquid funds
        angles[1] = 35; // short term debt
        angles[2] = 40; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 0; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 2 && new_risk == 2)
    {
    	angles[0] = 20; // Liquid funds
        angles[1] = 30; // short term debt
        angles[2] = 30; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 20; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 2 && new_risk == 3)
    {
    	angles[0] = 15; // Liquid funds
        angles[1] = 25; // short term debt
        angles[2] = 25; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 35; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 2 && new_risk == 4)
    {
    	angles[0] = 10; // Liquid funds
        angles[1] = 15; // short term debt
        angles[2] = 20; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 55; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 2 && new_risk == 5)
    {
    	angles[0] = 5; // Liquid funds
        angles[1] = 10; // short term debt
        angles[2] = 20; // long term debt
        angles[3] = 0; // balanced fund equity oriented
        angles[4] = 0; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 65; // Hybrid Debt Oriented Funds
    }
    
   //horizon 3
    if (new_horizon == 3 && new_risk == 1)
    {
    	angles[0] = 20; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 40; // balanced fund equity oriented
        angles[4] = 10; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 30; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 3 && new_risk == 2)
    {
    	angles[0] = 15; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 45; // balanced fund equity oriented
        angles[4] = 15; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 25; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 3 && new_risk == 3)
    {
    	angles[0] = 10; // Liquid funds
        angles[1] = 0; // short term debt
        angles[2] = 0; // long term debt
        angles[3] = 50; // balanced fund equity oriented
        angles[4] = 25; // largecap
        angles[5] = 0; // midcap
        angles[6] = 0; // thematic funds
        angles[7] = 15; // Hybrid Debt Oriented Funds
    }
    if (new_horizon == 3 && new_risk == 4)
    {
    	angles[0] = 5; // Liquid funds
        angles[1] = 0; // short term debt
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
	console.log("total----->"+total);
	
	var current_amount = parseInt(amount);
	console.log("current_amount--->"+current_amount);
	if(current_amount <= 50000)
	{
		var count = 0;		
		for(var k=0;k<angles.length;k++)
		{
			if(angles[k] > 0)
			{
				count++;	
			}
		}
		console.log("category count--->"+count);
		var check_count = 1;	
		if(current_amount <= 10000)
		{
			check_count = 1;
		}else if(current_amount <= 15000)
		{
			check_count = 2;
		}else if(current_amount <= 25000)
		{
			check_count = 3;
		}else if(current_amount <= 50000)
		{
			check_count = 4;
		}
		console.log("check count--->"+check_count);
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
			
			console.log("liquid_debt--->"+liquid_debt);
			console.log("short_term_debt--->"+short_term_debt);
			console.log("long_term_debt--->"+long_term_debt);
			console.log("equity_balanced--->"+equity_balanced);
			console.log("equity_largecap--->"+equity_largecap);
			console.log("equity_midcap--->"+equity_midcap);
			console.log("equity_diversified--->"+equity_diversified);
			console.log("hybrid_debt--->"+hybrid_debt);
		}
	}
	
	var total = liquid_debt + short_term_debt + long_term_debt + equity_balanced + equity_largecap + equity_midcap + equity_diversified + hybrid_debt;
	console.log("total----->"+total);
	
	var goal_based_amount = parseFloat(amount);
	var change_arr = [0, 0, 0, 0, 0, 0, 0, 0];
	change_arr[0] = liquid_debt;
	change_arr[1] = short_term_debt;
	change_arr[2] = long_term_debt;
	change_arr[3] = hybrid_debt;
	change_arr[4] = equity_balanced;
	change_arr[5] = equity_largecap;
	change_arr[6] = equity_diversified;
	change_arr[7] = equity_midcap;
	var check_value = (5000 / goal_based_amount) * 100;
	check_value = Math.ceil(check_value);
	console.log("check_value----->"+check_value);
	
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
	
	console.log("liquid_debt--->"+liquid_debt);
	console.log("short_term_debt--->"+short_term_debt);
	console.log("long_term_debt--->"+long_term_debt);
	console.log("equity_balanced--->"+equity_balanced);
	console.log("equity_largecap--->"+equity_largecap);
	console.log("equity_midcap--->"+equity_midcap);
	console.log("equity_diversified--->"+equity_diversified);
	console.log("hybrid_debt--->"+hybrid_debt);
	
	var total = liquid_debt + short_term_debt + long_term_debt + equity_balanced + equity_largecap + equity_midcap + equity_diversified + hybrid_debt;
	console.log("final one total----->"+total);
	
	/* var value = 0;
	var value1 = 0;
	var max_count = 0;
	var goal_based_amount = parseFloat(amount);
	var total_percentage = 0;
	var total_amount = 0;
	
	if(liquid_debt > 0)
	{
		if(total_percentage >= 100)
		{
			liquid_debt = 0;
		}else
		{
			if(liquid_debt <= 15 || goal_based_amount <= 50000)
			{
				max_count = 1;
			}else if(liquid_debt <= 40)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
			
			value = liquid_debt / max_count;
			value1 = goal_based_amount * (value / 100);
			value1 = Math.round(value1 / 1000) * 1000;
			if(value1 < 5000)
			{
				value1 = 5000;
			}
			value = (value1 / goal_based_amount) * 100;
			value = value * max_count;
			value = parseFloat(value.toFixed(2));
			total_percentage = total_percentage + value;
			total_amount = total_amount + value;
			liquid_debt = value;
			//alert("liquid_debt----->"+liquid_debt);
		}
	}
	if(short_term_debt > 0)
	{
		if(total_percentage >= 100)
		{
			short_term_debt = 0;
		}else
		{
			if(short_term_debt <= 15 || goal_based_amount <= 50000)
			{
				max_count = 1;
			}else if(short_term_debt <= 39)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
			
			value = short_term_debt / max_count;
			value1 = goal_based_amount * (value / 100);
			value1 = Math.round(value1 / 1000) * 1000;
			if(value1 < 5000)
			{
				value1 = 5000;
			}
			value = (value1 / goal_based_amount) * 100;
			value = value * max_count;
			value = parseFloat(value.toFixed(2));
			total_percentage = total_percentage + value;
			total_amount = total_amount + value;
			if(total_percentage > 100)
			{
				value = 100 - total_percentage;
			}
			short_term_debt = value;
			//alert("short_term_debt----->"+short_term_debt);
		}
	}
	if(long_term_debt > 0)
	{
		if(total_percentage >= 100)
		{
			long_term_debt = 0;
		}else
		{
			if(long_term_debt <= 15 || goal_based_amount <= 50000)
			{
				max_count = 1;
			}else if(long_term_debt <= 39)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
			
			value = long_term_debt / max_count;
			value1 = goal_based_amount * (value / 100);
			value1 = Math.round(value1 / 1000) * 1000;
			if(value1 < 5000)
			{
				value1 = 5000;
			}
			value = (value1 / goal_based_amount) * 100;
			value = value * max_count;
			value = parseFloat(value.toFixed(2));
			total_percentage = total_percentage + value;
			total_amount = total_amount + value;
			if(total_percentage > 100)
			{
				value = 100 - total_percentage;
			}
			long_term_debt = value;
			//alert("long_term_debt----->"+long_term_debt);
		}
	}
	if(hybrid_debt > 0)
	{
		if(total_percentage >= 100)
		{
			hybrid_debt = 0;
		}else
		{
			if(hybrid_debt <= 15 || goal_based_amount <= 50000)
			{
				max_count = 1;
			}else if(hybrid_debt <= 39)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
			
			value = hybrid_debt / max_count;
			value1 = goal_based_amount * (value / 100);
			value1 = Math.round(value1 / 1000) * 1000;
			if(value1 < 5000)
			{
				value1 = 5000;
			}
			value = (value1 / goal_based_amount) * 100;
			value = value * max_count;
			value = parseFloat(value.toFixed(2));
			total_percentage = total_percentage + value;
			total_amount = total_amount + value;
			if(total_percentage > 100)
			{
				value = 100 - total_percentage;
			}
			hybrid_debt = value;
			//alert("hybrid_debt----->"+hybrid_debt);
		}
	}
	if(equity_balanced > 0)
	{
		if(total_percentage >= 100)
		{
			equity_balanced = 0;
		}else
		{
			if(equity_balanced <= 15 || goal_based_amount <= 50000)
			{
				max_count = 1;
			}else if(equity_balanced <= 39)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
			
			value = equity_balanced / max_count;
			value1 = goal_based_amount * (value / 100);
			value1 = Math.round(value1 / 1000) * 1000;
			if(value1 < 5000)
			{
				value1 = 5000;
			}
			value = (value1 / goal_based_amount) * 100;
			value = value * max_count;
			value = parseFloat(value.toFixed(2));
			total_percentage = total_percentage + value;
			total_amount = total_amount + value;
			if(total_percentage > 100)
			{
				value = 100 - total_percentage;
			}
			equity_balanced = value;
			//alert("equity_balanced----->"+equity_balanced);
		}
	}
	if(equity_largecap > 0)
	{
		if(total_percentage >= 100)
		{
			equity_largecap = 0;
		}else
		{
			if(equity_largecap <= 15 || goal_based_amount <= 50000)
			{
				max_count = 1;
			}else if(equity_largecap <= 39)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
			
			value = equity_largecap / max_count;
			value1 = goal_based_amount * (value / 100);
			value1 = Math.round(value1 / 1000) * 1000;
			if(value1 < 5000)
			{
				value1 = 5000;
			}
			value = (value1 / goal_based_amount) * 100;
			value = value * max_count;
			value = parseFloat(value.toFixed(2));
			total_percentage = total_percentage + value;
			total_amount = total_amount + value;
			if(total_percentage > 100)
			{
				value = 100 - total_percentage;
			}
			equity_largecap = value;
			//alert("equity_largecap----->"+equity_largecap);
		}
	}
	if(equity_diversified > 0)
	{
		if(total_percentage >= 100)
		{
			equity_diversified = 0;
		}else
		{
			if(equity_diversified <= 15 || goal_based_amount <= 50000)
			{
				max_count = 1;
			}else if(equity_diversified <= 39)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
			
			value = equity_diversified / max_count;
			value1 = goal_based_amount * (value / 100);
			value1 = Math.round(value1 / 1000) * 1000;
			if(value1 < 5000)
			{
				value1 = 5000;
			}
			value = (value1 / goal_based_amount) * 100;
			value = value * max_count;
			value = parseFloat(value.toFixed(2));
			total_percentage = total_percentage + value;
			total_amount = total_amount + value;
			if(total_percentage > 100)
			{
				value = 100 - total_percentage;
			}
			equity_diversified = value;
			//alert("equity_diversified----->"+equity_diversified);
		}
	}
	if(equity_midcap > 0)
	{
		if(total_percentage >= 100)
		{
			equity_midcap = 0;
		}else
		{
			if(equity_midcap <= 15 || goal_based_amount <= 50000)
			{
				max_count = 1;
			}else if(equity_midcap <= 39)
			{
				max_count = 2;
			}else{
				max_count = 3;
			}
			
			value = equity_midcap / max_count;
			value1 = goal_based_amount * (value / 100);
			value1 = Math.round(value1 / 1000) * 1000;
			if(value1 < 5000)
			{
				value1 = 5000;
			}
			value = (value1 / goal_based_amount) * 100;
			value = value * max_count;
			value = parseFloat(value.toFixed(2));
			total_percentage = total_percentage + value;
			total_amount = total_amount + value;
			if(total_percentage > 100)
			{
				value = 100 - total_percentage;
			}
			equity_midcap = value;
			//alert("equity_midcap----->"+equity_midcap);
		}
	}
	
	var total = liquid_debt + short_term_debt + long_term_debt + equity_balanced + equity_largecap + equity_midcap + equity_diversified + hybrid_debt;
	console.log("final total----->"+total); */
	
	donutChart();
}
function donutChart()
{		
	liquid_debt = parseFloat(liquid_debt);
	short_term_debt = parseFloat(short_term_debt);
	long_term_debt = parseFloat(long_term_debt);
	hybrid_debt = parseFloat(hybrid_debt);
	equity_balanced = parseFloat(equity_balanced);
	equity_largecap = parseFloat(equity_largecap);
	equity_midcap = parseFloat(equity_midcap);
	equity_diversified = parseFloat(equity_diversified);
	
	var category_array = new Array();
	if(liquid_debt > 0)
	{
		var arr = new Array();
		arr.push('Debt: Liquid');
		arr.push(liquid_debt);
		category_array.push(arr);
	}
	if(short_term_debt > 0)
	{
		var arr = new Array();
		arr.push('Debt: Short Duration');
		arr.push(short_term_debt);
		category_array.push(arr);
	}
	if(long_term_debt > 0)
	{
		var arr = new Array();
		arr.push('Debt: Long Duration');
		arr.push(long_term_debt);
		category_array.push(arr);
	}
	if(hybrid_debt > 0)
	{
		var arr = new Array();
		arr.push('Hybrid: Conservative');
		arr.push(hybrid_debt);
		category_array.push(arr);
	}
	if(equity_balanced > 0)
	{
		var arr = new Array();
		arr.push('Hybrid: Aggressive');
		arr.push(equity_balanced);
		category_array.push(arr);
	}
	if(equity_largecap > 0)
	{
		var arr = new Array();
		arr.push('Equity: Large Cap');
		arr.push(equity_largecap);
		category_array.push(arr);
	}
	if(equity_midcap > 0)
	{
		var arr = new Array();
		arr.push('Equity: Mid Cap');
		arr.push(equity_midcap);
		category_array.push(arr);
	}
	if(equity_diversified > 0)
	{
		var arr = new Array();
		arr.push('Equity: Multi Cap');
		arr.push(equity_diversified);
		category_array.push(arr);
	}
	
	$('#dount_chart').highcharts({
		//colors: ['#FF8900', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
		colors: ['#005e96', '#ee1c25', '#ffa200', '#e8ce1d', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4'],
        chart: {
            type: 'pie',
        },
        title: {
            text: ''
        },
        credits: {
            enabled: false
        },
        subtitle: {
            text: ''
        },
        tooltip: {
            pointFormat: '{point.percentage:.0f}%'
        },
        legend: {
            enabled: true,
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
			borderWidth: 0,
            useHTML: true,
			labelFormatter: function() {
				return '<div>' + this.y + '% - ' + this.name + '</div><br>';
			},
			itemStyle: {
	        	  font: 'normal 12px Helvetica Neue, Helvetica, Arial, sans-serif',
	        }
        },
        plotOptions: {
            pie: {
                innerSize: 100,
                depth: 45,
                dataLabels: {
                    enabled: false,
                    connectorWidth: 0,
                    format: '{point.name}<br>{point.percentage:.0f}%'
                },
                showInLegend: true
            }
        },
        series: [{
            name: '',
            data:category_array
        }]
    });
	
	var total = liquid_debt + short_term_debt + long_term_debt + equity_balanced + equity_largecap + equity_midcap + equity_diversified + hybrid_debt;
	//alert("donut adjust total----->"+total);
	
	var hybrid_75_percent = (hybrid_debt / 100) * 75;
	var hybrid_25_percent = (hybrid_debt / 100) * 25;
	var balanced_35_percent = (equity_balanced / 100) * 35;
	var balanced_65_percent = (equity_balanced / 100) * 65;
	hybrid_75_percent = Math.round(hybrid_75_percent);
	hybrid_25_percent = Math.round(hybrid_25_percent);
	balanced_35_percent = Math.round(balanced_35_percent);
	balanced_65_percent = Math.round(balanced_65_percent);
	
	debt = liquid_debt + short_term_debt + long_term_debt + hybrid_75_percent + balanced_35_percent;
	equity = equity_largecap + equity_midcap + equity_diversified + hybrid_25_percent + balanced_65_percent;
	var total = debt + equity;
	
	//alert("debt--->"+debt);
	//alert("equity-->"+equity);
	
	if(total > 100)
	{
		debt = debt - (total - 100);
	}
	
	if(portfolio_flag)
	{
		portfolio_flag = false;
	}
	if(projected_flag)
	{
		projected_flag = false;
	}
	if(historical_flag)
	{
		historical_flag = false;
	}
	
	if(btn_state == 1)
	{
		
	}
	if(btn_state == 2)
	{
		completeStep4();
		portfolio_flag = true;
	}
	if(btn_state == 3)
	{
		
	}
	if(btn_state == 4)
	{
		completeStep6();
		historical_flag = true;
	}
	if(btn_state == 5)
	{
		completeStep5();
		projected_flag = true;
	}
	renderPieChart();
}
function renderPieChart()
{    
	equity = parseFloat(equity);
	debt = parseFloat(debt);
	
	var category_arr = new Array();
	if(equity > 0)
	{
		var arr = new Array();
		arr.push("Equity");
		arr.push(equity);
		category_arr.push(arr);
	}
	if(debt > 0)
	{
		var arr = new Array();
		arr.push("Debt");
		arr.push(debt);
		category_arr.push(arr);
	}
    
    $('#asset_allocation_chart').highcharts({
    	//colors: ['#FF8900', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
    	colors: ['#005e96', '#ee1c25', '#ffa200', '#e8ce1d', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4'],
        chart: {
            type: 'pie',
        },
        title: {
            text: ''
        },
        credits: {
            enabled: false
        },
        subtitle: {
            text: ''
        },
        tooltip: {
            pointFormat: '{point.percentage:.0f}%'
        },
        legend: {
            enabled: true,
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
			borderWidth: 0,
            useHTML: true,
			labelFormatter: function() {
				return '<div>' + this.y + '% - ' + this.name + '</div><br>';
			},
			itemStyle: {
	        	  font: 'normal 12px Helvetica Neue, Helvetica, Arial, sans-serif',
	        }
        },
        plotOptions: {
            pie: {
                innerSize: 100,
                depth: 45,
                dataLabels: {
                    enabled: false,
                    connectorWidth: 0,
                    format: '{point.name}<br>{point.percentage:.0f}%'
                },
                showInLegend: true
            }
        },
        series: [{
            name: '',
            data: category_arr
        }]
    });
}
function gotoTop()
{
	$('#category_allocation_table').hide();
	$('html,body').animate({
        scrollTop: 0
    }, 700);
} 
function completeStep4()
{
	$('#tbl_portfolio_returns').html("");
	$('#portfolio_spinner_div').show();
	
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
	
	var total_amount = 0;
	var total_percentage = 0;
	var loop_count = 0;
	var html = "";
	var last_category_flag = false;
	
	html += "<thead><tr>";
	html += "<th>Scheme Name</th>";
	html += "<th>Category</th>";
	html += "<th class='text-right'>1 Yr Ret (%)</th>";
	html += "<th class='text-right'>3 Yr Ret (%)</th>";
	html += "<th class='text-right'>5 Yr Ret (%)</th>";
	html += "<th width='150' class='text-right'>Allocation Amount</th>";
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
		
		var goal_based_amount = parseFloat(amount);
		if(goal_based_amount <= 50000)
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
				var scheme_category = schemePerformances_array[i].scheme_category;
				var oneYrRt = schemePerformances_array[i].returns_abs_1year;
				var threeYrRt = schemePerformances_array[i].returns_cmp_3year;
				var fiveYrRt = schemePerformances_array[i].returns_cmp_5year;
				
				loop_count++;
				var value = 0;
    			var value1 = 0;
    			
    			if(i == (count - 1))
				{
					scheme_flag = true;
				}
		    	
		    	html += "<tr>";
		    	html += '<td><span id="span_scheme_'+loop_count+'">' + scheme_name + '</span> | <a href="javascript:;" onclick="schemeChange('+loop_count+', \''+category+'\')">Change Scheme</a></td>';
		    	//if(i == 0)
		    	{
		    		html += "<td id='txt_category_"+loop_count+"'>" + category + "</td>";

		    		html += "<td class='text-right' id='1yrt_" + loop_count + "'>" + oneYrRt + "</td>";
					html += "<td class='text-right' id='3yrt_" + loop_count + "'>" + threeYrRt + "</td>";
					html += "<td class='text-right' id='5yrt_" + loop_count + "'>" + fiveYrRt + "</td>";
					
		    		if(category == "Debt: Liquid")
			        {
		    			value = liquid_debt / count;
	    				value1 = goal_based_amount * (value / 100);
	    				
		    			if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
			    			value1 = Math.round(value1 / 1000) * 1000;
			    			value = (value1 / goal_based_amount) * 100;
			    			if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
		    			total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Debt: Short Duration")
			        {
			        	value = short_term_debt / count;
	    				value1 = goal_based_amount * (value / 100);
	    				
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
				        	value1 = Math.round(value1 / 1000) * 1000;
				        	value = (value1 / goal_based_amount) * 100;
				        	if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
			        	total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Debt: Long Duration")
			        {
			        	value = long_term_debt / count;
			        	value1 = goal_based_amount * (value / 100);
			        	
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
				        	value1 = Math.round(value1 / 1000) * 1000;
				        	value = (value1 / goal_based_amount) * 100;
				        	if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
		    			total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Hybrid: Conservative")
			        {
			        	value = hybrid_debt / count;
			        	value1 = goal_based_amount * (value / 100);
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
		    				value1 = Math.round(value1 / 1000) * 1000;
				        	value = (value1 / goal_based_amount) * 100;
				        	if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
			        	
		    			total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Hybrid: Aggressive")
			        {
			        	value = equity_balanced / count;
			        	value1 = goal_based_amount * (value / 100);
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
		    				value1 = Math.round(value1 / 1000) * 1000;
				        	value = (value1 / goal_based_amount) * 100;
				        	if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
		    			total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Equity: Large Cap")
			        {
			        	value = equity_largecap / count;
			        	value1 = goal_based_amount * (value / 100);
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
		    				value1 = Math.round(value1 / 1000) * 1000;
				        	value = (value1 / goal_based_amount) * 100;
				        	if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
		    			total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Equity: Multi Cap")
			        {
			        	value = equity_diversified / count;
			        	value1 = goal_based_amount * (value / 100);
			        	
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
		    				value1 = Math.round(value1 / 1000) * 1000;
				        	value = (value1 / goal_based_amount) * 100;
				        	if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
		    			total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }else if(category == "Equity: Mid Cap")
			        {
			        	value = equity_midcap / count;
			        	value1 = goal_based_amount * (value / 100);
			        	
			        	if(last_category_flag && scheme_flag)
		    			{
		    				if((total_percentage + value) < 100 || (total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}else
		    			{
		    				value1 = Math.round(value1 / 1000) * 1000;
				        	value = (value1 / goal_based_amount) * 100;
				        	if((total_percentage + value) > 100)
		    				{
			    				value = 100 - total_percentage;
			    				value1 = goal_based_amount - total_amount;
		    				}
		    			}
		    			total_percentage = total_percentage + value;
		    			total_amount = total_amount + value1;
		    			
			        	html += "<td><input type='text' class='fc-2 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }
		    	}
		    	html += '<td align="center"><input type="button" class="btn btn-primary btn-sm btn-block btn-edit" id="btn_'+loop_count+'" value="Edit" onclick="editScheme('+loop_count+')" /></td>';
		    	html += '<td align="center"><input type="checkbox" name="save_goal" value="'+loop_count+'"></td>';
		    	html += "</tr>";
		    }
			
	    },'text');
    }
	
	html += "</tbody>"; 
	html += "<tfoot>"; 
	html += "<tr>";
	html += "<td></td>";
	html += "<td></td>";
	html += "<td></td>";
	html += "<td></td>";
	html += "<td style='font-size:1.1rem !important;'>Total</td>";
	html += "<td><input type='text' class=' fc-2 textInputRadius pull-right text-right' id='allocation_amount_total' value='"+numbersWithComma(parseFloat(goal_based_amount).toFixed(2))+"' disabled='disabled'></td>";
	html += "<td></td>";
	html += "<td></td>";
	html += "</tfoot>"; 
	
	$('#tbl_portfolio_returns').html(html);
	$('#portfolio_spinner_div').hide();
	
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
	var goal_based_amount = parseFloat(amount);
	
	var value = $("#txt_allocation_amount_"+count).val();
	if(value == "" || parseFloat(value) <= 0)
	{
		value = 0.0;
		$("#txt_allocation_amount_"+count).val(parseFloat(value).toFixed(2));
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
	var value = $("#btn_"+count).val();
	if(value == "Edit")
	{
		var flag = true;
		$(".btn-edit" ).each(function( index ) {
			var btn_text = $( this ).val();
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
			$("#btn_"+count).val("Save");
		}
	}else
	{
		$("#txt_allocation_amount_"+count).attr('disabled',true);
		$("#btn_"+count).val("Edit");
	}
}
function schemeChange(id, category)
{
	var html = '<table class="adv-table table table-striped table-bordered table-responsive">';
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
	    	html += "<td><span id='selected_new_scheme_"+i+"'>" + scheme_name + "</span></td>";
			html += "<td id='txt_category_"+i+"'>" + category + "</td>";
			html += "<td id='txt_category_"+i+"'>" + returns_abs_1year + "</td>";
			html += "<td id='txt_category_"+i+"'>" + returns_cmp_3year + "</td>";
			html += "<td id='txt_category_"+i+"'>" + returns_cmp_5year + "</td>";
			html += "<td id='txt_category_"+i+"'>" + returns_cmp_10year + "</td>";
			html += "<td id='txt_category_"+i+"'>" + returns_cmp_inception + "</td>";
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
		$("#span_scheme_"+id).html(scheme);
	}
	$("#scheme_name_change_model").modal('hide');
}
function completeStep5()
{
	$('#sip-gth-container').html('');
	$('#sip-gth-container_div1').hide();
	$('#sip-gth-container_div2').hide();
	$('#projected_spinner_div').show();
	
	var final_maximum = 0;
	var final_median = 0;
	var final_minimum = 0;
	
	//var cat_rolling_array = new Array();
	if(liquid_debt > 0)
	{
		//cat_rolling_array.push("Debt: Liquid");	
		var maximum_returns = 7;
		var median_returns = 6.5;
		var minimum_returns = 6;
		
		final_maximum = final_maximum + ((maximum_returns * liquid_debt) / 100);
    	final_median = final_median + ((median_returns * liquid_debt) / 100);
    	final_minimum = final_minimum + ((minimum_returns * liquid_debt) / 100);
	}
	if(short_term_debt > 0)
	{
		//cat_rolling_array.push("Debt: Short Duration");
		var maximum_returns = 9;
		var median_returns = 8;
		var minimum_returns = 7;
		
		final_maximum = final_maximum + ((maximum_returns * short_term_debt) / 100);
    	final_median = final_median + ((median_returns * short_term_debt) / 100);
    	final_minimum = final_minimum + ((minimum_returns * short_term_debt) / 100);
	}
	if(long_term_debt > 0)
	{
		//cat_rolling_array.push("Debt: Long Duration");	
		var maximum_returns = 9;
		var median_returns = 8;
		var minimum_returns = 7;
		
		final_maximum = final_maximum + ((maximum_returns * long_term_debt) / 100);
    	final_median = final_median + ((median_returns * long_term_debt) / 100);
    	final_minimum = final_minimum + ((minimum_returns * long_term_debt) / 100);
	}
	if(hybrid_debt > 0)
	{
		//cat_rolling_array.push("Hybrid: Conservative");	
		var maximum_returns = 10;
		var median_returns = 9;
		var minimum_returns = 8;
		
		final_maximum = final_maximum + ((maximum_returns * hybrid_debt) / 100);
    	final_median = final_median + ((median_returns * hybrid_debt) / 100);
    	final_minimum = final_minimum + ((minimum_returns * hybrid_debt) / 100);
	}
	if(equity_balanced > 0)
	{
		//cat_rolling_array.push("Hybrid: Aggressive");	
		var maximum_returns = 14;
		var median_returns = 11;
		var minimum_returns = 5;
		
		final_maximum = final_maximum + ((maximum_returns * equity_balanced) / 100);
    	final_median = final_median + ((median_returns * equity_balanced) / 100);
    	final_minimum = final_minimum + ((minimum_returns * equity_balanced) / 100);
	}
	if(equity_largecap > 0)
	{
		//cat_rolling_array.push("Equity: Large Cap");	
		var maximum_returns = 15;
		var median_returns = 12;
		var minimum_returns = 6;
		
		final_maximum = final_maximum + ((maximum_returns * equity_largecap) / 100);
    	final_median = final_median + ((median_returns * equity_largecap) / 100);
    	final_minimum = final_minimum + ((minimum_returns * equity_largecap) / 100);
	}
	if(equity_midcap > 0)
	{
		//cat_rolling_array.push("Equity: Mid Cap");	
		var maximum_returns = 16;
		var median_returns = 13;
		var minimum_returns = 7;
		
		final_maximum = final_maximum + ((maximum_returns * equity_midcap) / 100);
    	final_median = final_median + ((median_returns * equity_midcap) / 100);
    	final_minimum = final_minimum + ((minimum_returns * equity_midcap) / 100);
	}
	if(equity_diversified > 0)
	{
		//cat_rolling_array.push("Equity: Multi Cap");	
		var maximum_returns = 15;
		var median_returns = 12;
		var minimum_returns = 6;
		
		final_maximum = final_maximum + ((maximum_returns * equity_diversified) / 100);
    	final_median = final_median + ((median_returns * equity_diversified) / 100);
    	final_minimum = final_minimum + ((minimum_returns * equity_diversified) / 100);
	}
	
	final_maximum = parseFloat(final_maximum.toFixed(2));
	final_median = parseFloat(final_median.toFixed(2));
	final_minimum = parseFloat(final_minimum.toFixed(2));
	
	/* console.log("final_maximum------->"+final_maximum);
	console.log("final_median------->"+final_median);
	console.log("final_minimum------->"+final_minimum); */
	
	var data_array = new Array();
	var year_list_array = new Array();
	var invested_value_array = new Array();
	var expected_value_array = new Array();
	var minimum_expected_value_array = new Array();
	var maximum_expected_value_array = new Array();
	var invested_amount = Math.round(amount);
	var expected_amount = parseFloat(amount);
	var minimum_expected_amount = parseFloat(amount);
	var maximum_expected_amount = parseFloat(amount);
	choosen_year = parseInt(choosen_year);
	var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
	var d = new Date();
	var current_year = d.getFullYear();
    var current_month = months[d.getMonth()];
    var final_year = 0;
	var final_growth_amount = 0;
	
	var choose = choosen_year;
	if(choosen_year == 1)
	{
		choose = 2;	
	}
	
	for(var k=1; k<=choose;k++)
	{
		year_list_array.push("Year"+k);
		invested_value_array.push(invested_amount);
		if(k == 1)
		{
			expected_amount = Math.round(expected_amount);
			minimum_expected_amount = Math.round(minimum_expected_amount);
			maximum_expected_amount = Math.round(maximum_expected_amount);
			
			expected_value_array.push(expected_amount);
			minimum_expected_value_array.push(minimum_expected_amount);
			maximum_expected_value_array.push(maximum_expected_amount);
		}else
		{
			expected_amount = expected_amount + ((final_median / 100) * expected_amount);
			minimum_expected_amount = minimum_expected_amount + ((final_minimum / 100) * minimum_expected_amount);
			maximum_expected_amount = maximum_expected_amount + ((final_maximum / 100) * maximum_expected_amount);
			
			expected_amount = Math.round(expected_amount);
			minimum_expected_amount = Math.round(minimum_expected_amount);
			maximum_expected_amount = Math.round(maximum_expected_amount);
			
			expected_value_array.push(expected_amount);
			minimum_expected_value_array.push(minimum_expected_amount);
			maximum_expected_value_array.push(maximum_expected_amount);
			
			current_year = current_year + 1;
			final_year = current_year;
			final_growth_amount = expected_amount;
		}
	}
	
	$('.span_future_year').html(current_month + ' ' + final_year);
	$('.span_future_invested_amount').html(numbersWithComma(amount));
	$('.span_future_final_amount').html(numbersWithComma(final_growth_amount));
	
	//var colors = ['#24CBE5', '#FF8900', '#DDDF00', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'];
	var colors = ['#005e96', '#ee1c25', '#ffa200', '#e8ce1d', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4'];
	var obj = {
			name: "Invested Amount",
            data: invested_value_array,
            color : colors[0]
		};
	data_array.push(obj);
	
	var obj = {
			name: "Minimum Expected Growth",
            data: minimum_expected_value_array,
            color : colors[1]
		};
	data_array.push(obj);
	
	var obj = {
			name: "Expected Growth",
            data: expected_value_array,
            color : colors[2]
		};
	data_array.push(obj);
	
	var obj = {
			name: "Maximum Expected Growth",
            data: maximum_expected_value_array,
            color : colors[3]
		};
	data_array.push(obj);
	
	$('#projected_spinner_div').hide();
	
	$('#sip-gth-container').highcharts({
		chart: {
        },
        title: {
            text: '',
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: year_list_array
        },
        yAxis: {
        	title: {
                text: 'Amount (Rs.)'
            }
        },
        tooltip: {
            formatter: function() {
                var s = '<b>'+ this.x +'</b>';
                s += '<br><span style="color:'+ this.series.color +'">' + this.series.name + '</span>:<b>Rs ' + numbersWithComma(this.y) +'</b>';
                if(this.series.name == "Expected Growth")
            	{
                	s += '<br/><span style="color:'+ this.series.color +'">Expected Return</span>:<b>' + final_median +'%</b>';
            	}
                if(this.series.name == "Minimum Expected Growth"){
            		s += '<br/><span style="color:'+ this.series.color +'">Minimum Expected Return</span>:<b>' + final_minimum +'%</b>';
            	}
                if(this.series.name == "Maximum Expected Growth"){
            		s += '<br/><span style="color:'+ this.series.color +'">Maximum Expected Return</span>:<b>' + final_maximum +'%</b>';
            	}
                return s;
            }
        },
        legend: {
            enabled:true,
            itemStyle: {
	        	  font: 'normal 12px Helvetica Neue, Helvetica, Arial, sans-serif',
	        }
        },
        credits: {
            enabled: false
        },
        series: data_array
    });
	
	$('#sip-gth-container_div1').show();
	$('#sip-gth-container_div2').show();
}
function completeStep6()
{
	$('#historical-container').html('');
	$('#historical-container_div1').hide();
	$('#historical_spinner_div').show();
	
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
	if(equity_midcap > 0)
	{
		cat_rolling_array.push("Equity: Mid Cap");	
	}
	if(equity_diversified > 0)
	{
		cat_rolling_array.push("Equity: Multi Cap");	
	}
	
	var rolling_category = cat_rolling_array.toString();		
	var final_median = 0;
    
	$.ajaxSetup({async:false});
	$.post("/goal/getSipHistoricalReturnsByCategory", {category : rolling_category}, function(data)
    {
		var schemePerformances = $.trim(data);
		var schemePerformances_obj = jQuery.parseJSON(schemePerformances);
		var schemePerformances_array = $.makeArray(schemePerformances_obj);
		
		for (var i = 0; i < schemePerformances_array.length ; i++)
	    {
			var category = schemePerformances_array[i].category;
			var returns = schemePerformances_array[i].median_rolling_returns;
			
			if(category == "Debt: Liquid")
	        {
		    	final_median = final_median + ((returns * liquid_debt) / 100);
	        }else if(category == "Debt: Short Duration")
	        {
	        	final_median = final_median + ((returns * short_term_debt) / 100);
	        }else if(category == "Debt: Long Duration")
	        {
	        	final_median = final_median + ((returns * long_term_debt) / 100);
	        }else if(category == "Hybrid: Conservative")
	        {
	        	final_median = final_median + ((returns * hybrid_debt) / 100);
	        }else if(category == "Hybrid: Aggressive")
	        {
	        	final_median = final_median + ((returns * equity_balanced) / 100);
	        }else if(category == "Equity: Large Cap")
	        {
	        	final_median = final_median + ((returns * equity_largecap) / 100);
	        }else if(category == "Equity: Mid Cap")
	        {
	        	final_median = final_median + ((returns * equity_midcap) / 100);
	        }else if(category == "Equity: Multi Cap")
	        {
	        	final_median = final_median + ((returns * equity_diversified) / 100);
	        }
	    } 
    	
    },'text');
	
	var historical_return = parseFloat(final_median.toFixed(2));
	
	console.log("historical_return------>"+historical_return);
	
	var fd_year = parseInt(choosen_year);
	if(fd_year > 10)
	{
		fd_year = 10;
	}
	$(".span_lumpsum_year").html(fd_year);
	var data_array = new Array();
	var invested_value_array = new Array();
	var expected_value_array = new Array();
	var invested_amount = Math.round(amount);
	var expected_amount = parseFloat(amount);
	var d = new Date();
	var current_year = d.getFullYear();
	current_year = current_year - fd_year;
	var fd_start_year = current_year;
	var year_list_array = new Array();
	
	for(var k=0;k<=fd_year;k++)
	{
		if(k == 0)
		{
			expected_amount = Math.round(expected_amount);
			expected_value_array.push(expected_amount);
		}else
		{
			expected_amount = expected_amount + ((historical_return / 100) * expected_amount);
			expected_amount = Math.round(expected_amount);
			expected_value_array.push(expected_amount);
		}
		year_list_array.push(current_year);
		invested_value_array.push(invested_amount);
		current_year = current_year + 1;
	}
	
	//var colors = ['#FF8900', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'];
	var colors = ['#005e96', '#ee1c25', '#ffa200', '#e8ce1d', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4'];
	
	var obj = {
		name: "Invested Amount",
        data: invested_value_array,
        color : colors[0]
	};
	data_array.push(obj);
	
	var obj = {
		name: "Growth",
        data: expected_value_array,
        color : colors[1]
	};
	data_array.push(obj);
	
	$('#historical_spinner_div').hide();
	
	$('#historical-container').highcharts({
		chart: {
        },
        title: {
            text: '',
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: year_list_array
        },
        yAxis: {
        	title: {
                text: 'Amount (Rs.)'
            }
        },
        tooltip: {
        	formatter: function() {
                var s = 'Year : '+ this.x;
                s += '<br><span style="color:'+ this.series.color +'">' + this.series.name + '</span> : Rs. ' + numbersWithComma(Math.round(this.y));
                return s;
            }
        },
        legend: {
            enabled:true,
            itemStyle: {
	        	  font: 'normal 12px Helvetica Neue, Helvetica, Arial, sans-serif',
	        }
        },
        credits: {
            enabled: false
        },
        series: data_array
    });
	
	$('#historical-container_div1').show();
}
function savePlan()
{
	var scheme_array = new Array();
	var category_array = new Array();
	var percentage_array = new Array();
	var amount_array = new Array();
	
	$("input[name='save_goal']:checked").each(function()
	{
	      var count = $(this).val();
	      var scheme_name = $("#span_scheme_"+count).html();
	      var category = $("#txt_category_"+count).html();
	      var allocation_percentage = 0;
	      var allocation_amount = $("#txt_allocation_amount_"+count).val();
	      allocation_amount = allocation_amount.replace(/,/g,'');
	      
	      scheme_array.push(scheme_name);
	      category_array.push(category);
	      percentage_array.push(allocation_percentage);
	      amount_array.push(allocation_amount);
	});
	
	if(scheme_array.length == 0)
	{
		alert("Please select the scheme and save your plan.");
		return false;
	}
	
	var scheme_array_str = scheme_array.toString();
	var category_array_str = category_array.toString();
	var percentage_array_str = percentage_array.toString();
	var amount_array_str = amount_array.toString();
	
	$.ajaxSetup({async:false});
	$.post("/goal/saveRoboPlan", {age : "" + age + "",risk : "" + risk + "",amount : "" + amount + "",horizon : "" + horizon + "",
		type : "Lumpsum Robo Advisor",scheme_array : "" + scheme_array_str + "",category_array : "" + category_array_str + "",percentage_array : "" + percentage_array_str + "",
		amount_array : "" + amount_array_str + ""}, function(data)
    {
		var result = $.trim(data);
  		var obj = jQuery.parseJSON(result);
   		if(obj.status == 400)
   		{
   			swal({title:"", text: ""+obj.msg});
          	return false;
   		}
   		
   		swal({
	        title: "",
	        text: "Your Lumpsum Robo plan successfully saved.",
	        type: "success"
	    }, function () 
	    {
	    	top.location = "https://mfportfolio.dakshincapital.com/bse/bse-robo-based-online-investment?pan="+investor_pan+"&id="+obj.msg;
	    });
		return;
		
    },'text');
}
function showLogin()
{
	var scheme_array = new Array();
	var category_array = new Array();
	var percentage_array = new Array();
	var amount_array = new Array();
	
	$("input[name='save_goal']:checked").each(function()
	{
	      var count = $(this).val();
	      var scheme_name = $("#span_scheme_"+count).html();
	      var category = $("#txt_category_"+count).html();
	      var allocation_percentage = 0;
	      var allocation_amount = $("#txt_allocation_amount_"+count).val();
	      allocation_amount = allocation_amount.replace(/,/g,'');
	      
	      scheme_array.push(scheme_name);
	      category_array.push(category);
	      percentage_array.push(allocation_percentage);
	      amount_array.push(allocation_amount);
	});
	
	if(scheme_array.length == 0)
	{
		alert("Please select the scheme and save your plan.");
		return false;
	}
	
	var scheme_array_str = scheme_array.toString();
	var category_array_str = category_array.toString();
	var percentage_array_str = percentage_array.toString();
	var amount_array_str = amount_array.toString();
	
	$.ajaxSetup({async:false});
	$.post("/goal/saveRoboPlanWithoutLogin", {age : "" + age + "",risk : "" + risk + "",amount : "" + amount + "",horizon : "" + horizon + "",
		type : "Lumpsum Robo Advisor",scheme_array : "" + scheme_array_str + "",category_array : "" + category_array_str + "",percentage_array : "" + percentage_array_str + "",
		amount_array : "" + amount_array_str + ""}, function(data)
    {
		var result = $.trim(data);
  		var obj = jQuery.parseJSON(result);
   		if(obj.status == 400)
   		{
   			swal({title:"", text: ""+obj.msg});
          	return false;
   		}
   		top.location = "https://mfportfolio.dakshincapital.com?authcode="+$.trim(obj.msg);
		return;
		
    },'text');
}
</script>

<div class="container-fluid">

<div class="row">
<div class="robo1 ques_1">  

<div class="row"> 
<div class="col-md-12 col-sm-12">
<div class="title-v1">
	<h1 class="goal_name text-center">Lumpsum Robo Advisor</h1>
</div>
</div>
</div>

<div class="row">   
<div class="col-md-12 col-sm-12" style="margin:0 auto; float:none; text-align:center;">
<div class="row pt-4">
<div class="col-md-12 form-inline">
<div class="row" style="width: 100%;margin:0px;">
<div class="col lamount" style="float:none;">
	<div><b>Your age is</b></div>
	<input type="text" value="18" id="txt_age" class="fc-2" onchange="ageChange()" maxlength="9" />
	<div id="age_slider" style="margin:0px;"></div>
</div>

<div class="col lamount" style="float:none;">
	<div><b>You want to invest</b></div>
	<input type="text" value="1000000" id="txt_amount" class="fc-2" onchange="amountChange()" maxlength="9" />
	<div id="amount_slider" style="margin:0px;"></div>
</div>
</div>
</div>
</div>

<div class="row pt-4">
<div class="col-md-12 form-inline">
<div class="row" style="margin:0px auto;">
<div class="col lamount" style="float:none;">
	<div><b>Time Horizon</b></div>
	<select id="sel_period"  class="fc-2 mb-4 roboInput" onchange="riskProfileChange()" style="text-align:center;margin-top: 10px;">
	<option value="">Select</option>
	<option value="Between 0-1 year">Between 0-1 year</option>
	<option value="Between 1-3 years">Between 1-3 years</option>
	<option value="Between 4-7 years">Between 4-7 years</option>
	<option value="Between 8-15 years">Between 8-15 years</option>
	<option value="16 years and above">16 years and above</option>
	</select>
</div>

<div class="col lamount" style="float:none;">
	<div><b>Your Risk Profile</b></div>
	<select id="sel_risk"  class="fc-2 mb-4" onchange="riskProfileChange()" style="text-align:center;margin-top: 10px;">
		<option value="">Check Your Risk Profile</option>
		<option selected value="Conservative">Conservative</option>
		<option value="Moderately Conservative">Moderately Conservative</option>
		<option value="Moderate">Moderate</option>
		<option value="Moderately Aggressive">Moderately Aggressive</option>
		<option value="Aggressive">Aggressive</option>
	</select>
</div>
</div>
</div>
</div>

<div class="row">
<div class="col-md-12 text-center py-5">	
<button class="btn btn-primary hidden-xs" style="margin:0 auto; float: none;" onclick="completeStep1()">Build My Plan</button>
</div>
</div>

</div> 
</div>
</div>
</div>
</div>

<div class="robo2">
	<div class="container calc_div body-color" id="step1">	
	 <div class="row text-center">	  
		<div class="col-lg-12">
	        <h3 class="">Assess Your Risk Tolerance</h3>
	        <p>We will ask you a set of questions to get to know you!</p>
	    </div>
	  </div>
	  <div class="row">
	   <div class="col-lg-12 pt-4">	   
		  <div class="row">
			 <div class="col-lg-12 text-center">
			     <h4 class="text-dark">Step 1:</h4>
				  <p class="textColor font-size-19 question"> Describe your knowledge of investment:</p>
				  <div class="row">
				    <div class="col-lg-12">
						<div class="hrline-45"></div>
					</div>
				  </div>
			  </div>
			</div>		   
		    <div class="row">
			 <div class="col-md-6" style="margin: 0 auto;display:grid;">
			 	<label class="form-check-label mt-3 py-3 answer" style="border-top: 1px solid #ddd;">
				  <input type="radio" name="q1" value="1">
				  &nbsp;None
				  <span class="checkmark"></span>
				</label>
				<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
				  <input type="radio" name="q1" value="2">
				  &nbsp;Limited
				  <span class="checkmark"></span>
				</label>
				<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
				  <input type="radio" name="q1" value="3">
				  &nbsp;Goods
				  <span class="checkmark"></span>
				</label>
				<label class="form-check-label py-3 answer_last" style="border-top: 1px solid #ddd;border-bottom: 1px solid #ddd;">
				  <input type="radio" name="q1" value="4">
				  &nbsp;Extensive
				  <span class="checkmark"></span>
				</label>
			</div>
		   </div>
		   
		 <div class=" row py-4">
		 <div class="col-lg-12 text-center pb-4">
		 <button class="btn btn-border" onclick="goToStep1()">Back</button>
		 <button class="btn btn-primary" onclick="show_ques_div(1)">Continue</button>
		 </div>
	  </div>
	 </div>
	</div>
	</div>
	
	<div class="container calc_div"  id="step2">
		<div class="row text-center">	  
			<div class="col-lg-12">
		        <h3 class="">Assess Your Risk Tolerance</h3>
		        <p>We will ask you a set of questions to get to know you!</p>
		    </div>
	  	</div>
  	<div class="row">
		<div class="col-lg-12 pt-4">
			<div class="row">
	 			<div class="col-lg-12 text-center">
	     			<h4 class="text-dark">Step 2:</h4>
		  			<p class="textColor font-size-19 question">When you invest your money, you are:</p>
		 			<!-- <div class="w-50 border-bottom text-center"></div> -->
		  			<div class="row">
	 					<div class="col-lg-12">
							<div class="hrline-45"></div>
						</div>
					</div>
		  		</div>
		   	</div>
		    <div class="row">
	 			<div class="col-md-6" style="margin: 0 auto;display:grid;">
	 				<label class="form-check-label mt-3 py-3 answer" style="border-top: 1px solid #ddd;">
	  					<input type="radio" name="q2" value="1">
	  					&nbsp;Most concerned about your investment value
	  					<span class="checkmark"></span>
					</label>
					<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
  						<input type="radio" name="q2" value="2">
  						&nbsp;Equally concerned about your investment losing or gaining value
  						<span class="checkmark"></span>
					</label>
					<label class="form-check-label py-3 answer_last" style="border-top: 1px solid #ddd;border-bottom: 1px solid #ddd;">
					  <input type="radio" name="q2" value="3">
					  &nbsp;Most concerned about your investment gaining value
					  <span class="checkmark"></span>
					</label>
				</div>
		   </div>
			 <div class="row py-4">
				 <div class="col-lg-12 text-center pb-4">
					 <button class="btn btn-border" onclick="hide_div(2)">Back</button>
					 <button class="btn btn-primary" onclick="show_ques_div(2)">Continue</button>
				 </div>
		  	</div>
	  	</div>
 	  </div>
	</div>
	
	<div class="container calc_div" id="step3">
		<div class="row text-center">	  
			<div class="col-lg-12">
	        	<h3 class="">Assess Your Risk Tolerance</h3>
	        	<p>We will ask you a set of questions to get to know you!</p>
	    	</div>
	 	</div>
	  	<div class="row">
	   		<div class="col-lg-12 pt-4">
	    		<div class="row">
	 				<div class="col-lg-12 text-center">
	     				<h4 class="text-dark">Step 3:</h4>
		  				<p class="textColor font-size-19 question">If the market lost 25% in the last few months, and your investments also suffered the same - what would be your first impulse?</p>
						<div class="row">
						 	<div class="col-lg-12">
								<div class="hrline-75"></div>
							</div>
						</div>
		  			</div>
		   		</div>
		    	<div class="row">
	 				<div class="col-md-6" style="margin: 0 auto;display:grid;">
			 			<label class="form-check-label mt-3 py-3 answer" style="border-top: 1px solid #ddd;">
  							<input type="radio" name="q3" value="1">
  							&nbsp;Sell all of my investments
  							<span class="checkmark"></span>
						</label>
						<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
  							<input type="radio" name="q3" value="2">
  							&nbsp;Sell some of my investments
  							<span class="checkmark"></span>
						</label>
						<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
  							<input type="radio" name="q3" value="3">
  							&nbsp;Will wait and rake no action immediately
  							<span class="checkmark"></span>
						</label>
						<label class="form-check-label py-3 answer_last" style="border-top: 1px solid #ddd;border-bottom: 1px solid #ddd;">
						  <input type="radio" name="q3" value="4">
						  &nbsp;Will invest more
						  <span class="checkmark"></span>
						</label>	
					</div>
		   		</div>
				 <div class="row py-4">
					 <div class="col-lg-12 text-center pb-4">
						 <button class="btn btn-border" onclick="hide_div(3)">Back</button>
						 <button class="btn btn-primary" onclick="show_ques_div(3)">Continue</button>
					 </div>
			  	</div>
	  		</div>
	 	</div>
	</div>
	
	<div class="container calc_div" id="step4">
		<div class="row text-center">	  
			<div class="col-lg-12">
	        	<h3 class="">Assess Your Risk Tolerance</h3>
	        	<p>We will ask you a set of questions to get to know you!</p>
	    	</div>
	  	</div>
	   	<div class="row">
	   		<div class="col-lg-12 pt-4">
	    		<div class="row">
		 			<div class="col-lg-12 text-center">
					     <h4 class="text-dark">Step 4:</h4>
						  <p class="textColor font-size-19 question">Have you ever invested in shares or mutual funds? If yes,for how many years?</p>
							<div class="row">
							 	<div class="col-lg-12">
									<div class="hrline-55"></div>
								</div>
							</div>
			  			</div>
		   			</div>
		    		<div class="row">
	 					<div class="col-md-6" style="margin: 0 auto;display:grid;">
			 				<label class="form-check-label mt-3 py-3 answer" style="border-top: 1px solid #ddd;">
  								<input type="radio" name="q4" value="1">
  								&nbsp;Never
  								<span class="checkmark"></span>
							</label>
							<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
							  <input type="radio" name="q4" value="2">
							 &nbsp;1-3 years
							  <span class="checkmark"></span>
							</label>
							<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
							  <input type="radio" name="q4" value="3">
							 &nbsp;3-5 years
							  <span class="checkmark"></span>
							</label>
							<label class="form-check-label py-3 answer_last" style="border-top: 1px solid #ddd;border-bottom: 1px solid #ddd;">
							  <input type="radio" name="q4" value="4">
							  &nbsp;5+years
							  <span class="checkmark"></span>
							</label>
						</div>
					</div>
					 <div class="row py-4">
						  <div class="col-lg-12 text-center pb-4">
							 <button class="btn btn-border" onclick="hide_div(4)">Back</button>
							 <button class="btn btn-primary"onclick="show_ques_div(4)">Continue</button>
						 </div>
				  	 </div>
	  			</div>
	 		</div>
	 	</div>
	 	
	<div class="container calc_div" id="step5">
		 <div class="row text-center">	  
			<div class="col-lg-12">
	        	<h3 class="">Assess Your Risk Tolerance</h3>
	        	<p>We will ask you a set of questions to get to know you!</p>
	    	</div>
	  	</div>
	  	<div class="row">
	   		<div class="col-lg-12 pt-4">
	    		<div class="row">
	 				<div class="col-lg-12 text-center">
	     				<h4 class="text-dark">Step 5:</h4>
		  				<p class="textColor font-size-19 question">To obtain return of more then what you would receive as a bank fixed deposit,you must take risks.</p>
							<div class="row">
		 						<div class="col-lg-12">
									<div class="hrline-55"></div>
								</div>
							</div>
		  				</div>
		   		  </div>
		    	  <div class="row">
	 				<div class="col-md-6" style="margin: 0 auto;display:grid;">
			 			<label class="form-check-label mt-3 py-3 answer" style="border-top: 1px solid #ddd;">
  							<input type="radio" name="q5" value="1">
  							&nbsp;Strongly Disagree with the Statement
  							<span class="checkmark"></span>
						</label>
						<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
						  <input type="radio" name="q5" value="2">
						  &nbsp;Disagree with the Satatement
						  <span class="checkmark"></span>
						</label>
						<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
						  <input type="radio" name="q5" value="3">
						  &nbsp;Agree with the Statement
						  <span class="checkmark"></span>
						</label>
						<label class="form-check-label py-3 answer_last" style="border-top: 1px solid #ddd;border-bottom: 1px solid #ddd;">
						  <input type="radio" name="q5" value="4">
						  &nbsp;Strongly Agree with the Statement
						  <span class="checkmark"></span>
						</label>
					</div>
		   		</div>
				 <div class="row py-4">
					 <div class="col-lg-12 text-center pb-4">
						 <button class="btn btn-border" onclick="hide_div(5)">Back</button>
						 <button class="btn btn-primary" onclick="show_ques_div(5)">Continue</button>
					 </div>
				 </div>
	  		</div>
	 	</div>
	</div>
	
	<div class="container calc_div" id="step6">
		<div class="row text-center">	  
			<div class="col-lg-12">
		        <h3 class="">Assess Your Risk Tolerance</h3>
		        <p>We will ask you a set of questions to get to know you!</p>
	    	</div>
	  	</div>
	  	<div class="row">
	   		<div class="col-lg-12 pt-4">
	    		<div class="row">
	 				<div class="col-lg-12 text-center">
			     	<h4 class="text-dark">Step 6:</h4>
				  	<p class="textColor font-size-19 question">How do react to the idea of investments?</p>
		  				<div class="row">
	 						<div class="col-lg-12">
								<div class="hrline-45"></div>
							</div>
						</div>
		  			</div>
		   		</div>
		    	<div class="row">
	 				<div class="col-md-6" style="margin: 0 auto;display:grid;">
			 			<label class="form-check-label mt-3 py-3 answer" style="border-top: 1px solid #ddd;">
						  <input type="radio" name="q6" value="1">
						  &nbsp;I get stressed and avoid making financial decisions.
						  <span class="checkmark"></span>
						</label>
						<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
						  <input type="radio" name="q6" value="2">
						  &nbsp;I ask advice from or relatives.
						  <span class="checkmark"></span>
						</label>
						<label class="form-check-label py-3 answer" style="border-top: 1px solid #ddd;">
						  <input type="radio" name="q6" value="3">
						  &nbsp;I seek professional advice.
						  <span class="checkmark"></span>
						</label>
						<label class="form-check-label py-3 answer_last" style="border-top: 1px solid #ddd;border-bottom: 1px solid #ddd;">
						  <input type="radio" name="q6" value="4">
						  &nbsp;I am knowledgeable about investments and use my own expertise.
						  <span class="checkmark"></span>
						</label>
					</div>
		  		 </div>
				 <div class="row py-4">
					 <div class="col-lg-12 text-center pb-4">
						 <button class="btn btn-border" onclick="hide_div(6)">Back</button>
						 <button class="btn btn-primary" onclick="show_ques_div(6)">Continue</button>
					 </div>
		  		 </div>
	  		</div>
	 	</div>
	</div>
	
	<div id="step7" style="display:none;">
	<div>
 		<div class="col-lg-5 pt-4 text-center">
  		     <div class="row">
				 <div class="col-md-12 pl-5">
				  <div id="jqRadialGauge" style="width: 400px; height: 210px;">
				 </div>
				 </div>
			  </div>
  			 <div class="row">
 				<div class="col-md-12 mt-3">
    				<h4 class="textColor">YOUR RISK PROFILE IS <span id="risk_result"></span></h4>
 				</div>
 			</div>
  		</div>
   		<div class="col-lg-7 pt-5">
   			<p class="font-size-19 text-center pt-5"><br><br><br></p>
   			<p class="font-size-19 text-center pt-5" id="risk_result_para"></p>
	    	<div class="row">
 				<div class="col-lg-12 pl-5 py-2">
					<div class="hrline-100"></div>
				</div>
			</div>
			 <div class="p-4 text-center">
				<!--  <button class="btn btn-primary col-lg-border-custom col-lg-custom btn-md btnCol ml-2" onclick="contactUs()">Speak To Our<br>Human Professionals</button> -->
				 <button class="btn btn-primary col-lg-border-custom col-lg-custom btn-md btnCol" onclick="goToStep1()" style="margin-left:20px;">Next</button>
			 </div>
  		</div>
 	</div>
</div>
</div>

<div class="calc_div container-fluid robo3" style="padding: 0px 40px;">
<div class="row">
<div class="col-lg-2 col-xs-12 mt-5" style="border-right: 1px solid #eee;">
<div class="mt-5">
<div class="row header_btn">
<div class="col-lg-12 mb-4 col-xs-12 marginBottom10">
<button id="btn_head2" class="btn btn-primary btn-block btnCol active" onclick="show_div(2)">Asset Allocation</button>
</div>
<div class="col-lg-12 mb-4 col-xs-12 marginBottom10">
<button id="btn_head3" class="btn btn-primary btn-block btnCol" onclick="show_div(3)">Overview</button>
</div>
<div class="col-lg-12 mb-4 col-xs-12 marginBottom10">
<button id="btn_head4" class="btn btn-primary btn-block btnCol" onclick="show_div(4)">Projected Returns</button>
</div>
<div class="col-lg-12 mb-4 col-xs-12 marginBottom10">
<button id="btn_head5" class="btn btn-primary btn-block btnCol" onclick="show_div(5)">Historical Returns</button>
</div>
<div class="col-lg-12 mb-4 col-xs-12 marginBottom10">
<button id="btn_head6" class="btn btn-primary btn-block btnCol" onclick="show_div(6)">Portfolio</button>
</div>
</div>
</div>
</div>

<div class="col-lg-10 col-xs-12 marginBottom10">
<div class="row pt-4 plutusSipTopBox">
<div class="col-lg-4 border-blue LfCard  fundNamebg pt-3">
<p><span class="badge badge-pill badgebg badge-primary">1</span> Time Horizon(Years)</p>
<div class="row pt-5">
<div class="col-12 pr-2 text-center">
<input type="range" min="0" max="4" value="3" step="1" class="slider" id="txt_time_horizon_slider" name="txt_time_horizon_slider" onchange="checkSliderValues()">
<p class="marginTop10 text-center pt-3"> <span class="border px-5 py-2"><output class="time_horizon_slider_output"></output></span></p>
</div>
</div>
</div>
<div class="col-lg-4 border-blue border-left-0 fundNamebg  border-right-0 pt-3">
<p><span class="badge badge-pill badgebg badge-primary">2</span> Risk</p>
<div class="row pt-5">
<div class="col-12 pr-2 text-center">
<input type="range" min="0" max="4" value="3" step="1" class="slider" id="txt_risk_slider" name="txt_risk_slider" onchange="checkSliderValues()">
<p class="marginTop10 text-center pt-3"> <span class="border px-5 py-2"><output class="risk_slider_output"></output></span></p>
</div>
</div>
</div>
<div class="col-lg-4 border-blue fundNamebg RtCard pt-3">
<p><span class="badge badge-pill badgebg badge-primary">3</span> Investment Amount(Rs.)</p>
<div class="slidecontainer pt-5">
<input type="range" min="5000" max="100000000" value="100000" step="500" class="slider" id="txt_amount_slider" name="txt_amount_slider" onchange="checkSliderValues()">
<p class="marginTop10 text-center pt-3"> <span class="border"><input type="text" class="amount_slider_output number text-center" /></span></p>
</div>
</div>
</div>

<div class="container pb-4" id="DivF2" style="display:none">
<div class="row pt-2">
<div class="col-lg-6 border-blue RtCard fundNamebg pt-3">
<div>
<strong class="textColor">Equity</strong>
<p>Investing in Equity and Equity related instruments refers to the investment in publicly traded shares of companies listed on recognized stock exchanges (in India and overseas) and all such schemes that may have such shares as an underlying holding. It may also involve and not limited to investments in Equity Derivatives and or in unlisted shares of companies that may not be publicly traded. Such instruments may be more tax efficient that traditional investment options.</p>
 <strong class="textColor">Debt</strong>
<p>Investing in Debt markets and instruments involves investment in usually fixed interest securities that may be listed or unlisted. These securities may be in the form of Government Bonds, Corporate Bonds and other State Government Bonds/Municipal Bonds and or Bank Fixed Deposits (Public as well as Private). Tax free bonds are usually issued by central or state government/specialized agencies that do not attract any tax on interest earned.  Such instruments may also be more tax efficient that traditional investment options.</p>
</div>
</div>
<div class="col-lg-6 pt-5 highcharts_div">
<div id="asset_allocation_chart" style="height: 300px;"></div>
</div>
</div>
</div>


<div class="container  pb-4" id="DivF3" style="display:none">
<div class="row pt-2">
<div class="col-lg-6 border-blue RtCard fundNamebg  pt-3">
<div>
<strong class="textColor">Investment strategy</strong>
<p id="portfolio_para1"></p>
<strong class="textColor">Portfolio Construction</strong>
<p id="portfolio_para2"></p>
</div>
</div>
<div class="col-lg-6 pt-5">
<div id="dount_chart" style="height: 300px;"></div>
</div>
</div>
</div>


<div class="container  pb-4" id="DivF4" style="display:none">
<div class="row pt-2 sipRoboOffsetAlign">
<div class="col-lg-12 offset-lg-1 border-blue fundNamebg AllCornerBorder pt-3">
<p class="textColor text-center">Projected Returns of our Recommended Portfolio for you</p>
<div id="sip-gth-container" style="min-width: 310px; height: 400px; margin: 0 auto;"></div>
</div>
<div class="col-lg-12 offset-lg-1 py-2 mt-3 text-center cardProtbg">Projected growth of Rs. <span class="span_lumpsum_amount"></span> Lumpsum over <span class="span_year"></span> years.</div>
<div class="col-lg-12 offset-lg-1 py-2 mt-3 cardProtbg">
<p class="chart_para marginBottom0">Disclaimer :</p>
<p class="chart_para marginBottom0">Projections are based on historical returns, therefore, actual returns may vary subject to market risks and cannot be guaranteed.</p>
<p class="chart_para marginBottom0">All projections are annual, compounded annually. Your investment till <span class="span_future_year"></span> - Rs. <span class="span_future_invested_amount"></span>. Expected Corpus in <span class="span_future_year"></span> - Rs. <span class="span_future_final_amount"></span></p>
</div>
</div>
</div>

<div class="container pb-4" id="DivF5" style="display:none">
<div class="row pt-2 sipRoboAlignMargin">
<div class="col-lg-12 offset-lg-1 border-blue fundNamebg AllCornerBorder pt-3 pb-3">
<h4 class="textColor text-center">Historical Returns of our recommended portifolio for you</h4>
<div id="historical-container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</div>
<div class="col-md-12 offset-md-3 py-2 mt-3 text-center cardProtbg">Historical growth of Rs. <span class="span_lumpsum_amount"></span> Lumpsum in the last <span class="span_lumpsum_year">10</span> years.</div>
</div>
</div>


<div class="container  pb-4" id="DivF6" style="display:none">
<div class="row pt-2">
<div class="col-lg-12 border-blue fundNamebg AllCornerBorder pt-3">
<div class="row">
<div class="col-md-8 col-sm-8">
<h4 class="textColor">Recommended Portfolio (Lumpsum Amount - Rs.<span class="span_lumpsum_amount"></span>)</h4>
</div>
<div class="col-md-4 col-sm-4 text-right">
<span class="check_all_btn font-size-14">Select All Schemes</span>
</div>
</div>
<div class="text_center padding100" id="portfolio_spinner_div">
<i class="fa fa-spinner fa-pulse fa-2x" aria-hidden="true"></i>
</div>
<div class="table-responsive mf-research">
<table class="table" id="tbl_portfolio_returns">
</table>
</div>
<div class="text-right pb-3">
<c:choose>
<c:when test="${accountMap != null}">
	<button class="btn btn-border col-lg-custom" onclick="savePlan()">Save Plan</button>
</c:when>
<c:otherwise>
	<button class="btn btn-border col-lg-custom" onclick="showLogin()">Save Plan</button>
</c:otherwise>
</c:choose>
</div>
</div>
</div>
</div>
</div>
</div>
</div>