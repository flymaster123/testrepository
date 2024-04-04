<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page pageEncoding="UTF-8" %>

<div class="country-dropdown">
    <ul>
        <li><a href="javascript:void(0)"><img class="flag-icon" src="/resources/images/icons/usa-flag.png" alt="usa-flag" width="20" height="20"> USA</a>
            <ul>
                <li><a href="https://uk.lowtickets.com/"><img class="flag-icon" src="/resources/images/icons/uk-flag.png" alt="uk-flag" width="20" height="20">Uk</a></li>
                <li><a href="https://ca.lowtickets.com/"><img class="flag-icon" src="/resources/images/icons/ca-flag.png" alt="ca-flag" width="20" height="20">Canada</a></li>
                <li><a href="https://mx.lowtickets.com/"><img class="flag-icon" src="/resources/images/icons/mexico-flag.png" alt="mexico-flag" width="20" height="20"> Mexico</a></li>
            </ul>
        </li>
    </ul>
</div>



<script>
    $(document).ready(function(){
        $(document).click(function() {
             $(".country-dropdown ul ul").removeClass("country-dropdown-show");
        });

        $(".country-dropdown ul").click(function(event) {
            $(".country-dropdown ul ul").toggleClass("country-dropdown-show"); 
            event.stopPropagation();
        });
    });
</script>