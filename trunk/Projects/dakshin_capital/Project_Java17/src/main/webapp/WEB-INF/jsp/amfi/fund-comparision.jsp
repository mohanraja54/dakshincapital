<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
#tbl_scheme_returns thead th {
	padding: 2px 10px !important;
	border-bottom: 1px solid #ddd !important;
}
#div_fund_2,#div_fund_3,#div_fund_4,#div_fund_5{
	display:none;
}

#tbl_scheme_returns thead th {
	padding: 2px 10px !important;
	border-bottom: 1px solid #ddd !important;
}
table.dataTable tfoot th, table.dataTable tfoot td {
    border-top: 1px solid #ddd;
     border-bottom: 0;
}
table.dataTable tbody th, table.dataTable tbody td {
    padding: 10px 10px;
}
.dataTables_wrapper .dataTables_paginate .paginate_button.current,
.dataTables_wrapper .dataTables_paginate .paginate_button.current:hover{
	background: #005e96 !important;
    color: #fff !important;
    border: 0;
    border: 1px solid #005e96 !important;
    border-radius: 0px;
}

.dataTables_wrapper .dataTables_paginate .paginate_button:hover{
	background: #f2f2f2 !important;
    color: #000 !important;
}
.dataTables_wrapper .dataTables_paginate {
    padding-top: 1em;
}
table.dataTable.no-footer {
    border-bottom: 1px solid #dedede;
}
table.dataTable thead th, table.dataTable thead td {
    border-bottom: 1px solid #dedede;
}
table.dataTable{
	border-bottom: 1px solid #dedede;
}
.input-group-addon {
    padding: 4px 12px;
    font-size: 14px;
    font-weight: 400;
    border-radius: 0px;
    color: #fff;
    background-color: #1b9ce3;
    border: 1px solid #1b9ce3;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
    position: relative;
    left: -38px;
}
</style>

<script>

$(document).ready(function(){
	
	initializeTypeAhead();
	
	var fund = '${fund}';
	if(fund != "")
	{
		var fund_array = fund.split(",");
		for(var k=0;k<fund_array.length;k++)
		{
			var fund_name = fund_array[k];
			
			if(k == 0)
			{
				$("#txt_fund1").val(fund_name);
			}
			if(k == 1)
			{
				$("#more_funds_div_1").hide();
				$("#div_fund_2").show();
				$("#txt_fund2").val(fund_name);
			}
			if(k == 2)
			{
				$("#more_funds_div_2").hide();
				$("#div_fund_3").show();
				$("#txt_fund3").val(fund_name);
			}
			if(k == 3)
			{
				$("#more_funds_div_3").hide();
				$("#div_fund_4").show();
				$("#txt_fund4").val(fund_name);
			}
			if(k == 4)
			{
				$("#more_funds_div_4").hide();
				$("#div_fund_5").show();
				$("#txt_fund5").val(fund_name);
			}
		}
	}
	
	$('#tbl_scheme_returns').dataTable({
		"searching": false,
        "ordering": false,
        "info":     false,
        "paging":   false,
        "sDom": "lfrti",
        "columns": [
            { "width": "50%" },
            { "width": "15%" },
            { "width": "15%" },
            { "width": "10%" },
            { "width": "10%" },
          ]
	});
	
	$('#tbl_scheme_returns1').dataTable({
		"searching": false,
        "ordering": false,
        "info":     false,
        "paging":   false,
        "sDom": "lfrti",
        "columns": [
        	{ "width": "40%" },
            { "width": "10%" },
            { "width": "10%" },
            { "width": "10%" },
            { "width": "10%" },
            { "width": "10%" },
          ]
	});
});

function initializeTypeAhead()
{	
	$('.txt_fund').typeahead({
	    source: function (query, process) {
	        return $.ajax({
	            url: '../mutual-funds-research/autoSuggestAllMfSchemes',
	            type: 'post',
	            data: { 
	            	query: query,
	            	category: $("#sel_schemeCategories").val()
	            },
	            dataType: 'json',
	            success: function (result) {
		            $(".dropdown-menu").css({
		                'width': (($(".txt_fund").width() + 25) + 'px')
		              });
	                return process(result);
	            }
	        });
	    },
	    items:10,
	    matcher: function(item) {
	        return true;
	    }
	});
}

function getData()
{
	var fundname1 = $("#txt_fund1").val();
	var fundname2 = $("#txt_fund2").val();
	var fundname3 = $("#txt_fund3").val();
	var fundname4 = $("#txt_fund4").val();
	var fundname5 = $("#txt_fund5").val();
	var category = $("#sel_schemeCategories").val();
	var fund_array = new Array();
	
	if(fundname1 == "")
	{
		swal({title:"",text:"Please enter value for fund 1"});
		return;
	}else{
		fundname1 = encodeURIComponent(fundname1);
		fund_array.push(fundname1);
	}
	if(fundname2 != "")
	{
		fundname2 = encodeURIComponent(fundname2);
		fund_array.push(fundname2);
	}
	if(fundname3 != "")
	{
		fundname3 = encodeURIComponent(fundname3);
		fund_array.push(fundname3);
	}
	if(fundname4 != "")
	{
		fundname4 = encodeURIComponent(fundname4);
		fund_array.push(fundname4);
	}
	if(fundname5 != "")
	{
		fundname5 = encodeURIComponent(fundname5);
		fund_array.push(fundname5);
	}
	top.location =  "/mutual-funds-research/mutual-funds-performance-comparison?fund="+fund_array+"&category="+category;
}

function addMoreFund(count)
{
	var fundname1 = $("#txt_fund1").val();
	if(fundname1 == "")
	{
		$("#adv-alert-msg").html("Enter an value for Fund 1");
   	    $("#adv-alert").modal('show');
		return;
	}
	if($("#div_fund_2").is(':visible'))
	{
		var fundname2 = $("#txt_fund2").val();
		if(fundname2 == "")
		{
			$("#adv-alert-msg").html("Enter an value for Fund 2");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if($("#div_fund_3").is(':visible'))
	{
		var fundname3 = $("#txt_fund3").val();
		if(fundname3 == "")
		{
			$("#adv-alert-msg").html("Enter an value for Fund 3");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if($("#div_fund_4").is(':visible'))
	{
		var fundname4 = $("#txt_fund4").val();
		if(fundname4 == "")
		{
			$("#adv-alert-msg").html("Enter an value for Fund 4");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	if($("#div_fund_5").is(':visible'))
	{
		var fundname5 = $("#txt_fund5").val();
		if(fundname5 == "")
		{
			$("#adv-alert-msg").html("Enter an value for Fund 5");
	   	    $("#adv-alert").modal('show');
			return;
		}
	}
	
	if(count == 1)
	{
		$("#more_funds_div_1").hide();
		$("#div_fund_2").show();
	}else if(count == 2)
	{
		$("#more_funds_div_2").hide();
		$("#div_fund_3").show();
	}else if(count == 3)
	{
		$("#more_funds_div_3").hide();
		$("#div_fund_4").show();
	}else if(count == 4)
	{
		$("#more_funds_div_4").hide();
		$("#div_fund_5").show();
	}
}
function removeMoreFund(count)
{
	if(count == 2)
	{
		$("#more_funds_div_1").show();
		$("#div_fund_2").hide();
		$("#txt_fund2").val("");
	}else if(count == 3)
	{
		$("#more_funds_div_2").show();
		$("#div_fund_3").hide();
		$("#txt_fund3").val("");
	}else if(count == 4)
	{
		$("#more_funds_div_3").show();
		$("#div_fund_4").hide();
		$("#txt_fund4").val("");
	}else if(count == 5)
	{
		$("#more_funds_div_4").show();
		$("#div_fund_5").hide();
		$("#txt_fund5").val("");
	}
	
     if($("#transaction_details").is(":visible"))
   	 {
    	 getData();
   	 }
}

function downloadXl()
{
	var fundname1 = $("#txt_fund1").val();
	var fundname2 = "";
	var fundname3 = "";
	var fundname4 = "";
	var fundname5 = "";
	var category = $("#sel_schemeCategories").val();
	var fund_array = new Array();
	
	if(fundname1 == "")
	{
		$("#adv-alert-msg").html("Please enter value for fund 1");
   	    $("#adv-alert").modal('show');
		return;
	}else{
		fundname1 = encodeURIComponent(fundname1);
		fund_array.push(fundname1);
	}
	if($("#txt_fund2").val().length != 0)
	{
		fundname2 = $("#txt_fund2").val();
		if(fundname2 == "")
		{
			$("#adv-alert-msg").html("Please enter value for fund 2");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fundname2 = encodeURIComponent(fundname2);
			fund_array.push(fundname2);
		}
	}
	if($("#txt_fund3").val().length != 0)
	{
		fundname3 = $("#txt_fund3").val();
		if(fundname3 == "")
		{
			$("#adv-alert-msg").html("Please enter value for fund 3");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fundname3 = encodeURIComponent(fundname3);
			fund_array.push(fundname3);
		}
	}
	if($("#txt_fund4").val().length != 0)
	{
		fundname4 = $("#txt_fund4").val();
		if(fundname4 == "")
		{
			$("#adv-alert-msg").html("Please enter value for fund 4");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fundname4 = encodeURIComponent(fundname4);
			fund_array.push(fundname4);
		}
	}
	if($("#txt_fund5").val().length != 0)
	{
		fundname5 = $("#txt_fund5").val();
		if(fundname5 == "")
		{
			$("#adv-alert-msg").html("Please enter value for fund 5");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fundname5 = encodeURIComponent(fundname5);
			fund_array.push(fundname5);
		}
	}
	var path = "/mutual-funds-research/downloadMutualFundsPerformanceComparisonXl?fund="+fund_array+"&category="+category;
	var xhr = new XMLHttpRequest();
	xhr.open('GET', path, true);
	xhr.responseType = 'text';
	xhr.onload = function () {
	    if (xhr.readyState === xhr.DONE) {
	        if (xhr.status === 200) {
	        	
	        	var contentType = xhr.getResponseHeader("Content-Type");
	        	if(contentType == "application/json;charset=ISO-8859-1"){
	        		var data = JSON.parse(xhr.response);
	        		alert(data.msg);
	    	    }
	    	    else{
	    	    	top.location =  "/mutual-funds-research/downloadMutualFundsPerformanceComparisonXl?fund="+fund_array+"&category="+category+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
	
	var fundname1 = $("#txt_fund1").val();
	var fundname2 = "";
	var fundname3 = "";
	var fundname4 = "";
	var fundname5 = "";
	var category = $("#sel_schemeCategories").val();
	var fund_array = new Array();
	
	if(fundname1 == "")
	{
		$("#adv-alert-msg").html("Please enter value for fund 1");
   	    $("#adv-alert").modal('show');
		return;
	}else{
		fundname1 = encodeURIComponent(fundname1);
		fund_array.push(fundname1);
	}
	if($("#txt_fund2").val().length != 0)
	{
		fundname2 = $("#txt_fund2").val();
		if(fundname2 == "")
		{
			$("#adv-alert-msg").html("Please enter value for fund 2");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fundname2 = encodeURIComponent(fundname2);
			fund_array.push(fundname2);
		}
	}
	if($("#txt_fund3").val().length != 0)
	{
		fundname3 = $("#txt_fund3").val();
		if(fundname3 == "")
		{
			$("#adv-alert-msg").html("Please enter value for fund 3");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fundname3 = encodeURIComponent(fundname3);
			fund_array.push(fundname3);
		}
	}
	if($("#txt_fund4").val().length != 0)
	{
		fundname4 = $("#txt_fund4").val();
		if(fundname4 == "")
		{
			$("#adv-alert-msg").html("Please enter value for fund 4");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fundname4 = encodeURIComponent(fundname4);
			fund_array.push(fundname4);
		}
	}
	if($("#txt_fund5").val().length != 0)
	{
		fundname5 = $("#txt_fund5").val();
		if(fundname5 == "")
		{
			$("#adv-alert-msg").html("Please enter value for fund 5");
	   	    $("#adv-alert").modal('show');
			return;
		}else{
			fundname5 = encodeURIComponent(fundname5);
			fund_array.push(fundname5);
		}
	}
	downloadPath = "/mutual-funds-research/downloadMutualFundsPerformanceComparisonXl?fund="+fund_array+"&category="+category;
	imageDownload = "no";
	chartId = "";
	filename = "";
	$("#adv-login").modal("show");
}
</script>

<section class="main-container mf-research">

<div class="container-fluid pr-0 pl-0">
	<div class="row ml-0 mr-0">
		<div class="col-md-3 bg-mfbar py-3">
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Mutual Funds Performance Comparison</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
			<div class="row">
                     <div class="col-md-6">
                        <div class="form-group">
                           <label class="font-600">Select Category</label>
                           <select id="sel_schemeCategories" class="form-control selectpicker">
                              <option value="All">All</option>
                              <c:forEach var="cat" items="${schemeCategories}" varStatus="status">
                     <c:choose>
                        <c:when test="${cat eq category}">
                           <option selected="selected" value="${cat}">${cat}</option>
                        </c:when>
                        <c:otherwise>
                           <option value="${cat}">${cat}</option>
                        </c:otherwise>
                     </c:choose>
                  </c:forEach>
               </select>
            </div>
         </div>
         <div class="col-md-6">
            <div id="div_txt_funds">
               <div id="div_fund_1" class="form-group fund">
                  <label class="font-600">Fund 1</label>
                  <input id="txt_fund1" type="text" class="txt_fund form-control">
               </div>
            </div>
            <div class="form-group" id="more_funds_div_1">
               <a href="javascript:void(0);" class="stepsAddmore" onclick="addMoreFund(1)"><i class="fa fa-plus-square marginRight10"></i> Add another fund (upto 4)</a>
            </div>
         </div>
      </div>
      <div class="row">
         <div class="col-md-6 col-sm-6" id="div_fund_2">
            <div class="form-group fund">
               <label class="font-600">Fund 2</label>
               <div class="input-group">
                  <input id="txt_fund2" type="text" class="txt_fund form-control input-sm">
                  <span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(2)"><i class="fa fa-close"></i></span>
               </div>
            </div>
            <div class="form-group" id="more_funds_div_2">
               <a href="javascript:void(0);" class="stepsAddmore" onclick="addMoreFund(2)"><i class="fa fa-plus-square marginRight10"></i> Add another fund (upto 3)</a>
            </div>
         </div>
         <div class="col-md-6 col-sm-6" id="div_fund_3">
            <div class="form-group fund">
               <label class="font-600">Fund 3</label>
               <div class="input-group">
                  <input id="txt_fund3" type="text" class="txt_fund form-control input-sm">
                  <span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(3)"><i class="fa fa-close"></i></span>
               </div>
            </div>
            <div class="form-group" id="more_funds_div_3">
               <a href="javascript:void(0);" class="stepsAddmore" onclick="addMoreFund(3)"><i class="fa fa-plus-square marginRight10"></i> Add another fund (upto 2)</a>
            </div>
         </div>
      </div>
      <div class="row">
         <div class="col-md-6 col-sm-6" id="div_fund_4">
            <div class="form-group fund">
               <label class="font-600">Fund 4</label>
               <div class="input-group">
                  <input id="txt_fund4" type="text" class="txt_fund form-control input-sm">
                  <span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(4)"><i class="fa fa-close"></i></span>
               </div>
            </div>
            <div class="form-group" id="more_funds_div_4">
               <a href="javascript:void(0);" class="stepsAddmore" onclick="addMoreFund(4)"><i class="fa fa-plus-square marginRight10"></i> Add another fund (upto 1)</a>
            </div>
         </div>
         <div class="col-md-6 col-sm-6" id="div_fund_5">
            <div class="form-group fund">
               <label class="font-600">Fund 5</label>
               <div class="input-group">
                  <input id="txt_fund5" type="text" class="txt_fund form-control input-sm">
                  <span class="input-group-addon" style="cursor:pointer;"  onclick="removeMoreFund(5)"><i class="fa fa-close"></i></span>
               </div>
            </div>
         </div>
      </div>
      <div class="col-md-6 col-md-offset-6 pl-0">
         <div class="form-group">
            <a href="javascript:void(0)" style="width:25%;" class="btn btn-primary" onclick="getData()">Submit</a>
         </div>
      </div>
		</div>
	</div>
	</div>

   <div class="container-fluid pt-3 pb-3 pr-3 pl-0 calc-tool">
      <div class="row">
         <div class="col-md-3 order-sm-2 order-lg-1 order-2">
            <jsp:include page="../sidebar/mf-sidebar.jsp"></jsp:include>
         </div>
         <div class="col-md-9 order-sm-1 order-lg-2 order-1">
                  <!-- Download Excel -->
			      <div class="row" style="margin-left: 0px;margin-right: 0px;margin-bottom: 10px;">
				  		<div class="col-md-6 col-sm-6 col-xs-6 padding-0">	
				  			<span style="font-weight: 700;font-size: 13px;">Data as on - ${nav_date}</span>
			        	</div>
			        	<div class="col-md-6 col-sm-6 col-xs-6 pull-right download_anchor  padding-0">
				        <c:choose>
						  	<c:when test="${empty accountMap.userid}">
						  		<a onClick="openLogin();" style="cursor:pointer;float:right;color:white;text-decoration:none;" class="btn btn-sm btn-success">Download Result</a>					  	
						  	</c:when>
						  	<c:otherwise>
					  			<a onClick="downloadXl();" style="cursor:pointer;float:right;color:white;text-decoration:none;" class="btn btn-sm btn-success">Download Result</a>	
					  	    </c:otherwise>
					  	</c:choose>
				        </div>
			     </div>
                  
                  <div class="col-md-12 col-sm-12 mt-1 table-responsive">
					      <table class="table dataTable" id="tbl_scheme_returns">
					         <thead>
					            <tr>
					               <th>Fund Name</th>
					               <th>Category</th>
					               <th>Launch Date</th>
					               <th>AUM (Crore)</th>
					               <th>Expense Ratio (%)</th>
					            </tr>
					         </thead>
					         <tbody>
					            <c:forEach items="${schemePerformances}" var="schemePerformances">
					               <tr>
					                  <td>
					                     <a href='/mutual-funds-research/<c:out value="${schemePerformances.scheme_amfi}"></c:out>' class="mutual-funds-anchor">
					                        <c:out value="${schemePerformances.scheme_amfi}"></c:out>
					                     </a>
					                  </td>
					                  <td>
					                     <c:out value="${schemePerformances.scheme_category}"></c:out>
					                  </td>
					                  <td>
					                     <fmt:formatDate pattern="dd-MM-yyyy" value="${schemePerformances.inception_date}" />
					                  </td>
					                  <td>
					                     <fmt:formatNumber type="number" maxFractionDigits="2" value="${schemePerformances.scheme_assets / 10}"/>
					                  </td>
					                  <td>
					                     <c:out value="${schemePerformances.ter}"></c:out>
					                  </td>
					               </tr>
					            </c:forEach>
					         </tbody>
					      </table>
					</div>
					
					<div class="col-md-12 col-sm-12 table-responsive mt-4">
					   <h2 class="font-size-18 marginBottom10">Performance Comparison</h2>
					      <table class="table dataTable" id="tbl_scheme_returns1">
					         <thead >
					            <tr>
					               <th>Fund Name</th>
					               <th>1-Year Ret&nbsp;(%)</th>
					               <th>3-Yrs Ret&nbsp;(%)</th>
					               <th>5-Yrs Ret&nbsp;(%)</th>
					               <th>10-Yrs Ret&nbsp;(%)</th>
					               <th>Since Launch Ret&nbsp;(%)</th>
					            </tr>
					         </thead>
					         <tbody>
					            <c:forEach items="${schemePerformances}" var="schemePerformances">
					               <tr>
					                  <td>
					                     <a href='/mutual-funds-research/<c:out value="${schemePerformances.scheme_amfi}"></c:out>' class="mutual-funds-anchor">
					                        <c:out value="${schemePerformances.scheme_amfi}"></c:out>
					                     </a>
					                  </td>
					                  <td>
					                     <c:out value="${schemePerformances.returns_abs_1year eq 0 ? '-': schemePerformances.returns_abs_1year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${schemePerformances.returns_cmp_3year eq 0 ? '-': schemePerformances.returns_cmp_3year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${schemePerformances.returns_cmp_5year eq 0 ? '-': schemePerformances.returns_cmp_5year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${schemePerformances.returns_cmp_10year eq 0 ? '-': schemePerformances.returns_cmp_10year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${schemePerformances.returns_cmp_inception eq 0 ? '-': schemePerformances.returns_cmp_inception}"></c:out>
					                  </td>
					               </tr>
					            </c:forEach>
					         </tbody>
					         <c:if test="${category_returns != null && benchmark_returns != null}">
					            <tfoot>
					               <tr>
					                  <td>Category Average</td>
					                  <td>
					                     <c:out value="${category_returns.returns_abs_1year eq 0 ? '-': category_returns.returns_abs_1year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${category_returns.returns_cmp_3year eq 0 ? '-': category_returns.returns_cmp_3year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${category_returns.returns_cmp_5year eq 0 ? '-': category_returns.returns_cmp_5year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${category_returns.returns_cmp_10year eq 0 ? '-': category_returns.returns_cmp_10year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${category_returns.returns_cmp_inception eq 0 ? '-': category_returns.returns_cmp_inception}"></c:out>
					                  </td>
					               </tr>
					               <tr>
					                  <td>
					                     <c:out value="${benchmark_returns.benchmark_name}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${benchmark_returns.returns_abs_1year eq 0 ? '-': benchmark_returns.returns_abs_1year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${benchmark_returns.returns_cmp_3year eq 0 ? '-': benchmark_returns.returns_cmp_3year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${benchmark_returns.returns_cmp_5year eq 0 ? '-': benchmark_returns.returns_cmp_5year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${benchmark_returns.returns_cmp_10year eq 0 ? '-': benchmark_returns.returns_cmp_10year}"></c:out>
					                  </td>
					                  <td>
					                     <c:out value="${benchmark_returns.returns_cmp_inception eq 0 ? '-': benchmark_returns.returns_cmp_inception}"></c:out>
					                  </td>
					               </tr>
					            </tfoot>
					         </c:if>
					      </table>
					</div>
         </div>
      </div>
   </div>
</section>