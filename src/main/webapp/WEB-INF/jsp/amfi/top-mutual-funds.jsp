<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>

.fund_hover {
	line-height: 25px;
}
.ret_label {
	font-size: 14px;
	color: #777;
}
.nav-pills > li.active > a, .nav-pills > li.active > a:focus, .nav-pills > li.active > a:hover {
	color: #FF4F00;
	background-color: #fff;
	border-bottom: 3px solid #FF4F00;
	border-radius: 0px !important;
	font-weight: bold;
}

.menuli > a, .menuli > a:focus, .menuli > a:hover {
	border:none !important;
}
.nav-pills a {
    color: #000;
    text-decoration: none;    
}
 .nav-pills a .active{
    font-weight: bold !important; 
} 
.padding-0 {
	padding: 0px;
}
.horizonBtn {
	box-shadow: 4px 4px 10px 1px #d3d3d3;
}
.activePeriod {
	border: 2px solid #005e96;
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

</style>

<script>
var periodTop = "1y";
$(document).ready(function()
{
	getTopFunds();

	$('.horizonBtn').removeClass('activePeriod');
	$('.'+periodTop).addClass('activePeriod');
});

function getTopFunds() {
	category = $("#sel_top_category").val();

	if ( $.fn.DataTable.isDataTable('#tbl_scheme_returns') ) {
		  $('#tbl_scheme_returns').DataTable().destroy();
	}
	
	$('#tbl_scheme_returns').html("<div class='text-center'><img src='/images/loading.gif' alt='loading'></div>");
	
	$.ajaxSetup({async:true});
	$.post("/mutual-funds-research/getTopMutualFundsFull", {category : category, period : periodTop}, function(data)
    {
		var top10FundsByCategory = $.trim(data);
		var top10FundsByCategory_obj = jQuery.parseJSON(top10FundsByCategory);
		var top10FundsByCategory_array = $.makeArray(top10FundsByCategory_obj);
        var html = "";

        html += "<thead><tr>";
        html += "<th>Scheme Name</th>";
        html += "<th>Inception Date</th>";
        html += "<th>Return in (%)</th>";
        html += "<th>Rs. 1L Grew to <br> (One-Time)</th>";
        html += "<th>Rs. 5000 Grew to<br>(SIP)</th>";
        html += "</tr></thead>";
        
        html += "<tbody>";
		for (var i = 0; i < top10FundsByCategory_array.length ; i++)
	    {
			var scheme_name = top10FundsByCategory_array[i].scheme_amfi;
			var category_name = top10FundsByCategory_array[i].scheme_category;

			var today = new Date(top10FundsByCategory_array[i].inception_date);
			var dd = today.getDate();
			var mm = today.getMonth() + 1; //January is 0!

			var yyyy = today.getFullYear();
			if (dd < 10) {
			  dd = '0' + dd;
			} 
			if (mm < 10) {
			  mm = '0' + mm;
			} 
			var today = dd + '-' + mm + '-' + yyyy;
			
			var returnToDisplay = top10FundsByCategory_array[i].returnToDisplay == 0 ? "-" :  top10FundsByCategory_array[i].returnToDisplay
			var lumpsumToDisplay = top10FundsByCategory_array[i].lumpsumToDisplay;
			var sipToDisplay = top10FundsByCategory_array[i].sipToDisplay;
			
			html += "<tr style='border-bottom: 1px solid #ddd;'>";
		    html += "<td class='fund_hover'><a href='/mutual-funds-research/" + scheme_name + "'>" + scheme_name + "</a>";
		    html += "<br><span class='ret_label'>"+category_name+"</span>";
		    html += "</td>";
		    html += "<td class='text-left'> "+ today +" </td>";
		    html += "<td class='text-left'> "+returnToDisplay+" </td>";
		    html += "<td class='text-left'> "+numbersWithComma(parseFloat(lumpsumToDisplay).toFixed(0))+" </td>";
		    html += "<td class='text-left'> "+numbersWithComma(parseFloat(sipToDisplay).toFixed(0))+" </td>";
		    html += "</tr>";	
	    }
		html += "</tbody>"; 

		$('#tbl_scheme_returns').empty();
		$('#tbl_scheme_returns').html(html);
    	$('#tbl_scheme_returns').dataTable({
    		"pageLength": 10,
    	    "bPaginate": true,
    	    "bFilter": true,
    	    "bInfo": true,
    	    "bSort": true,
    	    "aoColumnDefs": [
                { 'bSortable': false, 'aTargets': [ 1 ] }         
    		],
    	    "columns": [
    			{ "width": "45%" },
    			{ "width": "15%" },
                { "width": "10%" },
                { "width": "15%" },
                { "width": "15%" }
    	]
    	}).fnSort([2,'desc']);
    	
    	    
    },'text'); 
}

function updatePeriod(time) {
	periodTop = time;
	$('.horizonBtn').removeClass('activePeriod');
	$('.'+periodTop).addClass('activePeriod');
	getTopFunds();	
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

function downloadXl()
{
	category = $("#sel_top_category").val();
	
	var path = "/mutual-funds-research/topmutualfunds2020?category="+category+"&period="+periodTop;
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
	    	    	top.location =  "/mutual-funds-research/topmutualfunds2020?category="+category+"&period="+periodTop+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
}

function openLogin(){
	category = $("#sel_top_category").val();
 	downloadPath = "/mutual-funds-research/topmutualfunds2020?category="+category+"&period="+periodTop;
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
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Top Mutual Funds - 2020</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
			           		<div class="col-md-12 col-sm-12">
           			<div class="panel panel-default adv-panel">

           				
           				 <div class="panel-body row marginTop20">
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
			            	<div class="col-lg-5 col-md-5 col-sm-5 col-xs-12 padding-0">
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
						 			<div class="col padding-0" style="margin-left: 1%;">
						 				<button onclick="updatePeriod('SI')" class="btn horizonBtn SI">Inception</button> 				
						 			</div>
				 				</div>
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
		       	<div class="row" style="margin-left: 15px;margin-right: 15px;margin-bottom: 10px;">
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
       			
       			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 table-responsive">
	 				<table class="adv-table table" id="tbl_scheme_returns" style="width: 100%;border: none;">
			        <thead>
		            <tr>
		             	<th>Scheme Name</th>
		             	<th>Inception Date</th>
		                <th>Return in (%)</th>	
		                <!-- <th>Doubled In</th>	 -->
		                <th>Rs. 1L Grew to <br> (One-Time)</th>
		                <th>Rs. 5000 Grew to<br>(SIP)</th>
		            </tr>
		            </thead>
			            <tbody>
			            <c:forEach items="${top10FundsByCategory}" var="top10FundsByCategory">	              
		              	<tr>
			                <td>
			                	<a href='/mf-research/<c:out value="${top10FundsByCategory.scheme_amfi}"></c:out>' class="mutual-funds-anchor"><c:out value="${top10FundsByCategory.scheme_amfi}"></c:out></a>   
			                	<br><span class="categorySpan"> ${top10FundsByCategory.scheme_category} </span>          	                
			                </td>
			                <td><fmt:formatDate pattern="dd-MM-yyyy" value="${top10FundsByCategory.inception_date}" /></td>
			               <td>
			                	<span>
			                	<c:out value="${top10FundsByCategory.returnToDisplay eq 0 ? '-': top10FundsByCategory.returnToDisplay}"></c:out>
			                	</span>
			                </td>	
			                <%-- <td>${top10FundsByCategory.doubled_in}</td> --%>
			                <td class="lumpToDisp">${top10FundsByCategory.lumpsumToDisplay}</td>
			                <td class="sipToDisp">${top10FundsByCategory.sipToDisplay}</td>
		            	</tr>
		            	</c:forEach>
			          </tbody>		        
			       </table>
	 			</div>
           </div>
        </div>
    </div>
</section>
<!-- main-container end -->