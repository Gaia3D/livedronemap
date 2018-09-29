package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.APIHeader;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIValidationType;
import gaia3d.domain.CacheManager;
import gaia3d.domain.Client;
import gaia3d.domain.Policy;
import gaia3d.domain.TokenLog;
import gaia3d.service.APILogService;
import gaia3d.service.ClientService;
import gaia3d.service.TokenLogService;
import gaia3d.util.WebUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * rest api authentication
 * TODO client_id 를 받어서 url 패턴을 /tokens/{client_id} 형태로 가져가야 하나 고민중...
 * 
 * @author Cheon JeongDae
 *
 */
@Slf4j
@RequestMapping("/authentication/")
@RestController
public class AuthenticationAPIController implements APIController {

	@Autowired
	private APILogService aPILogService;
	@Autowired
	private ClientService clientService;
	@Autowired
	private TokenLogService tokenLogService;
	
	/**
	 * token create request
	 * @param request
	 * @return
	 */
	@PostMapping("tokens")
	public ResponseEntity<APIResult> createToken(HttpServletRequest request, @RequestHeader("live_drone_map") String customHeader) {
		log.info("@@@@@@@@@@ createToken api call");
		
		APIResult aPIResult = null;
		HttpStatus httpStatus = null;
		Policy policy = CacheManager.getPolicy();
		Client client = null;
		Integer clientId = null;
		String clientName = null;
		try {
			APIHeader aPIHeader = getHeader(policy.getRest_api_encryption_yn(), log, customHeader);
			aPIResult = validate(log, APIValidationType.AUTHETICATION, aPIHeader);
			if(aPIResult.getStatusCode() != HttpStatus.OK.value()) {
				log.info("@@ Unregistered client");
				return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
			}
			
			// api key 조회
			client = clientService.getClientByAPIKey(aPIHeader.getApiKey());
			if(client == null || client.getClient_id() == null) {
				aPIResult.setStatusCode(HttpStatus.FORBIDDEN.value());
				aPIResult.setMessage("Unregistered client");
				log.info("@@ Unregistered client");
				return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
			}
			clientId = client.getClient_id();
			clientName = client.getClient_name();
			
			// token 발행
			TokenLog tokenLog = new TokenLog();
			tokenLog.setRest_api_token_max_age(policy.getRest_api_token_max_age());
			tokenLog.setClient_id(client.getClient_id());
			tokenLogService.getToken(tokenLog);
			
			aPIResult.setToken(tokenLog.getToken());
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
	
	/**
	 * new token request
	 * @param request
	 * @return
	 */
	@PutMapping("refreshToken")
	public ResponseEntity<APIResult> refreshToken(HttpServletRequest request, @RequestHeader("live_drone_map") String customHeader) {
		log.info("@@@@@@@@@@ refreshToken api call");
		
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
			
			// token expires 갱신
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
			
			// token expires 갱신
			tokenLog.setRest_api_token_max_age(policy.getRest_api_token_max_age());
			tokenLogService.updateTokenExpires(tokenLog);

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
