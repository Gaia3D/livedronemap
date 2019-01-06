package gaia3d.api;

import org.slf4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;

import gaia3d.domain.APIHeader;
import gaia3d.domain.APILog;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIValidationType;
import gaia3d.domain.EncryptionStatus;
import gaia3d.exception.CustomSecurityException;
import gaia3d.security.AES128Cipher;
import gaia3d.service.APILogService;

public interface APIController {
	
	default void insertLog(APILogService aPILogService, String requestIp, String user_id, String url, Integer clientId, String clientName, APIResult aPIResult) {
		try {
			APILog aPILog = new APILog();
			aPILog.setClient_id(clientId);
			aPILog.setClient_name(clientName);
			aPILog.setRequest_ip(requestIp);
			aPILog.setUser_id(user_id);
			aPILog.setUrl(url);
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
		try {
			if(aPIHeader == null) {
				aPIResult.setStatusCode(HttpStatus.UNAUTHORIZED.value());
				aPIResult.setMessage("live drone map header is null or empty");
				return aPIResult;
			}
		} catch(CustomSecurityException e) {
			aPIResult.setStatusCode(HttpStatus.INTERNAL_SERVER_ERROR.value());
			aPIResult.setException(e.getMessage());
			aPIResult.setMessage("An error occurred during the encryption / decryption processing.");
			return aPIResult;
		}
		
		if(APIValidationType.AUTHETICATION.equals(validationType)) {
			if(StringUtils.isEmpty(aPIHeader.getApiKey())) {
				log.info("@@@@@@@@@@@@@@@@@@@ api key is null or empty");
				aPIResult.setStatusCode(HttpStatus.UNAUTHORIZED.value());
				aPIResult.setMessage("api key is null or empty");
				return aPIResult;
			}
		} else if(APIValidationType.TOKEN.equals(validationType)) {
			if(StringUtils.isEmpty(aPIHeader.getToken())) {
				log.info("@@@@@@@@@@@@@@@@@@@ token is null or empty");
				aPIResult.setStatusCode(HttpStatus.UNAUTHORIZED.value());
				aPIResult.setMessage("token is null or empty");
				return aPIResult;
			}
		}
		
		aPIResult.setStatusCode(HttpStatus.OK.value());
		return aPIResult;
	}
	
	/**
	 * header 복호화
	 * @param encryptionStatus
	 * @param log
	 * @param liveDroneMapHeader
	 * @return
	 */
	default APIHeader getHeader(String encryptionStatus, Logger log, String customHeader) {
		log.info("@@@@@@@@@@ encryptionStatus = {}", encryptionStatus);
		
		APIHeader apiHeader = null;
		if(StringUtils.isEmpty(customHeader)) {
			log.info("@@@@@@@@@@@@@@@@@@@ live_drone_map header is null or empty");
			return apiHeader;
		}
		
		String decodeHeader = customHeader;
		// TODO Enum 나중에 고치자... 귀찮음
		if(EncryptionStatus.Y.name().equals(encryptionStatus)) {
			try {
				decodeHeader = AES128Cipher.decode(customHeader);
			} catch(Exception e) {
				e.printStackTrace();
				throw new CustomSecurityException(e);
			}
		}
		log.info("@@@@@@@@@@@@@@@@@@@ customHeader = {}", decodeHeader);
		
		String[] headers = decodeHeader.split("&");
		
		apiHeader = new APIHeader();
		apiHeader.setUserId(headers[0].substring(8));
		apiHeader.setApiKey(headers[1].substring(8));
		apiHeader.setToken(headers[2].substring(6));
		apiHeader.setRole(headers[3].substring(5));
		apiHeader.setAlgorithm(headers[4].substring(10));
		apiHeader.setType(headers[5].substring(5));
		
		return apiHeader;
	}
}
