<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Testimonials</title>
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
        <span>Lowtickets Customer Reviews</span>
    </div>
    <div style="background-color:#ffffff;">
    <div class="testimonials">
        <div style="color:#002192;font-size:26px;">What Our Customers Say About Our Service?</div>
       
    </div>
    </div>
    <style>
     .testimonials
     {
       font-family:-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
       max-width:1200px;
       margin:auto;
       padding:20px 0;
       width:94%;
     }
     .creviews
     {
       display:flex;
       flex-wrap:wrap;
       padding:20px 0;
       margin:auto;
     }
     .crcard-container
     {
       width:32%;
       margin:10px 0.65%;
     }
     .crcard
     {
       background-color:#f4f5f6;
       color:#505050;
       border-radius:3px;
       box-shadow:1px 1px 1px #ccc,1px -1px 1px #ccc,-1px 1px 1px #ccc,-1px -1px 1px #ccc;
       padding:20px;
       height:auto;
     }
     .crtext
     {
       font-size:16px;
       padding:8px 0;
       border-bottom:1px solid #707070;
     }
     .crnamedate
     {
       font-size:15px;
       color:#505050;
       margin-top:5px;
     }
     @media only screen and (max-width:768px)
     {
       .crcard{width:99%;}
       .crcard-container {     width: 49%; margin: 10px 0.5%; }
     }
     @media only screen and (max-width:500px)
     {
       .crcard-container {     width:100%; margin: 10px 0; }
     }
     </style>
    
   <jsp:include page="footer.jsp" />
<script src="/resources/scripts/script.js?8-dec-2021"></script>
</body>

</html>