package com.travel.object.flightresponse;

import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import java.util.HashMap;
import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.Map;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "adultFare", "childFare", "infantFare", "infantWsFare", "adultTax", "childTax", "infantTax", "infantWsTax", "adultMarkup", "childMarkup", "infantMarkup", "infantWsMarkup", "bagFees", "grandTotal", "markupID", "markupType", "totalMarkup", "grandOrgTotal", "baseFare", "totalTax" })
public class Fare
{
    @JsonProperty("adultFare")
    private Double adultFare;
    @JsonProperty("childFare")
    private Double childFare;
    @JsonProperty("infantFare")
    private Double infantFare;
    @JsonProperty("infantWsFare")
    private Double infantWsFare;
    @JsonProperty("adultTax")
    private Double adultTax;
    @JsonProperty("childTax")
    private Double childTax;
    @JsonProperty("infantTax")
    private Double infantTax;
    @JsonProperty("infantWsTax")
    private Double infantWsTax;
    @JsonProperty("adultMarkup")
    private Double adultMarkup;
    @JsonProperty("childMarkup")
    private Double childMarkup;
    @JsonProperty("infantMarkup")
    private Double infantMarkup;
    @JsonProperty("infantWsMarkup")
    private Double infantWsMarkup;
    @JsonProperty("bagFees")
    private Double bagFees;
    @JsonProperty("grandTotal")
    private Double grandTotal;
    @JsonProperty("markupID")
    private Integer markupID;
    @JsonProperty("markupType")
    private String markupType;
    @JsonProperty("totalMarkup")
    private Double totalMarkup;
    @JsonProperty("grandOrgTotal")
    private Double grandOrgTotal;
    @JsonProperty("baseFare")
    private Double baseFare;
    @JsonProperty("totalTax")
    private Double totalTax;
    @JsonIgnore
    private Map<String, Object> additionalProperties;
    
    public Fare() {
        this.additionalProperties = new HashMap<String, Object>();
    }
    
    @JsonProperty("adultFare")
    public Double getAdultFare() {
        return this.adultFare;
    }
    
    @JsonProperty("adultFare")
    public void setAdultFare(final Double adultFare) {
        this.adultFare = adultFare;
    }
    
    @JsonProperty("childFare")
    public Double getChildFare() {
        return this.childFare;
    }
    
    @JsonProperty("childFare")
    public void setChildFare(final Double childFare) {
        this.childFare = childFare;
    }
    
    @JsonProperty("infantFare")
    public Double getInfantFare() {
        return this.infantFare;
    }
    
    @JsonProperty("infantFare")
    public void setInfantFare(final Double infantFare) {
        this.infantFare = infantFare;
    }
    
    @JsonProperty("infantWsFare")
    public Double getInfantWsFare() {
        return this.infantWsFare;
    }
    
    @JsonProperty("infantWsFare")
    public void setInfantWsFare(final Double infantWsFare) {
        this.infantWsFare = infantWsFare;
    }
    
    @JsonProperty("adultTax")
    public Double getAdultTax() {
        return this.adultTax;
    }
    
    @JsonProperty("adultTax")
    public void setAdultTax(final Double adultTax) {
        this.adultTax = adultTax;
    }
    
    @JsonProperty("childTax")
    public Double getChildTax() {
        return this.childTax;
    }
    
    @JsonProperty("childTax")
    public void setChildTax(final Double childTax) {
        this.childTax = childTax;
    }
    
    @JsonProperty("infantTax")
    public Double getInfantTax() {
        return this.infantTax;
    }
    
    @JsonProperty("infantTax")
    public void setInfantTax(final Double infantTax) {
        this.infantTax = infantTax;
    }
    
    @JsonProperty("infantWsTax")
    public Double getInfantWsTax() {
        return this.infantWsTax;
    }
    
    @JsonProperty("infantWsTax")
    public void setInfantWsTax(final Double infantWsTax) {
        this.infantWsTax = infantWsTax;
    }
    
    @JsonProperty("adultMarkup")
    public Double getAdultMarkup() {
        return this.adultMarkup;
    }
    
    @JsonProperty("adultMarkup")
    public void setAdultMarkup(final Double adultMarkup) {
        this.adultMarkup = adultMarkup;
    }
    
    @JsonProperty("childMarkup")
    public Double getChildMarkup() {
        return this.childMarkup;
    }
    
    @JsonProperty("childMarkup")
    public void setChildMarkup(final Double childMarkup) {
        this.childMarkup = childMarkup;
    }
    
    @JsonProperty("infantMarkup")
    public Double getInfantMarkup() {
        return this.infantMarkup;
    }
    
    @JsonProperty("infantMarkup")
    public void setInfantMarkup(final Double infantMarkup) {
        this.infantMarkup = infantMarkup;
    }
    
    @JsonProperty("infantWsMarkup")
    public Double getInfantWsMarkup() {
        return this.infantWsMarkup;
    }
    
    @JsonProperty("infantWsMarkup")
    public void setInfantWsMarkup(final Double infantWsMarkup) {
        this.infantWsMarkup = infantWsMarkup;
    }
    
    @JsonProperty("bagFees")
    public Double getBagFees() {
        return this.bagFees;
    }
    
    @JsonProperty("bagFees")
    public void setBagFees(final Double bagFees) {
        this.bagFees = bagFees;
    }
    
    @JsonProperty("grandTotal")
    public Double getGrandTotal() {
        return this.grandTotal;
    }
    
    @JsonProperty("grandTotal")
    public void setGrandTotal(final Double grandTotal) {
        this.grandTotal = grandTotal;
    }
    
    @JsonProperty("markupID")
    public Integer getMarkupID() {
        return this.markupID;
    }
    
    @JsonProperty("markupID")
    public void setMarkupID(final Integer markupID) {
        this.markupID = markupID;
    }
    
    @JsonProperty("markupType")
    public String getMarkupType() {
        return this.markupType;
    }
    
    @JsonProperty("markupType")
    public void setMarkupType(final String markupType) {
        this.markupType = markupType;
    }
    
    @JsonProperty("totalMarkup")
    public Double getTotalMarkup() {
        return this.totalMarkup;
    }
    
    @JsonProperty("totalMarkup")
    public void setTotalMarkup(final Double totalMarkup) {
        this.totalMarkup = totalMarkup;
    }
    
    @JsonProperty("grandOrgTotal")
    public Double getGrandOrgTotal() {
        return this.grandOrgTotal;
    }
    
    @JsonProperty("grandOrgTotal")
    public void setGrandOrgTotal(final Double grandOrgTotal) {
        this.grandOrgTotal = grandOrgTotal;
    }
    
    @JsonProperty("baseFare")
    public Double getBaseFare() {
        return this.baseFare;
    }
    
    @JsonProperty("baseFare")
    public void setBaseFare(final Double baseFare) {
        this.baseFare = baseFare;
    }
    
    @JsonProperty("totalTax")
    public Double getTotalTax() {
        return this.totalTax;
    }
    
    @JsonProperty("totalTax")
    public void setTotalTax(final Double totalTax) {
        this.totalTax = totalTax;
    }
    
    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }
    
    @JsonAnySetter
    public void setAdditionalProperty(final String name, final Object value) {
        this.additionalProperties.put(name, value);
    }
}
