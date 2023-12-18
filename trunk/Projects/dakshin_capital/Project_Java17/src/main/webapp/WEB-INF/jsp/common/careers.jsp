<script>
$(document).ready(function() {
	$('.datepicker').datepicker({
		format: 'dd-mm-yyyy',
		endDate: '-1d',
		autoclose:true,
		disableTouchKeyboard:true
	});
});

function sendCareersEmail()
{
	var name = $("#name").val();
	var email = $("#email").val();
	var address = $("#address").val();
	var mobile = $("#mobile").val();
	var qualification = $("#qualification").val();
	var skills = $("#skills").val();
	var experience = $("#experience").val();
	var dob = $("#dob").val();
	var age = $("#age").val();
	var prev_emp = $("#prev_emp").val();
	
	if(name == "")
    { 	  
	    swal("", "Please enter your name!", "warning");
  	    return false;	   
    }	   
    if(address == "")
    {
    	swal("", "Please enter your address!", "warning");
  	    return false;	   
   	}   
    if(mobile == "")
    {
    	swal("", "Please enter your mobile!", "warning");
  	    return false;	   
   	}
    if(email == "")
    {
    	swal("", "Please enter your email!", "warning");
  	    return false;	   
   	}
    if(qualification == "")
    {
    	swal("", "Please enter your qualification!", "warning");
  	    return false;	   
   	}
    if(skills == "")
    {
    	swal("", "Please enter your skills!", "warning");
  	    return false;	   
   	}
    if(experience == "")
    {
    	swal("", "Please enter your experience!", "warning");
  	    return false;	   
   	}
    if(dob == "")
    {
    	swal("", "Please enter your dob!", "warning");
  	    return false;	   
   	}
    if(age == "")
    {
    	swal("", "Please enter your age!", "warning");
  	    return false;	   
   	}
    $.ajaxSetup({async:false});
    $.post("/sendCareersEmail", {name : "" + name + "",email : "" + email + "",mobile : "" + mobile + "",address : "" + address + "",
    	qualification : "" + qualification + "",skills : "" + skills + "",experience : "" + experience + "",
    	dob : "" + dob + "", age : "" + age + "", prev_emp : "" + prev_emp + ""}, function(data)
    {
		var result = $.trim(data);
		var obj = jQuery.parseJSON(result);	
		 if(obj.status == "200")	   
		 {
	 		swal({
	            title: "",
	            text: "Thanks for applying to us. We will get back to you soon",
	            type: "success"
	        }, function() {
	            top.location = "/";
	        });
		 }
    }, "text");
}
</script>
 <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
            <h1 class="mb-2 bread">Careers</h1>
            <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home <i class="ion-ios-arrow-forward"></i></a></span> <span>Careers <i class="ion-ios-arrow-forward"></i></span></p>
          </div>
        </div>
      </div>
    </section>
    <!-- ================ contact section start ================= -->
    <section class="marginTop35 marginBottom35  ">
        <div class="container">
        	<div class="row">
	       		<div class="col-md-12 heading-section">
	        		<h2 class="mb-4">Careers</h2>
	        	</div>
        	</div>
            <div class="row">
                <div class="col-md-6">
                        <div class="row">
                        	<div class="col-md-12">
                                <div class="form-group">
                                    <input class="form-control" name="name" id="name" type="text"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter your name'"
                                        placeholder='Enter your name'>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <textarea class="form-control w-100" name="address" id="address" cols="30" rows="4"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Address'"
                                        placeholder='Enter Address'></textarea>
                                </div>
                            </div>
                             <div class="col-md-12">
                                <div class="form-group">
                                    <input class="form-control" name="mobile" id="mobile" type="number"
                                        onfocus="this.placeholder = ''"
                                        onblur="this.placeholder = 'Enter contact number'"
                                        placeholder='Enter contact number'>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input class="form-control" name="email" id="email" type="email"
                                        onfocus="this.placeholder = ''"
                                        onblur="this.placeholder = 'Enter email address'"
                                        placeholder='Enter email address'>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input class="form-control" name="qualification" id="qualification" type="text"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter your qualification'"
                                        placeholder='Enter your qualification'>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <textarea class="form-control w-100" name="skills" id="skills" cols="30" rows="4"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Your Skills'"
                                        placeholder='Enter Your Skills'></textarea>
                                </div>
                            </div>
                            
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input class="form-control" name="experience" id="experience" type="number"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Experience (in years)'"
                                        placeholder='Experience (in years)'>
                                </div>
                            </div>
                            
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input class="form-control datepicker" name="dob" id="dob" type="text"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Date of Birth'"
                                        placeholder='Date of Birth'>
                                </div>
                            </div>
                            
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input class="form-control" name="age" id="age" type="number"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Age (in years)'"
                                        placeholder='Age (in years)'>
                                </div>
                            </div>
                            
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input class="form-control" name="prev_emp" id="prev_emp" type="text"
                                        onfocus="this.placeholder = ''" onblur="this.placeholder = 'Previous Employer Name'"
                                        placeholder='Previous Employer Name'>
                                </div>
                            </div>
                            
                        </div>
                        <div class="form-group mt-5">
                            <button type="submit" class="button button-contactForm btn btn-primary" style="border-radius:5px;" onclick="sendCareersEmail()">Submit</button>
                        </div>
                </div>
                <div class="col-md-6 text-center">
	          		<img src="/images/career.jpg" style="width: 100%;" alt="Retirement Planning">
	          	</div>
            </div>
        </div>
    </section>
    <!-- ================ contact section end ================= -->