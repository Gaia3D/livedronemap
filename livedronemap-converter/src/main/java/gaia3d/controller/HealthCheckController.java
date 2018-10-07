package gaia3d.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.APIResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class HealthCheckController {

	/**
	 * token create request
	 * @param request
	 * @return
	 */
	@GetMapping("/health-check")
	public ResponseEntity<APIResult> healthCheck(HttpServletRequest request) {
		log.info("@@@@@@@@@@ createToken api call");
		
		APIResult aPIResult = new APIResult();
		HttpStatus httpStatus = null;
		Integer clientId = null;
		String clientName = null;
		try {
			// TODO 지금은 생략
			
			// validation
			// 로그
			
			httpStatus = HttpStatus.OK;
			aPIResult.setStatusCode(httpStatus.value());
		} catch(Exception e) {
			e.printStackTrace();
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			aPIResult.setStatusCode(httpStatus.value());
			aPIResult.setException(e.getMessage());
		} finally {
			//insertLog(aPILogService, WebUtil.getRequestIp(request), null, request.getRequestURL().toString(), clientId, clientName, aPIResult);
		}
		
		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
	}
}
