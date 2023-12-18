<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	
	$('#tbl_sip_scheme_returns').dataTable({
		"pageLength": 10,
        "bPaginate": true,
        "bFilter": true,
        "bInfo": true,
        "bSort": true,
        "columns": [
		        	{ "width": "45%" },
		            { "width": "15%" },
		            { "width": "15%" },
		            { "width": "15%" },
		            { "width": "10%" },
		            { "width": "15%" },
		            { "width": "10%" }
                  ]
    }).fnSort([5,'desc']);
});

function getData()
{
 	var category = $.trim($("#sel_schemeCategories").val());
	var period = $.trim($("#sel_period").val());
	var amount = $.trim($("#sel_sip_amount").val());
 	
	top.location =  "/mutual-funds-research/top-performing-systematic-investment-plan?category="+category+"&period="+period+"&amount="+amount;
}

function downloadXl()
{
	var category = $.trim($("#sel_schemeCategories").val());
	var period = $.trim($("#sel_period").val());
	var amount = $.trim($("#sel_sip_amount").val());
 	
	//top.location =  "/mutual-funds-research/downloadTopPerformingSystematicInvestmentPlanXl?category="+category+"&period="+period+"&amount="+amount;
	
	var path = "/mutual-funds-research/downloadTopPerformingSystematicInvestmentPlanXl?category="+category+"&period="+period+"&amount="+amount;
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
	    	    	top.location =  "/mutual-funds-research/downloadTopPerformingSystematicInvestmentPlanXl?category="+category+"&period="+period+"&amount="+amount+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
	
	var category = $.trim($("#sel_schemeCategories").val());
	var period = $.trim($("#sel_period").val());
	var amount = $.trim($("#sel_sip_amount").val());
	downloadPath = "/mutual-funds-research/downloadTopPerformingSystematicInvestmentPlanXl?category="+category+"&period="+period+"&amount="+amount;
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
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Top Performing SIP Funds</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
          <div class="row">
          <div class="col-md-4 col-sm-4">
          <div class="form-group">
            <label class="font-600">Select Category</label>
            <select id="sel_schemeCategories" class="form-control input-sm">
             <c:forEach var="cat" items="${schemeCategories}" varStatus="status">
               <c:choose>
                <c:when test="${cat eq category}">
                  <option selected="selected" value="${cat}">${cat}</option>
                </c:when>
                <c:otherwise>
                <c:if test="${cat != 'Fixed Maturity Plans' && cat != 'Gold Funds'}">
                  <option value="${cat}">${cat}</option>
                </c:if>
                </c:otherwise>
               </c:choose>
             </c:forEach>
           </select>
          </div>
        </div>
             
        <div class="col-md-3 col-sm-3">
           <div class="form-group">
              <label class="font-600 block">Select Period</label>
             <select id="sel_period" class="form-control input-sm" data-width="100%">
			    <option <c:if test="${period eq '1' }"><c:out value="selected=\'selected\'" /></c:if> value="1">1 Year</option>
			    <option <c:if test="${period eq '2' }"><c:out value="selected=\'selected\'" /></c:if> value="2">2 Years</option>
			    <option <c:if test="${period eq '3' }"><c:out value="selected=\'selected\'" /></c:if> value="3">3 Years</option>
			    <option <c:if test="${period eq '4' }"><c:out value="selected=\'selected\'" /></c:if> value="4">4 Years</option>
			    <option <c:if test="${period eq '5' }"><c:out value="selected=\'selected\'" /></c:if> value="5">5 Years</option>
			    <option <c:if test="${period eq '6' }"><c:out value="selected=\'selected\'" /></c:if> value="6">6 Years</option>
			    <option <c:if test="${period eq '7' }"><c:out value="selected=\'selected\'" /></c:if> value="7">7 Years</option>
			    <option <c:if test="${period eq '8' }"><c:out value="selected=\'selected\'" /></c:if> value="8">8 Years</option>
			    <option <c:if test="${period eq '9' }"><c:out value="selected=\'selected\'" /></c:if> value="9">9 Years</option>
			    <option <c:if test="${period eq '10' }"><c:out value="selected=\'selected\'" /></c:if> value="10">10 Years</option>
			    <option <c:if test="${period eq '11' }"><c:out value="selected=\'selected\'" /></c:if> value="11">11 Years</option>
			    <option <c:if test="${period eq '12' }"><c:out value="selected=\'selected\'" /></c:if> value="12">12 Years</option>
			    <option <c:if test="${period eq '13' }"><c:out value="selected=\'selected\'" /></c:if> value="13">13 Years</option>
			    <option <c:if test="${period eq '14' }"><c:out value="selected=\'selected\'" /></c:if> value="14">14 Years</option>
			    <option <c:if test="${period eq '15' }"><c:out value="selected=\'selected\'" /></c:if> value="15">15 Years</option>
			    <option <c:if test="${period eq '16' }"><c:out value="selected=\'selected\'" /></c:if> value="16">16 Years</option>
			    <option <c:if test="${period eq '17' }"><c:out value="selected=\'selected\'" /></c:if> value="17">17 Years</option>
			    <option <c:if test="${period eq '18' }"><c:out value="selected=\'selected\'" /></c:if> value="18">18 Years</option>
			    <option <c:if test="${period eq '19' }"><c:out value="selected=\'selected\'" /></c:if> value="19">19 Years</option>
			    <option <c:if test="${period eq '20' }"><c:out value="selected=\'selected\'" /></c:if> value="20">20 Years</option>
			    <option <c:if test="${period eq '21' }"><c:out value="selected=\'selected\'" /></c:if> value="21">21 Years</option>
			    <option <c:if test="${period eq '22' }"><c:out value="selected=\'selected\'" /></c:if> value="22">22 Years</option>
			   </select>
           </div>
        </div>     
        
        <div class="col-md-3 col-sm-3">
          <div class="form-group">
             <label class="font-600">Select Amount</label>
             
             <select id="sel_sip_amount" onchange="onSipParameterChange()" class="form-control input-sm" data-width="100%">              
                  <option <c:if test="${amount eq '1000' }"><c:out value="selected=\'selected\'" /></c:if> value="1000">1000</option>
                  <option <c:if test="${amount eq '2000' }"><c:out value="selected=\'selected\'" /></c:if> value="2000">2000</option>
                  <option <c:if test="${amount eq '3000' }"><c:out value="selected=\'selected\'" /></c:if> value="3000">3000</option>
                  <option <c:if test="${amount eq '5000' }"><c:out value="selected=\'selected\'" /></c:if> value="5000">5000</option>
                  <option <c:if test="${amount eq '10000' }"><c:out value="selected=\'selected\'" /></c:if> value="10000">10000</option>
                  <option <c:if test="${amount eq '15000' }"><c:out value="selected=\'selected\'" /></c:if> value="15000">15000</option>
                  <option <c:if test="${amount eq '20000' }"><c:out value="selected=\'selected\'" /></c:if> value="20000">20000</option>
                  <option <c:if test="${amount eq '25000' }"><c:out value="selected=\'selected\'" /></c:if> value="25000">25000</option>
                  <option <c:if test="${amount eq '30000' }"><c:out value="selected=\'selected\'" /></c:if> value="30000">30000</option>
                  <option <c:if test="${amount eq '35000' }"><c:out value="selected=\'selected\'" /></c:if> value="35000">35000</option>
                  <option <c:if test="${amount eq '40000' }"><c:out value="selected=\'selected\'" /></c:if> value="40000">40000</option>
                  <option <c:if test="${amount eq '45000' }"><c:out value="selected=\'selected\'" /></c:if> value="45000">45000</option>
                  <option <c:if test="${amount eq '50000' }"><c:out value="selected=\'selected\'" /></c:if> value="50000">50000</option>
             </select>
             
        </div>
        </div>

          <div class="col-md-2 col-sm-2 sub">
		<div class="form-group">
			<label class="no-bold"> &nbsp;&nbsp;&nbsp; </label>
			<div class="marginTop15">
				<a href="javascript:void(0)" class="btn btn-primary hidden-xs" style="width: 100%;" onclick="getData()">Submit</a>
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
					        <div class="col-md-12 col-sm-12 marginTop20 marginBottom20 table-responsive">
							       <table class="table sunshine-table" id="tbl_sip_scheme_returns">
							        <thead class="theadBody">
							            <tr>
							                <th>Scheme Name</th>
							    	        <th>Launch Date</th>
							    	        <th class="text-right">AUM (Crore)</th>
							                <th class="text-right">Expense <br/> Ratio (%)</th>
							    	        <th class="text-right">Invested Amount</th>
							    	        <th class="text-right">Current Value</th>
							    	        <th class="text-right">Return&nbsp;(%)</th>						
							            </tr>
							            </thead>
							            <tbody>
							             <c:forEach items="${schemePerformances}" var="schemePerformances">	              
							             <tr>
							                <td><a href='/mutual-funds-research/<c:out value="${schemePerformances.scheme_name}"></c:out>' class="mutual-funds-anchor"><c:out value="${schemePerformances.scheme_name}"></c:out></a>
							                </td>
							                <td class="text-center"><fmt:formatDate pattern="dd-MM-yyyy" value="${schemePerformances.inception_date}" /></td>
											<td class="text-right">
									    	<c:choose>
									    	<c:when test="${schemePerformances.scheme_assets eq 0}">
									    		-
									    	</c:when>
									    	<c:otherwise>
									    		<fmt:formatNumber type="number" maxFractionDigits="2" value="${schemePerformances.scheme_assets / 10}"/>
									    	</c:otherwise>
									    	</c:choose>
									    	</td>
							                <td class="text-right">
									    	<c:choose>
									    	<c:when test="${schemePerformances.ter eq 0}">
									    		-
									    	</c:when>
									    	<c:otherwise>
									    		<c:out value="${schemePerformances.ter}"/>
									    	</c:otherwise>
									    	</c:choose>
									    	</td>
							                <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${schemePerformances.current_cost}" /></td>
							                <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${schemePerformances.current_value}" /></td>
							                <td class="text-right"><c:out value="${schemePerformances.returns}"></c:out></td>
							            </tr>
							            </c:forEach>
							            </tbody>
							            <tfoot> 
										<c:if test="${category_returns != null}">
							            <tr>
							                <td>Category Average</td>
							                <td class="text-center">-</td>
							                <td class="text-right">-</td>
							                <td class="text-right">-</td>
							                <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${category_returns.current_cost}" /></td>
							                <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${category_returns.current_value}" /></td>
							                <td class="text-right"><c:out value="${category_returns.returns}"></c:out></td>
							            </tr>
							            </c:if>
										<c:if test="${benchmark_returns != null}">
							            <tr>
							                <td><c:out value="${benchmark_returns.scheme_name}"></c:out></td>
							                <td class="text-center"><fmt:formatDate pattern="dd-MM-yyyy" value="${benchmark_returns.inception_date}" /></td>
							                <td class="text-right">-</td>
							                <td class="text-right">-</td>
							                <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${benchmark_returns.current_cost}" /></td>
							                <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="0" value="${benchmark_returns.current_value}" /></td>
							                <td class="text-right"><c:out value="${benchmark_returns.returns}"></c:out></td>
							            </tr>
							            </c:if>
							            </tfoot>
							       	</table>
					        		</div>
         	</div>
         </div>
       </div>
     </div>
</section>