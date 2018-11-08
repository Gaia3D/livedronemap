package gaia3d.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.APIServerConfig;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIURL;
import gaia3d.domain.SimulationLog;
import gaia3d.service.ProjectService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectServiceServiceImpl implements ProjectService {
	
	@Autowired
	APIServerConfig aPIServerConfig;
	
	public SimulationLog getSimulationLog(Integer droneProjectId) {
		String url = aPIServerConfig.getRootUrl() + APIURL.SIMULATION.getUrl() + "/" + droneProjectId;
		log.info("url = {}", url);
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<SimulationLog> result = restTemplate.getForEntity(url, SimulationLog.class);
		log.debug("@@@@@@@@@@@ result = {}", result);
		return result.getBody();
	}
	
	public ResponseEntity<APIResult> updateSimulationLog(Integer simulationLogId, String status, String message) {
		String url = aPIServerConfig.getRootUrl() + APIURL.SIMULATION.getUrl() + "/" + simulationLogId;
		log.info("url = {}", url);
		Map<String, Object> reqData = new HashMap<>();
		reqData.put("simulation_log_id", simulationLogId);
		reqData.put("status", status);
		reqData.put("message", message);
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.postForEntity(url, reqData, APIResult.class);
	}
	
	public ResponseEntity<APIResult> updateDroneProject(Integer droneProjectId, String status) {
		String url = aPIServerConfig.getRootUrl() + APIURL.PROJECT.getUrl() + "/" + droneProjectId;
		log.info("url = {}", url);
		Map<String, Object> reqData = new HashMap<>();
		reqData.put("drone_project_id", droneProjectId);
		reqData.put("status", status);
		RestTemplate restTemplate = new RestTemplate();
		return restTemplate.postForEntity(url, reqData, APIResult.class);
	}

	

}
