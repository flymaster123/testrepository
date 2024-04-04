package com.travel.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.travel.object.fareRules.CheckFareRules;
import java.io.IOException;
import com.travel.object.deal.DealRequest;
import com.travel.object.deal.DealResponse;
import com.travel.object.bookingrequest.BookingRequest;
import com.travel.object.flightresponse.OtherBound;
import org.springframework.web.client.RestTemplate;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;
import com.travel.utility.Utility;
import eu.bitwalker.useragentutils.UserAgent;
import com.travel.object.searchRequest.Segment;
import java.util.ArrayList;
import com.travel.object.searchRequest.FlightRequest;
import javax.servlet.http.HttpServletRequest;
import com.travel.bean.FlightSearch;
import org.springframework.beans.factory.annotation.Autowired;
import com.travel.service.RestDataService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.travel.service.FlightService;

@Service
public class FlightServiceImpl implements FlightService
{
    @Value("${siteName}")
    private String siteName;
    @Value("${siteId}")
    private int siteId;
    @Value("${currency}")
    private String currency;
    @Value("${apiUrl}")
    private String apiUrl;
    @Value("${flightAPiUrl}")
    private String flightAPiUrl;
    @Value("${password}")
    private String password;
    @Autowired
    RestDataService restService;
    @Value("${flightMetaAPIUrl}")
    private String flightMetaAPIUrl;
    
    @Override
    public FlightRequest getFlightSearchRequest(final FlightSearch flightSearch, final HttpServletRequest request, final String searchId) {
        final FlightRequest flightRequest = new FlightRequest();
        final List<Segment> segment = new ArrayList<Segment>();
        final Segment departSegment = new Segment();
        if (flightSearch.getOrigin().length() == 3) {
            flightSearch.setOrigin((String)this.restService.getAirportList(flightSearch.getOrigin()).get(0));
        }
        if (flightSearch.getDestination().length() == 3) {
            flightSearch.setDestination((String)this.restService.getAirportList(flightSearch.getDestination()).get(0));
        }
        departSegment.setOriginAirport(flightSearch.getOrigin().substring(0, flightSearch.getOrigin().indexOf("-")));
        departSegment.setDestinationAirport(flightSearch.getDestination().substring(0, flightSearch.getDestination().indexOf("-")));
        departSegment.setTravelDate(flightSearch.getDepartDate());
        segment.add(departSegment);
        if (flightSearch.getTripType().equalsIgnoreCase("2")) {
            final Segment returnSegment = new Segment();
            returnSegment.setOriginAirport(flightSearch.getDestination().substring(0, flightSearch.getDestination().indexOf("-")));
            returnSegment.setDestinationAirport(flightSearch.getOrigin().substring(0, flightSearch.getOrigin().indexOf("-")));
            returnSegment.setTravelDate(flightSearch.getReturnDate());
            segment.add(returnSegment);
        }
        else if (flightSearch.getTripType().equalsIgnoreCase("3")) {
            final Segment segment2 = new Segment();
            segment2.setOriginAirport(flightSearch.getOrigin2().substring(0, flightSearch.getOrigin2().indexOf("-")));
            segment2.setDestinationAirport(flightSearch.getDestination2().substring(0, flightSearch.getDestination2().indexOf("-")));
            segment2.setTravelDate(flightSearch.getDepartDate2());
            segment.add(segment2);
            if (flightSearch.getOrigin3() != null) {
                final Segment segment3 = new Segment();
                segment3.setOriginAirport(flightSearch.getOrigin3().substring(0, flightSearch.getOrigin3().indexOf("-")));
                segment3.setDestinationAirport(flightSearch.getDestination3().substring(0, flightSearch.getDestination3().indexOf("-")));
                segment3.setTravelDate(flightSearch.getDepartDate3());
                segment.add(segment3);
                System.out.println("4: " + flightSearch.getOrigin4());
                if (flightSearch.getOrigin4() != null && flightSearch.getOrigin4() != "") {
                    final Segment segment4 = new Segment();
                    segment4.setOriginAirport(flightSearch.getOrigin4().substring(0, flightSearch.getOrigin4().indexOf("-")));
                    segment4.setDestinationAirport(flightSearch.getDestination4().substring(0, flightSearch.getDestination4().indexOf("-")));
                    segment4.setTravelDate(flightSearch.getDepartDate4());
                    segment.add(segment4);
                    if (flightSearch.getOrigin5() != null && flightSearch.getOrigin5() != "") {
                        final Segment segment5 = new Segment();
                        segment5.setOriginAirport(flightSearch.getOrigin5().substring(0, flightSearch.getOrigin5().indexOf("-")));
                        segment5.setDestinationAirport(flightSearch.getDestination5().substring(0, flightSearch.getDestination5().indexOf("-")));
                        segment5.setTravelDate(flightSearch.getDepartDate5());
                        segment.add(segment5);
                        if (flightSearch.getOrigin6() != null && flightSearch.getOrigin6() != "") {
                            final Segment segment6 = new Segment();
                            segment6.setOriginAirport(flightSearch.getOrigin6().substring(0, flightSearch.getOrigin6().indexOf("-")));
                            segment6.setDestinationAirport(flightSearch.getDestination6().substring(0, flightSearch.getDestination6().indexOf("-")));
                            segment6.setTravelDate(flightSearch.getDepartDate6());
                            segment.add(segment6);
                        }
                    }
                }
            }
        }
        flightRequest.setClient(Integer.valueOf(this.siteId));
        flightRequest.setAdults(Integer.valueOf(flightSearch.getAdult()));
        flightRequest.setAirline("All");
        String userBrowserDetails = "userBrowserDetails";
        String device = "";
        try {
            final UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
            userBrowserDetails = userAgent.getOperatingSystem() + "-" + userAgent.getBrowser() + "-" + userAgent.getBrowserVersion();
            device = userAgent.getOperatingSystem().getDeviceType().getName();
        }
        catch (Exception e1) {
            userBrowserDetails = request.getHeader("user-agent");
        }
        flightRequest.setBrowser(userBrowserDetails);
        flightRequest.setCabinType(Utility.getCabinId(flightSearch.getCabin()));
        flightRequest.setChild(Integer.valueOf(flightSearch.getChild()));
        flightRequest.setCurrencyCode(this.currency);
        flightRequest.setDevice(device);
        flightRequest.setFlexibleSearch(Boolean.valueOf(false));
        flightRequest.setInfants(Integer.valueOf(flightSearch.getInfant()));
        flightRequest.setInfantsWs(Integer.valueOf(flightSearch.getInfantWs()));
        flightRequest.setIsNearBy(Boolean.valueOf(false));
        flightRequest.setLimit(Integer.valueOf(200));
        flightRequest.setLocale("en");
        flightRequest.setMedia(this.siteName);
        flightRequest.setRID("");
        flightRequest.setSearchDirectFlight(Boolean.valueOf(flightSearch.isDirectFlight()));
        flightRequest.setSearchID(searchId);
        flightRequest.setSegment((List)segment);
        flightRequest.setServerIP("");
        flightRequest.setSID("");
        flightRequest.setSiteId(Integer.valueOf(this.siteId));
        flightRequest.setSource("Online");
        flightRequest.setTripType(Integer.valueOf(Integer.parseInt(flightSearch.getTripType())));
        flightRequest.setUserIP(request.getRemoteAddr());
        try {
            System.out.println("FlightServiceImpl::flightRequest::" + new ObjectMapper().writeValueAsString((Object)flightRequest));
        }
        catch (Exception ex) {}
        return flightRequest;
    }
    
    @Override
    public String getFlightSearchResponse(final FlightRequest flightRequest) {
        final RestTemplate rest = new RestTemplate();
        final String res = (String)rest.postForObject(String.valueOf(this.flightAPiUrl) + "/flightSearchs?authcode=" + this.password, (Object)flightRequest, (Class)String.class, new Object[0]);
        System.out.println("FlightServiceImpl::getFlightSearchResponse::" + res);
        return res;
    }
    
    @Override
    public FlightRequest getFlightDeepSearchRequest(final HttpServletRequest request, final String type, final String origin, final String destination, final String origin1, final String destination1, final List<List<OtherBound>> otherBounds, final int adults, final int children, final int infants, final int infantws, final String departure, final String retu, final String cabin, final String utm_source, final String utm_medium) {
        System.out.println("FlightServiceImpl :: getFlightDeepSearchRequest Caling.....");
        final FlightRequest flightRequest = new FlightRequest();
        final List<Segment> segment = new ArrayList<Segment>();
        final Segment departSegment = new Segment();
        departSegment.setOriginAirport(origin);
        departSegment.setDestinationAirport(destination);
        departSegment.setTravelDate(departure);
        segment.add(departSegment);
        if (type.equalsIgnoreCase("RT") || type.equalsIgnoreCase("RoundTrip") || type.equalsIgnoreCase("OpenJaw") || type.equalsIgnoreCase("MultiCity")) {
            final Segment returnSegment = new Segment();
            returnSegment.setOriginAirport(origin1);
            returnSegment.setDestinationAirport(destination1);
            returnSegment.setTravelDate(retu);
            segment.add(returnSegment);
        }
        if (type.equalsIgnoreCase("MultiCity")) {
            for (int i = 0; i < otherBounds.size(); ++i) {
                String originMc = "";
                String destinationMc = "";
                String departureDate = "";
                for (int j = 0; j < otherBounds.get(i).size(); ++j) {
                    if (j == 0) {
                        originMc = otherBounds.get(i).get(j).getFromAirport();
                        departureDate = otherBounds.get(i).get(j).getDepDate();
                    }
                    destinationMc = otherBounds.get(i).get(j).getToAirport();
                }
                final Segment returnSegment2 = new Segment();
                returnSegment2.setOriginAirport(originMc);
                returnSegment2.setDestinationAirport(destinationMc);
                returnSegment2.setTravelDate(Utility.googleDateformat(departureDate));
                segment.add(returnSegment2);
            }
        }
        try {
            System.out.println("FlightServiceImpl:: getFlightDeepSearchRequest :: Segment:: " + new ObjectMapper().writeValueAsString((Object)segment));
        }
        catch (Exception ex) {}
        flightRequest.setClient(Integer.valueOf(this.siteId));
        flightRequest.setAdults(Integer.valueOf(adults));
        flightRequest.setAirline("All");
        String userBrowserDetails = "userBrowserDetails";
        String device = "";
        try {
            final UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
            userBrowserDetails = userAgent.getOperatingSystem() + "-" + userAgent.getBrowser() + "-" + userAgent.getBrowserVersion();
            device = userAgent.getOperatingSystem().getDeviceType().getName();
        }
        catch (Exception e1) {
            userBrowserDetails = request.getHeader("user-agent");
        }
        flightRequest.setBrowser(userBrowserDetails);
        flightRequest.setCabinType(Utility.getCabinId(cabin));
        flightRequest.setChild(Integer.valueOf(children));
        flightRequest.setCurrencyCode(this.currency);
        flightRequest.setDevice(device);
        flightRequest.setFlexibleSearch(Boolean.valueOf(false));
        flightRequest.setInfants(Integer.valueOf(infants));
        flightRequest.setInfantsWs(Integer.valueOf(infantws));
        flightRequest.setIsNearBy(Boolean.valueOf(false));
        flightRequest.setLimit(Integer.valueOf(200));
        flightRequest.setLocale("en");
        flightRequest.setMedia("Google");
        flightRequest.setRID("");
        flightRequest.setSearchDirectFlight(Boolean.valueOf(false));
        flightRequest.setSearchID(Utility.getAlphaNumericString(16));
        flightRequest.setSegment((List)segment);
        flightRequest.setServerIP("");
        flightRequest.setSID("");
        flightRequest.setSiteId(Integer.valueOf(this.siteId));
        flightRequest.setSource(utm_source);
        flightRequest.setMedia(utm_medium);
        flightRequest.setTripType(Integer.valueOf(1));
        if (type.equalsIgnoreCase("RT")) {
            flightRequest.setTripType(Integer.valueOf(2));
        }
        if (type.equalsIgnoreCase("RoundTrip")) {
            flightRequest.setTripType(Integer.valueOf(2));
        }
        if (type.equalsIgnoreCase("OpenJaw")) {
            flightRequest.setTripType(Integer.valueOf(2));
        }
        if (type.equalsIgnoreCase("MultiCity")) {
            flightRequest.setTripType(Integer.valueOf(3));
        }
        flightRequest.setUserIP(request.getRemoteAddr());
        try {
            System.out.println("FlightServiceImpl:: getFlightDeepSearchRequest :: FlightSearchRequest:: " + new ObjectMapper().writeValueAsString((Object)flightRequest));
        }
        catch (Exception ex2) {}
        return flightRequest;
    }
    
    @Override
    public String getLiveFlightSearchResponse(final BookingRequest bookingRequest) {
        final RestTemplate rest = new RestTemplate();
        final String res = (String)rest.postForObject(String.valueOf(this.flightAPiUrl) + "/customerRequests?authcode=" + this.password, (Object)bookingRequest, (Class)String.class, new Object[0]);
        return res;
    }
    
    @Override
    public DealResponse getDealList() {
        final RestTemplate rest = new RestTemplate();
        final ObjectMapper mapper = new ObjectMapper();
        final DealRequest dealRequest = new DealRequest();
        dealRequest.setAirline("");
        dealRequest.setCabinClass("Y");
        dealRequest.setCityName((Object)"");
        dealRequest.setCountryCode("US");
        dealRequest.setCountryName("US");
        dealRequest.setCurrency("USD");
        dealRequest.setDepartDate((Object)"");
        dealRequest.setFroCity("");
        dealRequest.setPage("");
        dealRequest.setToCity("");
        dealRequest.setTripType("2");
        dealRequest.setSiteId("3");
        System.out.println(String.valueOf(this.apiUrl) + "/travelsite/deals?authcode=" + this.password);
        final String dealResStr = (String)rest.postForObject(String.valueOf(this.apiUrl) + "/travelsite/deals?authcode=" + this.password, (Object)dealRequest, (Class)String.class, new Object[0]);
        System.out.println(dealResStr);
        DealResponse dealResponse = null;
        try {
            dealResponse = (DealResponse)mapper.readValue(dealResStr, (Class)DealResponse.class);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        return dealResponse;
    }
    
    @Override
    public String getFlightMetaCheck(final CheckFareRules checkFareRules) {
        final RestTemplate rest = new RestTemplate();
        final String fareRules = (String)rest.postForObject(String.valueOf(this.flightAPiUrl) + "/GetFlightMetaCheck?authcode=" + this.password, (Object)checkFareRules, (Class)String.class, new Object[0]);
        return fareRules;
    }
    
    @Override
    public BookingRequest getMetaBookingRequest(BookingRequest bookingRequest) {
        final RestTemplate rest = new RestTemplate();
        bookingRequest.setSiteID(this.siteId);
        bookingRequest.setCurrencyCode(this.currency);
        final ObjectMapper mapper = new ObjectMapper();
        try {
            System.out.println("Jetrdr :: bookingRequest:: " + mapper.writeValueAsString((Object)bookingRequest));
        }
        catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        final String res = (String)rest.postForObject(String.valueOf(this.flightMetaAPIUrl) + "/metaBookingRequest?authcode=" + this.password, (Object)bookingRequest, (Class)String.class, new Object[0]);
        System.out.println("FlightServiceImpl :: MetaBookingResponse:: " + res);
        try {
            bookingRequest = (BookingRequest)mapper.readValue(res, (Class)BookingRequest.class);
        }
        catch (IOException e2) {
            e2.printStackTrace();
        }
        return bookingRequest;
    }
    
    @Override
    public String getFlightFareRules(final CheckFareRules checkFareRules) {
        final RestTemplate rest = new RestTemplate();
        final String fareRules = (String)rest.postForObject(String.valueOf(this.flightAPiUrl) + "/GetFlightFareRule?authcode=" + this.password, (Object)checkFareRules, (Class)String.class, new Object[0]);
        return fareRules;
    }
}