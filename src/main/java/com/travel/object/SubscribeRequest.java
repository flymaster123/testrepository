package com.travel.object;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "url", "date", "emailId", "status", "siteId", "userCountry", "userIp" })

public class SubscribeRequest {

	@JsonProperty("url")
	private String url;
	@JsonProperty("date")
	private String date;
	@JsonProperty("emailId")
	private String emailid;
	@JsonProperty("status")
	private String status;
	@JsonProperty("siteId")
	private Integer siteId;
	@JsonProperty("userCountry")
	private String userCountry;
	@JsonProperty("userIp")
	private String userIp;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getEmailid() {
		return emailid;
	}

	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getSiteId() {
		return siteId;
	}

	public void setSiteId(Integer siteId) {
		this.siteId = siteId;
	}

	public String getUserCountry() {
		return userCountry;
	}

	public void setUserCountry(String country) {
		this.userCountry = country;
	}

	public String getUserIp() {
		return userIp;
	}

	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}

}
