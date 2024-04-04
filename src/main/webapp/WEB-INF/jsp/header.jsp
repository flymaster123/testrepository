<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="header-container"
	style="background-color:#ffffff;width:100%">
	<div class="header">
		<div>
			<div class="upper-logo">
				<a href="/"><img src="/resources/images/logo.png" alt="logo"
					width="30" height="15" loading="lazy" decoding="async"></a>
			</div>

			<div class="upper-menu">
				<ul class="up-nav_group">
					<li><a href="/">Home</a></li>
					<li><a href="/aboutus">About Us</a></li>
					<li><a href="/blogs">Blog</a></li>
					<li><a href="/contactus">Contact Us</a></li>

					<c:if test="${userLogin == null}">
						<!-- <li><a href="/login"><span data-hover="My Bookings">My Bookings</span></a></li>
                                   <li><a href="/signup"><span data-hover="Sign Up">Sign Up</span></a></li> -->
					</c:if>
					<c:if test="${userLogin != null}">
						<!-- <li><a href="/mybookings"><span data-hover="My Bookings">My Bookings</span></a></li>
                                <li><a href="#" style="text-transform:capitalize;"><i class="fa fa-user-circle"></i> Welcome ${userLogin.userName}</a></li>
                                <li><a href="/logout"><i class="fa fa-sign-out"></i>  <span data-hover="Logout">Logout</span></a></li> -->
					</c:if>
					<!-- <li><a href="/admin"><i class="fa fa-user-circle"></i>   <span data-hover="Sign In">Sign In </span></a></li> -->
				</ul>
			</div>

			<jsp:include page="country-dropdown.jsp" />

			<div class="expertisetalk">
				<span class="callicon"><img
					src="/resources/images/icons/24-hours.png" alt="Customer support"
					width="10" height="10" loading="lazy" decoding="async"></span> <span>Call
					Us for Lowest Airfares</span> <a href="tel:+1-800-984-7414"
					title="Call Us 24/7 for Lowest Airfares">+1-800-984-7414</a>
			</div>
			<div style="clear: both;"></div>

			<div class="side-navbar-button">
				<button type="button" onclick="showsidenav()"
					aria-label="opensidenav">
					<i class="fa fa-bars"></i>
				</button>
			</div>
		</div>
	</div>
	<div class="side-navbar" id="sidenavbar">
		<ul>
			<li><span>MENU</span>
			<button type="button" onclick="hidesidenav()"
					aria-label="hidesidenav">
					<i class="fa fa-close"></i>
				</button></li>
			<li><a href="/">Home</a></li>
			<li><a href="/aboutus">About Us</a></li>
			<li><a href="/blogs">Blog</a></li>
			<li><a href="/contactus">Contact Us</a></li>
			<li><a href="/terms-and-conditions">Terms & Conditions</a></li>
			<li><a href="/privacy-policy">Privacy Policy</a></li>
		</ul>
	</div>
</div>