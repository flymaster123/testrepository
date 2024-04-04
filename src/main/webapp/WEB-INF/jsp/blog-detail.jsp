<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>${blogResponse.title} | Lowtickets</title>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="${blogResponse.description}">
    <meta name="keyword" content="${blogResponse.keywords}">
    <link rel="icon" href="/resources/images/favicon.png">
    <link rel="preload" fetchpriority="high" as="image" href="/resources/images/blog-body.webp" type="image/webp">
    <!-- <link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700&display=swap" rel="preload" as="font" crossorigin="anonymous"> -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" crossorigin="anonymous">
    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"> -->
    <link rel="stylesheet" href="/resources/css/default.css?v=4.2">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.16.0/jquery.validate.min.js" crossorigin="anonymous"></script> -->
   
  
   
<jsp:include page="tag-manager-head.jsp" /></head>
<body>
    <jsp:include page="tag-manager-body.jsp" />
    <!--Header Area Starts Here-->
    <jsp:include page="header.jsp" />
    <div class="screen-overlay" id="screenoverlay" onclick="hidesidenav()"></div>
    <!-- <div class="blog-head bannerheightmid">
        <span>Ebooktrip Blog</span>
    </div> -->

    <div class="inner-blog-bannersec">
        <div class="topimgheading">
            <c:if test="${blogResponse.extarTag !=''}">
                 <span class="blogcategory-name"> ${blogResponse.extarTag}</span>
            </c:if>
            <p class="innerbanner-heading">${blogResponse.heading}</p>
            <fmt:parseDate var="inputDate" value="${blogResponse.posttime}" pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
            <fmt:formatDate var="formattedDate" value="${inputDate}" pattern="MMM dd, yyyy" />
            <span class="innerblog-postdate">${formattedDate}</span>
        </div>
        <div class="topimg">
       
                       <c:choose>
							<c:when test="${blogResponse.blogdes2 !='' }">
							<a href="/blogs/${blogResponse.titleUrl}"><img src="/resources/images/blog/${blogResponse.blogdes2}.webp" alt="blog-slide1" width="10" height="6" decoding="async"></a>
							</c:when>
							<c:otherwise>
								<img src="/resources/images/blog/blog-dummyimg.webp" alt="blog-dummy" width="10" height="6" loading="lazy" decoding="async">
							</c:otherwise>
						</c:choose>
        </div>
    </div>
	<input type="hidden" id="pageUrl" value="${blogResponse.titleUrl}" />
    <div style="width:100%;background-color:#ffffff;">
        <div class="blog-detail-container">
                <div class="blog-detail static-content">
                    <div class="bdtxt blogflightheading">
                        ${blogResponse.content}
                        <c:if test="${faqResponse.size() > 0}">
						<div class="myaccordion">
							<!-- Accordion -->
							<div class="acc-container">
								<p class="faq-heading">Frequently Asked Questions ?</p>
								<c:forEach var="faqData" items="${faqResponse}">
									<div class="acc">
										<div class="acc-head">
											<p>${faqData.question}</p>
										</div>
										<div class="acc-content" >
											<p>${faqData.answer}</p>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:if> 
                    </div>
                    
                </div>

                <div class="recent-blog-sec">
                    <p class="recent-blog-title">Explore More Articles</p>
                    
                    <ul>
                      <c:forEach var="fblog" items="${filterBlogData}" varStatus="loopStatus">
                         <c:if test="${loopStatus.index >= 0 && loopStatus.index <=3}">
                          <li>
                            <div class="recent-blog-img">
                            
                            <c:choose>
							<c:when test="${fblog.blogdes2 !='' }">
								<a href="/blogs/${fblog.titleUrl}"> <img src="/resources/images/blog/${fblog.blogdes2}.webp"></a>
							</c:when>
							<c:otherwise>
								<a href="/blogs/${fblog.titleUrl}"><img src="/resources/images/blog/blog-dummyimg.webp" alt="blog-dummy"
									width="10" height="6" decoding="async"></a>
							</c:otherwise>
						</c:choose>
                            
                                <!-- <img src="/resources/images/blog/blog-dummyimg.webp" alt="blog-dummy" width="10" height="6" loading="lazy" decoding="async"> -->
                            </div>
                            <div class="recent-blog-content">
                                <p class="recent-blog-heading">${fblog.heading} </p>
                                <p>${fn:escapeXml(fn:substring(fblog.content.replaceAll('<.*?>' , ""), 0, 150))}...</p>
                            </div>
                            <a href="/blogs/${fblog.titleUrl}" class="read-more-btn" aria-label="Read More">Read More</a>
                        </li>
                        </c:if>
                     </c:forEach>
                   </ul>
                </div>
        </div>
        
    </div>
   <%-- <jsp:include page="customer-review.jsp" /> --%>
    
    <jsp:include page="footer.jsp" />
</body>
<script src="/resources/scripts/script.js"></script>
<script>
	$(document).ready(function() {
		$('.acc-container .acc:nth-child(2) .acc-head').addClass('active');
		$('.acc-container .acc:nth-child(2) .acc-content').slideDown();
		$('.acc-head').on('click', function() {
			if ($(this).hasClass('active')) {
				$(this).siblings('.acc-content').slideUp();
				$(this).removeClass('active');
			} else {
				$('.acc-content').slideUp();
				$('.acc-head').removeClass('active');
				$(this).siblings('.acc-content').slideToggle();
				$(this).toggleClass('active');
			}
		});
	});
</script>
</html>