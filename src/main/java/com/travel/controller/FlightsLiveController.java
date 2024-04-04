package com.travel.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.travel.object.bookingrequest.BookingRequest;
import com.travel.object.liveresult.LiveResultResponse;
import com.travel.service.FlightService;
import com.travel.service.RestDataService;

@Controller
public class FlightsLiveController
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
    
    @GetMapping({ "/flight/livelink/{searchId}/{resultId}/{star}/{comment}" })
    @ResponseBody
    public String selectCustomerPage(@PathVariable final String searchId, @PathVariable final int resultId, @PathVariable final int star, @PathVariable final String comment, @ModelAttribute final BookingRequest bookingRequest, final Model model, final HttpServletRequest request) {
        bookingRequest.setBookingID(String.valueOf(resultId));
        bookingRequest.setSearchID(searchId);
        bookingRequest.setSourceMedia("flight");
        String apiUrls = String.valueOf(this.flightAPiUrl) + "/customerRequests?authcode=varunfirstapi2020";
        System.out.println("apiUrls:" + apiUrls);
        final RestTemplate restTemplate = new RestTemplate();
        String bookingRes = (String)restTemplate.postForObject(apiUrls, (Object)bookingRequest, (Class)String.class, new Object[0]);
        System.out.println("BookingRequest response : " + bookingRes);
        final ObjectMapper mapper = new ObjectMapper();
        LiveResultResponse liveResponse = new LiveResultResponse();
        try {
            liveResponse = (LiveResultResponse)mapper.readValue(bookingRes, (Class)LiveResultResponse.class);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        for (int i = 0; i < liveResponse.getLiveflightResult().size(); ++i) {
            if (liveResponse.getLiveflightResult().get(i).getResultID() == star) {
                if (comment.equalsIgnoreCase("x")) {
                    if (liveResponse.getLiveflightResult().get(i).getConsId().equalsIgnoreCase("1")) {
                        System.out.println("inside");
                        liveResponse.getLiveflightResult().get(i).setConsId("0");
                    }
                    else {
                        liveResponse.getLiveflightResult().get(i).setConsId("1");
                    }
                }
                else {
                    liveResponse.getLiveflightResult().get(i).setBookingToken(comment);
                }
            }
        }
        liveResponse.setBookingID(Integer.valueOf(resultId));
        liveResponse.setSearchID(searchId);
        liveResponse.setSourceMedia("1");
        try {
            System.out.println("get query:" + mapper.writeValueAsString((Object)liveResponse));
        }
        catch (JsonProcessingException e2) {
            e2.printStackTrace();
        }
        apiUrls = String.valueOf(this.flightAPiUrl) + "/CustomerLink?authcode=varunfirstapi2020";
        bookingRes = (String)restTemplate.postForObject(apiUrls, (Object)liveResponse, (Class)String.class, new Object[0]);
        System.out.println("booking response : " + bookingRes);
        return "ok";
    }
}
