package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.springframework.http.HttpStatus;

import gaia3d.domain.APIHeader;
import gaia3d.domain.APILog;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIValidationType;
import gaia3d.service.APILogService;
import gaia3d.util.WebUtil;

/**
 * 내부 api 용
 * @author Cheon JeongDae
 *
 */
public interface PrivateAPIController {
	
	default void insertLog(APILogService aPILogService, HttpServletRequest request, String user_id, Integer clientId, String clientName, APIResult aPIResult) {
		try {
			APILog aPILog = new APILog();
			aPILog.setClient_id(clientId);
			aPILog.setClient_name(clientName);
			aPILog.setRequest_ip(WebUtil.getRequestIp(request));
			aPILog.setUser_id(user_id);
			aPILog.setUrl(request.getRequestURL().toString());
			aPILog.setStatus_code(aPIResult.getStatusCode());
			aPILog.setMessage(aPIResult.getMessage());
			aPILogService.insertAPILog(aPILog);
		} catch(Exception ex) {
			ex.printStackTrace();
			//log.error("@@@@@@@@ API 이력 저장 중 오류가 발생했지만... 무시");
		}
	}

	/**
	 * 검증
	 * @param validationType
	 * @param aPIHeader
	 * @return
	 */
	default APIResult validate(Logger log, APIValidationType validationType, APIHeader aPIHeader) {
		APIResult aPIResult = new APIResult();
		aPIResult.setStatusCode(HttpStatus.OK.value());
		return aPIResult;
	}
	
	/**
	 * header 를 취득
	 * @param request
	 * @return
	 */
	default APIHeader getHeader(String encryptionStatus, Logger log, HttpServletRequest request) {
		return new APIHeader();
	}
}
