package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.domain.APIResult;
import gaia3d.domain.OrthoImage;
import gaia3d.domain.TokenLog;
import gaia3d.service.APILogService;
import gaia3d.service.OrthoImageService;
import gaia3d.util.WebUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 개별 정사 영상 처리
 * @author Cheon JeongDae
 *
 */
@Slf4j
@Controller
public class OrthoImageAPIController implements APIController {

	@Autowired
	private APILogService aPILogService;
	@Autowired
	private OrthoImageService orthoImageService;
	
	/**
	 * 
	 * @param request
	 * @return
	 */
	@PostMapping("/ortho-images/{ortho_image_id}")
	public ResponseEntity<APIResult> updateOrthoImage(HttpServletRequest request, @PathVariable Long ortho_image_id, @RequestParam(value="status", required = true) String status) {
		log.info("@@@@@@@@@@ updateOrthoImage api call");
		
		APIResult aPIResult = new APIResult();
		HttpStatus httpStatus = null;
		TokenLog tokenLog = new TokenLog();
		Integer clientId = null;
		String clientName = null;
		try {
			// private api call
//			APIHeader aPIHeader = getHeader(policy.getRest_api_encryption_yn(), log, customHeader);
//			aPIResult = validate(log, APIValidationType.TOKEN, aPIHeader);
//			if(aPIResult.getStatusCode() != HttpStatus.OK.value()) return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
//			
//			tokenLog.setToken(aPIHeader.getToken());
//			tokenLog = tokenLogService.getValidToken(tokenLog);
//			if(tokenLog == null) {
//				aPIResult.setStatusCode(HttpStatus.OK.value());
//				aPIResult.setValidationCode("token.expires.invalid");
//				aPIResult.setMessage("Your token validity period has expired.");
//				return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
//			}
			clientId = tokenLog.getClient_id();
			clientName = tokenLog.getClient_name();
			
			//UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			//fileInfo.setUser_id(userSession.getUser_id());
			
			OrthoImage orthoImage = new OrthoImage();
			orthoImage.setOrtho_image_id(ortho_image_id);
			orthoImage.setStatus(status);
			
			orthoImageService.updateOrthoImage(orthoImage);
			
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
