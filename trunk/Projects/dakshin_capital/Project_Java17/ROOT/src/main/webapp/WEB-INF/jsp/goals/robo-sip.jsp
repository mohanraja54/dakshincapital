<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
.robo2,.robo3,.portfolio_div,.overview_div,.historical_returns_div,.projected_returns_div{
	display:none;
}
.asset_allocation_div{
	display:none;
}
.slidecontainer {
    width: 100%;
}
.robo1 , .robo4, .robo5{
	margin: 0px auto;
	background-color:#fff;
	margin-bottom: 5%;
	margin-top: 2%;
	padding-top: 3%;
}

.slider:hover {
    opacity: 1;
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
.slide-button {
    font-size: 14px;
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
.fundNamebg h4{
	font-size:1.2rem !important;
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
.btnCol.active {
    background-color: #1b0e3d !important;
	border-color: #ffffff !important;
}
.btnCol {
	width: 100%;
}
.rangeslider__fill{
	background: #3fc5f0 !important;
}
.rangeslider__handle {
	border: 2px solid #3fc5f0 !important;
	background: #fff;
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
var inflation = 5;
var goal = "";
var slider_age = 0;
var slider_horizon = 0;
var choosen_year = 0;
var slider_risk = 0;
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
var btn_state = 6;
var portfolio_flag = false;
var historical_flag = false;
var projected_flag = false;
var rateofReturn = 0;
var sipAmount = 0;
var investor_pan = "";
var ques_flag = 1;

$(document).ready(function(){
	
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
		case 1:
			document.getElementById("DivF1").style.display = 'block';
			document.getElementById("DivF2").style.display = 'none';
			document.getElementById("DivF3").style.display = 'none';
			document.getElementById("DivF4").style.display = 'none';
			document.getElementById("DivF5").style.display = 'none';
			document.getElementById("DivF6").style.display = 'none';
			btn_state = 6;
			$(".header_btn button").removeClass("active");
		    $("#btn_head1").addClass("active");
			break;
		case 2:
			document.getElementById("DivF1").style.display = 'none';
			document.getElementById("DivF2").style.display = 'block';
			document.getElementById("DivF3").style.display = 'none';
			document.getElementById("DivF4").style.display = 'none';
			document.getElementById("DivF5").style.display = 'none';
			document.getElementById("DivF6").style.display = 'none';
			btn_state = 3;
			checkSliderValues();
			$(".header_btn button").removeClass("active");
		    $("#btn_head2").addClass("active");
			break;
		case 3:
			document.getElementById("DivF1").style.display = 'none';
			document.getElementById("DivF2").style.display = 'none';
			document.getElementById("DivF3").style.display = 'block';
			document.getElementById("DivF4").style.display = 'none';
			document.getElementById("DivF5").style.display = 'none';
			document.getElementById("DivF6").style.display = 'none';
			btn_state = 1;
			checkSliderValues();
			$(".header_btn button").removeClass("active");
		    $("#btn_head3").addClass("active");
			break;
		case 4:
			document.getElementById("DivF1").style.display = 'none';
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
			document.getElementById("DivF1").style.display = 'none';
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
			document.getElementById("DivF1").style.display = 'none';
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
	horizon = $('#txt_time_horizon_slider').val();
	amount = $('#txt_amount_slider').val();
	slider_risk = $("#txt_risk_slider").val();
	inflation = $('#txt_inflation_slider').val();
	
	amount = amount.replace(/,/g,'');
	
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
    
    slider_horizon = horizon;
	choosen_year= horizon;
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
	horizon = $("#txt_period").val();
	goal = $("#sel_goal").val();
    risk = $("#sel_risk").val();
    
    amount = amount.replace(/,/g,'');
    
    if(age == "" || isNaN(age))
 	{
 		swal({title:"",text:"Please enter your valid age"});
		return;
 	}
    if(parseInt(age) < 18)
 	{
 		swal({title:"",text:"Investments in mutual funds not allowed below 18 years age unless via a parent or guardian"});
		return;
 	}
    if(amount == "" || isNaN(amount) || parseInt(amount) < 1)
 	{
 		swal({title:"",text:"Please enter your valid amount"});
		return;
 	}
    if(parseInt(amount) < 100000)
 	{
 		swal({title:"",text:"Please enter the goal amount maximum Rs. 1,00,000"});
		return;
 	}
    if(horizon == "")
 	{
 		swal({title:"",text:"Please select your time horizon"});
		return;
 	}
    if(goal == "")
 	{
 		swal({title:"",text:"Please select your goal"});
		return;
 	}
    if(risk == "")
 	{
 		swal({title:"",text:"Please select your risk tolerance"});
		return;
 	}
    if(risk == "Check Risk Profile")
 	{
    	$(".robo1").hide();
		$(".robo2").show();
 		return;
 	}
    
    $(".span_goal").html(goal);
    
    
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
    
    slider_horizon = horizon;
	choosen_year= horizon;
    slider_age = age;
    slider_amount = amount;
    slider_risk = slider_risk;
    
	$(".robo1").hide();
	$(".robo3").show();
	$("#DivF1").show();
	
	$('html,body').animate({
        scrollTop: 100
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
    
    $("#txt_risk_slider").val(slider_risk);
    $('#txt_time_horizon_slider').val(slider_horizon);
    $('#txt_amount_slider').val(slider_amount);
    $('#txt_inflation_slider').val(inflation);
    
    
    var $document = $(document);
    
    //Time Horizon Slider Initiate
    var timeslider = $("input[type=range][name='txt_time_horizon_slider']");
    var timeoutput = document.querySelectorAll("output.time_horizon_slider_output")[0];
  	
    // set initial output value
    timeoutput.textContent = timeslider[0].value;
    
    // update output value
    $document.on('input', 'input[type="range"][name="txt_time_horizon_slider"]', function(e) {
  	  
  	  timeoutput.textContent = e.currentTarget.value;
      
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
    
    //Inflation Slider Initiate
    var inflationslider = $("input[type=range][name='txt_inflation_slider']");
    var inflationoutput = document.querySelectorAll("output.inflation_slider_output")[0];
  	
    // set initial output value
    inflationoutput.textContent = inflationslider[0].value;
    
    // update output value
    $document.on('input', 'input[type="range"][name="txt_inflation_slider"]', function(e) {
  	  
  	  inflationoutput.textContent = e.currentTarget.value;
      
    });  
    
    //Initialize
    inflationslider.rangeslider({
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
    /* var answer7 = $("input[type='radio'][name='q7']:checked").val();
	var answer8 = $("input[type='radio'][name='q8']:checked").val(); */
	
    
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
        $(".robo1").show();
        $(".robo2").hide();
        $("#sel_risk").val(risk);   
        swal({html:true,title:"",text:"As per our risk assessment, your risk tolerance is <br><b>"+risk+"</b>"}); 
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
function showBarChart(goal_amount, target_amount)
{
	$('#goal_summary_chart').highcharts({
		//colors: ['#FF8900', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
		//colors: ['#5b8c5a', '#a23a5f', '#6459ce', '#3fc5f0', '#6decb9', '#FFF263', '#6AF9C4', '#DDDF00', '#24CBE5', '#64E572'],
		 colors: ['#005e96', '#ee1c25', '#ffa200', '#e8ce1d', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4'],
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        credits: {
            enabled: false
        },
        xAxis: {
            categories: [
                ''
            ],
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Amount (Rs.)'
            }
        },
        tooltip: {
        	formatter: function() {
                var s = '';
                s += '<span style="color:'+ this.series.color +'">' + this.series.name + '</span> : Rs. ' + numbersWithComma(Math.round(this.y));
                return s;
            }
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: 'Goal Amount',
            data: [goal_amount]

        }, {
            name: 'Inflation Adjusted Goal Amount',
            data: [target_amount]

        }]
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
	
	//$('.span_lumpsum_amount').html(numbersWithComma(amount));
	//$('.span_year').html(choosen_year);
    
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
    	$('#portfolio_para2').html("This asset allocation is designed to hold 100% debt and other highly liquid investments");
    }
    if(new_horizon == 2 && new_risk == 3)
    {
    	$('#portfolio_para1').html("The portfolio will aim for capital appreciation along with moderate income flows");
    	$('#portfolio_para2').html("This asset allocation is designed to hold 100% debt and other highly liquid investments");
    }
    if(new_horizon == 2 && new_risk == 4)
    {
    	$('#portfolio_para1').html("The portfolio will aim for capital appreciation along with restricted income flows");
    	$('#portfolio_para2').html("This asset allocation is designed to hold 100% debt and other highly liquid investments");
    }
    if(new_horizon == 2 && new_risk == 5)
    {
    	$('#portfolio_para1').html("The portfolio will aim to predominately generate capital gains");
    	$('#portfolio_para2').html("This asset allocation is designed to hold 100% debt and other highly liquid investments");
    }
    
    if(new_horizon == 3 && new_risk == 1)
    {
    	$('#portfolio_para1').html("The portfolio will aim for long term capital appreciation with restricted income flows");
        $('#portfolio_para2').html("This asset allocation is designed to hold upto 55% debt instuments and upto 45% in equity instuments across different market and risk capitalisation");
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
        $('#portfolio_para2').html("This asset allocation is designed to hold about 15% debt instruments and upto 85% in equity related instruments. The debt holdings are for tactical use only");
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
	console.log("total----->"+total);
	
	rateofReturn = 8.0;
	if(risk == "Aggressive")
    {
		rateofReturn = 14.0;
    }else if(risk == "Moderately Aggressive")
    {
    	rateofReturn = 12.5;
    }else if(risk == "Moderate")
    {
    	rateofReturn = 11.5;
    }else if(risk == "Moderately Conservative")
    {
    	rateofReturn = 10.0;
    }else
    {
    	rateofReturn = 8.0;
    }
	
	//Goal Summary
	var years = parseInt(slider_horizon);
	var rate1 = rateofReturn / 100;
	var rate2 = Math.pow(1+rate1,1/12)-1;
	var inflation1 = inflation / 100;
	
	var target_amount = slider_amount * Math.pow(1+inflation1,years);
	target_amount = Math.round(target_amount);
	target_amount = Math.ceil(target_amount / 1000) * 1000;
	
	var famt = parseFloat(target_amount);
	var rate = parseFloat(rateofReturn);
	var period = years * 12;
	
	var required_monthly_target = (rate / (12 * 100) * (famt)) / (Math.pow((1 + rate / (12 * 100)), period) - 1);
	required_monthly_target = Math.round(required_monthly_target);
	
	var invest_amount = (years * 12) * required_monthly_target;
	var interest_total = target_amount - invest_amount;
	
	sipAmount = parseFloat(required_monthly_target);
	//alert("init sipAmount----->"+sipAmount);
	sipAmount = Math.ceil(sipAmount / 1000) * 1000;
	//alert("after sipAmount----->"+sipAmount);
	
	$('.span_sip_amount').html(numbersWithComma(sipAmount));
	$('.span_target_amount').html(numbersWithComma(target_amount));
	$('.span_year').html(years);
	
	showBarChart(parseInt(slider_amount), parseInt(target_amount));
	
	var current_amount = parseInt(sipAmount);
	console.log("current_amount--->"+current_amount);
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
		console.log("category count--->"+count);
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
	
	var goal_based_amount = parseFloat(sipAmount);
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
		arr.push('Hybrid: Conservative');
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
		//colors: ['#5b8c5a', '#a23a5f', '#6459ce', '#3fc5f0', '#6decb9', '#eef5b2', '#801336', '#c72c41', '#DDDF00', '#24CBE5'],
		colors: ['#005e96', '#ee1c25', '#ffa200', '#e8ce1d', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4'],
        chart: {
            type: 'pie'            
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

    var container_width = $(".chart_div").width();
    $('#asset_allocation_chart').highcharts({
    	//colors: ['#FF8900', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
    	//colors: ['#5b8c5a', '#a23a5f', '#6459ce', '#3fc5f0', '#6decb9', '#FFF263', '#6AF9C4', '#DDDF00', '#24CBE5', '#64E572'],
    	 colors: ['#005e96', '#ee1c25', '#ffa200', '#e8ce1d', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4'],
        chart: {
            type: 'pie',
            reflow: false            
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
        scrollTop: 400
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
	
	var loop_count = 0;
	var html = "";

	html += "<thead><tr>";
	html += "<th style='width: 35%;'>Scheme Name</th>";
	html += "<th  style='width: 15%;'>Category</th>";
	html += "<th style='width: 10%;' class='text-right'>1 Yr Ret (%)</th>";
	html += "<th style='width: 10%;' class='text-right'>3 Yr Ret (%)</th>";
	html += "<th style='width: 10%;' class='text-right'>5 Yr Ret (%)</th>";
	html += "<th style='width: 8%;' class='text-right'>Allocation Amount</th>";
	html += "<th style='width: 10%;' class='text-right'>Edit Amount</th>";
	html += "<th class='text-right'>Save Scheme</th>";
	html += "</tr></thead>";
	html += "<tbody>";
	
	var total_percentage = 0;
	var total_amount = 0;
	var last_category_flag = false;
	
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
		
		var goal_based_amount = parseFloat(sipAmount);
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
				var scheme_category = schemePerformances_array[i].scheme_category;
				var oneYrRt = schemePerformances_array[i].returns_abs_1year;
				var threeYrRt = schemePerformances_array[i].returns_cmp_3year;
				var fiveYrRt = schemePerformances_array[i].returns_cmp_5year;
				loop_count++;
				
				if(i == (count - 1))
				{
					scheme_flag = true;
				}
		    	
		    	html += "<tr>";
		    	html += '<td><span id="span_scheme_'+loop_count+'">' + scheme_name + '</span> | <a style="font-size: 10px;color:blue;"  href="javascript:;" onclick="schemeChange('+loop_count+', \''+category+'\')">Change Scheme</a></td>';
		    	//if(i == 0)
		    	{
		    		html += "<td id='txt_category_"+loop_count+"'>" + category + "</td>";
		    		html += "<td class='text-right' id='1yrt_" + loop_count + "'>" + oneYrRt + "</td>";
					html += "<td class='text-right' id='3yrt_" + loop_count + "'>" + threeYrRt + "</td>";
					html += "<td class='text-right' id='5yrt_" + loop_count + "'>" + fiveYrRt + "</td>";
					
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
		    			
			        	html += "<td><input type='text' class='fc-2 text-right textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
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
		    			
			        	html += "<td><input type='text' class='fc-2 text-right textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
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
		    			
			        	html += "<td><input type='text' class='fc-2 text-right textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
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
		    			
			        	html += "<td><input type='text' class='fc-2 text-right textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
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
		    			
			        	html += "<td><input type='text' class='fc-2 text-right textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
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
		    			
			        	html += "<td><input type='text' class='fc-2 text-right textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
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
		    			
			        	html += "<td><input type='text' class='fc-2 text-right textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
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
		    			
			        	html += "<td><input type='text' class='fc-2 text-right textInputRadius allocaton_amount number1 text-right' id='txt_allocation_amount_"+loop_count+"' value='" + numbersWithComma(value1.toFixed(2)) + "' disabled='disabled' onchange='changeAmount("+loop_count+")'></td>";
			        	
			        }
		    	}
		    	html += '<td class="text-right"><input type="button" style="width: 100%; font-size: 14px; height: 30px; line-height: 15px;"  class="btn btn-primary" id="btn_'+loop_count+'" value="Edit" onclick="editScheme('+loop_count+')" /></td>';
		    	html += '<td class="text-right"><input  style="margin:0px;" type="checkbox" name="save_goal" value="'+loop_count+'"></td>';
		    	
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
	html += "<td><input type='text' class='fc-2 textInputRadius text-right' id='allocation_amount_total' value='"+numbersWithComma(parseFloat(goal_based_amount).toFixed(2))+"' disabled='disabled'></td>";
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
	var goal_based_amount = parseFloat(sipAmount);
	
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
function schemeChange(id, category)
{
	var html = '<table class="table table-responsive" style="font-size:11px;">';
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
function completeStep5()
{
	$('#sip-gth-container').html('');
	$('#sip-gth-container_div1').hide();
	$('#sip-gth-container_div2').hide();
	$('#projected_spinner_div').show();
	
	var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
	var d = new Date();
	var current_year = d.getFullYear();
    var current_month = months[d.getMonth()];
	var years = parseInt(slider_horizon);
	var mon = 12;
	var yearArr = new Array();
	var principalArr = new Array();
	var interestArr = new Array();
	var balanceArr = new Array();
	var final_year = 0;
	var final_growth_amount = 0;
	var final_invested_amount = 0;

	for(var k=1;k<=years;k++)
	{
		var value1 = (rateofReturn / 100) / 12;
	    var value3 = 1 + value1;
		var value4 = Math.pow((value3), (mon + 1));
	    var amount1 = (value4 - 1);
	    var amount2 = amount1 / value1;
	    var final_amount = (sipAmount * amount2) - sipAmount;
	    final_amount = Math.round(final_amount);
	    var invest_amount = sipAmount * mon;
	    var interest_total = final_amount - invest_amount;
	    yearArr.push("Year"+k);
		principalArr.push(invest_amount);
		interestArr.push(interest_total);
		balanceArr.push(final_amount);
		current_year = current_year + 1;

		final_year = current_year;
		final_growth_amount = final_amount;
		final_invested_amount = invest_amount;
		
		mon = mon + 12;
	}
	
	$('.span_future_year').html(current_month + ' ' + final_year);
	$('.span_future_invested_amount').html(numbersWithComma(final_invested_amount));
	$('.span_future_final_amount').html(numbersWithComma(final_growth_amount));
	
	$('#projected_spinner_div').hide();
	
	Highcharts.setOptions({
		lang: {
			thousandsSep: ','
		}
	});
	
	$('#containerProjectReturn').highcharts({
		//colors: ['#24CBE5', '#FF8900', '#DDDF00', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
		//colors: ['#5b8c5a', '#a23a5f', '#6459ce', '#3fc5f0', '#801336', '#6decb9', '#6AF9C4', '#DDDF00', '#24CBE5', '#64E572'],
		colors: ['#005e96', '#ee1c25', '#ffa200', '#e8ce1d', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4'],
	    chart: {
	        type: 'column'
	    },

	    title: {
	        text: ''
	    },

	    xAxis: {
	        categories: yearArr
	    },

	    yAxis: {
	        allowDecimals: false,
	        min: 0,
	        title: {
	            text: 'Total SIP Value '
	        }
	    },

	    tooltip: {
	    	shared:true
	    },
	    credits: {
            enabled: false
        },
	    plotOptions: {
	        column: {
	            stacking: 'normal'
	        }
	    },

	    series: [{
	        name: 'Total SIP Value',
	        data: balanceArr,
	        stack: 'male'
	    },{
	        name: 'Growth Amount',
	        data: interestArr,
	        stack: 'female'
	    }, {
	        name: 'Invested Amount',
	        data: principalArr,
	        stack: 'female'
	    }]
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
	
	var fd_year = parseInt(choosen_year);
	if(fd_year > 10)
	{
		fd_year = 10;
	}
	$(".span_sip_year").html(fd_year);
	var d = new Date();
	var current_year = d.getFullYear();
	current_year = current_year - fd_year;
	var mon = 12;
	var yearArr = new Array();
	var principalArr = new Array();
	var interestArr = new Array();
	var balanceArr = new Array();

	for(var k=1;k<=fd_year;k++)
	{
		var value1 = (historical_return / 100) / 12;
	    var value3 = 1 + value1;
		var value4 = Math.pow((value3), (mon + 1));
	    var amount1 = (value4 - 1);
	    var amount2 = amount1 / value1;
	    var final_amount = (sipAmount * amount2) - sipAmount;
	    final_amount = Math.round(final_amount);
	    var invest_amount = sipAmount * mon;
	    var interest_total = final_amount - invest_amount;
	    yearArr.push(current_year);
		principalArr.push(invest_amount);
		interestArr.push(interest_total);
		balanceArr.push(final_amount);
		current_year = current_year + 1;
		mon = mon + 12;
	}
	
	var data_array = new Array();
	//var colors = ['#FF8900', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'];
	//var colors = ['#5b8c5a', '#a23a5f', '#6459ce', '#3fc5f0', '#6decb9', '#FFF263', '#6AF9C4', '#DDDF00', '#24CBE5', '#64E572'];
	var colors = ['#005e96', '#ee1c25', '#ffa200', '#e8ce1d', '#24CBE5', '#64E572','#FF9655', '#FFF263', '#6AF9C4'];
	var obj = {
			name: "Growth",
	        data: balanceArr,
	        color : colors[1]
		};
	data_array.push(obj);
	
	var obj = {
		name: "Invested Amount",
        data: principalArr,
        color : colors[0]
	};
	data_array.push(obj);
	
	$('#historical_spinner_div').hide();
	
	$('#containerHistrocial').highcharts({
	    chart: {
	        type: 'area'
	    },
	    title: {
	       text: ''
	    },
	    //subtitle: {
	       // text: 'Source: Wikipedia.org'
	    //},
	    xAxis: {
	        categories: yearArr,
	        tickmarkPlacement: 'on',
	       title: {
	           enabled: false
	       }
	    },
	    yAxis: {
	        title: {
	            text: 'Total SIP Value'
	        },
	        labels: {
	            formatter: function () {
	                return this.value / 1000;
	            }
	        }
	    },
	    tooltip: {
	    	shared:true
	    },
	    credits: {
            enabled: false
        },
	    plotOptions: {
	        area: {
	            stacking: 'normal',
	            lineColor: '#666666',
	            lineWidth: 1,
	            marker: {
	                lineWidth: 1,
	                lineColor: '#666666'
	            }
	        }
	    },
	    series: data_array
	});
	
	$('#historical-container_div1').show();
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
		inflation : "" + inflation + "",goal : "" + goal + "",sip_amount : "" + sipAmount + "",type : "SIP Robo Advisor",scheme_array : "" + scheme_array_str + "",category_array : "" + category_array_str + "",percentage_array : "" + percentage_array_str + "",
		amount_array : "" + amount_array_str + ""}, function(data)
    {
		var result = $.trim(data);
  		var obj = jQuery.parseJSON(result);
   		if(obj.status == 400)
   		{
   			$("#adv-alert-msg").html(""+obj.msg);
          	$("#adv-alert").modal('show');
   			return false;
   		}
   		
   		top.location = "https://mfportfolio.dakshincapital.com?authcode="+$.trim(obj.msg);
		return;
		
    },'text');
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
		inflation : "" + inflation + "",goal : "" + goal + "",sip_amount : "" + sipAmount + "",type : "SIP Robo Advisor",scheme_array : "" + scheme_array_str + "",category_array : "" + category_array_str + "",percentage_array : "" + percentage_array_str + "",
		amount_array : "" + amount_array_str + ""}, function(data)
    {
		var result = $.trim(data);
  		var obj = jQuery.parseJSON(result);
   		if(obj.status == 400)
   		{
   			$("#adv-alert-msg").html(""+obj.msg);
          	$("#adv-alert").modal('show');
   			return false;
   		}
   		
   		swal({
	        title: "",
	        text: "Your SIP Robo plan successfully saved.",
	        type: "success"
	    }, function () {
	    	
	    	top.location = "https://mfportfolio.dakshincapital.com/bse/bse-robo-based-online-investment?pan="+investor_pan+"&id="+obj.msg;
	    });
		return;
		
    },'text');
}
function showButtonText()
{
	goal = $("#sel_goal").val();
    if(goal == "")
 	{
 		swal({title:"",text:"Please select your goal"});
		return;
 	}
    $("#submit_btn").text("Build My "+goal+" Plan");
}
</script>


<div class="container-fluid">

<div class="row">
<div class="robo1 ques_1">  

<div class="row"> 
<div class="col-md-12 col-sm-12">
<div class="title-v1">
	<h1 class="goal_name text-center">SIP Robo Advisor</h1>
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
	<div><b>Required amount is</b></div>
	<input type="text" value="1000000" id="txt_amount" class="fc-2" onchange="amountChange()" maxlength="9" />
	<div id="amount_slider" style="margin:0px;"></div>
</div>

<div class="col lamount" style="float:none;">
	<div><b>For Goal</b></div>
	<select id="sel_goal"  class="fc-2" onchange="riskProfileChange()" style="text-align:center;margin-top: 10px;">
		<option value="">Select</option>
		<option value="Wealth Creation">Wealth Creation</option>
		<option value="Retirement">Retirement</option>
		<option value="Children's Education">Children's Education</option>
		<option value="Children's Marriage">Children's Marriage</option>
		<option value="Buying a House">Buying a House</option>
		<option value="Starting a Business">Starting a Business</option>
		<option value="Supporting My Parents">Supporting My Parents</option>
		<option value="Other Goal">Other Goal</option>
	</select>
</div>

</div>
</div>
</div>

<div class="row pt-4">
<div class="col-md-12 form-inline">
<div class="row" style="margin:0px auto;">
<div class="col lamount" style="float:none;">
	<div><b>After years</b></div>
	<input type="text" value="5" id="txt_period" class="fc-2" onchange="yearChange()" maxlength="9" />
	<div id="year_slider" style="margin:0px;"></div>
</div>

<div class="col lamount" style="float:none;">
	<div><b>Your Risk Profile</b></div>
	<select id="sel_risk"  class="fc-2" onchange="riskProfileChange()" style="text-align:center;margin-top: 10px;">
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

<div class="calc_div container-fluid robo3 mt-3" style="padding:0px 40px">
<div class="row">
<div class="col-lg-2 col-xs-12 mt-5" style="border-right: 1px solid #eee;">
<div class="mt-5">	
<div class="row header_btn">
<div class="col-lg-12 col-xs-12 mb-4">
<button id="btn_head1" class="btn btn-primary btn-block btnCol active" onclick="show_div(1)">Goal Summary</button>
</div>
<div class="col-lg-12 col-xs-12 mb-4">
<button id="btn_head2" class="btn btn-primary btn-block btnCol" onclick="show_div(2)">Asset Allocation</button>
</div>
<div class="col-lg-12 col-xs-12 mb-4">
<button id="btn_head3" class="btn btn-primary btn-block btnCol" onclick="show_div(3)">Overview</button>
</div>
<div class="col-lg-12 col-xs-12 mb-4">
<button id="btn_head4" class="btn btn-primary btn-block btnCol" onclick="show_div(4)">Projected Returns</button>
</div>
<div class="col-lg-12 col-xs-12 mb-4">
<button id="btn_head5" class="btn btn-primary btn-block btnCol" onclick="show_div(5)">Historical Returns</button>
</div>
<div class="col-lg-12 col-xs-12 mb-4">
<button id="btn_head6" class="btn btn-primary btn-block btnCol" onclick="show_div(6)">Portfolio</button>
</div>
</div>
</div>
</div>
<div class="col-lg-10 col-xs-12 marginBottom10">
<div class="row pt-4 plutusSipTopBox">
<div class="col-lg-3 border-blue LfCard  fundNamebg pt-3">
<p><span class="badge badge-pill badgebg badge-primary">1</span> Time Horizon(Years)</p>
<div class="row pt-5">
<div class="col-12 pr-2 text-center">
<input type="range" min="1" max="100" value="10" step="1" class="slider" id="txt_time_horizon_slider" name="txt_time_horizon_slider" onchange="checkSliderValues()">
<p class="marginTop10 text-center pt-3"> <span class="border px-5 py-2"><output class="time_horizon_slider_output"></output></span></p>
</div>
</div>
</div>
<div class="col-lg-3 border-blue border-left-0 fundNamebg  border-right-0 pt-3">
<p><span class="badge badge-pill badgebg badge-primary">2</span> Risk</p>
<div class="row pt-5">
<div class="col-12 pr-2 text-center">
<input type="range" min="0" max="4" value="3" step="1" class="slider" id="txt_risk_slider" name="txt_risk_slider" onchange="checkSliderValues()">
<p class="marginTop10 text-center pt-3"> <span class="border px-5 py-2"><output class="risk_slider_output"></output></span></p>
</div>
</div>
</div>
<div class="col-lg-3 border-blue border-right-0 fundNamebg pt-3">
<p><span class="badge badge-pill badgebg badge-primary">3</span> 
<span class="span_goal"></span> Amount(Rs.)</p>
<div class="slidecontainer pt-5">
<input type="range" min="100000" max="1000000000" value="1000000" step="1000" class="slider" id="txt_amount_slider" name="txt_amount_slider" onchange="checkSliderValues()">
<p class="marginTop10 text-center pt-3"> <span class="border"><input type="text" class="amount_slider_output number text-center" /></span></p>
</div>
</div>
<div class="col-lg-3 border-blue fundNamebg RtCard pt-3">
<p><span class="badge badge-pill badgebg badge-primary">4</span> Inflation(%)</p>
<div class="row pt-5">
<div class="col-12 pr-2 text-center">
<input type="range" min="0" max="10" value="8" step="1" class="slider" id="txt_inflation_slider" name="txt_inflation_slider" onchange="checkSliderValues()">
<p class="marginTop10 text-center pt-3"> <span class="border px-5 py-2"><output class="inflation_slider_output"></output></span></p>
</div>
</div>
</div>
</div>

<div class="container pb-4" id="DivF1" style="display:none;clear:both;">
<div class="row pt-2">
<div class="col-lg-6 border-blue RtCard fundNamebg pt-3">
<div>
<strong class="textColor">Inflation</strong>
<p>Inflation is the rate at which the general level of prices for goods and services is rising and consequently, the purchasing power of currency is falling. The effects of Inflation are huge. And, it does not just affect areas like our salaries and the cost of purchasing a home etc. It hits us from every angle - Food prices go up, transportation prices increase and the cost of various services and goods skyrocket over time. All these factors make it absolutely necessary that you account for the impact of inflation on your long term savings and financial goals.</p>
<p><strong class="textColor">Average Inflation in India for last 3 years is as follows-</strong></p>
<p>2018 - 4.53%</p>
<p>2017 - 2.49%</p>
<p>2016 - 4.97%</p>
<p>(Source: www.inflation.eu)</p>
</div>
</div>
<div class="col-lg-6 pt-5 chartFontStyle" id="highcharts_div">
<div id="goal_summary_chart" style="height: 300px;"></div>
<p>You need to save Rs. <span class="span_sip_amount"></span> per month to achieve your inflation adjusted goal of Rs. <span class="span_target_amount"></span>.</p>
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
<div class="col-lg-6 pt-5">
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
<div id="containerProjectReturn" style="min-width: 310px; height: 400px; margin: 0 auto;"></div>
</div>
<div class="col-lg-12 offset-lg-1 py-2 mt-3 text-center cardProtbg">Projected growth of Rs. <span class="span_sip_amount"></span> Monthly SIP over <span class="span_year">10</span> years.</div>
<div class="col-lg-12 offset-lg-1 py-2 mt-3 cardProtbg">
<p class="chart_para marginBottom0">Disclaimer :</p>
<p class="chart_para marginBottom0">Projections are based on historical returns, therefore, actual returns may vary subject to market risks and cannot be guaranteed.</p>
<p class="chart_para marginBottom0">All projections are annual, compounded annually.</p>
<p class="chart_para marginBottom0">Your investment till <span class="span_future_year"></span> - Rs. <span class="span_future_invested_amount"></span>. Expected Corpus in <span class="span_future_year"></span> - Rs. <span class="span_future_final_amount"></span></p>
</div>
</div>
</div>

<div class="container pb-4" id="DivF5" style="display:none">
<div class="row pt-2 sipRoboAlignMargin">
<div class="col-lg-12 offset-lg-1 border-blue fundNamebg AllCornerBorder pt-3 pb-3">
<h4 class="textColor text-center">Historical Returns of our recommended portifolio for you</h4>
<div id="containerHistrocial" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</div>
<div class="col-md-12 offset-md-3 py-2 mt-3 text-center cardProtbg">Historical growth of Rs. <span class="span_sip_amount"></span> Monthly SIP in the last <span class="span_sip_year">10</span> years.</div>
</div>
</div>


<div class="container  pb-4" id="DivF6" style="display:none">
<div class="row pt-2">
<div class="col-lg-12 border-blue fundNamebg AllCornerBorder pt-3">
<div class="row">
<div class="col-md-8 col-sm-8">
<h4 class="textColor">Recommended Portfolio (SIP Amount - Rs. <span class="span_sip_amount"></span>)</h4>
</div>
<div class="col-md-4 col-sm-4 text-right">
<span class="check_all_btn font-size-14">Select All Schemes</span>
</div>
</div>
<div class="text_center padding100" id="portfolio_spinner_div">
<i class="fa fa-spinner fa-pulse fa-2x" aria-hidden="true"></i>
</div>
<div class="table-responsive  mf-research">
<table class="table" id="tbl_portfolio_returns">
</table>
</div>
<div class="text-right pb-3">
<c:choose>
<c:when test="${accountMap != null}">
	<button class="btn btn-border col-lg-custom"  onclick="savePlan()">Save Plan</button>
</c:when>
<c:otherwise>
	<button class="btn btn-border col-lg-custom"  onclick="showLogin()">Save Plan</button>
</c:otherwise>
</c:choose>
</div>
</div>
</div>
</div>
</div>
</div>
</div>