<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
.panel-default>.panel-head1 {
    padding: 0px 15px;
}

.panel-default>.panel-heading {
    background: #0191da;
    border-color: #ddd;
    color: #fff !important;
}
.adv-panel {
    border: 1px solid #e9dfcd;
}

</style>

<script type="text/javascript">
function amcChanged()
{
	var amc = $("#sel_amc").val();
 	if(amc == "")
 	{
 		$("#adv-alert-msg").html("Please select amc");
   	    $("#adv-alert").modal('show');
		return;
 	}

 	$.ajaxSetup({async:true});
	$.post("/mutual-funds-research/getFactsheetYearsByAmc", {amc : "" + amc + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);
		var years_array = $.makeArray(obj);
		var html = "<option value=''>Select Year</option>";
		for (var i = 0; i < years_array.length; i++)
	    {
			html += '<option value="' + years_array[i]+ '">' + years_array[i] + '</option>';
	    }
		$("#sel_year").html(html);
		//$('#sel_year').selectpicker('refresh');
    },'text');
}

function getDownload()
{
	var amc = $("#sel_amc").val();
 	if(amc == "")
 	{
 		$("#adv-alert-msg").html("Please select amc");
   	    $("#adv-alert").modal('show');
		return;
 	}
 	
 	var year = $("#sel_year").val();
 	if(year == "")
 	{
 		$("#adv-alert-msg").html("Please select year");
   	    $("#adv-alert").modal('show');
		return;
 	}	
 	var amc_name = amc.replace(/\ /g, '-');
 	window.location.href = "/mutual-funds-research/factsheet/"+amc_name+"/"+year;
}
var async = async || [];
async.push(["ready",function (){
	
	var amc_name = '${amc_name}';
	if(amc_name != '')
	{
		$("#sel_amc").val(amc_name);
		//$("#sel_amc").selectpicker("refresh");
	}
	
	var year = '${year}';
	if(year != '')
	{
		$("#sel_year").val(year);
		//$("#sel_year").selectpicker("refresh");
	}
	
}]);

function saveResult() 
{	
	var amc = $("#sel_amc").val();
	var year = $("#sel_year").val();
	
	var accountMap = '${accountMap}';
	var title = "Mutual Fund Fact Sheets -> AMC = " + amc + ", Year = " + year;
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
</script>

<!-- main-container start -->
<!-- ================ -->
<section class="main-container mf-research">

	<div class="container-fluid pr-0 pl-0">
	<div class="row ml-0 mr-0">
		<div class="col-md-3 bg-mfbar py-3">
			<h1 class="amfi-title calc-title bold mb-0 pl-3 pt-4"><c:if test="${not empty amc_name}"> ${amc_name} Fact Sheet ${year} </c:if></h1>
		</div>
		<div class="col-md-9 bg-mfbar py-3">
     	<div class="row">
            
            <div class="col-md-4 col-sm-4">
	        <div class="form-group">
	          <label class="bold-smaller">Select AMC</label>
		        <select id="sel_amc" class="form-control" onchange="amcChanged()" data-width="100%">
		        <option value="">Select Amc</option>
				<c:forEach items="${amcList}" var="amc_name">
				<option value="<c:out value="${amc_name}"></c:out>"><c:out value="${amc_name}"></c:out></option>
				</c:forEach>
			    </select>
			</div>
			</div>
			
			<div class="col-md-4 col-sm-4">
	        <div class="form-group">
	          <label class="bold-smaller">Select Year</label>
		        <select id="sel_year" class="form-control" data-width="100%">
		        <option value="">Select Year</option>
		        <c:forEach items="${year_list}" var="year">
				<option value="<c:out value="${year}"></c:out>"><c:out value="${year}"></c:out></option>
				</c:forEach>
			    </select>
			</div>
			</div>
            
            <div class="col-md-4 col-sm-4">
                <div class="form-group">
		          <label class="bold block hidden-xs">&nbsp;</label>
				  <a href="javascript:void(0)" class="btn btn-primary hidden-xs btn-xss" onclick="getDownload()" style="position: absolute;top: 35%;width:70%;">Download</a>
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
	      	<div class="row margin-top5">
				<c:if test="${amc != null && year != null}">
			      <div class="col-md-12 col-sm-12 clearfix">
			      <div class="panel panel-default adv-panel clearfix">
			        <div class="panel-heading panel-head1 padding-0 padding-left10">
			          <h2 class="panel-title margin0 ak-bold" style="padding: 5px 0;color:#fff;">Download ${amc_name} ${year} Fact Sheet</h2>
			        </div>
			        <div class="panel-body padding paddingBottom0 paddingTop5">          
			          <div class="row">
			           <div class="col-md-12 col-sm-12 remove-bootstrap-col-lr-padding">
			           <div class="padding20">
			           <c:forEach items="${factsheet_list}" var="factsheet">
							<p style="border-bottom:1px solid #ddd;"><i class="glyphicon glyphicon-file" style="margin-right:10px;color: red;"></i> 
							<a style="font-size:13px;color:#1177b9;" href="${factsheet.link}" target="_blank"> 
							${factsheet.name}</a>
							</p>
						</c:forEach>
			            </div>
			          </div>
			         </div>
			         
			        </div>  
			      </div> 
			     </div>
			     </c:if>
	       		</div>        
	      </div>

     </div>
	</div>
</section>
<!-- main-container end -->