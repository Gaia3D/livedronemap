package gaia3d.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.APIHeader;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIValidationType;
import gaia3d.domain.CacheManager;
import gaia3d.domain.FileInfo;
import gaia3d.domain.Policy;
import gaia3d.domain.SimulationLog;
import gaia3d.domain.TokenLog;
import gaia3d.domain.TransferDataResource;
import gaia3d.service.APILogService;
import gaia3d.service.SimulationLogService;
import gaia3d.service.TokenLogService;
import gaia3d.service.TransferDataService;
import gaia3d.util.FileUtil;
import gaia3d.util.WebUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * TODO 시뮬레이션 코드 통합 해야 함. 모든 처리는 동일하고 simulation_id의 존재 유무, update 처리만 차이날 뿐이다.
 * @author Cheon JeongDae
 *
 */
@Slf4j
@RestController
public class TransferDataAPIController implements APIController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private APILogService aPILogService;
	@Autowired
	private SimulationLogService simulationLogService;
	@Autowired
	private TokenLogService tokenLogService;
	@Autowired
	private TransferDataService transferDataService;

	/**
	 * 
	 * @param request
	 * @return
	 */
	@PostMapping("/transfer-data")
	public ResponseEntity<APIResult> insertTransferData(MultipartHttpServletRequest request, 
														@RequestParam("file") MultipartFile multipartFile, 
														@RequestHeader("live_drone_map") String customHeader) {
		log.info("@@@@@@@@@@ transfer data insert api call");
		
		APIResult aPIResult = new APIResult();
		HttpStatus httpStatus = null;
		Policy policy = CacheManager.getPolicy();
		TokenLog tokenLog = new TokenLog();
		Integer clientId = null;
		String clientName = null;
		FileInfo fileInfo = null;
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
			
			String fileMeta = request.getParameter("file_meta");
			ObjectMapper objectMapper = new ObjectMapper();
			TransferDataResource transferDataResource = objectMapper.readValue(fileMeta, TransferDataResource.class);
			log.info("@@@@@ transferDataResource = {}", transferDataResource);
			
			String uploadRootDir = propertiesConfig.getOrthoImageDir();
			if(TransferDataResource.POSTPROCESSING_IMAGE.equals(transferDataResource.getData_type())) {
				uploadRootDir = propertiesConfig.getPostprocessingImageDir();
			}
			fileInfo = FileUtil.upload(FileUtil.SUBDIRECTORY_YEAR_MONTH, multipartFile, CacheManager.getPolicy(), uploadRootDir);
			log.info("@@@@@ filename = {}", multipartFile.getOriginalFilename());
			if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
				log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getError_code());
				aPIResult.setStatusCode(HttpStatus.OK.value());
				aPIResult.setValidationCode(fileInfo.getError_code());
				aPIResult.setMessage("file validation error.");
				return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
			}
			
			//UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			//fileInfo.setUser_id(userSession.getUser_id());
			
			transferDataService.insertTransferData(fileInfo, transferDataResource);
			
			httpStatus = HttpStatus.OK;
			aPIResult.setStatusCode(httpStatus.value());
		} catch(Exception e) {
			if(fileInfo != null) FileUtil.deleteFile(fileInfo.getFile_path() + fileInfo.getFile_real_name());
			e.printStackTrace();
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			aPIResult.setStatusCode(httpStatus.value());
			aPIResult.setException(e.getMessage());
		} finally {
			insertLog(aPILogService, WebUtil.getRequestIp(request), null, request.getRequestURL().toString(), clientId, clientName, aPIResult);
		}
		
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
	
	/**
	 * TODO 위에 것과 통합 후 삭제해야 함.
	 * @param request
	 * @param multipartFile
	 * @param simulationLogId
	 * @return
	 */
	@PostMapping("/transfer-data/simulation/{simulation_log_id}")
	public ResponseEntity<APIResult> insertSimulationTransferData(MultipartHttpServletRequest request, 
																	@RequestParam("file") MultipartFile multipartFile,
																	@PathVariable("simulation_log_id") Integer simulationLogId) {
		log.info("@@@@@@@@@@ simulation transfer data insert api call");
		
		APIResult aPIResult = new APIResult();
		HttpStatus httpStatus = null;
		Integer clientId = null;
		String clientName = null;
		FileInfo fileInfo = null;
		try {
			
			// TODO file size check
			// TODO file extension check 
			String fileMeta = request.getParameter("file_meta");
			ObjectMapper objectMapper = new ObjectMapper();
			TransferDataResource transferDataResource = objectMapper.readValue(fileMeta, TransferDataResource.class);
			log.info("@@@@@ simulation transferDataResource = {}", transferDataResource);
			
			String uploadRootDir = propertiesConfig.getOrthoImageDir();
			if(TransferDataResource.POSTPROCESSING_IMAGE.equals(transferDataResource.getData_type())) {
				uploadRootDir = propertiesConfig.getPostprocessingImageDir();
			}
			
			fileInfo = FileUtil.upload(FileUtil.SUBDIRECTORY_YEAR_MONTH, multipartFile, CacheManager.getPolicy(), uploadRootDir);
			log.info("@@@@@ simulation filename = {}", multipartFile.getOriginalFilename());
			if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
				log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getError_code());
				aPIResult.setStatusCode(HttpStatus.OK.value());
				aPIResult.setValidationCode(fileInfo.getError_code());
				aPIResult.setMessage("file validation error.");
				return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
			}
			
			//UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			//fileInfo.setUser_id(userSession.getUser_id());
			
			transferDataService.insertTransferData(fileInfo, transferDataResource);
			
			httpStatus = HttpStatus.OK;
			aPIResult.setStatusCode(httpStatus.value());
		} catch(Exception e) {
			if(fileInfo != null) FileUtil.deleteFile(fileInfo.getFile_path() + fileInfo.getFile_real_name());
			e.printStackTrace();
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			aPIResult.setStatusCode(httpStatus.value());
			aPIResult.setException(e.getMessage());
			
			// simulation update 
			SimulationLog simulationLog = new SimulationLog();
			simulationLog.setSimulation_log_id(simulationLogId);
			simulationLog.setStatus("1"); // TODO enum
			simulationLog.setMessage(e.getMessage());
			simulationLogService.updateSimulationLog(simulationLog);
		} finally {
			insertLog(aPILogService, WebUtil.getRequestIp(request), null, request.getRequestURL().toString(), clientId, clientName, aPIResult);
		}
		
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
}
