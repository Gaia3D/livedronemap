package gaia3d.api;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

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
import gaia3d.domain.DroneProject;
import gaia3d.domain.SimulationStep;
import gaia3d.domain.SimulationLog;
import gaia3d.domain.TransferDataResource;
import gaia3d.service.APILogService;
import gaia3d.service.ClientService;
import gaia3d.service.DroneProjectService;
import gaia3d.service.SimulationLogService;
import gaia3d.util.WebUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class SimulationAPIController implements APIController {
	
	@Autowired
	private APILogService aPILogService;
	@Autowired
	private ClientService clientService;
	@Autowired
	private DroneProjectService droneProjectService;
	@Autowired
	private SimulationLogService simulationLogService;
	
	@Value("classpath:simulation/drone-project.json")
    private Resource simulationDroneProject;
	@Value("classpath:simulation/simulation_sample_img.tif")
    private Resource simulationSampleFile;
	@Value("classpath:simulation/transfer-data.json")
    private Resource simulationSampleFileMeta;
	
	/**
	 * 프로세스 테스트 시뮬레이션
	 * @return
	 */
	@PostMapping("simulations/{client_id:[0-9]+}/{step:[a-z]+}")
	public ResponseEntity<APIResult> simulateProcess(HttpServletRequest request, @PathVariable("client_id") Integer clientId, @PathVariable("step") String step) {
		log.info("@@@@@ Start {} simulation.", step);
		SimulationLog simulationLog = new SimulationLog();
		APIResult aPIResult = new APIResult();
		HttpStatus httpStatus = null;
		String clientName = null;
		int simulationLogId = 0;
		
		try {
			SimulationStep simulationStep = SimulationStep.valueOf(step.toUpperCase());
			String levelCode = simulationStep.getCode();
			
			// get client
			// name, ip, port 정보 확인
			Client client = clientService.getClient(clientId);
			if (client == null) {
				log.info("@@@@@ Client not exist.");
				httpStatus = HttpStatus.NOT_FOUND;
				aPIResult.setStatusCode(httpStatus.value());
				return new ResponseEntity<APIResult>(aPIResult, httpStatus);
			}
			// TODO insert simulateion_log
			simulationLog = new SimulationLog();
			simulationLog.setSimulation_type(levelCode);
			simulationLog.setClient_id(client.getClient_id());
			simulationLog.setClient_name(client.getClient_name());
			simulationLogService.insertSimulationLog(simulationLog);
			simulationLogId = simulationLog.getSimulation_log_id();
			log.info("@@@@@ simnulation log id : {}", simulationLogId);
			
			// request 설정 
			if (simulationStep == SimulationStep.ALL) {
				// TODO 시립대 
			} else if(simulationStep == SimulationStep.CLIENT) {
				// TODO 시립대
				throw new Exception("not support method");
			} else if(simulationStep == SimulationStep.INNER) {
				// project 생성, 직접 insert 
				DroneProject droneProject = getSimulationDroneProject();
				droneProject.setDrone_project_name("Simulation Project " + simulationLogId);
				droneProjectService.insertDroneProject(droneProject);
				
				simulationLog.setDrone_project_id(droneProject.getDrone_project_id());
				simulationLogService.updateSimulationLogProjectId(simulationLog);
				// 파일 전송
				aPIResult = restTempateTransferData(droneProject.getDrone_project_id(), simulationLogId, request.getLocalPort());
			} else {
				throw new Exception("not support method");
			}
			
			httpStatus = HttpStatus.OK;
			aPIResult.setStatusCode(httpStatus.value());
		} catch (Exception e) {
			e.printStackTrace();
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			aPIResult.setStatusCode(httpStatus.value());
			aPIResult.setException(e.getMessage());
			
			// simulation update 
			simulationLog.setSimulation_log_id(simulationLogId);
			simulationLog.setStatus("1"); // TODO enum
			simulationLog.setMessage(e.getMessage());
			simulationLogService.updateSimulationLog(simulationLog);
		} finally {
			insertLog(aPILogService, WebUtil.getRequestIp(request), null, request.getRequestURL().toString(), clientId, clientName, aPIResult);
		}
		
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
	
	@PostMapping("simulations")
	public ResponseEntity<APIResult> updateSimulationLog(SimulationLog simulationLog) {
		// TODO 인증
		APIResult aPIResult = null;
		HttpStatus httpStatus = null;

		// TODO 시뮬레이션 업데이트 
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
	
	private DroneProject getSimulationDroneProject() throws Exception {
		String droneProjectStr = new String(Files.readAllBytes(Paths.get(simulationDroneProject.getURI())), StandardCharsets.UTF_8);
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.readValue(droneProjectStr, DroneProject.class);
	}
	
	private APIResult restTempateTransferData(int droneProjectId, int simulationId, int port) throws Exception {
		MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<>();
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
		
		bodyMap.add("file_meta", getFileMetaResource(droneProjectId));
		bodyMap.add("file", getFileResource());
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost:" + port + "/transfer-data/simulation/" + simulationId;
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(bodyMap, headers);
		return restTemplate.postForObject(url, requestEntity, APIResult.class);
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
