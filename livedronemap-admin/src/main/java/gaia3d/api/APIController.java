package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import gaia3d.domain.APIHeader;

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
	default APIHeader getHeader(HttpServletRequest request) {
		
		String liveDroneHeader = request.getHeader("live_drone_header");
		
		String userId = request.getHeader("user_id");
		String apiKey = request.getHeader("api_key");
		String role = request.getHeader("role");
		String algorithm = request.getHeader("algorithm");
		String type = request.getHeader("type");
		
		return null;
	}
}
