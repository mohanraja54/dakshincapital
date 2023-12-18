<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style>
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
</style>

<script>
$(document).ready(function(){
		
	$('#tbl_scheme_returns').dataTable({
		"pageLength": 25,
        "bPaginate": true,
        "bFilter": true,
        "bInfo": true,
        "bSort": true,
        "aoColumnDefs": [
                         { 'bSortable': false, 'aTargets': [ 1,2 ] }
                      ],
                   "columns": [
   		        	{ "width": "35%" },
   		            { "width": "15%" },
   		            { "width": "25%" },
   		            { "width": "30%" },
   		            { "width": "5%" }
       ]
    }).fnSort([2,'desc']);
});
function getData()
{
 	var category = $.trim($("#sel_schemeCategories").val());
	var period = $.trim($("#sel_period").val());
	
	category = category.replace(/ /g,'-');
 	
	top.location =  "/mutual-funds-research/top-dividend-paying-mutual-funds/"+category+"?period="+period;
}
function downloadXl(){
	
	var category = $.trim($("#sel_schemeCategories").val());
	var period = $.trim($("#sel_period").val());
	
	category = category.replace(/ /g,'-');
	
	var path = "/mutual-funds-research/topDividendPayingMutualFunds?category="+category+"&period="+period;
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
	        		//console.log(xhr.response);
	 	            //console.log(xhr.responseText);
	    	    }
	    	    else{
	    	    	top.location =  "/mutual-funds-research/topDividendPayingMutualFunds?category="+category+"&period="+period+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
	var category = $.trim($("#sel_schemeCategories").val());
	var period = $.trim($("#sel_period").val());
	
	category = category.replace(/ /g,'-');
	
	downloadPath = "/mutual-funds-research/topDividendPayingMutualFunds?category="+category+"&period="+period;
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
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Top Dividend Paying Mutual Funds</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
          <div class="row">
          <div class="col-md-4 col-sm-4">
          <div class="form-group">
            <label class="font-600">Select Category</label>
            <select id="sel_schemeCategories" class="form-control input-sm">
             <c:forEach var="cat" items="${schemeCategories}" varStatus="status">
               <c:choose>
                <c:when test="${cat eq scheme_category}">
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
        <div class="col-md-4 col-sm-4">
           <div class="form-group">
              <label class="font-600">Select Period</label>
              <select id="sel_period" class="form-control input-sm">
              	<option <c:if test="${period eq '1' }"><c:out value="selected=\'selected\'" /></c:if> value="1">1 Year</option>
			    <option <c:if test="${period eq '3' }"><c:out value="selected=\'selected\'" /></c:if> value="3">3 Years</option>
			    <option <c:if test="${period eq '5' }"><c:out value="selected=\'selected\'" /></c:if> value="5">5 Years</option>
			    <option <c:if test="${period eq '7' }"><c:out value="selected=\'selected\'" /></c:if> value="7">7 Years</option>
			    <option <c:if test="${period eq '10' }"><c:out value="selected=\'selected\'" /></c:if> value="10">10 Years</option>
			   </select>
           </div>
        </div>
        
         <div class="col-md-3 col-sm-3 sub">
          	<div class="form-group">
          	<label class="no-bold"> &nbsp;&nbsp;&nbsp; </label>
				<div class="marginTop15">
					<a href="javascript:void(0)" class="btn btn-primary hidden-xs"  style="position: absolute;top: 35%;width: 45%;" onclick="getData()">Submit</a>
				</div>
			</div>
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
            <div class="col-md-12 col-sm-12">
                   <div class="row marginTop20">
		        <div class="col-md-12 col-sm-12 table-responsive">
			       <table class="table dataTable" id="tbl_scheme_returns">
			        <thead class="theadBody">
			            <tr>
			                <th>Scheme Name</th>
			                <th>Launch Date</th>
			                <th>Trailing ${period} year Annual Dividend Yield (Distribution yield)</th>
			                <th style="width:250px;">Period Range</th>
			                <th>Dividend History</th>
			            </tr>
			            </thead>
			            <tbody>
			            <c:forEach items="${divided_annualized_returns_list}" var="divided_returns">	              
			            <tr>
			                <td><a href='/mutual-funds-research/mutual-funds-historical-dividends/<c:out value="${divided_returns.scheme_name}"></c:out>' class="mutual-funds-anchor"><c:out value="${divided_returns.scheme_name}"></c:out></a>
			                </td>
			                <td><fmt:formatDate pattern="dd-MM-yyyy" value="${divided_returns.inception_date}" /></td>
			                <c:choose>
			                <c:when test="${divided_returns.returns eq 0 }">
			                <td>-</td>
			                </c:when>
			                <c:otherwise>
			                <td>
			                <fmt:formatNumber value="${divided_returns.returns * 100}" maxFractionDigits="2" />%</td>
			                </c:otherwise>
			                </c:choose>
			                <td><fmt:formatDate pattern="dd-MM-yyyy" value="${divided_returns.start_date}" /> To <fmt:formatDate pattern="dd-MM-yyyy" value="${end_date}" /></td>
			                <td class="text-center"><a href='/mutual-funds-research/mutual-funds-historical-dividends/<c:out value="${divided_returns.scheme_name}"></c:out>'><i class="fa fa-plus-circle fa-lg" aria-hidden="true"></i></a></td>
			            </tr>
			            </c:forEach>
			            </tbody>
			       </table>
		        </div>
		        </div>
		        
		        <div class="row">
				<div class="col-md-12 col-sm-12 margintop20">
			        <p style="text-align:justify;font-size:12px;">Trailing Annual Dividend Yield is defined as the ratio of aggregate trailing per unit dividends over the period to the current NAV, divided by the number of the years in the period.</p>
				</div>
				</div>
            </div>
         </div>
     </div>
   </div>
</section>