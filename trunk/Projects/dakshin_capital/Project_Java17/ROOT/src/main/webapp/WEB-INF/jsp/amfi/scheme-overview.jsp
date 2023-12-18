<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
h3.textColor {
	font-size: 20px;
}
select.form-control {
	height: auto !important;
}
.padding17 {
	padding: 17px;
}
.marginTop20 {
	margin-top: 20px !important;
}
.btn-outline-primary, .btn-outline-primary:hover {
	border-color: #007bff !important;
	opacity: .65 !important;
}
.card-body p label {
	font-size: 13px;
}
.font13{
	font-size:13px;
}
#full_sector_data_table th{
	border-top: 0px;
}
#full_holdings_data_table th {
    border-top: 0px;
}
.font-size-18{
	font-size: 18px;
}
.textAlignLeft{
	text-align:left !important;
}
.btn-white-space {
	   white-space: normal !important;
}
.btn-schover{
	border-radius: 5px;
}

.table tr {
    -webkit-box-shadow: 0px -10px 22px 5px #f3f3f3;
    -moz-box-shadow: 0px -10px 22px 5px #f3f3f3;
    box-shadow: 0px -10px 22px 5px #f3f3f3;
}

</style>

<script>
$(document).ready(function() {

	var hashed = window.location.hash;
	if (hashed != "") {
		hashed = hashed.replace('#', '');
		setTimeout(
				function() {

					if (hashed
							.includes("fh5co-tab-feature2")) {
						tabChange(2);
					}
					if (hashed
							.includes("fh5co-tab-feature3")) {
						tabChange(3);
					}
					if (hashed
							.includes("fh5co-tab-feature-center2")) {
						returnsTabChange(2);
					}
					if (hashed
							.includes("fh5co-tab-feature-center3")) {
						returnsTabChange(3);
					}
				}, 500)
	}

$('#mf_fund_txt').typeahead({
source : function(query, process) {
	return $
			.ajax({
				url : '/mutual-funds-research/autoSuggestAllMfSchemes',
				type : 'post',
				data : {
					query : query,
				},
				dataType : 'json',
				success : function(
						result) {
					return process(result);
				}
			});
},
items : 10,
matcher : function(item) {
	return true;
}
});

$('#sip-submit').click(function(e) {

	var fund = $("#mf_fund_txt").val();

	if (fund == "") {
		swal({title:"",text:"Please type an Fund Name and select it from the autocomplete functionality. Then click on Submit."});
		return false;
	}
	
	if (fund.toLocaleLowerCase().indexOf("dividend") != -1 && fund.toLocaleLowerCase().indexOf("growth") == -1)
    {
 		swal({title:"",text:"Please enter the Growth scheme."});
   	    return false;
    }

	$.LoadingOverlay("show");

	var schemeName = encodeURIComponent(fund);

	$.ajaxSetup({
		async : false
	});
	$.post("/mutual-funds-research/isValidFundName",
	{
		fund : schemeName
	},
	function(data) {
		$.LoadingOverlay("hide");

		var result = $.trim(data);
		if (result == "true") {
			document.location = "/mutual-funds-research/"+ schemeName;
		} else {
			swal({title:"",text:"Please type an Fund Name and select it from the autocomplete functionality. Then click on Submit."});
			return false;
		}
	}, 'text');

	return false;
});

});
</script>

<script>
$(document).ready(function() {
	
			$('#txt_sipStartDate').datepicker({
				format : 'dd-mm-yyyy',
				autoclose : true,
				endDate : '-1d',
				disableTouchKeyboard : true
			}).on("changeDate", function(e) {
				calculateSIPReturns();
			});
			$('#txt_sipEndDate').datepicker({
				format : 'dd-mm-yyyy',
				autoclose : true,
				endDate : '-1d',
				disableTouchKeyboard : true
			}).on("changeDate", function(e) {
				calculateSIPReturns();
			});
			$('#txt_lumpsumtartDate').datepicker({
				format : 'dd-mm-yyyy',
				autoclose : true,
				endDate : '-1d',
				disableTouchKeyboard : true
			}).on("changeDate", function(e) {
				calculateLumpSumReturns();
			});
			$('#txt_rolling_returns_start_date').datepicker({
				format : 'dd-mm-yyyy',
				autoclose : true,
				endDate : '-1d',
				disableTouchKeyboard : true
			}).on("changeDate", function(e) {
				calculateRollingReturnsBefore();
			});
			$('#txt_sipStartDate_compare').datepicker({
				format : 'dd-mm-yyyy',
				autoclose : true,
				endDate : '-1d',
				disableTouchKeyboard : true
			}).on("changeDate", function(e) {
				calculateCompareSIPReturns();
			});
			$('#txt_sipEndDate_compare').datepicker({
				format : 'dd-mm-yyyy',
				autoclose : true,
				endDate : '-1d',
				disableTouchKeyboard : true
			}).on("changeDate", function(e) {
				calculateCompareSIPReturns();
			});
			$('#txt_lumpsumStartDate_compare').datepicker({
				format : 'dd-mm-yyyy',
				autoclose : true,
				endDate : '-1d',
				disableTouchKeyboard : true
			}).on("changeDate", function(e) {
				calculateCompareLumpSumReturns();
			});
			$('#txt_lumpsumEndDate_compare').datepicker({
				format : 'dd-mm-yyyy',
				autoclose : true,
				endDate : '-1d',
				disableTouchKeyboard : true
			}).on("changeDate", function(e) {
				calculateCompareLumpSumReturns();
			});

			$('[data-toggle="tooltip"]').tooltip();			

		});

	var nav = '${nav}';
	var fund = '${scheme}';
	var scheme_end_date = '<fmt:formatDate pattern="yyyy-MM-dd" value="${dateMap[1]}" />';
	var sip_start_date = '<fmt:formatDate pattern="yyyy-MM-dd" value="${dateMap[0]}" />';
	var lumpsum_start_date = '<fmt:formatDate pattern="yyyy-MM-dd" value="${dateMap[0]}" />';

	$(document).ready(function() {

		setTimeout(function() {
			calculateSIPReturns();
		}, 1000);

		setTimeout(function() {
			//getPeerComparisonResponseForFundOverview("returns_abs_1year");		
		}, 2000);

		setTimeout(function() {
			showPortfolioAnalysis();
		}, 3000);

	});

	function sectorAllocationClick()
	{
		var sector_text = $("#sector_anchor_span").html();	
		if(sector_text == "Show All Sectors")
		{
			$("#fullSectorAnchor").html('<span id="sector_anchor_span" class="paddingRight5">Hide All Sectors</span> <i class="fa fa-chevron-circle-up"></i>');
			$("#full_sector_data_table tr:gt(10)").show();
		}else{
			$("#fullSectorAnchor").html('<span id="sector_anchor_span" class="paddingRight5">Show All Sectors</span> <i class="fa fa-chevron-circle-down"></i>');
			$("#full_sector_data_table tr:gt(10)").hide();
		}
	}
	
	function holdingsAllocationClick()
	{
		var holdings_text = $("#holdings_anchor_span").html();	
		if(holdings_text == "Show All Holdings")
		{
			$("#fullHoldingsAnchor").html('<span id="holdings_anchor_span" class="paddingRight5">Hide All Holdings</span> <i class="fa fa-chevron-circle-up"></i>');
			$("#full_holdings_data_table tr:gt(10)").show();
		}else{
			$("#fullHoldingsAnchor").html('<span id="holdings_anchor_span" class="paddingRight5">Show All Holdings</span> <i class="fa fa-chevron-circle-down"></i>');
			$("#full_holdings_data_table tr:gt(10)").hide();
		}
	}

	function calculateSIPReturns() {
		var amount = $("#txt_sip_amount").val();
		var frequency = $("#txt_sipFreq").val();
		var startDate = $("#txt_sipStartDate").val();
		var endDate = $("#txt_sipEndDate").val();

		if (amount == "" || isNaN(amount)) {
			swal({title:"",text:"Please enter valid amount"});
			return;
		}
		if (startDate == "") {
			swal({title:"",text:"Please select start date"});
			return;
		}
		if (endDate == "") {
			swal({title:"",text:"Please select end date"});
			return;
		}
		var start_date_arr = startDate.split("-");
		var start_date_new = start_date_arr[2] + "-" + start_date_arr[1] + "-"
				+ start_date_arr[0];
		var end_date_arr = endDate.split("-");
		var end_date_new = end_date_arr[2] + "-" + end_date_arr[1] + "-"
				+ end_date_arr[0];

		var start_date = new Date(start_date_new);
		start_date.setHours(0, 0, 0, 0);
		var end_date = new Date(end_date_new);
		end_date.setHours(0, 0, 0, 0);

		if (start_date.getTime() >= end_date.getTime()) {
			swal({title:"",text:"End Date Should be greater than start date"});
			return;
		}
		$("#sip-gth-container").hide();
		$("#sip-gth-spinner").removeClass("hidden");

		var container_width = $("#sip-gth-div").width();
		container_width = container_width - 5;

		var scheme_benchmark = '${schemeMapping.scheme_benchmark}';
		var scheme_benchmark_code = '${schemeMapping.scheme_benchmark_code}';

		var fundArray = new Array();
		//fundArray.push(encodeURIComponent(fund) + '||true');
		fundArray.push(encodeURIComponent(fund) + '||false');
		if (scheme_benchmark != null && scheme_benchmark != ""
				&& scheme_benchmark_code != '') {
			fundArray.push(encodeURIComponent(scheme_benchmark_code)
					+ '||false');
		}

		var fundNameArray = new Array();
		fundNameArray.push(fund);
		if (scheme_benchmark != null && scheme_benchmark != ""
				&& scheme_benchmark_code != '') {
			fundNameArray.push(scheme_benchmark);
		}

		var str = "";
		str += '<table class="adv-table table table-striped table-bordered"><thead><tr>';
		str += '<th style="text-align:center;"></th>';
		str += '<th style="text-align:center;">Amount Invested</th>';
		str += '<th style="text-align:center;">Fund Value</th>';
		str += '<th style="text-align:center;">Profit</th>';
		str += '<th style="text-align:center;">Returns</th>';
		str += '</tr></thead><tbody>';

		$.ajaxSetup({
			async : false
		});
		$.post("/mutual-funds-research/getSIPReturnsTable", {
			scheme_amfi_name : "" + fundNameArray[0] + "",
			amount : "" + amount + "",
			frequency : "" + frequency + "",
			startDate : "" + startDate + "",
			endDate : "" + endDate + ""
		}, function(data) {
			var result = $.trim(data);
			var obj = jQuery.parseJSON(result);
			var current_cost = obj.current_cost;
			var current_value = obj.current_value;
			var returns = obj.returns;

			current_cost = Math.round(current_cost);
			current_value = Math.round(current_value);
			var profit = current_value - current_cost;
			profit = Math.round(profit);

			str += '<tr><td>Fund</td><td>' + current_cost.toLocaleString()
					+ '</td><td>' + current_value.toLocaleString()
					+ '</td><td>' + profit.toLocaleString() + '</td><td>'
					+ returns.toFixed(2) + '</td></tr>';

		}, 'text');

		if (scheme_benchmark != null && scheme_benchmark != ""
				&& scheme_benchmark_code != '') {
			$.ajaxSetup({
				async : false
			});
			$.post("/mutual-funds-research/getSIPReturnsTable", {
				scheme_amfi_name : "" + scheme_benchmark_code + "",
				amount : "" + amount + "",
				frequency : "" + frequency + "",
				startDate : "" + startDate + "",
				endDate : "" + endDate + ""
			}, function(data) {
				var result = $.trim(data);
				var obj = jQuery.parseJSON(result);
				var current_cost = obj.current_cost;
				var current_value = obj.current_value;
				var returns = obj.returns;

				current_cost = Math.round(current_cost);
				current_value = Math.round(current_value);
				var profit = current_value - current_cost;
				profit = Math.round(profit);

				str += '<tr><td>Benchmark</td><td>'
						+ current_cost.toLocaleString() + '</td><td>'
						+ current_value.toLocaleString() + '</td><td>'
						+ profit.toLocaleString() + '</td><td>'
						+ returns.toFixed(2) + '</td></tr>';

			}, 'text');
		} else {
			str += '<tr><td>Benchmark</td><td>-</td><td>-</td><td>-</td></tr>';
		}
		str += '</tbody></table>';
		$("#sip_returns_table_res").html(str);

		var seriesOptions = [], seriesCounter = 0, names = fundArray,

		// create the chart when all data is loaded
		createChart = function() {

			$('#sip-gth-container')
					.highcharts(
							'StockChart',
							{

								/* colors: ['#FE581E','#2B3292','#000000','#194d30','#8B0045','#ff0000','#804000','#000066','#00ff00','#0A9BF5','#999999','#3b0066'], */
								/* colors: ['#f59c1a', '#00acac', '#FF8900', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'], */
								colors : [ '#005e96', '#ee1c25', '#ffa200',
										'#e8ce1d', '#858688', '#1cb7eb',
										'#FF9655', '#1686b0', '#6AF9C4' ],

								rangeSelector : {
									enabled : false
								},
								navigator : {
									enabled : false
								},
								credits : {
									enabled : false
								},
								scrollbar : {
									enabled : false
								},
								xAxis : {
									gridLineColor : "#eee",
									gridLineWidth : 1,
									lineColor : "#eee",
									tickColor : "#eee"
								},
								yAxis : {
									gridLineColor : "#eee",
									gridLineWidth : 1,
									lineColor : "#eee",
									tickColor : "#eee"
								},
								plotOptions : {
									series : {
										connectNulls : true,
										dataGrouping : {
											enabled : false
										}
									}
								},
								legend : {
									enabled : true
								},
								tooltip : {
									pointFormat : '<span style="color:{series.color}">{series.name}</span>: {point.y}<br/>',
									valueDecimals : 2,
									xDateFormat : '%b %d, %Y'
								},
								series : seriesOptions,
								chart : {
									events : {
										load : function(event) {
											$("#sip-gth-spinner").addClass(
													"hidden");
											$("#sip-gth-container").show();
										}
									},
									width : container_width,
								/* backgroundColor: "#F1EDE2" */
								}
							});
		};

		$.each(names, function(i, name) {
			$.getJSON(
					'/mutual-funds-research/getSIPReturnsForFundOverview?scheme_amfi_name='
							+encodeURIComponent(name) + "&amount=" + amount + "&frequency="
							+ frequency + "&startDate=" + startDate
							+ "&endDate=" + endDate, function(values) {
						seriesOptions[i] = {
							name : fundNameArray[i],
							data : values
						};

						seriesCounter += 1;

						if (seriesCounter === names.length) {
							createChart();
						}
					});

		});

		Highcharts.setOptions({
			global : {
				useUTC : false,
			}
		});
	}

	function calculateLumpSumReturns() {
		var amount = $("#txt_lumpsum_amount").val();
		var startDate = $("#txt_lumpsumtartDate").val();
		var curDate = new Date();

		if (amount == "" || isNaN(amount)) {
			swal({title:"",text:"Please enter valid amount"});
			return;
		}
		if (startDate == "") {
			swal({title:"",text:"Please select start date"});
			return;
		}
		var start_date_arr = startDate.split("-");
		var start_date_new = start_date_arr[2] + "-" + start_date_arr[1] + "-"
				+ start_date_arr[0];

		var start_date = new Date(start_date_new);
		start_date.setHours(0, 0, 0, 0);
		curDate.setHours(0, 0, 0, 0);

		if (start_date.getTime() >= curDate.getTime()) {
			swal({title:"",text:"Start Date Should be less than current date"});
			return;
		}

		$("#lumpsum-gth-container").hide();
		$("#lumpsum-gth-spinner").removeClass("hidden");

		var container_width = $("#lumpsum-gth-div").width();
		container_width = container_width - 5

		var scheme_benchmark = '${schemeMapping.scheme_benchmark}';
		var scheme_benchmark_code = '${schemeMapping.scheme_benchmark_code}';

		var lumpsumArray = new Array();
		lumpsumArray.push(encodeURIComponent(fund));
		if (scheme_benchmark != null && scheme_benchmark != ""
				&& scheme_benchmark_code != '') {
			lumpsumArray.push(encodeURIComponent(scheme_benchmark_code));
		}

		var lumpsumNameArray = new Array();
		lumpsumNameArray.push(fund);
		if (scheme_benchmark != null && scheme_benchmark != ""
				&& scheme_benchmark_code != '') {
			lumpsumNameArray.push(scheme_benchmark);
		}

		var str = "";
		str += '<table class="adv-table table table-striped table-bordered"><thead><tr>';
		str += '<th style="text-align:center;"></th>';
		str += '<th style="text-align:center;">Amount Invested</th>';
		str += '<th style="text-align:center;">Fund Value</th>';
		str += '<th style="text-align:center;">Profit</th>';
		str += '<th style="text-align:center;">Returns</th>';
		str += '</tr></thead><tbody>';

		$.ajaxSetup({
			async : false
		});
		$.post("/mutual-funds-research/getLumpSumReturnsTable", {
			scheme_amfi_name : "" + lumpsumNameArray[0] + "",
			amount : "" + amount + "",
			startDate : "" + startDate + ""
		}, function(data) {
			var result = $.trim(data);
			var obj = jQuery.parseJSON(result);
			var current_cost = obj.current_cost;
			var current_value = obj.current_value;
			var returns = obj.returns;

			current_cost = Math.round(current_cost);
			current_value = Math.round(current_value);
			var profit = current_value - current_cost;
			profit = Math.round(profit);

			str += '<tr><td>Fund</td><td>' + current_cost.toLocaleString()
					+ '</td><td>' + current_value.toLocaleString()
					+ '</td><td>' + profit.toLocaleString() + '</td><td>'
					+ returns.toFixed(2) + '</td></tr>';

		}, 'text');

		if (scheme_benchmark != null && scheme_benchmark != ""
				&& scheme_benchmark_code != '') {
			$.ajaxSetup({
				async : false
			});
			$.post("/mutual-funds-research/getLumpSumReturnsTable", {
				scheme_amfi_name : "" + scheme_benchmark_code + "",
				amount : "" + amount + "",
				startDate : "" + startDate + ""
			}, function(data) {
				var result = $.trim(data);
				var obj = jQuery.parseJSON(result);
				var current_cost = obj.current_cost;
				var current_value = obj.current_value;
				var returns = obj.returns;

				current_cost = Math.round(current_cost);
				current_value = Math.round(current_value);
				var profit = current_value - current_cost;
				profit = Math.round(profit);

				str += '<tr><td>Benchmark</td><td>'
						+ current_cost.toLocaleString() + '</td><td>'
						+ current_value.toLocaleString() + '</td><td>'
						+ profit.toLocaleString() + '</td><td>'
						+ returns.toFixed(2) + '</td></tr>';

			}, 'text');
		} else {
			str += '<tr><td>Benchmark</td><td>-</td><td>-</td><td>-</td></tr>';
		}
		str += '</tbody></table>';
		$("#lumpsum_returns_table_res").html(str);

		var seriesOptions = [], seriesCounter = 0, names = lumpsumArray,

		// create the chart when all data is loaded
		createChart = function() {

			$('#lumpsum-gth-container')
					.highcharts(
							'StockChart',
							{

								/* colors: ['#FE581E','#2B3292','#000000','#194d30','#8B0045','#ff0000','#804000','#000066','#00ff00','#0A9BF5','#999999','#3b0066'], */
								/* colors: ['#f59c1a', '#00acac', '#FF8900', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'], */
								colors : [ '#005e96', '#ee1c25', '#ffa200',
										'#e8ce1d', '#858688', '#1cb7eb',
										'#FF9655', '#1686b0', '#6AF9C4' ],
								rangeSelector : {
									enabled : false
								},
								navigator : {
									enabled : false
								},
								credits : {
									enabled : false,
									text : "Advisorkhoj.com",
									href : "https://www.advisorkhoj.com/",
									style : {
										cursor : 'pointer',
										color : '#0000ff',
										fontSize : '10px'
									}
								},
								legend : {
									enabled : true
								},
								scrollbar : {
									enabled : false
								},
								xAxis : {
									gridLineColor : "#eee",
									gridLineWidth : 1,
									lineColor : "#eee",
									tickColor : "#eee"
								},
								yAxis : {
									gridLineColor : "#eee",
									gridLineWidth : 1,
									lineColor : "#eee",
									tickColor : "#eee"
								},
								plotOptions : {
									series : {
										connectNulls : true,
										dataGrouping : {
											enabled : false
										}
									}
								},

								tooltip : {
									pointFormat : '<span style="color:{series.color}">{series.name}</span>: {point.y}<br/>',
									valueDecimals : 2,
									xDateFormat : '%b %d, %Y'
								},

								series : seriesOptions,
								chart : {
									events : {
										load : function(event) {
											$("#lumpsum-gth-spinner").addClass(
													"hidden");
											$("#lumpsum-gth-container").show();
										}
									},
									width : container_width,
								/* backgroundColor: "#F1EDE2" */
								}
							});
		};

		$.each(names, function(i, name) {
			$.getJSON(
					'/mutual-funds-research/getLumpSumReturnsForFundOverview?scheme_amfi_name='
							+ name + "&amount=" + amount + "&startDate="
							+ startDate, function(values) {
						seriesOptions[i] = {
							name : lumpsumNameArray[i],
							data : values
						};

						seriesCounter += 1;

						if (seriesCounter === names.length) {
							createChart();
						}
					});

		});

		Highcharts.setOptions({
			global : {
				useUTC : false
			}
		});

	}

	var fundBenchArray = new Array();
	fundBenchArray.push(encodeURIComponent('${scheme}'));
	var scheme_benchmark = '${schemeMapping.scheme_benchmark}';
	var scheme_benchmark_code = '${schemeMapping.scheme_benchmark_code}';
	if (scheme_benchmark != null && scheme_benchmark != ""
			&& scheme_benchmark_code != '') {
		fundBenchArray.push(encodeURIComponent(scheme_benchmark_code));
	}

	var fundBenchNameArray = new Array();
	fundBenchNameArray.push('${scheme}');
	var scheme_benchmark = '${schemeMapping.scheme_benchmark}';
	if (scheme_benchmark != null && scheme_benchmark != ""
			&& scheme_benchmark_code != '') {
		fundBenchNameArray.push('${schemeMapping.scheme_benchmark}');
	}

	function getCompleteNavReport() {
		$("#nav-movement-gth-spinner").removeClass("hidden");

		var container_width = $("#nav-movement-gth-div").width();
		container_width = container_width - 5;

		var seriesOptions = [], seriesCounter = 0, names = fundBenchArray,
		// create the chart when all data is loaded
		createChart = function() {

			$('#nav-movement-container')
					.highcharts(
							'StockChart',
							{
								colors : [ '#005e96', '#ee1c25', '#ffa200',
										'#00a85b', '#858688', '#1cb7eb',
										'#FF9655', '#1686b0', '#6AF9C4' ],
								rangeSelector : {
									selected : 4
								},
								yAxis : {
									labels : {
										formatter : function() {
											return (this.value > 0 ? ' + ' : '')
													+ this.value + '%';
										}
									},
									plotLines : [ {
										value : 0,
										width : 2,
										color : 'silver'
									} ]
								},
								credits : {
									enabled : false,
									text : "Advisorkhoj.com",
									href : "https://www.advisorkhoj.com/",
									style : {
										cursor : 'pointer',
										color : '#0000ff',
										fontSize : '10px'
									}
								},
								legend : {
									enabled : true
								},
								plotOptions : {
									series : {
										compare : 'percent'
									}
								},
								tooltip : {
									pointFormat : '<span style="color:{series.color}">{series.name}</span>: {point.y} ({point.change}%)<br/>',
									valueDecimals : 2
								},
								chart : {
									width : container_width,
									/* backgroundColor: "#F1EDE2", */
									events : {
										load : function(event) {
											$("#nav-movement-gth-spinner")
													.addClass("hidden");
										}
									},
								},
								series : seriesOptions
							});
		};

		$.each(names, function(i, name) {

			$.getJSON(
					'/mutual-funds-research/getCompleteNavReportForFundOverview?scheme_amfi_name='
							+ name.toLowerCase(), function(data) {

						if (data == "" || data == null || data.length < 5) {
							data = [];
						}

						seriesOptions[i] = {
							name : fundBenchNameArray[i],
							data : data
						};

						// As we're loading the data asynchronously, we don't know what order it will arrive. So
						// we keep a counter and create the chart when all the data is loaded.
						seriesCounter += 1;

						if (seriesCounter === names.length) {
							createChart();
						}

					});
		});
	}

	function onPeerComparisonPeriodChange() {
		var val = $("#sel_peer_period").val();
		$('#tbl-peer').DataTable().destroy();
		getPeerComparisonResponseForFundOverview(val);
	}

	function getPeerComparisonResponseForFundOverview(period) {
		var dataSet = new Array();
		$.ajaxSetup({
			async : false
		});
		$
				.post(
						"/mutual-funds-research/getPeerComparisonResponseForFundOverview",
						{
							scheme_amfi : "" + fund + "",
							period : "" + period + ""
						},
						function(data) {
							var schemePerformances = $.trim(data);
							var schemePerformances_obj = jQuery
									.parseJSON(schemePerformances);
							var schemePerformances_array = $
									.makeArray(schemePerformances_obj);
							for (var i = 0; i < schemePerformances_array.length; i++) {
								var scheme_name = schemePerformances_array[i].scheme_amfi;
								var one_year_returns = schemePerformances_array[i].returns_abs_1year;
								var two_year_returns = schemePerformances_array[i].returns_cmp_2year;
								var three_year_returns = schemePerformances_array[i].returns_cmp_3year;
								var five_year_returns = schemePerformances_array[i].returns_cmp_5year;
								var ten_year_returns = schemePerformances_array[i].returns_cmp_10year;
								var inception_returns = schemePerformances_array[i].returns_cmp_inception;
								var inception_date = new Date(
										schemePerformances_array[i].inception_date);
								inception_date = inception_date
										.format("dd-mm-yyyy");

								one_year_returns = one_year_returns.toFixed(2);
								two_year_returns = two_year_returns.toFixed(2);
								three_year_returns = three_year_returns
										.toFixed(2);
								five_year_returns = five_year_returns
										.toFixed(2);
								ten_year_returns = ten_year_returns.toFixed(2);
								inception_returns = inception_returns
										.toFixed(2);

								if (one_year_returns == 0) {
									one_year_returns = "-";
								}
								if (two_year_returns == 0) {
									two_year_returns = "-";
								}
								if (three_year_returns == 0) {
									three_year_returns = "-";
								}
								if (five_year_returns == 0) {
									five_year_returns = "-";
								}
								if (ten_year_returns == 0) {
									ten_year_returns = "-";
								}
								if (inception_returns == 0) {
									inception_returns = "-";
								}

								var data_content = new Array();
								data_content
										.push("<a href='/mutual-funds-research/"
												+ encodeURIComponent(scheme_name)
												+ "'>" + scheme_name + "</a>");
								data_content.push(inception_date);
								data_content.push(one_year_returns);
								data_content.push(two_year_returns);
								data_content.push(three_year_returns);
								data_content.push(five_year_returns);
								data_content.push(ten_year_returns);
								dataSet.push(data_content);
							}
						}, 'text');

		$('#tbl-peer').dataTable({
			"data" : dataSet,
			"bPaginate" : false,
			"bFilter" : false,
			"bInfo" : false,
			"bSort" : false,
			"bAutoWidth" : false, // Disable the auto width calculation 
			"columnDefs" : [ {
				"sWidth" : "32%",
				"title" : "Scheme Name",
				"targets" : 0
			}, {
				"sWidth" : "6%",
				"title" : "Launch Date",
				"targets" : 1
			}, {
				"sWidth" : "6%",
				"title" : "1-Year Ret&nbsp;(%)",
				"targets" : 2
			}, {
				"sWidth" : "7%",
				"title" : "2-Yrs Ret&nbsp;(%)",
				"targets" : 3
			}, {
				"sWidth" : "6%",
				"title" : "3-Yrs Ret&nbsp;(%)",
				"targets" : 4
			}, {
				"sWidth" : "7%",
				"title" : "5-Yrs Ret&nbsp;(%)",
				"targets" : 5
			}, {
				"sWidth" : "8%",
				"title" : "10-Yrs Ret&nbsp;(%)",
				"targets" : 6
			} ],
		});

		$('#tbl-peer tr:first-child td').each(function() {
			$(this).css("background-image", "none");
			$(this).css("background-color", "#aaaaaa");
			$(this).css("color", "#fff");
		});

		$('#tbl-peer tr:first-child td a').each(function() {
			$(this).css("color", "#fff");
		});

		if (period == "returns_abs_1year") {
			$("#tbl-peer thead tr th:nth-child(3)").css("background-image",
					"none");
			$("#tbl-peer thead tr th:nth-child(3)").css("background-color",
					"#447cd5");
			$("#tbl-peer thead tr th:nth-child(3)").css("color", "#fff");
		} else {
			$("#tbl-peer thead tr th:nth-child(3)").css("background-color",
					"#fff");
			$("#tbl-peer thead tr th:nth-child(3)").css("color", "#333");
		}
		if (period == "returns_cmp_2year") {
			$("#tbl-peer thead tr th:nth-child(4)").css("background-image",
					"none");
			$("#tbl-peer thead tr th:nth-child(4)").css("background-color",
					"#447cd5");
			$("#tbl-peer thead tr th:nth-child(4)").css("color", "#fff");
		} else {
			$("#tbl-peer thead tr th:nth-child(4)").css("background-color",
					"#fff");
			$("#tbl-peer thead tr th:nth-child(4)").css("color", "#333");
		}
		if (period == "returns_cmp_3year") {
			$("#tbl-peer thead tr th:nth-child(5)").css("background-image",
					"none");
			$("#tbl-peer thead tr th:nth-child(5)").css("background-color",
					"#447cd5");
			$("#tbl-peer thead tr th:nth-child(5)").css("color", "#fff");
		} else {
			$("#tbl-peer thead tr th:nth-child(5)").css("background-color",
					"#fff");
			$("#tbl-peer thead tr th:nth-child(5)").css("color", "#333");
		}
		if (period == "returns_cmp_5year") {
			$("#tbl-peer thead tr th:nth-child(6)").css("background-image",
					"none");
			$("#tbl-peer thead tr th:nth-child(6)").css("background-color",
					"#447cd5");
			$("#tbl-peer thead tr th:nth-child(6)").css("color", "#fff");
		} else {
			$("#tbl-peer thead tr th:nth-child(6)").css("background-color",
					"#fff");
			$("#tbl-peer thead tr th:nth-child(6)").css("color", "#333");
		}
		if (period == "returns_cmp_10year") {
			$("#tbl-peer thead tr th:nth-child(7)").css("background-image",
					"none");
			$("#tbl-peer thead tr th:nth-child(7)").css("background-color",
					"#447cd5");
			$("#tbl-peer thead tr th:nth-child(7)").css("color", "#fff");
		} else {
			$("#tbl-peer thead tr th:nth-child(7)").css("background-color",
					"#fff");
			$("#tbl-peer thead tr th:nth-child(7)").css("color", "#333");
		}
	}

	$(document).ready(function() {
		$('#compare-hide').on('click', function() {
		});
	});

	function compareHide() {
		$("#div-compare-lumpsum").addClass("hidden");
		$("#div-compare-sip").addClass("hidden");
	}

	function compareSip() {
		$("#div-compare-lumpsum").addClass("hidden");
		$("#div-compare-sip").removeClass("hidden");
		calculateCompareSIPReturns();
	}

	function compareLumpsum() {
		$("#div-compare-lumpsum").removeClass("hidden");
		$("#div-compare-sip").addClass("hidden");
		calculateCompareLumpSumReturns();
	}

	function calculateCompareLumpSumReturns() {
		var amount = $("#txt_lumpsum_amount_compare").val();
		var startDate = $("#txt_lumpsumStartDate_compare").val();
		var endDate = $("#txt_lumpsumEndDate_compare").val();

		if (amount == "" || isNaN(amount)) {
			swal({title:"",text:"Please enter valid amount"});
			return;
		}
		if (startDate == "") {
			swal({title:"",text:"Please select start date"});
			return;
		}
		if (endDate == "") {
			swal({title:"",text:"Please select end date"});
			return;
		}
		var start_date_arr = startDate.split("-");
		var start_date_new = start_date_arr[2] + "-" + start_date_arr[1] + "-"
				+ start_date_arr[0];
		var end_date_arr = endDate.split("-");
		var end_date_new = end_date_arr[2] + "-" + end_date_arr[1] + "-"
				+ end_date_arr[0];

		var start_date = new Date(start_date_new);
		start_date.setHours(0, 0, 0, 0);
		var end_date = new Date(end_date_new);
		end_date.setHours(0, 0, 0, 0);
		var current_date = new Date();
		current_date.setHours(0, 0, 0, 0);

		if (start_date.getTime() >= current_date.getTime()) {
			swal({title:"",text:"Please select start date less then today date"});
			return;
		}
		if (end_date.getTime() >= current_date.getTime()) {
			swal({title:"",text:"Please select end date less then today date"});
			return;
		}
		if (end_date.getTime() <= start_date.getTime()) {
			swal({title:"",text:"Please select End Date Should be greater than start date"});
			return;
		}

		$("#lumpsum-compare-container").hide();
		$("#lumpsum-compare-spinner").removeClass("hidden");

		var data_arr = new Array();

		$('#tbl-peer tr td:first-child').each(function() {
			var scheme = $(this).text();
			var obj = {};
			obj.scheme = scheme;
			data_arr.push(obj);
		});

		var json_str = JSON.stringify(data_arr);

		$.ajaxSetup({
			async : true
		});
		$
				.post(
						"/mutual-funds-research/getLumpSumReturnsTable",
						{
							schemes : "" + json_str + "",
							amount : "" + amount + "",
							start_date : "" + startDate + "",
							end_date : "" + endDate + ""
						},
						function(data) {
							var response = $.trim(data);
							var response_obj = jQuery.parseJSON(response);
							var response_array = $.makeArray(response_obj);

							var master_html = "";
							master_html += "<div class='table-responsive'><table class='adv-table table table-striped table-bordered' style='text-align:left;'><thead>";
							master_html += "<tr>";
							master_html += "<th>Scheme Name</th>";
							master_html += "<th>Launch Date</th>";
							master_html += "<th>Amount Invested</th>";
							master_html += "<th>Fund Value</th>";
							master_html += "</tr></thead>";
							master_html += "<tbody>";

							for (var i = 0; i < response_array.length; i++) {
								var scheme = response_array[i].scheme;
								var inception = new Date(
										response_array[i].inception_date);
								var current_cost = response_array[i].current_cost;
								var current_value = response_array[i].current_value;

								master_html += "<tr>";
								master_html += "<td><a href='/mutual-funds-research/" + scheme + "'>"
										+ scheme + "</a></td>";
								master_html += "<td>"
										+ inception.format("dd-mm-yyyy")
										+ "</td>";
								master_html += "<td>"
										+ commaSeparateNumber(current_cost
												.toFixed(0)) + "</td>";
								master_html += "<td>"
										+ commaSeparateNumber(current_value
												.toFixed(0)) + "</td>";
								master_html += "</tr>";
							}

							master_html += "</tbody></table></div>";
							$("#lumpsum-compare-container").html(master_html);

							$("#lumpsum-compare-spinner").addClass("hidden");
							$("#lumpsum-compare-container").show();

							$('#lumpsum-compare-container tr:first-child td')
									.each(
											function() {
												$(this).css("background-image",
														"none");
												$(this).css("background-color",
														"#aaaaaa");
												$(this).css("color", "#fff");
											});

						}, 'text');

	}

	function calculateCompareSIPReturns() {
		var amount = $("#txt_sip_amount_compare").val();
		var frequency = $("#txt_sipFreq_compare").val();
		var startDate = $("#txt_sipStartDate_compare").val();
		var endDate = $("#txt_sipEndDate_compare").val();

		if (amount == "" || isNaN(amount)) {
			swal({title:"",text:"Please enter valid amount"});
			return;
		}
		if (startDate == "") {
			swal({title:"",text:"Please select start date"});
			return;
		}
		if (endDate == "") {
			swal({title:"",text:"Please select end date"});
			return;
		}

		var start_date_arr = startDate.split("-");
		var start_date_new = start_date_arr[2] + "-" + start_date_arr[1] + "-"
				+ start_date_arr[0];
		var end_date_arr = endDate.split("-");
		var end_date_new = end_date_arr[2] + "-" + end_date_arr[1] + "-"
				+ end_date_arr[0];

		var start_date = new Date(start_date_new);
		start_date.setHours(0, 0, 0, 0);
		var end_date = new Date(end_date_new);
		end_date.setHours(0, 0, 0, 0);
		var current_date = new Date();
		current_date.setHours(0, 0, 0, 0);

		if (start_date.getTime() >= current_date.getTime()) {
			swal({title:"",text:"Please select start date less then today date"});
			return;
		}
		if (end_date.getTime() >= current_date.getTime()) {
			swal({title:"",text:"Please select end date less then today date"});
			return;
		}
		if (end_date.getTime() <= start_date.getTime()) {
			swal({title:"",text:"Please select End Date Should be greater than start date"});
			return;
		}
		if (frequency == "Fortnightly") {
			start_date.setDate(start_date.getDate() + 15);
			if (end_date.getTime() <= start_date.getTime()) {
				swal({title:"",text:"Please select valid start date and end date"});
				return;
			}
		}
		if (frequency == "Monthly") {
			start_date.setMonth(start_date.getMonth() + 1);
			if (end_date.getTime() <= start_date.getTime()) {
				swal({title:"",text:"Please select valid start date and end date"});
				return;
			}
		}
		if (frequency == "Quarterly") {
			start_date.setMonth(start_date.getMonth() + 3);
			if (end_date.getTime() <= start_date.getTime()) {
				swal({title:"",text:"Please select valid start date and end date"});
				return;
			}
		}

		var data_arr = new Array();

		$('#tbl-peer tr td:first-child').each(function() {
			var scheme = $(this).text();
			var obj = {};
			obj.scheme = scheme;
			data_arr.push(obj);
		});

		var json_str = JSON.stringify(data_arr);

		$("#sip-compare-container").hide();
		$("#sip-compare-spinner").removeClass("hidden");

		$.ajaxSetup({
			async : true
		});
		$
				.post(
						"/mutual-funds-research/getSIPReturnsOverview",
						{
							schemes : "" + json_str + "",
							sip_amount : "" + amount + "",
							frequency : "" + frequency + "",
							start_date : "" + startDate + "",
							end_date : "" + endDate + "",
							maxno : "" + 10 + ""
						},
						function(data) {
							var response = $.trim(data);
							var response_obj = jQuery.parseJSON(response);
							var response_array = $.makeArray(response_obj);

							var master_html = "";
							master_html += "<div class='table-responsive'><table class='adv-table table table-striped table-bordered' style='text-align:left;'><thead>";
							master_html += "<tr>";
							master_html += "<th>Scheme Name</th>";
							master_html += "<th>Launch Date</th>";
							master_html += "<th>Amount Invested</th>";
							master_html += "<th>Fund Value</th>";
							master_html += "</tr></thead>";
							master_html += "<tbody>";

							for (var i = 0; i < response_array.length; i++) {
								var scheme = response_array[i].scheme;
								var inception = new Date(
										response_array[i].inception_date);
								var current_cost = response_array[i].current_cost;
								var current_value = response_array[i].current_value;

								master_html += "<tr>";
								master_html += "<td><a href='/mutual-funds-research/" + scheme + "'>"
										+ scheme + "</a></td>";
								master_html += "<td>"
										+ inception.format("dd-mm-yyyy")
										+ "</td>";
								master_html += "<td>"
										+ commaSeparateNumber(current_cost
												.toFixed(0)) + "</td>";
								master_html += "<td>"
										+ commaSeparateNumber(current_value
												.toFixed(0)) + "</td>";
								master_html += "</tr>";
							}

							master_html += "</tbody></table></div>";
							$("#sip-compare-container").html(master_html);

							$("#sip-compare-spinner").addClass("hidden");
							$("#sip-compare-container").show();

							$('#sip-compare-container tr:first-child td')
									.each(
											function() {
												$(this).css("background-image",
														"none");
												$(this).css("background-color",
														"#aaaaaa");
												$(this).css("color", "#fff");
											});

						}, 'text');

	}

	$(document)
			.ready(
					function() {

						$('#container-instrument-chart')
								.highcharts(
										{
											colors : [ '#005e96', '#ee1c25',
													'#ffa200', '#e8ce1d',
													'#858688', '#1cb7eb',
													'#FF9655', '#1686b0',
													'#6AF9C4' ],
											chart : {
												plotBackgroundColor : null,
												plotBorderWidth : null,
												plotShadow : false
											},
											title : {
												text : ''
											},
											credits : {
												enabled : true,
												text : "Advisorkhoj.com",
												href : "https://www.advisorkhoj.com/",
												style : {
													cursor : 'pointer',
													color : '#0000ff',
													fontSize : '10px'
												}
											},
											tooltip : {
												pointFormat : '{series.name}: {point.percentage:.1f}%'
											},
											plotOptions : {
												pie : {
													allowPointSelect : true,
													cursor : 'pointer',
													dataLabels : {
														enabled : true,
														format : '{point.name}: {point.percentage:.1f} %',
														style : {
															color : (Highcharts.theme && Highcharts.theme.contrastTextColor)
																	|| 'black'
														}
													}
												}
											},
											series : [ {
												type : 'pie',
												name : 'Browser share',
												data : [ <c:out escapeXml='false' value='${schemePortfolioAnalysisResponse.instrumentCategoryAllocationString}'/> ]
											} ]
										});

					});

	$(document)
			.ready(
					function() {

						$('#container-sector-chart')
								.highcharts(
										{
											colors : [ '#005e96', '#ee1c25',
													'#ffa200', '#e8ce1d',
													'#858688', '#1cb7eb',
													'#FF9655', '#1686b0',
													'#6AF9C4' ],
											chart : {
												plotBackgroundColor : null,
												plotBorderWidth : null,
												plotShadow : false
											},
											title : {
												text : ''
											},
											credits : {
												enabled : true,
												text : "Advisorkhoj.com",
												href : "https://www.advisorkhoj.com/",
												style : {
													cursor : 'pointer',
													color : '#0000ff',
													fontSize : '10px'
												}
											},
											tooltip : {
												pointFormat : '{series.name}: {point.percentage:.1f}%'
											},
											plotOptions : {
												pie : {
													allowPointSelect : true,
													cursor : 'pointer',
													dataLabels : {
														enabled : true,
														format : '{point.name}: {point.percentage:.1f} %',
														style : {
															color : (Highcharts.theme && Highcharts.theme.contrastTextColor)
																	|| 'black'
														}
													},
													point : {
														events : {
															click : function() {
																alert('Category: '
																		+ this.name
																		+ ', value: '
																		+ this.y);
															}
														}
													}
												}
											},
											series : [ {
												type : 'pie',
												name : 'Browser share',
												data : [ <c:out escapeXml='false' value='${schemePortfolioAnalysisResponse.sectorAllocationString}'/> ]
											} ]
										});

					});

	$(document).ready(
			function() {

				$('#tbl-sector').dataTable(
						{
							"iDisplayLength" : 5,
							"bInfo" : false,
							"bFilter" : false,
							"bLengthChange" : false,
							dom : "<'row'<'col-sm-6'l><'col-sm-6'f>>"
									+ "<'row'<'col-sm-12'tr>>"
									+ "<'row'<'col-sm-6'i><'col-sm-12'p>>",
							"footerCallback" : function(row, data, start, end,
									display) {
								var api = this.api(), data;

								// Remove the formatting to get integer data for summation
								var intVal = function(i) {
									return typeof i === 'string' ? i.replace(
											/[\$,]/g, '') * 1
											: typeof i === 'number' ? i : 0;
								};

								// Total over all pages
								total = api.column(1).data().reduce(
										function(a, b) {
											return intVal(a) + intVal(b);
										});

								// Total over this page
								pageTotal = api.column(1, {
									page : 'current'
								}).data().reduce(function(a, b) {
									return intVal(a) + intVal(b);
								}, 0);

								// Update footer
								$(api.column(1).footer()).html(
										' ' + pageTotal.toFixed(2) + ' ( '
												+ total.toFixed(2) + ' )');
							}
						});

			});

	var second_tab_loaded = false;
	var third_tab_loaded = false;
	
	function tabChange(val) 
	{
		if (val == 2 && second_tab_loaded == false) 
		{
			second_tab_loaded = true;
			setTimeout(function() 
			{
				yearlyPerformaceGraph();
			}, 1000);
		}
		if (val == 3 && third_tab_loaded == false) 
		{
			third_tab_loaded = true;
			setTimeout(function() 
			{
				getCompleteNavReport();
			}, 1000);
		}
	}

	var retuns_tab_loaded = false;
	var rolling_retuns_tab_loaded = false;
	function returnsTabChange(value) {
		if (value == 2) {
			if (retuns_tab_loaded == false) {
				retuns_tab_loaded = true;
				setTimeout(function() {
					calculateLumpSumReturns();
				}, 1000);

			}
		}
		if (value == 3) {
			if (rolling_retuns_tab_loaded == false) {
				rolling_retuns_tab_loaded = true;
				calculateRollingReturnsBefore();
			}
		}
	}
	function calculateRollingReturnsBefore() {
		setTimeout(function() {
			calculateRollingReturns();
		}, 500);
	}
	function calculateRollingReturns() {
		var startDate = $("#txt_rolling_returns_start_date").val();
		var period = $("#sel_rolling_returns_period").val();
		var category = '${schemeMapping.scheme_advisorkhoj_category}';

		if (startDate == null || startDate == "") {
			swal({title:"",text:"Please select rolling returns start date"});
			return false;
		}
		if (period == null || period == "" || isNaN(period) || period <= 0) {
			swal({title:"",text:"Please select rolling returns period"});
			return false;
		}
		period = parseInt(period);

		var date_arr = startDate.split("-");
		var start_date_str = date_arr[2] + "-" + date_arr[1] + "-"
				+ date_arr[0];

		var start_date = new Date(start_date_str);
		start_date.setHours(0, 0, 0, 0);
		var increased_year = start_date.getFullYear() + period;
		start_date.setFullYear(increased_year);
		var current_date = new Date();
		current_date.setHours(0, 0, 0, 0);

		if (start_date.getTime() >= current_date.getTime()) {
			swal({title:"",text:"Please select start date and period less then today date"});
			return;
		}
		var scheme = fund;
		var schemeName = encodeURIComponent(scheme);

		$('#rolling-returns-container').hide();
		$("#rolling-returns-spinner").removeClass("hidden");

		var master_array = new Array();
		/* var colors = ['#FE581E','#FFD700','#00BFFF','#FFB6C1','#999999','#804000','#000066','#00ff00','#0A9BF5','#999999','#3b0066']; */
		/* var colors = ['#f59c1a', '#00acac', '#FF8900', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']; */
		var colors = [ '#005e96', '#ee1c25', '#ffa200', '#e8ce1d', '#858688',
				'#1cb7eb', '#FF9655', '#1686b0', '#6AF9C4' ];

		$.ajaxSetup({
			async : false
		});
		$
				.post(
						"/mutual-funds-research/getRollingReturns",
						{
							schemes : "" + schemeName + "",
							category : "" + category + "",
							start_date : "" + startDate + "",
							period : "" + period + ""
						},
						function(data) {
							var result = $.trim(data);
							if (result == null || result == "null" || result == "") {
								swal({title:"",text:"Oops something wrong. Please try again later."});
								return false;
							}
							var obj = jQuery.parseJSON(result);
							var list_array = $.makeArray(obj);

							for (var k = 0; k < list_array.length; k++) {
								var data_obj = list_array[k];
								var data_array = $.makeArray(data_obj);
								var scheme_data = new Array();

								for (var m = 0; m < data_array.length; m++) {
									var nav_date = data_array[m].nav_date;
									nav_date = new Date(nav_date).getTime();
									var scheme_rolling_returns = data_array[m].scheme_rolling_returns;

									if (scheme_rolling_returns != null
											&& scheme_rolling_returns != "") {
										var scheme_arr = new Array();
										scheme_arr.push(nav_date);
										scheme_arr.push(scheme_rolling_returns);
										scheme_data.push(scheme_arr);
									}
								}

								if (scheme_data.length > 0) {
									var scheme = data_array[0].scheme_name;
									var scheme_category = data_array[0].scheme_category;
									var color_name = "";
									if (scheme_category == "") {
										color_name = "#00acac";
									} else {
										color_name = colors[k];
									}
									var obj = {
										name : scheme,
										data : scheme_data,
										color : color_name
									};
									master_array.push(obj);
								}
							}

						}, 'text');

		var container_width = $("#rolling-returns-gth-div").width();
		container_width = container_width - 5;

		$('#rolling-returns-container')
				.highcharts(
						'StockChart',
						{

							rangeSelector : {
								enabled : false
							},
							navigator : {
								enabled : false
							},
							credits : {
								enabled : false
							},
							scrollbar : {
								enabled : false
							},
							xAxis : {
								type : 'datetime',
								labels : {
									formatter : function() {
										var monthStr = Highcharts.dateFormat(
												'%b %Y', this.value);
										var values = monthStr.split(' ');
										if (values.length > 1) {
											var add_value = parseInt(values[1])
													+ period;
											if (add_value.length == 1) {
												add_value = "0" + add_value;
											}
											return monthStr + "<br>to<br>"
													+ values[0] + " "
													+ add_value;
										} else {
											return values;
										}
									}
								}
							},
							yAxis : {
								labels : {
									formatter : function() {
										return this.value + '%';
									}
								}
							},
							plotOptions : {
								series : {
									connectNulls : true,
									dataGrouping : {
										enabled : false
									}
								}
							},
							legend : {
								enabled : true
							},
							tooltip : {
								formatter : function() {
									var dateMonthStr = Highcharts.dateFormat(
											'%b %d', new Date(this.x));
									var yearStr = Highcharts.dateFormat('%Y',
											new Date(this.x));
									var year_int = parseInt(yearStr)
											+ parseInt(period);
									var str = Highcharts.dateFormat(
											'%b %d, %Y', new Date(this.x))
											+ ' - '
											+ dateMonthStr
											+ ', '
											+ year_int + '<br/>'
									$
											.each(
													this.points,
													function(i, point) {
														str += '<span style="color: ' + point.series.color + '">'
																+ point.series.name
																+ ':</span>'
																+ Highcharts
																		.numberFormat(
																				point.y,
																				2)
																+ '%<br/>';
													});
									return str;
								}
							},
							series : master_array,
							chart : {
								events : {
									load : function(event) {
										$("#rolling-returns-spinner").addClass(
												"hidden");
										$("#rolling-returns-container").show();
									}
								},
								width : container_width,
							/* backgroundColor: "#F1EDE2" */
							}
						});
	}

	/* Yearly Performance Graph */
	function yearlyPerformaceGraph() 
	{
		$("#yearly-performance-gth-spinner").removeClass("hidden");

		var current_year = new Date().getFullYear();
		var year_array = new Array();
		year_array.push(current_year-4);
		year_array.push(current_year-3);
		year_array.push(current_year-2);
		year_array.push(current_year-1);
		year_array.push(current_year);

		var data_array = new Array();
		var fund_obj = {
			name : '<c:out escapeXml="false" value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.scheme_amfi}"/>',
			color : '#3a4692',
			data : [
					parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_abs_2012}"/>'),
					parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_abs_2013}"/>'),
					parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_abs_2014}"/>'),
					parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_abs_2015}"/>'),
					parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_abs_ytd}"/>') ]
		};
		data_array.push(fund_obj);

		var scheme_benchmark = '${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark}';
		if (scheme_benchmark != null && scheme_benchmark != "") {
			var benchmark_obj = {
				name : '<c:out escapeXml="false" value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.benchmark_name}"/>',
				color : '#ec3237',
				data : [
						parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_abs_2012}"/>'),
						parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_abs_2013}"/>'),
						parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_abs_2014}"/>'),
						parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_abs_2015}"/>'),
						parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_abs_ytd}"/>') ]
			};
			data_array.push(benchmark_obj);
		}

		var category_obj = {
			name : '<c:out escapeXml="false" value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.sector}"/>',
			color : '#f58634',
			data : [
					parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_abs_2012}"/>'),
					parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_abs_2013}"/>'),
					parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_abs_2014}"/>'),
					parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_abs_2015}"/>'),
					parseFloat('<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_abs_ytd}"/>') ]
		};
		data_array.push(category_obj);

		var container_width = $("#yearly-performance-gth-div").width();
		container_width = container_width - 5;

		$('#yearly-performance-container').highcharts(
				{
					colors : [ '#005e96', '#ee1c25', '#ffa200', '#e8ce1d',
							'#858688', '#1cb7eb', '#FF9655', '#1686b0',
							'#6AF9C4' ],
					chart : {
						type : 'column',
						width : container_width,
						/* backgroundColor: "#F1EDE2", */
						events : {
							load : function(event) {
								$("#yearly-performance-gth-spinner").addClass(
										"hidden");
							}
						},
					},
					title : {
						text : ''
					},
					legend : {
						enabled : true
					},
					xAxis : {
						categories : year_array
					},
					credits : {
						enabled : false,
						text : "Advisorkhoj.com",
						href : "https://www.advisorkhoj.com/",
						style : {
							cursor : 'pointer',
							color : '#0000ff',
							fontSize : '10px'
						}
					},
					series : data_array
				});
	}

	function commaSeparateNumber(x) {
		x = x.toString();
		var afterPoint = '';
		if (x.indexOf('.') > 0)
			afterPoint = x.substring(x.indexOf('.'), x.length);
		x = Math.floor(x);
		x = x.toString();
		var lastThree = x.substring(x.length - 3);
		var otherNumbers = x.substring(0, x.length - 3);
		if (otherNumbers != '')
			lastThree = ',' + lastThree;
		var res = otherNumbers.replace(/\B(?=(\d{2})+(?!\d))/g, ",")
				+ lastThree + afterPoint;
		return res;
	}
	function showPortfolioAnalysis() {
		$("#asset-gth-spinner").show();
		$("#portfolio-gth-spinner").show();

		$("#fullSector").addClass("in");
		$("#fullHoldings").addClass("in");

		var scheme_amfi = '${scheme}';

		var container_width = $("#asset_allocation_div").width();
		container_width = container_width - 5;

		$.ajaxSetup({
			async : false
		});
		$
				.post(
						"/mutual-funds-research/getPortfolioAnalysis",
						{
							scheme_amfi : scheme_amfi
						},
						function(data) {
							var result = $.trim(data);
							var obj = jQuery.parseJSON(result);
							var schemePortfolioAnalysisResponse = obj.schemePortfolioAnalysisResponse;
							var schemePortfolioList_array = $
									.makeArray(schemePortfolioAnalysisResponse.schemePortfolioList);
							var sectorAllocationMap = schemePortfolioAnalysisResponse.sectorAllocationMap;
							var assetAllocationMap = schemePortfolioAnalysisResponse.assetAllocationMap;

							/* schemeAssets */
							if (assetAllocationMap != null
									&& assetAllocationMap != undefined
									&& assetAllocationMap != "") {
								var main_arr = new Array();
								for ( var key in assetAllocationMap) {
									var value = assetAllocationMap[key];
									var obj = {
										name : key,
										y : value,
									};
									main_arr.push(obj);
								}

								if (main_arr.length == 0 || main_arr == "0") {
									$("#asset-gth-spinner").hide();
									$('#asset-allocation-container')
											.html(
													"Asset allocation Not Available");
									//$("#portfolio-gth-spinner").hide();
									$('#portfolio-gth-spinner')
											.html(
													"Portfolio Analysis Not Available");
									return false;
								}

								$('#asset-allocation-container')
										.highcharts(
												{
													colors : [ '#005e96',
															'#ee1c25',
															'#ffa200',
															'#e8ce1d',
															'#8B0045',
															'#ff0000',
															'#804000',
															'#000066',
															'#00ff00',
															'#FE581E',
															'#999999',
															'#3b0066' ],
													chart : {
														type : 'bar',
														width : container_width,
														backgroundColor : "#fff"
													},
													title : {
														text : ''
													},
													subtitle : {
														text : ''
													},
													xAxis : {
														type : 'category',
														gridLineColor : "#eee",
														gridLineWidth : 1,
														lineColor : "#eee",
														tickColor : "#eee",
														labels : {
															align : 'left',
															x : 5
														}
													},
													yAxis : {
														gridLineColor : "#eee",
														gridLineWidth : 1,
														lineColor : "#eee",
														tickColor : "#eee"
													},
													credits : {
														enabled : false,
													},
													legend : {
														enabled : false
													},
													plotOptions : {
														series : {
															dataLabels : {
																enabled : true,
																align : 'left',
																y : 20,
																format : '{point.y:.1f}%'
															}
														},
														pointPadding : 0,
														groupPadding : 0,
													},
													tooltip : {
														pointFormat : '{point.y:.2f}%'
													},
													series : [ {
														data : main_arr
													} ],
												});

								$("#asset-gth-spinner").hide();
							} else {
								$("#asset-gth-spinner").hide();
								$('#asset-allocation-container')
										.html(
												"Asset allocation Not Available");
							}

							if (sectorAllocationMap == null
									|| sectorAllocationMap == undefined
									|| sectorAllocationMap == ""
									|| schemePortfolioList_array == null
									|| schemePortfolioList_array == undefined
									|| schemePortfolioList_array.length == 0) {
								//$("#portfolio-gth-spinner").hide();
								$('#portfolio-gth-spinner')
										.html(
												"Portfolio Analysis Not Available");
								return false;
							}

							/* Sectors */
							var sector_data = "";
							sector_data +='<table class="table table-striped tbl" id="full_sector_data_table"><thead><tr><th colspan="2" class="textAlignLeft textColor">Sector Allocation</th></tr></thead><tbody><tr><td>Sector</td><td>Allocation (%)</td></tr>';
							for(var key in sectorAllocationMap) {
							    var value = sectorAllocationMap[key];
							    sector_data +='<tr><td>'+key+'</td><td>'+value+'</td></tr>';
							}
							sector_data +='</tbody></table>';
							$("#full_sector_data").html(sector_data);
					        
							/* Holdings */
					        var holdings_data = "";
					        holdings_data +='<table class="table table-striped tbl" id="full_holdings_data_table"><thead><tr><th colspan="2" class="textAlignLeft textColor">Portfolio Holdings</th></tr></thead><tbody><tr><td>Portfolio</td><td>Holdings (%)</td></tr>';
					        for (var i = 0; i < schemePortfolioList_array.length ; i++)
						    {
								var company_name = schemePortfolioList_array[i].instrument;
								var holdings = schemePortfolioList_array[i].holdings;
								holdings_data +='<tr><td>'+company_name+'</td><td>'+holdings+'</td></tr>';
						    }
					        holdings_data +='</tbody></table>';          
							$("#full_holdings_data").html(holdings_data);
							
							var from = schemePortfolioList_array[0].portfolio_date.split("-");
							var portfolio_date = new Date(from[2], from[1] - 1, from[0]);
							
							/* var portfolio_date = new Date(
									schemePortfolioList_array[0].portfolio_date); */
							portfolio_date = portfolio_date
									.format("dd-mm-yyyy");
							$("#portfolio_date_txt").html(portfolio_date);
							$("#portfolio_date_div").show();

							var sector_names_array = $
									.makeArray(schemePortfolioAnalysisResponse.sectorNamesString);
							var sector_value_string = $
									.makeArray(schemePortfolioAnalysisResponse.sectorAllocationMorrisString);
							var total_sector = 0;
							var sector_value_array = new Array();

							for (var i = 0; i < (sector_value_string.length - 1); i++) {
								var sector_name = sector_names_array[i];
								var sector_value = parseFloat(sector_value_string[i]);
								total_sector = total_sector + sector_value;
								var arr = new Array();
								arr.push(sector_name);
								arr.push(sector_value);
								sector_value_array.push(arr);
							}
							if (total_sector < 100) {
								var sector_others = 100 - total_sector;
								var arr = new Array();
								arr.push("Others");
								arr.push(sector_others);
								sector_value_array.push(arr);
							}

							/* Sector Allocation Graph */
							$('#sector-allocation-container')
									.highcharts(
											{
												colors : [ '#005e96',
														'#ee1c25', '#ffa200',
														'#e8ce1d', '#858688',
														'#1cb7eb', '#FF9655',
														'#1686b0', '#6AF9C4' ],
												chart : {
													plotBackgroundColor : null,
													plotBorderWidth : null,
													plotShadow : false
												},
												title : {
													text : ''
												},
												tooltip : {
													pointFormat : '{point.percentage:.2f}%'
												},
												credits : {
													enabled : false,
													text : "Advisorkhoj.com",
													href : "https://www.advisorkhoj.com/",
													style : {
														cursor : 'pointer',
														color : '#0000ff',
														fontSize : '10px'
													}
												},
												plotOptions : {
													pie : {
														allowPointSelect : true,
														cursor : 'pointer',
														dataLabels : {
															enabled : false
														}
													}
												},
												series : [ {
													type : 'pie',
													data : sector_value_array
												} ]
											});

							var holding_name_array = $
									.makeArray(schemePortfolioAnalysisResponse.schemePortfolioHoldingsNamesString);
							var holding_value_string = $
									.makeArray(schemePortfolioAnalysisResponse.schemePortfolioHoldingsValuesString);
							var total_holdings = 0;
							var holding_value_array = new Array();

							for (var i = 0; i < (holding_value_string.length - 1); i++) {
								var holdings_name = holding_name_array[i];
								var holdings_value = parseFloat(holding_value_string[i]);
								total_holdings = total_holdings
										+ holdings_value;
								var arr = new Array();
								arr.push(holdings_name);
								arr.push(holdings_value);
								holding_value_array.push(arr);
							}
							if (total_holdings < 100) {
								var holding_others = 100 - total_holdings;
								var arr = new Array();
								arr.push("Others");
								arr.push(holding_others);
								holding_value_array.push(arr);
							}

							/* Holdings Allocation Graph */
							$('#holdings-allocation-container')
									.highcharts(
											{
												colors : [ '#005e96',
														'#ee1c25', '#ffa200',
														'#e8ce1d', '#858688',
														'#1cb7eb', '#FF9655',
														'#1686b0', '#6AF9C4' ],
												chart : {
													plotBackgroundColor : null,
													plotBorderWidth : null,
													plotShadow : false
												},
												title : {
													text : ''
												},
												tooltip : {
													pointFormat : '{point.percentage:.2f}%'
												},
												credits : {
													enabled : false,
													text : "Advisorkhoj.com",
													href : "https://www.advisorkhoj.com/",
													style : {
														cursor : 'pointer',
														color : '#0000ff',
														fontSize : '10px'
													}
												},
												plotOptions : {
													pie : {
														allowPointSelect : true,
														cursor : 'pointer',
														dataLabels : {
															enabled : false
														}
													}
												},
												series : [ {
													type : 'pie',
													data : holding_value_array
												} ]
											});

							$("#portfolio-gth-spinner").hide();
							$("#top_10_sectors").show();
							$("#top_10_stocks").show();
							$("#fullSector").show();
							$("#fullHoldings").show();

							$("#full_sector_data_table tr:gt(10)").hide();
							$("#full_holdings_data_table tr:gt(10)").hide();

						}, 'text');
	}

	function compareSip() {
		$("#div-compare-lumpsum").addClass("hidden");
		$("#div-compare-sip").removeClass("hidden");
		calculateCompareSIPReturns();
	}

	function compareLumpsum() {
		$("#div-compare-lumpsum").removeClass("hidden");
		$("#div-compare-sip").addClass("hidden");
		calculateCompareLumpSumReturns();
	}
</script>


<!-- Page Content -->
<div class="container-fluid pt-4">
	<div class="container">
		<div class="row">
			<div class="col-lg-6 pl-0">
				<h3 class="textColor pb-2 pl-0">
					<c:out value="${scheme}" />
				</h3>
			</div>
			<div class="col-lg-6 text-right" id="mf_fund_txt_div">	
			<div class="row">
				<div class="col-md-10">
					<input id="mf_fund_txt" type="text" class="form-control no-radius" placeholder="Search for another scheme">
				</div>
				<div class="col-md-2 paddingBottom20 text-right">
					<a href="#" id="sip-submit" class="btn btn-primary hidden-xs btn-schover" data-style="expand-right" data-size="l">Submit</a>
				</div>
			</div>
		</div>
		</div>
		<div class="row scheme-overview-box">

			<div class="col-lg-4 pr-2">
				<div class="card fundNamebg LfCard border-0 pl-3">
					<div class="card-body" style="min-height: 236px; line-height: 2;">
						<p>
							<label class="textColor font-600">Category: </label> <label> <c:out
									value="${schemeMapping.scheme_advisorkhoj_category}" /></label>
						</p>
						<p>
							<label class="textColor font-600">Launch Date: </label> <label> <fmt:formatDate
									pattern="dd-MM-yyyy"
									value="${schemeMapping.scheme_inception_date}" /></label>
						</p>
						<p>
							<label class="textColor font-600">Asset Class: </label> <label> <c:out
									value="${schemeMapping.asset_class}" /></label>
						</p>
						<p>
							<label class="textColor font-600">Benchmark: </label> <label> <c:choose>
									<c:when test="${not empty schemeMapping.scheme_benchmark}">
										<c:out value="${schemeMapping.scheme_benchmark}" />
									</c:when>
									<c:otherwise>
         		Not Available
        	</c:otherwise>
								</c:choose>
							</label>
						</p>
						<p>
							<label class="textColor font-600">Expense Ratio: </label> <label>
								<c:out value="${schemeMapping.ter}" />% As on (<fmt:parseDate
									value="${schemeMapping.ter_date}" var="parsedEmpDate"
									pattern="yyyy-MM-dd" />
								<fmt:formatDate pattern="dd-MM-yyyy" value="${parsedEmpDate}" />)
							</label>
						</p>

					</div>

				</div>
			</div>
			<div class="col-lg-4 px-0 margin-mobile20">
				<div class="card fundNamebg border-0 rounded-0">
					<div class="card-body" style="min-height: 236px; line-height: 2;">
						<p>
							<label class="textColor font-600">Status: </label> <label> <c:choose>
									<c:when
										test="${fn:contains(schemeMapping.open_or_closed, 'Open Ended Schemes')}"> Open Ended</c:when>
									<c:when
										test="${fn:contains(schemeMapping.open_or_closed, 'Close Ended Schemes')}"> Close Ended</c:when>
									<c:when
										test="${fn:contains(schemeMapping.open_or_closed, 'Interval Fund Schemes')}"> Interval Fund</c:when>
									<c:otherwise></c:otherwise>
								</c:choose> 
							</label>
						</p>
						<p>
							<label class="textColor font-600">Minimum Investment: </label> <label>
								<c:out value="${schemeMapping.minimum}" />
							</label>
						</p>
						<p>
							<label class="textColor font-600">Minimum Topup: </label> <label>
								<c:out value="${schemeMapping.minimum_topup}" />
							</label>
						</p>
						<p>
							<label class="textColor font-600">Total Assets: </label> <label> <fmt:formatNumber
									type="number" maxFractionDigits="2"
									value="${schemeMapping.scheme_assets / 10}" /> Cr As on (<fmt:parseDate
									value="${schemeMapping.scheme_asset_date}" var="parsedEmpDate"
									pattern="yyyy-MM-dd" />
								<fmt:formatDate pattern="dd-MM-yyyy" value="${parsedEmpDate}" />)
							</label>
						</p>
						<p>
							<label class="textColor font-600">Turn over: </label> <label> <c:out
									value="${schemeMapping.portfolio_turnover_ratio}" /></label>
						</p>


					</div>

				</div>
			</div>
			<div class="col-lg-4 px-0 margin-mobile20">
				<div class="row" style="margin:0px;">
				<div class="col-6 py-4 pl-0">
					<h5 class="text-center textColor">NAV</h5>
					<div class="card body-color bdrcolorInv" style="border: none;">

						<div class="card-body text-center">
							<h4 class="font-size-18"><i class="fa fa-inr" aria-hidden="true"></i><c:out value="${schemePerformances.price}" /></h4>
							<c:choose>
								<c:when test="${schemePerformances.price_change_onday < 0}">
									<h4 class="text-danger font-size-18"><i class="fa fa-angle-down textColor" aria-hidden="true"></i>
										<fmt:formatNumber type="number" maxFractionDigits="2" value="${schemePerformances.price_change_onday}" />
										(<c:out value="${schemePerformances.price_change_percent_onday}" /> %)
									</h4>
								</c:when>
								<c:otherwise>
									<h4 class="text-success font-size-18"><i class="fa fa-angle-up textColor" aria-hidden="true"></i>
										<fmt:formatNumber type="number" maxFractionDigits="2" value="${schemePerformances.price_change_onday}" />
										(<c:out value="${schemePerformances.price_change_percent_onday}" /> %)
									</h4>
								</c:otherwise>
							</c:choose>
							<h4 class="font-size-18"><fmt:formatDate pattern="dd-MM-yyyy" value="${schemePerformances.price_date}" /></h4>
						</div>
					</div>
				</div>
				
				<div class="col-6 py-4 pl-0">
				<h5 class="text-center textColor">CAGR Since Inception</h5>
				<div class="card body-color bdrcolorInv" style="border: none;">

					<div class="card-body text-center">
						<c:choose>
							<c:when test="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_inception < 0}">
								<h4 class="text-danger font-size-18">
									<i class="fa fa-angle-down textColor" aria-hidden="true"></i>
									<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_inception}" /> %
								</h4>
							</c:when>
							<c:otherwise>
								<h4 class="text-success font-size-18">
									<i class="fa fa-angle-up textColor" aria-hidden="true"></i>
									<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_inception}" /> %
								</h4>
							</c:otherwise>
						</c:choose>

						<c:if test="${not empty schemeMapping.scheme_benchmark && not empty fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_inception}">
							<h4 class="font-size-18"><c:out value="${schemeMapping.scheme_benchmark}" /></h4>
							<c:choose>
								<c:when test="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_inception < 0}">
									<h4 class="text-danger font-size-18">
										<i class="fa fa-angle-down textColor" aria-hidden="true"></i>
										<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_inception}" /> %
									</h4>
								</c:when>
								<c:otherwise>
									<h4 class="text-success font-size-18">
										<i class="fa fa-angle-up textColor" aria-hidden="true"></i>
										<c:out value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_inception}" /> %
									</h4>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>

				</div>
			</div>
			</div>
			</div>
			
			
		</div>

		<div class="row scheme-overview-box mt-5 pt-4 pb-5">

			<div class="col-lg-8 navtb">
				<h4 class="textColor">PERFORMANCE of ${scheme}</h4>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li class="nav-item"><a class="nav-link active text-dark" data-toggle="tab" href="#performance_menu1">Scheme Performance</a></li>
					<li class="nav-item"><a class="nav-link text-dark" data-toggle="tab" href="#performance_menu2"	onclick="tabChange(2)">Yearly Performance</a></li>
					<li class="nav-item"><a class="nav-link text-dark" data-toggle="tab" href="#performance_menu3" onclick="tabChange(3)">NAV Movement</a></li>
				</ul>

				<!-- Tab panes -->
				<div class="tab-content">
					<div id="performance_menu1" class="container tab-pane active">
						<br>
						<h4 class="textColor">Scheme Performance (%)</h4>
						<div class="p-2 table-bdr-radius table-bg table-responsive">
							<table class="table mb-0 table-bg">

								<thead>
									<tr>
										<th></th>
										<th>1-Year Ret&nbsp;(%)</th>
										<th>3-Yrs Ret&nbsp;(%)</th>
										<th>5-Yrs Ret&nbsp;(%)</th>
										<th>10-Yrs Ret&nbsp;(%)</th>
										<th>Since Launch Ret&nbsp;(%)</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><c:out escapeXml="false"
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.scheme_amfi}" /></td>
										<td><c:out
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_abs_1year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_abs_1year}" /></td>
										<td><c:out
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_3year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_3year}" /></td>
										<td><c:out
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_5year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_5year}" /></td>
										<td><c:out
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_10year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_10year}" /></td>
										<td><c:out
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_inception eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformances.returns_cmp_inception}" /></td>
									</tr>
									<tr>
										<c:choose>
											<c:when
												test="${not empty fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.benchmark_name && not empty schemeMapping.scheme_benchmark_code}">
												<td><c:out escapeXml="false"
														value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.benchmark_name}" /></td>
												<td><c:out
														value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_abs_1year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_abs_1year}" /></td>
												<td><c:out
														value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_3year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_3year}" /></td>
												<td><c:out
														value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_5year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_5year}" /></td>
												<td><c:out
														value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_10year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_10year}" /></td>
												<td><c:out
														value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_inception eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesBenchmark.returns_cmp_inception}" /></td>
											</c:when>
											<c:otherwise>
												<td>Benchmark</td>
												<td>-</td>
												<td>-</td>
												<td>-</td>
												<td>-</td>
												<td>-</td>
											</c:otherwise>
										</c:choose>

									</tr>
									<tr>
										<td><c:out escapeXml="false"
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.sector}" /></td>
										<td><c:out
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_abs_1year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_abs_1year}" /></td>
										<td><c:out
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_cmp_3year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_cmp_3year}" /></td>
										<td><c:out
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_cmp_5year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_cmp_5year}" /></td>
										<td><c:out
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_cmp_10year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_cmp_10year}" /></td>
										<td><c:out
												value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_cmp_inception eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.returns_cmp_inception}" /></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div id="performance_menu2" class="container tab-pane">
						<br>
						<h4 class="textColor">Yearly Performance (%)</h4>
						<div id="yearly-performance-gth-div">
							<div id="yearly-performance-container" style="min-width: 250px; height: 275px;" class="adv-panel-border text-center">
								<i id="yearly-performance-gth-spinner" class="fa fa-cog fa-spin fa-2x" style="margin-top: 100px;"></i>
							</div>
						</div>
					</div>
					<div id="performance_menu3" class="container tab-pane">
						<br>
						<h4 class="textColor">Nav Movement</h4>
						<div id="nav-movement-gth-div">
							<div id="nav-movement-container" style="height: 275px; min-width: 250px;" class="adv-panel-border text-center">
								<i id="nav-movement-gth-spinner" class="fa fa-cog fa-spin fa-2x" style="margin-top: 100px;"></i>
							</div>
						</div>
					</div>
				</div>

			</div>
			<div class="col-lg-4 pl-4 py-4" style="border-left:1px solid #eee;">
				<h5 class="textColor">Funds Manager</h5>
				<p>
					<strong><c:out value="${schemeMapping.scheme_manager}"></c:out></strong>
				</p>
				<p class="text-justify">
					<c:out value="${schemeMapping.scheme_manager_biography}"></c:out>
				</p>
			</div>
		</div>


		<div class="row scheme-overview-box mt-5 pt-4 pb-5">

			<div class="col-lg-12 navtb">
				<h4 class="textColor">RETURNS CALCULATORS for ${scheme}</h4>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li class="nav-item"><a class="nav-link active text-dark" data-toggle="tab" href="#sip">SIP Return</a></li>
					<li class="nav-item"><a class="nav-link text-dark" data-toggle="tab" href="#Lumpsum" onclick="returnsTabChange(2)">Lumpsum Performance</a></li>
					<li class="nav-item"><a class="nav-link text-dark" data-toggle="tab" href="#Rolling" onclick="returnsTabChange(3)">Rolling Returns</a></li>
				</ul>

				<!-- Tab panes -->
				<div class="tab-content">
					<div id="sip" class="container tab-pane active">
						<br>
						<div id="sip-gth-div">
							<h4 class="textColor">Growth of 10000 In SIP (Fund vs
								Benchmark)</h4>
							<div class="row pb-3" style="margin-left:0px;margin-right:0px;">

								<div class="col-lg-12 strtDatebg px-5 pb-4 pt-2">
									<div class="row">

										<div class="col-lg-3">
											<label class="font-600">Amount :</label> <input type="text"
												value="10000" id="txt_sip_amount"
												onchange="calculateSIPReturns()"
												class="form-control form-control-sm width80 " />
										</div>
										<div class="col-lg-3">
											<label class="font-600">Period :</label> <select
												id="txt_sipFreq" onchange="calculateSIPReturns()"
												class="form-control form-control-sm width150 ">
												<option value="Daily">Daily</option>
												<option value="Weekly">Weekly</option>
												<option value="FortNightly">FortNightly</option>
												<option selected value="Monthly">Monthly</option>
												<option value="Quarterly">Quarterly</option>
											</select>
										</div>
										<div class="col-lg-3">
											<label class="font-600">Start :</label> <input type="text"
												value="<fmt:formatDate pattern="dd-MM-yyyy" value="${dateMap[0]}"/>"
												id="txt_sipStartDate"
												class="form-control form-control-sm inline-block width100" />
										</div>
										<div class="col-lg-3">
											<label class="font-600">End :</label> <input type="text"
												value="<fmt:formatDate pattern="dd-MM-yyyy" value="${dateMap[1]}" />"
												id="txt_sipEndDate"
												class="form-control form-control-sm inline-block width100" />
										</div>

									</div>
								</div>
							</div>

							<div class="p-2 table-bdr-radius table-bg">
								<div class="table-responsive" id="sip_returns_table_res"></div>
								<div id="sip-gth-container"
									style="height: 300px; min-width: 250px;"
									class="adv-panel-border">
									<i id="sip-gth-spinner" class="fa fa-cog fa-spin fa-2x"
										style="margin-top: 100px;"></i>
								</div>
							</div>

						</div>
					</div>

					<div id="Lumpsum" class="container tab-pane">
						<br>
						<div id="lumpsum-gth-div">
							<h4 class="textColor">Growth of 10000 In LUMPSUM (Fund vs
								Benchmark)</h4>
							<div class="row pb-3" style="margin-left:0px;margin-right:0px;">

								<div class="col-lg-12 strtDatebg px-5 pb-4 pt-2">
									<div class="row">

										<div class="col-lg-3">
											<label class="font-600">Amount :</label> <input type="text"
												value="10000" id="txt_lumpsum_amount"
												onchange="calculateLumpSumReturns()"
												class="form-control form-control-sm width80 inline-block" />
										</div>
										<div class="col-lg-3">
											<label class="font-600">Start :</label> <input type="text"
												value="<fmt:formatDate pattern="dd-MM-yyyy" value="${dateMap[0]}"/>"
												id="txt_lumpsumtartDate"
												class="form-control form-control-sm inline-block width100" />
										</div>
									</div>
								</div>
							</div>
							<div class="p-2 table-bdr-radius table-bg">
								<div class="table-responsive" id="lumpsum_returns_table_res"></div>
								<div id="lumpsum-gth-container"
									style="height: 300px; min-width: 250px;"
									class="adv-panel-border">
									<i id="lumpsum-gth-spinner" class="fa fa-cog fa-spin fa-2x"
										style="margin-top: 100px;"></i>
								</div>
							</div>
						</div>
					</div>
					<div id="Rolling" class="container tab-pane">
						<br>
						<div id="rolling-returns-gth-div">
							<h4 class="textColor">Rolling Returns</h4>
							<div class="row pb-3" style="margin-left:0px;margin-right:0px;">
								<p style="text-align: justify; font-size: 12px;">Rolling
									returns are the annualized returns of the scheme taken for a
									specified period (rolling returns period) on every
									day/week/month and taken till the last day of the duration. In
									this chart we are showing the annualized returns over the
									rolling returns period on every day from the start date and
									comparing it with the benchmark. Rolling returns is the best
									measure of a fund's performance. Trailing returns have a
									recency bias and point to point returns are specific to the
									period in consideration. Rolling returns, on the other hand,
									measures the fund's absolute and relative performance across
									all timescales, without bias.</p>
							</div>
							<div class="row pb-3" style="margin-left:0px;margin-right:0px;">
								<div class="col-lg-12 strtDatebg px-5 pb-4 pt-2">
									<div class="row">

										<div class="col-lg-3">
											<label class="font-600">Select Start Date :</label> <input
												type="text"
												value="<fmt:formatDate pattern="dd-MM-yyyy" value="${rolling_returns_start_date}"/>"
												id="txt_rolling_returns_start_date"
												class="form-control inline-block width100" />
										</div>
										<div class="col-lg-3">
											<label class="font-600">Select Rolling Return Time
												Period <i class="fa fa-question-circle"
												data-toggle="tooltip"
												title="The Rolling Return time period should correspond to your typical investment holding period. For example, if you hold your investment for 3 years, then select 3 years in the Rolling Return Time Period"></i>
											</label> <select id="sel_rolling_returns_period"
												class="form-control width350 selectpicker"
												onchange="calculateRollingReturnsBefore()">
												<option value="1">1 year</option>
												<option value="2">2 years</option>
												<option value="3" selected="selected">3 years</option>
												<option value="5">5 years</option>
												<option value="10">10 years</option>
												<option value="15">15 years</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="p-2 table-bdr-radius table-bg marginTop20">
								<div class="table-responsive"></div>
								<div id="rolling-returns-container"
									style="height: 300px; min-width: 250px;"
									class="adv-panel-border">
									<i id="rolling-returns-spinner" class="fa fa-cog fa-spin fa-2x"
										style="margin-top: 100px;"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row scheme-overview-box mt-5 pt-4 pb-5">

			<div class="col-lg-8 navtb">
				<h4 class="textColor">PEER COMPARISION of ${scheme}</h4>
				
				<div class="tab-content">
					<div class="table-responsive">
						<table class="table font12 margin-bottom10" id="tbl-peer">
							<thead>
								<tr>
									<th>Scheme Name</th>
									<th>Inception <br/>Date</th>
									<th>1 Year <br/>Rtn (%)</th>
									<th>2 Year <br/>Rtn (%)</th>
									<th>3 Year <br/>Rtn (%)</th>
									<th>5 Year <br/>Rtn (%)</th>
									<th>10 Year <br/>Rtn (%)</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${peerComparisonResponse}" var="peer"	varStatus="status">
								<tr class="rowcompar row-${status.index}">
									<td class="table-font-color <c:if test='${status.index eq 0}'>active</c:if>">
										<a class="blue-color" href="/mutual-funds-research/${peer.scheme_amfi_url}">${peer.scheme_amfi}</a>
									</td>
									<td class="table-font-color <c:if test='${status.index eq 0}'>active</c:if>" style="width:100px;">
										<fmt:formatDate pattern="dd-MM-yyyy" value="${peer.inception_date}" />
									</td>
									<td class="table-font-color <c:if test='${status.index eq 0}'>active</c:if>" style="width:75px;">
										<c:choose>
										    <c:when test="${peer.returns_abs_1year eq 0}">-</c:when>
										    <c:otherwise>${peer.returns_abs_1year}</c:otherwise>
									  	</c:choose>
									</td>
									<td class="table-font-color <c:if test='${status.index eq 0}'>active</c:if>" style="width:75px;">
										<c:choose>
										    <c:when test="${peer.returns_cmp_2year eq 0}">-</c:when>
										    <c:otherwise>${peer.returns_cmp_2year}</c:otherwise>
									  	</c:choose>
									</td>
									<td class="table-font-color <c:if test='${status.index eq 0}'>active</c:if>" style="width:75px;">
										<c:choose>
										    <c:when test="${peer.returns_cmp_3year eq 0}">-</c:when>
										    <c:otherwise>${peer.returns_cmp_3year}</c:otherwise>
									  	</c:choose>
									</td>
									<td class="table-font-color <c:if test='${status.index eq 0}'>active</c:if>" style="width:75px;">
										<c:choose>
										    <c:when test="${peer.returns_cmp_5year eq 0}">-</c:when>
										    <c:otherwise>${peer.returns_cmp_5year}</c:otherwise>
									  	</c:choose>
									</td>
									<td class="table-font-color <c:if test='${status.index eq 0}'>active</c:if>" style="width:75px;">
										<c:choose>
										    <c:when test="${peer.returns_cmp_10year eq 0}">-</c:when>
										    <c:otherwise>${peer.returns_cmp_10year}</c:otherwise>
									  	</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>						
						</table>
					</div>				
				</div>
			</div>
			<div class="col-lg-4 pl-4 py-4" style="border-left:1px solid #eee;">
				<h5 class="textColor">Asset Allocation (%)</h5>
				<div class="col-md-12 col-sm-12" id="asset_allocation_div">
				<h2 class="font-size-16 marginTop0"></h2>
				<div id="asset-gth-spinner"
					style="text-align: center; display: none;">
					<i class="fa fa-cog fa-spin fa-2x"
						style="margin-top: 100px; margin-bottom: 100px;"></i>
				</div>
				<div id="asset-allocation-container"
					style="min-width: 250px; height: 300px;"></div>
				</div>
			</div>
		</div>
		
		

		<div class="row scheme-overview-box mt-5 pt-4">

			<div class="col-lg-12">
				<h4 class="textColor">PORTFOLIO ANALYSIS of ${scheme}</h4>
			</div>
		
			<div class="col-lg-6">
				<h4 class="textColor text-center">Top 10 Stocks in portfolio (%)</h4>
				<div id="sector-allocation-container"
					style="height: 300px; width: 100%;"></div>
				<!--  <p class="textColor text-center">Show All Sectors <i class="fa fa-chevron-circle-down textColor" aria-hidden="true"></i></p> -->
			</div>
			<div class="col-lg-6">
				<h4 class="textColor text-center">Top 10 Sectors in portfolio (%)</h4>
				<div id="holdings-allocation-container"
					style="height: 300px; width: 100%;"></div>
				<!-- <p class="textColor text-center">Show All Sectors <i class="fa fa-chevron-circle-down textColor" aria-hidden="true"></i></p> -->
			</div>
			<div class="col-md-6 pr-0" id="fullSector" style="display:none;min-height:200px;">
	    		<div id="fullSectorAnchor" style="color:red;cursor:pointer;margin-bottom: 20px;" onclick="sectorAllocationClick()"><span id="sector_anchor_span" class="paddingRight5">Show All Sectors</span> <i class="fa fa-chevron-circle-down"></i> </div>
	       		<div class="table-responsive" id="full_sector_data">
		       		<table class="table table-striped tbl" id="full_sector_data_table"><thead><tr><th>Sector</th><th>Allocation (%)</th></tr></thead><tbody>
					</tbody></table>
	       		</div>
      		</div>
      
      		<div class="col-md-6 pr-0" id="fullHoldings" style="display:none;min-height:200px;">
      			<div id="fullHoldingsAnchor" style="color:red;cursor:pointer;margin-bottom: 20px;" onclick="holdingsAllocationClick()"><span id="holdings_anchor_span" class="paddingRight5">Show All Holdings</span> <i class="fa fa-chevron-circle-down"></i></div>
        		<div class="table-responsive" id="full_holdings_data">
	        		<table class="table table-striped tbl" id="full_holdings_data_table"><thead><tr><th>Sector</th><th>Allocation (%)</th></tr></thead><tbody>
					</tbody></table>
        		</div>
      		</div>
		</div>
		
		<div class="row scheme-overview-box mt-5 pt-4">
			<div class="col-lg-12">
				<h4 class="textColor">Key Performance and Risk Statistics of ${scheme}</h4>
				<div class="p-2 table-bdr-radius table-bg table-responsive">
					<table class="table table-bordered mb-0 table-bg">
						<thead>
							<tr>
								<th>Key Statistics</th>
								<th>Volatility</th>
								<th>Sharpe Ratio</th>
								<th>Alpha</th>
								<th>Beta</th>
								<th>Yield to Maturity</th>
								<th>Average Maturity</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${scheme}</td>
								<td><c:out
										value="${schemeMapping.volatility eq 0 ? '-': schemeMapping.volatility}"></c:out></td>
								<td><c:out
										value="${schemeMapping.sharpratio eq 0 ? '-': schemeMapping.sharpratio}"></c:out></td>
								<td><c:out
										value="${schemeMapping.alpha eq 0 ? '-': schemeMapping.alpha}"></c:out></td>
								<td><c:out
										value="${schemeMapping.beta eq 0 ? '-': schemeMapping.beta}"></c:out></td>
								<td><c:out
										value="${schemeMapping.yield_to_maturity eq 0 ? '-': schemeMapping.yield_to_maturity}"></c:out></td>
								<td><c:out
										value="${schemeMapping.average_maturity eq 0 ? '-': schemeMapping.average_maturity}"></c:out></td>
							</tr>
							<tr>
								<td>${schemeMapping.scheme_advisorkhoj_category}</td>
								<td><c:out
										value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.volatility_cm_3year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.volatility_cm_3year}"></c:out></td>
								<td><c:out
										value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.sharpratio_cm_3year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.sharpratio_cm_3year}"></c:out></td>
								<td><c:out
										value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.alpha_cm_1year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.alpha_cm_1year}"></c:out></td>
								<td><c:out
										value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.beta_cm_1year eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.beta_cm_1year}"></c:out></td>
								<td><c:out
										value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.yield_to_maturity eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.yield_to_maturity}"></c:out></td>
								<td><c:out
										value="${fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.average_maturity eq 0 ? '-': fundPerformanceOverviewAgainstBenchmarkAndCategoryResponse.schemePerformancesCategory.average_maturity}"></c:out></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div id="Rolling" class="container tab-pane fade">
		<br>
		
		<!-- Mobile Responsive Issue ends here -->

	</div>
</div>