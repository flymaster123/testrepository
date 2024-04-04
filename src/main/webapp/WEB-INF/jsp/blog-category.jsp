<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Lowtickets: Blog Category</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Blogs Description">
<meta name="keyword" content="Blogs">
<link rel="icon" href="/resources/images/favicon.png">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap"
	rel="stylesheet" crossorigin="anonymous">
<link rel="preload" fetchpriority="high" as="image"
	href="/resources/images/blog-body.webp" type="image/webp">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.css"
	crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/default.css?v=2.9">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>


<jsp:include page="tag-manager-head.jsp" /></head>
<body>
	<jsp:include page="tag-manager-body.jsp" /><!--Header Area Starts Here-->
	<jsp:include page="header.jsp" />
	<div class="screen-overlay" id="screenoverlay" onclick="hidesidenav()"></div>
	

	<div class="blogslider">
	
		<div class="owl-carousel owl-theme">
		<c:forEach var="rblogs" items="${recentBlog }">
			<div class="item">
				<div class="blog-slide">
				
				<c:choose>
							<c:when test="${rblogs.blogdes2 !='' }">
								<img class="owl-lazy" data-src="/resources/images/blog/${rblogs.blogdes2}.webp" alt="blog-slide1" width="10" height="6" decoding="async">

							</c:when>
							<c:otherwise>
									<img class="owl-lazy" data-src="/resources/images/blog/blog-dummyimg.webp" alt="blog-slide2" width="10" height="6" decoding="async">
							</c:otherwise>
						</c:choose>
				
				
					<!-- <img class="owl-lazy" data-src="/resources/images/blog/blog-dummyimg.webp" alt="blog-slide1" width="10" height="6" decoding="async"> -->
					<div class="caption-section">
						<div class="caption-content">
							<p class="caption-heading">${rblogs.heading}</p>
							<div class="read-postdate">
								 <a href="/blogs/${rblogs.titleUrl}" aria-label="Read More">Read More</a> 
								<fmt:parseDate var="inputDate" value="${rblogs.posttime}" pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
								<fmt:formatDate var="formattedDate" value="${inputDate}" pattern="MMM dd, yyyy" />
								<span class="blog-postdate">${formattedDate}</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>
		
	</div>
	<div class="aboutus blog-category">
	
	<!-- Adenture Blog Start -->
	
		<%-- <div class="blog-category-list">
			<div class="blog-heading-viewallbtn">
				<p class="category-heading">Latest</p>
				<span class="viewallbtn"><a href="#">View All</a></span>	
			</div>
			<div class="category-row">
			<c:forEach var="rblogs" items="${blogresponse}" varStatus="loopStatus">
				<c:if test="${loopStatus.index == 4}">
					<div class="category-col category-col-left">
							<div class="category-col-post">
					<c:choose>
							<c:when test="${rblogs.blogdes2 !='' }">
							<img src="/resources/images/blog/${rblogs.blogdes2}.webp"alt="blog-slide1" width="10" height="6" decoding="async">

							</c:when>
							<c:otherwise>
							<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp"alt="blog-dummyimg" width="10" height="6" decoding="async">
							</c:otherwise>
						</c:choose>
								<div class="post-content">
									<p class="post-content-heading">${rblogs.heading} </p>
									<p>${fn:escapeXml(fn:substring(rblogs.content.replaceAll('<.*?>' , ""), 0, 150))}...</p>
									<div class="postread-postdate">
										<fmt:parseDate var="inputDate" value="${rblogs.posttime}" pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
										<fmt:formatDate var="formattedDate" value="${inputDate}" pattern="MMM dd, yyyy" />
										<span class="blog-postdate">${formattedDate}</span> 
										<a href="/blogs/${rblogs.titleUrl}" aria-label="Read More">Read More</a>
									</div>
								</div>
							</div>
					</div>
				</c:if>
			</c:forEach>


			<div class="category-col category-col-right">
				<c:forEach var="blogR" items="${blogresponse }" varStatus="loopStatus">
					<c:if test="${loopStatus.index >= 5 && loopStatus.index <= 8 }">
						<div class="category-post-right">
							<div class="right-postimg">
							
							<c:choose>
								<c:when test="${blogR.blogdes2 !='' }">
								<img src="/resources/images/blog/${blogR.blogdes2}.webp" alt="blog-slide1" width="10" height="6" decoding="async">
	
								</c:when>
								<c:otherwise>
									<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp" alt="blog-dummyimg" width="10" height="6" decoding="async">
								</c:otherwise>
							</c:choose>
							
							
								
							</div>
							<div class="right-post-content">
								<p class="post-content-heading">${blogR.heading}</p>
	
								<div class="postread-postdate">
									<fmt:parseDate var="inputDate" value="${blogR.posttime}"
										pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
									<fmt:formatDate var="formattedDate" value="${inputDate}"
										pattern="MMM dd, yyyy" />
									<span class="blog-postdate">${formattedDate}</span>
									<a href="/blogs/${blogR.titleUrl}" aria-label="Read More">Read More</a>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>

		</div>

			<div class="see-more-btn"><a href="/blogs">View More</a></div>
		</div> --%>
		
		<!-- Adenture Blog End -->


         <!-- Adenture Blog Start -->
         <c:if test="${ adventureblog.size()>0}">
		<div class="blog-category-list">
			<div class="blog-heading-viewallbtn">
			
				<p class="category-heading">Adventure</p>
				<span class="viewallbtn"><a href="/blog/category/adventure">View All</a></span>
				
			</div>
			<div class="category-row">
			<c:forEach var="adventure" items="${adventureblog}" varStatus="loopStatus">
				<c:if test="${loopStatus.index == 0}">
					<div class="category-col category-col-left">
							<div class="category-col-post">
					<c:choose>
							<c:when test="${adventure.blogdes2 !='' }">
							<img class="post-img" src="/resources/images/blog/${adventure.blogdes2}.webp"alt="blog-slide1" width="10" height="6" decoding="async">

							</c:when>
							<c:otherwise>
							<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp"alt="blog-dummyimg" width="10" height="6" decoding="async">
							</c:otherwise>
						</c:choose>
								<div class="post-content">
									<p class="post-content-heading">${adventure.heading} </p>
									<p>${fn:escapeXml(fn:substring(adventure.content.replaceAll('<.*?>' , ""), 0, 150))}...</p>
									<div class="postread-postdate">
										<fmt:parseDate var="inputDate" value="${adventure.posttime}" pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
										<fmt:formatDate var="formattedDate" value="${inputDate}" pattern="MMM dd, yyyy" />
										<span class="blog-postdate">${formattedDate}</span> 
										<a href="/blogs/${adventure.titleUrl}" aria-label="Read More">Read More</a>
									</div>
								</div>
							</div>
					</div>
				</c:if>
			</c:forEach>


			<div class="category-col category-col-right">
				<c:forEach var="advent" items="${adventureblog}" varStatus="loopStatus">
					<c:if test="${loopStatus.index >= 1 && loopStatus.index <= 4 }">
						<div class="category-post-right">
							<div class="right-postimg">
							
							<c:choose>
								<c:when test="${advent.blogdes2 !='' }">
								<img class="post-img" src="/resources/images/blog/${advent.blogdes2}.webp" alt="blog-slide1" width="10" height="6" decoding="async">
	
								</c:when>
								<c:otherwise>
									<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp" alt="blog-dummyimg" width="10" height="6" decoding="async">
								</c:otherwise>
							</c:choose>
							
							</div>
							<div class="right-post-content">
								<p class="post-content-heading">${advent.heading}</p>
	
								<div class="postread-postdate">
									<fmt:parseDate var="inputDate" value="${advent.posttime}"
										pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
									<fmt:formatDate var="formattedDate" value="${inputDate}"
										pattern="MMM dd, yyyy" />
									<span class="blog-postdate">${formattedDate}</span>
									<a href="/blogs/${advent.titleUrl}" aria-label="Read More">Read More</a>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>

		</div>

			<!-- <div class="see-more-btn"><a href="/blogs">View More</a></div> -->
		</div>
		</c:if>
		<!-- Adenture Blog End -->
		
		
		<!-- Romance Blog Start -->
		<c:if test="${ romanceblog.size()>0}">
		<div class="blog-category-list">
			<div class="blog-heading-viewallbtn">
			
				<p class="category-heading">Romance</p>
				<span class="viewallbtn"><a href="/blog/category/romance">View All</a></span>
				
			</div>
			<div class="category-row">
			<c:forEach var="romance" items="${romanceblog}" varStatus="loopStatus">
				<c:if test="${loopStatus.index == 0}">
					<div class="category-col category-col-left">
							<div class="category-col-post">
					<c:choose>
							<c:when test="${romance.blogdes2 !='' }">
							<img class="post-img" src="/resources/images/blog/${romance.blogdes2}.webp"alt="blog-slide1" width="10" height="6" decoding="async">

							</c:when>
							<c:otherwise>
							<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp"alt="blog-dummyimg" width="10" height="6" decoding="async">
							</c:otherwise>
						</c:choose>
								<div class="post-content">
									<p class="post-content-heading">${romance.heading} </p>
									<p>${fn:escapeXml(fn:substring(romance.content.replaceAll('<.*?>' , ""), 0, 150))}...</p>
									<div class="postread-postdate">
										<fmt:parseDate var="inputDate" value="${romance.posttime}" pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
										<fmt:formatDate var="formattedDate" value="${inputDate}" pattern="MMM dd, yyyy" />
										<span class="blog-postdate">${formattedDate}</span> 
										<a href="/blogs/${romance.titleUrl}" aria-label="Read More">Read More</a>
									</div>
								</div>
							</div>
					</div>
				</c:if>
			</c:forEach>


			<div class="category-col category-col-right">
				<c:forEach var="rom" items="${romanceblog}" varStatus="loopStatus">
					<c:if test="${loopStatus.index >= 1 && loopStatus.index <= 4 }">
						<div class="category-post-right">
							<div class="right-postimg">
							
							<c:choose>
								<c:when test="${rom.blogdes2 !='' }">
								<img class="post-img" src="/resources/images/blog/${rom.blogdes2}.webp" alt="blog-slide1" width="10" height="6" decoding="async">
	
								</c:when>
								<c:otherwise>
									<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp" alt="blog-dummyimg" width="10" height="6" decoding="async">
								</c:otherwise>
							</c:choose>	
							</div>
							<div class="right-post-content">
								<p class="post-content-heading">${rom.heading}</p>
	
								<div class="postread-postdate">
									<fmt:parseDate var="inputDate" value="${rom.posttime}"
										pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
									<fmt:formatDate var="formattedDate" value="${inputDate}"
										pattern="MMM dd, yyyy" />
									<span class="blog-postdate">${formattedDate}</span>
									 <a href="/blogs/${rom.titleUrl}" aria-label="Read More">Read More</a>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>

		</div>

			<!-- <div class="see-more-btn"><a href="/blogs">View More</a></div> -->
		</div>
		</c:if>	
		<!-- Romance Blog End -->
		
		<!-- Destination Blog Start -->
		<c:if test="${ destinationblog.size()>0}">
		<div class="blog-category-list">
			<div class="blog-heading-viewallbtn">
				<p class="category-heading">Destination</p>
				<span class="viewallbtn"><a href="/blog/category/destination">View All</a></span>
					
			</div>
			<div class="category-row">
			<c:forEach var="destination" items="${destinationblog}" varStatus="loopStatus">
				<c:if test="${loopStatus.index == 0}">
					<div class="category-col category-col-left">
							<div class="category-col-post">
					<c:choose>
							<c:when test="${destination.blogdes2 !='' }">
							<img class="post-img" src="/resources/images/blog/${destination.blogdes2}.webp"alt="blog-slide1" width="10" height="6" decoding="async">

							</c:when>
							<c:otherwise>
							<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp"alt="blog-dummyimg" width="10" height="6" decoding="async">
							</c:otherwise>
						</c:choose>
								<div class="post-content">
									<p class="post-content-heading">${destination.heading} </p>
									<p>${fn:escapeXml(fn:substring(destination.content.replaceAll('<.*?>' , ""), 0, 150))}...</p>
									<div class="postread-postdate">
										<fmt:parseDate var="inputDate" value="${destination.posttime}" pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
										<fmt:formatDate var="formattedDate" value="${inputDate}" pattern="MMM dd, yyyy" />
										<span class="blog-postdate">${formattedDate}</span> 
										<a href="/blogs/${destination.titleUrl}" aria-label="Read More">Read More</a>
									</div>
								</div>
							</div>
					</div>
				</c:if>
			</c:forEach>


			<div class="category-col category-col-right">
				<c:forEach var="distin" items="${destinationblog}" varStatus="loopStatus">
					<c:if test="${loopStatus.index >= 1 && loopStatus.index <= 4 }">
						<div class="category-post-right">
							<div class="right-postimg">
							
							<c:choose>
								<c:when test="${distin.blogdes2 !='' }">
								<img class="post-img" src="/resources/images/blog/${distin.blogdes2}.webp" alt="blog-slide1" width="10" height="6" decoding="async">
	
								</c:when>
								<c:otherwise>
									<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp" alt="blog-dummyimg" width="10" height="6" decoding="async">
								</c:otherwise>
							</c:choose>
							
							
								
							</div>
							<div class="right-post-content">
								<p class="post-content-heading">${distin.heading}</p>
	
								<div class="postread-postdate">
									<fmt:parseDate var="inputDate" value="${distin.posttime}"
										pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
									<fmt:formatDate var="formattedDate" value="${inputDate}"
										pattern="MMM dd, yyyy" />
									<span class="blog-postdate">${formattedDate}</span>
									<a href="/blogs/${distin.titleUrl}" aria-label="Read More">Read More</a>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>

		</div>

			<!-- <div class="see-more-btn"><a href="/blogs">View More</a></div> -->
		</div>
		</c:if>
		<!-- Destination Blog End -->
		
		<!-- Family Blog Start -->
		<c:if test="${ familyblog.size()>0}">
		<div class="blog-category-list">
			<div class="blog-heading-viewallbtn">
				<p class="category-heading">Family</p>
				<span class="viewallbtn"><a href="/blog/category/family">View All</a></span>
				
			</div>
			<div class="category-row">
			<c:forEach var="family" items="${familyblog}" varStatus="loopStatus">
				<c:if test="${loopStatus.index == 0}">
					<div class="category-col category-col-left">
							<div class="category-col-post">
					<c:choose>
							<c:when test="${family.blogdes2 !='' }">
							<img class="post-img" src="/resources/images/blog/${family.blogdes2}.webp"alt="blog-slide1" width="10" height="6" decoding="async">

							</c:when>
							<c:otherwise>
							<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp"alt="blog-dummyimg" width="10" height="6" decoding="async">
							</c:otherwise>
						</c:choose>
								<div class="post-content">
									<p class="post-content-heading">${family.heading} </p>
									<p>${fn:escapeXml(fn:substring(family.content.replaceAll('<.*?>' , ""), 0, 150))}...</p>
									<div class="postread-postdate">
										<fmt:parseDate var="inputDate" value="${family.posttime}" pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
										<fmt:formatDate var="formattedDate" value="${inputDate}" pattern="MMM dd, yyyy" />
										<span class="blog-postdate">${formattedDate}</span> 
										<a href="/blogs/${family.titleUrl}" aria-label="Read More">Read More</a>
									</div>
								</div>
							</div>
					</div>
				</c:if>
			</c:forEach>


			<div class="category-col category-col-right">
				<c:forEach var="fm" items="${familyblog}" varStatus="loopStatus">
					<c:if test="${loopStatus.index >= 1 && loopStatus.index <= 4 }">
						<div class="category-post-right">
							<div class="right-postimg">
							
							<c:choose>
								<c:when test="${fm.blogdes2 !='' }">
								<img class="post-img" src="/resources/images/blog/${fm.blogdes2}.webp" alt="blog-slide1" width="10" height="6" decoding="async">
	
								</c:when>
								<c:otherwise>
									<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp" alt="blog-dummyimg" width="10" height="6" decoding="async">
								</c:otherwise>
							</c:choose>
							
							
								
							</div>
							<div class="right-post-content">
								<p class="post-content-heading">${fm.heading}</p>
	
								<div class="postread-postdate">
									<fmt:parseDate var="inputDate" value="${fm.posttime}"
										pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
									<fmt:formatDate var="formattedDate" value="${inputDate}"
										pattern="MMM dd, yyyy" />
									<span class="blog-postdate">${formattedDate}</span>
									<a href="/blogs/${fm.titleUrl}" aria-label="Read More">Read More</a>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>

		</div>

			<!-- <div class="see-more-btn"><a href="/blogs">View More</a></div> -->
		</div>
		</c:if>	
		<!-- Family Blog End -->
		
		<!-- Group Blog Start -->
		<c:if test="${ news.size()>0}">
		<div class="blog-category-list">
			<div class="blog-heading-viewallbtn">
				<p class="category-heading">News And Articles</p>
				<span class="viewallbtn"><a href="/blog/category/News And Articles">View All</a></span>
				
			</div>
			<div class="category-row">
			<c:forEach var="group" items="${news}" varStatus="loopStatus">
				<c:if test="${loopStatus.index == 0}">
					<div class="category-col category-col-left">
							<div class="category-col-post">
					<c:choose>
							<c:when test="${group.blogdes2 !='' }">
							<img class="post-img" src="/resources/images/blog/${group.blogdes2}.webp"alt="blog-slide1" width="10" height="6" decoding="async">

							</c:when>
							<c:otherwise>
							<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp"alt="blog-dummyimg" width="10" height="6" decoding="async">
							</c:otherwise>
						</c:choose>
								<div class="post-content">
									<p class="post-content-heading">${group.heading} </p>
									<p>${fn:escapeXml(fn:substring(group.content.replaceAll('<.*?>' , ""), 0, 150))}...</p>
									<div class="postread-postdate">
										<fmt:parseDate var="inputDate" value="${group.posttime}" pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
										<fmt:formatDate var="formattedDate" value="${inputDate}" pattern="MMM dd, yyyy" />
										<span class="blog-postdate">${formattedDate}</span> 
										<a href="/blogs/${group.titleUrl}" aria-label="Read More">Read More</a>
									</div>
								</div>
							</div>
					</div>
				</c:if>
			</c:forEach>


			<div class="category-col category-col-right">
				<c:forEach var="gp" items="${news}" varStatus="loopStatus">
					<c:if test="${loopStatus.index >= 1 && loopStatus.index <= 4 }">
						<div class="category-post-right">
							<div class="right-postimg">
							
							<c:choose>
								<c:when test="${gp.blogdes2 !='' }">
								<img class="post-img" src="/resources/images/blog/${gp.blogdes2}.webp" alt="blog-slide1" width="10" height="6" decoding="async">
	
								</c:when>
								<c:otherwise>
									<img class="post-img" src="/resources/images/blog/blog-dummyimg.webp" alt="blog-dummyimg" width="10" height="6" decoding="async">
								</c:otherwise>
							</c:choose>
							
							
								
							</div>
							<div class="right-post-content">
								<p class="post-content-heading">${gp.heading}</p>
	
								<div class="postread-postdate">
									<fmt:parseDate var="inputDate" value="${gp.posttime}"
										pattern="EEE MMM dd HH:mm:ss zzz yyyy" />
									<fmt:formatDate var="formattedDate" value="${inputDate}"
										pattern="MMM dd, yyyy" />
									<span class="blog-postdate">${formattedDate}</span>
									<a href="/blogs/${gp.titleUrl}" aria-label="Read More">Read More</a>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>

		</div>

			<!-- <div class="see-more-btn"><a href="/blogs">View More</a></div> -->
		</div>
		</c:if>	
		
		<!-- Group Blog End -->


	<div class="see-more-btn see-all-btn"><a href="/blogs">All blogs</a></div>

	</div>
	
	
		
	


	
	

	
	<jsp:include page="footer.jsp" />


	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
	<script src="/resources/scripts/script.js?23Oct2023"></script>

	<script>
		$(document).ready(function() {
			$('.owl-carousel').owlCarousel({
				loop : true,
				margin : 10,
				//autoplay:true,
				lazyLoad : true,
				nav : true,
				items : 1,
				dots : true,
				nav : false,
			})
		})
	</script>

</body>

</html>