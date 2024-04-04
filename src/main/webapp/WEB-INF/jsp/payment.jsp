<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html ng-app="flightPayment">
    <head>
        <title>Review Trip Details & Book</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href='https://fonts.googleapis.com/css?family=Chivo' rel='stylesheet'>
        <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet'>
        <link rel="icon" href="/resources/images/favicon.png">
		<script src="/resources/scripts/jquery-1.11.1.min.js"></script>
		<script src="/resources/scripts/jquery.validate.min.js"></script>
		<script src="/resources/scripts/angular.min.js"></script>
		<script src="/resources/scripts/jquery.creditCardValidator.js"></script>
		<script src="/resources/scripts/fpayment.js?20032022"></script>
		<script src="/resources/scripts/ancillaries.js?v=7Nov2023"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="//widget.trustpilot.com/bootstrap/v5/tp.widget.bootstrap.min.js" async></script>
		<style>
		.has-error{border: 1px solid red !important;}
        .submit-details button
        {
            color:#fff;
            background-color:#FF4500!important;
            height:50px; 
            width:100%;
            margin:15px 30%; 
            border:0;
            outline:0;
            font-size:18px;
            font-weight:550;
            border-radius:3px;
        }


.bdform input.rkap { width:100%!important;}
.bdform select.rkap4{ width:99%!important;}

.mobile-price-details { display:none; }
@media(max-width: 767px){
    .mobile-price-details { display: block; }
    .desktop-price-details { display:none; }
}


	</style>
		<script>
function goBack() {
  window.history.back();
}
</script>


<link rel="stylesheet" href="/resources/css/payment.css?9April_2022" type="text/css">
    <jsp:include page="tag-manager-head.jsp" /></head>
    <body ng-controller="flightPaymentCntrl">
    <jsp:include page="tag-manager-body.jsp" />
        
        <div class="header-container">
            <div class="header">
                <div class="logo-fh">
                    <a href="/"><img src="/resources/images/logo.png" width="20" height="4"></a>
                </div>
                <div class="navbar-main">
                    <div class="expert-talk">
                        <!-- <a href="tel:+1(800) 984-7414"><span>Get Customer Support: </span><span> +1(800) 984-7414</span></a> -->

                        <a href="tel:+1-800-984-7414">
                            <span class="call-icon">
                                <img src="/resources/images/icons/24-hours.png" alt="phonek" width="5" height="5" loading="lazy" decoding="async"> 
                            </span>
                            <span class="topcall-text-sec"> 
                                <span class="topcall-text">Get Customer Support:</span>
                                +1-800-984-7414
                            </span>
                        </a>
            </div>

                </div>
                <div class="side-navbar-button" style="display: none;">
                    <button type="button" onclick="showsidenav()"><i class="fa fa-bars"></i></button>
                </div>
            </div>
        </div>
        <div class="side-navbar" id="sidenavbar">
            <li><button type="button" onclick="hidesidenav()"><i class="fa fa-close"></i></button></li>
           
            <li><a href="/contactus">Contact Us</a></li>
        <li><a href="/terms-and-conditions">Terms & Conditions</a></li>
        <li><a href="/privacy-policy">Privacy Policy</a></li>
            <p>Copyright &copy;  2021 - 2023, Lowtickets. All rights reserved</p>
        </div>
        <div class="screen-overlay" id="screenoverlay" onclick="hidesidenav();"></div>
        <div id="screenoverlay2" onclick="enginehide();"></div>
        <div class="backbtnrow mycontainer">
            <button type="button" onclick="goBack();" style="border-radius:3px"><i class="fa fa-long-arrow-left" aria-hidden="true"></i>&nbsp;&nbsp; Go Back</button>
        </div>
		
		<fmt:setLocale value="en_US" scope="session"/>

		<form:form method="POST" action="/flight/payment/confirm" modelAttribute="bookingRequest" novalidate="novalidate">
		<input type="hidden" id="sessionId" value="${bookingRequest.searchID}">
        <div class="ftpdetails mycontainer">
            <div class="ft-block">
                <div class="flight-details payment-sectop">
                    <div class="fdhead">
                        <img src="/resources/images/icons/Pplane-white.png" alt="Plane">&nbsp;&nbsp;Flight Details
                    </div>
                    <div class="departure">
                        <div class="deprow">
                            <span>Departure</span>
                            <a href="javascript:void(window.open('/baggage-fees', 'Taxes and Fees', 'width=600,height=750,scrollbars=yes'));"><i class="fa fa-briefcase"></i>&nbsp;Baggage Fees</a>
                             </div>
						<c:forEach var="outbound" items="${bookingRequest.flightResult.outBound}">
                        <div class="flirow">
                            <div class="fdetails1"><img src="/resources/images/airline-logo/${outbound.airline}.png">&nbsp;&nbsp;<div><span class="fliname">${outbound.airlineName}</span><span class="flinum">Flight ${outbound.flightNo}</span></div></div>
                            <div class="tadetails">
                                <div class="a1d">
                                    <div><span class="sname">${outbound.fromAirport}</span><span class="fname"> ${outbound.froCityName},${outbound.fromAirportName}</span></div>
                                    <c:set var="depDate" value="${fn:replace(outbound.depDate,'T', ' ')}" />
									<fmt:parseDate value="${depDate}" var="dateObject" pattern="yyyy-MM-dd HH:mm:ss" />
									<div><span class="date"><fmt:formatDate value="${dateObject }" pattern="EEE, MMM dd" /></span>&nbsp<span class="time"> <fmt:formatDate value="${dateObject }" pattern="hh:mm a" /></span></div>
                                </div>
                                <i class="fa fa-long-arrow-right" style="font-size:30px;color:#17252A"></i>
                                <div class="a2d">
                                    <div><span class="sname">${outbound.toAirport}</span><span class="fname"> ${outbound.toCityName},${outbound.toAirportName}</span></div>
                                    <c:set var="reachDate" value="${fn:replace(outbound.reachDate,'T', ' ')}" />
									<fmt:parseDate value="${reachDate}" var="reachObject" pattern="yyyy-MM-dd HH:mm:ss" />
									<div><span class="date"><fmt:formatDate value="${reachObject }" pattern="EEE, MMM dd" /> </span>&nbsp<span class="time" ><fmt:formatDate value="${reachObject }" pattern="hh:mm a" /></span></div>
                                </div> 
                            </div>
                            <div class="cwdetails"><span class="wayd">Non Stop</span><span class="classd"><script>document.write(getCabin(<c:out value='${outbound.cabinClass}' />))</script></span></div>
                            <div class="fdetails2"><img src="/resources/images/airline-logo/${outbound.airline}.png">&nbsp;&nbsp;<div><span class="fliname">${outbound.airlineName}</span><span class="flinum">Flight ${outbound.flightNo}</span></div></div>
                        </div>
                        
                        <c:if test="${not empty outbound.layOverTime}">
                        	<c:if test="${outbound.layOverTime > 0 }">
                        		<h2 class="stop-divider"><span><i class="fa fa-clock-o"></i> <script>document.write(timeConvert(<c:out value='${outbound.layOverTime}' />))</script> layover in ${outbound.toCityName} (${outbound.toAirport})</span></h2>
                        	</c:if>
                        </c:if>
                        
                        </c:forEach>
                    </div>
                    
                    <c:if test="${not empty bookingRequest.flightResult.outEFT}">
                    	<div class="durarow">
                        	<span><i class="fa fa-clock-o"></i> Total Trip Time: <script>document.write(timeConvert(<c:out value='${bookingRequest.flightResult.outEFT}' />))</script></span>
                    	</div>
                    </c:if>
                     
                    <div class="return">
                        <div class="retrow">
						<c:if test="${searchRequest.tripType == 2}">
                            <span>Return</span>
						</c:if>	
						<c:if test="${searchRequest.tripType == 3}">
                            <span>Departure</span>
						</c:if>
                        </div>
						<c:forEach var="inbound" items="${bookingRequest.flightResult.inBound}">
                        <div class="flirow">
                            <div class="fdetails1"><img src="/resources/images/airline-logo/${inbound.airline}.png">&nbsp;&nbsp;<div><span class="fliname">${inbound.airlineName}</span><span class="flinum">Flight ${inbound.flightNo}</span></div></div>
                            <div class="tadetails">
                                <div class="a1d">
                                    <div><span class="sname">${inbound.fromAirport}</span><span class="fname"> ${inbound.froCityName},${inbound.fromAirportName}</span></div>
                                    <c:set var="depDate" value="${fn:replace(inbound.depDate,'T', ' ')}" />
									<fmt:parseDate value="${depDate}" var="dateObject" pattern="yyyy-MM-dd HH:mm:ss" />
                                    <div><span class="date"><fmt:formatDate value="${dateObject }" pattern="EEE, MMM dd" /></span>&nbsp<span class="time"> <fmt:formatDate value="${dateObject }" pattern="hh:mm a" /></span></div>
                                </div>
                                <i class="fa fa-long-arrow-right" style="font-size:30px;color:#17252A"></i>
                                <div class="a2d">
                                    <div><span class="sname">${inbound.toAirport}</span><span class="fname"> ${inbound.toCityName},${inbound.toAirportName}</span></div>
                                    <c:set var="reachDate" value="${fn:replace(inbound.reachDate,'T', ' ')}" />
									<fmt:parseDate value="${reachDate}" var="reachObject" pattern="yyyy-MM-dd HH:mm:ss" />
                                    <div><span class="date"><fmt:formatDate value="${reachObject }" pattern="EEE, MMM dd" /> </span>&nbsp<span class="time" ><fmt:formatDate value="${reachObject }" pattern="hh:mm a" /></span></div>
                                </div> 
                            </div>
                            <div class="cwdetails"><span class="wayd">Non Stop</span><span class="classd"><script>document.write(getCabin(<c:out value='${inbound.cabinClass}' />))</script></span></div>
                            <div class="fdetails2"><img src="/resources/images/airline-logo/${inbound.airline}.png">&nbsp;&nbsp;<div><span class="fliname">${inbound.airlineName}</span><span class="flinum">Flight ${inbound.flightNo}</span></div></div>
                        </div>
                        
                        <c:if test="${not empty inbound.layOverTime && inbound.layOverTime > 0}">
                        	<h2 class="stop-divider"><span><i class="fa fa-clock-o"></i> <script>document.write(timeConvert(<c:out value='${inbound.layOverTime}' />))</script> layover in ${inbound.toCityName} (${inbound.toAirport})</span></h2>
                        </c:if>
                        
                        </c:forEach>
                    </div>
                    
					<%-- <c:if test="${not empty bookingRequest.flightResult.inEFT}"> --%>
					<c:if test="${bookingRequest.flightResult.inBound != null}">
                    	<div class="durarow">
                        	<span><i class="fa fa-clock-o"></i> Total Trip Time: <script>document.write(timeConvert(<c:out value='${bookingRequest.flightResult.inEFT}' />))</script></span>
                    	</div>
					</c:if>
					
					<c:forEach var="outbound" items="${bookingRequest.flightResult.otherBound}">
					<div class="departure">
                        <div class="deprow">
                            <span>Departure</span>
                            <a href="#"><i class="fa fa-briefcase"></i>&nbspBaggage Fees</a>
                        </div>
						<c:forEach var="outbound" items="${outbound}">
                        <div class="flirow">
                            <div class="fdetails1"><img src="/resources/images/airline-logo/${outbound.airline}.png">&nbsp;&nbsp;<div><span class="fliname">${outbound.airlineName}</span><span class="flinum">Flight ${outbound.flightNo}</span></div></div>
                            <div class="tadetails">
                                <div class="a1d">
                                    <div><span class="sname">${outbound.fromAirport}</span><span class="fname"> ${outbound.froCityName},${outbound.fromAirportName}</span></div>
                                    <c:set var="depDate" value="${fn:replace(outbound.depDate,'T', ' ')}" />
									<fmt:parseDate value="${depDate}" var="dateObject" pattern="yyyy-MM-dd HH:mm:ss" />
									<div><span class="date"><fmt:formatDate value="${dateObject }" pattern="EEE, MMM dd" /></span>&nbsp<span class="time"> <fmt:formatDate value="${dateObject}" pattern="hh:mm a" /></span></div>
                                </div>
                                <i class="fa fa-long-arrow-right" style="font-size:30px;color:#17252A"></i>
                                <div class="a2d">
                                    <div><span class="sname">${outbound.toAirport}</span><span class="fname"> ${outbound.toCityName},${outbound.toAirportName}</span></div>
                                    <c:set var="reachDate" value="${fn:replace(outbound.reachDate,'T', ' ')}" />
									<fmt:parseDate value="${reachDate}" var="reachObject" pattern="yyyy-MM-dd HH:mm:ss" />
									<div><span class="date"><fmt:formatDate value="${reachObject }" pattern="dd, MMM yyyy" /> </span>&nbsp<span class="time" ><fmt:formatDate value="${reachObject }" pattern="hh:mm a" /></span></div>
                                </div> 
                            </div>
                            <div class="cwdetails"><span class="wayd">Non Stop</span><span class="classd"><script>document.write(getCabin(<c:out value='${outbound.cabinClass}' />))</script></span></div>
                            <div class="fdetails2"><img src="/resources/images/airline-logo/${outbound.airline}.png">&nbsp;&nbsp;<div><span class="fliname">${outbound.airlineName}</span><span class="flinum">Flight ${outbound.flightNo}</span></div></div>
                        </div>
                        <c:if test="${not empty outbound.layOverTime && outbound.layOverTime > 0 }">
                        <h2 class="stop-divider"><span><i class="fa fa-clock-o"></i> <script>document.write(timeConvert(<c:out value='${outbound.layOverTime}' />))</script> layover in ${outbound.toCityName} (${outbound.toAirport})</span></h2>
                        </c:if>
						
						<c:if test="${not empty outbound.eft}">
							<div class="durarow">
                        		<span><i class="fa fa-clock-o"></i> Total Trip Time: <script>document.write(timeConvert(<c:out value='${outbound.eft}' />))</script></span>
                    		</div>
						</c:if>
						
                        </c:forEach>
                    </div>
                    
					</c:forEach>
                </div>
                
                <div class="traveler-details payment-sectop">
                    <div class="tdhead">
                        <img src="/resources/images/icons/Ppeople-white.png" alt="Travelers">&nbsp;&nbsp;Traveler Information
                    </div>
                    
                <style type="text/css">
                .tdform .tname { position:relative; }
                .tdform .tname .error_text:nth-child(2) { position:absolute; bottom:-12px; left:0; font-size:12px; color:red; font-weight:normal; width:32%; }
                .tdform .tname .error_text:last-child { position:absolute; bottom:-12px; right:0; font-size:12px; color:red; font-weight:normal; width:32%; }
                .tdform .tgdob { position:relative; }
                .tdform .tgdob > .error_text:nth-child(2) { position:absolute; bottom:3px; left:0; font-size:12px; color:red; font-weight:normal; width:32%; }
                .tdform .tgdob > .dobform .dob { position:relative; }
                .tdform .tgdob > .dobform .dob .error_text:nth-child(2) { position:absolute; bottom:-20px; left:0; font-size:12px; color:red; font-weight:normal; width:32%; }
                .tdform .tgdob > .dobform .dob .error_text:nth-child(4) { position:absolute; bottom:-20px; left:34%; font-size:12px; color:red; font-weight:normal; width:32%; }
                .tdform .tgdob > .dobform .dob .error_text:last-child { position:absolute; bottom:-20px; right:0; font-size:12px; color:red; font-weight:normal; width:32%; }
                @media(max-width:768px){
                    .tdform .tname .error_text:nth-child(2) { bottom:unset; top:44px; width:100%; }
                    .tdform .tname .error_text:last-child { width:100%; bottom:-1px; }
                    .tdform .tgdob > .error_text:nth-child(2) { bottom:unset; top:44px; width:100%; }
                }
                @media(max-width:370px){
                    .tdform .tgdob > .dobform .dob .error_text:nth-child(2) { line-height:8px; }
                    .tdform .tgdob > .dobform .dob .error_text:nth-child(4) { line-height:8px; }
                    .tdform .tgdob > .dobform .dob .error_text:last-child { line-height:8px; }
                }
                </style>
					<c:forEach items="${bookingRequest.passengerDetails}" var="passenger" varStatus="indexed">
                    <div class="tdblock">
                        <div>
						<span><c:out value="${indexed.index+1}"/></span>. 
                     <span> <c:if test="${passenger.passengerType == 1}">
                                Adult
								 <form:hidden path="passengerDetails[${indexed.index}].passengerType" value="1"/>
								</c:if>
								 <c:if test="${passenger.passengerType == 2}">
                                Child
								 <form:hidden path="passengerDetails[${indexed.index}].passengerType" value="2"/>
								</c:if>
								 <c:if test="${passenger.passengerType == 3}">
                                Infant (on lap)
								 <form:hidden path="passengerDetails[${indexed.index}].passengerType" value="3"/>
								</c:if>
								 <c:if test="${passenger.passengerType == 4}">
                                Infant (on seat)
								 <form:hidden path="passengerDetails[${indexed.index}].passengerType" value="4"/>
								</c:if></span>
                                <select style="border-color:#e9e9e9;background:#e9e9e9;font-size:14px; padding:1px 5px;letter-spacing:1px;border-radius:4px;margin:0 0 0 10px;outline:none !important;">
                                    <option value="0">Select Title</option>
                                    <option value="1">Mr.</option>
                                    <option value="2">Mrs.</option>
                                    <option value="3">Miss.</option>
                                </select>
						</div>
                        <div class="tdform">
                        
                            <div class="tname">
                                	
									<form:input path="passengerDetails[${indexed.index}].firstName" id="passengerDetails${indexed.index}.firstName" placeholder="First Name" class="form-control textOnly inputfieldset"  />
									
									<form:input path="passengerDetails[${indexed.index}].middleName" id="passengerDetails${indexed.index}.middleName" placeholder="Middle Name" class="form-control textOnly"  />
								
                                	<form:input path="passengerDetails[${indexed.index}].lastName" id="passengerDetails${indexed.index}.lastName" placeholder="Last Name" class="form-control textOnly inputfieldset"  />
                                
                            </div>
                            
                            <div class="tgdob">
                                
								<form:select path="passengerDetails[${indexed.index}].Gender" class="form-control gender inputfieldset gendersel">
                        			<c:forEach items="${gender}" var="curCategory" varStatus="loop">
                          				<form:option value="${loop.index}">${curCategory}</form:option>
                        			</c:forEach>
                      			</form:select>
                      			
                                <div class="dobform">
                                    <div>Date of Birth</div>
                                    <div class="dob">
                                    
                                        <form:select path="passengerDetails[${indexed.index}].dobDay" id="paxdob${indexed.index}" class="form-control select inputfieldset paxbod"  items="${days}" />
                                        
                      					<form:select  path="passengerDetails[${indexed.index}].dateOfMonth" class="form-control select inputfieldset paxbod" id="paxdom${indexed.index}">
                        					<c:forEach items="${month}" var="curCategory" varStatus="loop">
                          						<option value="${loop.index}">${curCategory}</option>
                        					</c:forEach>
                      					</form:select>
                    					
                                       	<c:if test="${passenger.passengerType == 1}">
                      						<form:select path="passengerDetails[${indexed.index}].dateOfYear" id="paxdoy${indexed.index}" class="form-control select inputfieldset paxbod" items="${year}" />
					                    </c:if>
					                    <c:if test="${passenger.passengerType == 2}">
					                      <form:select path="passengerDetails[${indexed.index}].dateOfYear" id="paxdoy${indexed.index}" class="form-control select inputfieldset paxbod" items="${chyear}" />
					                    </c:if>
					                    <c:if test="${passenger.passengerType == 3}">
					                      <form:select path="passengerDetails[${indexed.index}].dateOfYear" id="paxdoy${indexed.index}" class="form-control select inputfieldset paxbod"  items="${infyear}" />
					                    </c:if>
					                    <c:if test="${passenger.passengerType == 4}">
					                      <form:select path="passengerDetails[${indexed.index}].dateOfYear" id="paxdoy${indexed.index}" class="form-control select inputfieldset paxbod" items="${infyear}" />
					                    </c:if>
					                    
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
					</c:forEach>
                    
                </div>
                <!-- start - ancillaries code  -->
                <input type="hidden" id="sessionId" value="${bookingRequest.searchID}">
		        <input type="hidden" id="totalPax" value="${bookingRequest.adults+bookingRequest.child+bookingRequest.infants+bookingRequest.infantsWs}" scope="request" />
                <input type="hidden" id="tripType" value="${searchRequest.tripType}" />
                <input type="hidden" id="grandTotal" value="${bookingRequest.flightResult.fare.grandTotal}" />
                <input type="hidden" id="travelGuardCost" value="0.00" />
                <input type="hidden" id="tgValue" value="0.00" />

                <form:hidden path="travelGuard" id="tgOption" value="No"/>
                <form:hidden path="priceDropAmount" id="priceDropAmount" value="0.00"/>
                <form:hidden path="priceDropTaken" id="priceDropTaken" value="No"/>
                <form:hidden path="travelAssistAmount" id="travelAssistAmount" value="0.00"/>
                <form:hidden path="travelAssistTaken" id="travelAssistTaken" value="No"/>
                <form:hidden path="upgradeAmount" id="upgradeAmount" value="0.00"/>
                <form:hidden path="upgradeTaken" id="upgradeTaken" value="No"/>
                <form:hidden path="upgradePlan" id="upgradePlan" value="Current"/>
                <form:hidden path="webcheckincost" value="0.00" />
		        <form:hidden path="webcheckin" value="No" />
                <!-- end - ancillaries code --> 
                

                <div class="billing-details">
                      <div class="trvlExpSec trvlAsistSec">
                        <div class="trvlProt">
                          <div>
                            <div class="cccdhead">
                              <img src="/resources/images/icons/travel-assist-white.png" alt="Protections">Travel Assist
                              <!-- <p><a href="javascript:;">Learn More</a></p> -->
                            </div>
                          </div>
                        </div>
                        <div class="proAddProd_Section">
                          <p class="travel-assist-description">Enhance your level of customer service that suit your needs! Don't let the stress of traveling take the fun out of your trip. Fly with enhanced peace of mind and upgrade your service level.</p>
                          <div class="proAddProd">
                            <div class="itemsHeadng">
                            
                                <ul class="trvlAssistUl">
                                    <li><strong>Services</strong></li>
                                        <li>
                                            <b>Rescheduling Help</b><br><p class="d-none d-lg-block d-xl-block">No Agency Fees for rescheduling or canceling your flight ticket*.</p>
                                            <img src="/resources/images/icons/info-icon.png" alt="info">
                                            <div class="detailCntnt_popup">
                                              <img src="/resources/images/icons/close.png" alt="close" class="detailCntnt_popup_close">
                                              <div><span><img src="/resources/images/icons/check-mark.png" alt="check">We've got you covered for things such as flight cancelation, rescheduling, or name changes of passenger.<br>You won't incur any additional agency fees at any point, even after 24 hours of booking.<br><br>(Note: Additional fare differences and airlines penalties may still apply.)</span></div>
                                            </div>
                                        </li>
                                    
                                        <li>
                                            <b>Trip Monitoring</b><br><p class="d-none d-lg-block d-xl-block">Real time assistance with unforeseen schedule changes.</p>
                                            <img src="/resources/images/icons/info-icon.png" alt="info">
                                            <div class="detailCntnt_popup">
                                                <img src="/resources/images/icons/close.png" alt="close" class="detailCntnt_popup_close">
    
                                                <div><span><img src="/resources/images/icons/check-mark.png" alt="check">In case of schedule change and cancellations by the airlines, give us a call at +1-800-984-7414 (toll free) and speak with one of our customer care representatives to get assisted with alternative options.</span>
                                                </div>
    
                                            </div>
                                        </li>
                                    
                                        <li>
                                            <b>24 hours Risk-Free Cancellation</b><br><p class="d-none d-lg-block d-xl-block">Stress-free Booking, cancel with-in 24 hours of booking purchased.</p>
                                            <img src="/resources/images/icons/info-icon.png" alt="info">
                                            <div class="detailCntnt_popup">
                                                <img src="/resources/images/icons/close.png" alt="close" class="detailCntnt_popup_close">
                                                 <div><span><img src="/resources/images/icons/check-mark.png" alt="check">After purchasing a flight, get up to 24 hours to cancel the flight for any reason and get a full refund to your original form of payment.</span>
                                                </div>
                                            </div>
                                        </li>
                                    
                                        <li>
                                            <b>VIP Customer Service</b><br><p class="d-none d-lg-block d-xl-block">Get priority assistance at all hours from our travel experts.</p>
                                            <img src="/resources/images/icons/info-icon.png" alt="info">
                                            <div class="detailCntnt_popup">
                                                <img src="/resources/images/icons/close.png" alt="close" class="detailCntnt_popup_close">
                                                <div><span><img src="/resources/images/icons/check-mark.png" alt="check">Access to dedicated toll-free number available 24/7. <br>No need to wait on hold! Reach to a travel specialist within a few minutes.</span>
                                                </div>
                                            </div>
                                        </li>
                                    
                                    <!-- <li><a class="travel-assist-tnc" href="javascript:;" data-toggle="modal" data-target="#travelAssistPopup">*terms and conditions</a></li> -->
                                    
                                </ul>
                              
                            </div>

                            <div class="itemss">
                                <div class="itemssHead">
                                    <img src="/resources/images/icons/basic-plan_0.png">
                                    <span>Basic</span>
                                    <label>
                                        <input type="radio" class="Basic" name="protectionPlan" onclick="javascript:addTravelAssist('Basic', 0);">
                                    </label>
                                </div>
                                <div class="itemssBody">
                                    <ul>
                                        <li>Fees Apply</li>
                                        <li>Fees Apply</li>
                                        <li>Fees Apply</li>
                                        <li>Regular</li>
                                    </ul>
                                    <div>
                                        <a style="cursor:pointer;" onclick="javascript:addTravelAssist('Basic', 0);">$0.00</a>
                                    </div>
                                </div>
                            </div>

                            <div class="itemss active">
                                <div class="sowOnActive">Most Popular</div>
                                <div class="itemssHead">
                                    <img src="/resources/images/icons/basic-plan_1.png">
                                    <span>Standard</span>
                                    <label>
                                        <input type="radio" class="Standard" name="protectionPlan" onclick="javascript:addTravelAssist('Standard', 29);">
                                      </label>
                                </div>
                                <div class="itemssBody">
                                    <ul>
                                        <li><img style="opacity:0.6;height:24px" src="/resources/images/icons/check.png" alt="Image"></li>
                                        <li>Fees Apply</li>
                                        <li><img style="opacity:0.6;height:24px" src="/resources/images/icons/check.png" alt="Image"></li>
                                        <li>Priority</li>  
                                    </ul>
                                    <div>
                                        <a style="cursor:pointer;" onclick="javascript:addTravelAssist('Standard', 29);">$29.00</a>
                                    </div>
                                </div>
                            </div>

                            <div class="itemss">
                                <div class="itemssHead">
                                    <img src="/resources/images/icons/basic-plan_2.png">
                                    <span>Plus</span>
                                    <label>
                                        <input type="radio" class="Plus" name="protectionPlan" onclick="javascript:addTravelAssist('Plus', 49);">
                                    </label>
                                </div>
                                <div class="itemssBody">
                                    <ul>
                                        <li><img style="opacity:0.6;height:24px" src="/resources/images/icons/check.png" alt="Image"></li>
                                        <li><img style="opacity:0.6;height:24px" src="/resources/images/icons/check.png" alt="Image"></li>
                                        <li><img style="opacity:0.6;height:24px" src="/resources/images/icons/check.png" alt="Image"></li>
                                        <li>Fastest</li>
                                    </ul>
                                    <div>
                                        <a style="cursor:pointer;" onclick="javascript:addTravelAssist('Plus', 49);">$49.00</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-12 mobTermsDiv">
                              <!-- <a href="javascript:;" data-toggle="modal" data-target="#travelAssistPopup">*terms and conditions</a> -->
                              <a class="travel-assist-tnc" href="javascript:;" data-toggle="modal" data-target="#travelAssistPopup">*terms and conditions</a>
                            </div>
                          </div>
                          <div class="travel-tnc">
                            <a class="travel-assist-tnc" href="javascript:;" data-toggle="modal" data-target="#travelAssistPopup">*terms and conditions</a>
                          </div>

                          <div class="proaddnonte">
                            <p>
                              <span>
                                <i class="fa fa-info-circle" aria-hidden="true"></i> Note : </span> All Fares displayed are quoted in local currency and inclusive of base fare, taxes and other services.
                            </p>
                          </div>
                        </div>
                      </div>
                    
                </div>


                <div class="billing-details "><!-- add class priceDrop-ancillaries here to hide -->
                        <div class="trvlProt priceDrop bgblue">
                            <div>
                              <div class="cccdhead"> <img src="/resources/images/icons/shield-white.png" alt="Protection"> Price Drop Protection
                              </div>
            
                                <div class="pricedropP">
                                  <p>Get the opportunity for money back with our Price Drop Protection.</p>
                                    <ul class="checkMark checkMark_">
                                        <li>We'll automatically check for price drops for 24 hours after you book.</li>
                                        <li>If price drop, we'll share those savings with you.</li>
                                    </ul>
                                    
                                    <div class="protection-price-display">
                                        <span>$14.99
                                          <span class="per-person-text">per person</span>
                                        </span>
                                        
            
                                        <span class="addRemButSec">
                                          <button type="button" id="addPdp" onclick="flightProduct('Add', '14.99');">
                                            <i class="fa fa-check" aria-hidden="true"></i> <span>Add Product</span>
                                          </button>
                                          <button type="button" id="removePdp" onclick="flightProduct('Remove','0.00');" style="display:none;">
                                            <i class="fa fa-trash-o" aria-hidden="true"></i><span>Remove Product</span>
                                          </button>
                                       </span>
            
                                    </div>
                                </div>
                            </div>
                        </div>
                        
            
                        <div class="proaddnonte">
                          <p><span><i class="fa fa-info-circle" aria-hidden="true"></i> Note : </span> You never know when the airline will make a promotion announcement and provide a better deal on your
                            flight. Get the opportunity for money back with our Price Drop Protection. <a href="javascript:;" data-toggle="modal" data-target="#priceDropProtectionPopup">Learn More</a></p>
                        </div>
              </div>


              <div class="billing-details"><!-- add class priceDrop-refundable here to hide -->
                    <div class="trvlProt refundable-booking-price bgblue">
                        <div>
                          <div class="cccdhead"> <img src="/resources/images/icons/web-checking-white.png" alt="Protection"> Web Check-in
                          </div>
            
                            <div class="pricedropP">
                              <p>Reasons you might need web checking</p>
                                <div class="web-checking-details">                    
                                  <ul class="checkMark checkMark_">
                                    <li>We'll complete the process of flight check-in on time.</li>
                                    <li>Prior to reaching the airport, you will obtain an assigned seat.</li>
                                    <li>Enter directly without visiting the kiosk/check-in counter</li>
                                    <li>Do not need to pay a fee for printing the boarding pass.</li>
                                </ul>
                                <div class="protection-price-display">
                                    <span class="price-display-text">$7.99
                                      <span>per person/each way</span>
                                    </span>
                                    <div class="proAddProd">
                                        <span class="addRemButSec">
                                          <button type="button" onclick="setWebcheck('Add','7.99')" id="addwebcheck">
                                            <i class="fa fa-check" aria-hidden="true"></i> <span>Add Product</span>
                                          </button>
                                          <button type="button" onclick="setWebcheck('Remove',0.0)" id="removewebcheck" style="display:none;">
                                            <i class="fa fa-trash-o" aria-hidden="true"></i><span>Remove Product</span>
                                          </button>
                                      </span>
                                   </div>
                                </div>
                              </div>
                            </div>
                            <div class="proaddnonte">
                              <p><span><i class="fa fa-info-circle" aria-hidden="true"></i> Note : </span> Enjoy the trip. Make unforgettable memories. On the registered email, you will get your boarding pass. Bring a printout of the boarding pass at the airport. For any further queries related to seat and baggage, Contact us at <a href="tel:+1-800-984-7414">+1-800-984-7414</a></p>
                            </div>
                        </div>
                    </div>
                    
                </div>
                
                <div class="price-details mobile-price-details payment-sectop" id="priceblock">
                    <div class="pdhead">
                        <img src="/resources/images/icons/Pcredit-card-white.png" alt="Price">&nbsp;&nbsp;Price Details
                    </div>
                    
                    <div class="person-price">
                        <div class="tpp">
                            <span><span>${bookingRequest.adults}</span> Traveler(s): <span>Adult</span></span>
                            <span>$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.adults * (bookingRequest.flightResult.fare.adultFare+bookingRequest.flightResult.fare.adultTax+bookingRequest.flightResult.fare.adultMarkup)}" /></span>
                        </div>
                        <div class="fcp">
                            <span>Flight Charges per <span>adult</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.adultFare}" /></span>
                        </div>
                        <div class="tfp">
                            <span>Taxes & Fees per <span>adult</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.adultTax+bookingRequest.flightResult.fare.adultMarkup}" /></span>
                        </div>
                    </div>
                    <hr>
					<c:if test="${bookingRequest.child > 0}">
                    <div class="person-price">
                        <div class="tpp">
                            <span><span>${bookingRequest.child}</span> Traveler(s): <span>Child</span></span>
                            <span>$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.child * (bookingRequest.flightResult.fare.childFare+bookingRequest.flightResult.fare.childTax+bookingRequest.flightResult.fare.childMarkup)}" /></span>
                        </div>
                        <div class="fcp">
                            <span>Flight Charges per <span>Child</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.childFare}" /></span>
                        </div>
                        <div class="tfp">
                            <span>Taxes & Fees per <span>Child</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.childTax+bookingRequest.flightResult.fare.childMarkup}" /></span>
                        </div>
                    </div>
					<hr>
					</c:if>
					
					<c:if test="${bookingRequest.infants > 0}">
					<div class="person-price">
                        <div class="tpp">
                            <span><span>${bookingRequest.infants}</span> Traveler(s): <span>Infant(lap)</span></span>
                            <span>$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.infants * (bookingRequest.flightResult.fare.infantFare+bookingRequest.flightResult.fare.infantTax+bookingRequest.flightResult.fare.infantMarkup)}" /></span>
                        </div>
                        <div class="fcp">
                            <span>Flight Charges per <span>Infant(lap)</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.infantFare}" /></span>
                        </div>
                        <div class="tfp">
                            <span>Taxes & Fees per <span>Infant(lap)</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.infantTax+bookingRequest.flightResult.fare.infantMarkup}" /></span>
                        </div>
                    </div>
					<hr>
					</c:if>
					<c:if test="${bookingRequest.infantsWs > 0}">
					<div class="person-price">
                        <div class="tpp">
                            <span><span>${bookingRequest.infantsWs}</span> Traveler(s): <span>Infant(ws)</span></span>
                            <span>$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.infantsWs * (bookingRequest.flightResult.fare.infantWsFare+bookingRequest.flightResult.fare.infantWsTax+bookingRequest.flightResult.fare.infantWsMarkup)}" /></span>
                        </div>
                        <div class="fcp">
                            <span>Flight Charges per <span>Infant(ws)</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.infantWsFare}" /></span>
                        </div>
                        <div class="tfp">
                            <span>Taxes & Fees per <span>Infant(ws)</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.infantWsTax+bookingRequest.flightResult.fare.infantWsMarkup}" /></span>
                        </div>
                    </div>
					<hr>
					</c:if>
                    <div class="person-price">
						
						<div class="tpp" id="tgfareladder" style="display:none; position:relative;text-font:15px;">
                            <span> Travel Guard Insurance </span>
                            <span id="tg_price"></span>
                        </div>
                        
                        <div class="tpp" id="fareladder_pdp" style="display:none; position:relative;text-font:15px;">
                            <span> Price Drop Protection </span>
                            <span id="pdp_price"></span>
                        </div>
                        
                        <div class="tpp" id="fareladder_ta" style="display:none; position:relative;text-font:15px;">
                            <span> Travel Assist (<span id="planName"></span>)</span>
                            <span id="ta_price"></span>
                        </div>
                        
                        <div class="tpp" id="fareladder_up" style="display:none; position:relative;text-font:15px;">
                            <span id="upgradePlanName"></span>
                            <span id="up_price"></span>
                        </div>
						
						<div class="tpp" id="fareladder_web" style="display:none; position:relative;text-font:15px;">
                            <span>Web Check-in</span>
                            <span id="web_price"></span>
                        </div>
                        
                    </div>

                    <div class="total-price">
                        <span>Total Price:</span>
                        <span id="total_price">$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.grandTotal}" /></span>
                    </div>
                    <div class="proaddnonte">
                        <p>
                          <span><i class="fa fa-info-circle" aria-hidden="true"></i> Note : </span> All Fares displayed are quoted in USD and inclusive of base fare, taxes and all fees. Additional baggage fees may apply as per the airline policies.
                        </p>
                    </div>
                </div>
                <div class="payment-details payment-sectop">
                    <div class="paydhead"><img src="/resources/images/icons/Pcredit-card-white.png" alt="Payment mode">&nbsp;&nbsp;Payment Info</div>
                    
                    <div class="paydform">
					<div class="card-varients">
                            <div class="card-images">
                                <div><img src="/resources/images/card-master.png" alt="card-master" width="10" height="6" loading="lazy" decoding="async"></div>
                                <div><img src="/resources/images/card-visa.png" alt="card-visa" width="10" height="6" loading="lazy" decoding="async"></div>
                                <div><img src="/resources/images/card-diners-club.png" alt="card-diners-club" width="10" height="6" loading="lazy" decoding="async"></div>
                                <div><img src="/resources/images/card-discover.png" alt="card-discover" width="10" height="6" loading="lazy" decoding="async"></div>
                                <div><img src="/resources/images/card-american-express.png" alt="card-american-express" width="10" height="6" loading="lazy" decoding="async"></div>
                            </div>
                        </div>
<div class="bdform PpayInfoForm">
  
    <div class="payment-card-expirysec">
        <div class="card-numberinput">
            <label>Card Number</label>
            <form:hidden path="paymentDetails.cardCode" id="paymentDetails-cardCode" value="Visa" /> 
            <div class="lableUpOnFocus"> 
            <form:input id="paymentDetails_MaskCardNumber" path="paymentDetails.maskCardNumber" class="rkap form-control text-box numbersOnly numbersastseveOnly card-type" placeholder="Credit/Debit Card No." style="background-image:none;" maxlength="16" />
            </div>
        </div>

        <div class="expirydate">
            <label>Expiration Date</label>
            <div class="expirydate-inputs">
            <div class="lableUpOnFocus"> 
            <form:select path="paymentDetails.expiryMonth" id="paymentDetails_ExpiryMonth"   class="rkap2 form-control">
                <c:forEach items="${cardMonth}" var="curExp" varStatus="loop">
                <option value="${loop.index}">${curExp}</option>
                </c:forEach>
            </form:select>
            </div>

            <div class="lableUpOnFocus"> 
                <form:select id="paymentDetails_ExpiryYear" path="paymentDetails.expiryYear" items="${cardyear}" class="rkap2 form-control" />
            </div>

            <div class="lableUpOnFocus">
            <form:password id="paymentDetails_CvvNo" path="paymentDetails.cvvNo" class="form-control rkap3 numbersOnly" placeholder="Card Verification No." maxlength="4" />
            </div>
            <div class="lableUpOnFocus aboutcvv-info-div">
                <span class="aboutcvv-info"><img src="/resources/images/icons/info.png" alt="info">3-4 Digit Number on your card</span>
            </div>
        </div>  
        </div>
    </div>

  
    <div class="cardholderinput">
        <label>Holder's Name</label>
        <form:hidden id="paymentDetails_CardNumber" path="paymentDetails.cardNumber" name="Payments.CardNumber" />
        <div class="lableUpOnFocus">
          <form:input id="paymentDetails_cardHolderName" path="paymentDetails.cardHolderName" class="rkap form-control textOnly" placeholder="Card Holder's Name"  />
        </div>
    </div>
	
  
</div>
                </div></div>
                <div class="billing-details">
                    <div class="bdhead"><img src="/resources/images/icons/Pinvoice-white.png" alt="Invoice">&nbsp;&nbsp;Billing Information  <!-- <span class="headsubinfo"> (As per bank records Or credit card company)</span> -->
                    </div>
                    <div class="bdform" id="addressAutofill">
                        <form:input path="paymentDetails.address1" id="paymentDetails_address1" class="form-control addressOnly" placeholder="Address" />
                       <form:input path="paymentDetails.address2" id="paymentDetails_address2" class="form-control addressOnly" placeholder="Near by Address" />
                       <form:input path="paymentDetails.city" id="paymentDetails_city" class="form-control text-box textOnly" placeholder="City/ Town" />
                       <form:select path="paymentDetails.country" id="paymentDetails_Country" class="form-control" ng-options="opt.Name for opt in countryList track by opt.ID" ng-model="selectedCountry" >
                   
                  </form:select>
                         <div id="stateInp" ng-hide="IsHidden">
                    <form:input path="paymentDetails.state" id="paymentDetails_state1" class="form-control" placeholder="State/ Province"/>
                  </div>
                  <div id="stateSel" ng-hide="IsShow">
                    <form:select path="paymentDetails.state" id="paymentDetails_state2" class="rkap4 form-control" ng-options="opt.Name for opt in usState track by opt.ID" ng-model="selectedItem"> </form:select>
                  </div>
                        <form:input path="paymentDetails.postalCode" id="paymentDetails_postalCode" class="form-control text-box card_type col-xs-12" placeholder="Postal/Zip Code"/>
                    </div>
                </div>
                
                <div class="ccc-details">
	                    <div class="cccdhead"><img src="/resources/images/icons/Pcredit-card-white.png" alt="Payment mode">&nbsp;&nbsp;Contact Information</div>
	                    <div class="cccdform">
	                        
	                        <input id="internationalBillNum" minlength="4"  maxlength="15" class="form-control" placeholder="" required="required" />
	                        <form:input path="phoneNo" id="phoneNo" hidden="true" required="required"/>
	                        <%--hidden for country code input
	                         <form:input path="phoneNo" id="phoneNo" minlength="10"  maxlength="15" class="form-control numbersOnly" placeholder="Billing Phone"  /> --%>
	                       
	                        <!-- <input id="internationalMobileNum" minlength="4" maxlength="15" class="focus_input form-control" placeholder="" required="required"/> -->
	                        <form:input path="mobileNo" id="mobileNo" hidden="true" required="required"/>
	                        <%--hidden for country code input
	                         <form:input path="mobileNo" id="mobileNo" minlength="10" maxlength="15" class="form-control numbersOnly" placeholder="Mobile Phone"  /> --%>
	                        
	                        <form:input path="emailID" id="emailID" class="form-control" placeholder="Email"/>
	                        <%-- <form:input path="emailID1" id="emailID1" class="form-control" placeholder="Retype Email"/> --%>
	                    </div>
	                     <div class="proaddnonte">
	                            <p><span><i class="fa fa-info-circle" aria-hidden="true"></i> Note: </span> 
	                            Provide your valid email and phone to receive e-tickets and important messages. 
	                            This will also be used as billing email id and phone number.
	                            </p>
	                      </div>
                </div>
                
                <div class="pr-details">
                    <div class="prdhead"><img src="/resources/images/icons/Pinsurance-white.png" alt="Policies">&nbsp;&nbsp;Policies & Review</div>
                    
                    <div class="prdcontent">
                        <div class="i-button">
                            Please confirm that the <b>date(s)</b> and <b>time(s)</b> of flights and <b>name(s)</b> of travelers are accurate.
                            <br>
                            <b>Each traveler's name and date of birth must be exactly as shown on the passport or other government-issued photo ID to be used on this trip.</b>
                        </div>
                       
                        <div class="terms-policies">
                            Tickets are non-transferable and name changes are not permitted. Total price shown includes all applicable <a href="javascript:void(window.open('/taxes-fees', '_blank', 'width=600,height=750,scrollbars=yes'));">taxes & fees</a> and our service fees. 
                            Some airlines may charge additional baggage fees or other fees. Fares are not guaranteed until ticketed.
                                Tickets and our fees are non-refundable (see Fare Rules). Some taxes and government agency fees may be non-refundable. 
                                Date and routing changes will be subject to airline penalties and our fees. 
                        </div>
                        <div class="submit-details">
                            <label>
                                <input type="checkbox" name="agree" id="iagree">
                                <div class="cb">
                                    <div class="checkmark"></div>
                                    <p style="font-size: 14px;"> By clicking Book Now, I agree that I have read and accepted Lowtickets.com <a class="tcshow">Terms and Conditions</a> and <a class="ppshow">Privacy Policy</a></p>
                                </div>
                            </label>
                            <button type="submit" onClick="validateMobileInputs();confirmFlight();" id="candbb" disabled>Confirm &amp; Book</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="paymentright-block">
                <div class="sa-item">
                    <!-- You may book in the next <b>20 minutes</b> as this page will then refresh. -->
                     <!-- TrustBox widget - Micro Review Count -->
                     <div class="trustpilot-widget" data-locale="en-US" data-template-id="5419b6a8b0d04a076446a9ad" data-businessunit-id="641d84e132ef9666402d41b4" data-style-height="24px" data-style-width="100%" data-theme="light" data-min-review-count="10" data-style-alignment="center">
                        <a href="https://www.trustpilot.com/review/lowtickets.com" target="_blank" rel="noopener">Trustpilot</a>
                    </div>
                    <!-- End TrustBox widget -->
                </div>


                <div class="price-details desktop-price-details payment-sectop" id="priceblock">
                    <div class="pdhead">
                        <img src="/resources/images/icons/Pcredit-card.png" alt="Price">&nbsp;&nbsp;Price Details
                    </div>
                    
                    <div class="person-price">
                        <div class="tpp">
                            <span><span>${bookingRequest.adults}</span> Traveler(s): <span>Adult</span></span>
                            <span>$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.adults * (bookingRequest.flightResult.fare.adultFare+bookingRequest.flightResult.fare.adultTax+bookingRequest.flightResult.fare.adultMarkup)}" /></span>
                        </div>
                        <div class="fcp">
                            <span>Flight Charges per <span>adult</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.adultFare}" /></span>
                        </div>
                        <div class="tfp">
                            <span>Taxes & Fees per <span>adult</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.adultTax+bookingRequest.flightResult.fare.adultMarkup}" /></span>
                        </div>
                    </div>
                    <hr>
					<c:if test="${bookingRequest.child > 0}">
                    <div class="person-price">
                        <div class="tpp">
                            <span><span>${bookingRequest.child}</span> Traveler(s): <span>Child</span></span>
                            <span>$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.child * (bookingRequest.flightResult.fare.childFare+bookingRequest.flightResult.fare.childTax+bookingRequest.flightResult.fare.childMarkup)}" /></span>
                        </div>
                        <div class="fcp">
                            <span>Flight Charges per <span>Child</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.childFare}" /></span>
                        </div>
                        <div class="tfp">
                            <span>Taxes & Fees per <span>Child</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.childTax+bookingRequest.flightResult.fare.childMarkup}" /></span>
                        </div>
                    </div>
					<hr>
					</c:if>
					
					<c:if test="${bookingRequest.infants > 0}">
					<div class="person-price">
                        <div class="tpp">
                            <span><span>${bookingRequest.infants}</span> Traveler(s): <span>Infant(lap)</span></span>
                            <span>$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.infants * (bookingRequest.flightResult.fare.infantFare+bookingRequest.flightResult.fare.infantTax+bookingRequest.flightResult.fare.infantMarkup)}" /></span>
                        </div>
                        <div class="fcp">
                            <span>Flight Charges per <span>Infant(lap)</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.infantFare}" /></span>
                        </div>
                        <div class="tfp">
                            <span>Taxes & Fees per <span>Infant(lap)</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.infantTax+bookingRequest.flightResult.fare.infantMarkup}" /></span>
                        </div>
                    </div>
					<hr>
					</c:if>
					<c:if test="${bookingRequest.infantsWs > 0}">
					<div class="person-price">
                        <div class="tpp">
                            <span><span>${bookingRequest.infantsWs}</span> Traveler(s): <span>Infant(ws)</span></span>
                            <span>$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.infantsWs * (bookingRequest.flightResult.fare.infantWsFare+bookingRequest.flightResult.fare.infantWsTax+bookingRequest.flightResult.fare.infantWsMarkup)}" /></span>
                        </div>
                        <div class="fcp">
                            <span>Flight Charges per <span>Infant(ws)</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.infantWsFare}" /></span>
                        </div>
                        <div class="tfp">
                            <span>Taxes & Fees per <span>Infant(ws)</span></span>
                            <span>$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.infantWsTax+bookingRequest.flightResult.fare.infantWsMarkup}" /></span>
                        </div>
                    </div>
					<hr>
					</c:if>

                    <div class="person-price">
						
						<div class="tpp" id="tgfareladder" style="display:none; position:relative;text-font:15px;">
                            <span> Travel Guard Insurance </span>
                            <span id="tg_price"></span>
                        </div>
                        
                        <div class="tpp" id="fareladder_pdp" style="display:none; position:relative;text-font:15px;">
                            <span> Price Drop Protection </span>
                            <span id="pdp_price"></span>
                        </div>
                        
                        <div class="tpp" id="fareladder_ta" style="display:none; position:relative;text-font:15px;">
                            <span> Travel Assist (<span id="planName"></span>)</span>
                            <span id="ta_price"></span>
                        </div>
                        
                        <div class="tpp" id="fareladder_up" style="display:none; position:relative;text-font:15px;">
                            <span id="upgradePlanName"></span>
                            <span id="up_price"></span>
                        </div>
						
						<div class="tpp" id="fareladder_web" style="display:none; position:relative;text-font:15px;">
                            <span>Web Check-in</span>
                            <span id="web_price"></span>
                        </div>
                        
                    </div>

                    <div class="total-price">
                        <span>Total Price:</span>
                        <span id="total_price">$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.grandTotal}" /></span>
                    </div>
                    <div class="proaddnonte">
                        <p>
                          <span><i class="fa fa-info-circle" aria-hidden="true"></i> Note : </span> All Fares displayed are quoted in USD and inclusive of base fare, taxes and all fees. Additional baggage fees may apply as per the airline policies.
                        </p>
                    </div>
                </div>
                


                <div class="sa-item">
                    <div class="sa-head">Secure SSL Booking</div>
                    <hr>
                    <div class="sa-row"><img src="/resources/images/mcafee.png"><span>Lowtickets has passed McAfee SECURE's daily security scan</span></div>
                    <div class="sa-row"><img src="/resources/images/norton.png"><span>Your booking is SSL secured & encrypted by DigiCert</span></div>
                </div>
                <div class="sa-item">
                    <div class="sa-head">Book with <img src="/resources/images/logo.png"></div>
                    <hr>
                    <div class="sa-row"><i class="fa fa-check"></i><span> Travel Industry Award Winner</span></div>
                    <div class="sa-row"><i class="fa fa-check"></i><span> IATAN, ARC, ASTA Member</span></div>
                    <div class="sa-row"><i class="fa fa-check"></i><span> Travel Weekly Power List</span></div>
                </div>
            </div>
        </div>
        </form:form>
        <div class="terms-screen-overlay">
            <div class="terms-and-conditions">
                <div class="t-and-c-close"><h5>TERMS AND CONDITIONS</h5><i class="fa fa-close"></i></div>
                <div class="t-and-c-of">
                    <p>
                        These Terms and Conditions, together with any other written information we brought to your attention during the process of confirming your booking, 
                        apply to your booking Trading as Lowtickets. Please read the Terms and Conditions carefully prior to utilising Lowtickets website and making any bookings. 
                        You consent to the Terms and Conditions when you use the Site, without qualification. 
                        If you do not agree with any portion of the Terms and Conditions, you cannot utilise the website in any method or make a booking.
                    </p>
                    <p>
                        All communications concerning customer service or your booking email to: <a href="mailto:bookings@lowtickets.com">bookings@lowtickets.com</a>
                    </p>
                    <h6>CONTRACT</h6>
                    <p>
                        When making your reservation we, as a representative, would organise it for you to come into an agreement with the principal(s) or other supplier(s) such as tour operator / airline / cruise firm / lodging firm etc. as mentioned on your receipt(s). We could reserve you a holiday deal, in which instance you would hold one agreement with the principal,
                        or we could reserve the services that make up your trip with various principals or suppliers, in which instance you would have different agreements with every one of them.
                    </p>
                    <p>
                        As a representative, we take no accountability for the actions or cuts of the principal(s) or supplier(s) or for the services offered by them. 
                        The principals(s) or suppliers(s) Terms & Conditions would relate to your reservation and we suggest that you read them cautiously as they do hold significant details about your reservations. Kindly request for copies of these if you do not possess them.
                    </p>
                    <h6>BOOKING</h6>
                    <p>
                        Passengers must make sure that all the names and timings are accurate as per their passports and that the travel itinerary is correct. Changes might not be allowed after the tickets are provided and alterations may incur additional charges.
                    </p>
                    <p>
                        During a booking, all details will be read back to you and the respective details will be confirmed with the principal(s) or the supplier(s). On receipt of all travel documents please check whether the details such as names, dates and timings are accurate and advise us immediately if any revisions to be done. 
                        Also, please be noted that all the tickets supplied are non-refundable, non-changeable and non-transferable unless otherwise stated.
                    </p>
                    <p>The booking information that you provide to us will be passed on only to the relevant suppliers of your travel arrangements or other particular persons who are a part of the provision of your travel 
                        arrangements. Further, if required by any authorities, or as required by law, the information may be provided to public authorities such as customs or immigration. 
                        This applies to any sensitive information that you provide such as details of any disabilities, or dietary and religious requirements. Certain information may also be passed on to security 
                        or credit checking companies. If you are travelling to the United States, the US Customs and Border Protection will receive this information for the purposes of preventing and combating 
                        terrorism and other transnational serious crimes. If you travel outside the European Economic Area, controls on data protection may not be as strong as the legal requirements in this country. 
                        If we cannot pass this information to the relevant suppliers, whether in the EEA or not, we will be unable to provide your booking. In making this booking, you consent to this information 
                        being passed on to the relevant persons. Full details of our data protection policy are available upon request.
                    </p>
                    <p>Airfares are promised upon ticketing only. If there would be any problem with the payment, we would inform you as soon as possible via email and/or phone. Otherwise, we would send you the ticket within 48 hours of your booking with us.</p>
                    <p>The free baggage allowance offered to the passenger differs based on the route, class/cabin seating and as per the norms of the Individual airline. Airlines might charge an extra fee for checked-in baggage, additional baggage or other voluntary services. Please contact the airlines straight for the most current updates concerning the baggage payment, weight and sizes of the bags.
                    </p>
                    <p>Passengers need to be at the airport 3 hours prior to the departure as tickets could not be refunded or changed because of a no show at the airport.</p>
                    <p>Passengers are held accountable for all their travel documentation plus visas. Visas might be needed for the whole journey both for the destination and/or transit. Visas need to be acquired prior to the ticket been issued.</p>
                    <h6>PAYMENT</h6>
                    <p>Customers are required to pay an instalment or the whole amount at the time of booking. If only a part payment is made, the balance has to be paid on or before the stipulated due date. Failing to do so may result in cancellation of the booking by the principal(s) or supplier(s). This may involve cancellation fees set out in their Terms and Conditions. Unless otherwise mentioned in the booking
                        conditions or advised all the amount paid for the bookings will be held on behalf of the principal(s) or supplier(s) concerned.
                    </p>
                </div>
            </div>
        </div>
        <div class="policy-screen-overlay">
            <div class="privacy-and-policy">
                <div class="p-and-p-close"><h5>PRIVACY AND POLICY</h5><i class="fa fa-close"></i></div>
                <div class="p-and-p-of">
                    <!-- <p>
                        This Privacy Notice sets out how Lowtickets, 
                        registered at 4208, 198th st, SW, suite 203 Lynnwood, wa, 98036 and its associated trading names, protects the privacy of your personal information.
                    </p> -->
                    <p>
                        We recognise and acknowledge the importance of your personal data and are committed to respecting your privacy and protecting your personal information.
                    </p>
                    <b>
                        1. What information do we collect and why?
                    </b>
                    <p>
                        We need to collect, use and disclose personal information to perform our duties as a travel agent, namely, making and managing travel bookings on behalf of our customers. During the course of our relationship we may collect the following:
                    </p>
                    <p>
                        a. <b>Personal and contact details</b>, such as title, full name, contact details (address, telephone and email address)
                    </p>
                    <p>
                        b. <b>Passport number</b>, date of birth and nationality - if required by the respective airline
                    </p>
                    <p>c. <b>Payment information:</b> card number, security number, expiration date and cardholder name</p>
                    <p>d. <b>Frequent flyer numbers</b>, car rental programme and hotel room preferences (if applicable)</p>
                    <p>e. <b>Dietary requirements and health issues</b> (if any) relevant to your travel arrangements or required by the relevant travel service provider(s) (e.g. accommodation or tour providers).</p>
                    <p>f. <b>Information provided</b> by filling forms on our website e.g. email address, where you heard about us and your travel preferences. This information will be used to keep you up to date with all our latest offers and products</p>
                    <p>g. <b>Call recordings</b> - calls may be recorded for the purposes of quality control and staff training</p>
                    <p>h. <b>Social media</b> - by interacting with the social media features on our website (Facebook, Twitter or Instagram) you will be bound by the privacy policies of the respective social media companies</p>
                    <p>i. <b>IP address and cookies</b> - When you access our website our servers may record data regarding your device and the network you are using to connect with us, including your IP address</p>
                </div>
            </div>
        </div>
        
        <jsp:include page="footer2.jsp" />
        <div class="youpay">
            <div class="ypr">
                <span>You Pay</span>
                <a href="#priceblock">+ View Detail</a>
                <span id="total_price_mobile">$<fmt:formatNumber  type="number" minFractionDigits="2" maxFractionDigits="2" value="${bookingRequest.flightResult.fare.grandTotal}" /></span>
            </div>
        </div>


        <!-- The Modal  Start-->
        <div class="modal fade travelAssistPopup" id="travelAssistPopup">
            <div class="modal-dialog modal-xl">
            <div class="modal-content">
            
                <!-- Modal Header -->
                <div class="modal-header">
                <img src="/resources/images/logo.png" class="img-responsive logoT" alt="Logo"  width="150"/>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- TravelAssistPopup Modal body -->
                <div class="modal-body">
                    <section class="travelAssistPopup-topsec">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-7 col-md-12">
                                    <h4>Travel Assist</h4>
                                    <p>Travel Assist is a revolutionary new product that provides travelers with the assistance they need to make their trips go as smoothly as possible. This includes everything from booking flights and hotels, to providing personalized recommendations for activities and attractions. With Travel Assist, users can easily plan and book their entire trip in minutes, without having to worry about the hassle of researching, planning and organizing each step of their journey. It can be used by WhatsApp, Voice calling, Massage text, Email, App or the website.</p>
                                </div>
                                <div class="d-none d-lg-block my-auto col-lg-5"><img src="/resources/images/payment-img/auxiliary-hero.svg" alt="Image" class="img-responsive"></div>
                            </div>
                        </div>
                    </section>

                    <section class="travelAssistPopup-bodypsec">
                        <div class="container">
                                <div class="assist-beneficial-header">
                                    <h5>How travel assist is beneficial for the passengers?</h5>
                                    <p>Travel assist is a great way to make any journey easier and more enjoyable. It can help you plan, book, and manage your trip from start to finish.</p>
                                </div>

                                <div class="assist-beneficial-body">
                                        <div class="Image-brt"><img src="/resources/images/payment-img/Image-brt.svg" alt="Image" class="img-responsive"></div>

                                        <ul>
                                            <li>Also with the help of travel assist, you can save time and money by booking the best deals for flights, hotels, car rentals, activities and more. </li>
                                            <li>You can also get personalized recommendations on where to go and what to do during your trip. Travel assist also provides assistance with visa applications and other paperwork so that you don't have to worry about it yourself.</li>
                                            <li>It can be quite daunting to plan a trip as there are so many factors to consider like accommodation, food, transportation and sightseeing. This is where travel assist comes in.</li>
                                            <li>Travel assist is an online platform that helps travelers plan their trips with ease. It offers personalized recommendations based on your preferences and budget.</li>
                                            <li>It also provides detailed information about the places you are visiting so that you can make the most out of your trip.</li>
                                        </ul>    
                                        <p>With travel assist, you don't have to worry about missing out on any attractions or activities as it will provide all the necessary information in one place.</p>
                                </div>
                        </div>
                    </section>
                </div>
                

                <!-- Modal footer -->
                <div class="modal-copyrightsec">
                    <p>&copy; Copyright by Lowtickets 2023</p>
                </div>
                
            </div>
            </div>
        </div>

         <!-- The Modal End -->



         <!-- The Modal  Start-->
        <div class="modal fade travelAssistPopup price-drop-model" id="priceDropProtectionPopup">
            <div class="modal-dialog modal-xl">
            <div class="modal-content">
            
                <!-- Modal Header -->
                <div class="modal-header">
                <img src="/resources/images/logo.png" class="img-responsive logoT" alt="Logo"  width="150"/>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- TravelAssistPopup Modal body -->
                <div class="modal-body">
                    <section class="travelAssistPopup-topsec">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-7 col-md-12 my-auto">
                                    <h4>Price Drop Protection</h4>
                                    <p>Finding a ticket for an impending flight is frequently a guessing game. You never know when the airline will make a promotion announcement and provide a better deal on your flight. Price Drop Protection was created specifically to cover these scenarios.</p>
                                </div>
                                <div class="d-none d-lg-block my-auto col-lg-5"><img src="/resources/images/payment-img/auxiliary-hero.svg" alt="Image" class="img-responsive"></div>
                            </div>
                        </div>
                    </section>

                    <section class="travelAssistPopup-bodypsec">
                        <div class="container">
                                <div class="assist-beneficial-header">
                                    <h5>Why is it worth adding to my booking?</h5>
                                </div>

                                <div class="assist-beneficial-body">
                                     <p>You can purchase Price Drop Protection as an add-on service to your ticket, giving you the chance to save money in the event that the cost of your specific flight decreased.</p>
                                     <p>Did you get the best deal on your ticket? What if prices on your journey are lower? In the event that you have even a slight qualm regarding the purchased airfare, this choice may prove to be quite helpful for you.</p>
                                     <p>Additionally, it spares you from worrying about any changes in the price of the purchased airfare within 24 hours of the booking's completion because we promise to notify you automatically of any changes in price.</p>


                                    <div class="benefit-section mt-5">
                                        <div class="row">
                                            <div class="col-lg-5">
                                                <div class="benefit-img">
                                                    <img src="/resources/images/payment-img/bi.svg" alt="Image" class="img-responsive">
                                                </div>
                                            </div>

                                            <div class="col-lg-7  my-auto">
                                                <p class="benefit-section-heading">How you might benefit from It?</p>
                                                <p>50% of the money saved is the Price Drop Protection portion.</p>
                                                <p>This share will be converted right away into a flight coupon that can be applied to your upcoming flight reservations with us</p>
                                            </div>
                                            
                                        </div>
                                    </div>

                                    <div class="wayitwork-section mt-5">
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <div class="wayitwork-section-col">
                                                    <img src="/resources/images/payment-img/st-1.svg" alt="Image" class="img-responsive">
                                                    <p class="wayitwork-headings">WE SEARCH</p>
                                                    <p>Within 24 hours of booking, we conduct a search for the same flight numbers and departure dates to check for price changes for your precise route.</p>
                                                </div>
                                            </div>

                                            <div class="col-lg-4">
                                                <div class="wayitwork-section-col">
                                                    <img src="/resources/images/payment-img/st-2.svg" alt="Image" class="img-responsive">
                                                    <p class="wayitwork-headings">PRICE DROPS</p>
                                                    <p>If a lower price is discovered, we will rebook your flight and provide a new ticket with the same itinerary but a different booking number.</p>
                                                </div>
                                            </div>

                                            <div class="col-lg-4">
                                                <div class="wayitwork-section-col">
                                                    <img src="/resources/images/payment-img/st-3.svg" alt="Image" class="img-responsive">
                                                    <p class="wayitwork-headings">YOU SAVE</p>
                                                    <p>You'll receive a flight coupon for use on your upcoming reservation with us as a way of receiving the savings.</p>
                                                </div>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="benefit-section shouldknow-section mt-5">
                                        <div class="row">
                                            <div class="col-lg-5">
                                                <div class="benefit-img">
                                                    <img src="/resources/images/payment-img/asc.svg" alt="Image" class="img-responsive">
                                                </div>
                                            </div>

                                            <div class="col-lg-7  my-auto">
                                                <p class="benefit-section-heading">What else you should know?</p>
                                                <p>The Price Drop Protection is a non-refundable option that could not be offered by all airlines or itineraries, and it doesn't ensure that you'll save any money because everything is based on the availability of lower prices.</p>
                                                <p>You should be informed that the airfare will remain as first booked if we are unable to detect any price changes, as there are instances where no price cuts occur within 24 hours of the booking being made.</p>
                                            </div>
                                            
                                        </div>
                                    </div>



                                </div>
                        </div>
                    </section>
                </div>
                

                <!-- Modal footer -->
                <div class="modal-copyrightsec">
                    <p>&copy; Copyright by Lowtickets 2023</p>
                </div>
                
            </div>
            </div>
        </div>

         <!-- The Modal End -->


        

    </body>
   <script>
       $(".t-and-c-close i").click(function(){
           $(".terms-screen-overlay").hide();
       });
       $(".tcshow").click(function(){
           $(".terms-screen-overlay").css("display","flex");
       });
       $(".p-and-p-close i").click(function(){
           $(".policy-screen-overlay").hide();
       });
       $(".ppshow").click(function(){
           $(".policy-screen-overlay").css("display","flex");
       });
       $('#iagree').click(function(){
    	if($(this).is(':checked')){
           $('#candbb').attr("disabled", false);
           } 
        else{
        $('#candbb').attr("disabled", true);
           }
	});
   </script>
	<script>
		function timeConvert(n) {
			var num = n;
			var hours = (num / 60);
			var rhours = Math.floor(hours);
			var minutes = (hours - rhours) * 60;
			var rminutes = Math.round(minutes);
			return rhours + " h " + rminutes + " m";
		}
		
		function getCabin(id){
				var cabin = "Economy";
				if(id == 1){
					cabin = "Economy";
				}
				else if(id == 2){
					cabin = "Premium Economy";
				}
				else if(id == 3){
					cabin = "Business";
				}
				else if(id == 4){
					cabin = "First";
				}
				return cabin;
		}
		</script>
		
		<script type="text/javascript">
		  $(document).ready(function(){
		      if ($(window).width() < 991) {
		           $(".desktop-price-details").html("").hide();
		      }
		     else {
		           $(".mobile-price-details").html("").hide();
		     }
		});
		</script>
<!-- code for address autocomplete google maps API -->
<script src="/resources/scripts/addressAutocomplete.js"></script>
<link rel="stylesheet" href="/resources/css/address_autocomplete.css" />
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDHGBk3XpEgqytoawWAXYqIROEmEU4bEcc&callback=Function.prototype&libraries=places" defer></script>
<!--  map key: AIzaSyDHGBk3XpEgqytoawWAXYqIROEmEU4bEcc -->
<script type="text/javascript">
	
	      document.getElementById('paymentDetails_address1').addEventListener('change', function()  {
	            initAutocomplete();
	      });
	     document.addEventListener('DOMContentLoaded', function () {
	          initAutocomplete();
	      });
</script>
<script type="text/javascript">

	   //address autocomplete
		document.getElementById('addressAutofill').addEventListener('change', function() {
			const countryInput = document.getElementById('paymentDetails_Country');
			if (countryInput.value == 'IN' || countryInput.value == 'AU' || countryInput.value == 'US' || countryInput.value == 'CA') {
	          if ($("#stateSel").is(":hidden") && $("#stateInp").is(":hidden")) {
					$("#stateSel").css("display", "block");
					}
	              $("#paymentDetails_state1").val(null);
			} else {
				$("#stateInp").css("display", "block");
				$("#paymentDetails_state2").val("0");
			}
       });
	    
</script>
	<!-- start - email and mobile  -->
<!-- link and scripts for international telephone input -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.1.60/inputmask/jquery.inputmask.js"></script>
<style>
	.cccdform .iti {display: block; font-size: 14px; width: 48%; margin: 5px 5px;}
	.cccdform .iti input {width: 100%;}
	@media screen and (max-width:768px){
		.cccdform .iti{width: 100%;}
	}
</style>

<script type="text/javascript">
	
	//country code addition in mobile
	$(function () {
		/*
		 * International Telephone Input v17.0.8
		 * https://github.com/jackocnr/intl-tel-input.git
		 * Licensed under the MIT license
		 */
		 
		//For phoneNo path - Billing Phone input box
	     var phoneInput = document.querySelectorAll("input[id=internationalBillNum]");
		var iti_el_phone = $(".iti.iti--allow-dropdown.iti--separate-dial-code:eq(0)");
		if (iti_el_phone.length) {
			itiphone.destroy();

			// Get the current number in the given format
		}
		for (var i = 0; i < phoneInput.length; i++) {
			var itiphone = intlTelInput(phoneInput[i], {
				autoHideDialCode: false,
				autoPlaceholder: "aggressive",
				initialCountry: "us",
				separateDialCode: true,
				preferredCountries: ["us", "gb","ca"],
				customPlaceholder: function (
					selectedCountryPlaceholder,
					selectedCountryData
				) {
					return "" + selectedCountryPlaceholder.replace(/[0-9]/g, "X");
				},
				geoIpLookup: function (callback) {
					$.get("https://ipinfo.io", function () {}, "jsonp").always(function (resp) {
						var countryCode = resp && resp.country ? resp.country : "";
						callback(countryCode);
					});
				},
				utilsScript:
					"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"
			});

			$('input[id="internationalBillNum"]').on(
				"focus click countrychange",
				function (e, countryData) {
					var pl = $(this).attr("placeholder") + "";
					var res = pl.replace(/X/g, "9");
					if (res != "undefined") {
						$(this).inputmask(res, { placeholder: "X", clearMaskOnLostFocus: true });
					}
				}
			);

			$('input[id="internationalBillNum"]').on(
				"focusout",
				function(e, countryData) {
					/* var intlNumber = itiphone.getNumber();*/
					var billNumOriginal = document.getElementById('phoneNo');
					var selCountryData = itiphone.getSelectedCountryData();
					if ($(phoneInput).val().trim() != "") {
						if ($(phoneInput).val() != null || $(phoneInput).val().trim() != "" || $(phoneInput).val().length === 0) {
							if ($(phoneInput).val() != null || $(phoneInput).val() != '') {
								
								/* var formattedNum = selCountryData.dialCode + $(phoneInput).val();
								billNumOriginal.value = "+" + formattedNum.replaceAll(" ", '').replaceAll("-",''); */
								var formattedNum = $(phoneInput).val();
								billNumOriginal.value = formattedNum.replaceAll(" ", '').replaceAll("-",'');
								
								console.log(document.getElementById('phoneNo').value);
								document.getElementById('mobileNo').value = document.getElementById('phoneNo').value;
								
							}
						}
					}
				}
				);
		} 
	});
	
	$(function () {
	//For mobileNo path - Mobile Phone input box
			/* var mobileInput = document.querySelectorAll("input[id=internationalMobileNum]");
			var iti_el_mobile = $(".iti.iti--allow-dropdown.iti--separate-dial-code:eq(1)");
			
			for (var i = 0; i < mobileInput.length; i++) {
				var itimobile = intlTelInput(mobileInput[i], {
					autoHideDialCode: false,
					autoPlaceholder: "aggressive",
					initialCountry: "us",
					separateDialCode: true,
					preferredCountries: ["us", "gb","ca"],
					customPlaceholder: function (
						selectedCountryPlaceholder,
						selectedCountryData
					) {
						return "" + selectedCountryPlaceholder.replace(/[0-9]/g, "X");
					},
					geoIpLookup: function (callback) {
						$.get("https://ipinfo.io", function () {}, "jsonp").always(function (resp) {
							var countryCode = resp && resp.country ? resp.country : "";
							callback(countryCode);
						});
					},
					utilsScript:
						"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"
				});

				$('input[id="internationalMobileNum"]').on(
					"focus click countrychange",
					function (e, countryData) {
						var pl = $(this).attr("placeholder") + "";
						var res = pl.replace(/X/g, "9");
						if (res != "undefined") {
							$(this).inputmask(res, { placeholder: "X", clearMaskOnLostFocus: true });
						}
					}
				);

				$('input[id="internationalMobileNum"]').on("focusout",function (e, countryData) {
				//var int2Number = itimobile.getNumber();
				var selCountryData = itimobile.getSelectedCountryData();
				var mobileNumOriginal = document.getElementById('mobileNo');
				if ($(mobileInput).val().trim() != "") {
					if ($(mobileInput).val() != null || $(mobileInput).val().trim() != "" || $(mobileInput).val().length === 0) {
						var formattedMobileNum = selCountryData.dialCode + "-" + $(mobileInput).val();
						mobileNumOriginal.value = formattedMobileNum.replaceAll(" ", "-");
						console.log(document.getElementById('mobileNo').value);
						
					}
				}
			}
			);
			}
			if (iti_el_mobile.length) {
				itimobile.destroy();
			} */
	});
</script>
<script type="text/javascript">
$(function () {

		//var mobileNum = document.getElementById('internationalMobileNum');
		var billNum = document.getElementById('internationalBillNum');
		//const mobileInput = document.getElementById('mobileNo');
		const phoneInput = document.getElementById('phoneNo');
		billNum.addEventListener('blur', function() {
			if (billNum.value.trim() != '' ) {
				billNum.classList.remove('has-error');
				billNum.classList.add('valid');
			} else {
				billNum.classList.add('has-error');
				billNum.value='';
				phoneInput.value ='';
			}
		});

		/* mobileNum.addEventListener('blur', function() {
			if (mobileNum.value.trim() != '' ) {
				mobileNum.classList.remove('has-error');
				mobileNum.classList.add('valid');
			}else{
				mobileNum.classList.add('has-error');
				mobileInput.value = '';
				mobileNum.value= '';
			}
		}); */
		
	});
	function validateMobileInputs(){
    
	//const mobileInput = document.getElementById('mobileNo');
	//var mobileNum = document.getElementById('internationalMobileNum');
	const phoneInput = document.getElementById('phoneNo');
	var billNum = document.getElementById('internationalBillNum');
	
	if (billNum.value.trim() =='' || billNum.value.trim().includes('X'))
	{
		billNum.classList.add('has-error');
		billNum.value='';
		phoneInput.value='';
	}
	/* if (mobileNum.value.trim() =='' || mobileNum.value.trim().includes('X'))
	{
		mobileNum.classList.add('has-error');
		mobileNum.value = '';
		mobileInput.value = '';
		
		mobileNum.focus();
		
	}*/
		
}; 
</script>
<!-- end - email and mobile  -->
</html>