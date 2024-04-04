package com.travel.controller;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.travel.bean.ContactForm;
import com.travel.bean.FlightSearch;
import com.travel.object.SubscribeRequest;
import com.travel.object.blogs.BlogsRequest;
import com.travel.object.blogs.BlogsResponse;
import com.travel.object.deal.DealRequest;
import com.travel.object.deal.DealResponse;
import com.travel.object.email.EmailFormat;
import com.travel.object.faq.FaqDetail;
import com.travel.object.faq.FaqRequest;
import com.travel.object.newsletter.NewsletterRequest;
import com.travel.object.newsletter.NewsletterResponse;
import com.travel.object.pagerequest.PageRequest;
import com.travel.object.pageresponse.PageResponse;
import com.travel.object.review.Response;
import com.travel.object.review.ReviewRequest;
import com.travel.object.review.ReviewResponse;
import com.travel.service.FlightService;
import com.travel.service.RestDataService;
import com.travel.utility.Emails;
import com.travel.utility.SiteMap;
import com.travel.utility.SubscribeMail;
import com.travel.utility.Utility;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Controller
public class PagesController {
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
    @Autowired
    FlightService flightService;

    @GetMapping({"/faqs" })
    public String faqs() {
        return "faqs";
    }

    @GetMapping({"/contactus"})
    public String contactus(@ModelAttribute ContactForm contactForm) {
        return "contact-us";
    }

    @PostMapping({"/contactus/submit"})
    @ResponseBody
    public String contactusPost(@RequestBody ContactForm contactForm) {
        Emails email = new Emails();
        String emailBody = email.buildContactEmail(contactForm);
        System.out.println(emailBody);
        EmailFormat emailSend = new EmailFormat();
        emailSend.setBookingID("");
        emailSend.setFromEmail("bookings@lowtickets.com");
        emailSend.setToEmail("bookings@lowtickets.com");
        emailSend.setCcEmail("bookings@lowtickets.com");
        emailSend.setMailBody(emailBody);
        emailSend.setMailSubject("Contact Us Query " + contactForm.getLastName());
        String status = "false";

        try {
            status = this.mailService.SendMail(emailSend, "smtp.gmail.com", "465", "Bhavika@1187");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    @GetMapping({"/aboutus"})
    public String aboutus() {
        return "aboutus";
    }

    @GetMapping({"/terms-and-conditions"})
    public String termsandconditions() {
        return "terms-conditions";
    }

    @GetMapping({"/privacy-policy"})
    public String privacypolicy() {
        return "privacy-policy";
    }

    @GetMapping({"/sitemap"})
    public String sitemap(HttpServletRequest request) {
        SiteMap tc = new SiteMap();
        tc.getSitemap(request);
        return "sitemap";
    }

    @GetMapping({ "/deals-destinations" })
    public String dealsdestinations() {
        return "deals-destinations";
    }

    @GetMapping({"/checkin"})
    public String checkin() {
        return "checkin";
    }

    @GetMapping({"/baggage-fees"})
    public String baggagefees() {
        return "baggage-fees";
    }

    @GetMapping({"/newsletter"})
    public String newsletter() {
        return "newsletter";
    }

    @GetMapping({"/our-service-fees" })
    public String ourservices() {
        return "our-service-fees";
    }

    @GetMapping({"/taxes-fees"})
    public String taxesfees() {
        return "taxes-fees";
    }

    @GetMapping({"/testimonials" })
    public String testimonials() {
        return "testimonials";
    }

    @GetMapping({"/post-ticketing-fees"})
    public String postTktFees() {
        return "post-ticketing-fees";
    }

   @GetMapping({"/flights/{page}"})
   public String airlines(@PathVariable("page") String page, @ModelAttribute FlightSearch flightSearch, @ModelAttribute ReviewRequest reviewRequest, Model model) {
      model.addAttribute("airlineList", Utility.getAirlines());
      System.out.println("PagesController::Airline::Page Value:: " + page);
      PageRequest pageRequest = new PageRequest();
      PageResponse pageResponse = new PageResponse();
      RestTemplate rest = new RestTemplate();
      ObjectMapper mapper = new ObjectMapper();
      String code = page.substring(page.lastIndexOf("-") + 1, page.length());
      String url = page.substring(0, page.lastIndexOf("-"));
      pageRequest.setPageType("Airline");
      pageRequest.setPageValue(code.toLowerCase());
      pageRequest.setSiteId("4");
      pageRequest.setUrl(url);

      try {
         System.out.println("Airline PageRequest:: " + mapper.writeValueAsString(pageRequest));
      } catch (JsonProcessingException ex) {
         ex.printStackTrace();
      }

      String res = rest.postForObject(pageApiUrl + "/showcontent?authcode=ebooktrip", pageRequest, String.class);
      System.out.println("Airlines Content:: " + res);

      try {
         pageResponse = (PageResponse)mapper.readValue(res, PageResponse.class);
      } catch (JsonParseException ex) {
         ex.printStackTrace();
      } catch (JsonMappingException ex) {
         ex.printStackTrace();
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      if (pageResponse.getResponse().size() == 0) {
         return "redirect:/";
      } else {
         model.addAttribute("pageResponse", pageResponse.getResponse().get(0));
         flightSearch.setPageAirline(code.toUpperCase());
         ReviewRequest reviewReq = new ReviewRequest();
         reviewReq.setSiteId("1");
         reviewReq.setReviewUrl(page);
         String reviewRes = rest.postForObject(pageApiUrl + "/reviewbyurl?authcode=ebooktrip", reviewReq, String.class);
         System.out.println("reviewRes : " + reviewRes);
         ReviewResponse reviewResponse = new ReviewResponse();

         try {
            reviewResponse = (ReviewResponse)mapper.readValue(reviewRes, ReviewResponse.class);
         } catch (IOException ex) {
            ex.printStackTrace();
         }

         for(int i = 0; i < reviewResponse.getResponse().size(); ++i) {
            ((Response)reviewResponse.getResponse().get(i)).setReviewUrl(Utility.getDayHHMMDiff(((Response)reviewResponse.getResponse().get(i)).getReviewDate(), new Date()));
         }

         model.addAttribute("reviewResponse", reviewResponse.getResponse());
         DealRequest dealRequest = new DealRequest();
         dealRequest.setAirline(code.toUpperCase());
         dealRequest.setCabinClass("Y");
         dealRequest.setCityName("");
         dealRequest.setCountryCode("US");
         dealRequest.setCountryName("US");
         dealRequest.setCurrency("USD");
         dealRequest.setDepartDate("");
         dealRequest.setFroCity("");
         dealRequest.setPage("");
         dealRequest.setToCity("");
         dealRequest.setTripType("2");
         dealRequest.setSiteId("4");
         String dealResStr = rest.postForObject(this.apiUrl + "/travelsite/deals?authcode=ebooktrip", dealRequest, String.class);
         System.out.println("DealsRequest:: " + dealResStr);
         DealResponse dealResponse = null;
         List filterDealResponse = null;

         try {
            dealResponse = (DealResponse)mapper.readValue(dealResStr, DealResponse.class);
            filterDealResponse = dealResponse.getResponse().stream().filter((a) -> {
               return !a.getAirline().equals("DL");
            }).collect(Collectors.toList());
         } catch (IOException ex) {
            ex.printStackTrace();
         }

         model.addAttribute("filterDealResponse", filterDealResponse);
         String blogResponse = rest.postForObject(this.apiUrl + "/find/recentBlogs?authcode=ebooktrip", dealRequest, String.class);
         blogResponse = this.Spanish_Repair(blogResponse);
         BlogsResponse recentBlog = null;

         try {
            recentBlog = (BlogsResponse)mapper.readValue(blogResponse, BlogsResponse.class);
         } catch (Exception ex) {
            ex.printStackTrace();
         }

         model.addAttribute("blogResponse", recentBlog);
         return "airlines";
      }
   }

   @GetMapping({"/city/cheap-flights-to-{page}"})
   public String cities(@PathVariable("page") String page, @ModelAttribute FlightSearch flightSearch, @ModelAttribute ReviewRequest reviewRequest, Model model) {
      model.addAttribute("airlineList", Utility.getAirlines());
      System.out.println("PagesController::City::PageVaue>>" + page);
      String code = page.split("-")[1];
      String pageName = page.split("-")[0];
      PageRequest pageRequest = new PageRequest();
      PageResponse pageResponse = new PageResponse();
      RestTemplate rest = new RestTemplate();
      ObjectMapper mapper = new ObjectMapper();
      pageRequest.setPageType("City");
      pageRequest.setPageValue(code.toLowerCase());
      pageRequest.setSiteId("4");
      pageRequest.setUrl("");
      String res = rest.postForObject(pageApiUrl + "/showcontent?authcode=ebooktrip", pageRequest, String.class);
      System.out.println("City Content:: " + res);

      try {
         pageResponse = (PageResponse)mapper.readValue(res, PageResponse.class);
      } catch (JsonParseException ex) {
         ex.printStackTrace();
      } catch (JsonMappingException ex) {
         ex.printStackTrace();
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      model.addAttribute("pageResponse", pageResponse.getResponse().get(0));
      model.addAttribute("page", pageName);
      flightSearch.setDestination((String)this.restService.getAirportList(code).get(0));
      ReviewRequest reviewReq = new ReviewRequest();
      reviewReq.setSiteId("4");
      reviewReq.setReviewUrl(page);
      String reviewRes = rest.postForObject(pageApiUrl + "/reviewbyurl?authcode=ebooktrip", reviewReq, String.class);
      System.out.println("reviewRes : " + reviewRes);
      ReviewResponse reviewResponse = new ReviewResponse();

      try {
         reviewResponse = (ReviewResponse)mapper.readValue(reviewRes, ReviewResponse.class);
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      for(int i = 0; i < reviewResponse.getResponse().size(); ++i) {
         ((Response)reviewResponse.getResponse().get(i)).setReviewUrl(Utility.getDayHHMMDiff(((Response)reviewResponse.getResponse().get(i)).getReviewDate(), new Date()));
      }

      model.addAttribute("reviewResponse", reviewResponse.getResponse());
      DealRequest dealRequest = new DealRequest();
      dealRequest.setAirline("");
      dealRequest.setCabinClass("Y");
      dealRequest.setCityName("");
      dealRequest.setCountryCode("US");
      dealRequest.setCountryName("US");
      dealRequest.setCurrency("USD");
      dealRequest.setDepartDate("");
      dealRequest.setFroCity("");
      dealRequest.setPage("");
      dealRequest.setToCity(code.toUpperCase());
      dealRequest.setTripType("2");
      dealRequest.setSiteId("4");
      String dealResStr = rest.postForObject(this.apiUrl + "/travelsite/deals?authcode=ebooktrip", dealRequest, String.class);
      System.out.println("DealResStr>>" + dealResStr);
      DealResponse dealResponse = null;
      List filterDealResponse = null;

      try {
         dealResponse = (DealResponse)mapper.readValue(dealResStr, DealResponse.class);
         filterDealResponse = dealResponse.getResponse().stream().filter((a) -> {
            return !a.getAirline().equals("DL");
         }).collect(Collectors.toList());
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      model.addAttribute("dealResponse", dealResponse);
      model.addAttribute("filterDealResponse", filterDealResponse);
      model.addAttribute("dealList", this.flightService.getDealList());
      String blogResponse = rest.postForObject(this.apiUrl + "/find/recentBlogs?authcode=ebooktrip", dealRequest, String.class);
      blogResponse = this.Spanish_Repair(blogResponse);
      BlogsResponse recentBlog = null;

      try {
         recentBlog = (BlogsResponse)mapper.readValue(blogResponse, BlogsResponse.class);
      } catch (Exception ex) {
         ex.printStackTrace();
      }

      model.addAttribute("blogResponse", recentBlog);
      return "cities";
   }

   @GetMapping({"/routes/cheap-flights-from-{page}"})
   public String citiesto(@PathVariable("page") String page, @ModelAttribute FlightSearch flightSearch, @ModelAttribute ReviewRequest reviewRequest, Model model) {
      model.addAttribute("airlineList", Utility.getAirlines());
      System.out.println("PagesController::Routes::Pagevalue>>" + page);
      String code = page.split("-")[1];
      String pageName = page.split("-")[0];
      String tocityName = page.split("-")[3];
      page.substring(page.lastIndexOf("-") + 1);
      System.out.println("code and page name is :---" + code + "-------" + pageName);
      PageRequest pageRequest = new PageRequest();
      PageResponse pageResponse = new PageResponse();
      RestTemplate rest = new RestTemplate();
      ObjectMapper mapper = new ObjectMapper();
      pageRequest.setPageType("Genric");
      pageRequest.setPageValue(code.toLowerCase());
      pageRequest.setSiteId("4");
      pageRequest.setUrl("");
      String res = rest.postForObject(pageApiUrl + "/showcontent?authcode=ebooktrip", pageRequest, String.class);
      System.out.println("Route==PageResponse:: " + res);

      try {
         pageResponse = (PageResponse)mapper.readValue(res, PageResponse.class);
      } catch (JsonParseException ex) {
         ex.printStackTrace();
      } catch (JsonMappingException ex) {
         ex.printStackTrace();
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      String dealResStr;
      ReviewResponse reviewResponse;
      if (pageResponse.getBaseResponse().getStatus() == 1) {
         System.out.println(" <<<<<<  Getting Status == 11  >>>>>>");
         model.addAttribute("pageResponse", pageResponse.getResponse().get(0));
         System.out.println("<<<<< code ====>>>>>>");
         model.addAttribute("page", pageName);
         flightSearch.setDestination((String)this.restService.getAirportList(code).get(0));
         ReviewRequest reviewReq = new ReviewRequest();
         reviewReq.setSiteId("4");
         reviewReq.setReviewUrl(page);
         dealResStr = rest.postForObject(pageApiUrl + "/reviewbyurl?authcode=ebooktrip", reviewReq, String.class);
         System.out.println("Review Response :: " + dealResStr);
         reviewResponse = new ReviewResponse();

         try {
            reviewResponse = (ReviewResponse)mapper.readValue(dealResStr, ReviewResponse.class);
         } catch (IOException ex) {
            ex.printStackTrace();
         }

         for(int i = 0; i < reviewResponse.getResponse().size(); ++i) {
            ((Response)reviewResponse.getResponse().get(i)).setReviewUrl(Utility.getDayHHMMDiff(((Response)reviewResponse.getResponse().get(i)).getReviewDate(), new Date()));
         }

         model.addAttribute("reviewResponse", reviewResponse.getResponse());
      }

      DealRequest dealRequest = new DealRequest();
      dealRequest.setAirline("");
      dealRequest.setCabinClass("Y");
      dealRequest.setCityName("");
      dealRequest.setCountryCode("US");
      dealRequest.setCountryName("US");
      dealRequest.setCurrency("USD");
      dealRequest.setDepartDate("");
      dealRequest.setFroCity("");
      dealRequest.setPage("");
      dealRequest.setToCity(code.toUpperCase());
      dealRequest.setTripType("2");
      dealRequest.setSiteId("4");
      dealResStr = rest.postForObject(this.apiUrl + "/travelsite/deals?authcode=ebooktrip", dealRequest, String.class);
      System.out.println("DealResStr>>" + dealResStr);
      reviewResponse = null;
      List filterDealResponse = null;

      try {
         DealResponse dealResponse = (DealResponse)mapper.readValue(dealResStr, DealResponse.class);
         filterDealResponse = dealResponse.getResponse().stream().filter((a) -> {
            return !a.getAirline().equals("DL");
         }).collect(Collectors.toList());
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      String sFirst_tocityName = tocityName.substring(0, 1).toUpperCase();
      String sRemain_tocityName = tocityName.substring(1, tocityName.length());
      sFirst_tocityName = String.valueOf(sFirst_tocityName) + sRemain_tocityName;
      System.out.println("To City >>>>>>>" + sFirst_tocityName);
      model.addAttribute("tocityName", sFirst_tocityName);
      model.addAttribute("filterDealResponse", filterDealResponse);
      model.addAttribute("dealList", this.flightService.getDealList());
      String blogResponse = rest.postForObject(this.apiUrl + "/find/recentBlogs?authcode=ebooktrip", dealRequest, String.class);
      blogResponse = this.Spanish_Repair(blogResponse);
      BlogsResponse recentBlog = null;

      try {
         recentBlog = (BlogsResponse)mapper.readValue(blogResponse, BlogsResponse.class);
      } catch (Exception ex) {
         ex.printStackTrace();
      }

      model.addAttribute("blogResponse", recentBlog);
      return "cities-to";
   }
   @GetMapping({"blog/category"})
   public String blogCategory(Model model) {
      RestTemplate rest = new RestTemplate();
      ObjectMapper mapper = new ObjectMapper();
      BlogsResponse blogresponse = new BlogsResponse();
      BlogsRequest request = new BlogsRequest();
      request.setSiteId("4");
      String blogRS = rest.postForObject(pageApiUrl + "/showblogdata?authcode=ebooktrip", request, String.class);
      blogRS = this.Spanish_Repair(blogRS);
      System.out.println("blogRS>>" + blogRS);

      try {
         blogresponse = (BlogsResponse)mapper.readValue(blogRS, BlogsResponse.class);
      } catch (JsonParseException ex) {
         ex.printStackTrace();
      } catch (JsonMappingException ex) {
         ex.printStackTrace();
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      List news;
      try {
         news = blogresponse.getResponse().stream().filter((a) -> {
            String extarTag = a.getExtarTag();
            return extarTag != null && extarTag.equalsIgnoreCase("Adventure");
         }).collect(Collectors.toList());
         model.addAttribute("adventureblog", news);
      } catch (Exception ex) {
         ex.printStackTrace();
      }

      try {
         news = blogresponse.getResponse().stream().filter((a) -> {
            String extarTag = a.getExtarTag();
            return extarTag != null && extarTag.equalsIgnoreCase("Romance");
         }).collect(Collectors.toList());
         model.addAttribute("romanceblog", news);
      } catch (Exception ex) {
         ex.printStackTrace();
      }

      try {
         news = blogresponse.getResponse().stream().filter((a) -> {
            String extarTag = a.getExtarTag();
            return extarTag != null && extarTag.equalsIgnoreCase("Destination");
         }).collect(Collectors.toList());
         model.addAttribute("destinationblog", news);
      } catch (Exception ex) {
         ex.printStackTrace();
      }

      try {
         news = blogresponse.getResponse().stream().filter((a) -> {
            String extarTag = a.getExtarTag();
            return extarTag != null && extarTag.equalsIgnoreCase("Family");
         }).collect(Collectors.toList());
         model.addAttribute("familyblog", news);
      } catch (Exception ex) {
         ex.printStackTrace();
      }

      try {
         news = blogresponse.getResponse().stream().filter((a) -> {
            String extarTag = a.getExtarTag();
            return extarTag != null && extarTag.equalsIgnoreCase("News and Articles");
         }).collect(Collectors.toList());
         model.addAttribute("news", news);
      } catch (Exception ex) {
         ex.printStackTrace();
      }

      DealRequest dealReq = new DealRequest();
      dealReq.setAirline("");
      dealReq.setCabinClass("Y");
      dealReq.setCityName("");
      dealReq.setCountryCode("US");
      dealReq.setCountryName("US");
      dealReq.setCurrency("USD");
      dealReq.setDepartDate("");
      dealReq.setFroCity("");
      dealReq.setToCity("");
      dealReq.setPage("");
      dealReq.setTripType("2");
      dealReq.setSiteId("4");
      String recentBlog = rest.postForObject(this.apiUrl + "/find/recentBlogs?authcode=ebooktrip", dealReq, String.class);
      System.out.println("recentBlog : - " + recentBlog);
      BlogsResponse blogResponse = null;

      try {
         blogResponse = (BlogsResponse)mapper.readValue(recentBlog, BlogsResponse.class);
      } catch (JsonParseException ex) {
         ex.printStackTrace();
      } catch (JsonMappingException ex) {
         ex.printStackTrace();
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      com.travel.object.blogs.Response blogCReq = new com.travel.object.blogs.Response();
      blogCReq.setSiteId(Integer.parseInt("4"));
      model.addAttribute("recentBlog", blogResponse.getResponse());
      model.addAttribute("blogresponse", blogresponse.getResponse());
      return "blog-category";
   }

   @GetMapping({"blog/category/{cat}"})
   public String viewAllCategory(@PathVariable("cat") String cat, Model model) {
      RestTemplate rest = new RestTemplate();
      ObjectMapper mapper = new ObjectMapper();
      System.out.println("Category : ---" + cat);
      BlogsRequest req = new BlogsRequest();
      new com.travel.object.blogs.Response();
      BlogsResponse blogResp = null;
      req.setSiteId("4");
      req.setExtarTag(cat);
      String categoryResp = rest.postForObject(this.apiUrl + "/cat/blogdatabyid?authcode=ebooktrip", req, String.class);
      System.out.println("categoryResp ---- " + categoryResp);

      try {
         blogResp = (BlogsResponse)mapper.readValue(categoryResp, BlogsResponse.class);
      } catch (JsonParseException ex) {
         ex.printStackTrace();
      } catch (JsonMappingException ex) {
         ex.printStackTrace();
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      System.out.println("Extar Tag ---" + ((com.travel.object.blogs.Response)blogResp.getResponse().get(0)).getExtarTag());
      model.addAttribute("allBlogs", blogResp.getResponse());
      model.addAttribute("cat", cat);
      return "category-all-blog";
   }

   @GetMapping({"/blogs"})
   public String blogs(Model model) {
      System.out.println(" Blogs Method Calling.....");
      BlogsResponse blogresponse = new BlogsResponse();
      model.addAttribute("airlineList", Utility.getAirlines());
      RestTemplate rest = new RestTemplate();
      ObjectMapper mapper = new ObjectMapper();
      BlogsRequest request = new BlogsRequest();
      request.setSiteId("4");
      String blogRS = rest.postForObject(pageApiUrl + "/showblogdata?authcode=ebooktrip", request, String.class);
      blogRS = this.Spanish_Repair(blogRS);
      System.out.println("blogRS>>" + blogRS);

      try {
         blogresponse = (BlogsResponse)mapper.readValue(blogRS, BlogsResponse.class);
      } catch (JsonParseException ex) {
         ex.printStackTrace();
      } catch (JsonMappingException ex) {
         ex.printStackTrace();
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      if (blogresponse.getResponse().size() == 0) {
         return "redirect:/";
      } else {
         model.addAttribute("blogResponse", blogresponse.getResponse());
         return "blogs";
      }
   }

   @GetMapping({"/blogs/{page}"})
   public String blogPages(@PathVariable String page, Model model) throws JsonProcessingException {
      System.out.println(" BlogPages method Calling ..... " + page);
      BlogsRequest req1 = new BlogsRequest();
      RestTemplate rest = new RestTemplate();
      ObjectMapper mapper = new ObjectMapper();
      BlogsResponse blogresponse = new BlogsResponse();
      req1.setTitleUrl(page);
      req1.setSiteId("4");
      System.out.println("Blog Page Request is :-- " + mapper.writeValueAsString(req1));
      String blogPageURL = "http://44.235.26.108/content/blogdatabyid?authcode=ebooktrip";
      String blogPageRS = rest.postForObject(blogPageURL, req1, String.class);
      System.out.println("Blog-Page Response :- " + blogPageRS);
      BlogsResponse blogRes = new BlogsResponse();

      try {
         blogRes = (BlogsResponse)mapper.readValue(blogPageRS, BlogsResponse.class);
      } catch (JsonParseException ex) {
         ex.printStackTrace();
      } catch (JsonMappingException ex) {
         ex.printStackTrace();
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      Integer id = ((com.travel.object.blogs.Response)blogRes.getResponse().get(0)).getId();
      System.out.println("Blog Id : - " + id);
      String blogRS = rest.postForObject(pageApiUrl + "/showblogdata?authcode=ebooktrip", req1, String.class);

      try {
         blogresponse = (BlogsResponse)mapper.readValue(blogRS, BlogsResponse.class);
      } catch (JsonParseException ex) {
         ex.printStackTrace();
      } catch (JsonMappingException ex) {
         ex.printStackTrace();
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      List<com.travel.object.blogs.Response> filterBlogData = blogresponse.getResponse().stream().filter((a) -> {
         return !a.getId().equals(id);
      }).collect(Collectors.toList());
      FaqDetail objFaqDetails = new FaqDetail();
      FaqRequest objFaqRequest = new FaqRequest();
      objFaqRequest.setSiteId(1);
      objFaqRequest.setUrl(page);
      objFaqRequest.setPageType("Blog");
      objFaqRequest.setFaqStatus("Active");
      String faqurl = "http://44.235.26.108/faq/showFaqsByUrl?authcode=ebooktrip";
      String faqResponse = rest.postForObject(faqurl, objFaqRequest, String.class);
      System.out.println("faqResponse : -- " + faqResponse);

      try {
         objFaqDetails = (FaqDetail)mapper.readValue(faqResponse, FaqDetail.class);
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      model.addAttribute("faqResponse", objFaqDetails.getResponse());
      model.addAttribute("filterBlogData", filterBlogData);
      model.addAttribute("blogResponse", blogRes.getResponse().get(0));
      return "blog-detail";
   }

   @PostMapping({"/review/submit"})
   @ResponseBody
   public String reviewsubmit(@RequestBody ReviewRequest reviewRequest) {
      System.out.println(" reviewsubmit Method Calling.. ");
      System.out.println("UserName:" + reviewRequest.getUserName());
      Date currDate = new Date();
      RestTemplate rest = new RestTemplate();
      ObjectMapper mapper = new ObjectMapper();
      reviewRequest.setSiteId("4");
      reviewRequest.setUserPhone("");
      reviewRequest.setReviewDate(currDate.toString());
      reviewRequest.setReviewStatus("Inactive");
      reviewRequest.setReviewRpyId("2");

      try {
         System.out.println("Review Submit Request :-- " + mapper.writeValueAsString(reviewRequest));
      } catch (Exception ex) {
      }

      String reviewRS = rest.postForObject(pageApiUrl + "/addreview?authcode=ebooktrip", reviewRequest, String.class);
      System.out.println(" ReviewSubmit Response:: " + reviewRS);
      return reviewRS;
   }

   @PostMapping({"/newsletter/submit"})
   @ResponseBody
   public String newslettersubmit(@RequestBody NewsletterRequest newsletterRequest) {
      Date currDate = new Date();
      RestTemplate rest = new RestTemplate();
      ObjectMapper mapper = new ObjectMapper();
      newsletterRequest.setDate(currDate.toString());
      newsletterRequest.setSiteId(4);
      newsletterRequest.setStatus("Active");
      newsletterRequest.setUrl("https://www.lowtickets.com");
      newsletterRequest.setEmailId(newsletterRequest.getEmailId());

      try {
         System.out.println("NewsletterRequest:: " + mapper.writeValueAsString(newsletterRequest));
      } catch (JsonProcessingException ex) {
         ex.printStackTrace();
      }

      String newsletterURL = "http://44.235.26.108/subscribe/addNewsletter?authcode=ebooktrip";
      String newsletterRS = rest.postForObject(newsletterURL, newsletterRequest, String.class);
      System.out.println("NewsletterRequest" + newsletterRS);
      NewsletterResponse subscribeObj = new NewsletterResponse();

      try {
         subscribeObj = (NewsletterResponse)mapper.readValue(newsletterRS, NewsletterResponse.class);
      } catch (JsonParseException ex) {
         ex.printStackTrace();
      } catch (JsonMappingException ex) {
         ex.printStackTrace();
      } catch (IOException ex) {
         ex.printStackTrace();
      }

      String status = "false";
      if (subscribeObj.getBaseResponse().getStatus() == 1) {
         SubscribeMail email = new SubscribeMail();
         String emailBody = email.buildSubscribeMail(newsletterRequest.getEmailId(), "newsletter");
         EmailFormat emailSend = new EmailFormat();
         emailSend.setBookingID("");
         emailSend.setFromEmail("bookings@lowtickets.com");
         emailSend.setToEmail("bookings@lowtickets.com");
         emailSend.setCcEmail("");
         emailSend.setMailBody(emailBody);
         emailSend.setMailSubject("Registered Susccessfully From " + newsletterRequest.getEmailId());

         try {
            status = this.mailService.SendMail(emailSend, "smtp.gmail.com", "465", "Bhavika@1187");
         } catch (Exception ex) {
            ex.printStackTrace();
         }
      } else {
         status = "false";
      }

      return status;
   }

    @PostMapping({"/subscribesubmit/{emailId}/{country}"})
    @ResponseBody
    public String subscribesubmit(@PathVariable String emailId, @PathVariable String country,
        HttpServletRequest request) {
        if (country.contains(" (")) {
            country = country.split("\\s\\(")[0];
        }

        /*
         * country = "afsdgf435936<>?\\/\\/\\sdd"; emailId =
         * "select (sleep)15kfdf";
         */
        boolean validMail = false;
        boolean validCountry = false;

        // email validation
        if (emailId != null && !emailId.isEmpty()) {
            Pattern p = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
            Matcher m = p.matcher(emailId);
            validMail = m.matches();
        }

        // country validation
        if (country != null && !country.isEmpty()) {
            Pattern p = Pattern.compile("^[a-zA-Z\\s]+$");
            Matcher m = p.matcher(country);
            validCountry = m.matches();
        }

        if (!validMail || !validCountry) {
            return "false";
        }

        String remoteAddr = "";

        if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }

        System.out.println("subscription user ip: " + request.getRemoteAddr());
        RestTemplate rest = new RestTemplate();
        ObjectMapper mapper = new ObjectMapper();
        Date d = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = format.format(d);
        SubscribeRequest reqObj = new SubscribeRequest();
        reqObj.setDate(dateString);
        reqObj.setEmailid(emailId);
        reqObj.setUserCountry(country);
        reqObj.setUserIp(remoteAddr);
        reqObj.setStatus("Active");
        reqObj.setSiteId(this.siteId);
        reqObj.setUrl("https://www.lowtickets.com");
        NewsletterResponse subscribeObj = new NewsletterResponse();
        try {
            System.out.println("NewsletterRequest:: " + mapper.writeValueAsString(reqObj));
            String subscribeRS = rest.postForObject("http://44.235.26.108/subscribe/addNewsletter?authcode=ebooktrip",reqObj, String.class);
            System.out.println("Subscribe Response:: " + subscribeRS);
            subscribeObj = mapper.readValue(subscribeRS, NewsletterResponse.class);
        } catch (JsonProcessingException e1) {
            e1.printStackTrace();
        } catch (IOException e4) {
            e4.printStackTrace();
        }

        String status = "false";
        if (subscribeObj.getBaseResponse().getStatus().intValue() == 1) {
            SubscribeMail email = new SubscribeMail();
            String emailBody = email.buildSubscribeMail(emailId, "subscribe");
            EmailFormat emailSend = new EmailFormat();
            emailSend.setBookingID("");
            emailSend.setFromEmail("bookings@lowtickets.com");
            emailSend.setToEmail("bookings@lowtickets.com");
            emailSend.setCcEmail("bookings@lowtickets.com");
            emailSend.setMailBody(emailBody);
            emailSend.setMailSubject("Subscribe Mail for Lowtickets from " + emailId);

            try {
                status = this.mailService.SendMail(emailSend, "smtp.gmail.com", "465", "Bhavika@1187");
            } catch (Exception e5) {
                e5.printStackTrace();
            }
        } else {
            status = "false";
        }

        return status;
    }

    public int getDayDiff(String date1, String date2) {
        SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
        float daysBetween = 0.0F;

        try {
            Date dateBefore = myFormat.parse(date1);
            Date dateAfter = myFormat.parse(date2);
            long difference = dateAfter.getTime() - dateBefore.getTime();
            daysBetween = (float)(difference / 86400000L);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return (int) daysBetween;
    }

    public String Spanish_Repair(String sValue) {
        sValue = sValue.replace("&iquest;", "¿");
        sValue = sValue.replace("&aacute;", "á");
        sValue = sValue.replace("&uacute;", "ú");
        sValue = sValue.replace("&eacute;", "é");
        sValue = sValue.replace("&oacute;", "ó");
        sValue = sValue.replace("&oicute;", "í");
        sValue = sValue.replace("&ntilde;", "ñ");
        sValue = sValue.replace("&ntilde;", "ñ");
        sValue = sValue.replace("&nbsp;", " ");
        sValue = sValue.replace("&amp;", "&");
        sValue = sValue.replace("&#8239;", " ");
        sValue = sValue.replace("&rsquo;", "'");
        sValue = sValue.replace("&rsquo;", "'");
        sValue = sValue.replace("&iacute;", "í");
        sValue = sValue.replace("&#39;", "'");
        return sValue;
    }
}