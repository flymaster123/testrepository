<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Suscribe to Newsletter</title>
    <link rel="stylesheet" href="/resources/css/default.css?v=5.1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Mukta:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="icon" href="/resources/images/favicon.png">
	<script src="/resources/scripts/jquery-1.11.1.min.js"></script>
<jsp:include page="tag-manager-head.jsp" /></head>
<body style="background-image:url('/resources/images/blog-body.jpg');background-repeat:no-repeat;background-attachment: fixed;background-size:100% 100%;">
   <jsp:include page="tag-manager-body.jsp" /> 
    <jsp:include page="header.jsp" />
    <div class="screen-overlay" id="screenoverlay" onclick="hidesidenav()"></div>
    
     <div class="blog-head">
        <span>Subscribe to Newsletter</span>
    </div>
    <div style="background-color:#ffffff;padding:40px 0">
         <div class="auto-fare-alert">
               <div class="speak-expert-section">
                    <div class="auto-alert-topic">Be the first to know!</div>
                    <div class="auto-alert-line">Sign up now to receive our latest flight deals and discounts!</div>
                    <div class="auto-alert-call-us">You will even get to save up to $20 our fees on your next flight.</div>
            </div>
            <div class="alert-section-form"><input type="text" id="newsEmail" placeholder="Enter Email Address"><button type="button" onclick="newsalertsubmit()">Sign Up Now</button>
			</div>
			<span id="newsMsg"></span>
            <div class="auto-alert-terms"><a href="/terms-and-conditions" target="blank">Terms & Conditions</a></div>
        </div>
   </div>
<style>
.auto-fare-alert
{
    background-color:#f4f5f6;
    border-radius:5px;
    padding:10px 20px;
    box-shadow:1px 1px 1px #909090,-1px -1px 1px #909090,1px -1px 1px #909090,-1px 1px 1px #909090;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    max-width:550px;
    margin:auto;
}
.speak-expert-section
{
    display:flex;
    flex-direction:column;
    text-align:center;
}
.auto-alert-topic
{
    font-family:'Mukta';
    font-weight:550;
    color:#101010;
    font-size:25px;
    padding:5px 0;
}
.auto-alert-line
{
    color:#303030;
    font-size:18px;
    padding:5px 0;
}
.auto-alert-call-us
{
    color:#303030;
    font-size:18px;
    padding:5px 0;
}
.alert-section-form
{
    padding:15px 0;
    display:flex;
    justify-content:space-between;
    flex-direction:column;
    align-items:center;
    justifiy-content:center;
}
.alert-section-form input
{
    width:330px;
    height:40px;
    border:1px solid #909090;
    border-radius:5px;
    padding:0 5px;
    color:#202020;
    font-size:15px;
    outline:0;
    margin:5px;
}
.alert-section-form button
{
    width:200px;
    height:40px;
    border:0;
    border-radius:20px;
    color:#ffffff;
    font-size:17px;
    background-color:#ff4500;
    outline:0;
    cursor: pointer;
    margin:5px 0; 
}
.alert-section-form button:hover
{
    background-color:red;
}
.auto-alert-terms
{
    margin:5px 0;
    display:flex;
    justify-content:center;
}
.auto-alert-terms a
{
    color:#002192;
    font-size:15px;
}
</style>
<jsp:include page="footer.jsp" />
</body>
<script src="/resources/scripts/script.js?01112024"></script>
</html>