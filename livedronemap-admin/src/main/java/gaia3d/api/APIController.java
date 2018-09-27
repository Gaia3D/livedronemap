package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;

import gaia3d.domain.APIHeader;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIValidationType;
import gaia3d.domain.Client;
import gaia3d.domain.EncryptionStatus;
import gaia3d.exception.CustomSecurityException;
import gaia3d.security.AES128Cipher;

public interface APIController {
	
	void insertLog(HttpServletRequest request, String userId, Client client, APIResult aPIResult);

	/**
	 * 검증
	 * @param validationType
	 * @param aPIHeader
	 * @return
	 */
	default APIResult validate(APIValidationType validationType, APIHeader aPIHeader) {
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
				aPIResult.setStatusCode(HttpStatus.UNAUTHORIZED.value());
				aPIResult.setMessage("api key is null or empty");
				return aPIResult;
			}
		} else if(APIValidationType.TOKEN.equals(validationType)) {
			if(StringUtils.isEmpty(aPIHeader.getToken())) {
				aPIResult.setStatusCode(HttpStatus.UNAUTHORIZED.value());
				aPIResult.setMessage("token is null or empty");
				return aPIResult;
			}
		}
		
		aPIResult.setStatusCode(HttpStatus.OK.value());
		return aPIResult;
	}
	
	/**
	 * header 를 취득
	 * @param request
	 * @return
	 */
	default APIHeader getHeader(String encryptionStatus, Logger log, HttpServletRequest request) {
		APIHeader apiHeader = null;
		
		String encodedCustomHeader = request.getHeader("live_drone_map");
		if(StringUtils.isEmpty(encodedCustomHeader)) {
			log.info("@@@@@@@@@@@@@@@@@@@ live_drone_map header is null or empty");
			return apiHeader;
		}
		
		String customHeader = null;
		// TODO Enum 나중에 고치자... 귀찮음
		if(EncryptionStatus.Y.name().equals(encryptionStatus)) {
			try {
				customHeader = AES128Cipher.decode(encodedCustomHeader);
			} catch(Exception e) {
				e.printStackTrace();
				throw new CustomSecurityException(e);
			}
		} else {
			customHeader = encryptionStatus;
		}
		log.info("@@@@@@@@@@@@@@@@@@@ customHeader = {}", customHeader);
		
		String[] headers = customHeader.split("&");
		
		apiHeader = new APIHeader();
		apiHeader.setUserId(headers[0].substring(7));
		apiHeader.setApiKey(headers[1].substring(8));
		apiHeader.setToken(headers[2].substring(6));
		apiHeader.setRole(headers[3].substring(5));
		apiHeader.setAlgorithm(headers[4].substring(10));
		apiHeader.setType(headers[5].substring(5));
		
		return apiHeader;
	}
}
