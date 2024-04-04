package com.travel.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.travel.object.farealert.FareAlertRequest;


public interface RestDataService {

	public List<String> getAirportList(String searchterm);
	public void setNewsletterSubscription(String email);
	public void setFareAlert(FareAlertRequest farealAlertRequest);
	public String getCurrencyResponse(HttpServletRequest request,String country);
}
