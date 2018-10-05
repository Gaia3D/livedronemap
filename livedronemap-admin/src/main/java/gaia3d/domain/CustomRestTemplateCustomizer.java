package gaia3d.domain;

import org.springframework.boot.web.client.RestTemplateCustomizer;
import org.springframework.web.client.RestTemplate;

import gaia3d.interceptor.CustomClientHttpRequestInterceptor;

/**
 * customize rest template with an interceptor
 */
public class CustomRestTemplateCustomizer implements RestTemplateCustomizer {
    @Override
    public void customize(RestTemplate restTemplate) {
        restTemplate.getInterceptors().add(new CustomClientHttpRequestInterceptor());
    }
}