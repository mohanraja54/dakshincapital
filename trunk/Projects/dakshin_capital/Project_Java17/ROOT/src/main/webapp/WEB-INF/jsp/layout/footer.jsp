<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
var downloadPath = "";
var imageDownload = "no";
var chartId = "";
var filename = "";
var overlap = "";

$(document).ready(function(){
	$(".goal_plan").click(function() {
	    $('html, body').animate({
	        scrollTop: ($(".goal-section").offset().top) + 20
	    }, 2000);
	});
});
</script>
<footer class="ftco-footer ftco-bg-dark ftco-section">
      <div class="container">
        <div class="row">
          <div class="col-md-6 col-lg-3">
            <div class="ftco-footer-widget">
            	<h2 class="ftco-heading-2">Contact Info</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span class="icon icon-map-marker"></span><span class="text">Dakshin Capital Private Limited,<br/> Ground Floor, AP-867, H Block,<br/> 2nd Street,12th Main Road, Annanagar,<br/> Chennai-600040</span></li>
	                <li><a href="#"><span class="icon icon-phone"></span><span class="text">044-42023300</span></a></li>
	                <li><a href="#"><span class="icon icon-envelope"></span><span class="text">info@dakshincapital.com</span></a></li>
	              </ul>
	            </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3">
            <div class="ftco-footer-widget ml-md-4">
              <h2 class="ftco-heading-2">Useful Links</h2>
              <ul class="list-unstyled">
                <li><a href="/"><span class="ion-ios-arrow-round-forward mr-2"></span>Home</a></li>
                <li><a href="/aboutus"><span class="ion-ios-arrow-round-forward mr-2"></span>About Us</a></li>
                <li><a href="/contactus"><span class="ion-ios-arrow-round-forward mr-2"></span>Contact Us</a></li>
                <li><a href="/blog"><span class="ion-ios-arrow-round-forward mr-2"></span>Blogs</a></li>
                <li><a href="/feedback"><span class="ion-ios-arrow-round-forward mr-2"></span>Feedback</a></li>
                <li><a href="/disclaimer"><span class="ion-ios-arrow-round-forward mr-2"></span>Disclaimer</a></li>
                <li><a href="/privacy_policy"><span class="ion-ios-arrow-round-forward mr-2"></span>Privacy Policy</a></li>
                <li><a href="/careers"><span class="ion-ios-arrow-round-forward mr-2"></span>Careers</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-6 col-lg-3">
            <div class="ftco-footer-widget ml-md-4">
              <h2 class="ftco-heading-2">Resources</h2>
              <ul class="list-unstyled">
                <li><a href="/mutual-funds-research/top-performing-mutual-funds"><span class="ion-ios-arrow-round-forward mr-2"></span>MF Performance</a></li>
                <li><a href="/tools-and-calculators/become-a-crorepati"><span class="ion-ios-arrow-round-forward mr-2"></span>Tools and Calculators</a></li>
                <li><a href="/goal/robo-advisor"><span class="ion-ios-arrow-round-forward mr-2"></span>Lumpsum Robo Advise</a></li>
                <li><a href="/goal/robo-sip"><span class="ion-ios-arrow-round-forward mr-2"></span>SIP Robo Advise</a></li>
                <li><a href="/mutual-funds-research/model-portfolio"><span class="ion-ios-arrow-round-forward mr-2"></span>Model Portfolios</a></li>
                <li><a class="goal_plan" href="/goal/child-education"><span class="ion-ios-arrow-round-forward mr-2"></span>Create Your Goal</a></li>
                <li><a href="/fd-rates"><span class="ion-ios-arrow-round-forward mr-2"></span>FD Rates</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-6 col-lg-3">
            <div class="ftco-footer-widget ml-md-4 mt-5">
             	<div class="row">
					<div class="col-md-6 col-lg-6 col-xs-12 text-center" style="text-center;padding: 0px;margin-top: 5%;">
						<img src="/images/logo/bse.png" alt="BSE" style="float: none;width: 50%;margin-top: 15px;">
						<br><span style="font-size:12px;color:#e0e0e0;">Member Code: 10127</span>
					</div>
					<div class="col-md-6 col-lg-6 col-xs-12 text-center" style="text-align:left;margin-top: 5%;">
						<img src="/images/logo/amfi-white.webp" alt="AMFI">
						<br><span style="font-size:12px;color:#e0e0e0;">ARN : 96025</span>
					</div>														
				</div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3">
             <!-- <div class="ftco-footer-widget">
            	<h2 class="ftco-heading-2">Subscribe Us!</h2>
              <div class="subscribe-form">
                <div class="form-group">
                  <input type="text" class="form-control mb-2 text-center" placeholder="Enter email address" id="txt_email_subscription1">
                  <input type="submit" value="Subscribe" onclick="subscribeEmail()" class="form-control submit px-3">
                </div>
              </div>
            </div>
           <div class="ftco-footer-widget ">
            	<h2 class="ftco-heading-2 mb-0">Connect With Us</h2>
            	<ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-3">
                <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
              </ul>
            </div> -->
          </div>
        </div>
      </div>
    </footer>
    <div class="col-md-12 text-center" style="background:#2f2e2e; color:rgba(255, 255, 255, 0.7);">
            <div class="pt-2 pb-2">Copyright &copy;<script>document.write(new Date().getFullYear());</script> Dakshin Capital. All Rights Reserved</div>
    </div>
    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>



  <script src="/js/jquery.easing.1.3.js"></script>
  <script src="/js/jquery.waypoints.min.js"></script>
  <script src="/js/jquery.stellar.min.js"></script>
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/aos.js"></script>
  <script src="/js/jquery.animateNumber.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
 <!--  <script src="/https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/js/google-map.js"></script> -->
  <script src="/js/main.js"></script>
  <script src="/plugins/datatables/datatables.min.js"></script>
  <script src="/js/bootstrap3-typeahead.min.js"></script>
  <script src="/js/highstock.js"></script>
  <script src="/js/rangeslider.min.js"></script>
  <script src="/plugins/date-format/date.format.js"></script>
  <script src="/plugins/swal/swal.js"></script>
  <script type="text/javascript" src="/plugins/bootstrap-slider/bootstrap-slider.min.js"></script>
  <script src="/plugins/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
  <script type="text/javascript" src="/plugins/bootbox/bootbox.min.js"></script>
  <!-- <script src="/js/jquery-3.3.1.slim.min.js"></script> -->


  <div id="scheme_name_change_model" class="modal fade" role="dialog">
  <div class="modal-dialog modal-xl modal-dialog-centered">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
          	<div class="col-md-12">
          		<h4 class="modal-title">Select the Scheme Name</h4>
          	</div>
      </div>
      <div class="modal-body mf-research">
        <div class="popup_select_scheme" style="font-size: 12px; color: #333;"></div>
      </div>
	  <div class="modal-footer">
		<button type="button" data-dismiss="modal" class="btn btn-border" style="width: auto;">Close</button>
		<button type="submit" onclick="changeSchemeName()" class="btn btn-primary">Submit</button>
	  </div>
    </div>
  </div>
</div>

<div id="adv-alert" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false" style="display: none;">
<div class="modal-dialog modal-dialog-centered">
<div class="modal-content">
  <div class="modal-body">
    <p id="adv-alert-msg">Would you like to continue with some arbitrary task?</p>
  </div>
  <div class="modal-footer">
    <!-- <button type="button" data-dismiss="modal" class="btn btn-default">Cancel</button> -->
    <button type="button" data-dismiss="modal" class="btn btn-warning">OK</button>
  </div>
 </div>
 </div>
</div>


<div id="adv-login" class="modal fade" tabindex="-1" data-width="380" data-focus-on="input:first">
<form id="adv-login-form">
<div class="modal-dialog  modal-dialog-centered">
<div class="modal-content">
  <div class="modal-header">
        <h5 class="modal-title">Sign In</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
  <div class="modal-body">
  <div class="row">
    <div class="col-md-12">
	<div class="form-group margin-bottom15">
	  <label class="no-bold">Mobile Number</label>
	  <input id="user_signin_mobile" name="user_email" type="text" class="form-control" minlength="5" maxlength="50" required placeholder="Enter User ID">
	</div>
	<div class="form-group margin-bottom15">
	  <label class="no-bold">Password</label>
	  <input id="user_signin_password" name="user_password" type="password" class="form-control" minlength="6" maxlength="16" required placeholder="Enter password">
	</div>
	<div class="form-group margin-bottom15">
	  <button type="submit" id="adv-login-submit" class="btn btn-warning ladda-button bold" data-style="expand-right" data-size="l"><span class="ladda-label">Login</span></button>
	  <a href="https://mfportfolio.dakshincapital.com/signup" class="pull-right khojbrandlink"> &nbsp; | Register</a>
	  <a href="https://mfportfolio.dakshincapital.com/forgot-password" class="pull-right khojbrandlink">Forgot Password?</a>
	</div>
	<div id="adv-login-alert" class="alert alert-danger hide" role="alert">
	  <button type="button" class="close" aria-label="Close" onclick="$('#adv-login-alert').addClass('hide');"><span aria-hidden="true">&times;</span></button>
	  <span id="adv-login-alert-msg"></span>
	</div>
    </div>
  </div>
  </div>
  </div>
  </div>
    </form>
</div>

<c:if test="${not empty downloadPath}">
	<script>
	var path = "";
	var imageDownload = "";
	var chartId = "";
	var filename = "";
	var overlap = "";
	 
	 $(document).ready(function() {
		$.LoadingOverlay("show");
		path = '${downloadPath}';
		imageDownload = '${imageDownload}';
		chartId = '${chartId}';
		filename = '${filename}';
		overlap = '${overlap}';
/* 		alert(path);
		alert(imageDownload);
		alert(chartId);
		alert(filename);  */

		if(path!="" && imageDownload == "no" && overlap == ""){
			var xhr = new XMLHttpRequest();
			xhr.open('GET', path, true);
			xhr.responseType = 'text';
			xhr.onload = function () {
			    if (xhr.readyState === xhr.DONE) {
			    	$.LoadingOverlay("hide");
			        if (xhr.status === 200) {
			        	
			        	var contentType = xhr.getResponseHeader("Content-Type");
			        	if(contentType == "application/json;charset=ISO-8859-1"){
			        		var data = JSON.parse(xhr.response);
			        		alert(data.msg);
			    	    }
			    	    else{
			    	    	if(path.indexOf('?') != -1){
								setTimeout(function(){
									top.location =  path+"&download=yes";
								}, 1000);
			    	    	}
			    	    	else{
								setTimeout(function(){
									top.location =  path+"?download=yes";
								}, 1000);
			    	    	}
			    	    	
			    	    }
			        }
			    }
			};
			xhr.send(null);
		}
		
		if(path!="" && imageDownload == "yes" && overlap == ""){
			var xhr = new XMLHttpRequest();
	    	xhr.open('GET', path, true);
	    	xhr.responseType = 'text';
	    	xhr.onload = function () {
	    	    if (xhr.readyState === xhr.DONE) {
	    	    	$.LoadingOverlay("hide");
	    	        if (xhr.status === 200) {
	    	        	
	    	        	var contentType = xhr.getResponseHeader("Content-Type");
	    	        	if(contentType == "application/json;charset=ISO-8859-1"){
	    	        		var data = JSON.parse(xhr.response);
	    	        		alert(data.msg);
	    	    	    }
	    	    	    else{
	    	    	    	setTimeout(function(){ 
	    	    	    		 html2canvas(document.querySelector(chartId)).then(canvas => {
	 	    	    	 			getCanvas = canvas;     //or whatever you want to execute 
	 	    	    	 			var imgageData = getCanvas.toDataURL("image/png");
	 	    	    	 			img = imgageData.replace('data:image/png;base64,', '');
	 	    	    	 			$.ajaxSetup({async:false});
	 	    	    	 			$.post("/mutual-funds-research/base64toimage", {base64image : img, filename:filename}, function(data){
	 	    	    	 				if(path.indexOf('?') != -1){
	 	    			    	    		top.location =  path+"&download=yes";
	 	    			    	    	}
	 	    			    	    	else{
	 	    			    	    		top.location =  path+"?download=yes";
	 	    			    	    	}
	 	    	    	 				//top.location = "/mf-research/downloadcategoryMonitor?download=yes";
	 	    	    	 			},'text');
	 	    	    	         });
	    	    	    	}, 3000);
	    	    	    }
	    	        }
	    	    }
	    	};
	    	xhr.send(null);
		}
		
		if(path!="" && imageDownload == "no" && overlap == "overlap"){
			
			var xhr = new XMLHttpRequest();
	    	xhr.open('GET', path, true);
	    	xhr.responseType = 'text';
	    	xhr.onload = function () {
	    	    if (xhr.readyState === xhr.DONE) {
	    	    	$.LoadingOverlay("show");
	    	        if (xhr.status === 200) {
	    	        	
	    	        	var contentType = xhr.getResponseHeader("Content-Type");
	    	        	if(contentType == "application/json;charset=ISO-8859-1"){
	    	        		var data = JSON.parse(xhr.response);
	    	        		alert(data.msg);
	    	    	    }
	    	    	    else{
	    	    	    	setTimeout(function(){ 
		    	    	    	html2canvas(document.querySelector("#bar_chart")).then(canvas => {
		    	    				getCanvas = canvas;     //or whatever you want to execute 
		    	    				var imgageData = getCanvas.toDataURL("image/png");
		    	    				img = imgageData.replace('data:image/png;base64,', '');
		    	    				$.ajaxSetup({async:false});
		    	    				$.post("/mutual-funds-research/base64toimage", {base64image : img, filename:"bar-chart"}, function(data){
		    	    					
		    	    				},'text');
		    	    	        });
		    	    	        
		    	    	        html2canvas(document.querySelector("#dount_chart")).then(canvas => {
		    	    				getCanvas = canvas;     //or whatever you want to execute 
		    	    				var imgageData = getCanvas.toDataURL("image/png");
		    	    				img = imgageData.replace('data:image/png;base64,', '');
		    	    				$.ajaxSetup({async:false});
		    	    				$.post("/mutual-funds-research/base64toimage", {base64image : img, filename:"down-chart"}, function(data){
		    	    					top.location = path+"&download=yes";
		    	    				},'text');
		    	    	        });
	    	    	    	}, 3000);
	    	    	    }
	    	        }
	    	    }
	    	};
	    	xhr.send(null);
		}

	});
	</script>
</c:if>

<%
session.removeAttribute("downloadPath");
session.removeAttribute("imageDownload");
session.removeAttribute("chartId");
session.removeAttribute("filename");
session.removeAttribute("overlap");
%>