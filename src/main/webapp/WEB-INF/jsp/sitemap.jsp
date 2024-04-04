<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Site Map</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="DESCRIPTION"
	content="Lowtickets's sitemap gives you all routes and city flights pages after that you can book flight tickets according to plans with a heavy discount and offers">
<link rel="icon" href="/resources/images/favicon.png">
<link rel="canonical" href="https://www.cheapinair.com/sitemap">

<link
	href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700&display=swap"
	rel="preload" as="font" crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="preload" fetchpriority="high"
	href="/resources/images/blog-body.webp" as="image" type="image/webp" />
<link rel="stylesheet" href="/resources/css/default.css?v=2.7">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<script data-ad-client="ca-pub-8417978305493541" async
	src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<jsp:include page="tag-manager-head.jsp" />
</head>

<body>
	<jsp:include page="tag-manager-body.jsp" /><!--Header Area Starts Here-->
	<jsp:include page="header.jsp" />
	<div class="screen-overlay" id="screenoverlay" onclick="hidesidenav()"></div>
	<!--Header Ends Here-->
	<div class="blog-head">
		<h1>Site Map</h1>
	</div>
	<div style="background-color:#ffffff">
		<div class="aboutus static-content">
			<c:if test="${airlineMap.size()>0}">
				<p class="sitemap-heading">Airlines Flight Deals</p>

				<div class="smlink-row">
					<div>
						<ul>
							<c:forEach var="airUrl" items="${airlineMap}" varStatus="indexed">
								<li><i class="fa fa-plane"></i>&nbsp;&nbsp;<a
									href="/flights/${fn:replace(fn:toLowerCase(airUrl.url),' ','-')}-${fn:toLowerCase(airUrl.pageValue)}">${airUrl.pageName}
										Reservations</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</c:if>

			<c:if test="${cityMap.size()>0}">
				<p class="sitemap-heading">Cheap Flight Deals</p>

				<div class="smlink-row">
					<div>
						<ul>
							<c:forEach var="airUrl" items="${cityMap}" varStatus="indexed">
								<li><i class="fa fa-plane"></i>&nbsp;&nbsp;<a
									href="/city/cheap-flights-to-${fn:replace(fn:toLowerCase(airUrl.url),' ','-')}-${fn:toLowerCase(airUrl.pageValue)}">Cheap
										Flights to ${airUrl.pageName}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</c:if>
			<c:if test="${genericMap.size()>0}">
				<p class="sitemap-heading">Flight Routes</p>

				<div class="smlink-row">
					<div>
						<ul>
							<c:forEach var="airUrl" items="${genericMap}" varStatus="indexed">
								<li><i class="fa fa-plane"></i>&nbsp;&nbsp;<a
									href="/routes/cheap-flights-from-${fn:replace(fn:toLowerCase(airUrl.url),' ','-')}">${airUrl.pageName}</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</c:if>

		</div>
	</div>

	<!--Footer Starts-->
	<jsp:include page="footer.jsp" />
	<script src="/resources/scripts/script.js?8-dec-2021"></script>
</body>

</html>