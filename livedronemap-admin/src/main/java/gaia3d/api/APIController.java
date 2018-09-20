package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.springframework.util.StringUtils;

import gaia3d.domain.APIHeader;
import gaia3d.security.AES128Cipher;

public interface APIController {

	/**
	 * @param request
	 * @return
	 */
	default APIHeader validateHeader(HttpServletRequest request) {
		return null;
	}
	
	/**
	 * header 를 취득
	 * @param request
	 * @return
	 */
	default APIHeader getHeader(Logger log, HttpServletRequest request) throws Exception {
		APIHeader apiHeader = null;
		
		String encodedCustomHeader = request.getHeader("live_drone_map");
		if(StringUtils.isEmpty(encodedCustomHeader)) {
			log.info("@@@@@@@@@@@@@@@@@@@ live_drone_map header is null or empty");
			return apiHeader;
		}
		
		apiHeader = new APIHeader();
		String customHeader = AES128Cipher.decode(encodedCustomHeader);
		log.info("@@@@@@@@@@@@@@@@@@@ customHeader = {}", customHeader);
		String[] headers = customHeader.split("&");
		
		apiHeader.setUserId(headers[0].substring(7));
		apiHeader.setApiKey(headers[1].substring(8));
		apiHeader.setToken(headers[2].substring(6));
		apiHeader.setRole(headers[3].substring(5));
		apiHeader.setAlgorithm(headers[4].substring(10));
		apiHeader.setType(headers[5].substring(5));
		
		return apiHeader;
	}
}
