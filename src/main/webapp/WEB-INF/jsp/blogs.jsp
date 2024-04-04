<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>Lowtickets: Blogs</title>
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
<link rel="stylesheet" href="/resources/css/default.css?v=2.9">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>


<jsp:include page="tag-manager-head.jsp" /></head>
<body>
	<jsp:include page="tag-manager-body.jsp" /><!--Header Area Starts Here-->
	<jsp:include page="header.jsp" />
	<div class="screen-overlay" id="screenoverlay" onclick="hidesidenav()"></div>
	<div class="blogtop-banner">
		<img src="/resources/images/blog-banner.jpg" alt="blog-banner"
			width="10" height="2" loading="lazy" decoding="async">
		<h1>Our Blog</h1>
	</div>

	<div class="blog-items-container">

		<div class="blog-items">
			<!-- <h1>Our Blog</h1> -->
			<c:forEach var="blll" items="${blogResponse}">
				<div class="bitem">
					<div class="bimg">
					
						 <c:if test="${blll.extarTag !=''}">
						<span class="blogcategory-name"> ${blll.extarTag} </span>
						</c:if> 
						<c:choose>
							<c:when test="${blll.blogdes2 !='' }">
								<a href="/blogs/${blll.titleUrl}"> <img
									src="/resources/images/blog/${blll.blogdes2}.webp"></a>
							</c:when>
							<c:otherwise>
								<a href="/blogs/${blll.titleUrl}"><img
									src="/resources/images/blog/blog-dummyimg.webp"
									alt="blog-dummy" width="10" height="6" decoding="async"></a>
							</c:otherwise>
						</c:choose>
						
					</div>
					<div class="bmtxt">
						<a href="/blogs/${blll.titleUrl}">${blll.heading}</a>
					</div>
					<div class="btxt">
						${fn:escapeXml(fn:substring(blll.content.replaceAll('<.*?>' , ""), 0, 115))}...
					</div>
					<div class="bdate">
						<a href="/blogs/${blll.titleUrl}" aria-label="Read More">Read
							More</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<jsp:include page="footer.jsp" />

	<script src="/resources/scripts/script.js?23Oct2023"></script>

	<script>
		$(document).ready(function() {
			/* $(".blog-items .bitem").hide();
			 $(".blog-items .bitem").slice(0, 3).show();
	
			 $("body").on('click touchstart', '.loadmoreblogs', function (e) {
				e.preventDefault();
				$(".blog-items .bitem:hidden").slice(0, 3).slideDown();
				if ($(".blog-items .bitem:hidden").length == 0) {
					$(".loadmoreblogs").css('visibility', 'hidden');
				}
				$('html,body').animate({
					scrollTop: $(this).offset().top
				}, 1000);
			    });*/
	
		})
	</script>


</body>

</html>