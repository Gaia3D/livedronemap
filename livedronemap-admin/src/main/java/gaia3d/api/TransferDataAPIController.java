package gaia3d.api;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import gaia3d.domain.UserSession;

import gaia3d.config.PropertiesConfig;

import gaia3d.domain.APIHeader;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIValidationType;
import gaia3d.domain.CacheManager;
import gaia3d.domain.FileInfo;
import gaia3d.domain.Policy;
import gaia3d.domain.TokenLog;
import gaia3d.domain.TransferDataResource;
import gaia3d.service.APILogService;
import gaia3d.service.TokenLogService;
import gaia3d.util.FileUtil;
import gaia3d.util.WebUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class TransferDataAPIController implements APIController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
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
	public ResponseEntity<APIResult> insertTransferData(MultipartHttpServletRequest request, 
														@RequestParam("file") MultipartFile multipartFile, 
														@RequestHeader("live_drone_map") String customHeader,
														TransferDataResource transferDataResource) {
		log.info("@@@@@@@@@@ transfer data insert api call");
		
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
			
			log.info("transferDataResource = {}", transferDataResource);
			log.info("@@@@@ filename = {}", multipartFile.getName());
			
			String uploadRootDir = propertiesConfig.getOrthoImageDir();
			if(TransferDataResource.POSTPROCESSING_IMAGE.equals(transferDataResource.getData_type())) {
				uploadRootDir = propertiesConfig.getPostprocessingImageDir();
			}
			
			//UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			FileInfo fileInfo = FileUtil.userUpload(null, FileUtil.SUBDIRECTORY_YEAR_MONTH, multipartFile, CacheManager.getPolicy(), uploadRootDir);
			if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
				log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getError_code());
				aPIResult.setStatusCode(HttpStatus.OK.value());
				aPIResult.setValidationCode(fileInfo.getError_code());
				aPIResult.setMessage("file validation error.");
				return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
			}
				
			//fileInfo.setUser_id(userSession.getUser_id());
			//fileInfo = fileService.insertDataAttributeFile(data_id, fileInfo);
			
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
