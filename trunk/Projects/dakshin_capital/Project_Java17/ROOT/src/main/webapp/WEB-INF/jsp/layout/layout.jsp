<!doctype html>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
  <head>
  <title>Dakshin Capital</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="icon" href="/images/logo/favicon.png" type="image/gif" sizes="16x16">
  <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:300,400,600,700,800,900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/css/open-iconic-bootstrap.min.css">
  <link rel="stylesheet" href="/css/animate.css">
  <link rel="stylesheet" href="/css/owl.carousel.min.css">
  <link rel="stylesheet" href="/css/owl.theme.default.min.css">
  <link rel="stylesheet" href="/css/magnific-popup.css">
  <link rel="stylesheet" href="/css/aos.css">
  <link rel="stylesheet" href="/css/ionicons.min.css">
  <link rel="stylesheet" href="/css/flaticon.css">
  <link rel="stylesheet" href="/css/icomoon.css">
  <link rel="stylesheet" href="/css/rangeslider.css">
  <link rel="stylesheet" href="/plugins/swal/swal.css">
  <link rel="stylesheet" href="/plugins/bootstrap-slider/slider.css">
  <link rel="stylesheet" href="/plugins/bootstrap-datepicker/bootstrap-datepicker.min.css">
  <link href="<c:url value="/css/bootstrap/css/ladda-themeless.min.css"/>" rel="stylesheet">
  <link rel="stylesheet" href="/plugins/datatables/datatables.min.css">
  <link rel="stylesheet" href="/css/css/font-awesome.min.css">
  <link rel="stylesheet" href="/css/style.css">
  
  
  <script src="/js/jquery.min.js"></script>
  <script src="/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/js/popper.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <script src="/plugins/loadingoverlay/loadingoverlay.js"></script>
  <script src="<c:url value="/js/jqBootstrapValidation.min.js"/>"></script>
  <script type="text/javascript" src="<c:url value="/js/html2canvas.js"/>"></script>
  
  <script src="<c:url value="/js/spin.min.js"/>"></script>
  <script src="<c:url value="/js/ladda.min.js"/>"></script>
  <script>
  $(document).ready(function(){
  $("#adv-login-form").find("input,textarea,select").jqBootstrapValidation(
  {
	    preventSubmit: true,
	    submitError: function($form, event, errors) {
	        
	    },
	    submitSuccess: function($form, event) {
	        event.preventDefault();
	
	        var usermobile = $("#user_signin_mobile").val();
	    	var userpass = $("#user_signin_password").val();
	
	        if(usermobile == "")
	        {
	        	$("#adv-login-alert").removeClass('hide');
	        	$("#adv-login-alert-msg").html('Enter valid login id');
	        	validityflag = false;
	        	return;
	        }
	        if(userpass.length < 6)
	        {
	        	$("#adv-login-alert").removeClass('hide');
	        	$("#adv-login-alert-msg").html('Password requires minimum of 6 characters');
	        	return;
	        }
	       
	        $("#adv-login-alert").addClass('hide');
	    	$("#adv-login-alert-msg").html('');
	   
	    	
	        $.ajaxSetup({async:true});
	    	$.post("/validateLogin", {mobile : "" + usermobile + "",
	    		password : ""  + userpass + "",
	    		downloadPath : "" + downloadPath + "",
	    		imageDownload : "" + imageDownload + "", 
	    		chartId : "" + chartId + "", 
	    		filename : "" + filename + "",
	    		overlap : "" + overlap + "",
	    		}, function(data)
	        {
	    		
	    		var obj = jQuery.parseJSON(data);
	    		var result = $.trim(obj.msg);
	    		if(result == "You have entered a wrong password")
	    		{           			 
	    			 $("#adv-login-alert").removeClass('hide');
	             	 $("#adv-login-alert-msg").html('Password is wrong');
	    		}
	    		else if(result == "Your mobile number not registered with us.")
	    		{
	    			 $("#adv-login-alert").removeClass('hide');
	             	 $("#adv-login-alert-msg").html('Mobile Number is not registered with us');
	    		}
	    		else if(result == "reload")
	    		{
	    			
	    			
	    			location.reload();
	    		}	    		
	    		else if(result == "inactive")
	    		{
	    			$("#adv-login-alert").removeClass('hide');
	            	$("#adv-login-alert-msg").html('Your account has been deactivated.<br/><br/>Please call 08041706980 for assistance.');
	    		}
	    		else
	    		{
	    			
	    		}
	    		
	        }, "text"); 
	        
	    },
	    filter: function() {
	        return $(this).is(":visible");
	        }
    }
  );
  });
  </script>
  
  <script type="text/javascript">
	function subscribeEmail()
	{
		var email = $.trim($("#txt_email_subscription1").val());
		
	    if(email == "")
	    {
	    	 bootbox.alert("Please enter email address");
	  		 return false;
	    }
	   
	    $.ajaxSetup({async:false});
	    $.post("/subscribeForEmail", {email : "" + email + "", page : "Website - home"}, function(data)
	    {
			var result = $.trim(data);
	        var obj = jQuery.parseJSON(result);
	        if(obj.status == 400)
	        {
	             bootbox.alert("Entered email id is already subscribed with us! Thanks.");
	           	 $("#txt_email_subscription1").val("");
	             return false;
	        }
	        else
	        {
	        	 bootbox.alert("Thanks. We will be in touch always!");
	             $("#txt_email_subscription1").val("");
	             return false;
	        }
	       
			
	    }, "text");
	}
	</script>
  
	<!-- Google tag (gtag.js) -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-53665245-1"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());

	  gtag('config', 'UA-53665245-1');
	</script>
	
  </head>
  <body>

    <jsp:include page="header.jsp"></jsp:include>
    
    <c:choose>
   		<c:when test="${not empty jsp}">
   			<jsp:include page="${jsp}"></jsp:include>
   		</c:when>
   		<c:otherwise>
   			<jsp:include page="error.jsp"></jsp:include>
   		</c:otherwise>
    </c:choose>
       
    <jsp:include page="footer.jsp"></jsp:include>
    
  </body>
</html>