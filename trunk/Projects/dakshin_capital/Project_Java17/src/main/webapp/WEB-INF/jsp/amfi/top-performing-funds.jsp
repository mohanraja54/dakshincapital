<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
#tbl_scheme_returns thead th {
	padding: 2px 16px !important;
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
	
	var period = '${period}';

	var period_sort = 3;
	if(period == "1y" || period == "1w")
	{
		period_sort = 3;
	}
	if(period == "2y" || period == "1m")
	{
		period_sort = 4;
	}
	if(period == "3y" || period == "3m")
	{
		period_sort = 5;
	}
	if(period == "5y" || period == "6m")
	{
		period_sort = 6;
	}
	if(period == "10y" || period == "ytd")
	{
		period_sort = 7;
	}
	if(period == "Since Inception")
	{
		period_sort = 8;
	}
	
	$('#tbl_scheme_returns').dataTable({
		"pageLength": 10,
        "bPaginate": true,
        "bFilter": true,
        "bInfo": true,
        "bSort": true,
        "aoColumnDefs": [
                         { 'bSortable': false, 'aTargets': [ 1,2 ] }
                      ],
        "columns": [
                    { "width": "52%" },
                    { "width": "15%" },
                    { "width": "8%" },
                    { "width": "8%" },
                    { "width": "8%" },
                    { "width": "8%" },
                    { "width": "8%" },
                    { "width": "8%" },
                    { "width": "8%" }
                  ]
    }).fnSort([period_sort,'desc']);
	
});

function getData()
{
 	var category = $.trim($("#sel_schemeCategories").val());
	var period = $.trim($("#sel_period").val());
	var type = $.trim($("#sel_type").val());
 	var mode = "Growth";
 	
	top.location =  "/mutual-funds-research/top-performing-mutual-funds?category="+category+"&period="+period+"&type="+type+"&mode="+mode;
}

function downloadXl()
{

	var category = $.trim($("#sel_schemeCategories").val());
	var period = $.trim($("#sel_period").val());
	var type = $.trim($("#sel_type").val());
 	var mode = "Growth";
	
	var path = "/mutual-funds-research/downloadTopPerformingFundsXl?category="+category+"&period="+period+"&type="+type+"&mode="+mode;
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
	    	    	top.location =  "/mutual-funds-research/downloadTopPerformingFundsXl?category="+category+"&period="+period+"&type="+type+"&mode="+mode+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
	
	var category = $.trim($("#sel_schemeCategories").val());
	var period = $.trim($("#sel_period").val());
	var type = $.trim($("#sel_type").val());
 	var mode = "Growth";
 	downloadPath = "/mutual-funds-research/downloadTopPerformingFundsXl?category="+category+"&period="+period+"&type="+type+"&mode="+mode;
 	imageDownload = "no";
	chartId = "";
	filename = "";
	$("#adv-login").modal("show");
}

</script>

<!-- main-container start -->
<!-- ================ -->
<section class="main-container mf-research">

	<div class="container-fluid pr-0 pl-0">
	<div class="row ml-0 mr-0">
		<div class="col-md-3 bg-mfbar py-3">
			<c:choose>
			  	<c:when test="${category_name eq ''}">
			  		<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Top Performing Mutual Funds</h1>
			  	</c:when>
			  	<c:otherwise>
			  		<h1 class="amfi-title bold mb-0 pl-3 pt-4">Top Performing Mutual Funds - ${category_name}</h1>
			  	</c:otherwise>
		  	</c:choose>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
	        <div class="row">
	        <div class="col-md-4 col-sm-4">
	          <div class="form-group">
	            <label class="font-600">Select Category</label>
	            <select id="sel_schemeCategories" class="form-control selectpicker">
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
	        <div class="col-md-3 col-sm-3">
	           <div class="form-group">
	              <label class="font-600">Select Period</label>
	              <select id="sel_period" class="form-control selectpicker">
				    <option <c:if test="${period eq 'ytd' }"><c:out value="selected=\'selected\'" /></c:if> value="ytd">YTD</option>
				    <option <c:if test="${period eq '1w' }"><c:out value="selected=\'selected\'" /></c:if> value="1w">1 Week</option>
				    <option <c:if test="${period eq '1m' }"><c:out value="selected=\'selected\'" /></c:if> value="1m">1 Month</option>
				    <option <c:if test="${period eq '3m' }"><c:out value="selected=\'selected\'" /></c:if> value="3m">3 Month</option>
				    <option <c:if test="${period eq '6m' }"><c:out value="selected=\'selected\'" /></c:if> value="6m">6 Month</option>
				    <option <c:if test="${period eq '1y' }"><c:out value="selected=\'selected\'" /></c:if> value="1y" >1 Year</option>
				    <option <c:if test="${period eq '2y' }"><c:out value="selected=\'selected\'" /></c:if> value="2y">2 Years</option>
				    <option <c:if test="${period eq '3y' }"><c:out value="selected=\'selected\'" /></c:if> value="3y">3 Years</option>
				    <option <c:if test="${period eq '5y' }"><c:out value="selected=\'selected\'" /></c:if> value="5y">5 Years</option>
				    <option <c:if test="${period eq '10y' }"><c:out value="selected=\'selected\'" /></c:if> value="10y">10 Years</option>
				    <option <c:if test="${period eq 'Since Inception' }"><c:out value="selected=\'selected\'" /></c:if> value="Since Inception">Since Inception</option>
				   </select>
	           </div>
	        </div>
	        
	        <div class="col-md-3 col-sm-3">
	           <div class="form-group">
	              <label class="font-600">Scheme Type</label>
		           <select id="sel_type" class="form-control selectpicker">
		           	<option value="Open" <c:if test="${type eq 'Open' }"><c:out value="selected" /></c:if>>Open</option>
		            <option value="Close" <c:if test="${type eq 'Close' }"><c:out value="selected" /></c:if>>Closed</option>
		           </select>
	           </div>
	        </div>
	        
	         <div class="col-md-2 col-sm-2">
	         	   <a href="javascript:void(0)" class="btn btn-primary hidden-xs btn-xss" style="position: absolute;top: 35%;width:70%;" onclick="getData()">Submit</a>	         	   
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
     	
	        <div class="col-md-12 col-sm-12 table-responsive mt-1">
		       <table class="table" id="tbl_scheme_returns">
		        <thead>
		            <tr>
		                <th>Scheme Name</th>
		                <th>Launch<br> Date</th>
		                <th class="text-right">Expense <br> Ratio&nbsp;(%)</th>
		                <c:if test="${period eq '1w' || period eq '1m' || period eq '3m' || period eq '6m' || period eq 'ytd'}">
		                <th class="text-right">1-Week <br/> Ret&nbsp;(%)</th>
		                <th class="text-right">1-Month<br/> Ret&nbsp;(%)</th>
		                <th class="text-right">3-Months <br/>Ret&nbsp;(%)</th>
		                <th class="text-right">6-Months <br/>Ret&nbsp;(%)</th>
		                <th class="text-right">YTD <br/>Ret&nbsp;(%)</th>
		                <th class="text-right">1-Yr<br/> Ret&nbsp;(%)</th>
		                </c:if>
		                <c:if test="${period eq '1y' || period eq '2y' || period eq '3y' || period eq '5y' || period eq '10y' || period eq 'Since Inception'}">
		                <th class="text-right">1-Year<br/> Ret&nbsp;(%)</th>	
		                <th class="text-right">2-Yrs <br/>Ret&nbsp;(%)</th>	
		                <th class="text-right">3-Yrs<br/> Ret&nbsp;(%)</th>	
		                <th class="text-right">5-Yrs <br/>Ret&nbsp;(%)</th>	
		                <th class="text-right">10-Yrs <br/>Ret&nbsp;(%)</th>	
		                <th class="text-right">Since Launch<br/> Ret&nbsp;(%)</th>	
		                </c:if>					
		            </tr>
		            </thead>
		            <tbody>
		            <c:forEach items="${schemePerformances}" var="schemePerformances">	              
		              <tr>
		                <td><a href='/mutual-funds-research/<c:out value="${schemePerformances.scheme_amfi}"></c:out>' class="mutual-funds-anchor"><c:out value="${schemePerformances.scheme_amfi}"></c:out></a></td>
		                <td><fmt:formatDate pattern="dd-MM-yyyy" value="${schemePerformances.inception_date}" /></td>
		                <td class="text-right"><c:out value="${schemePerformances.ter}"></c:out></td>
		                <c:if test="${period eq '1w' || period eq '1m' || period eq '3m' || period eq '6m' || period eq 'ytd'}">
		                <td class="text-right"><c:out value="${schemePerformances.returns_abs_7days eq 0 ? '-': schemePerformances.returns_abs_7days}"></c:out></td>
		                <td class="text-right"><c:out value="${schemePerformances.returns_abs_1month eq 0 ? '-': schemePerformances.returns_abs_1month}"></c:out></td>
		                <td class="text-right"><c:out value="${schemePerformances.returns_abs_3month eq 0 ? '-': schemePerformances.returns_abs_3month}"></c:out></td>
		                <td class="text-right"><c:out value="${schemePerformances.returns_abs_6month eq 0 ? '-': schemePerformances.returns_abs_6month}"></c:out></td>
		                <td class="text-right"><c:out value="${schemePerformances.returns_abs_ytd eq 0 ? '-': schemePerformances.returns_abs_ytd}"></c:out></td>
		                <td class="text-right"><c:out value="${schemePerformances.returns_abs_1year eq 0 ? '-': schemePerformances.returns_abs_1year}"></c:out></td>
		                </c:if>
		                <c:if test="${period eq '1y' || period eq '2y' || period eq '3y' || period eq '5y' || period eq '10y' || period eq 'Since Inception'}">
		                <td class="text-right"><c:out value="${schemePerformances.returns_abs_1year eq 0 ? '-': schemePerformances.returns_abs_1year}"></c:out></td>
		                <td class="text-right"><c:out value="${schemePerformances.returns_cmp_2year eq 0 ? '-': schemePerformances.returns_cmp_2year}"></c:out></td>
		                <td class="text-right"><c:out value="${schemePerformances.returns_cmp_3year eq 0 ? '-': schemePerformances.returns_cmp_3year}"></c:out></td>
		                <td class="text-right"><c:out value="${schemePerformances.returns_cmp_5year eq 0 ? '-': schemePerformances.returns_cmp_5year}"></c:out></td>
		                <td class="text-right"><c:out value="${schemePerformances.returns_cmp_10year eq 0 ? '-': schemePerformances.returns_cmp_10year}"></c:out></td>
		                <td class="text-right"><c:out value="${schemePerformances.returns_cmp_inception eq 0 ? '-': schemePerformances.returns_cmp_inception}"></c:out></td>
		                </c:if>
		            </tr>
		            </c:forEach>
		            </tbody>
		            <c:if test="${fn:indexOf(header['User-Agent'],'Mobile')  == -1}">
							<tfoot>  
								<c:if test="${category_returns != null}">
								<tr>
					                <td>Category Average</td>
					                <td>-</td>
					                <td>-</td>					               
					                <c:if test="${period eq '1w' || period eq '1m' || period eq '3m' || period eq '6m' || period eq 'ytd'}">
					                <td class="text-right"><c:out value="${category_returns.returns_abs_7days eq 0 ? '-': category_returns.returns_abs_7days}"></c:out></td>
					                <td class="text-right"><c:out value="${category_returns.returns_abs_1month eq 0 ? '-': category_returns.returns_abs_1month}"></c:out></td>
					                <td class="text-right"><c:out value="${category_returns.returns_abs_3month eq 0 ? '-': category_returns.returns_abs_3month}"></c:out></td>
					                <td class="text-right"><c:out value="${category_returns.returns_abs_6month eq 0 ? '-': category_returns.returns_abs_6month}"></c:out></td>
					                <td class="text-right"><c:out value="${category_returns.returns_abs_ytd eq 0 ? '-': category_returns.returns_abs_ytd}"></c:out></td>
					                <td class="text-right"><c:out value="${category_returns.returns_abs_1year eq 0 ? '-': category_returns.returns_abs_1year}"></c:out></td>
					                </c:if>
					                <c:if test="${period eq '1y' || period eq '2y' || period eq '3y' || period eq '5y' || period eq '10y' || period eq 'Since Inception'}">
					                <td class="text-right"><c:out value="${category_returns.returns_abs_1year eq 0 ? '-': category_returns.returns_abs_1year}"></c:out></td>
					                <td class="text-right"><c:out value="${category_returns.returns_cmp_2year eq 0 ? '-': category_returns.returns_cmp_2year}"></c:out></td>
					                <td class="text-right"><c:out value="${category_returns.returns_cmp_3year eq 0 ? '-': category_returns.returns_cmp_3year}"></c:out></td>
					                <td class="text-right"><c:out value="${category_returns.returns_cmp_5year eq 0 ? '-': category_returns.returns_cmp_5year}"></c:out></td>
					                <td class="text-right"><c:out value="${category_returns.returns_cmp_10year eq 0 ? '-': category_returns.returns_cmp_10year}"></c:out></td>
					                <td class="text-right"><c:out value="${category_returns.returns_cmp_inception eq 0 ? '-': category_returns.returns_cmp_inception}"></c:out></td>
					                </c:if>
					            </tr>    
					            </c:if>
					            
					            <c:if test="${benchmark_returns != null}">       
					            <tr>
					                <td><c:out value="${benchmark_returns.benchmark_name}"></c:out></td>
					                <td>-</td>
					                <td>-</td>					                
					                <c:if test="${period eq '1w' || period eq '1m' || period eq '3m' || period eq '6m' || period eq 'ytd'}">
					                <td class="text-right"><c:out value="${benchmark_returns.returns_abs_7days eq 0 ? '-': benchmark_returns.returns_abs_7days}"></c:out></td>
					                <td class="text-right"><c:out value="${benchmark_returns.returns_abs_1month eq 0 ? '-': benchmark_returns.returns_abs_1month}"></c:out></td>
					                <td class="text-right"><c:out value="${benchmark_returns.returns_abs_3month eq 0 ? '-': benchmark_returns.returns_abs_3month}"></c:out></td>
					                <td class="text-right"><c:out value="${benchmark_returns.returns_abs_6month eq 0 ? '-': benchmark_returns.returns_abs_6month}"></c:out></td>
					                <td class="text-right"><c:out value="${benchmark_returns.returns_abs_ytd eq 0 ? '-': benchmark_returns.returns_abs_ytd}"></c:out></td>
					                <td class="text-right"><c:out value="${benchmark_returns.returns_abs_1year eq 0 ? '-': benchmark_returns.returns_abs_1year}"></c:out></td>
					                </c:if>
					                <c:if test="${period eq '1y' || period eq '2y' || period eq '3y' || period eq '5y' || period eq '10y' || period eq 'Since Inception'}">
					                <td class="text-right"><c:out value="${benchmark_returns.returns_abs_1year eq 0 ? '-': benchmark_returns.returns_abs_1year}"></c:out></td>
					                <td class="text-right"><c:out value="${benchmark_returns.returns_cmp_2year eq 0 ? '-': benchmark_returns.returns_cmp_2year}"></c:out></td>
					                <td class="text-right"><c:out value="${benchmark_returns.returns_cmp_3year eq 0 ? '-': benchmark_returns.returns_cmp_3year}"></c:out></td>
					                <td class="text-right"><c:out value="${benchmark_returns.returns_cmp_5year eq 0 ? '-': benchmark_returns.returns_cmp_5year}"></c:out></td>
					                <td class="text-right"><c:out value="${benchmark_returns.returns_cmp_10year eq 0 ? '-': benchmark_returns.returns_cmp_10year}"></c:out></td>
					                <td class="text-right"><c:out value="${benchmark_returns.returns_cmp_inception eq 0 ? '-': benchmark_returns.returns_cmp_inception}"></c:out></td>
					                </c:if>
					            </tr>
					            </c:if>
					        </tfoot>
					        </c:if>
		       </table>
	        </div>
	              
	      </div>

     </div>
	</div>
</section>
<!-- main-container end -->