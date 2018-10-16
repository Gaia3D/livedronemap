package gaia3d.api;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

import gaia3d.domain.APIResult;
import gaia3d.domain.Client;
import gaia3d.domain.SimulationLevel;
import gaia3d.domain.SimulationLog;
import gaia3d.domain.TransferDataResource;
import gaia3d.service.APILogService;
import gaia3d.service.ClientService;
import gaia3d.service.SimulationLogService;
import gaia3d.util.WebUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class SimulationAPIController implements APIController {
	
	@Autowired
	private APILogService aPILogService;
	@Autowired
	ClientService clientService;
	@Autowired
	SimulationLogService simulationLogService;
	
	@Value("classpath:simulation/simulation_sample_img.tif")
    private Resource simulationSampleFile;
	@Value("classpath:simulation/transfer-data.json")
    private Resource simulationSampleFileMeta;
	
	/**
	 * 프로세스 테스트 시뮬레이션
	 * @return
	 */
	@PostMapping("simulations/{client_id:[0-9]+}/{level:[a-z]+}")
	public ResponseEntity<APIResult> simulateProcess(HttpServletRequest request, @PathVariable("client_id") Integer clientId, @PathVariable("level") String level) {
		log.info("@@@@@ Start simulation.");
		APIResult aPIResult = new APIResult();
		HttpStatus httpStatus = null;
		String clientName = null;
		
		try {
			SimulationLevel simulationLevel = SimulationLevel.valueOf(level.toUpperCase());
			String levelCode = simulationLevel.getCode();
			
			// get client info
			Client client = clientService.getClientByClientId(clientId);
			if (client == null) {
				log.info("@@@@@ Client not exist.");
				httpStatus = HttpStatus.NOT_FOUND;
				aPIResult.setStatusCode(httpStatus.value());
				return new ResponseEntity<APIResult>(aPIResult, httpStatus);
			}
			
			// TODO insert simulateion_log
			SimulationLog simulationLog = new SimulationLog();
			simulationLog.setSimulation_type(levelCode);
			simulationLog.setClient_id(client.getClient_id());
			simulationLog.setClient_name(client.getClient_name());
			simulationLogService.insertSimulationLog(simulationLog);
			int simulationId = simulationLog.getSimulation_log_id();
			log.info("@@@@@ simnulation id : {}", simulationId);
			
			// request 설정 
			if (simulationLevel == SimulationLevel.ALL) {
				// TODO 시립대 
			} else if(simulationLevel == SimulationLevel.CLIENT) {
				// TODO 시립대
			} else if(simulationLevel == SimulationLevel.INNER) {
				// project 생성
				aPIResult = createSimulationProject(simulationId);
				// 파일 전송
				aPIResult = restTempateTransferData(aPIResult.getDroneProjectId());
			} else {
				
			}
			
			httpStatus = HttpStatus.OK;
			aPIResult.setStatusCode(httpStatus.value());
		} catch (Exception e) {
			e.printStackTrace();
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			aPIResult.setStatusCode(httpStatus.value());
			aPIResult.setException(e.getMessage());
		} finally {
			insertLog(aPILogService, WebUtil.getRequestIp(request), null, request.getRequestURL().toString(), clientId, clientName, aPIResult);
		}
		
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
	
	@PostMapping("simulations/{simulation_id}")
	public ResponseEntity<APIResult> updateSimulationLog(@PathVariable("simulation_id") String simulationId) {
		APIResult aPIResult = null;
		HttpStatus httpStatus = null;
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
	
	private APIResult createSimulationProject(int simulationId) throws Exception {
		MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<>();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("live_drone_map", getCustomHeader());
		
		createDroneProject(bodyMap, simulationId);
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost:9999/drone-projects";
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(bodyMap, headers);
		return restTemplate.postForObject(url, requestEntity, APIResult.class);
	}
	
	private APIResult restTempateTransferData(int droneProjectId) throws Exception {
		MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<>();
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
		headers.add("live_drone_map", getCustomHeader());
		
		bodyMap.add("file_meta", getFileMetaResource(droneProjectId));
		bodyMap.add("file", getFileResource());
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost:9999/transfer-data";
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(bodyMap, headers);
		return restTemplate.postForObject(url, requestEntity, APIResult.class);
	}
	
	private String getCustomHeader() throws Exception {
		StringBuffer buffer = new StringBuffer();
		buffer.append("user_id=")
				.append("test")
				.append("&")
				.append("api_key=")
				.append(UUID.randomUUID().toString())
				.append("&")
				.append("token=")
				.append("22327341")
				.append("&")
				.append("role=")
				.append("ADMIN")
				.append("&")
				.append("algorithm=")
				.append("sha")
				.append("&")
				.append("type=")
				.append("jwt, mac")
				.append("&")
				.append("timestamp=")
				.append(System.nanoTime());
		
		return buffer.toString();
		//return AES128Cipher.encode(buffer.toString());
	}
	
	private MultiValueMap<String, Object> createDroneProject(MultiValueMap<String, Object> bodyMap, int SimulationId) {
		bodyMap.add("drone_id", 1);
		bodyMap.add("drone_project_name", "LDM Simulation " + SimulationId);
		bodyMap.add("drone_project_type", "1");
		bodyMap.add("shooting_area", "동해 앞바다");
		bodyMap.add("shooting_latitude1", 37.1);
		bodyMap.add("shooting_longitude1", 132.23);
		bodyMap.add("shooting_latitude2", 37.2);
		bodyMap.add("shooting_longitude2", 132.24);
		bodyMap.add("shooting_latitude3", 37.3);
		bodyMap.add("shooting_longitude3", 132.25);
		bodyMap.add("shooting_latitude4", 37.4);
		bodyMap.add("shooting_longitude4", 132.26);
		bodyMap.add("location", "POINT (128.382757714281 34.7651373676212)");
		bodyMap.add("shooting_date", "20180929203800");
		bodyMap.add("description", "Simulation test");
		return bodyMap;
	}
	
	private Resource getFileResource() throws Exception {
		String filePath = simulationSampleFile.getURI().getPath();
		return new FileSystemResource(filePath);
	}
	
	private TransferDataResource getFileMetaResource(int droneProjectId) throws IOException {
		String fileMetaStr = new String(Files.readAllBytes(Paths.get(simulationSampleFileMeta.getURI())), StandardCharsets.UTF_8);
		ObjectMapper objectMapper = new ObjectMapper();
		TransferDataResource transferDataResource = objectMapper.readValue(fileMetaStr, TransferDataResource.class);
		transferDataResource.setDrone_project_id(droneProjectId);
		return transferDataResource;
	}
}
