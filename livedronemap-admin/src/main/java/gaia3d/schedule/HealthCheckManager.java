package gaia3d.schedule;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.RestTemplateResponseErrorHandler;
import gaia3d.domain.CacheManager;
import gaia3d.domain.HealthCheck;
import gaia3d.domain.HealthCheckLog;
import gaia3d.service.DroneProjectService;
import gaia3d.service.HealthCheckLogService;
import gaia3d.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class HealthCheckManager {
	
	@Autowired
	private DroneProjectService droneProjectService;
	@Autowired
	private HealthCheckLogService healthCheckLogService;
	
	@Autowired
	private RestTemplateBuilder restTemplateBuilder;
	@Autowired
	private RestTemplateResponseErrorHandler restTemplateResponseErrorHandler;

	/**
	 * health check
	 * @throws Exception
	 */
	@Scheduled(fixedDelay = 3000 * 1000)
	public void healthCheck() throws Exception {
		log.info("@@@@@@@@@@@@@ HealthCheckManager healCheck execute.");
		HealthCheckLog healthCheckLog = new HealthCheckLog();
		String healthCheckStatus = null;
		String healthCheckMessage = null;
		HttpStatus httpStatus = null;
		
		Map<String, String> healthCheckMap = CacheManager.getHealthCheckMap();
		try {
			HttpHeaders headers = new HttpHeaders();
			HttpEntity<String> entity = new HttpEntity<String>(null, headers);
			String url = CacheManager.getPolicy().getRest_api_converter_url() + "/health-check";
			RestTemplate restTemplate = restTemplateBuilder.errorHandler(restTemplateResponseErrorHandler)
					.setConnectTimeout(5000)
					.setReadTimeout(5000)
					.build();
			ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			log.info("@@@ status = {}, message = {}", response.getStatusCodeValue(), response.getBody());
			httpStatus = response.getStatusCode();
			if (httpStatus == HttpStatus.OK) {
				healthCheckStatus = HealthCheck.ALIVE;
			} else {
				healthCheckStatus = HealthCheck.DOWN;
			}
			healthCheckMap.put(HealthCheck.CONVERTER_STATUS, healthCheckStatus);
			healthCheckMap.put(HealthCheck.LAST_CHECK_TIME, DateUtil.getToday());
			CacheManager.setHealthCheck(healthCheckMap);
			
		} catch(Exception e) {
			healthCheckStatus = HealthCheck.DOWN;
			healthCheckMessage = e.getMessage();
			
			healthCheckMap.put(HealthCheck.LAST_CHECK_TIME, DateUtil.getToday());
			healthCheckMap.put(HealthCheck.CONVERTER_STATUS, healthCheckStatus);
			CacheManager.setHealthCheck(healthCheckMap);
			
			log.info("@@@@@@@@@@@@@ exception message = {}", e.getMessage());
		} finally {
			healthCheckLog.setClient_id(0);
			healthCheckLog.setClient_name("Converter");
			healthCheckLog.setStatus(healthCheckStatus);
			healthCheckLog.setMessage(healthCheckMessage);
			if (httpStatus != null) {
				healthCheckLog.setStatus_code(httpStatus.value());
			}
			healthCheckLogService.insertHealthCheckLog(healthCheckLog);
		}
	}
	
	/**
	 * 프로젝트가 정상 종료 되지 않고 하루가 지난 경우 완료 처리 하는 배치
	 */
	@Scheduled(cron = "0 0 1 * * *")
	public void droneProjectStatusCheck() {
		log.info("@@@@@@@@@@@@@ HealthCheckManager droneProjectStatusCheck execute.");
		// droneProjectService
	}
}
