package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.APIHeader;
import gaia3d.domain.APIResult;
import gaia3d.domain.Policy;
import gaia3d.service.PolicyService;
import lombok.extern.slf4j.Slf4j;

/**
 * restconroller 사용시 responsebody는 생략
 * @author Cheon JeongDae
 *
 */
@Slf4j
@RequestMapping("/authentication/")
@RestController
public class AuthenticationAPIController implements APIController {

	@Autowired
	private PolicyService policyService;
	
	@PostMapping("token")
	public ResponseEntity<APIResult> createToken(HttpServletRequest request) {
		APIResult aPIResult = new APIResult();
		try {
			Policy policy = policyService.getPolicy();
			APIHeader apiHeader = getHeader(log, request);
			
			log.info(" ************************* apiHeader {}", apiHeader);
			
			
			// /auth/token
			/*
			 * paramenter api-key를 암호화 된 상태로 받으면 될거 같음
			 */
		} catch(Exception e) {
			e.printStackTrace();
			aPIResult.setException(e.getMessage());
		}
			
		return new ResponseEntity<APIResult>(aPIResult, HttpStatus.OK);
	}
	
	@PutMapping
	public String refreshToken() {
		return "";
	}
	
}
