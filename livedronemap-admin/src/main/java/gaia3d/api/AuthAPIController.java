package gaia3d.api;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * restconroller 사용시 responsebody는 생략
 * @author Cheon JeongDae
 *
 */
@RequestMapping("/auth")
@RestController
public class AuthAPIController {

	@PostMapping
	public String createToken() {
		// /auth/token
		/*
		 * paramenter api-key를 암호화 된 상태로 받으면 될거 같음
		 */
		
		return "";
	}
	
	@PutMapping
	public String refreshToken() {
		return "";
	}
	
}
