
package com.travel.object.faq;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.travel.object.faq.Response;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "baseResponse",
    "response"
})
@Generated("jsonschema2pojo")
public class FaqDetail {

    @JsonProperty("baseResponse")
    private BaseResponse baseResponse;
    @JsonProperty("response")
    private List<Response> response;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();

    @JsonProperty("baseResponse")
    public BaseResponse getBaseResponse() {
        return baseResponse;
    }

    @JsonProperty("baseResponse")
    public void setBaseResponse(BaseResponse baseResponse) {
        this.baseResponse = baseResponse;
    }

    @JsonProperty("response")
    public List<Response> getResponse() {
        return response;
    }

    @JsonProperty("response")
    public void setResponse(List<Response> response) {
        this.response = response;
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
