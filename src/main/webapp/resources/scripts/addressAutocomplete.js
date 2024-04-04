/**
 * @author Shruti
 */

//Google Maps address autocomplete API
function initAutocomplete() {
	//container element
	const containerElement = document.getElementById("addressAutofill");
	//input elements
	const addressInput = document.getElementById('paymentDetails_address1');
	const nearbyAddressInput = document.getElementById('paymentDetails_address2');
	const cityInput = document.getElementById('paymentDetails_city');
	const countryInput = document.getElementById('paymentDetails_Country');
	const stateInput1 = document.getElementById('paymentDetails_state1');
	const stateInput2 = document.getElementById('paymentDetails_state2');
	const postalCodeInput = document.getElementById('paymentDetails_postalCode');
    		
     var autocomplete = new google.maps.places.Autocomplete(addressInput, { types: ['geocode'] });
     
	 autocomplete.addListener('place_changed', function() {
		var place = autocomplete.getPlace();
		console.log(autocomplete.getPlace());
		
		var streetNum = getAddressComponent(place, 'street_number');
		var route = getAddressComponent(place, 'route');
		if(streetNum!="" && route!=""){
		addressInput.value = streetNum +" "+ route;
		}else if(streetNum!="" && route==""){ 
			addressInput.value = streetNum;
		}else if(streetNum=="" && route!=""){ 
			addressInput.value = route;
		}else{
			addressInput.value = getAddressComponent(place, 'sublocality_level_3') || getAddressComponent(place, 'sublocality_level_2') || 
			getAddressComponent(place, 'neighborhood') || getAddressComponent(place, 'sublocality')|| 
			getAddressComponent(place, 'locality')||getAddressComponent(place, 'administrative_area_level_2');
		}
		nearbyAddressInput.value =getAddressComponent(place, 'sublocality_level_1') ||getAddressComponent(place, 'neighborhood') ||getAddressComponent(place, 'sublocality');
		cityInput.value = getAddressComponent(place, 'locality') ||getAddressComponent(place, 'administrative_area_level_3')|| getAddressComponent(place, 'administrative_area_level_2');
		postalCodeInput.value = getAddressComponent(place, 'postal_code');

		//to set country from dropdown  (countryList in fpayment.js)
		var countryName = getAddressComponent(place, 'country');
		var scope = angular.element(countryInput).scope();
		var selectedCountry = '';
		var countryId = '';
		function findCountryByName(countryName) {
			for (var i = 0; i < scope.countryList.length; i++) {
				if (scope.countryList[i].Name === countryName) {
					countryId = scope.countryList[i].ID;
					return [ scope.countryList[i].ID, scope.countryList[i].Name ];
				}
			}
			return '0'; //'0' is the default value for "Select Country"
		}
		selectedCountry = findCountryByName(countryName);
		console.log("selectedCountry: " + selectedCountry);
		countryInput.value = countryId;
		$('#paymentDetails_Country').removeClass('ng-pristine ng-untouched has-error');
		$('#paymentDetails_Country').addClass('ng-dirty ng-valid-parse valid ng-touched');
		$('#paymentDetails_Country').attr("aria-required", true);
		$('#paymentDetails_Country').attr("aria-invalid", false);
		$('#paymentDetails_Country option[value="0"]').removeAttr('selected');
		$("#paymentDetails_Country").find('option[value="' + countryId + '"]').attr("selected", "selected");
		scope.selectedCountry = selectedCountry;
		scope.$apply();

		//to set states from dropdown  (usState in fpayment.js)
		function getSelectedStateList(countryId) {
			switch (countryId) {
			case "US":
				return scope.usaState;
			case "CA":
				scope.usState = scope.caState;
				return scope.caState;
			case "IN":
				scope.usState = scope.inState;
				return scope.inState;
			case "AU":
				scope.usState = scope.auState;
				return scope.auState;
			default:
				return scope.usaState;
			}
		}

		var stateName = getAddressComponent(place, 'administrative_area_level_1');
		var selectedStateList = getSelectedStateList(countryId);
		var stateId = "";
		var stateString = ";"
		function findStateByName(stateName, selectedStateList) {
			for (var i = 0; i < selectedStateList.length; i++) {
				if (selectedStateList[i].Name.toLowerCase().indexOf(stateName.toLowerCase()) !== -1 ||
					selectedStateList[i].ID.toLowerCase().indexOf(stateName.toLowerCase()) !== -1) {
					stateId = selectedStateList[i].ID;
					stateString = [ {
						'ID' : scope.countryList[i].ID,
						'Name' : scope.countryList[i].Name
					} ];
					return [ selectedStateList[i].ID, selectedStateList[i].Name ];
				}
			}
			return '0';
		}

		if (countryId == "US" || countryId == "CA" || countryId == "IN" || countryId == "AU") {
			var selectedState = findStateByName(stateName, selectedStateList);

			$("#paymentDetails_state2").val(stateId);
			$('#paymentDetails_state2').removeClass('ng-pristine ng-untouched has-error');
			$('#paymentDetails_state2').addClass('ng-dirty ng-valid-parse valid ng-touched');
			$('#paymentDetails_state2').attr("aria-required", true);
			$('#paymentDetails_state2').attr("aria-invalid", false);
			$('#paymentDetails_state2 option[value="0"]').removeAttr('selected');
			$("#paymentDetails_state2").find('option[value="' + stateId + '"]').attr("selected", "selected");

			$("#paymentDetails_state1").val('');
			$("#stateSel").removeClass("ng-hide");
			$("#stateSel").css("display", "block");
			$("#stateInp").css("display", "none");

			selectedCountry[2] = selectedState[0];
			selectedCountry[3] = selectedState[1];
			scope.selectedCountry = selectedCountry;
			scope.selectedItem = selectedCountry;
			scope.IsHidden = true;
			scope.IsShow = false;
		} else {
			scope.IsHidden = false;
			scope.IsShow = true;
			$("#stateSel").css("display", "none");
			$("#paymentDetails_state2").addClass('ng-pristine ng-untouched ng-valid ng-not-empty has-error');
			$("#paymentDetails_state2").find('option[value="0"]').attr("selected", true);
			$("#paymentDetails_state1").css("display", "block");
			$("#paymentDetails_state1").val(stateName);
			$("#stateInp").removeClass("ng-hide");
			$("#stateInp").css("display", "block");
		}

		scope.$apply();
		
		var clearButton = document.createElement("div");
		clearButton.classList.add("clear-button");
		clearButton.classList.add("visible");
		clearButton.innerHTML ="";
		
		clearButton.addEventListener("click", (e) => {
			e.stopPropagation();
			addressInput.value = '';
			nearbyAddressInput.value = '';
			cityInput.value = '';
			countryInput.value = 0;
			stateInput1.value = '';
			stateInput2.value = 0;
			postalCodeInput.value = '';
			$("#paymentDetails_Country option").removeAttr("selected", "selected");
			$("#paymentDetails_state2 option").removeAttr("selected", "selected");

			$("#paymentDetails_state2").addClass('has-error');
			$("#paymentDetails_state1").addClass('has-error');
			$("#paymentDetails_Country").addClass('has-error');
			$("#paymentDetails_address1").addClass('has-error');
			$("#paymentDetails_city").addClass('has-error');
			$("#paymentDetails_postalCode").addClass('has-error');
			clearButton.classList.remove("visible");
			containerElement.removeChild(clearButton);
		});

	    containerElement.appendChild(clearButton);
		
		if (stateInput1.value.length > 0) {
			$("#paymentDetails_state1").removeClass('has-error');
		}
		if (stateInput2.value.length > 0) {
			$("#paymentDetails_state2").removeClass('has-error');
		}
		if (addressInput.value.length > 0) {
		$("#paymentDetails_address1").removeClass('has-error');
		}
		if (countryInput.value.length > 0) {
			$("#paymentDetails_Country").removeClass('has-error');
		}
		if (cityInput.value.length > 0) {
		$("#paymentDetails_city").removeClass('has-error');
		}
		if (postalCodeInput.value.length > 0) {
			$("#paymentDetails_postalCode").removeClass('has-error');
		}
		
		$(".focus_input").each(function() {
			"" != $(this).val() && $(this).val().length > 0 ? $(this).parent().find(".not_focus_input").removeClass("apart_labl") : $(this).parent().find(".not_focus_input").addClass("apart_labl");
		})
		
	});
}

function getAddressComponent(place, component) {
	for (var i = 0; i < place.address_components.length; i++) {
		var types = place.address_components[i].types;
		if (types.indexOf(component) !== -1) {
			return place.address_components[i].long_name;
		}
	}
	return '';
}

//geoapify autocomplete adress API
function addressAutocomplete(containerElement, callback, options) {
	// input elements
	const addressInput = document.getElementById('paymentDetails_address1');
	const nearbyAddressInput = document.getElementById('paymentDetails_address2');
	const cityInput = document.getElementById('paymentDetails_city');
	const countryInput = document.getElementById('paymentDetails_Country');
	const stateInput1 = document.getElementById('paymentDetails_state1');
	const stateInput2 = document.getElementById('paymentDetails_state2');
	const postalCodeInput = document.getElementById('paymentDetails_postalCode');
	//var originalElementContent = document.getElementById('addressAutofill').cloneNode(true);

	// add input field clear button
	var clearButton = document.createElement("div");
	clearButton.classList.add("clear-button");
	addIcon(clearButton);
	clearButton.addEventListener("click", (e) => {
		e.stopPropagation();
		addressInput.value = '';
		nearbyAddressInput.value = '';
		cityInput.value = '';
		countryInput.value = 0;
		stateInput1.value = '';
		stateInput2.value = 0;
		postalCodeInput.value = '';
		$("#paymentDetails_Country option").removeAttr("selected", "selected");
		$("#paymentDetails_state2 option").removeAttr("selected", "selected");

		checkval('paymentDetails_address1', 'input', 'id');
		checkval('paymentDetails_city', 'input', 'id');
		checkval('paymentDetails_postalCode', 'input', 'id');
		checkval('paymentDetails_Country', 'select', 'id');
		checkval('paymentDetails_state1', 'input', 'id');
		checkval('paymentDetails_state2', 'select', 'id');

		$("#paymentDetails_state2").addClass('has-error');
		$("#paymentDetails_state1").addClass('has-error');
		$("#paymentDetails_Country").addClass('has-error');
		$("#paymentDetails_address1").addClass('has-error');
		$("#paymentDetails_city").addClass('has-error');
		$("#paymentDetails_postalCode").addClass('has-error');

		callback(null);
		clearButton.classList.remove("visible");
		closeDropDownList();
	});

	containerElement.appendChild(clearButton);

	/* Current autocomplete items data (GeoJSON.Feature) */
	var currentItems;

	/* Active request promise reject function. To be able to cancel the promise when a new request comes */
	var currentPromiseReject;

	/* Focused item in the autocomplete list. This variable is used to navigate with buttons */
	var focusedItemIndex;

	/* Execute a function when someone writes in the text field: */
	addressInput.addEventListener("input", function(e) {
		var currentValue = this.value;

		/* Close any already open dropdown list */
		closeDropDownList();

		// Cancel previous request promise
		if (currentPromiseReject) {
			currentPromiseReject({
				canceled : true
			});
		}

		if (!currentValue) {
			clearButton.classList.remove("visible");
			return false;
		}

		// Show clearButton when there is a text
		clearButton.classList.add("visible");

		/* Create a new promise and send geocoding request */
		var promise = new Promise((resolve, reject) => {
			currentPromiseReject = reject;

			var apiKey = "ddf01384a51d4327b785a64026d24b51";
			var url = `https://api.geoapify.com/v1/geocode/autocomplete?text=${encodeURIComponent(currentValue)}&apiKey=${apiKey}&filter=countrycode:us,ca,gb,au&fuzzyMatch=true`;

			if (options.type) {
				url += `&type=${options.type}`;
			}

			fetch(url)
				.then(response => {
					// check if the call was successful
					if (response.ok) {
						response.json().then(data => resolve(data));
					} else {
						response.json().then(data => reject(data));
					}
				});
		});

		promise.then((data) => {
			currentItems = data.features;

			if (data.features.length > 0) {
				/*create a DIV element that will contain the items (values):*/
				var autocompleteItemsElement = document.createElement("div");
				autocompleteItemsElement.setAttribute("class", "autocomplete-items");
				containerElement.appendChild(autocompleteItemsElement);

				/* For each item in the results */
				data.features.forEach((feature, index) => {
					/* Create a DIV element for each element: */
					var itemElement = document.createElement("SPAN");

					var iconElement = document.createElement('i');
					iconElement.className = 'fa fa-map-marker';

					/* Set formatted address as item value */
					var fullAddressOption = feature.properties.formatted;
					var formattedFullAddressOption = fullAddressOption.replace('(undefined)', '');
					itemElement.innerHTML = formattedFullAddressOption;

					/* Set the value for the autocomplete text field and notify: */
					itemElement.addEventListener("click", function(e) {
						/*var fullAddress = currentItems[index].properties.formatted;*/
						var addressLine1 = currentItems[index].properties.address_line1;
						var addressLine2 = currentItems[index].properties.address_line2;
						var formattedaddressLine1 = addressLine1.replace('(undefined)', '');
						var formattedaddressLine2 = addressLine2.replace('(undefined)', '');

						addressInput.value = formattedaddressLine1 || '';
						nearbyAddressInput.value = currentItems[index].properties.county || '';
						cityInput.value = currentItems[index].properties.city || currentItems[index].properties.county || currentItems[index].properties.suburb;
						stateInput1.value = currentItems[index].properties.state || '';
						postalCodeInput.value = currentItems[index].properties.postcode || '';

						if (stateInput1.value.length > 0) {
							$("#paymentDetails_state1").removeClass('has-error');
						}
						$("#paymentDetails_address1").removeClass('has-error');
						$("#paymentDetails_city").removeClass('has-error');
						if (postalCodeInput.value.length > 0) {
							$("#paymentDetails_postalCode").removeClass('has-error');
						}
						//to set country from dropdown  (countryList in fpayment.js)
						var countryName = currentItems[index].properties.country;
						var scope = angular.element(countryInput).scope();
						var selectedCountry = '';
						var countryId = '';
						function findCountryByName(countryName) {
							for (var i = 0; i < scope.countryList.length; i++) {
								if (scope.countryList[i].Name === countryName) {
									countryId = scope.countryList[i].ID;
									return [ scope.countryList[i].ID, scope.countryList[i].Name ];
								}
							}
							return '0'; //'0' is the default value for "Select Country"
						}
						selectedCountry = findCountryByName(countryName);
						console.log("selectedCountry" + selectedCountry);
						countryInput.value = countryId;
						$('#paymentDetails_Country').removeClass('ng-pristine ng-untouched has-error');
						$('#paymentDetails_Country').addClass('ng-dirty ng-valid-parse valid ng-touched');
						$('#paymentDetails_Country').attr("aria-required", true);
						$('#paymentDetails_Country').attr("aria-invalid", false);
						$('#paymentDetails_Country option[value="0"]').removeAttr('selected');
						$("#paymentDetails_Country").find('option[value="' + countryId + '"]').attr("selected", "selected");
						scope.selectedCountry = selectedCountry;
						scope.$apply();

						//to set states from dropdown  (usState in fpayment.js)
						function getSelectedStateList(countryId) {
							switch (countryId) {
							case "US":
								return scope.usaState;
							case "CA":
								scope.usState = scope.caState;
								return scope.caState;
							case "IN":
								scope.usState = scope.inState;
								return scope.inState;
							case "AU":
								scope.usState = scope.auState;
								return scope.auState;
							default:
								return scope.usState;
							}
						}

						var stateName = currentItems[index].properties.state;
						var selectedStateList = getSelectedStateList(countryId);
						var stateId = "";
						var stateString = ";"
						function findStateByName(stateName, selectedStateList) {
							for (var i = 0; i < selectedStateList.length; i++) {
								if (selectedStateList[i].Name.toLowerCase().indexOf(stateName.toLowerCase()) !== -1 ||
									selectedStateList[i].ID.toLowerCase().indexOf(stateName.toLowerCase()) !== -1) {
									stateId = selectedStateList[i].ID;
									stateString = [ {
										'ID' : scope.countryList[i].ID,
										'Name' : scope.countryList[i].Name
									} ];
									return [ selectedStateList[i].ID, selectedStateList[i].Name ];
								}
							}
							return '0';
						}

						if (countryId == "US" || countryId == "CA" || countryId == "IN" || countryId == "AU") {
							var selectedState = findStateByName(stateName, selectedStateList);

							$("#paymentDetails_state2").val(stateId);
							$('#paymentDetails_state2').removeClass('ng-pristine ng-untouched has-error');
							$('#paymentDetails_state2').addClass('ng-dirty ng-valid-parse valid ng-touched');
							$('#paymentDetails_state2').attr("aria-required", true);
							$('#paymentDetails_state2').attr("aria-invalid", false);
							$('#paymentDetails_state2 option[value="0"]').removeAttr('selected');
							$("#paymentDetails_state2").find('option[value="' + stateId + '"]').attr("selected", "selected");
							$("#paymentDetails_state1").val('');
							$("#stateSel").removeClass("ng-hide");
							$("#stateSel").css("display", "block");
							$("#stateInp").css("display", "none");

							selectedCountry[2] = selectedState[0];
							selectedCountry[3] = selectedState[1];
							scope.selectedCountry = selectedCountry;
							scope.selectedItem = selectedCountry;
							scope.IsHidden = true;
							scope.IsShow = false;
						} else {
							scope.IsHidden = false;
							scope.IsShow = true;
							$("#stateSel").css("display", "none");
							$("#paymentDetails_state2").addClass('ng-pristine ng-untouched ng-valid ng-not-empty has-error');
							$("#paymentDetails_state2").find('option[value="0"]').attr("selected", true);
							$("#paymentDetails_state1").css("display", "block");
							$("#paymentDetails_state1").val(stateName);
							$("#paymentDetails_state2").val(0);
							$("#stateInp").removeClass("ng-hide");
							$("#stateInp").css("display", "block");
						}

						scope.$apply();

						checkval('paymentDetails_address1', 'input', 'id');
						checkval('paymentDetails_city', 'input', 'id');
						checkval('paymentDetails_postalCode', 'input', 'id');
						checkval('paymentDetails_Country', 'select', 'id');
						checkval('paymentDetails_state1', 'input', 'id');
						checkval('paymentDetails_state2', 'select', 'id');
						$(".focus_input").each(function() {
							"" != $(this).val() && $(this).val().length > 3 ? $(this).parent().find(".not_focus_input").removeClass("apart_labl") : $(this).parent().find(".not_focus_input").addClass("apart_labl");
						})

						callback(currentItems[index]);

						/* Close the list of autocompleted values: */
						closeDropDownList();
					});
					itemElement.appendChild(iconElement);
					autocompleteItemsElement.appendChild(itemElement);


				});
			}
		}, (err) => {
			if (!err.canceled) {
				console.log(err);
			}
		});
	});

	/* Add support for keyboard navigation */
	addressInput.addEventListener("keydown", function(e) {
		var autocompleteItemsElement = containerElement.querySelector(".autocomplete-items");
		if (autocompleteItemsElement) {
			var itemElements = autocompleteItemsElement.getElementsByTagName("div");
			if (e.keyCode == 40) {
				e.preventDefault();
				/*If the arrow DOWN key is pressed, increase the focusedItemIndex variable:*/
				focusedItemIndex = focusedItemIndex !== itemElements.length - 1 ? focusedItemIndex + 1 : 0;
				/*and and make the current item more visible:*/
				setActive(itemElements, focusedItemIndex);
			} else if (e.keyCode == 38) {
				e.preventDefault();

				/*If the arrow UP key is pressed, decrease the focusedItemIndex variable:*/
				focusedItemIndex = focusedItemIndex !== 0 ? focusedItemIndex - 1 : focusedItemIndex = (itemElements.length - 1);
				/*and and make the current item more visible:*/
				setActive(itemElements, focusedItemIndex);
			} else if (e.keyCode == 13) {
				/* If the ENTER key is pressed and value as selected, close the list*/
				e.preventDefault();
				if (focusedItemIndex > -1) {
					closeDropDownList();
				}
			}
		} else {
			if (e.keyCode == 40) {
				/* Open dropdown list again */
				var event = document.createEvent('Event');
				event.initEvent('input', true, true);
				addressInput.dispatchEvent(event);
			}
		}
	});

	function setActive(items, index) {
		if (!items || !items.length) return false;

		for (var i = 0; i < items.length; i++) {
			items[i].classList.remove("autocomplete-active");
		}

		/* Add class "autocomplete-active" to the active element*/
		items[index].classList.add("autocomplete-active");

		// Change input value and notify
		var fullAddress = currentItems[index].properties.formatted;
		var formattedFullAddress = fullAddress.replace('(undefined)', '');
		addressInput.value = formattedFullAddress;
		callback(currentItems[index]);
	}

	function closeDropDownList() {
		var autocompleteItemsElement = containerElement.querySelector(".autocomplete-items");
		if (autocompleteItemsElement) {
			containerElement.removeChild(autocompleteItemsElement);
		}

		focusedItemIndex = -1;
	}

	function addIcon(buttonElement) {
		var svgElement = document.createElementNS("http://www.w3.org/2000/svg", 'svg');
		svgElement.setAttribute('viewBox', "0 0 24 24");
		svgElement.setAttribute('height', "24");

		var iconElement = document.createElementNS("http://www.w3.org/2000/svg", 'path');
		iconElement.setAttribute("d", "M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z");
		iconElement.setAttribute('fill', 'currentColor');
		svgElement.appendChild(iconElement);
		buttonElement.appendChild(svgElement);
	}

	/* Close the autocomplete dropdown when the document is clicked. 
  	Skip, when a user clicks on the input field */
	document.addEventListener("click", function(e) {
		if (e.target !== addressInput) {
			closeDropDownList();
		} else if (!containerElement.querySelector(".autocomplete-items")) {
			// open dropdown list again
			var event = document.createEvent('Event');
			event.initEvent('input', true, true);
			addressInput.dispatchEvent(event);
		}
	});

}