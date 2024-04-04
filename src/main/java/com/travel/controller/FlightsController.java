package com.travel.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.text.DateFormatSymbols;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.travel.bean.Child;
import com.travel.bean.FlightSearch;
import com.travel.bean.HotelSearch;
import com.travel.bean.Room;
import com.travel.object.bookingrequest.AncillaryService;
import com.travel.object.bookingrequest.BookingRequest;
import com.travel.object.bookingrequest.PassengerDetail;
import com.travel.object.bookingrequest.ancillaryServices.AncillaryProduct;
import com.travel.object.bookingrequest.ancillaryServices.Services;
import com.travel.object.bookingresponse.BookingResponse;
import com.travel.object.checkFareRulesResponse.CheckFareRulesResponse;
import com.travel.object.checkFareRulesResponse.FareFamily;
import com.travel.object.email.EmailFormat;
import com.travel.object.fareRules.CheckFareRules;
import com.travel.object.flightresponse.Airline;
import com.travel.object.flightresponse.Airport;
import com.travel.object.flightresponse.FlightResponse;
import com.travel.object.flightresponse.FlightResult;
import com.travel.object.searchRequest.FlightRequest;
import com.travel.object.searchRequest.Segment;
import com.travel.service.FlightService;
import com.travel.service.RestDataService;
import com.travel.utility.Emails;
import com.travel.utility.Utility;
import eu.bitwalker.useragentutils.UserAgent;

@Controller
public class FlightsController 
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
	
	@GetMapping("/")
	public String welcomePage(@ModelAttribute FlightSearch flightSearch, @ModelAttribute HotelSearch hotelSearch,Model model){
		model.addAttribute("airlineList", Utility.getAirlines());

		List<Room> rooms = new ArrayList<Room>();	

		for (int i = 0; i < 5; i++) {

			Room room=new Room();

			List<Child> children=new ArrayList<Child>();
			for (int j = 0; j < 5; j++) {
				Child childs =new Child();
				childs.setRef(j);
				children.add(childs);

			}
			room.setChildren(children);
			rooms.add(room);

		}
		
		hotelSearch.setRooms(rooms);
		model.addAttribute("dealList", flightService.getDealList());
		
		/*try
		{
			File catalinaBase = new File(System.getProperty("catalina.base")).getAbsoluteFile();
			System.out.println("catalinaBase::"+catalinaBase.toString());
			File propertyFile = new File(catalinaBase, "webapps/ROOT/WEB-INF/route-list.xlsx");
			RouteListFileReader reader = new RouteListFileReader();
			reader.readFromExcelFile(propertyFile.getAbsolutePath());
		}catch(Exception e){
			e.printStackTrace();
		}*/
		
		return "index";
	}

	/*@GetMapping("/cheap-flights")
	public String cheapFlights(@ModelAttribute FlightSearch flightSearch,@ModelAttribute HotelSearch hotelSearch, Model model){
		model.addAttribute("airlineList", Utility.getAirlines());

		List<Room> rooms = new ArrayList<Room>();	

		for (int i = 0; i < 5; i++) {

			Room room=new Room(); 

			List<Child> children=new ArrayList<Child>();
			for (int j = 0; j < 5; j++) {
				Child childs =new Child();
				childs.setRef(j);
				children.add(childs);

			}
			room.setChildren(children);
			rooms.add(room);

		}

		hotelSearch.setRooms(rooms);

		return "index";
	}*/

	@PostMapping("/flight-listing/{searchId}")
	public String resultPage(@ModelAttribute FlightSearch flightSearch, @PathVariable String searchId, HttpServletRequest request, Model model){
		ObjectMapper mapper = new ObjectMapper();
		FlightRequest flightReq = flightService.getFlightSearchRequest(flightSearch, request, searchId);
		try
		{
			System.out.println("Search Request:"+mapper.writeValueAsString(flightReq));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		//System.out.println(flightService.getFlightSearchResponse(flightReq));
		request.getSession().setAttribute("flightRequest", flightReq);
		request.getSession().setAttribute("flightSearch", flightSearch);
		model.addAttribute("airlineList", Utility.getAirlines());
		try {
			model.addAttribute("searchString", new ObjectMapper().writeValueAsString(flightSearch).replace("Int'l", "Intl"));
		} catch (JsonProcessingException e) {
			
			e.printStackTrace();
		}
		return "result";
	}
	
	@GetMapping("/flight-listing/{searchId}")
	public String flightListing(@ModelAttribute FlightSearch flightSearch,@PathVariable String searchId, HttpServletRequest request, Model model){
		flightSearch = (FlightSearch) request.getSession().getAttribute("flightSearch");
		model.addAttribute("airlineList", Utility.getAirlines());
		model.addAttribute("flightSearch", flightSearch);
		try 
		{
			model.addAttribute("searchString", new ObjectMapper().writeValueAsString(flightSearch).replace("Int'l", "Intl"));
		} catch (JsonProcessingException e) {
			
			e.printStackTrace();
		}
		return "result";
	}
	
	@RequestMapping(value = "/flight/payment/{searchId}/{resultId}", method = { RequestMethod.GET, RequestMethod.POST })
	public String paymentPage(@PathVariable String searchId,@PathVariable String resultId,@ModelAttribute BookingRequest bookingRequest,Model model,HttpServletRequest request){
		FlightRequest searchRequest = (FlightRequest) request.getSession().getAttribute("flightRequest");
		try{
		}
		catch(Exception e){
			 request.getSession().setAttribute("currencySymbol","$");
			 request.getSession().setAttribute("currencyValue",1);
		}
		FlightResponse flightResult=new FlightResponse();
		FlightResult selectedflight=new FlightResult();

		ObjectMapper mapper = new ObjectMapper();
        String partner = "";
		try {
			partner = (String)request.getSession().getAttribute("partner");
		} catch (Exception e) {
			partner = "";
		}
        System.out.println("payment partner :-- "+partner);
        model.addAttribute("partner", partner);
		if(searchId.equalsIgnoreCase("coremeta")){
			
			System.out.println("<<<<<<<<<<<<<<<< Comes From CoreMeta >>>>>>>>>>>>>> ");
			
			String deeplinkId=resultId.split("-")[0];
			String flightId=resultId.split("-")[1];
			String userBrowserDetails="userBrowserDetails";
			String device = "";
			try {
				UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
				userBrowserDetails=userAgent.getOperatingSystem()+"-"+userAgent.getBrowser()+"-"+userAgent.getBrowserVersion();
				device = userAgent.getOperatingSystem().getDeviceType().getName();
			} catch (Exception e1) {
				userBrowserDetails = request.getHeader("user-agent");
			}
			bookingRequest.setDevice(device);
			bookingRequest.setBrowser(userBrowserDetails);
			bookingRequest.setSearchID(deeplinkId);
			bookingRequest.setSourceMedia(searchId);
			bookingRequest.setCacheLocation(flightId);

			bookingRequest = flightService.getMetaBookingRequest(bookingRequest);
			bookingRequest.setCurrencyCode(currency);
			bookingRequest.setDevice(device);
			bookingRequest.setBrowser(userBrowserDetails);
			bookingRequest.setSearchID(deeplinkId);
			bookingRequest.setUserSessionID(deeplinkId);
			bookingRequest.setUserIP(request.getRemoteAddr());
			//bookingRequest.setSourceMedia(searchId);
			bookingRequest.setCacheLocation(flightId);
			bookingRequest.setProdID("1");
			bookingRequest.setBookingID("0");
			selectedflight=bookingRequest.getFlightResult();
			
			searchRequest.setAdults(bookingRequest.getAdults());
			searchRequest.setChild(bookingRequest.getChild());
			searchRequest.setInfants(bookingRequest.getInfants());
			searchRequest.setInfantsWs(bookingRequest.getInfantsWs());
			searchRequest.setSearchID(bookingRequest.getSearchID());
			searchRequest.setSiteId(bookingRequest.getSiteID());
			searchRequest.setSearchID(bookingRequest.getUserSessionID());
			
			List<Segment> segment = new ArrayList<Segment>();
			Segment departSegment = new Segment();
			
			departSegment.setOriginAirport(bookingRequest.getFlightResult().getOutBound().get(0).getFromAirport());
			departSegment.setDestinationAirport(bookingRequest.getFlightResult().getOutBound().get(bookingRequest.getFlightResult().getOutBound().size()-1).getToAirport());
			departSegment.setTravelDate(bookingRequest.getFlightResult().getOutBound().get(0).getDepDate().split("T")[0].toString());
			segment.add(departSegment);
			
			try {
				if(bookingRequest.getFlightResult().getInBound().size()>0){
					Segment returnSegment = new Segment();
					returnSegment.setOriginAirport(bookingRequest.getFlightResult().getInBound().get(0).getFromAirport());
					returnSegment.setDestinationAirport(bookingRequest.getFlightResult().getInBound().get(bookingRequest.getFlightResult().getInBound().size()-1).getToAirport());
					returnSegment.setTravelDate(bookingRequest.getFlightResult().getInBound().get(0).getDepDate().split("T")[0].toString());
					segment.add(returnSegment);
				}
			} catch (Exception e) {
			}
			
			
			searchRequest.setSegment(segment);
			request.getSession().setAttribute("flightRequest", searchRequest);
			
		}else{
				System.out.println("<<<<<<<<<<<<<<<< Comes From Website >>>>>>>>>>>>>> ");
			try 
			{
				flightResult = (FlightResponse) request.getSession().getAttribute("sessionFlightResponse");
				System.out.println("flightResultStr : " + flightResult); 
				//flightResult = mapper.readValue(flightResultStr, FlightResult.class);
			} 
			catch (Exception e1) {
				
				e1.printStackTrace();
			}
			
			for (int i = 0; i < flightResult.getFlightResult().size(); i++) {
				if(flightResult.getFlightResult().get(i).getResultID() == Integer.parseInt(resultId)){
					selectedflight=flightResult.getFlightResult().get(i);
				}
			}
			
			List<Airline> airline  = flightResult.getAirline();
			List<Airport> airport = flightResult.getAirport();
			for (int i = 0; i < selectedflight.getOutBound().size(); i++) {
				for (int j = 0; j < airline.size(); j++) {
					if(selectedflight.getOutBound().get(i).getAirline().equalsIgnoreCase(airline.get(j).getCode())){
						selectedflight.getOutBound().get(i).setAirlineName(airline.get(j).getName());
					}
				}
				for (int j = 0; j < airport.size(); j++) {
					if(airport.get(j).getAirportCode().equalsIgnoreCase(selectedflight.getOutBound().get(i).getFromAirport())){
						selectedflight.getOutBound().get(i).setFromAirportName(airport.get(j).getAirportName());
						selectedflight.getOutBound().get(i).setFroCityName(airport.get(j).getCityName());
					}
					if(airport.get(j).getAirportCode().equalsIgnoreCase(selectedflight.getOutBound().get(i).getToAirport())){
						selectedflight.getOutBound().get(i).setToAirportName(airport.get(j).getAirportName());
						selectedflight.getOutBound().get(i).setToCityName(airport.get(j).getCityName());
					}
				}
			}
			if(selectedflight.getInBound() != null){
				for (int i = 0; i < selectedflight.getInBound().size(); i++) {
					for (int j = 0; j < airline.size(); j++) {
						if(selectedflight.getInBound().get(i).getAirline().equalsIgnoreCase(airline.get(j).getCode())){
							selectedflight.getInBound().get(i).setAirlineName(airline.get(j).getName());
						}
					}
					for (int j = 0; j < airport.size(); j++) { 
						if(airport.get(j).getAirportCode().equalsIgnoreCase(selectedflight.getInBound().get(i).getFromAirport())){
							selectedflight.getInBound().get(i).setFromAirportName(airport.get(j).getAirportName());
							selectedflight.getInBound().get(i).setFroCityName(airport.get(j).getCityName());
						}
						if(airport.get(j).getAirportCode().equalsIgnoreCase(selectedflight.getInBound().get(i).getToAirport())){
							selectedflight.getInBound().get(i).setToAirportName(airport.get(j).getAirportName());
							selectedflight.getInBound().get(i).setToCityName(airport.get(j).getCityName());
						} 
					}
				}
			}
			
			selectedflight.setGdsType(2);  // added on 26March24
			
			CheckFareRules checkRules=new CheckFareRules();
			checkRules.setFlightResult(selectedflight);
			checkRules.setAdults(searchRequest.getAdults());
			checkRules.setChild(searchRequest.getChild());
			checkRules.setInfants(searchRequest.getInfants());
			checkRules.setInfantsWs(searchRequest.getInfantsWs());
			checkRules.setSiteID(searchRequest.getSiteId());
			checkRules.setCurrencyCode(searchRequest.getCurrencyCode());

			try {
				// get Search Request object as a json string
				String jsonStr = mapper.writeValueAsString(checkRules);
				System.out.println("Flight Controller::CheckRules JSON:: "+jsonStr);
			} catch (IOException e) {
				 
				e.printStackTrace();
			}
			
			String fareRules = flightService.getFlightFareRules(checkRules);
			System.out.println("FlightPaymentPageOne::Direct Payment FareRules Response:: " + fareRules);

			bookingRequest.setFlightResult(selectedflight);
			bookingRequest.setAdults(searchRequest.getAdults());
			bookingRequest.setChild(searchRequest.getChild());
			bookingRequest.setInfants(searchRequest.getInfants());
			bookingRequest.setInfantsWs(searchRequest.getInfantsWs());
			bookingRequest.setSearchID(searchRequest.getSearchID());
			bookingRequest.setSiteID(searchRequest.getSiteId());
			bookingRequest.setProdID("1");
			bookingRequest.setBookingID("0");
			bookingRequest.setUserSessionID(searchId);
			bookingRequest.setCurrencyCode(currency);
			bookingRequest.setBrowser(searchRequest.getBrowser());
			
		//	bookingRequest.setTravelAssistTaken(book);
			
			CheckFareRulesResponse checkRulesResponse = null;
			try 
			{
				checkRulesResponse = mapper.readValue(fareRules, CheckFareRulesResponse.class);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			String anclrStr = "";

			try
			{
				anclrStr = mapper.writeValueAsString(checkRulesResponse.getAncillaryServices());
			}catch(Exception e){}

			//System.out.println("FlightPaymentPageOne:: anclrStr"+anclrStr);

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

			String fareFamilyStr = "";
			List<FareFamily> fareFamilyList = null;
			try
			{
				fareFamilyStr = mapper.writeValueAsString(checkRulesResponse.getFareFamily());
			}catch(Exception e){}

			try
			{
				fareFamilyList = mapper.readValue(fareFamilyStr.toString(), new TypeReference<List<FareFamily>>(){});
			}catch (Exception e) {}

			try
			{
				System.out.println("FareFamilyList:: "+new ObjectMapper().writeValueAsString(fareFamilyList));
			}catch (Exception e) {}

			int familySize=0;
			try{
				familySize= fareFamilyList.size();
			}catch(Exception e){
				familySize=0;
			}

			List<FareFamily> fareFamilyListNew = new ArrayList<FareFamily>();
			FareFamily fareObject = new FareFamily();

			if(familySize>0){
				for (int f = 0; f < familySize; f++) {
					//System.out.println("############["+(f+1)+"] Start ##############");
					if(fareFamilyList.get(f).getFamilyNames().size()>1){
						if(fareFamilyList.get(f).getFamilyNames().get(0).equals(fareFamilyList.get(f).getFamilyNames().get(1))){

							System.out.println("["+(f+1)+"] Match Start ======>>"+fareFamilyList.get(f).getFamilyNames().get(0)+"======"+fareFamilyList.get(f).getFamilyNames().get(1));
							fareObject = fareFamilyList.get(f);
							//fareFamilyListNew = Arrays.asList(fareObject);
							fareFamilyListNew.add(fareObject);
							//System.out.println("############["+(f+1)+"] Match End ##############");
						}
					}else{
						System.out.println("["+(f+1)+"] Match Start ======>>"+fareFamilyList.get(f).getFamilyNames().get(0));
						fareObject = fareFamilyList.get(f);
						//fareFamilyListNew = Arrays.asList(fareObject);
						fareFamilyListNew.add(fareObject);
					}
					//System.out.println("############["+(f+1)+"] End ##############");
					bookingRequest.setFareFamily(fareFamilyListNew);
				}
			}

			try
			{
				System.out.println("FareFamilyListNew:: "+new ObjectMapper().writeValueAsString(bookingRequest.getFareFamily()));
			}catch (Exception e) {}

			//bookingRequest.setFareFamily(fareFamilyList);
			bookingRequest.setFreeTextLines(checkRulesResponse.getFreeTextLines());
			
			List<PassengerDetail> passengerDetails=new ArrayList<PassengerDetail>();
			for (int i = 0; i < searchRequest.getAdults(); i++) {
				PassengerDetail paxDetail=new PassengerDetail();
				paxDetail.setPassengerType(1);
				passengerDetails.add(paxDetail);
			}
			for (int i = 0; i < searchRequest.getChild(); i++) {
				PassengerDetail paxDetail=new PassengerDetail();
				paxDetail.setPassengerType(2);
				passengerDetails.add(paxDetail);
			}
			for (int i = 0; i < searchRequest.getInfants(); i++) {
				PassengerDetail paxDetail=new PassengerDetail();
				paxDetail.setPassengerType(3);
				passengerDetails.add(paxDetail);
			}
			for (int i = 0; i < searchRequest.getInfantsWs(); i++) {
				PassengerDetail paxDetail=new PassengerDetail();
				paxDetail.setPassengerType(4);
				passengerDetails.add(paxDetail);
			}
			
			bookingRequest.setPassengerDetails(passengerDetails);

		}
		
		ArrayList<String> title = new ArrayList<String>(); 
		title.add("Title"); 
		title.add("Mr"); 
		title.add("Mrs");  
		title.add("Miss"); 
		title.add("Dr"); 

		ArrayList<String> gender = new ArrayList<String>(); 

		gender.add("Select Gender");
		gender.add("Male"); 
		gender.add("Female"); 

		ArrayList<String> month = new ArrayList<String>(); 
		String[] shortMonths = new DateFormatSymbols().getShortMonths();
		month.add("Month");
		for (int i = 0; i < shortMonths.length-1; i++) {
			String shortMonth = shortMonths[i];
			month.add(shortMonth);
		}

		ArrayList<String> days = new ArrayList<String>();
		days.add("Day");
		for (int i = 1; i < 32; i++) {
			days.add(String.valueOf(i));
		}

		ArrayList<String> year = new ArrayList<String>(); 
		int years = Calendar.getInstance().get(Calendar.YEAR)-11;
		year.add("Year");
		for (int i = years; i > (years-100); i--) {
			year.add(String.valueOf(i));
		}


		ArrayList<String> childyear = new ArrayList<String>(); 
		int chyears = Calendar.getInstance().get(Calendar.YEAR)-2;
		childyear.add("Year");
		for (int i = chyears; i > (chyears-11); i--) {
			childyear.add(String.valueOf(i));
		}

		ArrayList<String> infyear = new ArrayList<String>(); 
		int infyears = Calendar.getInstance().get(Calendar.YEAR);
		infyear.add("Year");
		for (int i = infyears; i > (infyears-3); i--) {
			infyear.add(String.valueOf(i));
		}


		ArrayList<String> cardyear = new ArrayList<String>(); 
		years = Calendar.getInstance().get(Calendar.YEAR);
		cardyear.add("Year");
		for (int i = years; i < (years+50); i++) {
			cardyear.add(String.valueOf(i));
		}
		ArrayList<String> cardMonth = new ArrayList<String>(); 
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

		ArrayList<String> cardtype = new ArrayList<String>(); 
		cardtype.add("Select a Card");
		cardtype.add("Visa");
		cardtype.add("Master Card");
		cardtype.add("American Express");
		cardtype.add("Diners Club");
		cardtype.add("Discover");
		cardtype.add("Carte Blanche");

		HashMap<String, ArrayList<String>> models = new HashMap<String, ArrayList<String>>();  
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
		model.mergeAttributes(models);

		try 
		{
			System.out.println(" Direct Booking Request For Payment:: "+mapper.writeValueAsString(bookingRequest));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		request.getSession().setAttribute("bookingRequest", bookingRequest);
		request.getSession().setAttribute("selectedflight", selectedflight);
		model.addAttribute("searchRequest", searchRequest);
		model.addAttribute("bookingRequest", bookingRequest);
		return "payment";
	}

	@PostMapping("/flight/payment/confirm")
	public String flightPaymentMid(@ModelAttribute BookingRequest bookingRequest, HttpServletRequest request, Model model){

		System.out.println("<<<<<<<< FlightPaymentMid Calling >>>>>>>");

		FlightResult selectedflight=(FlightResult) request.getSession().getAttribute("selectedflight");
		FlightRequest searchRequest = (FlightRequest) request.getSession().getAttribute("flightRequest");
		ObjectMapper mapper = new ObjectMapper();
       /* String partner = "";
		try {
			partner = (String)request.getSession().getAttribute("partner");
		} catch (Exception e) {
			partner = "";
		}*/
        try {
			System.out.println("FlightPaymentMid::SelectedFlight From Session:: "+mapper.writeValueAsString(selectedflight));
			System.out.println("FlightPaymentMid::Booking Request From Session:: "+mapper.writeValueAsString(bookingRequest));
			System.out.println("FlightPaymentMid::SearchRequest Request From Session:: "+mapper.writeValueAsString(searchRequest));
		} 
		catch (JsonProcessingException e) {
			
			e.printStackTrace();
		}
        
        /****Code done on 26 March 24*****/
        
        int fareFamilySize=0;
		try
		{
			fareFamilySize = bookingRequest.getFareFamily().size();
		}catch(Exception e){
			fareFamilySize=0;
		}

		List<FareFamily> fareFamilyList = new ArrayList<FareFamily>();
		FareFamily familyObject = new FareFamily();
		if(fareFamilySize>0){
			for (int i = 0; i < fareFamilySize; i++) {
				if(bookingRequest.getFareFamily().get(i).getFareFamilyDescription().get(0).getDescription().contains(bookingRequest.getUpgradePlan())){
					System.out.println(" Contain now >> "+bookingRequest.getUpgradePlan()); 
					//fareFamily = (List<FareFamily>) bookingRequest.getFareFamily().get(i);
					familyObject = bookingRequest.getFareFamily().get(i);
					fareFamilyList.add(familyObject);
					selectedflight.setFareFamily(fareFamilyList); 
				}
			}
		}
		
		/*****End here****/

		bookingRequest.setFlightResult(selectedflight);
		bookingRequest.setAdults(searchRequest.getAdults());
		bookingRequest.setChild(searchRequest.getChild());
		bookingRequest.setInfants(searchRequest.getInfants());
		bookingRequest.setInfantsWs(searchRequest.getInfantsWs());
		bookingRequest.setSearchID(searchRequest.getSearchID());
		bookingRequest.setSiteID(searchRequest.getSiteId());
		bookingRequest.setBookingID("0"); 
		bookingRequest.setUserSessionID(searchRequest.getSearchID());
		request.getSession().setAttribute("bookingRequest", bookingRequest);
		model.addAttribute("bookingRequest", bookingRequest);
		return "flightmid";

	}

	@PostMapping("/flight/confirm/{sessionId}/{randomId}")
	public String flightConfirm(@ModelAttribute BookingRequest bookingRequest, @PathVariable String sessionId, @PathVariable String randomId, HttpServletRequest request, Model model){

		System.out.println(" Confirmation To Book Calling..... "); 

		FlightRequest searchRequest = (FlightRequest) request.getSession().getAttribute("flightRequest");
		bookingRequest=(BookingRequest) request.getSession().getAttribute("bookingRequest");

		ObjectMapper mapper = new ObjectMapper();
        String partner = "";
      		try {
      			partner = (String)request.getSession().getAttribute("partner");
      		} catch (Exception e) {
      			partner = "";
      		}
        try {
            System.out.println("Booking Request From Session::" + mapper.writeValueAsString((Object)bookingRequest));
       
		} catch (JsonProcessingException e) {
			
			e.printStackTrace();
		}

		bookingRequest.setSourceMedia(searchRequest.getSource());
		bookingRequest.setCurrencyCode("USD");
		bookingRequest.setSiteID(searchRequest.getSiteId());

		for (int i = 0; i < bookingRequest.getPassengerDetails().size(); i++) {
			String dateOfBirth = bookingRequest.getPassengerDetails().get(i).getDateOfYear()+"-"+bookingRequest.getPassengerDetails().get(i).getDateOfMonth()+"-"+bookingRequest.getPassengerDetails().get(i).getDobDay();
			bookingRequest.getPassengerDetails().get(i).setDateOfBirth(dateOfBirth);
		}
		
		bookingRequest.setUserIP(searchRequest.getUserIP());
		bookingRequest.setDevice(searchRequest.getDevice());
		bookingRequest.setDepartDate(searchRequest.getSegment().get(0).getTravelDate());
		bookingRequest.getFlightResult().setGdsType(2);
		
		/*ancillaries code start*/
		List<AncillaryProduct> ancillaryProductList = new ArrayList<AncillaryProduct>();
		
		try {
			if(bookingRequest.getTravelAssistTaken().equalsIgnoreCase("Yes")){
				List<AncillaryService> anclrList1 = bookingRequest.getAncillaryServices();
				for (int i = 0; i < anclrList1.size(); i++) {
					if(anclrList1.get(i).getSupplierCode().contains("TAS"))
					{
						AncillaryProduct ancillariesObj = new AncillaryProduct();
						List<Services> serviceList = new ArrayList<Services>();
						ancillariesObj.setMostPopular(anclrList1.get(i).getOwServiceText().get(0).getMostPopular());
						ancillariesObj.setFullName(anclrList1.get(i).getFullName());
						ancillariesObj.setName("TAS");
						ancillariesObj.setPrice(bookingRequest.getTravelAssistAmount());
						ancillariesObj.setProductId(anclrList1.get(i).getOwServiceText().get(0).getProductId());
						ancillariesObj.setSelectionType("Yes");
						ancillariesObj.setSupplierLookup("");
						ancillariesObj.setSupplierNumber("");
						ancillariesObj.setConditionList(serviceList);
						ancillaryProductList.add(ancillariesObj);
						bookingRequest.setAncillaryProduct(ancillaryProductList);
					}
				}
			}
		} catch (Exception e3) {
			
			//e3.printStackTrace();
		}
		
		
		try {
			if(bookingRequest.getPriceDropTaken().equalsIgnoreCase("Yes")){
				List<AncillaryService> anclrList2 = bookingRequest.getAncillaryServices();
				for (int i = 0; i < anclrList2.size(); i++) {
					if(anclrList2.get(i).getSupplierCode().contains("PDP"))
					{	
						AncillaryProduct ancillariesObj = new AncillaryProduct();
						List<Services> serviceList = new ArrayList<Services>();
						ancillariesObj.setMostPopular(anclrList2.get(i).getOwServiceText().get(0).getMostPopular());
						ancillariesObj.setFullName(anclrList2.get(i).getFullName());
						ancillariesObj.setName("PDP");
						ancillariesObj.setPrice(bookingRequest.getPriceDropAmount());
						ancillariesObj.setProductId(anclrList2.get(i).getOwServiceText().get(0).getProductId());
						ancillariesObj.setSelectionType("Yes");
						ancillariesObj.setSupplierLookup("");
						ancillariesObj.setSupplierNumber("");
						ancillariesObj.setConditionList(serviceList);
						ancillaryProductList.add(ancillariesObj);
						bookingRequest.setAncillaryProduct(ancillaryProductList);
					}
				}
			}
		} catch (Exception e2) {
			
			//e2.printStackTrace();
		}
		
		System.out.println("UpgradeTaken"+bookingRequest.getUpgradeTaken());
		if(bookingRequest.getUpgradeTaken().equalsIgnoreCase("Yes")){
			AncillaryProduct ancillariesObj = new AncillaryProduct();
			List<Services> serviceList = new ArrayList<Services>();
			ancillariesObj.setMostPopular(true);
			ancillariesObj.setFullName(bookingRequest.getUpgradePlan());
			ancillariesObj.setName("UP");
			ancillariesObj.setPrice(bookingRequest.getUpgradeAmount());
			ancillariesObj.setProductId(0);
			ancillariesObj.setSelectionType("Yes");
			ancillariesObj.setSupplierLookup("");
			ancillariesObj.setSupplierNumber("");
			ancillariesObj.setConditionList(serviceList);
			ancillaryProductList.add(ancillariesObj);
			bookingRequest.setAncillaryProduct(ancillaryProductList);
		}
		
		/*ancillaries code end*/
		try 
		{
			System.out.println("Booking Request Finally::" + mapper.writeValueAsString(bookingRequest));
		} 
		catch (JsonProcessingException e1) {
			e1.printStackTrace();
		}

		String apiUrls=flightAPiUrl+"/BookingProcess?authcode="+password;  
		RestTemplate restTemplate = new RestTemplate();
		String bookingRes= restTemplate.postForObject (apiUrls, bookingRequest,String.class);

		//String bookingRes="{\"bookingID\":\"EB2280\",\"PNR\":\"X\",\"flightResut\":{\"resultID\":4,\"valCarrier\":\"UA\",\"fareType\":\"RP\",\"gdsType\":2,\"cabinClass\":1,\"fare\":{\"adultFare\":53.959999999999994,\"childFare\":0.0,\"infantFare\":0.0,\"infantWsFare\":0.0,\"adultTax\":33.25,\"childTax\":0.0,\"infantTax\":0.0,\"infantWsTax\":0.0,\"adultMarkup\":50.0,\"childMarkup\":0.0,\"infantMarkup\":0.0,\"infantWsMarkup\":0.0,\"bagFees\":0.0,\"grandTotal\":137.20999999999998,\"markupID\":6,\"totalMarkup\":50.0,\"grandOrgTotal\":87.21,\"baseFare\":53.959999999999994,\"totalTax\":83.25,\"tbo_baseFare\":0.0,\"tbo_totalTax\":0.0,\"markupType\":\"us\"},\"outBound\":[{\"SequenceNumber\":\"0\",\"airline\":\"UA\",\"orgAirline\":\"UA\",\"flightID\":\"\",\"flightNo\":\"2604\",\"equipmentType\":\"320\",\"equipmentTypeDes\":\"\",\"fromAirport\":\"SFO\",\"depDate\":\"2022-05-12T06:00:00\",\"toAirport\":\"LAX\",\"reachDate\":\"2022-05-12T07:45:00\",\"opratingAirline\":\"UA\",\"resDesignCode\":\"N\",\"fromTerminal\":\"3\",\"toTerminal\":\"7\",\"cabinClass\":1,\"eft\":105,\"estimateTime\":105,\"layOverTime\":0,\"fareType\":\"RP\",\"isETicketEligible\":false,\"airlineName\":\"United Airlines\",\"fromAirportName\":\"San Francisco International Airport\",\"orgdepDate\":\"2022-05-12T06:00:00\",\"toAirportName\":\"Los Angeles International Airport\",\"orgreachDate\":\"2022-05-12T07:45:00\",\"froCityName\":\"San Francisco\",\"toCityName\":\"Los Angeles\"}],\"inBound\":[{\"SequenceNumber\":\"0\",\"airline\":\"UA\",\"orgAirline\":\"UA\",\"flightID\":\"\",\"flightNo\":\"2032\",\"equipmentType\":\"738\",\"equipmentTypeDes\":\"\",\"fromAirport\":\"LAX\",\"depDate\":\"2022-05-19T06:00:00\",\"toAirport\":\"SFO\",\"reachDate\":\"2022-05-19T07:28:00\",\"opratingAirline\":\"UA\",\"resDesignCode\":\"N\",\"fromTerminal\":\"7\",\"toTerminal\":\"3\",\"cabinClass\":1,\"eft\":88,\"estimateTime\":88,\"layOverTime\":0,\"fareType\":\"RP\",\"isETicketEligible\":false,\"airlineName\":\"United Airlines\",\"fromAirportName\":\"Los Angeles International Airport\",\"orgdepDate\":\"2022-05-19T06:00:00\",\"toAirportName\":\"San Francisco International Airport\",\"orgreachDate\":\"2022-05-19T07:28:00\",\"froCityName\":\"Los Angeles\",\"toCityName\":\"San Francisco\"}],\"booking_token\":\"\",\"consId\":\"\",\"outEFT\":105,\"inEFT\":88,\"maxSeat\":9,\"airline\":\"UA\"},\"adults\":1,\"child\":0,\"infants\":0,\"infantsWs\":0,\"paymentDetails\":{\"cardCode\":\"Visa\",\"cardNumber\":\"4111111111111111\",\"cardHolderName\":\"Bhavika\",\"expiryMonth\":\"2\",\"expiryYear\":\"2023\",\"cvvNo\":\"123\",\"country\":\"US\",\"address1\":\"san marine drive\",\"address2\":\"\",\"city\":\"sanjose\",\"state\":\",CA\",\"postalCode\":\"95123\",\"maskCardNumber\":\"************1111\"},\"passengerDetails\":[{\"passengerType\":1,\"firstName\":\"bhavika\",\"middleName\":\"\",\"lastName\":\"Singh\",\"dateOfBirth\":\"1994-3-14\",\"gender\":2,\"dobDay\":\"14\",\"dateOfMonth\":\"3\",\"dateOfYear\":\"1994\"}],\"ispriceChange\":false,\"newPrice\":0.0,\"isCcv\":false,\"bookingStatus\":\"Succeeded\",\"responseStatus\":{\"status\":0,\"messege\":\"AUTH FAILURE\"},\"IsTimeChanged\":false,\"isticketeRun\":0,\"isticketeRunRet\":0}";

		System.out.println("Booking Response : " + bookingRes);

		BookingResponse bookingResponse = null; 
		try{
			bookingResponse = mapper.readValue(bookingRes, BookingResponse.class);
			bookingRequest.setBookingID(bookingResponse.getBookingID());
			bookingRequest.setBookingStatus(bookingResponse.getBookingStatus()); 
		}
		catch(Exception e){

		}
			 
		model.addAttribute("bookingRequest", bookingRequest);
		request.getSession().setAttribute("bookingRequest", bookingRequest);
		
		System.out.println("ID : " + bookingRequest.getBookingID());
		System.out.println("PAX Email IS -- "+bookingRequest.getEmailID() + "---------------Next-------------"+bookingRequest.getEmailID1());
		
		Emails email = new Emails();
		String emailBody = email.buildFlightEmail(bookingRequest, searchRequest);
		//System.out.println("EmailBody>>"+emailBody);
		
		EmailFormat emailSend = new EmailFormat();
		emailSend.setFromEmail("bookings@lowtickets.com");
        emailSend.setToEmail(bookingRequest.getEmailID());
        emailSend.setCcEmail("bookings@lowtickets.com");
        emailSend.setBookingID(bookingRequest.getBookingID());
		emailSend.setMailBody(emailBody);
		emailSend.setMailSubject("Your Flight Booking ID "+bookingRequest.getBookingID()+" From Lowtickets.com");
		
		try 
		{
			mailService.SendMail(emailSend, "smtp.gmail.com", "465", "Bhavika@1187");
		} 
		catch (IOException e) {
			
			e.printStackTrace();
		} catch (URISyntaxException e) {
			
			e.printStackTrace();
		}
		model.addAttribute("searchRequest", searchRequest);	
		model.addAttribute("bookingRequest", bookingRequest);
		request.getSession().setAttribute("bookingRequest", bookingRequest);
		return "confirmation";
	}
	
	@GetMapping("/flight/confirm/{sessionId}/{randomId}")
	public String flightConfirmGet(@ModelAttribute BookingRequest bookingRequest, @PathVariable String sessionId, @PathVariable String randomId, HttpServletRequest request, Model model){
		bookingRequest = (BookingRequest) request.getSession().getAttribute("bookingRequest");
		FlightRequest searchRequest = (FlightRequest) request.getSession().getAttribute("flightRequest");
		model.addAttribute("bookingRequest", bookingRequest);
		model.addAttribute("searchRequest", searchRequest);
		return "confirmation";
	}

}