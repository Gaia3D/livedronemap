package gaia3d.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import gaia3d.domain.APIHeader;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIValidationType;
import gaia3d.domain.CacheManager;
import gaia3d.domain.Policy;
import gaia3d.domain.TokenLog;
import gaia3d.service.APILogService;
import gaia3d.service.TokenLogService;
import gaia3d.util.WebUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class TransferDataAPIController implements APIController {
	
	@Autowired
	private APILogService aPILogService;
	@Autowired
	private TokenLogService tokenLogService;
	

	/**
	 * 
	 * @param request
	 * @return
	 */
	// @PostMapping(value = "/transfer-data", headers = ("content-type=multipart/*")
	@PostMapping("/transfer-data")
	public ResponseEntity<APIResult> insertTransferData(MultipartHttpServletRequest request, @RequestHeader("live_drone_map") String customHeader) {
		log.info("@@@@@@@@@@ project insert api call");
		
		APIResult aPIResult = null;
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
				aPIResult.setMessage("token The validity period has expired.");
				return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
			}
			clientId = tokenLog.getClient_id();
			clientName = tokenLog.getClient_name();
			
			
			
//			Map<String, MultipartFile> fileMap = request.getFileMap();
//	        for (MultipartFile multipartFile : fileMap.values()) {
//	        	FileInfo fileInfo = FileUtil.userUpload(userId, FileUtil.SUBDIRECTORY_YEAR_MONTH_DAY, multipartFile, CacheManager.getPolicy(), propertiesConfig.getUserUploadDir());
//				if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
//					log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getError_code());
//					result = fileInfo.getError_code();
//					break;
//				}
//				
//				fileInfo.setUser_id(userId);
//				fileList.add(fileInfo);
//	        }
			
			
			
			
//			droneProjectService.insertDroneProject(droneProject);
//			aPIResult.setDroneProjectId(droneProject.getDrone_project_id());

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
