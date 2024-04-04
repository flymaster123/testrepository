
package com.travel.service;

import com.travel.object.deal.DealResponse;
import com.travel.object.fareRules.CheckFareRules;
import com.travel.object.bookingrequest.BookingRequest;
import com.travel.object.flightresponse.OtherBound;
import java.util.List;
import com.travel.object.searchRequest.FlightRequest;
import javax.servlet.http.HttpServletRequest;
import com.travel.bean.FlightSearch;

public interface FlightService
{
    FlightRequest getFlightSearchRequest(final FlightSearch p0, final HttpServletRequest p1, final String p2);
    
    String getFlightSearchResponse(final FlightRequest p0);
    
    FlightRequest getFlightDeepSearchRequest(final HttpServletRequest p0, final String p1, final String p2, final String p3, final String p4, final String p5, final List<List<OtherBound>> p6, final int p7, final int p8, final int p9, final int p10, final String p11, final String p12, final String p13, final String p14, final String p15);
    
    String getLiveFlightSearchResponse(final BookingRequest p0);
    
    String getFlightMetaCheck(final CheckFareRules p0);
    
    DealResponse getDealList();
    
    BookingRequest getMetaBookingRequest(final BookingRequest p0);
    
    String getFlightFareRules(final CheckFareRules p0);
}