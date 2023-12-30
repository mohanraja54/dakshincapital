<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- content Start -->

<style>
.goals {
	color: #233e62;
}
.services-2:hover .media-body .goals p {
	color: #fff;
}

.home-slider .btn-border {
	background: #ffa200 !important;
	border: 1px solid #ffa200 !important;
	color: #333;	
}
.home-slider .btn:hover {
	background: #1b0e3d !important;
	border: 1px solid #1b0e3d !important;
	color: #fff;	
}
.horizonBtn {
    box-shadow: 4px 4px 10px 1px #d3d3d3 !important;
}
.padding-0 {
    padding: 0px;
}
.activePeriod {
    border: 2px solid #005e96;
}
.btn{
	padding: 0.375rem 0.65rem;
}
#txt_email_subscription::placeholder {
  color: rgba(255, 255, 255, 0.7) !important;
}

.owl-prev {
   width:30px;
   left:0 !important;
   top: -300px !important;
   margin-left: 20px !important;
}

.owl-next {
   width:30px;
   right:0 !important;
   top: -300px !important;
   margin-right: 20px !important;
}
</style>


<script>
	var periodTop = "1y";
  	var data = [];
	var rangeSlider = function(){
	  var slider = $('.range-slider'),
	      range1 = $('.rs1'),
	      range2 = $('.rs2'),
	      range3 = $('.rs3'),
	      value = $('.range-slider__value');
	    
	  slider.each(function(){
	    value.each(function(){
	      var value = $(this).prev().attr('value');
	      $(this).html(value);
	      data.push(value);
	    });
	
	    range1.on('input .rs1', function(){
	      $(this).next(value).html(this.value);
	      data[0] = this.value;
	      calculateSIP(data);
	      return;
	    });
	    
	    range2.on('input .rs2', function(){
	      $(this).next(value).html(this.value);
	      data[1] = this.value;
	      calculateSIP(data);
	      return;
		});
	    
	    range3.on('input .rs3', function(){
	      $(this).next(value).html(this.value);
	      data[2] = this.value;
	      calculateSIP(data);
	      return;
		});
	    
	    calculateSIP(data)
	  });
	  
	  
	};
	
	$(document).ready(function(){
		rangeSlider();
	        
		$(".goal_plan").click(function() {
		    $('html, body').animate({
		        scrollTop: ($(".goal-section").offset().top) + 20
		    }, 2000);
		});
		
		$(".mf-research34").click(function(){
			top.location="/mutual-funds-research/top-performing-mutual-funds";
		});
		
		$(".tools-calc34").click(function(){
			top.location="/tools-and-calculators/become-a-crorepati";
		}); 
		
		onParameterChange();
		getTopFunds();
		$('.horizonBtn').removeClass('activePeriod');
		$('.'+periodTop).addClass('activePeriod');
	});
	
	function validateEmail(email)
	{    
		var re = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
	    if(re.test(email))
	    {
	       return true;
		}
	    else
	    {
	       return false;
	    }
	}
	function subscribeEmail()
	{
		var email = $.trim($("#txt_email_subscription").val());
	    if(email == "")
	    {
	    	swal({title:"",text:"Please enter your email"});
	 		return false;
	    }
	    if(!validateEmail(email))
	    {
	    	swal({title:"",text:"Please enter valid email"});
	 		return false;
	    }
	    var ele = document.getElementById("subscribe_home_btn");
	 	var l = Ladda.create(ele);
	 	l.start();
	 	
	    $.post("/subscribeForEmail", {email : "" + email + "", page : "Website - home"}, function(data)
	    {
	    	l.stop();
	    	
	    	var result = $.trim(data);
	        var obj = jQuery.parseJSON(result);
	        
	        if(obj.status == 400)
	        {
	        	//swal("Thanks!", "Entered email id is already subscribed!", "success");
	        	swal("Thanks!", obj.msg, "success");
	            $("#txt_email_subscription").val("");
	            return false;
	        }
	        
	        swal("Thanks!", "We will be in touch with you!", "success");
	        $("#txt_email_subscription").val("");
	        return false;		
	    }, "text");
	}
	
	function onParameterChange()
	{
		var category = $("#sel_schemeCategories").val();
		var period = $("#sel_period").val();
		var type = "Open";
		getFundPerformanceReturns(category,period,type);
	}
	
	function getFundPerformanceReturns(category,period,type)
	{
		$('#tbl_schemeReturns').html("<div class='text-center'><img src='/images/loading.gif' alt='loading'></div>");
		$.ajaxSetup({async:true});
		$.post("/mutual-funds-research/getSchemePerformanceReturns", {category : category, period : period, type : type, maxno : 5}, function(data)
	    {
			var schemePerformances = $.trim(data);
			var schemePerformances_obj = jQuery.parseJSON(schemePerformances);
			var schemePerformances_array = $.makeArray(schemePerformances_obj);
	        var html = "";
	        
	    	html += "<tbody>";
	    	var len = 4;
	    	if(schemePerformances_array.length < 4) {
				len = schemePerformances_array.length
	        }
			for (var i = 0; i < len ; i++)
		    {
				var scheme_name = schemePerformances_array[i].scheme_amfi;
				var ytd_returns = schemePerformances_array[i].returns_abs_ytd;
				var one_week_returns = schemePerformances_array[i].returns_abs_7days;	 
		    	var one_month_returns = schemePerformances_array[i].returns_abs_1month;	    	
		    	var three_month_returns = schemePerformances_array[i].returns_abs_3month;  	
		    	var six_month_returns = schemePerformances_array[i].returns_abs_6month;	    	
		    	var one_year_returns = schemePerformances_array[i].returns_abs_1year;
		    	var two_year_returns = schemePerformances_array[i].returns_cmp_2year;
		    	var three_year_returns = schemePerformances_array[i].returns_cmp_3year;
		    	var five_year_returns = schemePerformances_array[i].returns_cmp_5year;
		    	var ten_year_returns = schemePerformances_array[i].returns_cmp_10year;
		    	var inception_returns = schemePerformances_array[i].returns_cmp_inception;
		    	var inception_date = new Date(schemePerformances_array[i].inception_date);
		    	var ter = schemePerformances_array[i].ter;
		    	var url = schemePerformances_array[i].url;

				one_week_returns = one_week_returns.toFixed(2);
		    	one_month_returns = one_month_returns.toFixed(2);
		    	three_month_returns = three_month_returns.toFixed(2);
		    	six_month_returns = six_month_returns.toFixed(2);
		    	ytd_returns = ytd_returns.toFixed(2);
		    	one_year_returns = one_year_returns.toFixed(2);
		    	two_year_returns = two_year_returns.toFixed(2);
		    	three_year_returns = three_year_returns.toFixed(2);
		    	five_year_returns = five_year_returns.toFixed(2);
		    	ten_year_returns = ten_year_returns.toFixed(2);
		    	inception_returns = inception_returns.toFixed(2);
	            
				if(one_week_returns == 0)
	    		{
		    		one_week_returns = "-";
	    		}
		    	if(one_month_returns == 0)
	    		{
		    		one_month_returns = "-";
	    		}
		    	if(three_month_returns == 0)
	    		{
		    		three_month_returns = "-";
	    		}
		    	if(six_month_returns == 0)
	    		{
		    		six_month_returns = "-";
	    		}
		    	if(ytd_returns == 0)
	    		{
		    		ytd_returns = "-";
	    		}
		    	if(one_year_returns == 0)
	    		{
		    		one_year_returns = "-";
	    		}
		    	if(two_year_returns == 0)
	    		{
		    		two_year_returns = "-";
	    		}
		    	if(three_year_returns == 0)
	    		{
		    		three_year_returns = "-";
	    		}
		    	if(five_year_returns == 0)
	    		{
		    		five_year_returns = "-";
	    		}
		    	if(ten_year_returns == 0)
	    		{
		    		ten_year_returns = "-";
	    		}
		    	if(inception_returns == 0)
	    		{
		    		inception_returns = "-";
	    		}
		    	
		    	var displaySchemeName = scheme_name;
		    	if(scheme_name.length > 100) {
		    		displaySchemeName = scheme_name.substr(0,99) + "...";
		    	}
		    	html += "<tr>";
		    	html += "<td colspan='3' style='line-height: 12px;padding-top: 10px;' class='fund_hover'><a href='/mutual-funds-research/" + scheme_name + "'>" + scheme_name + "</a>";
		    	html += "</td></tr><tr style='border-bottom: 1px solid #ddd'>";
		    	var day = inception_date.getDate();
		    	var month = inception_date.getMonth() + 1;
		    	var year = inception_date.getFullYear();
		    	/*html += "<td>" +  day + "-"+ month + "-" + year + "</td>";*/
		    	/*html += "<td>" + ter.toFixed(2) + "</td>";*/
		    	if(period == "1y")
		    	{
		    		html += "<td style='line-height: 20px;'><span class='ret'>" + three_month_returns + " %</span><br><span class='ret_label'>3M Return</span></td>";
			    	html += "<td style='line-height: 20px;'><span class='ret'>" + six_month_returns + " %</span><br><span class='ret_label'>6M Return </span></td>";
			    	html += "<td style='line-height: 20px;'><span class='ret'>" + one_year_returns + " %</span><br><span class='ret_label'>1Y Return</span></td>";
		    	}
		    	if(period == "2y")
		    	{
		    		html += "<td style='line-height: 20px;'><span class='ret'>" + six_month_returns + " %</span><br><span class='ret_label'> 6M Return</span></td>";
			    	html += "<td style='line-height: 20px;'><span class='ret'>" + one_year_returns + " %</span><br><span class='ret_label'> 1Y Return</span></td>";
			    	html += "<td style='line-height: 20px;'><span class='ret'>" + two_year_returns + " %</span><br><span class='ret_label'> 2Y Return</span></td>";
		    	}
		    	if(period == "3y" || period == "5y")
		    	{
		    		html += "<td style='line-height: 20px;'><span class='ret'>" + one_year_returns + " %</span><br><span class='ret_label'> 1Y Return</span></td>";
			    	html += "<td style='line-height: 20px;'><span class='ret'>" + three_year_returns + " %</span><br><span class='ret_label'> 3Y Return</span></td>";
			    	html += "<td style='line-height: 20px;'><span class='ret'>" + five_year_returns + " %</span><br><span class='ret_label'> 5Y Return</span></td>";
		    	}
		    	if(period == "10y")
		    	{
		    		html += "<td style='line-height: 20px;'><span class='ret'>" + three_year_returns + " %</span><br><span class='ret_label'> 3Y Return</span></td>";
			    	html += "<td style='line-height: 20px;'><span class='ret'>" + five_year_returns + " %</span><br><span class='ret_label'> 5Y Return</span></td>";
			    	html += "<td style='line-height: 20px;'><span class='ret'>" + ten_year_returns + " %</span><br><span class='ret_label'> 10Y Return</span></td>";
		    	}
		    	html += "</tr>";
		    }
			html += "</tbody>"; 
			/*$('#tbl_schemeReturns').DataTable().destroy();*/
			$('#tbl_schemeReturns').empty();
	    	$('#tbl_schemeReturns').html(html);
	    	/*$('#tbl_schemeReturns').dataTable({
	            "bPaginate": false,
	            "bFilter": false,
	            "bInfo": false,
	            "bSort": false,
	            "columns": [
	                        { "width": "45%" },
	                        { "width": "13%" },
	                        { "width": "8%" },
	                        { "width": "9%" },
	                        { "width": "9%" },
	                        { "width": "8%" }
	                      ]
	        });*/
	    	$("#tbl_schemeReturns_wrapper").css("margin-top","-10px");
	    	
	    	//onSipParameterChange();
	    	
	    },'text');
	}
	
	
	function calculateSIP(data)
	{

		var sipAmount = data[0];
		var rateofReturn = data[2];
		var sipMonth = data[1];

		
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
		
	    $('#res_amount_invest').html(numbersWithComma(data[0]));
	    $('#res_total_interest').html(numbersWithComma(growth_value));
		$('#res_total_amount').html(numbersWithComma(maturity_amount));
		renderChart(invested_amount, growth_value);
		
		//var d = new Date();
		//var current_year = d.getFullYear(); 
		//var current_month = d.getMonth();
		//barChartValuesPrepare(current_year,current_month,sipAmount);
	}
	
	function renderChart(amount,total_interest)
	{
		amount = parseFloat(amount);
		total_interest = parseFloat(total_interest);
		
		$('#emipiechart1').highcharts({
			 colors: ['#005e96', '#ee1c25', '#FF8900', '#DDDF00', '#24CBE5', '#64E572', 
	       '#FF9655', '#FFF263', '#6AF9C4'],
	      chart: {
	    	  type: 'pie',
	    	  backgroundColor:'rgba(255, 255, 255, 0.0)'
	      },
	      title: {
	    	 /*  text: 'Browser<br>shares<br>2017',
	          align: 'center',
	          verticalAlign: 'middle',
	          y: 0 */
	          text: ""
	      },
	      credits: {
	            enabled: false
	      },
	      subtitle: {
	            text: ''
	      },
	      tooltip: {
	  	    pointFormat: 'Rs.{point.y}'
	      },

	      /* legend: {
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
	        }, */
	      plotOptions: {
	    	  pie: {
	    		  innerSize: 100,
	              depth: 45,
	              allowPointSelect: true,
	              cursor: 'pointer',
	              dataLabels: {
	                  enabled: true,
	                  format: '<b>{point.name}</b>:<br/> Rs.{point.y}',
	                  connectorColor: 'silver'
	              }
	          }
	        },
	      
	      series: [{
	    	  showInLegend: false,  
	          data: [
	              ['Total SIP Amount', amount],
	              {
	                  name: 'Total Growth',
	                  y: total_interest,
	                  sliced: true,
	                  selected: true
	              }
	          ],
	          
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
	
	function contactus()
	{
		var name = $("#fname").val();
		var email = $("#email").val();
		var subject = $("#subject").val();
		var message = $("#message").val();
		
		if(name == "")
	    { 	  
		    swal("OOPS!", "Please enter your name!", "error")
	  	    return false;	   
	    }	   
	    if(email == "")
	    {
	    	swal("OOPS!", "Please enter your email!", "error")
	  	    return false;	   
	   }
	    if(subject == "")
	    { 	  
		    swal("OOPS!", "Please enter subject!", "error")
	  	    return false;	   
	    }	
	    $.ajaxSetup({async:false});
	    $.post("/saveContactUs", {name : "" + name + "",email : "" + email + "",subject : "" + subject + "",message : "" + message + ""}, function(data)
	    {
			var result = $.trim(data);
			var obj = jQuery.parseJSON(result);	
			 if(obj.status == "200")	   
			 {
				 swal({title:"",text:"Thanks for contacting us. Soon we will get in touch with you!"});
					$("#name").val("");
					$("#email").val("");
					$("#subject").val("");
					$("#message").val("");
			 }
	          else{			
					swal({title:"",text:obj.msg});
				}
	        
	    }, "text");
	}
	
	
	function updatePeriod(time) {
		periodTop = time;
		$('.horizonBtn').removeClass('activePeriod');
		$('.'+periodTop).addClass('activePeriod');
		getTopFunds();	
	}
	
	function getTopFunds() {
		category = $("#sel_top_category").val();
		$('#tbl_scheme_returns').html("<div class='text-center'><img src='/images/loading.gif' alt='loading'></div>");
		$.ajaxSetup({async:true});
		$.post("/mutual-funds-research/getTopMutualFunds", {category : category, period : periodTop}, function(data)
	    {
			var top10FundsByCategory = $.trim(data);
			var top10FundsByCategory_obj = jQuery.parseJSON(top10FundsByCategory);
			var top10FundsByCategory_array = $.makeArray(top10FundsByCategory_obj);
	        var html = "";

	       // html += "<thead><tr><th>Scheme Name</th><th>Rs. 1L Grew to <br> (One-Time)</th></tr></thead>";
	        html += "<tbody>";
			for (var i = 0; i < top10FundsByCategory_array.length ; i++)
		    {
				var scheme_name = top10FundsByCategory_array[i].scheme_amfi;
				var lumpsumToDisplay = top10FundsByCategory_array[i].lumpsumToDisplay;
				var category_name = top10FundsByCategory_array[i].scheme_category;
				
				html += "<tr style='border-bottom: 1px solid #ddd;'>";
			    html += "<td class='fund_hover'><a href='/mutual-funds-research/" + scheme_name + "'>" + scheme_name + "</a>";
			    html += "<br><span class='ret_label'>"+category_name+"</span>";
			    html += "</td>";
			    html += "<td class='ret text-right'> "+numbersWithComma(parseFloat(lumpsumToDisplay).toFixed(0))+" </td>";
			    html += "</tr>";	
		    }
			html += "</tbody>"; 
			$('#tbl_scheme_returns').empty();
	    	$('#tbl_scheme_returns').html(html);
	    	    
	    },'text'); 
	}
	
	// menu fixed js code
	  $(window).scroll(function () {
	    var window_top = $(window).scrollTop() + 1;
	    if (window_top > 50) {
	      $('.main_menu_top').addClass('menu_fixed animated fadeInDown');
	      $('.bg-top').css({background:"#ffffff"});
	    } else {
	      $('.main_menu_top').removeClass('menu_fixed animated fadeInDown');
	      $('.bg-top').css({background:"transparent"});
	    }
	  });
	
	  $(document).ready(function(){
		   //$('#myModal').modal('show');
		}); 
	
	</script>

<section class="home-slider owl-carousel">
      <div class="slider-item" style="background-image:url(images/1.jpg); background-position: 3% center;">
      	<div class="overlay"></div>
        <div class="container">
          <div class="row no-gutters slider-text align-items-center justify-content-start" data-scrollax-parent="true">
          <div class="col-md-12 ftco-animate">
          	<h1 class="mb-4">Are you investing in the Right Portfolios<br> to meet your investment needs</h1>
          	<span class="subheading">Investing in portfolios suiting your risk profile is the basic of investing! </span>            
            <p>
            	<a href="/mutual-funds-research/model-portfolio" class="btn btn-primary px-5 py-2 mt-3">Model Portfolios can help</a>
            	<a href="/contactus" class="btn btn-border px-5 py-2 ml-2 mt-3">Contact Us</a>
            </p>
          </div>
        </div>
        </div>
      </div>

      <div class="slider-item" style="background-image:url(images/3.jpg);">
      	<div class="overlay"></div>
        <div class="container">
          <div class="row no-gutters slider-text align-items-center justify-content-start" data-scrollax-parent="true">
          <div class="col-md-12 ftco-animate">
          	<h1 class="mb-4">To Become Wealthy You don't need <br>Large Sums to Invest</h1>
          	<span class="subheading">Build your wealth brick by brick - Invest through SIPs</span>
            <p>
            	<a href="/goal/robo-sip" class="btn btn-primary px-5 py-2 mt-3">Start a SIP</a>
            	<a href="/contactus" class="btn btn-border px-5 py-2 ml-2 mt-3">Contact Us</a>
            </p>
          </div>
        </div>
        </div>
      </div>
      
      <div class="slider-item" style="background-image:url(images/2.jpg);">
      	<div class="overlay"></div>
        <div class="container">
          <div class="row no-gutters slider-text align-items-center justify-content-start" data-scrollax-parent="true">
          <div class="col-md-12 ftco-animate">
          	<h1 class="mb-4">Have a lump sum Amount to Invest and <br>Don't know the Best Funds?</h1>
          	<span class="subheading">We suggest the best mutual Funds basis your investment tenure</span>
            <p>
            	<a href="/goal/robo-advisor" class="btn btn-primary px-5 py-2 mt-3">Invest a Lump Sum Amount</a>
            	<a href="/contactus" class="btn btn-border px-5 py-2 ml-2 mt-3">Contact Us</a>
            </p>
          </div>
        </div>
        </div>
      </div>
    </section>

		<section class="ftco-section">
			<div class="container">
				<div class="row d-flex">
					<div class="col-md-5 order-md-last wrap-about align-items-stretch">
						<div class="wrap-about-border mt-4 pb-5 ftco-animate">
							<div class="img" style="background-image: url(images/success-story.jpg); border"></div>
							<div class="text">
								<h3>Read Our Success Story for Inspiration</h3>
								<p>At <strong>"Dakshin Capital"</strong>, we adopt a structured and disciplined advisory approach and provide you portfolio solutions which meet your desired financial goals and milestones.</p>
								<p>At <strong>"Dakshin Capital"</strong>, we offer you a complete range of solutions that complement our advisory services. The range includes a combination of best of breed proprietary and non proprietary (third party) products.</p>
								<p class="mb-0"><a href="/contactus" class="btn btn-primary py-2 px-4">Contact us</a></p>
							</div>
						</div>
					</div>
					<div class="col-md-7 wrap-about pr-md-4 ftco-animate">
          			<!-- <h2 class="mb-4">Our Best Services</h2> -->
          			<h2 class="mb-4">Best Resources To Invest Better</h2>
          			
						<!-- <p>On her way she met a copy. The copy warned the Little Blind Text, that where it came from it would have been rewritten a thousand times and everything that was left from its origin would be the word.</p> -->
						<p>We have enough resources - Best Mutual Funds, Model Portfolios, Calculators, Goal Planning Tools
							<br>And Financial Planning Calculators - to help invest you invest better basis your risk profile and time horizon </p>
						<div class="row mt-5">
							<div class="col-lg-6">
								<div class="services active text-center" style="cursor:pointer;">
									<div class="icon mt-2 d-flex justify-content-center align-items-center"><span class="flaticon-pig"></span></div>
									<div class="text media-body">
										<h3>Mutual Funds</h3>
										<p>Mutual funds help investors diversify their risks by investing in a fairly portfolio ...</p>
									</div>
								</div>
								<div class="services tools-calc34 text-center" style="cursor:pointer;">
									<div class="icon mt-2 d-flex justify-content-center align-items-center"><span class="flaticon-cost"></span></div>
									<div class="text media-body">
										<h3>Tools & Calculators</h3>
										<p>Easy-to-use calculators to help make better financial planning and achieve your financial ...</p>
									</div>
								</div>
							</div>
							<div class="col-lg-6">
								<div class="services mf-research34 text-center" style="cursor:pointer;">
									<div class="icon mt-2 d-flex justify-content-center align-items-center"><span class="flaticon-lightbulb"></span></div>
									<div class="text media-body">
										<h3>MF Research Tools</h3>
										<p>The one-of-its kind Mutual fund Research section helps you identify what is the best ...</p>
									</div>
								</div>
								<div class="services text-center" style="cursor:pointer;">
									<div class="icon mt-2 d-flex justify-content-center align-items-center"><span class="flaticon-career"></span></div>
									<div class="text media-body goal_plan">
										<h3>Goal Planner</h3>
										<p>All fish day af emale very appear moved seas above Fifth them grass gathere above ...</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		
		<!-- <section class="ftco-intro ftco-no-pb img" style="background-image: url(images/bg_3.jpg);">
    	<div class="container">
    		<div class="row justify-content-center mb-5">
          <div class="col-md-10 text-center heading-section heading-section-white ftco-animate">
            <h2 class="mb-0">You Always Get the Best Guidance</h2>
          </div>
        </div>	
    	</div>
    </section>

		<section class="ftco-counter" id="section-counter">
    	<div class="container">
    		<div class="row d-md-flex align-items-center justify-content-center">
    			<div class="wrapper">
    				<div class="row d-md-flex align-items-center">
		          <div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18">
		            	<div class="icon"><span class="flaticon-doctor"></span></div>
		              <div class="text">
		                <strong class="number" data-number="705">0</strong>
		                <span>Projects Completed</span>
		              </div>
		            </div>
		          </div>
		          <div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18">
		            	<div class="icon"><span class="flaticon-doctor"></span></div>
		              <div class="text">
		                <strong class="number" data-number="809">0</strong>
		                <span>Satisfied Customer</span>
		              </div>
		            </div>
		          </div>
		          <div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18">
		            	<div class="icon"><span class="flaticon-doctor"></span></div>
		              <div class="text">
		                <strong class="number" data-number="335">0</strong>
		                <span>Awwards Received</span>
		              </div>
		            </div>
		          </div>
		          <div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
		            <div class="block-18">
		            	<div class="icon"><span class="flaticon-doctor"></span></div>
		              <div class="text">
		                <strong class="number" data-number="35">0</strong>
		                <span>Years of Experienced</span>
		              </div>
		            </div>
		          </div>
	          </div>
          </div>
        </div>
    	</div>
    </section> -->
    
    <section class="ftco-section bg-light" style="padding-bottom: 20px;">
    	<div class="col-md-12 text-center heading-section ftco-animate fadeInUp ftco-animated"><h2 class="mb-4">Returns Value Calculator</h2></div>
	    <div class="container">
		    <div class="row">
		    	<div class="col-md-6">
			    	<div class="pb-3">
			    		<b>How much do you want to invest?</b>
			    		<div class="range-slider">
						  <input class="range-slider__range rs1" type="range" value="5000" min="0" max="100000" step="500">
						  <span class="range-slider__value">0</span> 
						</div>
			    	</div>
			    	<div class="pt-3 pb-3">
			    		<b>Investment Period</b>
			    		<div class="range-slider-1">
						  <input class="range-slider__range rs2" type="range" value="60" min="0" max="450" step="1">
						  <span class="range-slider__value">0</span> 
						</div>
			    	</div>
			    	<div class="pt-3 pb-3">
			    		<b>Expected Annual Returns(% per annum)</b>
			    		<div class="range-slider-2">
						  <input class="range-slider__range rs3" type="range" value="12" min="5" max="20" step="1">
						  <span class="range-slider__value">0%</span> 
						</div>
			    	</div>
		    	</div>
		    	<div class="col-md-6 text-center">
		    		<div id="emipiechart1" style="height:275px;"></div>
		    	</div>
		    	<div class="col-md-12 text-center mt-4">
		    		If you start investing with Rs.<span id="res_amount_invest" class="font-weight-bold">5,000</span> per month. we can Help you grow it to Rs.<span id="res_total_amount" class="font-weight-bold">9,74,828*</span>*
		    	</div>
		    </div>
		    <div class="row">
		    	<div class="col-md-12 text-center pt-3 pb-3">
		    	<a href="/goal/robo-sip" class="btn btn-primary py-2 px-4">Explore More</a>
		    	</div>
		    </div>
	    </div>
    </section>
    
    <section class="ftco-section">
    	<div class="col-md-12 text-center heading-section ftco-animate fadeInUp ftco-animated">
    		<h2 class="mb-4">Mutual Fund Research</h2>
    	</div>
    	<div class="container mf-research">
    		<div class="row">
                <div class="col-lg-6 col-sm-6 mfleft" style="padding-right: 30px; border-right: 1px dotted #ddd;">
                	<div class="section_tittle">
					<h2 style="font-size: 18px;color: #233e62 !important;font-weight: 800;padding-bottom: 15px;" class="text-dark">How much return your fund is giving</h2>
					</div>
					<div class="row" style="margin:0px;">
					<select id="sel_schemeCategories" onchange="onParameterChange()" class="col-lg-7 form-control" style="margin-right: 8%;">  
		                 <c:forEach var="categories" items="${schemeCategories}"> 
		                    <c:choose>
		                      <c:when test="${categories eq 'Equity: Multi Cap'}">
		                        <option value="<c:out value="${categories}"/>" selected="selected"><c:out value="${categories}"/></option>
		                      </c:when>
		                      <c:otherwise>
		                        <option value="<c:out value="${categories}"/>"><c:out value="${categories}"/></option>
		                      </c:otherwise>
		                    </c:choose>
		                 </c:forEach>                             
		            </select>
		             
		            <select id="sel_period" onchange="onParameterChange()" class="col-lg-2 form-control" data-width="100%">              
						   <option value="1y" selected="selected">1 Year</option>
						   <option value="3y">3 Year</option>
						   <option value="5y">5 Year</option>
						   <option value="10y">10 Year</option>
		            </select> 
		            </div>
                    <table class="table table-resposive dataTable" id="tbl_schemeReturns" style="margin-top: 2%;">
						<thead>
							<tr>
								<th>Scheme Name</th>
								<th>1 Yr<br/>Rtn(%)</th>
								<th>3 Yrs<br/>Rtn(%)</th>
								<th>5 Yrs<br/>Rtn(%)</th>
							</tr>
						</thead>
						<tbody>						  
						</tbody>
					</table>
					<div class="row mt-4">	 
						 <div class="col-lg-12 text-right">	   
							<a href="${path}/mutual-funds-research/top-performing-mutual-funds" class="btn btn-primary btn-xs text-white start-button">Explore More</a>
						</div>
					</div>
                </div>
                <div class="col-lg-6 col-sm-6 mfright" style="padding-left: 30px;">
                	<div class="section_tittle" style="padding-left: 15px;">
						<h2 style="font-size: 18px;color: #233e62 !important;font-weight: 800;padding-bottom: 15px;" class="text-dark">How much investment of 1 Lakh would have grown to</h2>
					</div>
					<div class="row" style="margin: 0px;">
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
						<select id="sel_top_category" onchange="getTopFunds()" class="form-control" data-width="100%">
	  						   <option value="" selected="selected">Top Funds</option>              
							   <option value="All Equity">Top Equity</option>
							   <option value="All Debt">Top Debt</option>
							   <option value="Equity: ELSS">Top Tax Savings</option>
							   <option value="Debt: Liquid">Top Liquid Funds</option>
							   <option value="All Hybrid">Top Hybrid Funds</option>
							   <option value="Childrens Fund">Top Child Funds</option>
							   
			            </select> 
			            </div>
		            	<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 padding-0">
				 			<div class="row" style="margin: 0px;">
					 			<div class="col padding-0">
					 				<button onclick="updatePeriod('6m')" class="btn horizonBtn 6m">6M</button> 				
					 			</div>
					 			<div class="col padding-0">
					 				<button onclick="updatePeriod('1y')" class="btn horizonBtn 1y">1Y</button> 				
					 			</div>
					 			<div class="col padding-0">
					 				<button onclick="updatePeriod('3y')" class="btn horizonBtn 3y">3Y</button> 				
					 			</div>
					 			<div class="col padding-0">
					 				<button onclick="updatePeriod('5y')" class="btn horizonBtn 5y">5Y</button> 				
					 			</div>
					 			<div class="col padding-0">
					 				<button onclick="updatePeriod('10y')" class="btn horizonBtn 10y">10Y</button> 				
					 			</div>
					 			<!-- <div class="col padding-0" style="margin-left: 1%;">
					 				<button onclick="updatePeriod('SI')" class="btn horizonBtn SI">Inception</button> 				
					 			</div> -->
			 				</div>
			 			</div>
			 		</div>
			 		
			 		<div class="row detailsDiv" style="margin: 0px; margin-top: 2%;">
			 			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 table-responsive">
			 				<table class="table dataTable" id="tbl_scheme_returns" style="width: 100%;border: none;">
					        <thead>
				            <tr>
				             	<th>Scheme Name</th>
				             	<th>Rs. 1L Grew to <br> (One-Time)</th>				                
				            </tr>
				            </thead>
					            <tbody>
					            
					          </tbody>		        
					       </table>
			 			</div>
			 		</div>
			 		<div class="row mt-4">	 
						 <div class="col-lg-12 text-right dask-right-button">	   
							<a href="${path}/mutual-funds-research/top-mutual-funds" class="btn btn-primary btn-xs text-white start-button">Explore More</a>
						</div>
					</div>
                </div>
            </div>
    	</div>
    </section>

    <section class="ftco-section bg-light goal-section" id="goal_section">
			<div class="container">
				<div class="row justify-content-center mb-2 pb-2">
          <div class="col-md-8 text-center heading-section ftco-animate">
            <h2 class="mb-4">Goal Based Plans</h2>
            <p>Mutual Funds help you reach your different financial goals. Create goals for your different investment needs and track them on your investment dashboard</p>
          </div>
        </div>
				<div class="row no-gutters">
					<div class="col-lg-4 d-flex" style="cursor:pointer;">
						<div class="services-2 noborder-left text-center ftco-animate">
							<div class="icon mt-2 d-flex justify-content-center align-items-center"><span class="flaticon-school"></span></div>
							<div class="text media-body">
								<a class="goals" href="/goal/child-education">
								<h3>Higher Education</h3>
								<p>Education cost is increasing over 15% annually! Have you planned for your Kid's higher education.</p>
								</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 d-flex" style="cursor:pointer;">
						<div class="services-2 text-center ftco-animate">
							<div class="icon mt-2 d-flex justify-content-center align-items-center"><span class="flaticon-loan"></span></div>
							<div class="text media-body">
								<a class="goals" href="/goal/dream-home">
								<h3>Dream Home</h3>
								<p>No goal is impossible. Plan your dream house and start saving from now!</p>
								</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 d-flex" style="cursor:pointer;">
						<div class="services-2 text-center ftco-animate">
							<div class="icon mt-2 d-flex justify-content-center align-items-center"><span class="flaticon-chair"></span></div>
							<div class="text media-body">
								<a class="goals" href="/goal/retirement">
								<h3>Retirement</h3>
								<p>Can you maintain the same life style in your retirement years? Plan for your retired, start saving early</p>
								</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 d-flex" style="cursor:pointer;">
						<div class="services-2 noborder-left noborder-bottom text-center ftco-animate">
							<div class="icon mt-2 d-flex justify-content-center align-items-center"><span class="flaticon-bride"></span></div>
							<div class="text media-body">
								<a class="goals" href="/goal/marriage">
								<h3>Marriage</h3>
								<p>In India, marriage is an important event. Start saving for the same from now on.</p>
								</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 d-flex" style="cursor:pointer;">
						<div class="services-2 text-center noborder-bottom ftco-animate">
							<div class="icon mt-2 d-flex justify-content-center align-items-center"><span class="flaticon-medicine"></span></div>
							<div class="text media-body">
								<a class="goals" href="/goal/emergency">
								<h3>Emergency</h3>
								<p>You can meet your emergency needs , if planned well</p>
								</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 d-flex" style="cursor:pointer;">
						<div class="services-2 text-center noborder-bottom ftco-animate">
							<div class="icon mt-2 d-flex justify-content-center align-items-center"><span class="flaticon-rich"></span></div>
							<div class="text media-body">
								<a class="goals" href="/goal/save-tax">
								<h3>Save Tax</h3>
								<p>Saving Tax is possible. All you need is proper planning, discipline and perseverance</p>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		
		<section class="ftco-intro ftco-no-pb img" style="background-image: url(images/bg_1.jpg);">
    	<div class="container-fluid" style="padding: 0px 60px;">
    		<div class="row justify-content-center">
          <div class="col-lg-7 col-md-8 d-flex align-items-center heading-section heading-section-white ftco-animate">
            <h5 style="color: #fff;font-weight: bold;" class="mb-3 mb-md-0">Keep yourself updated with the current news - Subscribe to our Newsletter</h5>
            
          </div>
          <div class="col-lg-5 col-md-4 ftco-animate">
          	<div class="mb-0" style="display:flex">
          		<input type="text" style="width: 100%;background: rgba(255, 255, 255, 0.1) !important;border: 2px solid #fff;;color: rgba(255, 255, 255, 1) !important;font-size: 16px;" class="form-control mb-2 text-center" placeholder="Enter email address" id="txt_email_subscription">
          		<button id="subscribe_home_btn" style="margin-left:20px; color: #fff !important;font-size: 16px;background: #ffa200 !important;border: none !important;border-radius: 2px;transition: all 0.3s ease;" type="submit" onclick="subscribeEmail()" class="form-control submit px-3"> <span class="ladda-label">Subscribe</span> </button>          	  
          	</div>
          </div>
        </div>	
    	</div>
    </section>

		<section class="ftco-section bg-light">
			<div class="container">
				<div class="row justify-content-center mb-5 pb-2">
          <div class="col-md-8 text-center heading-section ftco-animate">
            <h2 class="mb-4"><span>Recent</span> Blog</h2>
            <p>Separated they live in. A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country</p>
          </div>
        </div>
		<div class="row">
		<c:forEach items="${blogsList}" var="blogs">
          <div class="col-md-6 col-lg-4 ftco-animate">
            <div class="blog-entry">
              <a href="/blog/${fn:replace(blogs.title,' ','-')}" class="block-20 d-flex align-items-end" style='background-image: url("/resources/images/blogs/${blogs.title_folder}/${blogs.photo}");'>
								<div class="meta-date text-center p-2">
                   <span class="day"><fmt:formatDate pattern="dd" value="${blogs.create_date}" /></span>
                  <span class="mos"><fmt:formatDate pattern="MMM" value="${blogs.create_date}" /></span>
                  <span class="yr"><fmt:formatDate pattern="yyyy" value="${blogs.create_date}" /></span>
                </div>
              </a>
              <div class="text bg-white p-4">
                <h3 class="heading"><a href="<c:url value="/blog/${fn:replace(blogs.title,' ','-')}"/>"><c:out value="${fn:substring(blogs.title,0,60)}" /></a></h3>
                <p><c:out value="${fn:substring(blogs.short_content,0,149)}" /> ...</p>
                <div class="d-flex align-items-center mt-4">
	                <p class="mb-0"><a href="<c:url value="/blog/${fn:replace(blogs.title,' ','-')}"/>" class="btn btn-primary">Read More <span class="ion-ios-arrow-round-forward"></span></a></p>
	                <p class="ml-auto mb-0">
	                	<a href="#" class="mr-2"><span class="fa fa-user"></span>&nbsp;<c:out value="${blogs.author_name}" /></a>
	                </p>
                </div>
              </div>
            </div>
          </div>
		</c:forEach>
        </div>
			</div>
		</section>

    <section class="ftco-section ftco-consult ftco-no-pt ftco-no-pb" style="background-image: url(images/bg_5.jpg);" data-stellar-background-ratio="0.5">
    	<div class="overlay"></div>
    	<div class="container">
    		<div class="row justify-content-end">
    			<div class="col-md-6 py-5 px-md-5">
    				<div class="py-md-5">
		          <div class="heading-section heading-section-white ftco-animate mb-5">
		            <h2 class="mb-4">Request A Call Back </h2>
		            <p>If you have any investment and financial planning query, feel free write to us and our team will call you back!</p>
		          </div>
		          <div class="appointment-form ftco-animate">
		    				<div class="d-md-flex">
			    				<div class="form-group">
			    					<input type="text" class="form-control" placeholder="First Name" id="fname">
			    				</div>
			    				<div class="form-group ml-md-4">
			    					<input type="text" class="form-control" placeholder="Last Name" id="fname">
			    				</div>
		    				</div>
		    				<div class="d-md-flex">
		    					<div class="form-group">
			    					<input type="text" class="form-control" placeholder="Email" id="email">
			    				</div>
		    					<div class="form-group ml-md-4">
			    					<input type="text" class="form-control" placeholder="Phone" id="phone">
			    				</div>
		    				</div>
		    				<div class="d-md-flex">
		    					<div class="form-group">
			    					<input type="text" class="form-control" placeholder="Subject" id="subject">
			    				</div>
		    				</div>
		    				<div class="d-md-flex">
		    					<div class="form-group">
			              <textarea cols="30" rows="2" class="form-control" placeholder="Message" id="message"></textarea>
			            </div>
			            <div class="form-group ml-md-4">
			              <input type="submit" onclick="contactus()" value="Request A Call Back" class="btn btn-white py-3 px-4">
			            </div>
		    				</div>
		    			</div>
		    		</div>
    			</div>
        </div>
    	</div>
    </section>

		<section class="ftco-section testimony-section">
      <div class="container">
        <div class="row justify-content-center mb-2">
          <div class="col-md-8 text-center heading-section ftco-animate">
            <h2 class="mb-4">What Our Clients Says</h2>
            <p>Read what our awesome clients has to say about our good work and join them to experience our service and be part of Dakshin Capital Family</p>
          </div>
        </div>
        <div class="row ftco-animate justify-content-center">
          <div class="col-md-12">
            <div class="carousel-testimony owl-carousel">
              <div class="item">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="background-image: url(images/testimonial/n_r_Murali_Small.jpg)">
                  </div>
                  <div class="text pl-4">
                  	<span class="quote d-flex align-items-center justify-content-center">
                      <i class="icon-quote-left"></i>
                    </span>
                    <p>Dakshin Capital has made for itself a name for excellence in service of investors in India. I am very impressed by the dedication of the founder, Mr. Ramakrishnan Nayak and his team. Whenever I need any kind of investment advice, whether in Mutual Funds, shares or insurance, I turn to Ramakrishnan and on every occasion, I have received clear, unambiguous and wholesome advice. I have known Ramakrishnan for more than 3 decades and wish him and his team at Dakshin Capital many more years of happiness and prosperity and Dakshin Capital Private Limited to reach the pinnacle of success.</p>
                    <p class="name">Mr N R Murali</p>
                    <span class="position">Chartered Accountant</span>
                  </div>
                </div>
              </div>
              <div class="item">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="background-image: url(images/testimonial/Kartik_dore.jpg)">
                  </div>
                  <div class="text pl-4">
                  	<span class="quote d-flex align-items-center justify-content-center">
                      <i class="icon-quote-left"></i>
                    </span>
                    <p>The Financial Advisory Dakshin Capital Pvt Ltd founded by Mr Ramakrishnan V Nayak has been closely associated with my Family investment, since their inception in June 2014 with utmost sincerely and integrity to customer care. Their associates and staff provides prompt and regular service on both in front and online and in personal interaction has and when required.  We have seen them grow from strength to strength and enhance their customer base many fold over the year.  Their ethical and integrity being off the highest order, we recommend them and wish them all success in the future.</p>
                    <p class="name">Mr Kartik Dore</p>
                    <span class="position">Former Executive, Tata group</span>
                  </div>
                </div>
              </div>
              <div class="item">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="background-image: url(images/testimonial/v_Balaji_small.jpg)">
                  </div>
                  <div class="text pl-4">
                  	<span class="quote d-flex align-items-center justify-content-center">
                      <i class="icon-quote-left"></i>
                    </span>
                    <p>Ever since its inception we are with Dakshin capital. All aspects of our financial well-being are ensured by their proactive analysis, consultation and continual guidance. Creation of awareness and financial knowledge among its customers is Hallmark of Dakshin's way of work. Over the years, Dakshin Capital has helped us to build a balanced and Futuristic portfolio that gives us confidence to realize our goals. Financial Health of our family is in the safe hands of Dakshin.</p>
                    <p class="name">Mr Balaji V</p>
                    <span class="position">IT Professional</span>
                  </div>
                </div>
              </div>
              <div class="item">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="background-image: url(images/testimonial/r_Suraj_Kumar_small.jpeg)">
                  </div>
                  <div class="text pl-4">
                  	<span class="quote d-flex align-items-center justify-content-center">
                      <i class="icon-quote-left"></i>
                    </span>
                    <p>Investment for me was only Bank FDs,RDs and PPF until I got in touch with Ramakrishnan 8 years ago.  Now investment has become an interesting and challenging game. Thanks to the entire team of Dakshin Capital.</p>
                    <p class="name">Mr R Suraj Kumar</p>
                    <span class="position">Medical Engineering Professional</span>
                  </div>
                </div>
              </div>
              <div class="item">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="background-image: url(images/testimonial/r_Vijaya_small.jpg)">
                  </div>
                  <div class="text pl-4">
                  	<span class="quote d-flex align-items-center justify-content-center">
                      <i class="icon-quote-left"></i>
                    </span>
                    <p>Dakshin Capital has made a more Complex and Unpredictable Finance Management an Easy Go for investors like us.Their prompt sharing of vital  information on the financial market trends and hand holding the  investors on the prospective Short term and long term investments is worth a special mention. Thanks to Team Dakshin.</p>
                    <p class="name">Mrs R Vijaya</p>
                    <span class="position">Home Maker</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

	<section class="ftco-section bg-light">
      <div class="container">
        <div class="row justify-content-center mb-0">
          <div class="col-md-8 text-center heading-section ftco-animate">
            <h2 class="mb-4">Our Partners</h2>
           </div>
        </div>
        <div class="row ftco-animate justify-content-center">
          <div class="col-md-12">
            <div class="carousel-partners owl-carousel">
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/aditya.jpg)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/bnp.png)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/canara.png)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/dsp.png)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/franklin.jpg)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/hdfc.png)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/icici.jpg)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/bandhan.png)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/invesco.jpg)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/kotak.png)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/lnt.png)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/mahindra.jpg)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/mirae.jpg)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/nippon.jpeg)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/principal.png)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/sbi.jpg)">
                  </div>
                </div>
              </div>
              <div class="item" style="background: #fff;">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="width: 100%; border-radius: 0px !important;background-size: contain;background-image: url(images/amc/sundaram.jpg)">
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
<!-- content End -->

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
       <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" style="padding-left:6px;">&times;</button>
        <h4 class="modal-title"></h4>
      </div> 
      <div class="modal-body">
        <img src="/images/sovereign_gold_bonds.jpg" class="img-responsive" style="width:100%;" /> 
      </div>
	  <!-- <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
      </div> -->
    </div>

  </div>
</div>