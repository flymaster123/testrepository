var width="";
    $( document ).ready(function() { 
    	width=$(window).width();
        
    });

    $(window).load(function(){
        $('input:radio[class="Basic"]').prop('checked', true);
        
        var upgradeTaken = $("#upgradeTaken").val();
        var amt = $("#upgradeAmount").val();
        var plan = $("#upgradePlan").val();
        
        if($("#upgradeTaken").val()=='Yes'){
        	addUpgradeProduct(plan, amt);
        }
        
    });

    function setAncillaries(ancillariesType, value, status){
    	var currencySymbol = "$";
    	var tgfareLadder = $("#tgfareladder");
    	var fareladder_pdp = $("#fareladder_pdp");
    	var fareladder_ta = $("#fareladder_ta");
    	var fareladder_up = $("#fareladder_up");
    	var travelGuardCost = $("#travelGuardCost").val();;
    	var priceDropAmount = $("#priceDropAmount").val();
    	var travelAssistAmount = $("#travelAssistAmount").val();
    	var upgradeAmount = $("#upgradeAmount").val();
    	var grandTotal = $("#grandTotal").val(); 
    	var totalPrice = grandTotal;
    	var webcheckincost = $("#webcheckincost").val();
    	var fareladder_web = $("#fareladder_web");
    	
    	if(travelGuardCost == "NaN" || travelGuardCost == null){
    		travelGuardCost = Number(0.00);
    	}
    	
    	if(ancillariesType=='TG'){
    		if(status=='Y'){
    			tgfareLadder.slideDown(200);
    			$("#tgOption").val("Yes");
    			$("#tgValue").val(travelGuardCost);
    			$("#travelGuardYes").val("Yes");
    			$("#travelGuard").val("Yes");
    			var myDiVElem = document.getElementById("tg_price");
    			myDiVElem.innerHTML = currencySymbol+parseFloat(travelGuardCost).toFixed(2);
    			totalPrice = Number(travelGuardCost)+Number(grandTotal)+Number(priceDropAmount)+Number(travelAssistAmount)+Number(webcheckincost);
    		}
    		else{
    			tgfareLadder.slideUp(200);
    			$("#tgOption").val("No");
    			$("#tgValue").val(0.00);
    			$("#travelGuardNo").val("No");
    			$("#travelGuard").val("No");
    			travelGuardCost=0.00;
    			var myDiVElem = document.getElementById("tg_price");
    			myDiVElem.innerHTML = currencySymbol+parseFloat(travelGuardCost).toFixed(2);
    			totalPrice = Number(travelGuardCost)+Number(grandTotal)+Number(priceDropAmount)+Number(travelAssistAmount)+Number(webcheckincost);
    		}
    	}
    	else if(ancillariesType=='PDP'){
    		if(status=='Y'){
    			fareladder_pdp.slideDown(200);
    			$("#priceDropTaken").val("Yes");
    			$("#addPdp").hide();
    			$("#removePdp").show();
    			var myDiVElem = document.getElementById("pdp_price");
    			myDiVElem.innerHTML = currencySymbol+parseFloat(priceDropAmount).toFixed(2);
    			totalPrice = Number(travelGuardCost)+Number(grandTotal)+Number(priceDropAmount)+Number(travelAssistAmount)+Number(webcheckincost);
    		}
    		else{
    			fareladder_pdp.slideUp(200);
    			$("#priceDropTaken").val("No");
    			$("#addPdp").show();
    			$("#removePdp").hide();
    			priceDropAmount = 0.00;
    			var myDiVElem = document.getElementById("pdp_price");
    			myDiVElem.innerHTML = currencySymbol+parseFloat(priceDropAmount).toFixed(2);
    			totalPrice = Number(travelGuardCost)+Number(grandTotal)+Number(priceDropAmount)+Number(travelAssistAmount)+Number(webcheckincost);
    		}
    	}
    	else if(ancillariesType=='TA'){
    		if(status=='Y'){
    			fareladder_ta.slideDown(200);
    			$("#travelAssistTaken").val("Yes");
    			var myDiVElem = document.getElementById("ta_price");
    			myDiVElem.innerHTML = currencySymbol+parseFloat(travelAssistAmount).toFixed(2);
    			totalPrice = Number(travelGuardCost)+Number(grandTotal)+Number(priceDropAmount)+Number(travelAssistAmount)+Number(webcheckincost);
    		}
    		else{
    			fareladder_ta.slideUp(200);
    			$("#travelAssistTaken").val("No");
    			travelAssistAmount = 0.00;
    			var myDiVElem = document.getElementById("ta_price");
    			myDiVElem.innerHTML = currencySymbol+parseFloat(travelAssistAmount).toFixed(2);
    			totalPrice = Number(travelGuardCost)+Number(grandTotal)+Number(priceDropAmount)+Number(travelAssistAmount)+Number(webcheckincost);
    		}
    	}
    	else if(ancillariesType=='UP'){
    		if(status=='Y'){
    			fareladder_up.slideDown(200);
    			$("#upgradeTaken").val("Yes");
    			var myDiVElem = document.getElementById("up_price");
    			myDiVElem.innerHTML = currencySymbol+parseFloat(upgradeAmount).toFixed(2);
    			totalPrice = Number(travelGuardCost)+Number(grandTotal)+Number(priceDropAmount)+Number(travelAssistAmount)+Number(upgradeAmount)+Number(webcheckincost);
    		}
    		else{
    			fareladder_up.slideUp(200);
    			$("#upgradeTaken").val("No");
    			upgradeAmount = 0.00;
    			var myDiVElem = document.getElementById("up_price");
    			myDiVElem.innerHTML = currencySymbol+parseFloat(Number(upgradeAmount)).toFixed(2);
    			totalPrice = Number(travelGuardCost)+Number(grandTotal)+Number(priceDropAmount)+Number(travelAssistAmount)+Number(upgradeAmount)+Number(webcheckincost);
    		}
    	}
    	else if(ancillariesType=='Web'){
    		if(status=='Y'){
    			fareladder_web.slideDown(200);
    			$("#webcheckin").val("Yes");
    			$("#webcheckinYes").val("Yes");
    			var myDiVElem = document.getElementById("web_price");
    			myDiVElem.innerHTML = currencySymbol+parseFloat(webcheckincost).toFixed(2);
    			totalPrice = Number(travelGuardCost)+Number(grandTotal)+Number(priceDropAmount)+Number(travelAssistAmount)+Number(upgradeAmount)+Number(webcheckincost);
    		}
    		else{
    			fareladder_web.slideUp(200);
    			$("#webcheckin").val("No");
    			$("#webcheckinNo").val("No");
    			webcheckincost = 0.00;
    			var myDiVElem = document.getElementById("web_price");
    			myDiVElem.innerHTML = currencySymbol+parseFloat(webcheckincost).toFixed(2);
    			totalPrice = Number(travelGuardCost)+Number(grandTotal)+Number(priceDropAmount)+Number(travelAssistAmount)+Number(upgradeAmount)+Number(webcheckincost);
    		}
    	}
    	var myDiVElem = document.getElementById("total_price");
		myDiVElem.innerHTML = currencySymbol+parseFloat(totalPrice).toFixed(2);
		var myDiVElemMobile = document.getElementById("total_price_mobile");
		myDiVElemMobile.innerHTML = currencySymbol+parseFloat(totalPrice).toFixed(2);
    	/* document.getElementById("total_price").innerHTML = currencySymbol+parseFloat(totalPrice).toFixed(2); */
    	
    } 

    function flightProduct(status, amount){
    	if(status=='Add'){
    		/*$("#priceDropAmount").val(Number(amount));*/
        $("#priceDropAmount").val(Number(amount*document.getElementById("totalPax").value));
    		
    		$("#priceDropTaken").val("Yes");
    		setAncillaries('PDP',Number(amount),'Y');
    	}
    	else{
    		$("#priceDropAmount").val(Number(0.0));
    		$("#priceDropTaken").val("No");
    		setAncillaries('PDP',0.0,'N');
    	}
    }

    function setTG(status, amount){
    	if(status=='Add'){
    		$("#travelGuardCost").val(Number(amount));
    		$("#travelGuard").val("Yes");
    		setAncillaries('TG',Number(amount),'Y');
    	}
    	else{
    		$("#travelGuardCost").val(Number(0.0));
    		$("#travelGuard").val("No");
    		setAncillaries('TG',0.0,'N');
    	}
    }

    function setWebcheck(status, amount){
    	var totalPax = $("#totalPax").val();
    	var tripType = $("#tripType").val();
    	amount = Number(amount)*Number(totalPax)*Number(tripType);
    	if(status=='Add'){
    		$("#webcheckincost").val(Number(amount));
    		$("#webcheckin").val("Yes");
    		setAncillaries('Web',Number(amount),'Y');
    		$("#addwebcheck").hide();
    		$("#removewebcheck").show();
    	}
    	else{
    		$("#webcheckincost").val(Number(0.0));
    		$("#webcheckin").val("No");
    		setAncillaries('Web',0.0,'N');
    		$("#addwebcheck").show();
    		$("#removewebcheck").hide();
    	}
    }

    function addTravelAssist(name, amount){
    	$('input:radio[class='+name+']').prop('checked', true);
    	if(name!='Basic'){
    		$("#travelAssistAmount").val(Number(amount*document.getElementById("totalPax").value));
    		$("#travelAssistTaken").val("Yes");
    		$("#planName").text(name);
    		setAncillaries('TA',Number(amount),'Y');
    	}else{
    		$(".Basic").prop('checked', true);
    		$("#travelAssistAmount").val(Number(0.0));
    		$("#travelAssistTaken").val("No");
    		$("#planName").text("");
    		setAncillaries('TA',0.0,'N');
    	}
    }

    function addUpgradeProduct(name, amount){
    	$("#upgradeAmount").val(Number(amount));
    	$("#upgradeTaken").val("Yes");
    	$("#upgradePlanName").text(name);
    	$("#upgradePlan").val(name);
    	setAncillaries('UP',Number(amount),'Y');
    	var amt = Number(amount);
    	$.get("/addUpgrade?amount="+amt, function(data){});
    }

    function removeUpgradeProduct(){
    	$("#upgradeAmount").val(0.00);
    	$("#upgradeTaken").val("No");
    	$("#upgradePlanName").text("");
    	$("#upgradePlan").val("Current");
    	setAncillaries('UP',0.0,'N');
    	$.get("/removeUpgrade", function(data){});
    }

    function upgradeProduct(status, name, amount, index){
    	var elems = document.querySelectorAll(".active");
    	[].forEach.call(elems, function(el) {
    	    el.classList.remove("active");
    	});
    	$("#fareID"+index).addClass("active");
    	
    	if(status=='Add'){
    		addUpgradeProduct(name, amount);
    	}
    	else{
    		removeUpgradeProduct();
    	}
    }