<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pageResponse.metaTitle}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="${pageResponse.metaDesc}">
    <meta name="keyword" content="${pageResponse.metaKeyword}">
    <link rel="icon" href="/resources/images/favicon.png">
    <link rel="canonical" href="https://www.Lowtickets.com/city/cheap-flights-to-${pageResponse.url}-${pageResponse.pageValue}">
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700&display=swap" rel="preload" as="font" crossorigin="anonymous">
    <link rel="preload" fetchpriority="high" href="/resources/images/enginebg.webp" as="image" type="image/webp" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
    <link rel="stylesheet" href="/resources/css/nice-select.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.16.0/jquery.validate.min.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/default.css?v=2.7">
    
    <jsp:include page="tag-manager-head.jsp" />

    <style>
        .why_sec .main-heading {font-size: 24px;}
    </style>

</head>
<body><jsp:include page="tag-manager-body.jsp" />

<style type="text/css">
	
.static-content .subheadings {
    font-size: 20px;
    font-weight: 600;
}	
.cityDealsNewSec {
    margin-bottom: 10px;
}
	
.dealCitySec {
	display: grid;
	grid-template-columns: auto auto auto auto;
	gap: 20px;
	margin-bottom:50px;
}

.dealCitySec .dealBox {
	box-shadow: 0 0 5px #bbb2b2;
	border-radius: 6px;
	padding: 15px;
}

.dealCitySec .tFullSctn {
	display: grid;
	grid-template-columns: auto auto;
}

.dealCitySec .tPartLft>div {
	font-size: 24px;
	font-weight: bold;
	color: #008a04;
}

.dealCitySec .tPartLft>p {
	margin: 0;
	color: #646464;
	font-size: 13px;
}

.dealCitySec .tPartLft sup {
	font-size: 12px;
}

.dealCitySec .tPartRht {
	color: #646464;
}

.dealCitySec .tPartRht i {
    margin: 0 10px;
}

.dealCitySec .tPartRht p {
	margin: 0;
}

.dealCitySec .dealProgress {
	display: flex;
	align-items: center;
	height: 30px;
	gap: 10px;
	margin-top: 8px;
}

.dealCitySec .dealProgress span {
	position: relative;
	width: 33.33%;
	display: inline-block;
	height: 5px;
	background: #008a04;
	border-radius: 4px;
}

.dealCitySec .dealProgress span:nth-child(2) {
	background: #FF9800;
}

.dealCitySec .dealProgress span:nth-child(3) {
	background: #FF5722;
}

.dealCitySec .dealProgress span:nth-child(1):before {
	content: "\f0d7";
	font-family: FontAwesome;
	color: #008a04;
	position: absolute;
	top: -15px;
	left: calc(50% - 4px);
}

.dealCitySec .twoPice {
	display: flex;
	justify-content: space-evenly;
	color: #878787;
	font-size: 13px;
	margin: 12px 0 0px;
}

.dealCitySec .dealDetails {
	text-align: center;
	font-size: 12px;
	color: #878787;
	margin: 13px 0 0;
	display: flex;
	justify-content: center;
	align-items: center;
}

.dealCitySec .dealDetails i {
	width: 20px;
	height: 20px;
	display: inline-flex;
	border: 1px solid #999999;
	border-radius: 20px;
	color: #afafaf;
	align-items: center;
	justify-content: center;
	margin: 0 0 0 5px;
}

.cityDealsNewSec .dealBody{
	margin-bottom: 50px;
}

.cityDealsNewSec table {
	border-collapse: collapse;
	width: 100%;
}

.cityDealsNewSec td, .cityDealsNewSec th {
	border: 1px solid #ddd !important;
	padding: 8px;
}

.cityDealsNewSec td {
	height: 70px;
	border-left: 0 !important;
	border-right: 0 !important
}

.cityDealsNewSec tr:nth-child(even) {
	background-color: #f2f2f2;
}

.cityDealsNewSec tr:hover {
	background-color: #f2f2f2;
}

.cityDealsNewSec th {
	padding-top: 12px !important;
	padding-bottom: 12px !important;
	text-align: left;
	background-color: #063d99;
	color: white; /*border: 1px solid #0b357c !important*/
	border: 0 !important
}

.cityDealsNewSec th:last-child, .cityDealsNewSec td:last-child {
	text-align: right;
}

.cityDealsNewSec td:last-child strong {
	font-size: 22px;
	color: #063d99;
	cursor: pointer;
	font-weight: 500;
}

.cityDealsNewSec td:last-child strong sup {
	font-size: 12px;
	position: relative;
	top: -5px;
}

.cityDealsNewSec thead {
	border: 1px solid #063d99;
}

.cityDealsNewSec tbody {
	border: 1px solid #ddd
}

.dealBody td .deal-wrapperp {
    width: 100%;
}

.dealCitySec .dealBox .deal-wrapperp{
	    text-align: center;
		margin-bottom: 10px;
}

.dealCitySec .dealBox .deal-wrapperp button {
    font-size: 13px;
    background-color: #063d99;
    border: 0;
    padding: 5px 12px;
    color: #fff;
    border-radius: 3px;
    cursor: pointer;
}

.static-content .subheadings {
    font-weight: 600;
}


@media ( max-width : 767px) {
	.dealCitySec {
		grid-template-columns: auto auto;
	}
}

@media ( max-width :500px) {
	.dealCitySec {
		grid-template-columns: auto;
	}
	.cityDealsNewSec th {
		font-size: 12px
	}
	.cityDealsNewSec td {
		font-size: 11px
	}
	.cityDealsNewSec td:last-child strong {
		font-size: 16px
	}
	.cityDealsNewSec td:last-child strong sup {
		font-size: 10px;
	}
}
</style>
    <!--Header Area Starts Here-->
    <jsp:include page="header.jsp" />
    <div class="screen-overlay" id="screenoverlay" onclick="hidesidenav()"></div>
    <!--Header Ends Here-->
    <!--Engine Area Starts Here-->
	<input type="hidden" id="pageUrl" value="${pageResponse.url}" />
    <div class="engine-bg">
        <div class="bg-overlay">
            <div class="engineTopCntnt"><p class="bg-overlay-bannerheading">Flights To <span style="text-transform:capitalize;">${fn:replace(page,'-',' ')}</span> </p></div>
            <jsp:include page="engine.jsp" />
            <!--Sign Up Area-->
            <div class="signup-section">
                <div class="signup-head"><b>SIGN UP</b> and <b>SAVE UP TO </b>  $20 off our fees with a promo code!</div>
                <div class="signup-inputs">
                    <input type="text" id="newsEmail" placeholder="Get Cheapinair.com Emails">
                    <button type="button" onclick="newsalertsubmit()">Sign Up</button>
                </div>
				<span id="newsMsg"></span>
                <div class="signup-footer">
                   
                    <li><a href="/privacy-policy">Privacy Policy</a></li>
                </div>
            </div>
            <!--Sign Up End Here-->
        </div>
    </div>
    <!--Engine Area Ends Here-->
    
    <div class="about-airlines static-content">

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
                    <p class="main-heading">Why Choose <span class="colororgange">Lowtickets?</span></p>
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


		<div class="nextTripDeals" style="">
			<c:if test="${filterDealResponse.size()>0 }">
				<p class="subheadings">Found these great deals for your next trip</p>
				<div class="dealCitySec">
				<c:forEach var="deal" items="${filterDealResponse}" begin="0" end="3">
				<fmt:parseDate value="${deal.depDate}" var="parsedDepDate" pattern="yyyy-MM-dd" />
				<fmt:parseDate value="${deal.retDate}" var="parsedRetDate" pattern="yyyy-MM-dd" />
				<fmt:formatDate pattern="MM/dd/yyyy" value="${parsedDepDate}" var="searchDepDate" />
				<fmt:formatDate pattern="MM/dd/yyyy" value="${parsedRetDate}" var="searchRetDate" />
				
					<div class="dealBox">
						<div class="tFullSctn">
							<div class="tPartLft">
								<div>${deal.totalPrice}</div>
								<p>Round Trip</p>
							</div>
							<div class="tPartRht">
								<p>
									 ${deal.froCity}<i class="fa fa-exchange"></i>${deal.toCity}
								</p>
								<p><fmt:formatDate pattern = "MMM dd" value = "${parsedDepDate}" /> - <fmt:formatDate pattern = "MMM dd" value = "${parsedRetDate}" /></p>
							</div>
						</div>
						<div class="dealProgress">
							<span></span> <span></span> <span></span>
						</div>
						 <div class="twoPice">
							<div class="deal-wrapperp" onclick="dealclick('${deal.froCity}','${deal.toCity}','${searchDepDate}','${searchRetDate}');"><button type="button">Search Now</button></div>
						</div> 
						<div class="dealDetails">
							<span>How we calculate this</span><i class="fa fa-info"
								aria-hidden="true"></i>
						</div>
					</div>
						</c:forEach>
					</div>
					</c:if>
		
	
				<div class="cityDealsNewSec" style="">
			 <c:if test="${filterDealResponse.size()>0}">
				<p class="subheadings"><span style="text-transform:capitalize;">${fn:replace(page,'-',' ')}</span> Flight Deals</p>
				<!-- <div class="dealHeadng">
					
				</div> -->
				<div class="dealBody">
					<div class="table-responsive ">
					<table class="table">
						<thead>
							<tr>
								<th>From</th>
								<th>To</th>
								<th>Depart</th>
								<th>Return</th>
								<th>Airline</th>
								<th>Sample Fares*</th>
							</tr>
						</thead>
						<tbody>
						
						<c:forEach var="deal" items="${filterDealResponse}" begin="0" end="7">
					
							<fmt:parseDate value="${deal.depDate}" var="parsedDepDate" pattern="yyyy-MM-dd" />
							<fmt:parseDate value="${deal.retDate}" var="parsedRetDate" pattern="yyyy-MM-dd" />
							<fmt:formatDate pattern="MM/dd/yyyy" value="${parsedDepDate}" var="searchDepDate" />
							<fmt:formatDate pattern="MM/dd/yyyy" value="${parsedRetDate}" var="searchRetDate" />
							
					
						 <tr>
						 
								<td>${deal.froCity}</td>
								<td>${deal.toCity}</td>
								<td><fmt:formatDate pattern="MMM dd, yyyy" value="${parsedDepDate}" /></td>
								<td><fmt:formatDate pattern="MMM dd, yyyy" value="${parsedRetDate}" /></td>
								<td><img src="/resources/images/airline-logo/${deal.airline}.png"  class="myimg" alt="Airline" width="35" height="35"></td>
								<td><div class="deal-wrapperp" onclick="dealclick('${deal.froCity}','${deal.toCity}','${searchDepDate}','${searchRetDate}');"><strong>&#36;${deal.totalPrice}</strong></div></td>
								
							</tr>
							
							
							</c:forEach>
							
						</tbody>
					</table>
				</div>
				</div>
	</c:if>
				
	<div class="citypage-dynamiccontent blogflightheading">
              ${pageResponse.contentData}
        </div> 
	
			 <c:if test="${blogResponse.response.size() > 3}">  
				<div class="recentPostSec" style="">
					<p class="subheadings">Recent Posts</p>
					
					<div class="blogRecent">
					<c:forEach var="deal" items="${blogResponse.response}"  end="3">
						<div class="blogBox">
							<!-- <img
								src="/resources/images/my-lost-luggage.png"
								alt="best-airline-discounts-for-us-students-sm" /> -->
							<p class="recentblog-heading">${deal.heading} </p>
							<div class="recentblog-text">
							   ${fn:escapeXml(fn:substring(deal.content.replaceAll('<.*?>' , ""), 0, 115))}
						  </div>
							<div class="readmore_btn"> 
									<a href="/blogs/${deal.titleUrl}">Read More</a>
							</div>
						</div>
						</c:forEach>
				
				
			</div>
			</div>
		</c:if>  
			</div>
	
		
	
	
		</div>


        <!-- <div class="citypage-dynamiccontent blogflightheading">
              ${pageResponse.contentData}
        </div> -->


    </div>


    <!--Deals Section Starts-->
	<%-- <c:if test="${dealResponse.response.size() > 0}">
    <div class="best-deals cityapi-section">
        <div class="dealHeadScn">
            <p class="dealHeadScn-heading">Think Ahead and Plan Your Next Trip</p>
        </div>
        
        <div class="deals-section city-deal-sec">
            
            <!-- <hr> -->
            <div class="deal-blocks">
			
                <c:forEach var="deal" items="${dealResponse.response}" end="7">
			<fmt:parseDate value = "${deal.depDate}" var = "parsedDepDate" pattern = "yyyy-MM-dd" />
			<fmt:parseDate value = "${deal.retDate}" var = "parsedRetDate" pattern = "yyyy-MM-dd" />
			<fmt:formatDate pattern = "MM/dd/yyyy" value = "${parsedDepDate}" var="searchDepDate" />
			<fmt:formatDate pattern = "MM/dd/yyyy" value = "${parsedRetDate}" var="searchRetDate" />
                <div class="deal-item" onclick="dealclick('${deal.froCity}','${deal.toCity}','${searchDepDate}','${searchRetDate}');">
                    <img src="/resources/images/chicago.jpg" alt="chicago" width="20" height="20" loading="lazy" decoding="async">
                    <div class="deal-text">
                        <span class="cityname">${deal.toCityName}</span>
                        <span class="cityfromto">${deal.froCity} <i class="fa fa-arrows-h"></i> ${deal.toCity}</span>
						
                        <span class="datefromto"><fmt:formatDate pattern = "MMM dd" value = "${parsedDepDate}" /> &#8208; <fmt:formatDate pattern = "MMM dd" value = "${parsedRetDate}" /></span>
                        <div>
                            <span class="price">&#36;${deal.totalPrice}</span>
                            <button type="button">Search Now</button>
                        </div>
                    </div>
                </div>
             </c:forEach>
                
                
            </div>
        </div>
        
    </div>
		</c:if> --%>
    <!-- <br> -->
	
    <div class="clearfix"></div>
	
			
	<%-- <jsp:include page="customer-review.jsp" /> --%>
	
	<!-- -------------- -->
		<style type="text/css">
.recentPostSec {
    margin-top: 50px;
}

.recentPostSec .blogRecent {
	display: grid;
	grid-template-columns: auto auto auto auto;
	gap: 15px;
}

.recentPostSec .blogRecent img {
	max-width: 100%;
	border-radius: 10px 10px 0 0;
	height: auto;
	width:100%;
}

.recentPostSec .blogRecent .blogBox {
	box-shadow: 0 0 10px gainsboro;
	border-radius: 10px;
	text-align: center;
	padding-bottom: 20px;
	border: 1px solid #eeeeee;
    background: rgb(6, 61, 153, .10);
    padding: 0 15px 10px;
}

.recentPostSec .blogRecent .blogBox .recentblog-heading {
    font-weight: 600;
}

.blogRecent .readmore_btn {
    margin-top: 20px;
    font-size: 15px;
}
.blogRecent .readmore_btn a {
    font-size: 11px;
}



.blogRecent .recentblog-text {
    font-size: 14px;
    line-height: 20px;
}

.recentPostSec .blogRecent .blogBox:hover {
	box-shadow: 0 0 20px #afaeae;
	transition: all 0.3s;
}

.recentPostSec .readmore_btn a {
    background: #db2203;
    color: #ffff;
    text-decoration: none;
    font-size: 12px;
    display: inline-block;
    padding: 7px 8px;
    border-radius: 5px;
    letter-spacing: .5px;
}

@media ( max-width : 767px) {
	.recentPostSec .blogRecent {
		grid-template-columns: auto auto;
	}
}

@media ( max-width :500px) {
	.recentPostSec .blogRecent {
		grid-template-columns: auto;
	}
}
</style>
			
	<!--Footer Starts-->
    <div class="tfn-show-footer">
        <jsp:include page="footer.jsp" />
    </div>
</body>
<script src="/resources/scripts/script.js"></script>
<script type="text/javascript" src="//widget.trustpilot.com/bootstrap/v5/tp.widget.bootstrap.min.js" async></script>
<script src="/resources/scripts/nice-select.min.js"></script>
<script>
    $(document).ready(function() {
      $('.selectNiceSelect').niceSelect();
    });
</script>
</html>