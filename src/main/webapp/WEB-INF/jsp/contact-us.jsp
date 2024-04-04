<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Contact Us for help</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="DESCRIPTION" content="Lowtickets.com make reservations on all flight rourtes. If you'd like to call and make a reservation, have further questions, or need more services.">
	<link rel="icon" href="/resources/images/favicon.png">
	<link rel="canonical" href="https://www.lowtickets.com/contactus">
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700&display=swap" rel="preload" as="font" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="preload" fetchpriority="high" href="/resources/images/blog-body.webp" as="image" type="image/webp" />
	<link rel="stylesheet" href="/resources/css/default.css?v=2.7">

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.16.0/jquery.validate.min.js" crossorigin="anonymous"></script>
 
    <script data-ad-client="ca-pub-8417978305493541" async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<jsp:include page="tag-manager-head.jsp" /></head>
<body>
   <jsp:include page="tag-manager-body.jsp" /> <!--Header Area Starts Here-->
   <jsp:include page="header.jsp" />
    <div class="screen-overlay" id="screenoverlay" onclick="hidesidenav()"></div>
    <!--Header Ends Here-->
    <div class="blog-head">
        <h1>Contact Us </h1>
    </div>
    <div style="background-color:#ffffff;">

	<div class="content-content static-content">
		<p>At lowtickets.com, we are aware of all possible requests. In addition to providing cheap tickets, lowtickets.com offers additional services for the benefit of its passengers. Satisfied customers inspire us. That's why we put a lot of effort into providing the greatest services.</p>
		<p>You can contact us in several ways with the assistance of lowtickets.com. Our company's customer service executives give you important instructions and information along with quick deals and discounts on travel.</p>
	</div>

    <div class="contactus static-content">
        <div class="contact-details">
            <!-- <h3>Contact Details</h3> -->
			<p class="contact-sec-heading">Contact Details</p>
             <p>We permit a direct connection between customers and customer service executives because we don't want to make our passengers wait in a queue or restrict them from utilizing our services. A customer support representative is available from 7:00 AM to 9:00 PM (EST).</p>
      

			<div class="contact-details-inner">
				<!-- <span><i class="fa fa-map-marker"></i> &nbsp;</span> -->
				<div class="info-contact-details">
					<div class="contact-icon"><i class="fa fa-envelope"></i> &nbsp;</div>
					<div class="contact-icon-text">
						<strong>Email:</strong>
						<a href="mailto:bookings@lowtickets.com">bookings@lowtickets.com</a>
					</div>
				</div>

				<div class="info-contact-details">
					<div class="contact-icon"><i class="fa fa-phone"></i> &nbsp;</div>
					<div class="contact-icon-text">
						<strong>Consumer Service:</strong>
						<a href="tel:+1-800-984-7414">+1-800-984-7414</a>
					</div>
				</div>
			</div>

            <br>
            <br>
        </div>
        <div class="contact-form">
            <!-- <h3>Contact Form</h3> -->
			<p class="contact-sec-heading">Contact Form</p>
            <form:form modelAttribute="contactForm" action="/contactus/submit" method="post">
                <div class="flname">
                    <div><label>First Name<span class="star-requ">*</span></label>
						<form:input path="firstName" type="text" placeholder="Enter the FirstName" class="textOnly inputfieldset" />
					</div>
                    
					<div>
						<label>Last Name<span class="star-requ">*</span></label>
						<form:input path="lastName" type="text" placeholder="Enter the LastName" class="textOnly inputfieldset" />
					</div>
                </div>
                <div class="phonemail">
                    <div>
						<label>Phone No.<span class="star-requ">*</span></label>
						<form:input path="phone" type="text" placeholder="Enter the Phone Number" class="numbersOnly inputfieldset" />
					</div>

                    <div>
						<label>Email<span class="star-requ">*</span></label>
						<form:input path="email" type="text" placeholder="Enter the Email-ID" class="inputfieldset"/>
					</div>
                </div>
                <div class="comment">
                    <label>Your Comment<span class="star-requ">*</span></label>
                    <form:textarea path="message" class="inputfieldset"></form:textarea>
                </div>
                

				<div class="row">
					<div class="capcha-code-sec">
					   <span class="capcha capcha-code">ABCD12345</span>
					   <span class="refresh-btn capcha-refresh-btn"><img src="/resources/images/refresh-icon.png" height="35" width="35" alt="contact"/></span>

					   <div class="capcha-input-field">
							<form:input path="capchaCode" text="text" placeholder="Enter the Code" id="capchaCode" class="inputfieldset"/>
					   </div>
				   </div>
			   </div>
                
                <div class="submit-form">
                    <button id="subID" type="submit">
                    	<div class="loader"><span>Loading...</span><i></i></div>
                    	<span>Submit</span>
                    </button>
                    
                </div>
                
            </form:form>
			<div id="reviewSuccess"></div>
        </div>
    </div>
    </div>
    <!--Footer Starts-->
    <jsp:include page="footer.jsp" />
    <script src="/resources/scripts/script.js?20032022"></script>
</body>

<script>

$(document).ready(function(){
	
	refreshCapcha();
	
	$(".refresh-btn").click(function(){
		refreshCapcha();
	});
});

$(document).ready(function(){
	
	$.validator.addMethod("email", function(value, element) {  
    	return this.optional(element) || /^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z.]{2,5}$/i.test(value);  
    }, "Please provide a valid email address");
    
    $.validator.addMethod("capchaChk", function(value, element) {  
    	 if($(".capcha").html()!=value){
    	 	return false;
    	 }
    	 else{
    	 	return true;
    	 }
    }, "Please enter correct capcha");
    
    
});

$('.numbersOnly').keyup(function () {
	if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
	   this.value = this.value.replace(/[^0-9\.]/g, '');
	}
});

$('.textOnly').keyup(function () {
	if (this.value != this.value.replace(/[^a-zA-Z ]+/g, '')) {
    	this.value = this.value.replace(/[^a-zA-Z ]+/g, '');
    }
});		
    		
$("#contactForm").validate({
		 rules:{
			 firstName : {
				 required : true
			 },
			 lastName :{
				 required : true
			 },
			 email :{
				 required : true,
				 email : true
			 },
			 phone :{
				 required : true,
				 minlength:10,
                 maxlength: 15,
                 number: true
			 },
			 message :{
				 required : true
			 },
			 capchaCode:{
			 	required : true,
			 	capchaChk: true
			 }
		 },
		 
		 errorPlacement: function(error, element) {  
		 	if($(element).attr("name") == "firstName" || $(element).attr("name") == "lastName" || $(element).attr("name") == "phone" || $(element).attr("name") == "email" || $(element).attr("name") == "message" 
		 	|| $(element).attr("name") == "capchaCode"){
		 		error.insertAfter(element);
		 	}
		 },
		 messages: {
		 	'firstName': { required: 'Please Enter First Name'},
            'lastName': { required: 'Please Enter Last Name'},
            'email': { required: 'Please Enter EmailID'},
            'phone': { required: 'Please Enter Phone No'},
            'message': { required: 'Please Enter Message'},
            'capchaCode':{ 
            				required: 'Please Enter Capcha', 
            				capchaChk:'Please enter correct Capcha'
            			}
		 },
		 highlight: function (element) {
         	$(element).closest('.inputfieldset').removeClass('valid').addClass('error');
			//$(element).removeClass('valid').addClass('error');
		},
		unhighlight: function (element) {
            $(element).closest('.inputfieldset').removeClass('error').addClass('valid');
            //$(element).removeClass('error').addClass('valid');
        },
		submitHandler: function(form) {
		 
					var data = {
								firstName: $("#firstName").val(), 
								lastName: $("#lastName").val(),
								email : $("#email").val(), 
								phone : $("#phone").val(), 
								message : $("#message").val(),
								capchaCode: $("#capchaCode").val()
							}
							
							$.ajax({
								url: '/contactus/submit',
								type: 'post',
								contentType: 'application/json; charset=utf-8',
								data: JSON.stringify(data),
								dataType: "text",
								beforeSend: function() {
        							$(".loader").show().addClass('activeLoader');
        							$("#subID").hide();
    							},
								success: function(response) {
									form.reset();
									$(".loader").hide().removeClass('activeLoader');
									$("#subID").show();
									refreshCapcha();
									if(response == 'true'){
										$("#reviewSuccess").text("Contact Query Submit Successfully!").css("color", "green");
										
										setTimeout(hideDiv, 5000);
									}
									else{
										$("#reviewSuccess").text("Some Technical Issue Please try later!").css("color", "red");	
									}
								}
							});
							
				
		  }
	 })
	 
	 function hideDiv(){
	 	$("#reviewSuccess").hide();
	 }
	 
	 function refreshCapcha(){
	 	
	 	setTimeout(function (){
	 		$(".capcha").html(randomString(6));
	 	}, 300);
	 }
	 
	 function randomString(length){
	 	var chars='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz'.split('');
	 	
	 	if(!length){
	 		length=Math.floor(Math.random() * chars.length);
	 	}
	 	
	 	var str='';
	 	for(var i=0; i<length; i++){
	 		str+=chars[Math.floor(Math.random() * chars.length)];
	 	}
	 	return str;
	 }
</script> 
</html>