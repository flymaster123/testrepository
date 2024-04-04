package com.travel.controller;

import java.io.IOException;
import java.text.DateFormatSymbols;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.travel.bean.FlightSearch;
import com.travel.object.bookingrequest.AncillaryService;
import com.travel.object.bookingrequest.BookingRequest;
import com.travel.object.bookingrequest.PassengerDetail;
import com.travel.object.fareRules.CheckFareRules;
import com.travel.object.fareRules.FareRules;
import com.travel.object.flightresponse.Airline;
import com.travel.object.flightresponse.Airport;
import com.travel.object.flightresponse.Fare;
import com.travel.object.flightresponse.FlightResult;
import com.travel.object.flightresponse.InBound;
import com.travel.object.flightresponse.OtherBound;
import com.travel.object.flightresponse.OutBound;
import com.travel.object.searchRequest.FlightRequest;
import com.travel.object.searchRequest.Segment;
import com.travel.service.FlightService;
import com.travel.service.RestDataService;
import com.travel.utility.Utility;

import eu.bitwalker.useragentutils.UserAgent;

@Controller
public class FlightsMetaController
{
	@Autowired
	FlightService flightService;
	@Autowired
	MailController mailService;
	@Autowired
	RestDataService restService;
	@Value("${flightAPiUrl}")
	private String flightAPiUrl;
	@Value("${currency}")
	private String currency;
	@Value("${password}")
	private String password;
	@Value("${siteId}")
	private int siteId;

	@GetMapping({ "/flights/services" })
	public String googleLink(@ModelAttribute final FlightSearch flightSearch, @ModelAttribute final BookingRequest bookingRequest, final HttpServletRequest request, final Model model) {
		System.out.println("<<<<<< FlightsMetaController :: /flights/services GoogleLink Calling..>>>>>>");
		try {
			final StringBuffer url = request.getRequestURL();
			final String query = request.getQueryString();
			if (StringUtils.hasText(query)) {
				url.append('?').append(query);
			}
			System.out.println("FlightsMetaController :: Google Deeplink URL>>>>> " + url.toString());
		}
		catch (Exception ex) {}
		final String Adult = request.getParameter("Adult");
		final String Child = request.getParameter("Child");
		final String Infant = request.getParameter("Infant");
		final String InfantLap = request.getParameter("InfantLap");
		final String PointOfSaleCountry = request.getParameter("PointOfSaleCountry");
		final String UserCurrency = request.getParameter("UserCurrency");
		final String grandTotal = request.getParameter("DisplayedPrice");
		final String DisplayedPriceCurrency = request.getParameter("DisplayedPriceCurrency");
		final String UserLanguage = request.getParameter("UserLanguage");
		final String Refe = request.getParameter("ReferralId");
		final String TripType = request.getParameter("TripType");
		final String Slice1 = request.getParameter("Slice1");
		bookingRequest.setCurrencyCode(UserCurrency);
		bookingRequest.setAdults(Integer.valueOf(Integer.parseInt(Adult))); 
		try {
			bookingRequest.setChild(Integer.valueOf(Integer.parseInt(Child)));
		}
		catch (Exception e2) {
			bookingRequest.setChild(Integer.valueOf(0));
		}
		try {
			bookingRequest.setInfants(Integer.valueOf(Integer.parseInt(InfantLap)));
		}
		catch (Exception e3) {
			bookingRequest.setInfants(Integer.valueOf(0));
		}
		try {
			bookingRequest.setInfantsWs(Integer.valueOf(Integer.parseInt(Infant)));
		}
		catch (NumberFormatException e4) {
			bookingRequest.setInfantsWs(Integer.valueOf(0));
		}
		bookingRequest.setSearchID(Refe);
		bookingRequest.setSiteID(Integer.valueOf(1));
		bookingRequest.setProdID("1");
		bookingRequest.setBookingID("0");
		bookingRequest.setUserSessionID(Slice1);
		bookingRequest.setCurrencyCode(this.currency);
		String userBrowserDetails = "userBrowserDetails";
		String device = "";
		try {
			final UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
			userBrowserDetails = userAgent.getOperatingSystem() + "-" + userAgent.getBrowser() + "-" + userAgent.getBrowserVersion();
			device = userAgent.getOperatingSystem().getDeviceType().getName();
		}
		catch (Exception e5) {
			userBrowserDetails = request.getHeader("user-agent");
		}
		bookingRequest.setDevice(device);
		bookingRequest.setBrowser(userBrowserDetails);
		final List<PassengerDetail> passengerDetails = new ArrayList<PassengerDetail>();
		int travelerNo = 0;
		for (int i = 0; i < bookingRequest.getAdults(); ++i) {
			final PassengerDetail paxDetail = new PassengerDetail();
			paxDetail.setPassengerType(Integer.valueOf(1));
			passengerDetails.add(paxDetail);
			++travelerNo;
		}
		for (int i = 0; i < bookingRequest.getChild(); ++i) {
			final PassengerDetail paxDetail = new PassengerDetail();
			paxDetail.setPassengerType(Integer.valueOf(2));
			passengerDetails.add(paxDetail);
			++travelerNo;
		}
		for (int i = 0; i < bookingRequest.getInfants(); ++i) {
			final PassengerDetail paxDetail = new PassengerDetail();
			paxDetail.setPassengerType(Integer.valueOf(3));
			passengerDetails.add(paxDetail);
			++travelerNo;
		}
		for (int i = 0; i < bookingRequest.getInfantsWs(); ++i) {
			final PassengerDetail paxDetail = new PassengerDetail();
			paxDetail.setPassengerType(Integer.valueOf(4));
			passengerDetails.add(paxDetail);
			++travelerNo;
		}
		bookingRequest.setPassengerDetails((List)passengerDetails);
		final FlightResult selectedflight = new FlightResult();
		String origin1 = "";
		String destination1 = "";
		final String origin2 = request.getParameter("Origin1");
		bookingRequest.setDepartDate(Utility.googleDateformat(request.getParameter("DepartureDate1")));
		final String cabinId = request.getParameter("Cabin1");
		String destination2 = "";
		final List<OutBound> outBound = new ArrayList<OutBound>();
		final String[] outArray = Slice1.split(",");
		for (int j = 0; j < outArray.length; ++j) {
			final String count = outArray[j];
			final OutBound outRoute = new OutBound();
			final String Cabin1 = request.getParameter("Cabin".concat(count));
			outRoute.setCabinClass(Utility.getCabinId(Cabin1));
			final String Carrier1 = request.getParameter("Carrier".concat(count));
			outRoute.setAirline(Carrier1);
			outRoute.setOrgAirline(Carrier1);
			final String DepartureDate1 = request.getParameter("DepartureDate".concat(count));
			outRoute.setDepDate(DepartureDate1);
			final String Origin1 = request.getParameter("Origin".concat(count));
			outRoute.setFromAirport(Origin1);
			final String Destination1 = request.getParameter("Destination".concat(count));
			outRoute.setToAirport(Destination1);
			destination2 = Destination1;
			final String BookingCode1 = request.getParameter("BookingCode".concat(count));
			outRoute.setResDesignCode(BookingCode1);
			final String FlightNumber1 = request.getParameter("FlightNumber".concat(count));
			outRoute.setFlightNo(FlightNumber1);
			outBound.add(outRoute);
		}
		bookingRequest.setReturnDate("");
		selectedflight.setOutBound((List)outBound);
		if (TripType.equalsIgnoreCase("RoundTrip") || TripType.equalsIgnoreCase("OpenJaw") || TripType.equalsIgnoreCase("MultiCity")) {
			final List<InBound> inBound = new ArrayList<InBound>();
			final String Slice2 = request.getParameter("Slice2");
			final String[] inArray = Slice2.split(",");
			for (int k = 0; k < inArray.length; ++k) {
				final String count2 = inArray[k];
				final InBound inRoute = new InBound();
				final String Cabin2 = request.getParameter("Cabin".concat(count2));
				inRoute.setCabinClass(Utility.getCabinId(Cabin2));
				final String Carrier2 = request.getParameter("Carrier".concat(count2));
				inRoute.setAirline(Carrier2);
				inRoute.setOrgAirline(Carrier2);
				final String DepartureDate2 = request.getParameter("DepartureDate".concat(count2));
				System.out.println("FlightsMetaController::Slice2:: DepartureDate" + count2 + " :: " + DepartureDate2);
				inRoute.setDepDate(DepartureDate2);
				final String Origin2 = request.getParameter("Origin".concat(count2));
				if (k == 0) {
					origin1 = Origin2;
				}
				inRoute.setFromAirport(Origin2);
				final String Destination2 = request.getParameter("Destination".concat(count2));
				inRoute.setToAirport(Destination2);
				if (k == 0) {
					bookingRequest.setReturnDate(Utility.googleDateformat(DepartureDate2));
				}
				destination1 = Destination2;
				final String BookingCode2 = request.getParameter("BookingCode".concat(count2));
				inRoute.setResDesignCode(BookingCode2);
				final String FlightNumber2 = request.getParameter("FlightNumber".concat(count2));
				inRoute.setFlightNo(FlightNumber2);
				inBound.add(inRoute);
			}
			selectedflight.setInBound((List)inBound);
		}
		final List<List<OtherBound>> otherBounds = new ArrayList<List<OtherBound>>();
		try {
			final List<OtherBound> otherBound = new ArrayList<OtherBound>();
			final String Slice3 = request.getParameter("Slice3");
			final String[] inArray2 = Slice3.split(",");
			for (int l = 0; l < inArray2.length; ++l) {
				final String count3 = inArray2[l];
				final OtherBound inRoute2 = new OtherBound();
				final String Cabin3 = request.getParameter("Cabin".concat(count3));
				inRoute2.setCabinClass(Utility.getCabinId(Cabin3));
				final String Carrier3 = request.getParameter("Carrier".concat(count3));
				inRoute2.setAirline(Carrier3);
				inRoute2.setOrgAirline(Carrier3);
				final String DepartureDate3 = request.getParameter("DepartureDate".concat(count3));
				System.out.println("FlightsMetaController::Slice3:: DepartureDate" + count3 + " :: " + DepartureDate3);
				inRoute2.setDepDate(DepartureDate3);
				final String Origin3 = request.getParameter("Origin".concat(count3));
				inRoute2.setFromAirport(Origin3);
				final String Destination3 = request.getParameter("Destination".concat(count3));
				inRoute2.setToAirport(Destination3);
				final String BookingCode3 = request.getParameter("BookingCode".concat(count3));
				inRoute2.setResDesignCode(BookingCode3);
				final String FlightNumber3 = request.getParameter("FlightNumber".concat(count3));
				inRoute2.setFlightNo(FlightNumber3);
				otherBound.add(inRoute2);
			}
			otherBounds.add(otherBound);
		}
		catch (Exception ex2) {}
		try {
			for (int m = 4; m < 10; ++m) {
				final List<OtherBound> otherBound2 = new ArrayList<OtherBound>();
				final String Slice4 = request.getParameter("Slice" + m);
				final String[] inArray3 = Slice4.split(",");
				for (int i2 = 0; i2 < inArray3.length; ++i2) {
					final String count4 = inArray3[i2];
					final OtherBound inRoute3 = new OtherBound();
					final String Cabin4 = request.getParameter("Cabin".concat(count4));
					inRoute3.setCabinClass(Utility.getCabinId(Cabin4));
					final String Carrier4 = request.getParameter("Carrier".concat(count4));
					inRoute3.setAirline(Carrier4);
					inRoute3.setOrgAirline(Carrier4);
					final String DepartureDate4 = request.getParameter("DepartureDate".concat(count4));
					System.out.println("FlightsMetaController::Slice4::11111:: " + DepartureDate4);
					inRoute3.setDepDate(DepartureDate4);
					final String Origin4 = request.getParameter("Origin".concat(count4));
					inRoute3.setFromAirport(Origin4);
					final String Destination4 = request.getParameter("Destination".concat(count4));
					inRoute3.setToAirport(Destination4);
					final String BookingCode4 = request.getParameter("BookingCode".concat(count4));
					inRoute3.setResDesignCode(BookingCode4);
					final String FlightNumber4 = request.getParameter("FlightNumber".concat(count4));
					inRoute3.setFlightNo(FlightNumber4);
					otherBound2.add(inRoute3);
				}
				otherBounds.add(otherBound2);
			}
		}
		catch (Exception ex3) {}
		selectedflight.setOtherBound((List)otherBounds);
		final Fare fare = new Fare();
		fare.setGrandTotal(Double.valueOf(grandTotal));
		fare.setGrandOrgTotal(Double.valueOf(grandTotal));
		fare.setBagFees(Double.valueOf(0.0));
		fare.setMarkupType("US");
		fare.setMarkupID(Integer.valueOf(1));
		selectedflight.setResultID(Integer.valueOf(1));
		selectedflight.setCabinClass(selectedflight.getOutBound().get(0).getCabinClass());
		selectedflight.setFare(fare);
		selectedflight.setGdsType(Integer.valueOf(2));
		selectedflight.setValCarrier(selectedflight.getOutBound().get(0).getOrgAirline());
		selectedflight.setFareType("RP");
		selectedflight.setAirline(selectedflight.getOutBound().get(0).getOrgAirline());
		selectedflight.setMaxSeat(Integer.valueOf(7));
		bookingRequest.setFlightResult(selectedflight);
		final ObjectMapper mapper = new ObjectMapper();
		try {
			System.out.println("FlightsMetaController::GoogleLink:: BookingRequest :: " + mapper.writeValueAsString((Object)bookingRequest));
		}
		catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		final FlightRequest flightReq = this.flightService.getFlightDeepSearchRequest(request, TripType, origin2, destination2, origin1, destination1, (List)otherBounds, (int)bookingRequest.getAdults(), (int)bookingRequest.getChild(), (int)bookingRequest.getInfants(), (int)bookingRequest.getInfantsWs(), bookingRequest.getDepartDate(), bookingRequest.getReturnDate(), cabinId, "google", Refe);
		request.getSession().setAttribute("flightRequest", (Object)flightReq);
		request.getSession().setAttribute("bookingRequest", (Object)bookingRequest);
		request.getSession().setAttribute("selectedflight", (Object)selectedflight);
		model.addAttribute("searchRequest", (Object)flightReq);
		return "midMetaPayment";
	}

	@PostMapping({ "/deep/link/{searchId}" })
	public String googlePaymentLink(@PathVariable final String searchId, @ModelAttribute final FlightSearch flightSearch, @ModelAttribute BookingRequest bookingRequest, final HttpServletRequest request, final Model model) {
		System.out.println("<<<<<<<<<<< FlightsMetaController::GooglePaymentLink Calling..>>>>>>>>>>>>>");
		final FlightResult selectedflight = (FlightResult)request.getSession().getAttribute("selectedflight");
		final FlightRequest flightReq = (FlightRequest)request.getSession().getAttribute("flightRequest");
		bookingRequest = (BookingRequest)request.getSession().getAttribute("bookingRequest");
		final ObjectMapper mapper = new ObjectMapper();
		try {
			System.out.println("FlightsMetaController::Googledeeplink :: bookingRequest:: " + mapper.writeValueAsString((Object)bookingRequest));
			System.out.println("FlightsMetaController::FlightSearchRequest:: " + mapper.writeValueAsString((Object)flightReq));
		}
		catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		final CheckFareRules checkRules = new CheckFareRules();
		checkRules.setFlightResult(selectedflight);
		checkRules.setAdults(bookingRequest.getAdults());
		checkRules.setChild(bookingRequest.getChild());
		checkRules.setInfants(bookingRequest.getInfants());
		checkRules.setInfantsWs(bookingRequest.getInfantsWs());
		checkRules.setSiteID(bookingRequest.getSiteID());
		checkRules.setCurrencyCode(bookingRequest.getCurrencyCode());
		try {
			System.out.println("FlightsMetaController::CheckFareRules RQ:" + mapper.writeValueAsString((Object)checkRules));
		}
		catch (IOException e2) {
			e2.printStackTrace();
		}
		final String fareRules = this.flightService.getFlightMetaCheck(checkRules);
		System.out.println("FlightsMetaController::CheckFareRules-RS:" + fareRules);
		FareRules fareRulesObj = null;
		try {
			fareRulesObj = (FareRules)mapper.readValue(fareRules, (Class)FareRules.class);
		}
		catch (IOException e3) {
			e3.printStackTrace();
		}
		String anclrStr = "";
        try
		{
			anclrStr = mapper.writeValueAsString(fareRulesObj.getAncillaryServices());
		}catch(Exception e){}

		System.out.println("FlightPaymentPageOne:: anclrStr"+anclrStr);

		List<AncillaryService> anclrList = null;
		try
		{
			anclrList = mapper.readValue(anclrStr.toString(), new TypeReference<List<AncillaryService>>(){});
		}catch (Exception e) {}

		try
		{
			System.out.println("anclrList:: "+new ObjectMapper().writeValueAsString(anclrList));
		}catch (Exception e) {}

		bookingRequest.setAncillaryServices(anclrList);
		if (fareRulesObj.isPriceChange()) {
			System.out.println("<<<< Flight IsPriceChange Case >>>>>>");
			bookingRequest.setIsPriceChange(Boolean.valueOf(true));
		}
		else if (fareRulesObj.isFlightInvalid() || !fareRulesObj.isFlightChecked()) {
			System.out.println("<<<< Flight Sold Out Case >>>>>>");
			model.addAttribute("IsSoldOut", (Object)fareRulesObj.isFlightInvalid());
			bookingRequest.setIsSoldOut(Boolean.valueOf(true));
			model.addAttribute("airlineList", (Object)Utility.getAirlines());
			flightSearch.setOrigin((String)this.restService.getAirportList(flightReq.getSegment().get(0).getOriginAirport()).get(0));
			flightSearch.setDestination((String)this.restService.getAirportList(flightReq.getSegment().get(0).getDestinationAirport()).get(0));
			flightSearch.setTripType("1");
			if (flightReq.getTripType() == 2) {
				flightSearch.setTripType("2");
			}
			flightSearch.setDepartDate(bookingRequest.getDepartDate());
			flightSearch.setReturnDate(bookingRequest.getReturnDate());
			flightSearch.setCabin(Utility.getCabin((int)flightReq.getCabinType()));
			flightSearch.setAdult((int)bookingRequest.getAdults());
			flightSearch.setChild((int)bookingRequest.getChild());
			flightSearch.setInfant((int)bookingRequest.getInfants());
			flightSearch.setInfantWs((int)bookingRequest.getInfantsWs());
			try {
				model.addAttribute("searchString", (Object)new ObjectMapper().writeValueAsString((Object)flightSearch).replace("Int'l", "Intl"));
			}
			catch (JsonProcessingException e4) {
				e4.printStackTrace();
			}
			return "result";
		}
		final FlightResult selectedOrgflight = fareRulesObj.getFlightResult();
		final List<Airline> airline = (List<Airline>)fareRulesObj.getAirline();
		final List<Airport> airport = (List<Airport>)fareRulesObj.getAirport();
		for (int i = 0; i < selectedOrgflight.getOutBound().size(); ++i) {
			for (int j = 0; j < airline.size(); ++j) {
				if (selectedOrgflight.getOutBound().get(i).getAirline().equalsIgnoreCase(airline.get(j).getCode())) {
					selectedOrgflight.getOutBound().get(i).setAirlineName(airline.get(j).getName());
				}
			}
			for (int j = 0; j < airport.size(); ++j) {
				if (airport.get(j).getAirportCode().equalsIgnoreCase(selectedOrgflight.getOutBound().get(i).getFromAirport())) {
					selectedOrgflight.getOutBound().get(i).setFromAirportName(airport.get(j).getAirportName());
					selectedOrgflight.getOutBound().get(i).setFroCityName(airport.get(j).getCityName());
				}
				if (airport.get(j).getAirportCode().equalsIgnoreCase(selectedOrgflight.getOutBound().get(i).getToAirport())) {
					selectedOrgflight.getOutBound().get(i).setToAirportName(airport.get(j).getAirportName());
					selectedOrgflight.getOutBound().get(i).setToCityName(airport.get(j).getCityName());
				}
			}
		}
		if (selectedOrgflight.getInBound() != null) {
			for (int i = 0; i < selectedOrgflight.getInBound().size(); ++i) {
				for (int j = 0; j < airline.size(); ++j) {
					if (selectedOrgflight.getInBound().get(i).getAirline().equalsIgnoreCase(airline.get(j).getCode())) {
						selectedOrgflight.getInBound().get(i).setAirlineName(airline.get(j).getName());
					}
				}
				for (int j = 0; j < airport.size(); ++j) {
					if (airport.get(j).getAirportCode().equalsIgnoreCase(selectedOrgflight.getInBound().get(i).getFromAirport())) {
						selectedOrgflight.getInBound().get(i).setFromAirportName(airport.get(j).getAirportName());
						selectedOrgflight.getInBound().get(i).setFroCityName(airport.get(j).getCityName());
					}
					if (airport.get(j).getAirportCode().equalsIgnoreCase(selectedOrgflight.getInBound().get(i).getToAirport())) {
						selectedOrgflight.getInBound().get(i).setToAirportName(airport.get(j).getAirportName());
						selectedOrgflight.getInBound().get(i).setToCityName(airport.get(j).getCityName());
					}
				}
			}
		}
		if (selectedOrgflight.getOtherBound() != null) {
			for (int i = 0; i < selectedOrgflight.getOtherBound().size(); ++i) {
				for (int j = 0; j < selectedOrgflight.getOtherBound().get(i).size(); ++j) {
					for (int a = 0; a < airline.size(); ++a) {
						if (selectedOrgflight.getOtherBound().get(i).get(j).getAirline().equalsIgnoreCase(airline.get(a).getCode())) {
							selectedOrgflight.getOtherBound().get(i).get(j).setAirlineName(airline.get(a).getName());
						}
					}
					for (int a = 0; a < airport.size(); ++a) {
						if (airport.get(a).getAirportCode().equalsIgnoreCase(selectedOrgflight.getOtherBound().get(i).get(j).getFromAirport())) {
							selectedOrgflight.getOtherBound().get(i).get(j).setFromAirportName(airport.get(a).getAirportName());
							selectedOrgflight.getOtherBound().get(i).get(j).setFroCityName(airport.get(a).getCityName());
						}
						if (airport.get(a).getAirportCode().equalsIgnoreCase(selectedOrgflight.getOtherBound().get(i).get(j).getToAirport())) {
							selectedOrgflight.getOtherBound().get(i).get(j).setToAirportName(airport.get(a).getAirportName());
							selectedOrgflight.getOtherBound().get(i).get(j).setToCityName(airport.get(a).getCityName());
						}
					}
				}
			}
		}
		bookingRequest.setFlightResult(selectedOrgflight);
		final ArrayList<String> title = new ArrayList<String>();
		title.add("Title");
		title.add("Mr");
		title.add("Mrs");
		title.add("Miss");
		title.add("Dr");
		final ArrayList<String> gender = new ArrayList<String>();
		gender.add("Select Gender");
		gender.add("Male");
		gender.add("Female");
		final ArrayList<String> month = new ArrayList<String>();
		final String[] shortMonths = new DateFormatSymbols().getShortMonths();
		month.add("Month");
		for (int k = 0; k < shortMonths.length - 1; ++k) {
			final String shortMonth = shortMonths[k];
			month.add(shortMonth);
		}
		final ArrayList<String> days = new ArrayList<String>();
		days.add("Day");
		for (int l = 1; l < 32; ++l) {
			days.add(String.valueOf(l));
		}
		final ArrayList<String> year = new ArrayList<String>();
		int years = Calendar.getInstance().get(1) - 11;
		year.add("Year");
		for (int m = years; m > years - 100; --m) {
			year.add(String.valueOf(m));
		}
		final ArrayList<String> childyear = new ArrayList<String>();
		final int chyears = Calendar.getInstance().get(1) - 2;
		childyear.add("Year");
		for (int i2 = chyears; i2 > chyears - 11; --i2) {
			childyear.add(String.valueOf(i2));
		}
		final ArrayList<String> infyear = new ArrayList<String>();
		final int infyears = Calendar.getInstance().get(1);
		infyear.add("Year");
		for (int i3 = infyears; i3 > infyears - 3; --i3) {
			infyear.add(String.valueOf(i3));
		}
		final ArrayList<String> cardyear = new ArrayList<String>();
		years = Calendar.getInstance().get(1);
		cardyear.add("Year");
		for (int i4 = years; i4 < years + 50; ++i4) {
			cardyear.add(String.valueOf(i4));
		}
		final ArrayList<String> cardMonth = new ArrayList<String>();
		final String[] longMonths = new DateFormatSymbols().getMonths();
		cardMonth.add("Month");
		cardMonth.add("Jan (01)");
		cardMonth.add("Feb (02)");
		cardMonth.add("Mar (03)");
		cardMonth.add("Apr (04)");
		cardMonth.add("May (05)");
		cardMonth.add("Jun (06)");
		cardMonth.add("Jul (07)");
		cardMonth.add("Aug (08)");
		cardMonth.add("Sep (09)");
		cardMonth.add("Oct (10)");
		cardMonth.add("Nov (11)");
		cardMonth.add("Dec (12)");
		final ArrayList<String> cardtype = new ArrayList<String>();
		cardtype.add("Select a Card");
		cardtype.add("Visa");
		cardtype.add("Master Card");
		cardtype.add("American Express");
		cardtype.add("Diners Club");
		cardtype.add("Discover");
		cardtype.add("Carte Blanche");
		final HashMap<String, ArrayList<String>> models = new HashMap<String, ArrayList<String>>();
		models.put("title", title);
		models.put("days", days);
		models.put("month", month);
		models.put("year", year);
		models.put("chyear", childyear);
		models.put("infyear", infyear);
		models.put("cardyear", cardyear);
		models.put("cardMonth", cardMonth);
		models.put("cardtype", cardtype);
		models.put("gender", gender);
		model.mergeAttributes((Map)models);
		try {
			System.out.println("FlightsMetaController::Meta Booking Request For Payment Page::" + mapper.writeValueAsString((Object)bookingRequest));
		}
		catch (JsonProcessingException e5) {
			e5.printStackTrace();
		}
		request.getSession().setAttribute("bookingRequest", (Object)bookingRequest);
		request.getSession().setAttribute("selectedflight", (Object)selectedOrgflight);
		model.addAttribute("searchRequest", (Object)flightReq);
		model.addAttribute("bookingRequest", (Object)bookingRequest);
		return "payment";
	}

	@GetMapping({ "/deeplink/result/{source}/{deeplinkId}/{flightId}" })
	public String paymentMetaPage(@PathVariable final String source, @PathVariable final String deeplinkId, @PathVariable final String flightId, @ModelAttribute BookingRequest bookingRequest, final Model model, final HttpServletRequest request) {
		System.out.println("FlightsMetaController::PaymentMetaPage Calling. manoj ."+source);
		String userBrowserDetails = "userBrowserDetails";
		String device = "";
		try {
			final UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
			userBrowserDetails = userAgent.getOperatingSystem() + "-" + userAgent.getBrowser() + "-" + userAgent.getBrowserVersion();
			device = userAgent.getOperatingSystem().getDeviceType().getName();
		}
		catch (Exception e3) {
			userBrowserDetails = request.getHeader("user-agent");
		}
		bookingRequest.setDevice(device);
		bookingRequest.setBrowser(userBrowserDetails);
		bookingRequest.setSearchID(deeplinkId);
		bookingRequest.setCacheLocation(flightId);
		String searchID = null;
		try {
			searchID = request.getParameter("marker");
		}
		catch (Exception e4) {
			searchID = null;
		}
		System.out.println("Before SearchID[Marker] :: " + searchID);
		if (searchID != null) {
			searchID = searchID;
		}
		else {
			searchID = Utility.getAlphaNumericString(16);
		}
		System.out.println("After SearchID[Marker] :: " + searchID);
		bookingRequest.setCurrencyCode(this.currency);
		bookingRequest.setUserSessionID(searchID);
		bookingRequest.setUserIP(request.getRemoteAddr());
		
		//bookingRequest.setSourceMedia(source);
		
		if(source.equalsIgnoreCase("jetcost"))
		{
			bookingRequest.setSourceMedia("jetcost");
		}
		else if(source.equalsIgnoreCase("jetcost"))
		{
			bookingRequest.setSourceMedia("jetcostMob");
		}
		else if(source.equalsIgnoreCase("jetrdr"))
		{
			bookingRequest.setSourceMedia("jetrdr");
		}
		
		bookingRequest.setCacheLocation(flightId);
		bookingRequest.setProdID("1");
		bookingRequest.setBookingID("0");
		//bookingRequest.setSourceMedia("jetcost");
		if(source.equalsIgnoreCase("jetcost"))
		{
			bookingRequest.setSourceMedia("jetcost");
		}
		else if(source.equalsIgnoreCase("jetcostMob"))
		{
			bookingRequest.setSourceMedia("jetcostMob");
		}
		else if(source.equalsIgnoreCase("jetrdr"))
		{
			bookingRequest.setSourceMedia("jetrdr");
		}
		
		bookingRequest = this.flightService.getMetaBookingRequest(bookingRequest);
		final ObjectMapper mapper = new ObjectMapper();
		final FlightResult selectedflight = bookingRequest.getFlightResult();
		final ArrayList<String> title = new ArrayList<String>();
		title.add("Title");
		title.add("Mr");
		title.add("Mrs");
		title.add("Miss");
		title.add("Dr");
		final ArrayList<String> gender = new ArrayList<String>();
		gender.add("Select Gender");
		gender.add("Male");
		gender.add("Female");
		final ArrayList<String> month = new ArrayList<String>();
		final String[] shortMonths = new DateFormatSymbols().getShortMonths();
		month.add("Month");
		for (int i = 0; i < shortMonths.length - 1; ++i) {
			final String shortMonth = shortMonths[i];
			month.add(shortMonth);
		}
		final ArrayList<String> days = new ArrayList<String>();
		days.add("Day");
		for (int j = 1; j < 32; ++j) {
			days.add(String.valueOf(j));
		}
		final ArrayList<String> year = new ArrayList<String>();
		int years = Calendar.getInstance().get(1) - 11;
		year.add("Year");
		for (int k = years; k > years - 100; --k) {
			year.add(String.valueOf(k));
		}
		final ArrayList<String> childyear = new ArrayList<String>();
		final int chyears = Calendar.getInstance().get(1) - 2;
		childyear.add("Year");
		for (int l = chyears; l > chyears - 11; --l) {
			childyear.add(String.valueOf(l));
		}
		final ArrayList<String> infyear = new ArrayList<String>();
		final int infyears = Calendar.getInstance().get(1);
		infyear.add("Year");
		for (int m = infyears; m > infyears - 3; --m) {
			infyear.add(String.valueOf(m));
		}
		final ArrayList<String> cardyear = new ArrayList<String>();
		years = Calendar.getInstance().get(1);
		cardyear.add("Year");
		for (int i2 = years; i2 < years + 50; ++i2) {
			cardyear.add(String.valueOf(i2));
		}
		final ArrayList<String> cardMonth = new ArrayList<String>();
		final String[] longMonths = new DateFormatSymbols().getMonths();
		cardMonth.add("Month");
		cardMonth.add("Jan (01)");
		cardMonth.add("Feb (02)");
		cardMonth.add("Mar (03)");
		cardMonth.add("Apr (04)");
		cardMonth.add("May (05)");
		cardMonth.add("Jun (06)");
		cardMonth.add("Jul (07)");
		cardMonth.add("Aug (08)");
		cardMonth.add("Sep (09)");
		cardMonth.add("Oct (10)");
		cardMonth.add("Nov (11)");
		cardMonth.add("Dec (12)");
		final ArrayList<String> cardtype = new ArrayList<String>();
		cardtype.add("Select a Card");
		cardtype.add("Visa");
		cardtype.add("Master Card");
		cardtype.add("American Express");
		cardtype.add("Diners Club");
		cardtype.add("Discover");
		cardtype.add("Carte Blanche");
		final HashMap<String, ArrayList<String>> models = new HashMap<String, ArrayList<String>>();
		models.put("title", title);
		models.put("days", days);
		models.put("month", month);
		models.put("year", year);
		models.put("chyear", childyear);
		models.put("infyear", infyear);
		models.put("cardyear", cardyear);
		models.put("cardMonth", cardMonth);
		models.put("cardtype", cardtype);
		models.put("gender", gender);
		model.mergeAttributes((Map)models);
		try {
			System.out.println("Meta Booking Request:" + mapper.writeValueAsString((Object)bookingRequest));
		}
		catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		final FlightRequest searchRequest = new FlightRequest();
		searchRequest.setAdults(bookingRequest.getAdults());
		searchRequest.setChild(bookingRequest.getChild());
		searchRequest.setInfants(bookingRequest.getInfants());
		searchRequest.setInfantsWs(bookingRequest.getInfantsWs());
		searchRequest.setSiteId(bookingRequest.getSiteID());
		searchRequest.setSearchID(searchID);
		searchRequest.setTripType(Integer.valueOf(1));
		final List<Segment> segment = new ArrayList<Segment>();
		final Segment departSegment = new Segment();
		departSegment.setOriginAirport(bookingRequest.getFlightResult().getOutBound().get(0).getFromAirport());
		departSegment.setDestinationAirport(bookingRequest.getFlightResult().getOutBound().get(bookingRequest.getFlightResult().getOutBound().size() - 1).getToAirport());
		departSegment.setTravelDate(Utility.googleDateformat(bookingRequest.getFlightResult().getOutBound().get(0).getDepDate().split("T")[0].toString()));
		segment.add(departSegment);
		try {
			if (bookingRequest.getFlightResult().getInBound().size() > 0) {
				final Segment returnSegment = new Segment();
				returnSegment.setOriginAirport(bookingRequest.getFlightResult().getInBound().get(0).getFromAirport());
				returnSegment.setDestinationAirport(bookingRequest.getFlightResult().getInBound().get(bookingRequest.getFlightResult().getInBound().size() - 1).getToAirport());
				returnSegment.setTravelDate(Utility.googleDateformat(bookingRequest.getFlightResult().getInBound().get(0).getDepDate().split("T")[0].toString()));
				segment.add(returnSegment);
				searchRequest.setTripType(Integer.valueOf(2));
			}
		}
		catch (Exception ex) {}
		searchRequest.setSegment(segment);
		searchRequest.setUserIP(bookingRequest.getUserIP());
		searchRequest.setDevice(bookingRequest.getDevice());
		
		 
		//searchRequest.setSource("jetcost");
		if(source.equalsIgnoreCase("jetcost"))
		{
			searchRequest.setSource("jetcost");
		}
		else if(source.equalsIgnoreCase("jetcostMob"))
		{
			searchRequest.setSource("jetcostMob");
		}
		else if(source.equalsIgnoreCase("jetrdr"))
		{
			searchRequest.setSource("jetrdr");
		}
		
		
		try {
			System.out.println("Meta Seach Request:" + mapper.writeValueAsString((Object)searchRequest));
		}
		catch (JsonProcessingException e2) {
			e2.printStackTrace();
		}
		request.getSession().setAttribute("bookingRequest", (Object)bookingRequest);
		request.getSession().setAttribute("selectedflight", (Object)selectedflight);
		request.getSession().setAttribute("flightRequest", (Object)searchRequest);
		model.addAttribute("bookingRequest", (Object)bookingRequest);
		return "payment";
	}
}