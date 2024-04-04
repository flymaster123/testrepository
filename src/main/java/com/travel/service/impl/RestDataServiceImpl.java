package com.travel.service.impl;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.travel.object.Location;
import com.travel.object.SubscribeRequest;
import com.travel.object.currency.CurrencyRequest;
import com.travel.object.currency.CurrencyResponse;
import com.travel.object.farealert.FareAlert;
import com.travel.object.farealert.FareAlertRequest;
import com.travel.service.RestDataService;

@Service
public class RestDataServiceImpl implements RestDataService{

	@Value("${flightAPiUrl}")
	String flightAPiUrl;
	
	@Value("${siteName}")
	private String siteName;
	
	@Value("${siteId}")
	private int siteId;
	
	@Value("${apiUrl}")
	String apiUrl;
	
	@Value("${password}")
	private String password;
	
	RestTemplate rest = new RestTemplate();
	ObjectMapper mapper = new ObjectMapper(); 
	
	@Override
	public List<String> getAirportList(String searchterm) {
		
		String url=flightAPiUrl+"/AirportList?authcode="+password.trim()+"&data="+searchterm;
		System.out.println(url);
		String airporStr = rest.getForObject(url, String.class);
		List<String> airportList = new ArrayList<String>();
		try {
			Location[] locationList =  mapper.readValue(airporStr, Location[].class);
			//System.out.println(locationList.length);
			for (Location location : locationList) {
				airportList.add(location.getAirportCode()+"-"+location.getCityName()+", "+location.getAirportName()+"-"+location.getCountryCode());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return airportList;
	}

	@Override
	public void setNewsletterSubscription(String email) {
		
		Date d = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = format.format(d);
		SubscribeRequest reqObj=new SubscribeRequest();
		reqObj.setDate(dateString);
		reqObj.setEmailid(email);
		reqObj.setStatus("active");
		reqObj.setSiteId(siteId);
		reqObj.setUrl(siteName);
		System.out.println(rest.postForObject(apiUrl+"/backend/subscribe?authcode=Trav3103s987876",reqObj,String.class));
	}

	@Override
	public void setFareAlert(FareAlertRequest farealAlertRequest) {
	String res = 	rest.postForObject(apiUrl+"/fare-alert/addFareAlert?authcode=ABCD26S20", farealAlertRequest, String.class);
	System.out.println(res);
		
	}

	@Override
	public String getCurrencyResponse(HttpServletRequest request,String country) {
		String currRes = rest.postForObject("http://44.224.170.152/currency/getAllCurrency?authcode=ebooktrip",new CurrencyRequest(), String.class);
		System.out.println("currRes >>> " + currRes);
		CurrencyResponse currencyResponse = new CurrencyResponse();
		try {
			currencyResponse = mapper.readValue(currRes, CurrencyResponse.class);
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String currencySymbol = "$";
		String currencyValue = "1";
		if(country.equalsIgnoreCase("GB")){
			currencySymbol = "£";
			currencyValue = currencyResponse.getResponse().get(0).getUsdGbp();
		}
		else if(country.equalsIgnoreCase("CA")){
			currencySymbol = "CAD";
			currencyValue = currencyResponse.getResponse().get(0).getUsdCad();
		}
		else if(country.equalsIgnoreCase("MX")){
			currencySymbol = "MXD";
			currencyValue = currencyResponse.getResponse().get(0).getUsdMxn();
		}
		request.getSession().setAttribute("currencySymbol", currencySymbol);
		request.getSession().setAttribute("currencyValue", Double.valueOf(currencyValue));
		return currRes;
	}

}
