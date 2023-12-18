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
table.dataTable {
    border-bottom: 1px solid #dedede;
}
</style>


<script>
$(document).ready(function(){
	
	$('.datepicker').datepicker({
		format: 'dd-mm-yyyy',
		startDate: '01/01/2000',
		endDate: '-1d',
		autoclose:true,
		disableTouchKeyboard:true
	});
	
	var years = '${years}';
	var end_date = '${end_date}';
    var arr = end_date.split("-");
    var end_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
    var endDate =  new Date(end_date_str);
    var march_date =  new Date("2017-03-31");
    if(endDate > march_date && years > 3)
	{
		$(".color_red").html("* The CPI index for current FY not available. Therefore, Indexation calculated based on the last available CPI index");
	}else
	{
		$(".color_red").html("");
	}
	
	$('#sip-submit').click(function(e){
	 	e.preventDefault();
	 	
	 	var amount = $("#txt_fd_amount").val();
	 	var start_date = $("#txt_start_date").val();
	 	var end_date = $("#txt_end_date").val();
	 	var amc = 	$("#sel_amc").val();
	    var category = 	$("#sel_category").val();
	 	var fund = $("#sel_scheme").val();
	 	var tax_rate = $("#sel_tax_rate").val();
	 	var savings_rate = $("#sel_savings_rate").val();

	 	if(amount == null || amount == "" || isNaN(amount) || parseFloat(amount)<=0)
	    {
	 		$("#adv-alert-msg").html("Please enter the valid deposit amount");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	if(start_date == null || start_date == "")
	    {
	 		$("#adv-alert-msg").html("Please select start date");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	if(end_date == null || end_date == "")
	    {
	 		$("#adv-alert-msg").html("Please select end date");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	if(amc == null || amc == "")
	 	{
	 		$("#adv-alert-msg").html("Please select AMC");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	 	}
	 	if(category == null || category == "")
	 	{
	 		$("#adv-alert-msg").html("Please select category");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	 	}
	 	if(fund == null || fund == "")
	 	{
	 		$("#adv-alert-msg").html("Please select scheme name");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	 	}
	 	if(tax_rate == null || tax_rate == "" || isNaN(tax_rate) || parseFloat(tax_rate)<=0)
	    {
	 		$("#adv-alert-msg").html("Please select income tax rate");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	if(savings_rate == null || savings_rate == "" || isNaN(savings_rate) || parseFloat(savings_rate)<=0)
	    {
	 		$("#adv-alert-msg").html("Please select savings bank rate");
	   	    $("#adv-alert").modal('show');
	   	    return false;
	    }
	 	var arr = start_date.split("-");
	    var start_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
	    var startDate =  new Date(start_date_str);
	    var flag = false;
	    
	    var schemeName = encodeURIComponent(fund);
		var flag = false;
		
		$.ajaxSetup({async:false});
		$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
	    {
			var schemes = $.trim(data);
			var schemes_obj = jQuery.parseJSON(schemes);
			var schemes_array = $.makeArray(schemes_obj);
			var from = schemes_array[0].split("-");
			var inception_date = new Date(from[2], from[1] - 1, from[0]);
			if(startDate < inception_date)
			{
				$("#adv-alert-msg").html(fund+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
		   	    $("#adv-alert").modal('show');
		   	 	flag = true;
				return false;
			}
	    },'text');
		
		if(flag)
		{
			return false;
		}
	 	
		document.location =  "/mutual-funds-research/liquid-funds-vs-savings-bank?scheme="+schemeName+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&savings_rate="+savings_rate+"&category="+category+"&amc="+amc;
	 	
	 	return false;
	});

});
function categoryChange()
{
	var amc = 	$("#sel_amc").val();
    var category = 	$("#sel_category").val();
    var start_date = $("#txt_start_date").val();
    
    if(amc == null || amc == "")
 	{
 		$("#adv-alert-msg").html("Please select AMC");
   	    $("#adv-alert").modal('show');
   	    return false;
 	}
 	if(category == null || category == "")
 	{
 		$("#adv-alert-msg").html("Please select category");
   	    $("#adv-alert").modal('show');
   	    return false;
 	}
 	if(start_date == null || start_date == "")
    {
 		$("#adv-alert-msg").html("Please select start date");
   	    $("#adv-alert").modal('show');
   	    return false;
    }
    
    $.ajaxSetup({async:true});
	$.post("/mutual-funds-research/getSchemeByAmcAndCategoryAndDate", {amc : "" + amc + "",category : "" + category + "", start_date : "" + start_date + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var html = "";
		for (var i = 0; i < schemes_array.length; i++)
	    {
			html += '<option value="' + schemes_array[i]+ '">' + schemes_array[i] + '</option>';
	    }
		$("#sel_scheme").html(html);
		$('#sel_scheme').selectpicker('refresh');
		
    },'text');
}

function saveResult() 
{	
	var amount = $("#txt_fd_amount").val();
 	var start_date = $("#txt_start_date").val();
 	var end_date = $("#txt_end_date").val();
 	var amc = 	$("#sel_amc").val();
    var category = 	$("#sel_category").val();
 	var fund = $("#sel_scheme").val();
 	var tax_rate = $("#sel_tax_rate").val();
 	var savings_rate = $("#sel_savings_rate").val();
 	
	var accountMap = '${accountMap}';
	var title = "Liquid Funds vs Savings Bank -> Deposit Amount = " + amount + ", Start Date = " + start_date + ", End Date = " + end_date + ", Category = " + category + ", Scheme = " + fund + ", AMC = " + amc + ", Income Tax Rate = " + tax_rate + ", Savings Bank Interest Rate = " + savings_rate;
	var url = window.location;
	
	if(accountMap == undefined || accountMap == null || accountMap == "" || accountMap == "null")
	{
		advisorkhoj_result_title = title;
		advisorkhoj_result_url = window.location.href;
		
		$("#adv-contact-advisor-signin-signup").modal("show");
	}
	else
	{
		saveUserResult("MF Tools",title, url);
	}
}

function downloadXl()
{
	var amount = $("#txt_fd_amount").val();
 	var start_date = $("#txt_start_date").val();
 	var end_date = $("#txt_end_date").val();
 	var amc = 	$("#sel_amc").val();
    var category = 	$("#sel_category").val();
 	var fund = $("#sel_scheme").val();
 	var tax_rate = $("#sel_tax_rate").val();
 	var savings_rate = $("#sel_savings_rate").val();

 	if(amount == null || amount == "" || isNaN(amount) || parseFloat(amount)<=0)
    {
 		//$("#adv-alert-msg").html("Please enter the valid deposit amount");
   	    //$("#adv-alert").modal('show');
   	    alert("Please enter the valid deposit amount");
   	    return false;
    }
 	if(start_date == null || start_date == "")
    {
 		//$("#adv-alert-msg").html("Please select start date");
   	    //$("#adv-alert").modal('show');
   	    alert("Please select start date");
   	    return false;
    }
 	if(end_date == null || end_date == "")
    {
 		//$("#adv-alert-msg").html("Please select end date");
   	    //$("#adv-alert").modal('show');
   	    alert("Please select end date");
   	    return false;
    }
 	if(amc == null || amc == "")
 	{
 		//$("#adv-alert-msg").html("Please select AMC");
   	    //$("#adv-alert").modal('show');
   	    alert("Please select AMC");
   	    return false;
 	}
 	if(category == null || category == "")
 	{
 		//$("#adv-alert-msg").html("Please select category");
   	    //$("#adv-alert").modal('show');
   	    alert("Please select category");
   	    
   	    return false;
 	}
 	if(fund == null || fund == "")
 	{
 		//$("#adv-alert-msg").html("Please select scheme name");
   	    //$("#adv-alert").modal('show');
   	    alert("Please select scheme name");
   	    return false;
 	}
 	if(tax_rate == null || tax_rate == "" || isNaN(tax_rate) || parseFloat(tax_rate)<=0)
    {
 		//$("#adv-alert-msg").html("Please select income tax rate");
   	    //$("#adv-alert").modal('show');
   	    alert("Please select income tax rate");
   	    return false;
    }
 	if(savings_rate == null || savings_rate == "" || isNaN(savings_rate) || parseFloat(savings_rate)<=0)
    {
 		//$("#adv-alert-msg").html("Please select savings bank rate");
   	   // $("#adv-alert").modal('show');
   	   alert("Please select savings bank rate");
   	    return false;
    }
 	var arr = start_date.split("-");
    var start_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
    var startDate =  new Date(start_date_str);
    var flag = false;
    
    var schemeName = encodeURIComponent(fund);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(startDate < inception_date)
		{
			//$("#adv-alert-msg").html(fund+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
	   	   // $("#adv-alert").modal('show');
	   	   alert(fund+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}

	var path = "/mutual-funds-research/downloadLiquidFundsVsSavingsBankXl?scheme="+schemeName+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&savings_rate="+savings_rate+"&category="+category+"&amc="+amc;
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
	    	    	top.location =  "/mutual-funds-research/downloadLiquidFundsVsSavingsBankXl?scheme="+schemeName+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&savings_rate="+savings_rate+"&category="+category+"&amc="+amc+"&download=yes";
	    	    }
	        }
	    }
	};
	xhr.send(null);
 	
 	return false;	
}

function openLogin(){
	var amount = $("#txt_fd_amount").val();
 	var start_date = $("#txt_start_date").val();
 	var end_date = $("#txt_end_date").val();
 	var amc = 	$("#sel_amc").val();
    var category = 	$("#sel_category").val();
 	var fund = $("#sel_scheme").val();
 	var tax_rate = $("#sel_tax_rate").val();
 	var savings_rate = $("#sel_savings_rate").val();

 	if(amount == null || amount == "" || isNaN(amount) || parseFloat(amount)<=0)
    {
   	    alert("Please enter the valid deposit amount");
   	    return false;
    }
 	if(start_date == null || start_date == "")
    {
   	    alert("Please select start date");
   	    return false;
    }
 	if(end_date == null || end_date == "")
    {
   	    alert("Please select end date");
   	    return false;
    }
 	if(amc == null || amc == "")
 	{
   	    alert("Please select AMC");
   	    return false;
 	}
 	if(category == null || category == "")
 	{
   	    alert("Please select category");
   	    
   	    return false;
 	}
 	if(fund == null || fund == "")
 	{
   	    alert("Please select scheme name");
   	    return false;
 	}
 	if(tax_rate == null || tax_rate == "" || isNaN(tax_rate) || parseFloat(tax_rate)<=0)
    {
   	    alert("Please select income tax rate");
   	    return false;
    }
 	if(savings_rate == null || savings_rate == "" || isNaN(savings_rate) || parseFloat(savings_rate)<=0)
    {
   	   alert("Please select savings bank rate");
   	    return false;
    }
 	var arr = start_date.split("-");
    var start_date_str = arr[2] + "-" + arr[1] + "-" + arr[0];
    var startDate =  new Date(start_date_str);
    var flag = false;
    
    var schemeName = encodeURIComponent(fund);
	var flag = false;
	
	$.ajaxSetup({async:false});
	$.post("/mutual-funds-research/getSchemeStartAndEndDate", {scheme_name : "" + schemeName + ""}, function(data)
    {
		var schemes = $.trim(data);
		var schemes_obj = jQuery.parseJSON(schemes);
		var schemes_array = $.makeArray(schemes_obj);
		var from = schemes_array[0].split("-");
		var inception_date = new Date(from[2], from[1] - 1, from[0]);
		if(startDate < inception_date)
		{
	   	   alert(fund+" inception date is "+ inception_date.format("dd-mm-yyyy") +". Please select a start date which is greater than or equal to scheme inception date.");
	   	 	flag = true;
			return false;
		}
    },'text');
	
	if(flag)
	{
		return false;
	}

	downloadPath = "/mutual-funds-research/downloadLiquidFundsVsSavingsBankXl?scheme="+schemeName+"&amount="+amount+"&start_date="+start_date+"&end_date="+end_date+"&tax_rate="+tax_rate+"&savings_rate="+savings_rate+"&category="+category+"&amc="+amc;
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
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4">Liquid Funds vs Savings Bank</h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
             <div class="row">
                	<div class="col-md-12 col-sm-12">
		           
          <div class="marginBottom10 headContent">Savings Bank</div>
          
          <div class="row">
          <div class="col-md-4 col-sm-4">
          <div class="form-group">
            <label class="font-600">Deposit Amount</label>
            <input type="text" id="txt_fd_amount" value="${amount}" class="form-control no-radius" />
          </div>
        </div>
        
        <div class="col-md-4 col-sm-4">
          <div class="form-group">
            <label class="font-600">Start Date</label>
            <input type="text" id="txt_start_date" value="${start_date}" class="form-control datepicker no-radius" />
          </div>
        </div>
        
        <div class="col-md-4 col-sm-4">
          <div class="form-group">
            <label class="font-600">End Date</label>
            <input type="text" id="txt_end_date" value="${end_date}" class="form-control datepicker no-radius" />
          </div>
        </div>
        </div>
      
        
        <div class="marginBottom10 headContent">Liquid Fund</div>
        
       <div class="row headRow">
		<div class="col-md-4 col-sm-4">
            <div class="form-group">
			<label class="font-600">Select Category</label>
               <select id="sel_category" class="form-control selectpicker" onchange="categoryChange()">
               <option <c:if test="${savings_rate eq 'Debt: Liquid' }"><c:out value="selected=\'selected\'" /></c:if> value="Debt: Liquid">Debt: Liquid</option>
            <option <c:if test="${savings_rate eq 'Debt: Ultra Short Duration' }"><c:out value="selected=\'selected\'" /></c:if> value="Debt: Ultra Short Duration">Debt: Ultra Short Duration</option>
               </select>
            </div>
           </div>
        
        <div class="col-md-4 col-sm-4">
            <div class="form-group">
			<label class="font-600">Select AMC</label>
               <select id="sel_amc" class="form-control selectpicker" onchange="categoryChange()">
               <c:forEach var="company" items="${amcCompanies}" varStatus="status">
               <c:choose>
               <c:when test="${company eq amc}">
               <option selected="selected" value="${company}">${company}</option>
               </c:when>
               <c:otherwise>
               <option value="${company}">${company}</option>
               </c:otherwise>
               </c:choose>
               </c:forEach>
               </select>
            </div>
           </div>
           
           <div class="col-md-4 col-sm-4">
            <div class="form-group">
			<label class="font-600">Select Scheme</label>
               <select id="sel_scheme" class="form-control selectpicker">
               <c:forEach var="scheme" items="${schemes}" varStatus="status">
               <c:choose>
               <c:when test="${scheme eq scheme_name}">
               <option selected="selected" value="${scheme}">${scheme}</option>
               </c:when>
               <c:otherwise>
               <option value="${scheme}">${scheme}</option>
               </c:otherwise>
               </c:choose>
               </c:forEach>
               </select>
            </div>
           </div>
           </div>
           
       <div class="row headRow">
        <div class="col-md-4 col-sm-4">
          <div class="form-group">
            <label class="font-600">Income Tax Rate</label>
            <select id="sel_tax_rate" class="form-control selectpicker" data-width="100%">
             <option <c:if test="${tax_rate eq '10' }"><c:out value="selected=\'selected\'" /></c:if> value="10">10</option>
             <option <c:if test="${tax_rate eq '20' }"><c:out value="selected=\'selected\'" /></c:if> value="20">20</option>
             <option <c:if test="${tax_rate eq '30' }"><c:out value="selected=\'selected\'" /></c:if> value="30">30</option>
            </select>
          </div>
        </div>
        
		<div class="col-md-4 col-sm-4">
          <div class="form-group">
            <label class="font-600">Savings Bank Interest Rate</label>
            <select id="sel_savings_rate" class="form-control selectpicker" data-width="100%">
             <option <c:if test="${savings_rate eq '4' }"><c:out value="selected=\'selected\'" /></c:if> value="4">4</option>
             <option <c:if test="${savings_rate eq '5' }"><c:out value="selected=\'selected\'" /></c:if> value="5">5</option>
             <option <c:if test="${savings_rate eq '6' }"><c:out value="selected=\'selected\'" /></c:if> value="6">6</option>
             <option <c:if test="${savings_rate eq '7' }"><c:out value="selected=\'selected\'" /></c:if> value="7">7</option>
            </select>
          </div>
        </div>
        
       <div class="col-md-3 col-sm-3 sub">
          	<div class="form-group">
          	<label class="no-bold"> &nbsp;&nbsp;&nbsp; </label>
			<div class="marginTop15">
				<a href="javascript:void(0)" class="btn btn-primary hidden-xs"  style="position: absolute;top: 35%;width: 45%;" id="sip-submit">Submit</a>
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
		      <c:if test="${not empty fDvsDebtResponse}">
		      <div class="col-md-12 col-sm-12 table-responsive mt-3">
		      <table class="table dataTable">
			        <thead class="theadBody">
			            <tr>
			            <th>Pre-Tax Return</th>
			            <th>Investment Amount</th>
			            <th>Redeemed / Maturity Amount</th>
			            <th>Total Interest / Profit Amount</th>
			            <th>Annual Interest / Return (%)</th>
			            </tr>
			        </thead>
			        <tbody>
			        	<tr>
			            <td>Savings Bank Deposit</td>
			            <td><fmt:formatNumber value="${amount}" maxFractionDigits="0" /></td>    
			            <td><fmt:formatNumber value="${fDvsDebtResponse.fd_investment_value}" maxFractionDigits="0" /></td>
			            <td><fmt:formatNumber value="${fDvsDebtResponse.fd_investment_value - amount}" maxFractionDigits="0" /></td>
			            <td><c:out value="${fDvsDebtResponse.fd_annualized_return}"/></td>
			            </tr>	 
			            <tr>
			            <td><a href='/mutual-funds-research/<c:out value="${fDvsDebtResponse.scheme}"></c:out>' class="mutual-funds-anchor">
			            <c:out value="${fDvsDebtResponse.scheme}"/></a>
			            </td>
			            <td><fmt:formatNumber value="${amount}" maxFractionDigits="0" /></td>  
			           	<td><fmt:formatNumber value="${fDvsDebtResponse.scheme_investment_value}" maxFractionDigits="0" /></td>
			           	<td><fmt:formatNumber value="${fDvsDebtResponse.scheme_investment_value - amount}" maxFractionDigits="0" /></td>
			           	<td><c:out value="${fDvsDebtResponse.scheme_annualized_return}"/></td>
			            </tr>
			                     
			        </tbody>
		       </table>      
		      </div>
		      
		      <div class="col-md-12 col-sm-12 table-responsive mt-3">
		      <table class="table dataTable">
			        <thead class="theadBody">
			            <tr>
			            <th>Post Tax Return</th>
			            <th>Pre-tax Interest / Profit Amount</th>
			            <th>Capital Gains Tax</th>
			            <th>Indexed Amount</th>
			            <th>Income / Capital Gains Tax</th>
			            <th>Post Tax Interest / Profit Amount</th>
			            </tr>
			        </thead>
			        <tbody>
			        	<tr>
			            <td>Savings Bank Deposit</td>
			            <td><fmt:formatNumber value="${fDvsDebtResponse.fd_investment_value - amount}" maxFractionDigits="0" /></td>
			            <td>Not Applicable</td>
			            <td>Not Applicable</td>
			            <td>0</td>
			            <td><fmt:formatNumber value="${fDvsDebtResponse.fd_investment_value - amount}" maxFractionDigits="0" /></td>
			            </tr>	 
			            <tr>
			            <td><a href='/mutual-funds-research/<c:out value="${fDvsDebtResponse.scheme}"></c:out>' class="mutual-funds-anchor">
			            <c:out value="${fDvsDebtResponse.scheme}"/></a></td>
			            <td><fmt:formatNumber value="${fDvsDebtResponse.scheme_investment_value - amount}" maxFractionDigits="0" /></td>
			            <c:choose>
			            <c:when test="${years > 3}">
			            <td>Long Term</td>
			            <td><fmt:formatNumber value="${fDvsDebtResponse.scheme_indexed_cost_of_purchase}" maxFractionDigits="0" /></td>
			            </c:when>
			            <c:otherwise>
			            <td>Short Term</td>
			            <td>Not Applicable</td>
			            </c:otherwise>
			            </c:choose>
			            <td><fmt:formatNumber value="${fDvsDebtResponse.scheme_income_tax}" maxFractionDigits="0" /></td>
			           	<td><fmt:formatNumber value="${fDvsDebtResponse.post_tax_scheme_investment_value - amount}" maxFractionDigits="0" /></td>
			            </tr>
			                     
			        </tbody>
		       </table>      
		      </div>
		      <div class="col-md-12 col-sm-12 marginBottom15">
			  <p class="para color_red"></p>
			  <p class="para"><b>Note: </b></p>
			  <p class="para">1. Short Term in case of debt funds is defined as less than or equal to 3 years. Long Term in case of debt funds is defined as more than 3 years.</p>
			  <p class="para">2. Short term gain formula:</p>
			  <p class="para">Short term capital gain = Amount realised - Amount invested</p>
			  <p class="para">Short term capital gain tax = Short term capital gain * Tax rate of the investor</p>
			  <p class="para">3. Long term gain formula:</p>
			  <p class="para">Indexed cost of acquisition = Amount invested * (Index in Year of redemption / Index in year of investment)</p>
			  <p class="para">Long term capital gain = Amount realised - Indexed Cost of Acquisition</p>
			  <p class="para">Long term capital gain tax = Long term capital gain (post indexation) @ 20%</p> 
			  <p class="para">Please note that Section 80TTA grants a deduction on savings account interest up to Rs 10,000 per annum. It applies to all individuals and HUFs other than senior citizens (those above 60). Senior citizens can instead take advantage of a bigger deduction of Rs 50,000 per annum which includes both savings and FD interest under Section 80TTB.</p>
			  <p class="para">Section 80TTA was introduced in the Finance Bill of 2013 and became applicable from the Financial Year of 2012-13 onwards. Whereas deduction under Section 80TTB is applicable w.e.f. April 01, 2018.</p>
			  <p class="para">No tax has been applied on the gains of saving bank interest in this tool. </p>     
			  </div>
		      </c:if>
           </div>
        </div>
     </div>
 </section>					   