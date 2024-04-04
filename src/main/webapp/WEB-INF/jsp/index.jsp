<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title> Book Cheap Airline Tickets| Flight Tickets Online | Lowtickets.com </title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="DESCRIPTION" content="Book Cheap Flights Tickets, Flight Tickets Online of domestic & international Flights. Get Flight Reservations deals" />
    <meta name="keywords" content="Cheap Airline Tickets, Cheap Air Tickets, Cheap Flights, Flights Booking, Low Cost Airline Tickets, Flights Tickets, Lowest Air Fares, Cheap Flight Tickets, Cheap Air Fares, Discount Flights Tickets, Discounted Airfare Deals, Cheap Plane Tickets, Book a Flight.">
    <meta name="agd-partner-manual-verification" />
    <meta name="google-site-verification" content="JnEtqct6GKm77MqcdB-oBbUdhafEx5p_zzIYq8-Dy-8" />
    <meta name="p:domain_verify" content="1a7f7580be9b04bfd2ae48304170c277" />
    <link rel="icon" href="/resources/images/favicon.png">
    <link rel="canonical" href="https://www.Lowtickets.com/">
    <link rel="preload" as="image" href="/resources/images/enginebgnew.webp" as="image" type="image/webp"/>
    <link rel="preload" as="image" href="/resources/images/logo.png" />
    <link rel="preload" as="image" href="/resources/images/phone-call.png" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="/resources/css/nice-select.css">
    <link rel="stylesheet" href="/resources/css/default.css?25_Aug_2023">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.0/jquery.min.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="//widget.trustpilot.com/bootstrap/v5/tp.widget.bootstrap.min.js" async></script>    
    <jsp:include page="tag-manager-head.jsp" />
</head>

<body>
        <jsp:include page="tag-manager-body.jsp" />
        <!--Header Area Starts Here-->
	<div class="header">
		<div>
			<div class="upper-logo">
				<a href="/"><img src="/resources/images/logo.png" alt="logo" width="30" height="15" loading="lazy" decoding="async"></a>
			</div>

			<div class="upper-menu">
				<ul class="up-nav_group">
					<li><a href="/">Home</a></li>
					<li><a href="/aboutus">About Us</a></li>
					<li><a href="/blogs">Blog</a></li>
					<li><a href="/contactus">Contact Us</a></li>
					<c:if test="${userLogin == null}">
					</c:if>
					<c:if test="${userLogin != null}">
					</c:if>
				</ul>
			</div>

			<jsp:include page="country-dropdown.jsp" />

			<div class="expertisetalk">
				<span class="callicon"><img
					src="/resources/images/icons/24-hours.png" alt="Customer support"
					width="10" height="10" loading="lazy" decoding="async"></span> <span>Call
					Us for Lowest Airfares</span> <a href="tel:+1-800-984-7414"
					title="Call Us 24/7 for Lowest Airfares">+1-800-984-7414</a>
			</div>
			<div style="clear: both;"></div>
			<div class="side-navbar-button">
				<button type="button" onclick="showsidenav()"
					aria-label="opensidenav">
					<i class="fa fa-bars"></i>
				</button>
			</div>
		</div>
	</div>
	<div class="side-navbar" id="sidenavbar">
		<ul>
			<li><span>MENU</span>
			<button type="button" onclick="hidesidenav()"aria-label="hidesidenav"><i class="fa fa-close"></i></button>
			</li>
			<li><a href="/">Home</a></li>
			<li><a href="/aboutus">About Us</a></li>
			<li><a href="/blogs">Blog</a></li>
			<li><a href="/contactus">Contact Us</a></li>
			<li><a href="/terms-and-conditions">Terms & Conditions</a></li>
			<li><a href="/privacy-policy">Privacy Policy</a></li>
		</ul>
	</div>
	<div class="screen-overlay" id="screenoverlay" onclick="hidesidenav()"></div>
            <!--Header Ends Here-->
            <!--Engine Area Starts Here-->
            <div class="engine-bg">
                <div class="bg-overlay">
                    <div class="engineTopCntnt">
                        <h1>Compare and book with 450+ Airlines</h1>
                        <p>Discover your next dream destination</p>
                    </div>
                    <jsp:include page="engine.jsp" />
                    <!--Sign Up Area-->
                    <div class="signup-section">
                        <div class="signup-head"><b>SIGN UP</b> and <b>SAVE UP TO </b> $20 off our fees with a promo
                            code!</div>
                        <div class="signup-inputs">
                            <input type="text" id="newsEmail" placeholder="Get Lowtickets.com Emails">
                            <button type="button" id="sign_id" onclick="newsalertsubmit()">
                                <label class="loader"><span>Loading...</span><i></i></label>
                                <span>Sign Up</span>
                            </button>
                        </div>
                        <span id="newsMsg"></span>
                        <div class="signup-footer">

                            <li><a href="/privacy-policy">Privacy Policy</a></li>
                        </div>
                    </div>
                    <!--Sign Up End Here-->
                </div>
            </div>

            <section class="trustbox-widget-sec">
                <div class="container-custom">
                    <!-- TrustBox widget - Micro Review Count -->
                    <div class="trustpilot-widget" data-locale="en-US" data-template-id="5419b6a8b0d04a076446a9ad" data-businessunit-id="641d84e132ef9666402d41b4" data-style-height="24px" data-style-width="100%" data-theme="light" data-min-review-count="10" data-style-alignment="center">
                        <a href="https://www.trustpilot.com/review/lowtickets.com" target="_blank" rel="noopener">Trustpilot</a>
                    </div>
                    <!-- End TrustBox widget -->
                </div>
            </section>

            <section class="why_sec">
                <div class="container-custom">
                    <div class="sec_title">
                        <h2 class="main-heading">Why Choose <span class="colororgange">Lowtickets?</span></h2>
                    </div>
                    <div class="offer_box">
                        <div class="offer_box_in one">
                            <div class="why_icon_inner">
                                <span><i class="fa fa-list-alt" aria-hidden="true"></i></span>
                            </div>
                            <p class="offer_box_in_heading">Huge selection</p>
                            <p>Easily compare thousands of flights,<br> all in one place</p>
                        </div>

                        <div class="offer_box_in two">
                            <div class="why_icon_inner">
                                <span><i class="fa fa-eye-slash" aria-hidden="true"></i></span>
                            </div>
                            <p class="offer_box_in_heading">No hidden fees</p>
                            <p>Always know exactly what you're paying for</p>
                        </div>

                        <div class="offer_box_in three">
                            <div class="why_icon_inner">
                                <span><i class="fa fa-calendar-check-o" aria-hidden="true"></i></span>
                            </div>
                            <p class="offer_box_in_heading">More flexibility</p>
                            <p>Keep your travel dates open<br> with flexible ticket options</p>
                        </div>

                    </div>
                </div>
            </section>

            <section class="about_sec">
                <div class="container-custom">
                    <div class="about_wrap">
                        <div class="a_left">
                            <span class="about-text color141">ABOUT US</span>
                            <p class="main-heading">Explore All Corners of The World With Us</p>
                            <p>We at Lowtickets.com are constantly available to offer our customers first-rate services
                                for a world-class online holiday. Our main goal is to offer our customers one of the
                                quickest, simplest, and easiest ways to book a flight. With the help of our
                                simple-to-use technology, travelers will be able to plan the ideal vacation and learn
                                all the necessary details about their trip.</p>
                            <p>When travelers buy flights using Lowtickets, they can experience luxury and lavishness
                                just as if they were doing so on a different travel website. We always prioritize the
                                comfort of the traveler and provide the best flight within their price range.</p>
                            <a class="readmore" href="/aboutus">Read more...</a>
                        </div>
                        <div class="a_right">
                            <!-- <div class="img_1">
                                <img src="/resources/images/about-1.webp" alt="about-1" width="100" height="150"
                                    loading="lazy" decoding="async">
                            </div>
                            <div class="img_2">
                                <img src="/resources/images/about-2.webp" alt="about-2" width="100" height="150"
                                    loading="lazy" decoding="async">
                            </div> -->
                            <img src="/resources/images/h-aboutus.png" alt="about-1" width="536" height="466"
                                    loading="lazy" decoding="async">
                        </div>
                    </div>
                </div>
            </section>



            <div class="popDealSecn">
                <div class="best-deals">
                    <div class="deals-section pj">
                        <div class="heading_title">
                        <p class="main-heading">Popular <span class="colororgange">Deals</span></p>
                    </div>  
                        <div class="deal1main">
                            <c:forEach var="deal" items="${dealList.response}" end="7">
                                <fmt:parseDate value="${deal.depDate}" var="parsedDepDate" pattern="yyyy-MM-dd" />
                                <fmt:parseDate value="${deal.retDate}" var="parsedRetDate" pattern="yyyy-MM-dd" />
                                <fmt:formatDate pattern="MM/dd/yyyy" value="${parsedDepDate}" var="searchDepDate" />
                                <fmt:formatDate pattern="MM/dd/yyyy" value="${parsedRetDate}" var="searchRetDate" />
                                <div class="deal-wrapperp"
                                    onclick="dealclick('${deal.froCity}','${deal.toCity}','${searchDepDate}','${searchRetDate}');">

                                    <div class="deal-wraper">
                                        <div class="deal-section">
                                            <div class="dealimg"> <img
                                                    src="/resources/images/airline-logo/${deal.airline}.png"
                                                    class="myimg" alt="Airline" width="10" height="10" loading="lazy" decoding="async"></div>
                                            <div class="dealone"> ${deal.froCity} <span>
                                                    <fmt:formatDate pattern="MMM dd, yyyy" value="${parsedDepDate}" />
                                                </span>
                                            </div>
                                            <div class="dealtwo"><img src="/resources/images/icons/h_plane.png"
                                                    alt="swap" class="myimg" width="10" height="10" loading="lazy" decoding="async"></div>
                                            <div class="dealthree"> ${deal.toCity} <span>
                                                    <fmt:formatDate pattern="MMM dd, yyyy" value="${parsedRetDate}" />
                                                </span></div>
                                            <div class="dealfour"> <b>&#36;${deal.totalPrice}</b>
                                                <button type="button" class="btnif">Search Now</button>
                                            </div>

                                            <div style="clear: both;"></div>
                                        </div>
                                    </div>
                                    <div style="clear: left;"></div>
                                </div>

                            </c:forEach>
                        </div>



                    </div>
                </div>
            </div>
            

            <!-- <br> -->
            <!--Deal Section End-->

            <section class="explor_des">
                <div class="container-custom">
                    <div class="heading_title">
                        <p class="main-heading">Explore To <span class="colororgange">Destination</span></p>
                    </div>
                   
                    <div class="explor_box">
                        <a href="https://www.lowtickets.com/city/cheap-flights-to-miami-mia" class="grid">
                            <div class="grid_img">
                                <img src="/resources/images/about-1.jpg" alt="about" width="100" height="150"
                                    loading="lazy" decoding="async">
                                <span><i class="fa fa-star" aria-hidden="true"></i> 5</span>
                            </div>
                            <p class="explor_box_heading">Miami</p>
                        </a>
                        <a href="https://www.lowtickets.com/city/cheap-flights-to-newyork-jfk" class="grid">
                            <div class="grid_img">
                                <picture>
                                    <source srcset="/resources/images/new-york-1.jpg" type="image/webp">
                                    <img src="/resources/images/new-york-1.jpg" alt="new-york-1" width="100"
                                        height="150" loading="lazy" decoding="async">
                                </picture>
                                <span><i class="fa fa-star" aria-hidden="true"></i> 4</span>
                            </div>
                            <!-- <h4>Barcelona</h4> -->
                            <p class="explor_box_heading">New York</p>
                        </a>
                        <a href="https://www.lowtickets.com/city/cheap-flights-to-sanfrancisco-sfo" class="grid">
                            <div class="grid_img">
                                <picture>
                                    <source srcset="/resources/images/san-francisco-1.jpg" type="image/webp">
                                    <img src="/resources/images/san-francisco-1.jpg" alt="san-francisco-1"
                                        width="100" height="150" loading="lazy" decoding="async">
                                </picture>
                                <span><i class="fa fa-star" aria-hidden="true"></i> 5</span>
                            </div>
                            <!-- <h4>Switzerland</h4> -->
                            <p class="explor_box_heading">San Francisco</p>
                        </a>
                        <a href="https://www.lowtickets.com/city/cheap-flights-to-lasvegas-las" class="grid">
                            <div class="grid_img">
                                <picture>
                                    <source srcset="/resources/images/las-vegas-1.jpg" type="image/webp">
                                    <img src="/resources/images/las-vegas-1.jpg" alt="las-vegas-1" width="100"
                                        height="150" loading="lazy" decoding="async">
                                </picture>
                                <span><i class="fa fa-star" aria-hidden="true"></i> 5</span>
                            </div>
                            <!-- <h4>Paris</h4> -->
                            <p class="explor_box_heading">Las Vegas</p>
                        </a>
                    </div>

                </div>
            </section>

            <div class="customer_call">
                <div class="container-custom">
                    <div class="customer_body">
                        <div class="c_text">
                            <!-- <span class="q">Have any questions?</span> -->
                            <h3 class="main-heading">Have any <span class="colororgange">questions?</span></h3>
                            <p><strong>Call Directly to our Customer Care.</strong></p>
                            <p>Speak to a dedicated customer service representative who can help with your wants and
                                wishes for your next vacation. Receive the individualized care you require.</p>
                            <p>Discuss your needs and desires for your next trip with a customer service representative
                                who has the experience and knowledge to help. Obtain the individualized assistance which
                                you need.</p>
                            <a class="common_btn yelllow_common_btn" href="tel:+1-800-984-7414"><i class="fa fa-plane"
                                    aria-hidden="true"></i> <span class="shape"></span> <span>+1-800-984-7414</span></a>
                        </div>

                    </div>
                </div>
            </div>

            <section class="follow_sec">
                <div class="container-custom">
                    <div class="heading_title">
                        <p class="main-heading">Follow <span class="colororgange">LowTickets</span></p>
                    </div>
                    <div class="blogHomeSliderSection">
                        <div class="homeBlogSLider">
                            <div class="item"><img src="/resources/images/f-1.jpg" alt="Image 1" loading="lazy"
                                    decoding="async"></div>
                            <div class="item"><img src="/resources/images/f-2.jpg" alt="Image 2" loading="lazy"
                                    decoding="async"></div>
                            <div class="item"><img src="/resources/images/f-3.jpg" alt="Image 3" loading="lazy"
                                    decoding="async"></div>
                            <div class="item"><img src="/resources/images/f-4.jpg" alt="Image 4" loading="lazy"
                                    decoding="async"></div>
                            <div class="item"><img src="/resources/images/f-5.jpg" alt="Image 5" loading="lazy"
                                    decoding="async"></div>
                            <div class="item"><img src="/resources/images/f-6.jpg" alt="Image 6" loading="lazy"
                                    decoding="async"></div>
                        </div>
                    </div>
                </div>
            </section>
            <div class="home-footer">
                 <jsp:include page="footer.jsp" />
            </div>

</body>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.16.0/jquery.validate.min.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="/resources/scripts/nice-select.min.js"></script>
<script src="/resources/scripts/script.js?12july-2023"></script>
<script>
    $(document).ready(function () {
        $('.homeBlogSLider').slick({
            dots: false,
            infinite: true,
            speed: 300,
            slidesToShow: 5,
            slidesToScroll: 1,
            centerMode: true,
            //centerPadding: '60px',
            responsive: [
                {
                    breakpoint: 769,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 1,
                        centerMode: false
                    }
                },
                {
                    breakpoint: 501,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                },
                {
                    breakpoint: 401,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }

            ]
        });
    })
</script>
</html>