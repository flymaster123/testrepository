<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page pageEncoding="UTF-8" %>
<style>
    .alert-screen-overlay
    {
        position:fixed;
        top:0;
        width:100%;
        height:100%;
        background-color:rgba(0,0,0,0.4);
        display:flex;
        justify-content:center;
        align-items:center;
        z-index:999;
        display:none;
    }
    .auto-fare-alert
    {
        background-color:#ffffff;
        box-shadow:1px 1px 1px #909090,-1px -1px 1px #909090,1px -1px 1px #909090,-1px 1px 1px #909090;
        font-family:'Lato' , sans-serif;
        width:590px;
         display:flex;
        align-items:center; align-content:space-between; flex-wrap:wrap;
        
        width:100%;
        height:100%;
    }
    .auto-fare-alert > div { width:100%; text-align:center; }
    .auto-alert-close
    {
        display:flex;
        align-items:center;
        justify-content:center;
        flex-direction:row-reverse;
        color:#ffffff;
        height:45px;
        width:100%;
        background-color:#002162; background-image:linear-gradient(red, #bf0d00);
        padding:0 10px;
        position:relative; 
    }
    .auto-alert-close i
    {
        position:absolute;
        right:10px;
        top:12px;
        cursor: pointer;
    }
    .auto-alert-close span
    {
        font-family:'Lato',sans-serif;
        text-align:center;
        font-weight:600;
        font-size:17px;
    }   
    .speak-expert-section
    {
        display:flex;
        padding:20px 0;
    }
    .speak-expert-section img
    {
        width:180px;
        height:180px;
        border-radius:50%;
        box-shadow:2px 2px 5px #f0f0f0,-2px 2px 5px #f0f0f0,2px -2px 5px #f0f0f0,-2px -2px 5px #f0f0f0;
        margin:0 20px;
    }
    .speak-expert-section > div
    {
        padding:0 10px;
    }
    .auto-alert-topic
    {
        font-weight:550;
        color:#101010;
        font-size:24px; font-weight:bold; letter-spacing:0.5px;
    }
    .auto-alert-line
    {
        color:#505050;
        font-size:18px;
        padding:5px 0;
    }
    .auto-alert-promo
    {
        font-size:18px;
        color:#505050;
    }
    .auto-alert-promo span
    {
        color:green;
        font-size:16px;
        border:1px dashed green;
        padding:1px 3px;
    }
    .auto-alert-call-us > span
    {
        font-family:'Mukta';
        color:#ffffff;
        font-size:18px;
        font-weight:550;
        padding:0 10px;
       
        background-color:#002162;
        height:60px;
        border-radius:5px;
        display:inline-flex;
        align-items:center;
        justify-content:center;
        text-align:center; width:280px;
    }
    .auto-alert-promo span b
    {
        font-size:17px;
    }
    .alert-section-topic
    {
        color:#303030;
        font-weight:550;
        font-size:18px;
        padding:10px 0 5px 0;
    }
    .alert-section-line
    {
        color:#505050;
        font-size:15px;
    }
    .alert-section-form
    {
        padding:15px 0;
        display:flex;
        justify-content:space-between;
    }
    .alert-section-form input
    {
        width:330px;
        height:45px;
        border:1px solid #c0c0c0;
        border-radius:5px;
        padding:0 5px;
        color:#303030;
        font-size:15px;
        outline:0;
    }
    .alert-section-form button
    {
        width:200px;
        height:45px;
        border:0;
        border-radius:5px;
        color:#ffffff;
        font-size:17px;
        background-color:rgba(8,100,255,0.9);
        outline:0;
        cursor: pointer; 
    }
    .auto-alert-terms
    {
        margin:10px 0;
        display:flex;
    }
    .auto-alert-terms a
    {
        color:rgba(8,100,255,0.9);
        font-size:15px;
    }
    .call-icon
    {
       
    }
    .call-icon img
    {
       width:85px;
       height:85px;
       border-radius:50%;
    }
    .exclPOnlyDeal { font-size:22px; font-weight:bold; letter-spacing:0.5px; }
    .foPopMob { background-image:linear-gradient(red, #bf0d00); display:inline-flex; justify-content:center; }
    .foPopMob>span { position:relative; display:inline-flex; padding-left:100px; color:white; padding-bottom:10px; padding-top:10px; }
    .foPopMob>span img { position:absolute; bottom:0; left:0; height:100px; }
    .foPopMob>span > span:first-child { font-size:12px; }
    .foPopMob>span > span:last-child { font-size:20px; }
    </style>  
      <div class="alert-screen-overlay">
            <div class="auto-fare-alert" onclick="changeText();" >
                <div class="auto-alert-close"><i class="fa fa-close"></i><span>EXCLUSIVE FLIGHT DEALS</span></div>
                
                 
                  <div ><img src="/resources/images/${pageResponse.pageValue}.png"></div>
                 
                 <div class="auto-alert-topic" style="text-align: center;">${pageResponse.pageName} 
                    
                </div>
                 <div class="call-icon"><img src="/resources/images/phone-call.png"></div>
                 <div class="exclPOnlyDeal">Exclusive Phone Only Deals</div>
                 
                 <div class="auto-alert-call-us" style="text-decoration:none !important;">
                    <span style="font-size:25px;text-decoration:none !important;background-color:#29932e;color:white !important">
                    <i class="fa fa-headphones" style="color:white !important;text-decoration:none !important"> &nbsp;
                   <c:choose>
            <c:when test="${pageResponse != null && pageResponse.tfnNo != null && pageResponse.tfnNo != ''}">
            ${pageResponse.tfnNo}
             </c:when>
            <c:otherwise>1-877-888-4546
            </c:otherwise>
            </c:choose>
            </i>
            </span>
        </div>
        <div class="foPopMob">
                    <span>
                        <img src="/resources/images/icons/csSup.png" alt="Image">
                        <span>
                            <span>CALL NOW TOLL FREE</span><br>
                            <span><i class="fa fa-phone"></i>
                                <c:choose>
                                    <c:when test="${pageResponse != null && pageResponse.tfnNo != null && pageResponse.tfnNo != ''}">
                                    ${pageResponse.tfnNo}
                                    </c:when>
                                    <c:otherwise>1-877-888-4546</c:otherwise>
                                </c:choose>
                            </span>
                        </span>
                    </span>
                </div>
             </div>
             <c:set var="tfns" value="+1-877-888-4546"/>
             <div class="fixed-call-bottom" style="display:none">
                  <c:choose>
            <c:when test="${pageResponse != null && pageResponse.tfnNo != null && pageResponse.tfnNo != ''}">
             <a href="tel:${pageResponse.tfnNo}"><img src="/resources/images/phone-call.png"></a>
              <c:set var="tfns" value="1${pageResponse.tfnNo}"/>
            <div>
            <div>Get Unpublished Flight Deals!</div>
            <div>${pageResponse.tfnNo}</div>
            </div>
           </c:when>
            <c:otherwise>
             <a href="tel:+1-877-888-4546"><img src="/resources/images/phone-call.png"></a>
               <div>
            <div>Get Unpublished Flight Deals!</div>
            <div>1-877-888-4546</div>
               </div>
            </c:otherwise>
            </c:choose>
       
        <i class="fa fa-close" style="visibility:hidden"></i>
    </div>
       </div>
        
        <script>$('.auto-alert-close i').click(function(){
        $('.alert-screen-overlay').hide();
    });
    setTimeout(function(){
         if ($(window).width() < 585) {
        $('.alert-screen-overlay').css("display","flex");
    }
    },2000);
    function changeText(){
         if ($(window).width() < 585) {
       window.open('tel:${tfns}');
    }
    }
    </script>
    