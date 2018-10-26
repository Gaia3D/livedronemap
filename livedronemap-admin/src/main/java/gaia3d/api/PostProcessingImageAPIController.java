package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.APIResult;
import gaia3d.domain.PostProcessingImage;
import gaia3d.domain.TokenLog;
import gaia3d.service.APILogService;
import gaia3d.service.PostProcessingImageService;
import gaia3d.service.TokenLogService;
import gaia3d.util.WebUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 후처리 영상 처리
 * @author Cheon JeongDae
 *
 */
@Slf4j
@Controller
public class PostProcessingImageAPIController implements APIController {

	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private APILogService aPILogService;
	@Autowired
	private TokenLogService tokenLogService;
	@Autowired
	private PostProcessingImageService postProcessingImageService;
	
	/**
	 * 
	 * @param request
	 * @return
	 */
	@PostMapping("/postprocessing-images/{postprocessing_image_id}")
	public ResponseEntity<APIResult> updatePostProcessingImage(	HttpServletRequest request, 
																@PathVariable Long postprocessing_image_id, 
																@RequestParam(value="status", required = true) String status) {
		log.info("@@@@@@@@@@ updatePostProcessingImage api call");
		
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
			
			PostProcessingImage postProcessingImage = new PostProcessingImage();
			postProcessingImage.setPostprocessing_image_id(postprocessing_image_id);
			postProcessingImage.setStatus(status);
			
			postProcessingImageService.updatePostProcessingImage(postProcessingImage);
			
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
