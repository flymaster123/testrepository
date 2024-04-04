
package com.travel.object.faq;

import java.util.LinkedHashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "id",
    "siteId",
    "question",
    "answer",
    "pageType",
    "url",
    "faqStatus",
    "modifiedDate",
    "modifyBy"
})
@Generated("jsonschema2pojo")
public class Response {

    @JsonProperty("id")
    private Integer id;
    @JsonProperty("siteId")
    private Integer siteId;
    @JsonProperty("question")
    private String question;
    @JsonProperty("answer")
    private String answer;
    @JsonProperty("pageType")
    private String pageType;
    @JsonProperty("url")
    private String url;
    @JsonProperty("faqStatus")
    private String faqStatus;
    @JsonProperty("modifiedDate")
    private String modifiedDate;
    @JsonProperty("modifyBy")
    private String modifyBy;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();

    @JsonProperty("id")
    public Integer getId() {
        return id;
    }

    @JsonProperty("id")
    public void setId(Integer id) {
        this.id = id;
    }

    @JsonProperty("siteId")
    public Integer getSiteId() {
        return siteId;
    }

    @JsonProperty("siteId")
    public void setSiteId(Integer siteId) {
        this.siteId = siteId;
    }

    @JsonProperty("question")
    public String getQuestion() {
        return question;
    }

    @JsonProperty("question")
    public void setQuestion(String question) {
        this.question = question;
    }

    @JsonProperty("answer")
    public String getAnswer() {
        return answer;
    }

    @JsonProperty("answer")
    public void setAnswer(String answer) {
        this.answer = answer;
    }

    @JsonProperty("pageType")
    public String getPageType() {
        return pageType;
    }

    @JsonProperty("pageType")
    public void setPageType(String pageType) {
        this.pageType = pageType;
    }

    @JsonProperty("url")
    public String getUrl() {
        return url;
    }

    @JsonProperty("url")
    public void setUrl(String url) {
        this.url = url;
    }

    @JsonProperty("faqStatus")
    public String getFaqStatus() {
        return faqStatus;
    }

    @JsonProperty("faqStatus")
    public void setFaqStatus(String faqStatus) {
        this.faqStatus = faqStatus;
    }

    @JsonProperty("modifiedDate")
    public String getModifiedDate() {
        return modifiedDate;
    }

    @JsonProperty("modifiedDate")
    public void setModifiedDate(String modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    @JsonProperty("modifyBy")
    public String getModifyBy() {
        return modifyBy;
    }

    @JsonProperty("modifyBy")
    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperty(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

}
