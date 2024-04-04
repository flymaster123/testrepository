<%@ page import="com.travel.utility.SiteMap"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page pageEncoding="UTF-8" %>

<link rel="stylesheet" href="/resources/css/countrySelect.css">
<link rel="stylesheet" href="/resources/css/countrySelect.min.css">
<script src="/resources/scripts/countrySelect.min.js"></script>
<script src="/resources/scripts/countrySelect.js"></script>
<style>
.country-select .country-list{z-index: 9;}
.errorMsgCountry{display: none;}
</style>

<div class="main-footer" style="background-color:#f5f5f5;width:100%;float:left">
<%
   com.travel.utility.SiteMap tc = new com.travel.utility.SiteMap();
   tc.getSitemap(request);
  %>
  

<div class="footer-container">
    <svg class="svgCurve" viewBox="0 0 800 60">
        <path d="M 0 30 C 150 100 280 0 800 20 L 800 0 L 0 0" fill="#323232" style="color:#af5454;"></path>
    </svg>
        <div class="footer1">
            
            <div class="fooSBox"> 
                <p class="fooSBox-heading">Quick Links <i class="fa fa-plane" aria-hidden="true"></i></p>   
                <ul class="fooLinkNew">
                    <!-- <li><a href="/"><span>Home</span></a></li> -->
                    <li><a href="/aboutus"><span>About Us</span></a></li>
                    <li><a href="/contactus"><span>Contact Us</span></a></li>
                    <li><a href="/terms-and-conditions"><span>Terms & Conditions</span></a></li>
                    <li><a href="/privacy-policy"><span>Privacy Policy</span></a></li>
                    <!-- <li><a href="/cookies"><span>Cookies</span></a></li>
                    <li><a href="/disclaimer"><span>Disclaimer</span></a></li> -->
                    <li><a href="/blogs"><span>Travel Blog</span></a></li>
                    <li><a href="/post-ticketing-fees"><span>Post Ticketing Fees</span></a></li>
                    <li><a href="/sitemap"><span>Sitemap</span></a></li>
                </ul>
            </div>
            <div class="fooSBox">    
                <p class="fooSBox-heading">Top Destinations <i class="fa fa-plane" aria-hidden="true"></i></p>
                <ul class="fooLinkNew">
                    <li><a href="https://www.lowtickets.com/city/cheap-flights-to-bangkok-bkk"><span>Bangkok Flights</span></a></li>
                    <li><a href="https://www.lowtickets.com/city/cheap-flights-to-dubai-dxb"><span>Dubai Flights</span></a></li>
                    <li><a href="https://www.lowtickets.com/city/cheap-flights-to-losangeles-lax"><span>Los Angeles Flights</span></a></li>
                    <li><a href="https://www.lowtickets.com/city/cheap-flights-to-miami-mia"><span>Miami Flights</span></a></li>
                    <li><a href="https://www.lowtickets.com/city/cheap-flights-to-newyork-jfk"><span>New York Flights</span></a></li>
                    <li><a href="https://www.lowtickets.com/city/cheap-flights-to-rome-fco"><span>Rome Flights</span></a></li>
                    <li><a href="https://www.lowtickets.com/city/cheap-flights-to-sanfrancisco-sfo"><span>San Francisco Flights</span></a></li>
                </ul>
            </div>
            <div class="fooSBox">  
                <p class="fooSBox-heading">Popular routes <i class="fa fa-plane" aria-hidden="true"></i></p>  
                <ul class="fooLinkNew">
                    <li><a href="/destination/cheap-flights-from-newyork-jfk-to-london-lhr"><span>New York to London Heathrow</span></a></li>
                    <li><a href="/destination/cheap-flights-from-dallas-dfw-to-los-angeles-lax"><span>Dallas Fort Worth to Los Angeles</span></a></li>
                    <li><a href="/destination/cheap-flights-from-newyork-jfk-to-losangeles-lax"><span>New York to Los Angeles</span></a></li>
                    <li><a href="/destination/cheap-flights-from-losangeles-lax-to-paris-cdg"><span>Los Angeles to Paris</span></a></li>
                    <li><a href="/destination/cheap-flights-from-sanfrancisco-sfo-to-barcelona-bcn"><span>San Francisco to Barcelona</span></a></li>
                    <li><a href="/destination/cheap-flights-from-losangeles-lax-to-chicago-ord"><span>Los Angeles to Chicago O'Hare</span></a></li>
                </ul>
            </div>
            
            <!--start- subscribe -->
            <div class="subscrib-emailform">
						<p class="subscribform-heading">Sign up for Exclusive Email-Only deals!</p>
						
						 <div class="subscrib-form-sec">
							<div class="sign-up-box">
								<input type="text" name="subscribe_email" class="form-control inputfieldset subscrib-emailinput" id="subscribe_email"
									placeholder="Your Email" maxlength="100" />
									<label class="errorMsg">Email is required</label> 
									<label class="emailMsg">Please Enter Correct ID</label> 
							</div>
							<div class="sign-up-box">
								<input id="country_selected" class="form-control inputfieldset" type="text" />
							</div>
								
							<div class="subscrib-btn">
								<button class="submit EmailSignup" onclick="return subscribeEmail();">
									<label class="loader"><span>Loading...</span><i></i></label> <span>subscribe
										<i class="fa fa-envelope"></i>
									</span>
								</button>
							</div>	
						</div>
						<div class="subscrib-error">
							<label
							class="errorMsgCountry">Country is required</label> 
							<label
							class="subcribe-msg" id="subcribe-msg-success"></label>
						</div>
					</div>
			<!--end- subscribe -->
            
            <div class="fooSBox logoSocialMail">    
                <div class="fooLogo">
                    <picture>
                        <source srcset="/resources/images/footer_logo.webp" type="image/webp">
                        <img src="/resources/images/footer_logo.png" alt="footer_logo" 
                        width="30" height="15" loading="lazy" decoding="async">
                    </picture>
                </div>
                <div class="fooCalEm">
                    <!-- <div class="fcallusTxt"><span>Call us:</span></div> -->
                    <div class="fphone">
                        <a href="tel:+1-800-984-7414">+1-800-984-7414</a>
                    </div>
                    <div class="fmail">
                        <a href="mailto:bookings@lowtickets.com">bookings@lowtickets.com</a>
                    </div>

                    <div class="fooSocial">
                        <!-- <label>Connect By Social</label> -->
                        <!-- <div>
                            <a href="https://www.facebook.com/lowticketss" class="foot-facbook" aria-label="facebook link">
                                <i class="fa fa-facebook" aria-hidden="true"></i>
                            </a>
                            <a href="https://twitter.com/lowtickets_com" class="foot-twitter" aria-label="twitter link">
                                <i class="fa fa-twitter" aria-hidden="true"></i>
                            </a>
                            <a href="https://www.instagram.com/lowtickets_com/" class="foot-instagram" aria-label="instagram link">
                                <i class="fa fa-instagram" aria-hidden="true"></i>
                            </a>
                            <a href="https://www.pinterest.com/lowtickets/" class="foot-pinterest" aria-label="pinterest link">
                                <i class="fa fa-pinterest" aria-hidden="true"></i>
                            </a>
                        </div> -->

                        <div>
                            <a href="https://www.facebook.com/lowticketss" class="foot-facbook" aria-label="facebook link">
                                <svg xmlns="http://www.w3.org/2000/svg" height="26" width="20" viewBox="0 0 320 512"><path d="M80 299.3V512H196V299.3h86.5l18-97.8H196V166.9c0-51.7 20.3-71.5 72.7-71.5c16.3 0 29.4 .4 37 1.2V7.9C291.4 4 256.4 0 236.2 0C129.3 0 80 50.5 80 159.4v42.1H14v97.8H80z"/></svg>
                            </a>
                            <a href="https://twitter.com/lowtickets_com" class="foot-twitter" aria-label="twitter link">
                                <svg xmlns="http://www.w3.org/2000/svg" height="26" width="26" viewBox="0 0 512 512"><path d="M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z"/></svg>
                            </a>
                            <a href="https://www.instagram.com/lowtickets_com/" class="foot-instagram" aria-label="instagram link">
                                <svg xmlns="http://www.w3.org/2000/svg" height="30" width="28" viewBox="0 0 448 512"><path d="M224.1 141c-63.6 0-114.9 51.3-114.9 114.9s51.3 114.9 114.9 114.9S339 319.5 339 255.9 287.7 141 224.1 141zm0 189.6c-41.1 0-74.7-33.5-74.7-74.7s33.5-74.7 74.7-74.7 74.7 33.5 74.7 74.7-33.6 74.7-74.7 74.7zm146.4-194.3c0 14.9-12 26.8-26.8 26.8-14.9 0-26.8-12-26.8-26.8s12-26.8 26.8-26.8 26.8 12 26.8 26.8zm76.1 27.2c-1.7-35.9-9.9-67.7-36.2-93.9-26.2-26.2-58-34.4-93.9-36.2-37-2.1-147.9-2.1-184.9 0-35.8 1.7-67.6 9.9-93.9 36.1s-34.4 58-36.2 93.9c-2.1 37-2.1 147.9 0 184.9 1.7 35.9 9.9 67.7 36.2 93.9s58 34.4 93.9 36.2c37 2.1 147.9 2.1 184.9 0 35.9-1.7 67.7-9.9 93.9-36.2 26.2-26.2 34.4-58 36.2-93.9 2.1-37 2.1-147.8 0-184.8zM398.8 388c-7.8 19.6-22.9 34.7-42.6 42.6-29.5 11.7-99.5 9-132.1 9s-102.7 2.6-132.1-9c-19.6-7.8-34.7-22.9-42.6-42.6-11.7-29.5-9-99.5-9-132.1s-2.6-102.7 9-132.1c7.8-19.6 22.9-34.7 42.6-42.6 29.5-11.7 99.5-9 132.1-9s102.7-2.6 132.1 9c19.6 7.8 34.7 22.9 42.6 42.6 11.7 29.5 9 99.5 9 132.1s2.7 102.7-9 132.1z"/></svg>
                            </a>
                            <a href="https://www.pinterest.com/lowtickets/" class="foot-pinterest" aria-label="pinterest link">
                                <svg xmlns="http://www.w3.org/2000/svg" height="30" width="29" viewBox="0 0 496 512"><path d="M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3 .8-3.4 5-20.3 6.9-28.1 .6-2.5 .3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z"/></svg>
                            </a>
                        </div>

                    </div>
                </div>
            </div>

            <p class="f_logo">
                <picture>
                    <source srcset="/resources/images/certified.webp" type="image/webp">
                    <img src="/resources/images/certified.png" alt="Certified" 
                      width="20" height="5" loading="lazy" decoding="async">
                </picture>
            </p>
            <p class="foot-disclaimer">
                <strong>Disclaimer</strong>: lowtickets.com helps to coordinate the passengers with the airline directly. And we work very hard to deliver reliable information. lowtickets.com disclaims any responsibility for indirect, exceptional, or loss. By using lowtickets.com, you acknowledge that you have read, understand, and accept the terms and conditions. To contact us with any inquiries or issues, go to <a href="https://www.lowtickets.com/contactus"> (https://www.lowtickets.com/contactus)</a>.
            </p>
        </div>
        <p class="f_copy">Copyright &copy; 2021 - 2024, Lowtickets. All rights reserved.</p>
    </div>
     
</div>


<div class="tnfsticky-container">
    <div class="sticky-tnf">
        <ul class="sticky">
            <li>
                <span class="tnf-call-icon"><i class="fa fa-phone" aria-hidden="true"></i></span>
                <p><a href="tel:+1-800-984-7414" title="Call Us 24/7 for Lowest Airfares">+1-800-984-7414
                    <span>Relative to lowtickets</span>
                </a>
                </p>
                <span class="sticky-close"><i class="fa fa-close" aria-hidden="true"></i></span>
            </li>
        </ul>
  </div>
</div>

<script type="text/javascript">

jQuery(document).ready(function(){
    jQuery(".sticky-tnf .sticky li").click(function(){
        jQuery(this).toggleClass("tnf-show");
    });
});

function emailCheck(email){
	var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	if(email.match(mailformat)){
		return true;
	}else{
		return false;
	}
}

	function subscribeEmail() {
		var emailID = $("#subscribe_email").val();
		var countrySelected = $("#country_selected").val();

		var flag = false;
		var countryFlag = false;

		if (emailID == "") {
			flag = true;
			$(".errorMsg").show();
			$(".emailMsg").hide();
		} else {
			$(".errorMsg").hide();

			if (!emailCheck(emailID)) {
				flag = true;
				$(".emailMsg").show();
				$(".errorMsg").hide();
			} else {
				$(".emailMsg").hide();
			}
		}

		if (countrySelected == "") {
			countryFlag = true;
			$(".errorMsgCountry").show().css("color", "#f77171");
		} else {
			$(".errorMsgCountry").hide();
		}

		if (flag) {
			return;
		} else if (countryFlag) {
			return;
		} else {
			$.ajax({
				url : '/subscribesubmit/' + $("#subscribe_email").val() + '/' + $("#country_selected").val(),
				type : 'post',
				contentType : 'application/json; charset=utf-8',
				//data: JSON.stringify(data),
				dataType : "text",
				beforeSend : function() {
					$(".loader").show().addClass('activeLoader');
				},
				success : function(response) {
					$(".loader").hide().removeClass('activeLoader');
					if (response == 'true') {
						$("#subcribe-msg-success").text("You have successfully subscribed!").css("color", "#0fd90f").delay(5000) //timeout in 5 seconds 
					    .queue(function (next) {
					        $(this).text("");
					        next();
					    });
					} else {
						$("#subcribe-msg-success").text("Some Technical Issue Please try later!").css("color", "#f77171").delay(5000) 
					    .queue(function (next) {
					        $(this).text("");
					        next();
					    });	
					}
	}
			});
		}
	}
</script>
<script type="text/javascript">
	$("#country_selected").countrySelect({
		defaultCountry: "us",
		//onlyCountries: ['us', 'gb', 'au'],
		responsiveDropdown: true,
		preferredCountries: ['us', 'gb', 'au', 'ca', 'in']
	});
</script>