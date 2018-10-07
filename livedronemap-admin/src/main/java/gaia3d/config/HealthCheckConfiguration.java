package gaia3d.config;

import java.util.Map;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.web.client.RestTemplate;

import gaia3d.domain.CacheManager;
import gaia3d.domain.HealthCheck;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableScheduling
public class HealthCheckConfiguration implements SchedulingConfigurer {

	@Autowired
	private RestTemplateBuilder restTemplateBuilder;
	@Autowired
	private RestTemplateResponseErrorHandler restTemplateResponseErrorHandler;
	
	@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
		log.info("@@@@@@@@@@@@@ HealthCheckConfiguration configureTasks execute.");
		taskRegistrar.setScheduler(scheduler());
		taskRegistrar.addFixedDelayTask(() -> {
			try {
				Map<String, String> healthCheckMap = CacheManager.getHealthCheckMap();
				
				HttpHeaders headers = new HttpHeaders();
				HttpEntity<String> entity = new HttpEntity<String>(null, headers);
				String url = CacheManager.getPolicy().getRest_api_converter_url() + "/health-check";
				RestTemplate restTemplate = restTemplateBuilder.errorHandler(restTemplateResponseErrorHandler)
						.setConnectTimeout(5000)
						.setReadTimeout(5000)
						.build();
				ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
				log.info("@@@ status = {}, message = {}", response.getStatusCodeValue(), response.getBody());
				if (response.getStatusCode() != HttpStatus.OK) {
					healthCheckMap.put(HealthCheck.CONVERTER_STATUS, HealthCheck.ALIVE);
				} else {
					healthCheckMap.put(HealthCheck.CONVERTER_STATUS, HealthCheck.DOWN);
				}
				CacheManager.setHealthCheck(healthCheckMap);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}, 60000);
	}
	
	@Bean
	public Executor scheduler() {
		return Executors.newScheduledThreadPool(1);
	}
}
