package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.APIHeader;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIValidationType;
import gaia3d.domain.CacheManager;
import gaia3d.domain.DroneProject;
import gaia3d.domain.Policy;
import gaia3d.domain.TokenLog;
import gaia3d.service.APILogService;
import gaia3d.service.DroneProjectService;
import gaia3d.service.TokenLogService;
import gaia3d.util.WebUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class DroneProjectAPIController implements APIController {
	
	@Autowired
	private APILogService aPILogService;
	@Autowired
	private TokenLogService tokenLogService;
	@Autowired
	private DroneProjectService droneProjectService;

	@PostMapping("/drone-projects")
	public ResponseEntity<APIResult> insertProject(HttpServletRequest request, @RequestHeader("live_drone_map") String customHeader, DroneProject droneProject) {
		log.info("@@@@@@@@@@ project insert api call");
		
		APIResult aPIResult = new APIResult();
		HttpStatus httpStatus = null;
		Policy policy = CacheManager.getPolicy();
		TokenLog tokenLog = new TokenLog();
		Integer clientId = null;
		String clientName = null;
		try {
			APIHeader aPIHeader = getHeader(policy.getRest_api_encryption_yn(), log, customHeader);
			aPIResult = validate(log, APIValidationType.TOKEN, aPIHeader);
			if(aPIResult.getStatusCode() != HttpStatus.OK.value()) return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
			
			tokenLog.setToken(aPIHeader.getToken());
			//tokenLog.setRest_api_token_max_age(policy.getRest_api_token_max_age());
			tokenLog = tokenLogService.getValidToken(tokenLog);
			if(tokenLog == null) {
				aPIResult.setStatusCode(HttpStatus.OK.value());
				aPIResult.setValidationCode("token.expires.invalid");
				aPIResult.setMessage("Your token validity period has expired.");
				return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
			}
			clientId = tokenLog.getClient_id();
			clientName = tokenLog.getClient_name();
			
			droneProjectService.insertDroneProject(droneProject);
			aPIResult.setDroneProjectId(droneProject.getDrone_project_id());

			httpStatus = HttpStatus.OK;
			aPIResult.setStatusCode(httpStatus.value());
		} catch(Exception e) {
			e.printStackTrace();
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			aPIResult.setStatusCode(httpStatus.value());
			aPIResult.setException(e.getMessage());
		} finally {
			insertLog(aPILogService, WebUtil.getRequestIp(request), null, request.getRequestURL().toString(), clientId, clientName, aPIResult);
		}
		
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
	
	@PostMapping("/drone-projects/{droneProjectId:[0-9]+}")
	public ResponseEntity<APIResult> updateDroneProject(HttpServletRequest request,
			@PathVariable("droneProjectId") Integer droneProjectId, @RequestBody DroneProject droneProject) {
		log.info("@@@@@@@@@@ project update api call");
		log.info("************ droneProject : {}", droneProject);
		APIResult aPIResult = new APIResult();
		HttpStatus httpStatus = null;
		Policy policy = CacheManager.getPolicy();
		TokenLog tokenLog = new TokenLog();
		Integer clientId = null;
		String clientName = null;
		
		try {
			
//			APIHeader aPIHeader = getHeader(policy.getRest_api_encryption_yn(), log, customHeader);
//			aPIResult = validate(log, APIValidationType.TOKEN, aPIHeader);
//			if(aPIResult.getStatusCode() != HttpStatus.OK.value()) return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
//			
//			tokenLog.setToken(aPIHeader.getToken());
//			//tokenLog.setRest_api_token_max_age(policy.getRest_api_token_max_age());
//			tokenLog = tokenLogService.getValidToken(tokenLog);
//			if(tokenLog == null) {
//				aPIResult.setStatusCode(HttpStatus.OK.value());
//				aPIResult.setValidationCode("token.expires.invalid");
//				aPIResult.setMessage("Your token validity period has expired.");
//				return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
//			}
//			clientId = tokenLog.getClient_id();
//			clientName = tokenLog.getClient_name();
			
			droneProject.setDrone_project_id(droneProjectId);
			droneProject.setOrtho_image_count(0);
			droneProject.setPostprocessing_image_count(0);
			droneProject.setDetected_object_item1_count(0);
			droneProject.setDetected_object_item2_count(0);
			droneProject.setDetected_object_item3_count(0);
			droneProject.setDetected_object_item4_count(0);
			droneProjectService.updateDroneProject(droneProject);

			httpStatus = HttpStatus.OK;
			aPIResult.setStatusCode(httpStatus.value());
		} catch(Exception e) {
			e.printStackTrace();
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			aPIResult.setStatusCode(httpStatus.value());
			aPIResult.setException(e.getMessage());
		} finally {
			insertLog(aPILogService, WebUtil.getRequestIp(request), null, request.getRequestURL().toString(), clientId, clientName, aPIResult);
		}
		
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
}
