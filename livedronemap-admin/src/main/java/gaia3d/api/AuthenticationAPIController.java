package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.APIResult;
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

	@PostMapping("token")
	public ResponseEntity<APIResult> createToken(HttpServletRequest request) {
		log.info("---- token create ----------------------------------------------------- ");
		log.info("=============================== {}", request.getHeader("live_drone_header"));
		getHeader(request);
		
		APIResult aPIResult = new APIResult();
		
		// /auth/token
		/*
		 * paramenter api-key를 암호화 된 상태로 받으면 될거 같음
		 */
		
		return new ResponseEntity<APIResult>(aPIResult, HttpStatus.OK);
	}
	
	@PutMapping
	public String refreshToken() {
		return "";
	}
	
}
