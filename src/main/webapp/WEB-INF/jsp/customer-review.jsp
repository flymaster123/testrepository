<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<div class="star_select" id="ratingdis0"></div>
<script type="text/javascript">
            var rating = 5
            rating = Math.round(rating * 2) / 2;
            output = [];

            // Append all the filled whole stars
            for (var i = rating; i >= 1; i--)
               output.push('<i class="fa fa-star" style="color:#3b5998;font-size:18px;margin-right:2px;" aria-hidden="true"></i>');

            // If there is a half a star, append it
            if (i == .5) output.push('<i class="fa fa-star-half-o" style="color:#3b5998;font-size:18px;margin-right:2px;" aria-hidden="true"></i>');

            // Fill the empty stars
            for (let i = (5 - rating); i >= 1; i--)
               output.push('<i class="fa fa-star-o" style="font-size:18px;margin-right:2px;" aria-hidden="true"></i>');
            //console.log(output);
            //$("#ratingdis0").html(output.join(''));

         </script>

<div class="sreviews-container">
	<c:if test="${reviewResponse.size() > 0}">
		<div class="review-heading">
			<span>Reviews & Ratings</span>
		</div>
	</c:if>
	<c:forEach var="review" items="${reviewResponse}">
		<div class="sreviews">
			<div class="suser-info">
				<!-- <img src="/resources/images/user.jpg"> -->
				<div class="suser-name-ago">
					<div class="suname">${review.userName}</div>
					<div class="suago">${review.reviewUrl}ago</div>
				</div>
			</div>
			<div class="sustar-rating">

				<c:set var="startRating" value="${review.reviewRating/2}" />

				<c:set var="half" value="false" />
				<c:if
					test="${fn:contains(startRating,'.') && fn:split(startRating,'.')[1] > 0}">
					<c:set var="half" value="true" />
					<c:set var="startRating" value="${fn:split(startRating,'.')[0]}" />
				</c:if>

				<c:forEach begin="1" end="${startRating}">
					<i class="fa fa-star" style="color:#ff4500;"></i>
				</c:forEach>
				<c:if test="${half == 'true'}">
					<span style="position:relative;"> <i class="fa fa-star"></i>
						<i class="fa fa-star-half"
						style="color:#ff4500;position:absolute;left:0;"></i>
					</span>
					<c:set var="startRating" value="${startRating+1}" />
				</c:if>
				<c:forEach end="5" begin="${startRating+1}">
					<i class="fa fa-star"></i>
				</c:forEach>

			</div>
			<div class="sucomment">${review.reviewMessage}</div>
		</div>
	</c:forEach>
</div>

<form name="reviewForm" id="reviewForm" action="/review/submit"
	method="post">
	<div class="customer-review-container">
		<div class="crsub-container">
			<div class="customer-review-form">
				<div class="crhead">Customer Review</div>
				<div class="crfhead">Leave a Comment</div>
				<fieldset class="rate">
					<input type="radio" id="rating10" name="rating" value="10" /><label
						for="rating10" title="5 stars"></label> <input type="radio"
						id="rating9" name="rating" value="9" /><label class="half"
						for="rating9" title="4 1/2 stars"></label> <input type="radio"
						id="rating8" name="rating" value="8" /><label for="rating8"
						title="4 stars"></label> <input type="radio" id="rating7"
						name="rating" value="7" /><label class="half" for="rating7"
						title="3 1/2 stars"></label> <input type="radio" id="rating6"
						name="rating" value="6" /><label for="rating6" title="3 stars"></label>
					<input type="radio" id="rating5" name="rating" value="5" /><label
						class="half" for="rating5" title="2 1/2 stars"></label> <input
						type="radio" id="rating4" name="rating" value="4" /><label
						for="rating4" title="2 stars"></label> <input type="radio"
						id="rating3" name="rating" value="3" /><label class="half"
						for="rating3" title="1 1/2 stars"></label> <input type="radio"
						id="rating2" name="rating" value="2" /><label for="rating2"
						title="1 star"></label> <input type="radio" id="rating1"
						name="rating" value="1" /><label class="half" for="rating1"
						title="1/2 star"></label>
				</fieldset>
				<div class="cname-email">
					<input type="text" placeholder="Your Name" name="customerName"
						id="customerName" class="textOnly" /> <input type="email"
						placeholder="Your Email" name="customerEmail" id="customerEmail" />
				</div>
				<div class="ccomment-box">
					<textarea type="text" placeholder="Comment Here"
						name="customerReview" id="customerReview"></textarea>
				</div>
				<div class="crsubmit">
					<button type="submit">Submit</button>
				</div>
				<div id="reviewSuccess"></div>
			</div>
		</div>
	</div>
</form>

<script>
            $('.textOnly').keyup(function () {
               if (this.value != this.value.replace(/[^a-zA-Z ]+/g, '')) {
                  this.value = this.value.replace(/[^a-zA-Z ]+/g, '');
               }
            });
            $("#reviewForm").validate({
               rules: {
                  rating: {
                     required: true
                  },
                  customerName: {
                     required: true
                  },
                  customerEmail: {
                     required: true,
                     email: true
                  },
                  customerReview: {
                     required: true
                  }
               },
               errorPlacement: function (error, element) { },
               submitHandler: function (form) {
                  var rating = $("input[name='rating']:checked").val();
                  if (rating == undefined) {
                     alert("Please Select Star Rating")
                     return false;
                  }

                  var data = {
                     userName: $("#customerName").val(),
                     userEmail: $("#customerEmail").val(),
                     reviewMessage: $("#customerReview").val(),
                     reviewRating: rating,
                     reviewUrl: $("#pageUrl").val()
                  }
                  $.ajax({
                     url: '/review/submit',
                     type: 'post',
                     contentType: 'application/json; charset=utf-8',
                     data: JSON.stringify(data),
                     dataType: "text",
                     success: function (response) {
                        var reviewRes = JSON.parse(response);
                        if (reviewRes.baseResponse.status == 1)
                           $("#reviewSuccess").text("Review Added Successfully!").css("color", "green");
                        // userName: $("#customerName").val(" ");
                        // userEmail: $("#customerEmail").val(" ");
                        // reviewMessage : $("#customerReview").val(" ");
                        document.getElementById("reviewForm").reset();
                        // else
                        // $("#reviewSuccess").text("Some Technical Issue Please try later!").css("color", "red");	
                     },
                     error: function (data) {
                        $("#reviewSuccess").text("Some Technical Issue Please try later!").css("color", "red");
                     }
                  });


               }
            })

         </script>