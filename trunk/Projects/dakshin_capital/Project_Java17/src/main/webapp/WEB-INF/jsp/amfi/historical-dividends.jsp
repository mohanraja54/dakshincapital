<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<style type="text/css">
#performance_div .form-control, #performance_div label, #performance_div .multiselect {
    font-size: 11px;
}
.marginTop20{
	margin-top:20px;
}
.table-responsive .form-inline{
	display:block !important;
}

#tbl_scheme_returns thead th {
	padding: 2px 10px !important;
	border-bottom: 1px solid #ddd !important;
}
table.dataTable tfoot th, table.dataTable tfoot td {
    border-top: 1px solid #ddd;
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

table.dataTable{
	border: 1px solid #dedede !important;
}
</style>

<script>

$(document).ready(function(){
	
	$('#mf_fund_txt').typeahead({
	    source: function (query, process) {
	        return $.ajax({
	            url: '/mutual-funds-research/autoSuggestMfSchemeWithDividend',
	            type: 'post',
	            data: { 
	            	query: query,
	                category: "All"
	            },
	            dataType: 'json',
	            success: function (result) {
	                return process(result);
	            }
	        });
	    },
	    items:10,
	    matcher: function(item) {
	        return true;
	    }
	});
	
	$('#tbl_dividend_history').dataTable({
		"pageLength": 25,
        "bPaginate": true,
        "bFilter": true,
        "bInfo": true,
        "bSort": false,
        "columns": [
                    { "width": "25%" },
                    { "width": "25%" },
                    { "width": "25%" },
                    { "width": "25%" },
                  ]
    });
	
	$("#tbl_dividend_history_wrapper").removeClass('form-inline');
	
	var scheme_name = '${scheme}';
	$("#mf_fund_txt").val(scheme_name);
});
function getData()
{
	var scheme_name = $("#mf_fund_txt").val();
 	if(scheme_name == "")
 	{
 		$("#adv-alert-msg").html("Please select scheme");
   	    $("#adv-alert").modal('show');
		return;
 	}
 	var schemeName = encodeURIComponent(scheme_name);
 	
 	var flag = false;
 	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/isValidFundName", {fund : schemeName}, function(data)
    {
		var result = $.trim(data);
		if(result == "true")
		{
		 	
		}
		else
		{
			flag = true;
	   	    return;
		}			
    },'text');
	
	if(flag)
	{
		$("#adv-alert-msg").html("Please type an Fund Name and select it from the autocomplete functionality.");
   	    $("#adv-alert").modal('show');
		return false;
	}
	
	top.location =  "/mutual-funds-research/mutual-funds-historical-dividends/"+schemeName;
}
</script>

<section class="main-container mf-research">

	<div class="container-fluid pr-0 pl-0">
	<div class="row ml-0 mr-0">
		<div class="col-md-3 bg-mfbar py-3">
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Mutual Fund Historical Dividends</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
			<div class="row">
	            <div class="col-md-6 col-sm-6">
		            <div class="form-group" >
		            <label class="font-600">Type an scheme Name</label>
		            <input id="mf_fund_txt" type="text" value="" class="form-control no-radius input-sm" placeholder="Type Fund Name and Click Submit">					
		            </div>
	            </div>
	            
	            <div class="col-md-2 col-sm-2">
	                <div class="form-group">
			            <label class="text-white" style="visibility: hidden;">Submit For Result</label>
					  <a href="javascript:void(0)" class="btn btn-primary" style="width: 80%;" onclick="getData()">Submit</a>
				    </div>
	            </div>
	
	         </div>
		</div>
	</div>
	</div>

   <div class="container-fluid pt-3 pb-3 pr-3 pl-0 calc-tool">
      <div class="row">
         <div class="col-md-3">
            <jsp:include page="../sidebar/mf-sidebar.jsp"></jsp:include>
         </div>
         <div class="col-md-9">
         	<div class="col-md-12 col-sm-12">
        <div class="row">
        	<div class="col-md-12 col-sm-12 table-responsive mt-4">
	       <table class="table dataTable">
	        <thead>
	            <tr>
	                <th>Category</th>
	                <th>Launch Date</th>
	    	        <th>Benchmark</th>
	    	        <th>Expense Ratio</th>		
	    	        <th>AUM</th>						
	            </tr>
	            </thead>
	            <tbody>              
	             <tr>
	                <td>${schemeMapping.scheme_advisorkhoj_category}</td>
	                <td><fmt:formatDate pattern="dd-MM-yyyy" value="${schemeMapping.scheme_inception_date}"/></td>
	                <td>
	                <c:choose>
	              	<c:when test="${not empty schemeMapping.scheme_benchmark}">
	               		<c:out value="${schemeMapping.scheme_benchmark}"/>
	              	</c:when>
	              	<c:otherwise>
	               		-
	              	</c:otherwise>               
	             	</c:choose>
	                </td>
	                <td><c:out value="${schemeMapping.ter}"/>% <br>As on (<fmt:parseDate value="${schemeMapping.ter_date}" var="parsedEmpDate" pattern="yyyy-MM-dd" /><fmt:formatDate pattern="dd-MM-yyyy" value="${parsedEmpDate}" />)</td>
	                <td><fmt:formatNumber type="number" maxFractionDigits="2" value="${schemeMapping.scheme_assets / 10}"/> Cr <br>As on (<fmt:parseDate value="${schemeMapping.scheme_asset_date}" var="parsedEmpDate" pattern="yyyy-MM-dd" /><fmt:formatDate pattern="dd-MM-yyyy" value="${parsedEmpDate}" />)</td>
	            </tr>
	            </tbody>
	       </table>
        </div>
        </div>  
        
     	<div class="row clearfix">
     	<div class="col-md-12 col-sm-12 table-responsive mt-5">
	       <table style="width:99.5%;" class="table dataTable" id="tbl_dividend_history">
	        <thead>
	            <tr>
	                <th>Dividend Record Date</th>
	                <th>Dividend / Unit</th>
	    	        <th>NAV</th>
	    	        <th>Dividend Yield (%)</th>					
	            </tr>
	            </thead>
	            <tbody>
	             <c:forEach items="${dividend_list}" var="dividend">	              
	             <tr>
	                <td><fmt:formatDate pattern="dd-MM-yyyy" value="${dividend.dividend_date}" /></td>
	                <%-- <td><c:out value="${dividend.dividend_value}"></c:out></td> --%>
	                <td><fmt:formatNumber type="number" minFractionDigits="4" value="${dividend.dividend_value}" /></td>
	                <td><c:out value="${dividend.net_asset_value}"></c:out></td>
	                <td><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${dividend.dividend_yield}" /></td>
	            </tr>
	            </c:forEach>
	            </tbody>
	       </table>
        </div> 
     	</div>
                </div>
             </div>
         </div>
      </div>
   </div>
</section>