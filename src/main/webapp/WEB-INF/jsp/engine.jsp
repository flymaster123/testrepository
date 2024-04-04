<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page pageEncoding="UTF-8" %>

<form:form modelAttribute="flightSearch" action="flight" method="POST">       
<div class="engine">
                <div class="engine-selector">
                   <ul> <li><a><i class="fa fa-plane"></i> &nbsp;&nbsp;FLIGHTS</a></li></ul>
                </div>
                <div class="flight-engine">
				<form:hidden path="tripType" value="2"/>
				<form:hidden path="pageAirline" />
                    <div class="trip-selector">
                        <label> Round Trip<input type="radio" name="trip" checked="checked" onclick="tripselector();multicity1();";><span class="custom-radio"></span></label>
                        <label> One Way<input type="radio" name="trip" id="oneway" onclick="tripselector();multicity1();";><span class="custom-radio"></span></label>
                        <label> Multi City<input type="radio" name="trip" id="multicity" onclick="tripselector();multicity1();"><span class="custom-radio"></span></label>
                    </div>
                    <div class="flight-search">
                        <div class="search-date">
                            <div class="defaultcity">
                                <div class="flightno" style="display:none;">Flight 1</div>
                                <div class="origra">
                                    <!-- <i class="fa fa-times-circle" id="OremEmpIcon" onclick="delEmpVal('origin','FcityName','OremEmpIcon','txtFltOrigin')" style="display:none;"></i> -->
                                    <img class="planeD" src="/resources/images/icons/take-off.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <!-- <span>Origin</span>
                                    <strong id="txtFltOrigin" style="display:none;"></strong> -->
                                    <form:input  path="origin" class="search" placeholder="Enter Origin" />
                                    <!-- <label class="bottom" for="origin" id="FcityName">&nbsp;</label> -->
                                    <!-- <input type="button" id="swap"> -->
                                    <img src="/resources/images/icons/swap-fill.png" alt="swap image" id="swap">
                                </div>
                                

                                <div class="origra rvksh">
                                    <!-- <i class="fa fa-times-circle" id="DremEmpIcon" onclick="delEmpVal('destination','RcityName','DremEmpIcon','txtFltDestin')" style="display:none;"></i> -->
                                    <img src="/resources/images/icons/landing.png" class="planeD" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <!-- <span>Destination</span>
                                    <strong id="txtFltDestin" style="display:none;"></strong> -->
                                    <form:input path="destination" class="search" placeholder="Enter Destination" />
                                    <!-- <label class="bottom" for="destination" id="RcityName">&nbsp;</label> -->
                                </div>

                                <div class="cal_wrap">
                            <div class="origra departCal">
                                <!-- <p class="ashm"><img src="/resources/images/mips2.png" style="width: 24px; height: 24px;"></p> -->
                                <!-- <span>Depart</span> -->
                                <form:input path="departDate" readonly="true" class="date" placeholder="Depart" />
                                <!-- <span class="bottom pl23px">Date</span> -->
                                <input type="button" class="mips" aria-label="mips" style="padding-left:0;">
                            </div>
                            
                            <div class="origra returnCal date rvksh2" id="retrnCalndr">
                                <!-- <p class="ashm"><img src="/resources/images/mips2.png" style="width: 24px; height: 24px;"></p>
                                <span>Return</span> -->

                                <form:input path="returnDate" readonly="true" class="date" placeholder="Return" />
                                <!-- <span class="bottom pl23px">Date</span> -->
                            </div>
                        </div>

                            </div>
                            <div class="multicity" style="display:none;">
                                <div class="flightno">Flight 2</div>
                                <!-- <label class="originM">Origin</label> -->
                                <div class="multiFrom">
                                    <img src="/resources/images/icons/take-off.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <form:input path="origin2" class="msearch" placeholder="Enter Origin" />
                                    <img src="/resources/images/icons/swap-fill.png" alt="swap image" onclick="swapFun('origin2','destination2')" id="" class="swapClass">
                                </div>
                                <!-- <label class="destinationM">Destination</label> -->
                                <div class="multiTo">
                                    <img src="/resources/images/icons/landing.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <form:input path="destination2" name="from" class="msearch" placeholder="Enter Destination" />
                                </div>
                                <div class="multiDate">
                                    <img src="/resources/images/icons/calendar-todo-fill.svg" alt="calendar" class="Mcalendr">
                                    <form:input path="departDate2" name="depart" class="mdate" readonly="true" placeholder="Depart" />
                                </div>
                                <button type="button" class="cbtn" onclick="closeself()"><i class="fa fa-close"></i></button>
                            </div>
                            <div class="multicity" style="display:none;">
                                <div class="flightno"><span>Flight 3</span><button type="button" onclick="closeself()"><i class="fa fa-close"></i> Remove This</button></div>
                                <!-- <label class="originM">Origin</label> -->
                                <div class="multiFrom">
                                    <img src="/resources/images/icons/take-off.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <form:input path="origin3" class="msearch" placeholder="Enter Origin" />
                                    <img src="/resources/images/icons/swap-fill.png" alt="swap image" onclick="swapFun('origin3','destination3')" id="" class="swapClass">
                                </div>
                                <!-- <label class="destinationM">Destination</label> -->
                                <div class="multiTo">
                                    <img src="/resources/images/icons/landing.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <form:input path="destination3" class="msearch" placeholder="Enter Destination" />
                                </div>
                                <div class="multiDate">
                                    <img src="/resources/images/icons/calendar-todo-fill.svg" alt="calendar" class="Mcalendr">
                                    <form:input path="departDate3" class="mdate" readonly="true" placeholder="Depart" />
                                </div>
                                <button type="button" class="cbtn" onclick="closeself()"><i class="fa fa-close"></i></button>
                            </div>
                            <div class="multicity" style="display:none;">
                                <div class="flightno"><span>Flight 4</span><button type="button" onclick="closeself()"><i class="fa fa-close"></i> Remove This</button></div>
                                <!-- <label class="originM">Origin</label> -->
                                <div class="multiFrom">
                                    <img src="/resources/images/icons/take-off.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <form:input path="origin4" class="msearch" placeholder="Enter Origin" />
                                    <img src="/resources/images/icons/swap-fill.png" alt="swap image" onclick="swapFun('origin4','destination4')" id="" class="swapClass">
                                </div>
                                <!-- <label class="destinationM">Destination</label> -->
                                <div class="multiTo">
                                    <img src="/resources/images/icons/landing.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <form:input path="destination4" class="msearch" placeholder="Enter Destination" />
                                </div>
                                <div class="multiDate">
                                    <img src="/resources/images/icons/calendar-todo-fill.svg" alt="calendar" class="Mcalendr">
                                    <form:input path="departDate4" class="mdate" readonly="true" placeholder="Depart" />
                                </div>
                                <button type="button" class="cbtn" onclick="closeself()"><i class="fa fa-close"></i></button>
                            </div>
                            <div class="multicity" style="display:none;">
                                <div class="flightno"><span>Flight 5</span><button type="button" onclick="closeself()"><i class="fa fa-close"></i> Remove This</button></div>
                                <!-- <label class="originM">Origin</label> -->
                                <div class="multiFrom">
                                    <img src="/resources/images/icons/take-off.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <form:input path="origin5" class="msearch" placeholder="Enter Origin" />
                                    <img src="/resources/images/icons/swap-fill.png" alt="swap image" onclick="swapFun('origin5','destination5')" id="" class="swapClass">
                                </div>
                                <!-- <label class="destinationM">Destination</label> -->
                                <div class="multiTo">
                                    <img src="/resources/images/icons/landing.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <form:input path="destination5" class="msearch" placeholder="Enter Destination" />
                                </div>
                                <div class="multiDate">
                                    <img src="/resources/images/icons/calendar-todo-fill.svg" alt="calendar" class="Mcalendr">
                                    <form:input path="departDate5" class="mdate" readonly="true" placeholder="Depart" />
                                </div>
                                <button type="button" class="cbtn" onclick="closeself()"><i class="fa fa-close"></i></button>
                            </div>
                            <div class="multicity" style="display:none;">
                                <div class="flightno"><span>Flight 6</span><button type="button" onclick="closeself()"><i class="fa fa-close"></i> Remove This</button></div>
                                <!-- <label class="originM">Origin</label> -->
                                <div class="multiFrom">
                                    <img src="/resources/images/icons/take-off.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <form:input path="origin6" class="msearch" placeholder="Enter Origin" />
                                    <img src="/resources/images/icons/swap-fill.png" alt="swap image" onclick="swapFun('origin6','destination6')" class="swapClass" id="">
                                </div>
                                <!-- <label class="destinationM">Destination</label> -->
                                <div class="multiTo">
                                    <img src="/resources/images/icons/landing.png" alt="plane" width="24" height="24" loading="lazy" decoding="async">
                                    <form:input path="destination6" class="msearch" placeholder="Enter Destination" />
                                </div>
                                <div class="multiDate">
                                    <img src="/resources/images/icons/calendar-todo-fill.svg" alt="calendar" class="Mcalendr">
                                    <form:input path="departDate6" class="mdate" readonly="true" placeholder="Depart" />
                                </div>
                                <button type="button" class="cbtn" onclick="closeself()"><i class="fa fa-close"></i></button>
                            </div>
                        </div>
                        <div class="coach-button">
                            <div class="coach-type rvksh" id="hideInMobile">
                                <form:select path="cabin" class="selectNiceSelect" onchange="travelercount()">
                                    <option>Economy</option>
                                    <option>PremiumEconomy</option>
                                    <option>Business</option>
                                    <option>First</option>
                                </form:select>
                            </div>
                            <div class="trvlrSectn">
                                <input type="text" name="coach" class="coach coachi1" aria-label="coach" value="1 Traveller" onclick="travelercoach();" readonly>
                                <i class="fa fa-angle-down"></i>
                                <div class="traveler-coach-dropdown" id="tcd" style="visibility:hidden;">
                                    <div class="travelers-container">
                                        <div class="traveler-type">
                                            <div><b>Adult</b><p>Age 18+</p></div>
                                            <div class="plus-minus-number">
                                                <button type="button" class="paxMinus" data-pax="adult" ><i class="fa fa-minus"></i></button>
                                                <form:input path="adult" readonly="true" class="pnumber" value="1" />
                                                <button type="button" class="paxPlus" data-pax="adult" ><i class="fa fa-plus"></i></button>
                                            </div>
                                        </div>
                                    
                                        <div class="traveler-type">
                                            <div><b>Child</b> <p>Age (2-15)</p></div>
                                            <div class="plus-minus-number">
                                                <button type="button" class="paxMinus" data-pax="child" ><i class="fa fa-minus"></i></button>
                                                <form:input path="child"  readonly="true" class="pnumber" value="0" />
                                                <button type="button" class="paxPlus" data-pax="child" ><i class="fa fa-plus"></i></button>
                                            </div>
                                        </div>
                                        <div class="traveler-type">
                                            <div><b>Seat Infant</b> <p>Age (Under 2)</p></div>
                                            <div class="plus-minus-number">
                                                <button type="button" class="paxMinus" data-pax="infantws" ><i class="fa fa-minus"></i></button>
                                                <form:input path="infantWs"   readonly="true" class="pnumber" value="0" />
                                                <button type="button" class="paxPlus" data-pax="infantws" ><i class="fa fa-plus"></i></button>
                                            </div>
                                        </div>
                                        <div class="traveler-type">
                                            <div><b>Lap Infant</b> <p>Age (Under 2)</p></div>
                                            <div class="plus-minus-number">
                                                <button type="button" class="paxMinus" data-pax="infant" ><i class="fa fa-minus"></i></button>
                                                <form:input path="infant" readonly="true" class="pnumber" value="0" />
                                                <button type="button" class="paxPlus" data-pax="infant" ><i class="fa fa-plus"></i></button>
                                            </div>
                                        </div>
                                        
                                    </div>
                                    <div class="class-done">
                                     
                                        <button type="button" onclick="tchide();">Done</button>
                                    </div>
                                </div>
                            </div>
                            
                            
                               




                            <button type="submit" id="sbtn">Search</button>

                        </div>
                    </div>
                    <div class="airline-search" style="display: none;">
                        <input list="airlineslist" name="airline" class="airline" placeholder="Select Preffered Airline">
                        <datalist id="airlineslist">
						<c:forEach items="${airlineList}" var="airline">
                            <option value="${airline.value} (${airline.key})"></option>
                         </c:forEach>
                        </datalist>
                        <label> Direct Flights<form:checkbox path="directFlight" class="direct-flights" /><span class="custom-switch"></span></label>
                        
						
                    </div>
                    <div class="multibuttons">
                            <button type="button" id="addflight" onclick="addflight1()"><i class="fa fa-plus"></i> Add Flight</button>
                            <button type="button" id="clearall">Clear All</button>
                        </div>
                </div>

                <div class="bannerheding">
                    <div class="main">
                    <div class="mainarea">
                    
                    <!-- <h1>Compare and Book Cheap Flights on 
                            </br>Over <span style="text-shadow:1px 2px 2px #252525; color:#f8e122; font-size:40px; font-weight: 700;">600 Airlines</span></h1> -->
                    
                    </div>
                    </div>
                </div>
                    
            </div>
</form:form>			
<script>
$(document).ready(function(){
    var wWidth = $(window).width();
    if(wWidth < 768){
        //$("#hideInMobile").remove();
        //var classVal = $(".trvlrSectn > input.coach").val();
        //$(".trvlrSectn > input.coach").val('1 Traveller, Economy');
    }
})
</script>