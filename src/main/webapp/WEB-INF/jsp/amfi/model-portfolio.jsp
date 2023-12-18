<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.track-container .table-border:hover {
    border: 1px solid #f6ba18;
}
.track-container .track-card-layout {
    height: auto;
    background: #fff;
    box-shadow: 2px 3px 15px 0 rgba(0,0,0,0.16);
    border-radius: 8px;
    margin: 25px 0 10px 0;
    border: 1px solid transparent;
}
.track-container .track-record-title {
    color: #333;
    font-size: 16px;
    font-weight: 600;
    margin: 0 auto;
    padding: 20px;
    min-height:85px;
}
.track-container .track-record-description {
    font-size: 12px;
    padding: 0 20px 20px 20px;
    font-weight: 300;
}
.track-container .track-record-sub-description {
    font-size: 16px;
    padding: 0 20px 20px 20px;
    font-weight: 600;
}
.track-container .table {
    width: 100%;
    max-width: 100%;
    margin-bottom: 1rem;
    background-color: transparent;
    text-align: center;
}
.track-container .track-title-left-align {
    padding-left: 22px;
}
.track-container .track-title {
    font-size: 12px;
    padding: 10px;
	padding-left: 10px;
    margin: 0 auto;
    border-bottom: 1px solid #ccc;
    border-top: 0;
    font-weight:normal;
}
.track-container .return {
    font-size: 14px;
    text-align: right;
}
.track-container .scripbox-return-value {
    color:#04457f;
    font-weight:bold;
}
.track-container .table-border:hover .sb-cta-button {
    background-color: #f6ba18;
    color: #fff;
    border: 1px solid #f6ba18;
}
.track-container .button-margin {
    margin-left: 10px;
    margin-right: 10px;
    padding-bottom: 15px;
}
.track-container .sb-cta-learn-button {
    padding: 4px 10px;
    font-size: 14px;
    color: #333;
    border: 1px solid #ccc;
    display: inline-block;
    border-radius: 2px;
    cursor: pointer;
}
.track-container .sb-cta-button {
    color: #080707;
    border-radius: 2px;
    cursor: pointer;
    display: inline-block;
    background: #fff;
    border: 1px solid #ccc;
}
.sb-cta-button.small {
    padding: 4px 10px;
    font-size: 14px;
}
.testimonial_sec{
	height:auto;
	margin-bottom:50px;
}
.testimonial_sec .row{
	padding-top:20px;
}
.padding0{
	padding:0px;
}
.company-tab .nav-item {
	padding: 0px 10px;
}
.company-tab .nav-link {
	background: #ffa200;
	border: 1px solid #ffa200;
	color: #333;
	font-weight: 600;
}
.company-tab .nav-link:hover {
	border: 1px solid #ffa200;
	background: transparent;
	color: #ffa200;
	font-weight: 600;
}
.company-tab .nav-link.active {
	background-color: #1b0e3d !important;
	border: 1px solid #1b0e3d !important;
	color: #fff;
	font-weight: 600;
}
</style> 

<script type="text/javascript">
var risk = "";

$(document).ready(function(){
	
	risk = '${risk}';
	
	if(risk == "Aggressive") {
		$('.menuli').removeClass('active');
		$('.agg').addClass('active');
		$('.tab-pane').removeClass('active in');
		$('#menu1').addClass('active in');		
	}
	else if(risk == "Moderately Aggressive") {
		$('.menuli').removeClass('active');
		$('.magg').addClass('active');
		$('.tab-pane').removeClass('active in');
		$('#menu2').addClass('active in');
	}
	else if(risk == "Moderate") {
		$('.menuli').removeClass('active');
		$('.mod').addClass('active');
		$('.tab-pane').removeClass('active in');
		$('#menu3').addClass('active in');
	}
	else if(risk == "Moderately Conservative") {
		$('.menuli').removeClass('active');
		$('.modcons').addClass('active');
		$('.tab-pane').removeClass('active in');
		$('#menu4').addClass('active in');
	}
	else if(risk == "Conservative") {
		$('.menuli').removeClass('active');
		$('.cons').addClass('active');
		$('.tab-pane').removeClass('active in');
		$('#menu5').addClass('active in');
	} else {
		$('.menuli').removeClass('active');
		$('.agg').addClass('active');
		$('.tab-pane').removeClass('active in');
		$('#menu1').addClass('active in');	
	}
	
	$('a[data-toggle="pill"]').on('shown.bs.tab', function (e) {
		
		$(".menu2-graph").each(function(){
   			var id = $(this).attr('id');
   			$("#"+id).highcharts().reflow();
		});
		
		$(".menu3-g").each(function(){
   			var id = $(this).attr('id');
   			$("#"+id).highcharts().reflow();
		});
		
		$(".menu4-g").each(function(){
   			var id = $(this).attr('id');
   			$("#"+id).highcharts().reflow();
		});
		
		$(".menu5-g").each(function(){
   			var id = $(this).attr('id');
   			$("#"+id).highcharts().reflow();
		});
		
        //$(".menu2-graph").highcharts().reflow();
    });
	
});
</script>

<div class="line"></div>

<!-- main-container start -->
<section class="testimonial_sec clear_fix track-container" id="track-record">
<div class="container content">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 company">
<div class="row mt-4"> 
<div class="col-md-12 col-sm-12">
<div class="title-v1">
	<h1 class="goal_name text-center">Model Portfolio</h1>
</div>
</div>
</div>
<div class="company-tab mt-3">

<ul class="nav nav-pills nav-justified">
     <li class="nav-item"><a class="nav-link agg menuli active" data-toggle="pill" href="#menu1">Aggressive</a></li>
    <li class="nav-item"><a class="nav-link magg menuli" data-toggle="pill" href="#menu2">Moderately Aggressive</a></li>
    <li class="nav-item"><a class="nav-link mod menuli" data-toggle="pill" href="#menu3">Moderate</a></li>
    <li class="nav-item"><a class="nav-link modcons menuli" data-toggle="pill" href="#menu4">Moderately Conservative</a></li>
    <li class="nav-item"><a class="nav-link cons menuli" data-toggle="pill" href="#menu5">Conservative</a></li>
</ul>

<div class="tab-content">
<div id="menu1" class="tab-pane fade in active">

<div class="row justify-content-center">
<c:forEach items="${aggressive_list}" var="schemePerformances" varStatus="status">
<c:choose>
<c:when test="${status.index eq 3}">
	<div class="col-md-6 col-lg-4 col-md-offset-2 col-lg-offset-2 col-xs-12 col-sm-12 col-12 track-card-spacing" >
</c:when>
<c:otherwise>
	<div class="col-md-6 col-lg-4 col-sm-12 col-12 track-card-spacing" >
</c:otherwise>
</c:choose>

<div class="track-card-layout table-border">
<div class="track-record-title">${schemePerformances.scheme_amfi}</div>
<div class="track-record-description">${schemePerformances.scheme_category}</div>
<div id="chart-a-${schemePerformances.scheme_amfi_code}" class="text-center aggressive_list" style="min-width: 363px; height: 200px;"></div>
<div class="table-responsive text-center">
<table class="table table-margin">
<thead>
<tr>
<th class="track-title track-title-left-align" scope="col">Period</th>
<th class="track-title text-right" scope="col">Annualized<br>Return (%)</th>
</tr>
</thead>
<tbody>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">1 Year</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_abs_1year eq 0 ? '-': schemePerformances.returns_abs_1year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">3 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_3year eq 0 ? '-': schemePerformances.returns_cmp_3year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">5 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_5year eq 0 ? '-': schemePerformances.returns_cmp_5year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">10 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_10year eq 0 ? '-': schemePerformances.returns_cmp_10year}"></c:out></td>
</tr>
</tbody>
</table>
</div>
<div class="button-margin row clearfix">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 padding0">
<a class="btn py-1 px-3 btn-border" href="/mutual-funds-research/<c:out value="${schemePerformances.scheme_amfi}"></c:out>">Learn More</a>
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-right padding0">
<c:choose>
<c:when test="${accountMap != null}">
	<a class="btn py-1 px-3 btn-primary" href="https://mfportfolio.dakshincapital.com/bse/bse-fresh-purchase">Start Investing</a>
</c:when>
<c:otherwise>
	<a class="btn py-1 px-3 btn-primary" href="https://mfportfolio.dakshincapital.com">Start Investing</a>
</c:otherwise>
</c:choose>
</div>
</div>
</div>
</div>
</c:forEach>
</div>

</div>
<div id="menu2" class="tab-pane fade">

<div class="row justify-content-center">
<c:forEach items="${moderately_aggressive_list}" var="schemePerformances" varStatus="status">
<c:choose>
<c:when test="${status.index eq 3}">
	<div class="col-md-6 col-lg-4 col-md-offset-2 col-lg-offset-2 col-xs-12 col-sm-12 col-12 track-card-spacing" >
</c:when>
<c:otherwise>
	<div class="col-md-6 col-lg-4 col-sm-12 col-12 track-card-spacing" >
</c:otherwise>
</c:choose>
<div class="track-card-layout table-border">
<div class="track-record-title">${schemePerformances.scheme_amfi}</div>
<div class="track-record-description">${schemePerformances.scheme_category}</div>
<div id="chart-ma-${schemePerformances.scheme_amfi_code}" class="text-center menu2-graph" style="min-width: 100%; height: 200px;"></div>
<div class="table-responsive text-center">
<table class="table table-margin">
<thead>
<tr>
<th class="track-title track-title-left-align" scope="col">Period</th>
<th class="track-title text-right" scope="col">Annualized<br>Return (%)</th>
</tr>
</thead>
<tbody>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">1 Year</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_abs_1year eq 0 ? '-': schemePerformances.returns_abs_1year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">3 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_3year eq 0 ? '-': schemePerformances.returns_cmp_3year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">5 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_5year eq 0 ? '-': schemePerformances.returns_cmp_5year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">10 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_10year eq 0 ? '-': schemePerformances.returns_cmp_10year}"></c:out></td>
</tr>
</tbody>
</table>
</div>
<div class="button-margin row clearfix">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 padding0">
<a class="btn py-1 px-3 btn-border" href="/mutual-funds-research/<c:out value="${schemePerformances.scheme_amfi}"></c:out>">Learn More</a>
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-right padding0">
<a class="btn py-1 px-3 btn-primary" href="https://mfportfolio.dakshincapital.com">Start Investing</a>
</div>
</div>
</div>
</div>
</c:forEach>
</div>

</div>
<div id="menu3" class="tab-pane fade">

<div class="row justify-content-center">
<c:forEach items="${moderate_list}" var="schemePerformances" varStatus="status">
<c:choose>
<c:when test="${status.index eq 3}">
	<div class="col-md-6 col-lg-4 col-md-offset-2 col-lg-offset-2 col-xs-12 col-sm-12 col-12 track-card-spacing" >
</c:when>
<c:otherwise>
	<div class="col-md-6 col-lg-4 col-sm-12 col-12 track-card-spacing" >
</c:otherwise>
</c:choose>
<div class="track-card-layout table-border">
<div class="track-record-title">${schemePerformances.scheme_amfi}</div>
<div class="track-record-description">${schemePerformances.scheme_category}</div>
<div id="chart-m-${schemePerformances.scheme_amfi_code}" class="text-center menu3-g" style="min-width: 100%; height: 200px;"></div>
<div class="table-responsive text-center">
<table class="table table-margin">
<thead>
<tr>
<th class="track-title track-title-left-align" scope="col">Period</th>
<th class="track-title text-right" scope="col">Annualized<br>Return (%)</th>
</tr>
</thead>
<tbody>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">1 Year</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_abs_1year eq 0 ? '-': schemePerformances.returns_abs_1year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">3 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_3year eq 0 ? '-': schemePerformances.returns_cmp_3year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">5 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_5year eq 0 ? '-': schemePerformances.returns_cmp_5year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">10 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_10year eq 0 ? '-': schemePerformances.returns_cmp_10year}"></c:out></td>
</tr>
</tbody>
</table>
</div>
<div class="button-margin row clearfix">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 padding0">
<a class="btn py-1 px-3 btn-border" href="/mutual-funds-research/<c:out value="${schemePerformances.scheme_amfi}"></c:out>">Learn More</a>
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-right padding0">
<a class="btn py-1 px-3 btn-primary" href="https://mfportfolio.dakshincapital.com">Start Investing</a>
</div>
</div>
</div>
</div>
</c:forEach>
</div>

</div>
<div id="menu4" class="tab-pane fade">

<div class="row justify-content-center">
<c:forEach items="${moderately_conservative_list}" var="schemePerformances" varStatus="status">
<c:choose>
<c:when test="${status.index eq 3}">
	<div class="col-md-6 col-lg-4 col-md-offset-2 col-lg-offset-2 col-xs-12 col-sm-12 col-12 track-card-spacing" >
</c:when>
<c:otherwise>
	<div class="col-md-6 col-lg-4 col-sm-12 col-12 track-card-spacing" >
</c:otherwise>
</c:choose>
<div class="track-card-layout table-border">
<div class="track-record-title">${schemePerformances.scheme_amfi}</div>
<div class="track-record-description">${schemePerformances.scheme_category}</div>
<div id="chart-mc-${schemePerformances.scheme_amfi_code}" class="text-center menu4-g" style="min-width: 100%; height: 200px;"></div>
<div class="table-responsive text-center">
<table class="table table-margin">
<thead>
<tr>
<th class="track-title track-title-left-align" scope="col">Period</th>
<th class="track-title text-right" scope="col">Annualized<br>Return (%)</th>
</tr>
</thead>
<tbody>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">1 Year</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_abs_1year eq 0 ? '-': schemePerformances.returns_abs_1year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">3 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_3year eq 0 ? '-': schemePerformances.returns_cmp_3year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">5 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_5year eq 0 ? '-': schemePerformances.returns_cmp_5year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">10 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_10year eq 0 ? '-': schemePerformances.returns_cmp_10year}"></c:out></td>
</tr>
</tbody>
</table>
</div>
<div class="button-margin row clearfix">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 padding0">
<a class="btn py-1 px-3 btn-border" href="/mutual-funds-research/<c:out value="${schemePerformances.scheme_amfi}"></c:out>">Learn More</a>
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-right padding0">
<a class="btn py-1 px-3 btn-primary" href="https://mfportfolio.dakshincapital.com">Start Investing</a>
</div>
</div>
</div>
</div>
</c:forEach>
</div>

</div>
<div id="menu5" class="tab-pane fade">

<div class="row justify-content-center">
<c:forEach items="${conservative_list}" var="schemePerformances" varStatus="status">
<c:choose>
<c:when test="${status.index eq 3}">
	<div class="col-md-6 col-lg-4 col-md-offset-2 col-lg-offset-2 col-xs-12 col-sm-12 col-12 track-card-spacing" >
</c:when>
<c:otherwise>
	<div class="col-md-6 col-lg-4 col-sm-12 col-12 track-card-spacing" >
</c:otherwise>
</c:choose>
<div class="track-card-layout table-border">
<div class="track-record-title">${schemePerformances.scheme_amfi}</div>
<div class="track-record-description">${schemePerformances.scheme_category}</div>
<div id="chart-c-${schemePerformances.scheme_amfi_code}" class="text-center menu5-g" style="min-width: 100%; height: 200px;"></div>
<div class="table-responsive text-center">
<table class="table table-margin">
<thead>
<tr>
<th class="track-title track-title-left-align" scope="col">Period</th>
<th class="track-title text-right" scope="col">Annualized<br>Return (%)</th>
</tr>
</thead>
<tbody>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">1 Year</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_abs_1year eq 0 ? '-': schemePerformances.returns_abs_1year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">3 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_3year eq 0 ? '-': schemePerformances.returns_cmp_3year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">5 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_5year eq 0 ? '-': schemePerformances.returns_cmp_5year}"></c:out></td>
</tr>
<tr class="track-margin track-padding">
<td class="track-hr number-of-years">10 Years</td>
<td class="track-hr return"><c:out value="${schemePerformances.returns_cmp_10year eq 0 ? '-': schemePerformances.returns_cmp_10year}"></c:out></td>
</tr>
</tbody>
</table>
</div>
<div class="button-margin row clearfix">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 padding0">
<a class="btn py-1 px-3 btn-border" href="/mutual-funds-research/<c:out value="${schemePerformances.scheme_amfi}"></c:out>">Learn More</a>
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-right padding0">
<a class="btn py-1 px-3 btn-primary" href="https://mfportfolio.dakshincapital.com">Start Investing</a>
</div>
</div>
</div>
</div>
</c:forEach>
</div>

</div>
</div>

</div>
</div>
</div>
</section>

<script type="text/javascript">

$(document).ready(function(){
	
	schemePerformaceGraph();
	
});
function schemePerformaceGraph()
{
	var aggressive_list = '${aggressive_list_json}';
	var obj1 = jQuery.parseJSON(aggressive_list);
	var aggressive_array = $.makeArray(obj1);
	
	var moderately_aggressive_list = '${moderately_aggressive_list_json}';
	var obj2 = jQuery.parseJSON(moderately_aggressive_list);
	var moderately_aggressive_array = $.makeArray(obj2);
	
	var moderate_list = '${moderate_list_json}';
	var obj3 = jQuery.parseJSON(moderate_list);
	var moderate_array = $.makeArray(obj3);
	
	var moderately_conservative_list = '${moderately_conservative_list_json}';
	var obj4 = jQuery.parseJSON(moderately_conservative_list);
	var moderately_conservative_array = $.makeArray(obj4);
	
	var conservative_list = '${conservative_list_json}';
	var obj5 = jQuery.parseJSON(conservative_list);
	var conservative_array = $.makeArray(obj5);
	
	var myArrays = new Array();
	myArrays = [aggressive_array, moderately_aggressive_array, moderate_array, moderately_conservative_array, conservative_array];
	var scheme_array = [].concat.apply([], myArrays);   
	
	var container_width = $(".aggressive_list").width();
	
	for (var i = 0; i < scheme_array.length; i++)
    {
		var scheme_amfi_code = scheme_array[i].scheme_amfi_code;
		var scheme_amfi = scheme_array[i].scheme_amfi;
		var returns_abs_1year = scheme_array[i].returns_abs_1year;
		var returns_cmp_3year = scheme_array[i].returns_cmp_3year;
		var returns_cmp_5year = scheme_array[i].returns_cmp_5year;
		var returns_cmp_10year = scheme_array[i].returns_cmp_10year;
		
		var benchmark_name = scheme_array[i].benchmark_name;
		var benchmark_returns_abs_1year = scheme_array[i].benchmark_returns_abs_1year;
		var benchmark_returns_cmp_3year = scheme_array[i].benchmark_returns_cmp_3year;
		var benchmark_returns_cmp_5year = scheme_array[i].benchmark_returns_cmp_5year;
		var benchmark_returns_cmp_10year = scheme_array[i].benchmark_returns_cmp_10year;
		
		var category_name = scheme_array[i].category_name;
		var category_returns_abs_1year = scheme_array[i].category_returns_abs_1year;
		var category_returns_cmp_3year = scheme_array[i].category_returns_cmp_3year;
		var category_returns_cmp_5year = scheme_array[i].category_returns_cmp_5year;
		var category_returns_cmp_10year = scheme_array[i].category_returns_cmp_10year;
		
		var data_array = new Array();
		var fund_array = new Array();
		
		if(returns_cmp_10year != 0.0)
		{
			fund_array.push("10 Years");
			fund_array.push(parseFloat(returns_cmp_10year));
			var fund_obj = {
	            name: scheme_amfi,
	            color:'#f6bb19',
	            data: [["0 Year", 0], 
	                   ["1 Year", parseFloat(returns_abs_1year)],
	            	   ["3 Years", parseFloat(returns_cmp_3year)],
	            	   ["5 Years", parseFloat(returns_cmp_5year)], fund_array]
	        };
		} else {
			var fund_obj = {
		            name: scheme_amfi,
		            color:'#f6bb19',
		            data: [["0 Year", 0], 
		                   ["1 Year", parseFloat(returns_abs_1year)],
		            	   ["3 Years", parseFloat(returns_cmp_3year)],
		            	   ["5 Years", parseFloat(returns_cmp_5year)]]
		        };
		}
		data_array.push(fund_obj);
		
		if(benchmark_name != null && benchmark_name != "")
		{
			var benchmark_obj = {
					name: benchmark_name,
		            color:'#01135c',
		            data: [["0 Year", 0], 
		                   ["1 Year", parseFloat(benchmark_returns_abs_1year)],
		                   ["3 Years", parseFloat(benchmark_returns_cmp_3year)],
		                   ["5 Years", parseFloat(benchmark_returns_cmp_5year)],
		                   ["10 Years", parseFloat(benchmark_returns_cmp_10year)]]
			};
			data_array.push(benchmark_obj);
		}
		
		var category_obj = {
	            name: category_name,
	            color:'#a8a8a8',
	            data: [["0 Year", 0], 
	                   ["1 Year", parseFloat(category_returns_abs_1year)],
	                   ["3 Years", parseFloat(category_returns_cmp_3year)],
	                   ["5 Years", parseFloat(category_returns_cmp_5year)],
	                   ["10 Years", parseFloat(category_returns_cmp_10year)]]
	        };
		data_array.push(category_obj);
		
		$('#chart-a-'+scheme_amfi_code).highcharts({
		    chart: {
		        type: 'spline',
		        width: 330,
		        renderTo: this
		    },
		    title: {
		        text: ''
		    },
		    subtitle: {
		        text: ''
		    },
		    xAxis: {
		    	tickInterval: 1,
		    	categories: ["0 Year", "1 Year", "3 Years", "5 Years", "10 Years"],
		    },
		    yAxis: {
		        title: {
		            text: ''
		        },
		        minorGridLineWidth: 0,
		        gridLineWidth: 0,
		        alternateGridColor: null,
		    },
		    tooltip: {
		        formatter: function() {
		            return '<b>'+ this.point.name +'</b><br/>'+
		            this.series.name +':<br/>'+
	                Highcharts.numberFormat(this.y, 2) +'%';
		        },
	            useHTML: true,
	            style: {
	                fontSize: '10px'
	            }
		    },
		    legend: {
		    	enabled: true,
		    	itemStyle: {
		    		fontSize: '10px',
		    		fontWeight: 'normal'
				},
		    },
		    credits:{
		    	enabled: false
		    },
		    plotOptions: {
		        spline: {
		            lineWidth: 4,
		            states: {
		                hover: {
		                    lineWidth: 5
		                }
		            },
		            marker: {
		                enabled: false
		            },
		            pointStart: 0
		        }
		    },
		    series: data_array,
		});
		
		$('#chart-ma-'+scheme_amfi_code).highcharts({
		    chart: {
		        type: 'spline',
		        renderTo: this
		    },
		    title: {
		        text: ''
		    },
		    subtitle: {
		        text: ''
		    },
		    xAxis: {
		    	tickInterval: 1,
		    	categories: ["0 Year", "1 Year", "3 Years", "5 Years", "10 Years"],
		    },
		    yAxis: {
		        title: {
		            text: ''
		        },
		        minorGridLineWidth: 0,
		        gridLineWidth: 0,
		        alternateGridColor: null,
		    },
		    tooltip: {
		        formatter: function() {
		            return '<b>'+ this.point.name +'</b><br/>'+
		            this.series.name +':<br/>'+
	                Highcharts.numberFormat(this.y, 2) +'%';
		        },
	            useHTML: true,
	            style: {
	                fontSize: '10px'
	            }
		    },
		    legend: {
		    	enabled: true,
		    	itemStyle: {
		    		fontSize: '10px',
		    		fontWeight: 'normal'
				},
		    },
		    credits:{
		    	enabled: false
		    },
		    plotOptions: {
		        spline: {
		            lineWidth: 4,
		            states: {
		                hover: {
		                    lineWidth: 5
		                }
		            },
		            marker: {
		                enabled: false
		            },
		            pointStart: 0
		        }
		    },
		    series: data_array,
		});
		
		$('#chart-m-'+scheme_amfi_code).highcharts({
		    chart: {
		        type: 'spline',
		        renderTo: this
		    },
		    title: {
		        text: ''
		    },
		    subtitle: {
		        text: ''
		    },
		    xAxis: {
		    	tickInterval: 1,
		    	categories: ["0 Year", "1 Year", "3 Years", "5 Years", "10 Years"],
		    },
		    yAxis: {
		        title: {
		            text: ''
		        },
		        minorGridLineWidth: 0,
		        gridLineWidth: 0,
		        alternateGridColor: null,
		    },
		    tooltip: {
		        formatter: function() {
		            return '<b>'+ this.point.name +'</b><br/>'+
		            this.series.name +':<br/>'+
	                Highcharts.numberFormat(this.y, 2) +'%';
		        },
	            useHTML: true,
	            style: {
	                fontSize: '10px'
	            }
		    },
		    legend: {
		    	enabled: true,
		    	itemStyle: {
		    		fontSize: '10px',
		    		fontWeight: 'normal'
				},
		    },
		    credits:{
		    	enabled: false
		    },
		    plotOptions: {
		        spline: {
		            lineWidth: 4,
		            states: {
		                hover: {
		                    lineWidth: 5
		                }
		            },
		            marker: {
		                enabled: false
		            },
		            pointStart: 0
		        }
		    },
		    series: data_array,
		});
		
		$('#chart-mc-'+scheme_amfi_code).highcharts({
		    chart: {
		        type: 'spline',
		        renderTo: this
		    },
		    title: {
		        text: ''
		    },
		    subtitle: {
		        text: ''
		    },
		    xAxis: {
		    	tickInterval: 1,
		    	categories: ["0 Year", "1 Year", "3 Years", "5 Years", "10 Years"],
		    },
		    yAxis: {
		        title: {
		            text: ''
		        },
		        minorGridLineWidth: 0,
		        gridLineWidth: 0,
		        alternateGridColor: null,
		    },
		    tooltip: {
		        formatter: function() {
		            return '<b>'+ this.point.name +'</b><br/>'+
		            this.series.name +':<br/>'+
	                Highcharts.numberFormat(this.y, 2) +'%';
		        },
	            useHTML: true,
	            style: {
	                fontSize: '10px'
	            }
		    },
		    legend: {
		    	enabled: true,
		    	itemStyle: {
		    		fontSize: '10px',
		    		fontWeight: 'normal'
				},
		    },
		    credits:{
		    	enabled: false
		    },
		    plotOptions: {
		        spline: {
		            lineWidth: 4,
		            states: {
		                hover: {
		                    lineWidth: 5
		                }
		            },
		            marker: {
		                enabled: false
		            },
		            pointStart: 0
		        }
		    },
		    series: data_array,
		});
		
		$('#chart-c-'+scheme_amfi_code).highcharts({
		    chart: {
		        type: 'spline',
		        renderTo: this
		    },
		    title: {
		        text: ''
		    },
		    subtitle: {
		        text: ''
		    },
		    xAxis: {
		    	tickInterval: 1,
		    	categories: ["0 Year", "1 Year", "3 Years", "5 Years", "10 Years"],
		    },
		    yAxis: {
		        title: {
		            text: ''
		        },
		        minorGridLineWidth: 0,
		        gridLineWidth: 0,
		        alternateGridColor: null,
		    },
		    tooltip: {
		        formatter: function() {
		            return '<b>'+ this.point.name +'</b><br/>'+
		            this.series.name +':<br/>'+
	                Highcharts.numberFormat(this.y, 2) +'%';
		        },
	            useHTML: true,
	            style: {
	                fontSize: '10px'
	            }
		    },
		    legend: {
		    	enabled: true,
		    	itemStyle: {
		    		fontSize: '10px',
		    		fontWeight: 'normal'
				},
		    },
		    credits:{
		    	enabled: false
		    },
		    plotOptions: {
		        spline: {
		            lineWidth: 4,
		            states: {
		                hover: {
		                    lineWidth: 5
		                }
		            },
		            marker: {
		                enabled: false
		            },
		            pointStart: 0
		        }
		    },
		    series: data_array,
		});
    }
}
</script>