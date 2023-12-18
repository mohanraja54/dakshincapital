<script>

function contactus()
{
	var name = $("#name").val();
	var email = $("#email").val();
	var subject = $("#subject").val();
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
    if(subject == "")
    { 	  
	    swal("OOPS!", "Please enter subject!", "error")
  	    return false;	   
    }	
    $.ajaxSetup({async:false});
    $.post("/saveContactUs", {name : "" + name + "",email : "" + email + "",subject : "" + subject + "",message : "" + message + ""}, function(data)
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
				alert("Thanks for Contacting Us. We will get back to you soon");
				$("#name").val("");
				$("#email").val("");
				$("#subject").val("");
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
            <h1 class="mb-2 bread">Contact Us</h1>
            <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home <i class="ion-ios-arrow-forward"></i></a></span> <span>Contact <i class="ion-ios-arrow-forward"></i></span></p>
          </div>
        </div>
      </div>
    </section>
    <!-- ================ contact section start ================= -->
    <section class="marginTop35 marginBottom35  ">
        <div class="container">

			<div class="d-none d-sm-block pb-4">
                <div id="map" style="height: 480px;">
					<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3886.2098162648745!2d80.2015957143054!3d13.085885015902052!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a52641b8ba65b13%3A0x4d5f7d9ea0083854!2sDAKSHIN%20CAPITAL%20PRIVATE%20LIMITED!5e0!3m2!1sen!2sin!4v1584528181508!5m2!1sen!2sin" width="100%" height="450" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
				</div>
            </div>


            <div class="row">

                <div class="col-lg-8">
                        <div class="row">
                            <div class="col-12">
							<h2 class="contact-title" style="font-size:22px;"><strong>Get in Touch</strong></h2>
					<p style="margin-bottom:15px;">It would be great to hear from you! Just drop us a line and ask for anything with which you think we could be helpful. <br/>We are looking forward to hearing from you!</p>
                                <div class="form-group">

                                    <textarea class="form-control w-100" name="message" id="message" cols="30" rows="9"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Message'"
                                        placeholder='Enter Message'></textarea>
                                </div>
                            </div>
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
                            <div class="col-12">
                                <div class="form-group">
                                    <input class="form-control" name="subject" id="subject" type="text"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Subject'"
                                        placeholder='Enter Subject'>
                                </div>
                            </div>
                        </div>
                        <div class="form-group mt-5">
                            <button type="submit" class="button button-contactForm btn btn-primary" style="border-radius:5px;" onclick="contactus()">Send Message</button>
                        </div>
                </div>	
				<div class="col-lg-4" style="font-size: 13px;">
                    <div class="media contact-info">
                        <span class="contact-info__icon"><i class="fa fa-home fa-lg"></i></span>
                        <div class="media-body">
						    <h3 style="font-size: 13px;font-weight: 800;">CORPORATE OFFICE (Anna Nagar)</h3>
                            <h3 style="font-size: 13px;font-weight: 800;">DAKSHIN CAPITAL PRIVATE LTD</h3>
                            <p>Ground Floor, AP-867, H Block,<br/> 2nd Street,12th Main Road, Annanagar,<br/> Chennai - 600040.</p>
                        </div>
                    </div>
                    <div class="media contact-info">
                        <span class="contact-info__icon"><i class="fa fa-phone fa-lg"></i></span>
                        <div class="media-body">
                            <h3 style="font-size: 13px;font-weight: 800;">&nbsp;044-42023300<br/> &nbsp;044-26160800</h3>
                            <p>&nbsp;Mon to Fri 9am to 6pm</p>
                        </div>
                    </div>
                    <div class="media contact-info">
                        <span class="contact-info__icon"><i class="fa fa-envelope fa-lg"></i></span>
                        <div class="media-body">
                            <h3 style="font-size: 13px;font-weight: 800;">info@dakshincapital.com</h3>
                            <p>Send us your query anytime!</p>
                        </div>
                    </div>
					<hr>
					
					<div class="media contact-info">
                        <span class="contact-info__icon"><i class="fa fa-home fa-lg"></i></span>
                        <div class="media-body">
                            <h3 style="font-size: 13px;font-weight: 800;">BRANCH OFFICE (Adyar)</h3>
                            <h3 style="font-size: 13px;font-weight: 800;">DAKSHIN CAPITAL PVT LTD</h3>
                            <p>NO.9, 1st Floor, New No.51, Old No.25 ,<br/>First Main Road, Gandhi Nagar, Adyar,<br/> Chennai - 600020.</p>
                        </div>
                    </div>
                    <div class="media contact-info">
                        <span class="contact-info__icon"><i class="fa fa-phone fa-lg"></i></span>
                        <div class="media-body">
                            <h3 style="font-size: 13px;font-weight: 800;">&nbsp;044-40065916</h3>
                            <p>&nbsp;Mon to Fri 9am to 6pm</p>
                        </div>
                    </div>
                    <div class="media contact-info">
                        <span class="contact-info__icon"><i class="fa fa-envelope fa-lg"></i></span>
                        <div class="media-body">
                            <h3 style="font-size: 13px;font-weight: 800;">adyar@dakshincapital.com</h3>
                            <p>Send us your query anytime!</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ================ contact section end ================= -->