<script>

function contactus()
{
	var name = $("#name").val();
	var email = $("#email").val();
	var mobile = $("#mobile").val();
	var city = $("#city").val();
	var message = $("#message").val();
	
	if(name == "")
    { 	  
	    swal("OOPS!", "Please enter your name!", "error")
  	    return false;	   
    }	   
    if(email == "")
    {
    	swal("OOPS!", "Please enter your email!", "error")
  	    return false;	   
   }
    if(mobile == "")
    { 	  
	    swal("OOPS!", "Please enter mobile!", "error")
  	    return false;	   
    }	
    $.ajaxSetup({async:false});
    $.post("/saveFeedback", {name : "" + name + "",email : "" + email + "",mobile : "" + mobile + "",
    	city : "" + city + "", message : "" + message + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);	
		 if(obj.status == "200")	   
		 {
			 /* swal({
				  title: "Congratulations?",
				  text: "Thanks for giving feedback.",
				  type: "success"
				});  */
				swal("", "Thanks for sharing your feedback", "success");
				$("#name").val("");
				$("#email").val("");
				$("#mobile").val("");
				$("#city").val("");
				$("#message").val("");
		 }
		
        
    }, "text");
}
</script>
 <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
            <h1 class="mb-2 bread">Feedback</h1>
            <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home <i class="ion-ios-arrow-forward"></i></a></span> <span>Feedback <i class="ion-ios-arrow-forward"></i></span></p>
          </div>
        </div>
      </div>
    </section>
    <!-- ================ contact section start ================= -->
    <section class="marginTop35 marginBottom35  ">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h2 class="contact-title" style="font-size:22px;"><strong>Share your feedback</strong></h2>
					<p style="margin-bottom:15px;">It would be great to hear from you! Just drop us a line and ask for anything with which you think we could be helpful. <br/>We are looking forward to hearing from you!</p>
                </div>
                <div class="col-lg-8">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <input class="form-control" name="name" id="name" type="text"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter your name'"
                                        placeholder='Enter your name'>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <input class="form-control" name="email" id="email" type="email"
                                        onfocus="this.placeholder = ''"
                                        onblur="this.placeholder = 'Enter email address'"
                                        placeholder='Enter email address'>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <input class="form-control" name="mobile" id="mobile" type="text"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter your mobile'"
                                        placeholder='Enter your mobile'>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <input class="form-control" name="city" id="city" type="text"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter your city'"
                                        placeholder='Enter your city'>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <textarea class="form-control w-100" name="message" id="message" cols="30" rows="9"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Your Feedback'"
                                        placeholder='Enter Your Feedback'></textarea>
                                </div>
                            </div>                            
                        </div>
                        <div class="form-group mt-5">
                            <button type="submit" class="button button-contactForm btn btn-primary" style="border-radius:5px;" onclick="contactus()">Post Your Feedback</button>
                        </div>
                </div>
                <div class="col-lg-4">
                    
                </div>
            </div>
        </div>
    </section>
    <!-- ================ contact section end ================= -->