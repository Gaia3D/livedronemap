package gaia3d.api;

import java.util.UUID;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import gaia3d.domain.APIResult;
import gaia3d.security.AES128Cipher;
import lombok.extern.slf4j.Slf4j;

/**
 * Authentication Test
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class AuthenticationAPIControllerTest {
	
	@Ignore
	public void createTokenReturnTypeIsEntity() {
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost/authentication/token";
		ResponseEntity<APIResult> aPIResult = restTemplate.postForEntity(url, null, APIResult.class);
		log.info("status code = {}", aPIResult.getStatusCodeValue());
		log.info("body = {}", aPIResult.getBody());
	}
	
	@Ignore
	public void createTokenReturnTypeIsString() {
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost/authentication/token";
		String result = restTemplate.postForObject(url, null, String.class);
		log.info("result = {}", result);
	}
	
	@Ignore
	public void createTokenWithHeader() throws Exception {
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
		parameters.add("test", "1234");
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("live_drone_map", getCustomHeader());
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(parameters, headers);
		
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost/authentication/token";
		ResponseEntity<APIResult> aPIResult = restTemplate.postForEntity(url, request, APIResult.class);
		log.info("createTokenWithHeader status code = {}", aPIResult.getStatusCodeValue());
		log.info("createTokenWithHeader aPIResult body = {}", aPIResult.getBody());
	}
	
	/**
	 * 암호화 된 header 값을 생성
	 * @return
	 * @throws Exception
	 */
	private String getCustomHeader() throws Exception {
		StringBuffer buffer = new StringBuffer();
		buffer.append("user_id=")
				.append("test")
				.append("&")
				.append("api_key=")
				.append(UUID.randomUUID().toString())
				.append("&")
				.append("token=")
				.append("")
				.append("&")
				.append("role=")
				.append("ADMIN")
				.append("&")
				.append("algorithm=")
				.append("sha")
				.append("&")
				.append("type=")
				.append("jwt, mac")
				.append("&")
				.append("timestamp=")
				.append(System.nanoTime());
		
		return AES128Cipher.encode(buffer.toString());
	}
}
