package com.travel.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.travel.bean.FlightSearch;
import com.travel.object.pagerequest.PageRequest;
import com.travel.object.pageresponse.PageResponse;
import com.travel.object.review.ReviewRequest;
import com.travel.object.review.ReviewResponse;
import com.travel.service.RestDataService;
import com.travel.utility.Utility;

@Controller
public class PageControllerLowTickets
{
    @Value("${pageApiUrl}")
    private String pageApiUrl;
    @Value("${apiUrl}")
    private String apiUrl;
    @Value("${siteName}")
    private String siteName;
    @Value("${siteId}")
    private int siteId;
    @Autowired
    private RestDataService restService;
    @Autowired
    MailController mailService;
    
    @GetMapping({ "/destination/cheap-flights-from-{page}" })
    public String citiestodesc(@PathVariable("page") final String page, @ModelAttribute final FlightSearch flightSearch, @ModelAttribute final ReviewRequest reviewRequest, final Model model) {
        model.addAttribute("airlineList", (Object)Utility.getAirlines());
        System.out.println("PagesController::Routes::Pagevalue>>" + page);
        final String code = page.split("-")[1];
        final String pageName = page.split("-")[0];
        System.out.println("code and page name is :---" + code + "-------" + pageName);
        final PageRequest pageRequest = new PageRequest();
        PageResponse pageResponse = new PageResponse();
        final RestTemplate rest = new RestTemplate();
        final ObjectMapper mapper = new ObjectMapper();
        pageRequest.setPageType("Genric");
        pageRequest.setPageValue(code.toLowerCase());
        pageRequest.setSiteId("4");
        pageRequest.setUrl(page);
        try {
            System.out.println(" Route==PageRequest:: " + mapper.writeValueAsString((Object)pageRequest));
        }
        catch (Exception ex) {}
        final String res = (String)rest.postForObject(String.valueOf(String.valueOf(this.pageApiUrl)) + "/showcontent?authcode=ebooktrip", (Object)pageRequest, (Class)String.class, new Object[0]);
        System.out.println("Route==PageResponse:: " + res);
        try {
            pageResponse = (PageResponse)mapper.readValue(res, (Class)PageResponse.class);
        }
        catch (JsonParseException e) {
            e.printStackTrace();
        }
        catch (JsonMappingException e2) {
            e2.printStackTrace();
        }
        catch (IOException e3) {
            e3.printStackTrace();
        }
        if (pageResponse.getBaseResponse().getStatus() == 1) {
            System.out.println(" <<<<<<  Getting Status == 11  >>>>>>");
            model.addAttribute("pageResponse", pageResponse.getResponse().get(0));
            model.addAttribute("page", (Object)pageName);
            flightSearch.setDestination((String)this.restService.getAirportList(code).get(0));
            final ReviewRequest reviewReq = new ReviewRequest();
            reviewReq.setSiteId("4");
            reviewReq.setReviewUrl(page);
            final String reviewRes = (String)rest.postForObject(String.valueOf(String.valueOf(this.pageApiUrl)) + "/reviewbyurl?authcode=ebooktrip", (Object)reviewReq, (Class)String.class, new Object[0]);
            System.out.println("Review Response :: " + reviewRes);
            ReviewResponse reviewResponse = new ReviewResponse();
            try {
                reviewResponse = (ReviewResponse)mapper.readValue(reviewRes, (Class)ReviewResponse.class);
            }
            catch (IOException e4) {
                e4.printStackTrace();
            }
            for (int i = 0; i < reviewResponse.getResponse().size(); ++i) {
                reviewResponse.getResponse().get(i).setReviewUrl(Utility.getDayHHMMDiff(reviewResponse.getResponse().get(i).getReviewDate(), new Date()));
            }
            model.addAttribute("reviewResponse", (Object)reviewResponse.getResponse());
        }
        else {
            System.out.println(" <<<<<<  Getting Status == 00  >>>>>>");
            final List<com.travel.object.pageresponse.Response> response = new ArrayList<com.travel.object.pageresponse.Response>();
            pageResponse.setResponse((List)response);
            model.addAttribute("pageResponse", pageResponse.getResponse().get(0));
            model.addAttribute("page", (Object)pageName);
        }
        return "cities-to";
    }
}