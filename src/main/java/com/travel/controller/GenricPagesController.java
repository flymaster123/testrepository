package com.travel.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.travel.bean.FlightSearch;
import com.travel.bean.HotelSearch;
import com.travel.object.pagerequest.PageRequest;
import com.travel.object.pageresponse.PageResponse;
import com.travel.object.review.ReviewRequest;
import com.travel.object.review.ReviewResponse;
import com.travel.service.RestDataService;
import com.travel.utility.Utility;

@Controller
public class GenricPagesController {
	
	@Value("${pageApiUrl}")
	private String pageApiUrl;
	
	@Value("${apiUrl}")
	private String apiUrl;
	
	@Autowired
	private RestDataService restService;
	
	
	@GetMapping("/genric/{page}")
	public String Genric(@PathVariable("page") String page,@ModelAttribute FlightSearch flightSearch,@ModelAttribute HotelSearch hotelSearch,@ModelAttribute ReviewRequest reviewRequest,Model model){
		model.addAttribute("airlineList", Utility.getAirlines());
		PageRequest pageRequest = new PageRequest();
		PageResponse pageResponse = new PageResponse();
		RestTemplate rest = new RestTemplate();
		ObjectMapper mapper = new ObjectMapper();
		String code = page.substring(page.lastIndexOf("-")+1, page.length());
		String url = page.substring(0,page.lastIndexOf("-"));
		pageRequest.setPageType("Genric");
		pageRequest.setPageValue("");
		pageRequest.setSiteId("4"); 
		pageRequest.setUrl(page);
		try {
			System.out.println(mapper.writeValueAsString(pageRequest));
		} catch (JsonProcessingException e1) {
			
			e1.printStackTrace();
		}
		String res = rest.postForObject(pageApiUrl+"/showcontent?authcode=ABCD26S20", pageRequest, String.class);
		System.out.println(res);
		try {
			pageResponse = mapper.readValue(res, PageResponse.class);
		} catch (JsonParseException e) {
			
			e.printStackTrace();
		} catch (JsonMappingException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		if(pageResponse.getResponse().size() == 0){
			return "redirect:/";
		}
		model.addAttribute("pageResponse", pageResponse.getResponse().get(0));
		flightSearch.setPageAirline(code.toUpperCase());
		
		ReviewRequest reviewReq = new ReviewRequest();
		reviewReq.setSiteId("3");
		reviewReq.setReviewUrl(page);
		String reviewRes = rest.postForObject(pageApiUrl+"/reviewbyurl?authcode=ABCD26S20", reviewReq, String.class);
		System.out.println("reviewRes : " + reviewRes);
		ReviewResponse reviewResponse = new ReviewResponse();
		try {
			reviewResponse = mapper.readValue(reviewRes, ReviewResponse.class);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		for (int i = 0; i < reviewResponse.getResponse().size(); i++) {
			reviewResponse.getResponse().get(i).setReviewUrl(Utility.getDayHHMMDiff(reviewResponse.getResponse().get(i).getReviewDate(), new Date()));
		}
		model.addAttribute("reviewResponse", reviewResponse.getResponse());
		
		return "airlines";
	}
	
	@RequestMapping(value = { "/currency/save" }, method = { RequestMethod.POST })
    @ResponseBody
    public String saveHosting(@RequestParam final String countryName, @RequestParam final String currency, final HttpServletRequest request) {
        System.out.println("currency---Ajax-" + currency);
        if (currency.equalsIgnoreCase("EUR")) {
            request.getSession().setAttribute("currency", currency);
            request.getSession().setAttribute("userCurrency", currency);
            request.getSession().setAttribute("tfnNum", "+1(888)888-8888");
        }
        else {
            request.getSession().setAttribute("currency", currency);
            request.getSession().setAttribute("userCurrency", currency);
            request.getSession().setAttribute("tfnNum", "+1(888)888-8888");
        }
        return "";
    }
}
