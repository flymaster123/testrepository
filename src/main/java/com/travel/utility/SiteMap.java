package com.travel.utility;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.travel.object.Pages;
import com.travel.object.sitmapdata.AllAirlines;

public class SiteMap {

public void getSitemap(HttpServletRequest request){
	RestTemplate rest = new RestTemplate();
	ObjectMapper mapper = new ObjectMapper(); 
	Pages reqObj=new Pages();
	reqObj.setSiteId("4"); 
	reqObj.setPageType("Airline");
	String airlinePage=rest.postForObject("http://44.235.26.108/content/sitemap?authcode=ebooktrip",reqObj,String.class);
	AllAirlines allAirlines=null;
	try{
		allAirlines = mapper.readValue(airlinePage, AllAirlines.class);
	}
	catch(Exception e){
	e.printStackTrace();
	}
	request.getSession().setAttribute("airlineMap", allAirlines.getResponse());
	
	reqObj.setSiteId("4"); 
	reqObj.setPageType("City");  
	 airlinePage=rest.postForObject("http://44.235.26.108/content/sitemap?authcode=ebooktrip",reqObj,String.class);
	AllAirlines allCity=null;
	try{
		allCity = mapper.readValue(airlinePage, AllAirlines.class);
	}
	catch(Exception e){
	e.printStackTrace();
	}
	request.getSession().setAttribute("cityMap", allCity.getResponse());
	
	reqObj.setSiteId("4");
	reqObj.setPageType("Genric");
	 airlinePage=rest.postForObject("http://44.235.26.108/content/sitemap?authcode=ebooktrip",reqObj,String.class);
	AllAirlines allGenric=null;
	try{
		allGenric = mapper.readValue(airlinePage, AllAirlines.class);
	}
	catch(Exception e){ 
	e.printStackTrace();
	}
	request.getSession().setAttribute("genericMap", allGenric.getResponse());
}
}
